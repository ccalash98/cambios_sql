import json

# Lista de líneas de SQL
sql_lines = [
    'VALUES (1, \'AMAZONAS\');',
    'VALUES (2, \'AMAZOAS\');',
    'VALUES (3, \'AMAZONAS\');',
    # Agrega más líneas aquí si es necesario
]

# Función para convertir una línea de SQL a JSON
def sql_to_json(sql):
    # Extraer valores de la línea de SQL
    values_start = sql.find("(") + 1
    values_end = sql.rfind(")")
    values = sql[values_start:values_end].split(",")
    
    # Mapear los valores a un objeto JSON
    json_obj = {
        "prov_cod_prov": int(values[0].strip().strip("\'")),  # Convertir a entero
        "prov_des_prov": values[1].strip().strip("\'"),
        "pais_codigo_inter": "51",
        "country_id": 173,
        "prov_cod_pais": "28",
        "country_name": "Peru",
        "state_code": "PE",
    }
    return json_obj

# Lista para almacenar los objetos JSON convertidos
json_objects = []

# Convertir todas las líneas de SQL a JSON
for line in sql_lines:
    json_objects.append(sql_to_json(line))

# Nombre del archivo de salida
output_file = "depart.json"

try:
    # Escribir los objetos JSON en el archivo
    with open(output_file, "w") as json_file:
        json.dump(json_objects, json_file, indent=4)
    print(f"Los resultados han sido guardados en el archivo: {output_file}")
except Exception as e:
    print(f"Hubo un error al guardar el archivo: {e}")

print("Fin del script")