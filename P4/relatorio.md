# Projeto 4 – Classificação de lesões de substância branca no Lúpus

# Apresentação

O presente projeto foi originado no contexto das atividades da disciplina de pós-graduação [*Ciência e Visualização de Dados em Saúde*](https://ds4h.org), oferecida no primeiro semestre de 2022, na Unicamp.

 |Nome  | RA | Especialização|
 |--|--|--|
 | Edoarda  | 204057  | Computação |

# Introdução
 O objetivo deste trabalho foi, usando um classificador treinado para classificar lesões cerebrais como isquêmicas ou desmielinizantes, usá-lo para classificar imagens de lesões de substância branca no cérebro ocorridas em decorrência de Lúpus, com o intuito de checar se essas lesões tem características mais parecidas com lesões isquêmicas ou desmienalizantes (ou nenhuma das duas).

## Ferramentas
* Google Colab
* Python 3.7
* PyTorch
* NumPy
* Glob

## Preparo e uso dos dados

As seguintes estratégias com relação ao preparo e ao uso de dados foram implantadas:
* Normalização (Com média e desvio padrão de 0.5 para ambos)
* Espelhamentos da imagem de forma aleatória, de forma a aumentar artificialmente a quantidade de dados e simular lesões em outros pontos do cérebro.
* Giros aleatórios da imagem em angulos de cinco graus, para aumentar artificialmente a quantidade de dados e simular sutis mudanças na posição da cabeça do paciente ao entrar na máquina.
* Não houve uso de máscaras, portanto os arquivos de máscara foram previamente excluidos do diretório de uso.
* Tambem não houveram extração ou seleção de atributos.

# Metodologia
 Foi escolhido um classificador semelhante ao apresentado pela professora na aula prática de *Deep Learning*, **ResNet18**. Cuja única diferença é que foi ativada a opção de Pré-Treinamento oferecida pelo pacote e com 25 *epochs* de rodadas pelo *dataset* em vez das 10 originais.
 Essa solução foi escolhida por já ter uma chance de acerto que eu consideraria boa, e as pequenas mudanças nos parametros foram motivadas a tentar melhorar um pouco a acurácia original. (<sup><sub>E eu já estou atrasado demais no quesito tempo para ficar inventando moda</sub></sup>).
* Os dados foram separados da seguinte forma:
  * 70% dos dados para o conjunto de treinamento (*train*)
  * 20% dos dados para o conjunto de teste (*test*)
  * 10% dos dados para o conjunto de validação (*val*)

* Sem validação cruzada
* As escolhas dos parâmetros do classificador foram escolhidas iguais a do classificador mostrado na sala de aula por terem gerado um modelo com uma acurácia aceitavel
* As métricas de validação selecionadas foram a porcentagem de acertos e a matriz de confusão.
> * resultados do treinamento do classificador usando tabelas e gráficos

# Resultados Obtidos e Discussão
> Esta seção deve apresentar o resultado de predição das lesões de LES usando o classificador treinado. Também deve tentar explicar quais os atributos relevantes usados na classificação obtida
> * apresente os resultados de forma quantitativa e qualitativa
> * tenha em mente que quem irá ler o relatório é uma equipe multidisciplinar. Descreva questões técnicas, mas também a intuição por trás delas.
> Não houveram resultados obtidos (até agora) por conta de uma comédia seguida de erros, eu ter sobreescrito o modelo treinado com 25 epochs e subsequentemente o colab e o meu computador só resolverem parar de colaborar, o que gerou bastante ansiedade. 

# Conclusão
> Destacar as principais conclusões obtidas no desenvolvimento do projeto.

 Um dos principais desafios apresentados, apesar de não ser uma coisa particular do projeto, foi o modo que o Google Colab (a plataforma na qual este trabalho foi rodado) trata com permissões de arquivo. Em particular, conseguir deletar os arquivos de máscara do dataset para poder carregá-lo sem eles foi uma experiência peculiar, que eu preferia não ter tido e não ter perdido tempo que eu não tinha tentando arrumar as pastas de forma adequada.
> > (depois de muitas horas eu finalmente descobri que os comandos Unix na plataforma não passam expressões regulares nem sob tortura)
> > Ele também copiava a pasta das imagens de Lúpus como um atalho (apesar disso não ter acontecido com *todas as outras pastas do curso que foram disponibilizadas*). Para conseguir modificar a pasta eu literalmente tive que baixar tudo para o pc, deletar manualmente as máscaras, e dar upload nesses arquivos para conseguir dar continuidade ao trabalho.
>
 **Principais lições aprendidas:**  Além do dito acima, provavelmente valeria bastante a pena ter feito o trabalho em uma máquina com uma GPU dedicada, tanto para aumentar a velocidade do treinamento, tanto para tentar executar uma rede mais "parruda" com o objetivo de tentar alcançar maiores resultados.
>
**Trabalhos Futuros:**
> * O que poderia ser melhorado se houvesse mais tempo?
>   > * Testar e comparar alguns modelos de rede diferentes;
>   > * Utilizar Máscaras e comparar com a versão apresentada;
>   > * Utilizar alguns filtros de detecção de borda e/ou de nitidez de imagem e comparar com a versão apresentada.

# Referências Bibliográficas
 * Basics of Image Classification with Pytorch ([Link](https://heartbeat.comet.ml/basics-of-image-classification-with-pytorch-2f8973c51864))
