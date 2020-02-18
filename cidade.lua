json = require "json";

function handler(evt)
	if evt.class=="ncl" then
		if evt.action=="start" then
			detalhes(persistent.service.cidade.."-"..persistent.service.estado)
		end
	end
end

function detalhes(option)
	result = arquivo("arquivos/cidade/"..option..".json");
	cidade = result.cidade
	cidade.posicao = result.posicao

	canvas:attrColor(230,81,0,255)
	canvas:drawRect("fill",0,0,canvas:attrSize())

	canvas:attrColor(255,255,255,255)
	canvas:attrFont("Arial",40,"bold")
	canvas:drawText(180, 12,cidade.cidade)
	canvas:attrFont("Arial",20,"bold")
	canvas:drawText(180, 57,"Posicao: ("..cidade.latitude..") - ("..cidade.longitude..")")
	canvas:drawText(180, 82,"Quantidade de Postos: "..cidade.quantidade)

	imagem = canvas:new("imagens/estados/"..cidade.estadoabrev:lower()..".png");
	imagem:attrScale(150,100);
	canvas:compose(10,10,imagem);

	titulo("Precos",360,125,30)

	i=0;
	for k, preco in ipairs(cidade.precos)  do
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

	if cidade.posicao.gasolina == 1 then medalhagasolina = canvas:new("imagens/gold_medal.png")
	elseif cidade.posicao.gasolina == 2 then medalhagasolina = canvas:new("imagens/silver_medal.png") 
	elseif cidade.posicao.gasolina == 3 then medalhagasolina = canvas:new("imagens/bronze_medal.png") 
	else medalhagasolina = canvas:new("imagens/bad_medal.png") 
	end

	if cidade.posicao.etanol == 1 then medalhaetanol = canvas:new("imagens/gold_medal.png")
	elseif cidade.posicao.etanol == 2 then medalhaetanol = canvas:new("imagens/silver_medal.png") 
	elseif cidade.posicao.etanol == 3 then medalhaetanol = canvas:new("imagens/bronze_medal.png") 
	else medalhaetanol = canvas:new("imagens/bad_medal.png") 
	end

	if cidade.posicao.diesel == 1 then medalhadiesel = canvas:new("imagens/gold_medal.png")
	elseif cidade.posicao.diesel == 2 then medalhadiesel = canvas:new("imagens/silver_medal.png") 
	elseif cidade.posicao.diesel == 3 then medalhadiesel = canvas:new("imagens/bronze_medal.png") 
	else medalhadiesel = canvas:new("imagens/bad_medal.png") 
	end

	if cidade.posicao.diesels10 == 1 then medalhadiesels10 = canvas:new("imagens/gold_medal.png")
	elseif cidade.posicao.diesels10 == 2 then medalhadiesels10 = canvas:new("imagens/silver_medal.png") 
	elseif cidade.posicao.diesels10 == 3 then medalhadiesels10 = canvas:new("imagens/bronze_medal.png") 
	else medalhadiesels10 = canvas:new("imagens/bad_medal.png") 
	end

	if cidade.posicao.gnv == 1 then medalhagnv = canvas:new("imagens/gold_medal.png")
	elseif cidade.posicao.gnv == 2 then medalhagnv = canvas:new("imagens/silver_medal.png") 
	elseif cidade.posicao.gnv == 3 then medalhagnv = canvas:new("imagens/bronze_medal.png") 
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
	canvas:drawText(225, 320,cidade.posicao.gasolina);

	canvas:attrFont("Arial",20,"bold");
	canvas:drawText(310, 320,cidade.posicao.etanol);

	canvas:attrFont("Arial",20,"bold");
	canvas:drawText(395, 320,cidade.posicao.diesel);

	canvas:attrFont("Arial",20,"bold");
	canvas:drawText(480, 320,cidade.posicao.diesels10);

	canvas:attrFont("Arial",20,"bold");
	canvas:drawText(565, 320,cidade.posicao.gnv);

	titulo("Compare com o preco no estado",230,430,25)

	imagem = canvas:new("imagens/estados/"..cidade.estadoabrev:lower()..".png");
	imagem:attrScale(75,50);
	canvas:compose(10,475,imagem);

	result = arquivo("arquivos/"..cidade.estadoabrev:lower()..".json")
	estado = result.estado

	i=0;
	for k, preco in ipairs(estado.precos)  do
		for k, preco1 in ipairs(cidade.precos)  do
			if (preco.combustivel==preco1.combustivel) then
				caixatexto = canvas:new(100,50);
				caixatexto:attrColor(22,29,67,255);
				caixatexto:drawRoundRect("fill",0,0,100,50,15,15);

				caixatexto:attrColor(255,255,255,255);
				caixatexto:attrFont("Tiresias",20,"bold");
				caixatexto:drawText(9, 5,"R$ "..preco.precomedio);

				caixatexto:attrFont("Arial",10);
				caixatexto:drawText(30, 30,preco.combustivel);

				canvas:compose((i*130)+100,475,caixatexto);
				i=i+1;
			end
		end
	end

	canvas:flush()
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

function separate(string)
	return split(" ",string)
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


event.register(handler);