function xor1
%T = Target
%P = Matriz de Entrada para teste
%Q = Matriz com bit errado para rede avaliar
P = [0 1 0 0 1 1 0 0 0 1 0 0 0 1 0 0 1 1 1 0;
     0 1 1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 1 1 1;
     1 1 1 0 0 0 0 1 0 0 1 0 0 0 0 1 1 1 1 0;
     1 0 1 0 1 0 1 0 1 1 1 1 0 0 1 0 0 0 1 0;
     1 1 1 1 1 0 0 0 1 1 1 0 0 0 0 1 1 1 1 0;
     0 1 1 1 1 0 0 0 1 1 1 0 1 0 0 1 0 0 1 0;
     1 1 1 1 0 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0;
     0 1 1 0 1 0 0 1 0 1 1 0 1 0 0 1 0 1 1 0;
     0 1 1 0 1 0 0 1 0 1 1 1 0 0 0 1 1 1 1 1;
     0 1 1 0 1 0 0 1 1 0 0 1 1 0 0 1 0 1 1 0];
%matriz de digitos separados sem ruido
%0 1 0 0 1 1 0 1 0 1 0 0 0 1 0 0 1 1 1 0
Digito1D = [0 1 0 0 1 1 0 1 0 1 0 0 0 1 0 0 0 1 1 0];
Digito2D = [0 1 1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 1 1 1];
Digito3D = [1 1 1 0 0 0 0 1 0 0 1 0 0 0 0 1 1 1 1 0];
Digito4D = [1 0 1 0 1 0 1 0 1 1 1 1 0 0 1 0 0 0 1 0];
Digito5D = [1 1 1 1 1 0 0 0 1 1 1 0 0 0 0 1 1 1 1 0];
Digito6D = [0 1 1 1 1 0 0 0 1 1 1 0 1 0 0 1 0 0 1 0];
Digito7D = [1 1 1 1 0 0 0 1 0 0 1 0 0 1 0 0 0 1 0 0];
Digito8D = [0 1 1 0 1 0 0 1 0 1 1 0 1 0 0 1 0 1 1 0];
Digito9D = [0 1 1 0 1 0 0 1 0 1 1 1 0 0 0 1 1 1 1 1];
Digito0D = [0 1 1 0 1 0 0 1 1 0 0 1 1 0 0 1 0 1 1 0];


 
A = P'
T = [1 0 0 0 0 0 0 0 0 0;
     0 1 0 0 0 0 0 0 0 0;
     0 0 1 0 0 0 0 0 0 0;
     0 0 0 1 0 0 0 0 0 0;
     0 0 0 0 1 0 0 0 0 0;
     0 0 0 0 0 1 0 0 0 0;
     0 0 0 0 0 0 1 0 0 0;
     0 0 0 0 0 0 0 1 0 0;
     0 0 0 0 0 0 0 0 1 0;
     0 0 0 0 0 0 0 0 0 1];
 
 
 %{
     Carregando Imagem dos digitos
     
 %}
 folder = 'C:\Users\BernardoMonteirodaSi\Desktop\Digitos\';
 filePattern = fullfile(folder, '*.jpg');
 f=dir(filePattern);
files={f.name};
for k=1:numel(files)
  	fullFileName = fullfile(folder, files{k});
	cellArrayOfImages{k}=imread(fullFileName);
end
%Fim do carregamento dos digitos nas imagens
net = newff([min(A')' max(A')'], [15 10], {'tansig', 'purelin'}, 'traingd');

net.trainParam.epochs = 10000;
net.trainParam.goal = 0.5e-3;
net.trainParam.lr = 0.1;
net.trainParam.show = 25;
net.trainParam.mc = 0.0;
%net.trainParam.showWindow = true;
%net.trainParam.showCommandLine = true;
net = train(net, A, T);

sim(net, A);
x = inputdlg('Entre com o digito que deseja, para validar a rede: ' );

data = str2num(x{:});
%Teste com digito 2
if data == 0
    CTest = sim(net,Digito0D');
end
if data == 1
     CTest = sim(net,Digito1D');
end
if data == 2
    CTest = sim(net,Digito2D');
end
if data == 3
    CTest = sim(net,Digito3D');
end
if data == 4
    CTest = sim(net,Digito4D');
end
if data == 5
    CTest = sim(net,Digito5D');
end
if data == 6
    CTest = sim(net,Digito6D');
end
if data == 7
    CTest = sim(net,Digito7D');
end
if data == 8
    CTest = sim(net,Digito8D');
end
if data == 9
    CTest = sim(net,Digito9D');
end

figure
%plot(C,'x')
subplot(2,2,1)
hold on
imshow(cellArrayOfImages{data + 1});
box on
title('Desejado')

subplot(2,2,2)
hold on
CTest
for i = 1:10,
   if (CTest(i) > 0.8)
      imshow(cellArrayOfImages{i + 1});
   end
end
box on
title('Obtido')
