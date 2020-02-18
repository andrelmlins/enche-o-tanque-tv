json = require "json";

canvas:attrColor(22,29,67,255);
width,height = canvas:attrSize()
canvas:drawRect("fill",0,0,width,height);

top = canvas:new(width-20,height-20);
top:attrColor(255,255,255,255);
top:drawRoundRect("fill",0,0,width-20,height-20,15,15);
canvas:compose(10,10,top);

size = 30;

canvas:attrColor(0,0,0,255);

function arquivo(arq)
  archive = "";
  for line in io.lines(arq) do
    archive = archive..line
  end
  return json.decode(archive)
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

postos = arquivo("arquivos/ranking.json").postos;

titulo("Ranking",135,20,15)
canvas:attrColor(0,0,0,255);
i=1;
for k, posto in ipairs(postos)  do

	result = ((size+13)*(i-1))+48;

	bandeira = split(" ",posto.bandeira)
	if (length(bandeira)<=1) then posto.bandeira=posto.bandeira:lower()
	else posto.bandeira=bandeira[0]:lower().."-"
	end

	imagem = canvas:new("imagens/bandeiras/"..posto.bandeira..".png");
	imagem:attrScale(size,size);
	canvas:compose(13,result,imagem);

	canvas:attrFont("Tiresias",15,"bold");
	canvas:drawText((size)+20, result,posto.razao);
	canvas:attrFont("Tiresias",10,"bold");
	canvas:drawText((size)+20,result+18,"Preco do "..posto.combustivel..": "..posto.precovenda);
	
	i=i+1;

end

canvas:flush();


