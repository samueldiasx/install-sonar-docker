# Instalação do Sonar utilizando Docker

**OBS:** 
- **Certifique que o Docker e Docker Compose estejam corretamente instalados na sua máquina**
- **Certifique que a váriavel de ambiente APP_NAME no arquivo .env esteja com todas as letras minusculas**

### Passo a passo
1 - Clone Repositório 
```sh
git clone https://github.com/samueldiasx/install-sonar-docker.git
```
```sh
cd install-sonar-docker
```
```sh
rm -rf .git README.md
```

2 - Copiar para o **"projeto desejado"**
```sh
cp -r . /pasta-destino
```

3 - configurar o arquivo de configuração do sonar **sonar-project.properties**
```dosini
# Valores de exemplos abaixo
sonar.projectKey=key_project
sonar.projectName=name_project
sonar.projectVersion=1.0.0
sonar.host.url=http://sonarqube:9000
sonar.sources=app
sonar.language=php
sonar.sourceEncoding=UTF-8
sonar.login=admin
sonar.password=admin
sonar.php.coverage.reportPaths=storage/coverage/clover-coverage.xml
sonar.php.tests.reportPath=storage/coverage/junit-report.xml
sonar.exclusions=
```

4 - caso desejar, pode mudar a rede no arquivo **docker-compose.yml** (opcional)
```sh
...
networks:
    # nome da rede abaixo, neste exemplo se chama "projeto"
    # caso mude, não esquecer de mudar também nos serviços
    projeto:
        driver: bridge
```

5 - subir os containers
```sh
docker-compose up -d --build
```

6 - inserir script "test-sonar" no arquivo **composer.json**
```json
"scripts": {
        ..., 
        // não esqueça a virgula antes do ultimo objeto
        "test-sonar": "php artisan test --coverage-clover ./storage/coverage/clover-coverage.xml --log-junit ./storage/coverage/junit-report.xml  && sonar-scanner"
},
```

7 - Acessar o container
```sh
docker exec -it "valor do APP_NAME dentro do arquivo .env" sh
```

8 - Rodar teste no container
```sh
 composer install && composer test-sonar
```

9 - Adicionr no .gitignore
```sh
/.mysql
/.scannerwork
/?
/storage/coverage
```

### dê uma estrela para ajudar :) , obrigado
