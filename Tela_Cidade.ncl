<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Generated by NCL Eclipse -->
<ncl id="Tela_Posto" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<regionBase>
			<region id="background" top="0" left="0" width="100%" zIndex="1">
				<region id="regionlaterald" top="0%" left="35%" width="65%" zIndex="1"/>
			</region>
		</regionBase>
		<descriptorBase>	
			<descriptor id="descregionlaterald" focusIndex="300" focusBorderTransparency="0" region="regionlaterald">
				<descriptorParam name="background" value="#e65100"/>
			</descriptor>
		</descriptorBase>
		<connectorBase>
		 	<causalConnector id="voltar">
				<connectorParam name="var"/>
				<simpleCondition role="onSelection" key="$var"/>
				<simpleAction role="stop"  max="unbounded" qualifier="par"/>
		   	</causalConnector>
		</connectorBase>
	</head>
	<body>
		<context id="cidade">
			<port id="port1" component="post"/>
			<media id="post" src="cidade.lua" descriptor="descregionlaterald"/>	
			
			<link xconnector="voltar" >
				<bind role="onSelection" component="post" > 
					<bindParam name="var" value="RED"/>
				</bind>	
				<bind role="stop"  component="cidade"/>
			</link>			
		</context>	
	</body>
</ncl>