%function that creates question, answer and wrong answer 
%uses EMA to analyse trends in user performance
%depending on the EMA, it will give easier or harder questions 

function [question, answer, wrong_ans] = create_question(current_EMA, previous_EMA)

%if there is an upward EMA trend, person gets harder questions 
if current_EMA > previous_EMA 
    %creates numbers for question (between 6 and 12)
    x = randi([6, 12]);
    y = randi([6, 12]); 
    %this is the answer to question
    answer = num2str(x * y); 
    %creates a wrong answer (using random numbers)
    wrong_ans = num2str(str2num(answer) + randi([1, 5])); 
    x_string = num2str(x); 
    y_string = num2str(y); 
    %creates question
    question = [x_string ' x ' y_string ' = ?']; 
end  

%if there is a downward EMA trend, person gets easier questions
if current_EMA <= previous_EMA 
    %creates numbers for question (between 1 and 6)
    x = randi([1, 6]);
    y = randi([1, 6]); 
    answer = num2str(x * y); 
    wrong_ans = num2str(str2num(answer) + randi([1, 5])); 
    x_string = num2str(x); 
    y_string = num2str(y); 
    %creates question
    question = [x_string ' x ' y_string ' = ?']; 
end  


end 

