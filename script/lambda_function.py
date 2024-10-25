import json

print('Loading function')


def lambda_handler(event, context):
    cidade =  event['cidade']
    uf = event['uf']
    prompt = f"""
    Estou programando uma viagem para {cidade}-{uf} preciso de pontos turisticos para visitar.
    - Os pontos turisticos devem vir dentro de um Json.
    """
    result = {
        "status": "success",
        "prompt": prompt
    }
    return result