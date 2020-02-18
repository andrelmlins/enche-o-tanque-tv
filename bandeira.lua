json = require "json";

openmodalestado = false
openmodalposto = false
optioncurrent = "";
chavegeral = "";
postosgeral = {};
estadosgeral = {};

function handler(evt)
	if evt.class=="ncl" then
		if evt.action=="start" then
			detalhes(settings.myVar)
		end
	end
end

function detalhes(option)
	optioncurrent = option;
	
	canvas:attrColor(230,81,0,255)
	canvas:drawRect("fill",0,0,canvas:attrSize());
	
	imagem = canvas:new("imagens/bandeiras/"..option..".png");
	imagem:attrScale(100,100);
	canvas:compose(10,10,imagem);

	bandeira = arquivo("arquivos/bandeiras/"..option..".json").bandeira

	canvas:attrColor(255,255,255,255)
	canvas:attrFont("Arial",35,"bold")
	canvas:drawText(140, 17,bandeira.bandeira)
	canvas:attrFont("Arial",20,"bold")
	canvas:drawText(140, 62,"Quantidade de Postos: "..bandeira.quantidade)

	titulo("Precos",360,125,30);

	i=0;
	for k, preco in ipairs(bandeira.precos)  do
		caixatexto = canvas:new(100,50);
		caixatexto:attrColor(22,29,67,255);
		caixatexto:drawRoundRect("fill",0,0,100,50,15,15);

		caixatexto:attrColor(255,255,255,255);
		caixatexto:attrFont("Tiresias",20,"bold");
		caixatexto:drawText(9, 5,"R$ "..preco.preco);

		caixatexto:attrFont("Arial",10);
		caixatexto:drawText(30, 30,preco.combustivel);

		canvas:compose((i*130)+100,175,caixatexto);
		i=i+1;
	end

	titulo("Estados onde atua",280,245,30);

	estados = arquivo("arquivos/estadosbandeiras/"..option..".json").estados
	estadosgeral = estados
	i=0;
	f=0;
	line = 295
	for k, estado in ipairs(estados)  do
		caixatexto = canvas:new(100,50);
		caixatexto:attrColor(255,255,255,255);
		caixatexto:drawRoundRect("fill",0,0,100,50,10,10);

		imagem = caixatexto:new("imagens/estados/"..estado.estadoabrev:lower()..".png");
		imagem:attrScale(90,40);
		caixatexto:compose(5,5,imagem);

		canvas:compose((i*130)+40,line,caixatexto);
		numero(f,(i*130)+40+81,line+26,20)
		i=i+1;
		f=f+1;
		if(i==6) then line=355;i=0 end
		if(f==12) then break end;
	end

	caixainferior = canvas:new(canvas:attrSize()-20,280);
	caixainferior:attrColor(22,29,67,255);
	caixainferior:drawRect("fill",0,0,caixainferior:attrSize(),280);

	caixaposto = caixainferior:new((caixainferior:attrSize())-15,260);
	caixaposto:attrColor(255,255,255,255);
	caixaposto:drawRoundRect("fill",0,0,caixaposto:attrSize(),260,15,15);

	bola = caixainferior:new(21,21);
	bola:attrColor(13,71,161,255);
	bola:drawRoundRect("fill",0,0,20,20,20,20);
	caixaposto:compose(10,10, bola);

	postos = arquivo("arquivos/postosbandeiras/"..option..".json").postos
	caixaposto:attrColor(0,0,0,255);
	caixaposto:attrFont("Arial",20,"bold");
	caixaposto:drawText(340, 10,"Postos: "..length(postos));
	i=0
	for k, posto in ipairs(postos)  do
		postounico = caixaposto:new(caixaposto:attrSize()-10,38);
		postounico:attrColor(13,71,161,255);
		postounico:drawRect("fill",0,0,caixaposto:attrSize()-10,38);
		
		imagem = postounico:new("imagens/bandeiras/"..option..".png")
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

	caixainferior:compose(10,10,caixaposto);
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
	canvas:attrFont("Arial",font,"bold")
	canvas:attrColor(27,94,32,255)
	width,height = canvas:measureText(texto)
	canvas:drawRoundRect("fill",x-4,y+2,20,20,2,2)
	canvas:attrColor(255,255,255,255)
	canvas:drawText(x, y,texto)
end

function modal(evt)
	if (evt.key=="BLUE" and evt.type=="release") then
		if openmodalposto==false then
			openmodal("",13,71,161,"posto")
		else
			detalhes(optioncurrent);
			openmodalposto = false;
			openmodalestado = false;
		end
	elseif (evt.key=="GREEN" and evt.type=="release") then
		if openmodalestado==false then
			openmodal("",27,94,32,"estado")
		else
			detalhes(optioncurrent);
			openmodalposto = false;
			openmodalestado = false;
		end
	elseif (evt.key=="YELLOW" and evt.type=="release") then
		if openmodalestado==true then
			persistent.service.estado = estadosgeral[tonumber(chavegeral)+1].estadoabrev;
			local evt =  {
                class  = 'ncl',
                type   = 'attribution',
                name  = 'estado',
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
			openmodal(evt.key,27,94,32,"estado")
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

function openmodal(text,r,g,b,tipo)
	print(tipo)
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
	if(tipo=="posto") then openmodalposto = true; openmodalestado = false;
	else openmodalestado = true; openmodalposto = false;
	end
end

event.register(handler);
event.register(modal,"key");