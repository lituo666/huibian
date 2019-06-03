assume cs:codesg
codesg segment
start: 
      mov ax,  1000
      add ax, ax 

       mov ax, 4c00h
       int 21h

codesg ends
end start
