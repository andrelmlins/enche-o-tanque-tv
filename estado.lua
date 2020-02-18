json = require "json";

openmodalcidade = false
openmodalposto = false
optioncurrent = "";
chavegeral = "";
postosgeral = {};
cidadesgeral = {};

function handler(evt)
	if evt.class=="ncl" then
		if evt.action=="start" then
			if(settings.myVar==nil) then detalhes(persistent.service.estado:lower())
			else detalhes(settings.myVar) end
		end
	end
end

function detalhes(option)
	optioncurrent = option;
	
	canvas:attrColor(230,81,0,255)
	canvas:drawRect("fill",0,0,canvas:attrSize());
	
	imagem = canvas:new("imagens/estados/"..option..".png");
	imagem:attrScale(150,100);
	canvas:compose(10,10,imagem);

	result = arquivo("arquivos/"..option..".json")
	estado = result.estado
	estado.posicao = result.posicao
	canvas:attrColor(255,255,255,255)
	canvas:attrFont("Arial",40,"bold")
	canvas:drawText(200, 12,estado.estado.." - "..estado.estadoabrev)
	canvas:attrFont("Arial",20,"bold")
	canvas:drawText(200, 57,"Posição: ("..estado.latitude..") - ("..estado.longitude..")")
	canvas:drawText(200, 82,"Quantidade de Postos: "..estado.quantidade)

	titulo("Precos",360,125,30);

	i=0;
	for k, preco in ipairs(estado.precos)  do
		caixatexto = canvas:new(100,50);
		caixatexto:attrColor(22,29,67,255);
		caixatexto:drawRoundRect("fill",0,0,100,50,15,15);

		caixatexto:attrColor(255,255,255,255);
		caixatexto:attrFont("Tiresias",20,"bold");
		caixatexto:drawText(9, 5,"R$ "..preco.precomedio);

		caixatexto:attrFont("Arial",10);
		caixatexto:drawText(30, 30,preco.combustivel);

		canvas:compose((i*130)+100,175,caixatexto);
		i=i+1;
	end

	titulo("Posicao no Ranking",280,245,30);

	if estado.posicao.gasolina == 1 then medalhagasolina = canvas:new("imagens/gold_medal.png")
	elseif estado.posicao.gasolina == 2 then medalhagasolina = canvas:new("imagens/silver_medal.png") 
	elseif estado.posicao.gasolina == 3 then medalhagasolina = canvas:new("imagens/bronze_medal.png") 
	else medalhagasolina = canvas:new("imagens/bad_medal.png") 
	end

	if estado.posicao.etanol == 1 then medalhaetanol = canvas:new("imagens/gold_medal.png")
	elseif estado.posicao.etanol == 2 then medalhaetanol = canvas:new("imagens/silver_medal.png") 
	elseif estado.posicao.etanol == 3 then medalhaetanol = canvas:new("imagens/bronze_medal.png") 
	else medalhaetanol = canvas:new("imagens/bad_medal.png") 
	end

	if estado.posicao.diesel == 1 then medalhadiesel = canvas:new("imagens/gold_medal.png")
	elseif estado.posicao.diesel == 2 then medalhadiesel = canvas:new("imagens/silver_medal.png") 
	elseif estado.posicao.diesel == 3 then medalhadiesel = canvas:new("imagens/bronze_medal.png") 
	else medalhadiesel = canvas:new("imagens/bad_medal.png") 
	end

	if estado.posicao.diesels10 == 1 then medalhadiesels10 = canvas:new("imagens/gold_medal.png")
	elseif estado.posicao.diesels10 == 2 then medalhadiesels10 = canvas:new("imagens/silver_medal.png") 
	elseif estado.posicao.diesels10 == 3 then medalhadiesels10 = canvas:new("imagens/bronze_medal.png") 
	else medalhadiesels10 = canvas:new("imagens/bad_medal.png") 
	end

	if estado.posicao.gnv == 1 then medalhagnv = canvas:new("imagens/gold_medal.png")
	elseif estado.posicao.gnv == 2 then medalhagnv = canvas:new("imagens/silver_medal.png") 
	elseif estado.posicao.gnv == 3 then medalhagnv = canvas:new("imagens/bronze_medal.png") 
	else medalhagnv = canvas:new("imagens/bad_medal.png") 
	end

	medalhagasolina:attrScale(75,100);
	medalhadiesel:attrScale(75,100);
	medalhadiesels10:attrScale(75,100);
	medalhaetanol:attrScale(75,100);
	medalhagnv:attrScale(75,100);

	canvas:compose(200,295,medalhagasolina);
	canvas:compose(285,295,medalhaetanol);
	canvas:compose(370,295,medalhadiesel);
	canvas:compose(455,295,medalhadiesels10);
	canvas:compose(540,295,medalhagnv);

	canvas:attrFont("Arial",20,"bold");
	canvas:drawText(225, 320,estado.posicao.gasolina);

	canvas:attrFont("Arial",20,"bold");
	canvas:drawText(310, 320,estado.posicao.etanol);

	canvas:attrFont("Arial",20,"bold");
	canvas:drawText(395, 320,estado.posicao.diesel);

	canvas:attrFont("Arial",20,"bold");
	canvas:drawText(480, 320,estado.posicao.diesels10);

	canvas:attrFont("Arial",20,"bold");
	canvas:drawText(565, 320,estado.posicao.gnv);

	caixainferior = canvas:new(canvas:attrSize()-20,280);
	caixainferior:attrColor(22,29,67,255);
	caixainferior:drawRect("fill",0,0,caixainferior:attrSize(),280);

	caixaposto = caixainferior:new((caixainferior:attrSize()/2)-15,260);
	caixaposto:attrColor(255,255,255,255);
	caixaposto:drawRoundRect("fill",0,0,caixaposto:attrSize(),260,15,15);

	caixacidade = caixainferior:new((caixainferior:attrSize()/2)-15,260);
	caixacidade:attrColor(255,255,255,255);
	caixacidade:drawRoundRect("fill",0,0,caixacidade:attrSize(),260,15,15);

	bola = caixainferior:new(21,21);
	bola:attrColor(13,71,161,255);
	bola:drawRoundRect("fill",0,0,20,20,20,20);
	caixaposto:compose(10,10, bola);

	bola:attrColor(27,94,32,255);
	bola:drawRoundRect("fill",0,0,20,20,20,20);
	caixacidade:compose(10,10, bola);

	postos = arquivo("arquivos/postos/"..option..".json").postos
	caixaposto:attrColor(0,0,0,255);
	caixaposto:attrFont("Arial",20,"bold");
	caixaposto:drawText(140, 10,"Postos: "..length(postos));
	i=0
	for k, posto in ipairs(postos)  do
		postounico = caixaposto:new(caixaposto:attrSize()-10,38);
		postounico:attrColor(13,71,161,255);
		postounico:drawRect("fill",0,0,caixaposto:attrSize()-10,38);
		
		bandeira = split(" ",posto.bandeira)
		if (length(bandeira)<=1) then posto.bandeira=posto.bandeira:lower()
		else posto.bandeira=bandeira[0]:lower().."-"
		end
		
		imagem = postounico:new("imagens/bandeiras/"..posto.bandeira..".png")
		imagem:attrScale(32,32);
		postounico:compose(3,3,imagem);

		postounico:attrColor(255,255,255,255);
		postounico:attrFont("Arial",15,"bold");
		postounico:drawText(45, 3, posto.razao);
		postounico:attrFont("Arial",10,"bold");
		postounico:drawText(45, 20, "Preco da Gasolina:R$"..posto.preco);

		x = 22;
		y = 17;
		postounico:attrFont("Arial",15,"bold")
		postounico:attrColor(13,71,161,255)
		postounico:drawRoundRect("fill",x-4,y+2,15,15,2,2)
		postounico:attrColor(255,255,255,255)
		postounico:drawText(x,y,i)

		caixaposto:compose(5,(43*i)+45,postounico);
		i=i+1;
		if i==5 then break end
	end
	postosgeral = postos

	cidades = arquivo("arquivos/cidades/"..option..".json").cidades
	cidadesgeral = cidades
	caixacidade:attrColor(0,0,0,255);
	caixacidade:attrFont("Arial",20,"bold");
	caixacidade:drawText(140, 10,"Cidades: "..length(cidades));
	i=0
	for k, cidade in ipairs(cidades)  do
		cidadeunico = caixaposto:new(caixaposto:attrSize()-10,38);
		cidadeunico:attrColor(27,94,32,255);
		cidadeunico:drawRect("fill",0,0,caixaposto:attrSize()-10,38);

		imagem = cidadeunico:new("imagens/estados/"..option..".png");
		imagem:attrScale(45,32);
		cidadeunico:compose(3,3,imagem);

		cidadeunico:attrColor(255,255,255,255);
		cidadeunico:attrFont("Arial",15,"bold");
		cidadeunico:drawText(58, 3, cidade.cidade.." - "..cidade.estadoabrev);
		cidadeunico:attrFont("Arial",10,"bold");
		cidadeunico:drawText(58, 20, "Preco da Gasolina:R$"..cidade.precomedio);

		x = 35;
		y = 17;
		cidadeunico:attrFont("Arial",15,"bold")
		cidadeunico:attrColor(27,94,32,255)
		cidadeunico:drawRoundRect("fill",x-4,y+2,15,15,2,2)
		cidadeunico:attrColor(255,255,255,255)
		cidadeunico:drawText(x,y,i)

		caixacidade:compose(5,(43*i)+45,cidadeunico);
		i=i+1;
		if i==5 then break end
	end

	caixainferior:compose(10,10,caixaposto);
	caixainferior:compose(caixacidade:attrSize()+20,10,caixacidade);
	canvas:compose(0,420,caixainferior);

	canvas:flush();
end

function titulo(texto,x,y,font)
	canvas:attrFont("Arial",font,"bold")
	canvas:attrColor(63,81,181,255)
	width,height = canvas:attrSize()
	width1,height1 = canvas:measureText(texto)
	canvas:drawRoundRect("fill",20,y,width-40,height1,10,10)
	canvas:attrColor(255,255,255,255)
	canvas:drawText(x, y,texto)
end

function numero(texto,x,y,font)
	
end

function modal(evt)
	if (evt.key=="BLUE" and evt.type=="release") then
		if openmodalposto==false then
			openmodal("",13,71,161,"posto")
		else
			detalhes(optioncurrent);
			openmodalposto = false;
			openmodalcidade = false;
		end
	elseif (evt.key=="GREEN" and evt.type=="release") then
		if openmodalcidade==false then
			openmodal("",27,94,32,"cidade")
		else
			detalhes(optioncurrent);
			openmodalposto = false;
			openmodalcidade = false;
		end
	elseif (evt.key=="YELLOW" and evt.type=="release") then
		if openmodalcidade==true then
			persistent.service.cidade = cidadesgeral[tonumber(chavegeral)+1].cidade;
			persistent.service.estado = cidadesgeral[tonumber(chavegeral)+1].estadoabrev;
			local evt =  {
                class  = 'ncl',
                type   = 'attribution',
                name  = 'cidade',
                value = 1
            }
            evt.action = 'start'; event.post(evt)
  			evt.action = 'stop' ; event.post(evt)
		elseif openmodalposto==true then
			persistent.service.hash = postosgeral[tonumber(chavegeral)+1].hash;
			local evt =  {
                class  = 'ncl',
                type   = 'attribution',
                name  = 'posto',
                value = 2,
            }
            evt.action = 'start'; event.post(evt)
  			evt.action = 'stop' ; event.post(evt)
		end
	elseif(evt.key~="BLUE" and evt.ley~="ESC" and evt.key~="RED" and evt.key~="YELLOW" and evt.key~="ENTER" and evt.key~="S" and evt.type=="release") then
		if(openmodalposto) then
			openmodal(evt.key,13,71,161,"posto")
		else
			openmodal(evt.key,27,94,32,"cidade")
		end
	end
end

function arquivo(arq)
  archive = "";
  for line in io.lines(arq) do
    archive = archive..line
  end
  return json.decode(archive)
end

function length(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function split(separator, string)
	array = {}
	f=0;
	for index in string.gmatch(string, '([^"'..separator..'"]+)') do
		array[f] = index
		f = f + 1
	end
	return array;
end

function save(object)
	file = io.open("persistent.et", "a")
	io.output(file)
	io.write("daskmlsaçdsakldsa")
	io.close(file)
end

function openmodal(text,r,g,b,tipo)
	modal = canvas:new(150,100)
	modal:attrColor(r,g,b,255);
	modal:drawRect("fill",0,0,modal:attrSize());

	modal:attrColor(255,255,255,255);
	modal:drawRect("fill",10,10,modal:attrSize()-20,80);
	
	if(text~="") then
		modal:attrColor(0,0,0,255);
		modal:attrFont("Arial",50,"bold");
		modal:drawText((modal:attrSize()/2)-10, 22, text);
		chavegeral = text;
	else
		modal:attrColor(0,0,0,255);
		modal:drawRect("fill",modal:attrSize()/2,20,1,60);
	end
	
	canvas:compose(340,300,modal);
	canvas:flush();
	if(tipo=="posto") then openmodalposto = true; openmodalcidade = false;
	else openmodalcidade = true; openmodalposto = false;
	end
end

event.register(handler);
event.register(modal,"key");