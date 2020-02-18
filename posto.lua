json = require "json";

function handler(evt)
	if evt.class=="ncl" then
		if evt.action=="start" then
			detalhes(persistent.service.hash)
		end
	end
end

function detalhes(posto)
	posto = arquivo("arquivos/posto/"..posto..".json").posto;

	canvas:attrColor(230,81,0,255)
	canvas:drawRect("fill",0,0,canvas:attrSize())

	canvas:attrColor(255,255,255,255)
	canvas:attrFont("Arial",40,"bold")
	canvas:drawText(130, 12,posto.razao)
	canvas:attrFont("Arial",20,"bold")
	canvas:drawText(130, 57,"Posicao: ("..posto.latitude..") - ("..posto.longitude..")")
	canvas:drawText(130, 82,"Bandeira: "..posto.bandeira)

	bandeirae = posto.bandeira
	bandeira = split(" ",posto.bandeira)
	if (length(bandeira)<=1) then posto.bandeira=posto.bandeira:lower()
	else posto.bandeira=bandeira[0]:lower().."-"
	end
	imagem = canvas:new("imagens/bandeiras/"..posto.bandeira..".png");
	imagem:attrScale(100,100);
	canvas:compose(10,10,imagem);

	titulo("Precos",360,125,30)

	i=0;
	for k, preco in ipairs(posto.precos)  do
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

	titulo("Endereco",360,250,30)

	canvas:attrFont("Arial",18,"bold")
	canvas:drawText(80, 300,"Endereco: "..posto.endereco)
	canvas:drawText(80, 330,"Bairro: "..posto.bairro)
	canvas:drawText(80, 360,"Cidade: "..posto.cidade)
	canvas:drawText(80, 390,"Estado: "..posto.estado)

	titulo("Compare com o preco no estado",230,430,25)

	imagem = canvas:new("imagens/estados/"..posto.estadoabrev:lower()..".png");
	imagem:attrScale(75,50);
	canvas:compose(10,475,imagem);

	result = arquivo("arquivos/"..posto.estadoabrev:lower()..".json")
	estado = result.estado

	i=0;
	for k, preco in ipairs(estado.precos)  do
		for k, preco1 in ipairs(posto.precos)  do
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