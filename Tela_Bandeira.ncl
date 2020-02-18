<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- Generated by NCL Eclipse -->
<ncl id="Tela_Bandeira" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<head>
		<importedDocumentBase>
			<importNCL alias="pos" documentURI="Tela_Posto.ncl"/>
			<importNCL alias="est" documentURI="Tela_Estado.ncl"/>
		</importedDocumentBase>
		<regionBase>
			<region id="background" top="0" left="0" width="100%" zIndex="1">
				<region id="regionlaterald" top="0%" left="35%" width="65%" zIndex="1"/>
			</region>
		</regionBase>
		<descriptorBase>	
			<descriptor id="descregionlaterald" focusIndex="300" focusBorderTransparency="0" region="regionlaterald"/>		
		</descriptorBase>
		<connectorBase>
		 	<causalConnector id="voltar">
				<connectorParam name="var"/>
				<simpleCondition role="onSelection" key="$var"/>
				<simpleAction role="stop"  max="unbounded" qualifier="par"/>
		   	</causalConnector>
		   	<causalConnector id="renovar">
				<connectorParam name="var"/>
				<simpleCondition role="onEnd" max="5"/>
				<compoundAction operator="seq">
					<simpleAction role="start" max="unbounded" qualifier="par"/>
					<simpleAction role="stop" max="unbounded" qualifier="par"/>
				</compoundAction>
		   	</causalConnector>
		   	<causalConnector id="detalhe">
				<simpleCondition role="onEndAttribution"/>
				<compoundAction operator="seq">
					<simpleAction role="start" max="unbounded" qualifier="par"/>
					<simpleAction role="stop" max="unbounded" qualifier="par"/>
				</compoundAction>
		   	</causalConnector>
		</connectorBase>
	</head>
	<body>
		<context id="bandeira">
			<port id="port1" component="bandeiralua"/>
			<media type="application/x-ginga-settings" id="settings">
				<property name="service.currentKeyMaster" value="300"/>
				<property name="channel.keyCapture" value="true"/>
			</media>
			<media id="bandeiralua" src="bandeira.lua" descriptor="descregionlaterald" type="application/x-ginga-NCLua">
				<property name="posto"/>
				<property name="estado"/>
			</media>	

			<link xconnector="voltar" >
				<bind role="onSelection" component="bandeiralua" > 
					<bindParam name="var" value="RED"/>
				</bind>	
				<bind role="stop"  component="bandeira"/>
			</link>

			<context id="posto" refer="pos#posto" />
			<context id="estado" refer="est#estado" />

			<link xconnector="detalhe">
				<bind role="onEndAttribution" component="bandeiralua" interface="posto"/> 
				<bind role="start"  component="posto"/>
				<bind role="stop"  component="bandeiralua"/>
			</link>

			<link xconnector="detalhe">
				<bind role="onEndAttribution" component="bandeiralua" interface="estado"/> 
				<bind role="start"  component="estado"/>
				<bind role="stop"  component="bandeiralua"/>
			</link>
			
			<link xconnector="renovar" >
				<bind role="onEnd" component="posto" />
				<bind role="onEnd" component="estado" />
				<bind role="start"  component="bandeiralua"/>
				<bind role="stop"  component="posto"/>
				<bind role="stop"  component="estado"/>
			</link>
			
		</context>	
	</body>
</ncl>