## PASSO A PASSO

1 - git clone https://github.com/samueldiasx/install-sonar-docker.git

2 - cd install-sonar-docker

3 - rm -rf .git && rm -rf README.md

4 - cp . /pasta-destino

5 - remover sufixo .example do arquivo de configuração do sonar

6 - configurar o arquivo de configuração do sonar

7 - caso deseja mude a rede no arquivo docker compose (opcional)

8 - rodar comando docker-compose up -d --build

7 - inserir script  "test-sonar": "php artisan test --coverage-clover ./storage/coverage/clover-coverage.xml --log-junit ./storage/coverage/junit-report.xml  && sonar-scanner" no arquivo composer.json

8 - rodar o seguinte comando dentro do container: composer test-sonar

## tchau e obrigado