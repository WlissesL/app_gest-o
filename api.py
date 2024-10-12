from flask import Flask, request, jsonify
from flask_cors import CORS
import pymysql
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
CORS(app)

def get_db_connection():
    connection = pymysql.connect(
        host='localhost',
        user='root',
        passwd='',
        db='gestao_escolar'
    )
    return connection

@app.route('/login', methods=['POST'])
def login():
    dados = request.get_json()
    cpf = dados.get('cpf')
    senha = dados.get('senha')

    # Validação dos dados de entrada
    if not cpf or not senha:
        return jsonify({'mensagem': 'CPF e senha são obrigatórios'}), 400

    connection = get_db_connection()
    cursor = connection.cursor()

    sql = "SELECT senha FROM usuarios WHERE cpf = %s"

    try:
        cursor.execute(sql, (cpf,))
        resultado = cursor.fetchone()

        if resultado:
            senha_armazenada = resultado[0]
            # Verificar se a senha corresponde
            if check_password_hash(senha_armazenada, senha):
                return jsonify({'mensagem': 'Login bem-sucedido!'}), 200
            else:
                return jsonify({'mensagem': 'CPF ou senha incorretos.'}), 401
        else:
            return jsonify({'mensagem': 'Usuário não encontrado.'}), 404
    except pymysql.MySQLError as e:
        return jsonify({'mensagem': 'Erro ao realizar login', 'erro': str(e)}), 500  # Mudança para erro 500
    except Exception as e:
        return jsonify({'mensagem': 'Erro inesperado', 'erro': str(e)}), 500  # Captura de erros inesperados
    finally:
        cursor.close()
        connection.close()

@app.route('/cadastro', methods=['POST'])
def cadastrar_usuario():
    dados = request.get_json()
    nome = dados.get('nome')
    cpf = dados.get('cpf')
    data_nascimento = dados.get('data_nascimento')
    senha = dados.get('senha')

    # Validação dos campos de entrada
    if not nome or not cpf or not data_nascimento or not senha:
        return jsonify({'mensagem': 'Todos os campos são obrigatórios'}), 400

    senha_criptografada = generate_password_hash(senha)

    connection = get_db_connection()
    cursor = connection.cursor()

    sql = "INSERT INTO usuarios (nome_completo, cpf, data_nascimento, senha) VALUES (%s, %s, %s, %s)"

    try:
        cursor.execute(sql, (nome, cpf, data_nascimento, senha_criptografada))
        connection.commit()
        return jsonify({'mensagem': 'Usuário cadastrado com sucesso!'}), 201
    except pymysql.MySQLError as e:
        return jsonify({'mensagem': 'Erro ao cadastrar usuário', 'erro': str(e)}), 400
    except Exception as e:
        return jsonify({'mensagem': 'Erro inesperado', 'erro': str(e)}), 500  # Captura de erros inesperados
    finally:
        cursor.close()
        connection.close()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
