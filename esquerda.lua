bola = canvas:new(21,21);
bola:attrColor(255,0,0,255);
bola:drawRoundRect("fill",0,0,20,20,20,20);
canvas:compose(10,320, bola);

canvas:attrColor(255,255,255,255);
canvas:attrFont("Arial",25,"bold");
canvas:drawText(38, 315, "Voltar");

canvas:flush();