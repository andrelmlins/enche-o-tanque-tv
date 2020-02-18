<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="Tela_Sobre" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="background" top="0" left="0" width="100%" zIndex="1">
				<region id="regionlaterald" top="0%" left="35%" width="65%" zIndex="1">						
					<region id="regionsobretext" width="80%" right="0%" zIndex="4" top="5%"/>
				</region>
			</region>			
		</regionBase>
		<descriptorBase>
			<descriptor id="descsobretext" region="regionsobretext">
				<descriptorParam name="fontSize" value="20"/> 
				<descriptorParam name="textAlign" value="left"/> 
			</descriptor>		
		</descriptorBase>
		<connectorBase>
			<causalConnector id="aoIniciar">
				<connectorParam name="var"/>
			  	<simpleCondition role="onBegin"/>
				<simpleAction role="start" max="unbounded" qualifier="par"/>
		   </causalConnector>
		   <causalConnector id="naSelecaoDeTeclaSetarPararIniciar">
				<connectorParam name="tecla"/>
				<connectorParam name="var"/>
				<simpleCondition role="onSelection" key="$tecla"/>
				<compoundAction operator="seq">
					<simpleAction role="stop"  max="unbounded" qualifier="par"/>
					<simpleAction role="start" max="unbounded" qualifier="par"/>
				</compoundAction>
		   </causalConnector>
		   <causalConnector id="voltar">
				<connectorParam name="var"/>
				<simpleCondition role="onSelection" key="$var"/>
				<simpleAction role="stop"  max="unbounded" qualifier="par"/>
		   </causalConnector>
		   <causalConnector id="terminar">
				<connectorParam name="var"/>
				<simpleCondition role="onEnd"/>
				<compoundAction operator="seq">
					<simpleAction role="stop"  max="unbounded" qualifier="par"/>
					<simpleAction role="start" max="unbounded" qualifier="par"/>
				</compoundAction>
		   </causalConnector>
		   <causalConnector id="descer">
				<connectorParam name="tecla"/>
				<connectorParam name="var"/>
				<simpleCondition role="onSeletion" key="$tecla"/>
				<compoundAction operator="seq">
					<simpleAction role="start" max="unbounded" qualifier="par"/>
					<simpleAction role="stop" max="unbounded" qualifier="par"/>
				</compoundAction>
		   </causalConnector>
		</connectorBase>
	</head>
	<body>
		<context id="sobretext">
			<port id="port01" component="media01"/>
			<media id="media01" descriptor="descsobretext" src="telas/sobre.txt"/>
			
			<!--**************Clicar em RED**************-->
			<link xconnector="voltar" >
				<bind role="onSelection" component="media01" > 
					<bindParam name="var" value="RED"/>
				</bind>	
				<bind role="stop"  component="sobretext"/>
			</link>
			<!--**************/Clicar em RED**************-->
		</context>
	</body>
</ncl>