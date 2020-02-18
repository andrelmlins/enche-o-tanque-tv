<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="Tela_Ranking" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<importBase alias="reg" documentURI="regioes.ncl" />		
		</regionBase>
		<descriptorBase>
			<importBase alias="dec" documentURI="descritores.ncl" />
		</descriptorBase>
		<connectorBase>
			<importBase alias="con" documentURI="conectores.ncl" />
		</connectorBase>
	</head>
	<body>
		<context id="ranking">
			<media id="media01" descriptor="dec#descmenuestado" src="telas/menu_principal_1.png" />
			<!--**************Clicar em RED**************-->
			<link xconnector="con#voltar" >
				<bind role="onSelection" component="media01" > 
					<bindParam name="var" value="RED"/>
				</bind>	
				<bind role="stop"  component="ranking"/>
			</link>
			<!--**************/Clicar em RED**************-->
		</context>
	</body>
</ncl>