import xml.etree.ElementTree as ET
import psycopg2

# Could be done better using https://robot-framework.readthedocs.io/en/stable/autodoc/robot.result.html ?

def publishResultToPostgres(host, port, database, user, password, test_name, test_result, result):
    try:
        connection = psycopg2.connect(user=user,
                                    password=password,
                                    host=host,
                                    port=port,
                                    database=database)
        cursor = connection.cursor()

        postgres_insert_query = """ INSERT INTO testresults (test_name, test_result, pass) VALUES (%s,%s,%s)"""
        record_to_insert = (test_name, test_result, result)
        cursor.execute(postgres_insert_query, record_to_insert)

        connection.commit()

    except (Exception, psycopg2.Error) as error:
        print("Failed to insert record into testresults table", error)

    finally:
        # closing database connection.
        if connection:
            cursor.close()
            connection.close()
            print("PostgreSQL connection is closed")

if __name__ == "__main__":
    tree = ET.parse('output.xml')
    root = tree.getroot()

    for suite in root.findall('.//suite'):
        for test in [child for child in suite if child.tag == 'test']:
            print(test)
            test_name = test.attrib['name']
            test_pass = test.find('status').attrib['status'] == "PASS"
            try:
                for msg in test.findall(f'./kw/kw/msg'):
                    print(msg.text, "&{ReportResultSQL} = ")
                    if "${ReportResultSQL} = " in msg.text:
                        test_result = msg.text[21:]
                        publishResultToPostgres(
                            "clab-pce_demo2-postgres",
                            5432,
                            "postgres",
                            "postgres",
                            "grafana",
                            test_name,
                            test_result,
                            test_pass
                        )
            except IndexError as e:
                print(e)
                pass

