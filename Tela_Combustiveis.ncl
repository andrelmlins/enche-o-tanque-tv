<?xml version="1.0" encoding="ISO-8859-1"?>
	<ncl id="Tela_Combustiveis" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<importedDocumentBase>
			<importNCL alias="comb" documentURI="Tela_Combustivel.ncl"/>
		</importedDocumentBase>
		<regionBase>
			<region id="background" top="0" left="0" width="100%" zIndex="1">
				<region id="regionlaterald" top="0%" left="35%" width="65%" zIndex="1">						
					<region id="regioncombustiveis" width="100%" height="100%" zIndex="4" top="5%" left="0%">
						<region id="regionfotocombga" left="5%" top="5%" width="42.5%" height="20%" zIndex="5"/>
						<region id="regionfotocombet" left="52.5%" top="5%" width="42.5%" height="20%" zIndex="5"/>
						<region id="regionfotocombdi" left="5%" top="30%" width="42.5%" height="20%" zIndex="5"/>
						<region id="regionfotocombds" left="52.5%" top="30%" width="42.5%" height="20%" zIndex="5"/>
						<region id="regionfotocombgn" left="5%" top="55%" width="42.5%" height="20%" zIndex="5"/>
					</region>
				</region>
			</region>			
		</regionBase>
		<descriptorBase>
			<descriptor id="descfotocombga" region="regionfotocombga" focusIndex="0" moveUp="4" moveDown="2" moveRight="1" moveLeft="1"/>
			<descriptor id="descfotocombet" region="regionfotocombet" focusIndex="1" moveUp="3" moveDown="3" moveRight="0" moveLeft="0"/>
			<descriptor id="descfotocombdi" region="regionfotocombdi" focusIndex="2" moveUp="0" moveDown="4" moveRight="3" moveLeft="3"/>
			<descriptor id="descfotocombds" region="regionfotocombds" focusIndex="3" moveUp="1" moveDown="1" moveRight="2" moveLeft="2"/>
			<descriptor id="descfotocombgn" region="regionfotocombgn" focusIndex="4" moveUp="2" moveDown="0"/>		
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
				<simpleCondition role="onEnd" max="5"/>
				<compoundAction operator="seq">
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
		<port id="port" component="combustiveis" />
		<context id="combustiveis">
			<port id="port01" component="media01"/>
			<port id="port02" component="media02"/>
			<port id="port03" component="media03"/>
			<port id="port04" component="media04"/>
			<port id="port05" component="media05"/>
			<media id="media01" descriptor="descfotocombga" src="telas/gasolina.png"/>
			<media id="media02" descriptor="descfotocombet" src="telas/etanol.png"/>
			<media id="media03" descriptor="descfotocombdi" src="telas/diesel.png"/>
			<media id="media04" descriptor="descfotocombds" src="telas/diesels10.png"/>
			<media id="media05" descriptor="descfotocombgn" src="telas/gnv.png"/>
			
			<!--**************Paginas**************-->
			<context id="gasolina" refer="comb#gasolina"/>
			<context id="etanol" refer="comb#etanol"/>
			<context id="diesel" refer="comb#diesel"/>
			<context id="gnv" refer="comb#gnv"/>
			<!--**************Paginas**************-->
			
			<!--**************Clicar em RED**************-->
			<link xconnector="voltar" >
				<bind role="onSelection" component="media01" > 
					<bindParam name="var" value="RED"/>
				</bind>	
				<bind role="stop"  component="combustiveis"/>
			</link>
			<!--**************/Clicar em RED**************-->
			
			<!--**************Clicar em Gasolina**************-->
			<link xconnector="naSelecaoDeTeclaSetarPararIniciar" >
				<bind role="onSelection" component="media01" > 
					<bindParam name="var" value="ENTER"/>
				</bind>	
				<bind role="stop"  component="combustiveis"/>
				<bind role="start" component="gasolina"/>				
			</link>
			<!--**************/Clicar em Gasolina**************-->
			
			<!--**************Clicar em Etanol**************-->
			<link xconnector="naSelecaoDeTeclaSetarPararIniciar" >
				<bind role="onSelection" component="media02" > 
					<bindParam name="var" value="ENTER"/>
				</bind>	
				<bind role="stop"  component="combustiveis"/>
				<bind role="start" component="etanol"/>				
			</link>
			<!--**************/Clicar em Etanol**************-->
			
			<!--**************Clicar em Diesel**************-->
			<link xconnector="naSelecaoDeTeclaSetarPararIniciar" >
				<bind role="onSelection" component="media03" > 
					<bindParam name="var" value="ENTER"/>
				</bind>	
				<bind role="stop"  component="combustiveis"/>
				<bind role="start" component="diesel"/>				
			</link>
			<!--**************/Clicar em diesel**************-->
			
			<!--**************Clicar em GNV**************-->
			<link xconnector="naSelecaoDeTeclaSetarPararIniciar" >
				<bind role="onSelection" component="media05" > 
					<bindParam name="var" value="ENTER"/>
				</bind>	
				<bind role="stop"  component="combustiveis"/>
				<bind role="start" component="gnv"/>				
			</link>
			<!--**************/Clicar em GNV**************-->
			
			<!--**************Clicar em Sair Gasolina**************-->
			<link xconnector="terminar" >
				<bind role="onEnd" component="gasolina"/>
				<bind role="onEnd" component="etanol"/>
				<bind role="onEnd" component="gnv"/>
				<bind role="onEnd" component="diesel"/>
				<bind role="start"  component="combustiveis"/>		
			</link>
			<!--**************/Clicar em Sair Gasolina**************-->
		</context>
	</body>
</ncl>