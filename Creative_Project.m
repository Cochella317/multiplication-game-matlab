
%starts line 23 while loop
start_game = 0; 

%tracks the # of questions
questions_amount = 1; 
%track # of right answers
right_answers = 0;  
%EMA gives information about trends in data 
current_EMA = 0; 
previous_EMA = 0; 
%formula for smoothing (for EMA)
smoothing = 2 / (1 + 15);
%helps to keep track of the change in trend (for EMA)
total = 0;
%saves EMA to use in app (GUI)
EMA_list = []; 
%tracks the time it takes for each question for app (GUI)
time_total_list = []; 

m5u.lcdClear()

while start_game == 0 
    m5u.lcdCursor(60,70); 
    m5u.lcdPrintLn("Welcome to MultiSolve")
    m5u.lcdCursor(50,100); 
    m5u.lcdPrintLn("Press any button to start.")

    %press button to start game
    if readDigitalPin(m5, 'D26') == 0 || readDigitalPin(m5, 'D36') == 0 
        m5u.lcdClear() 
        m5u.lcdPrintLn("Starting...")
        pause(0.5)
        m5u.lcdClear()
        %gives user 15 questions 
        while questions_amount <= 15
            %get current value to use in EMA formula 
            current_value = total / 15; 
            %sets current EMA to last EMA
            previous_EMA = current_EMA; 
            %This is the EMA formula, this will tell the function what type
            %of question to give 
            current_EMA = (current_value * smoothing) + (previous_EMA * (1 - smoothing));
            %adds current EMA to list
            EMA_list = [EMA_list; current_EMA];
            %function that creates question depending on EMA
            [question, answer, wrong_ans] = create_question(current_EMA, previous_EMA); 
             
            

            %displays question # on screen
            question_amount_str = ['Question Number: ' num2str(questions_amount) '/15'];
            m5u.lcdCursor(10,10);
            m5u.lcdPrint(question_amount_str); 

            %this is to randomize the buttons answer so that blue button
            %is not always right and red button is not always wrong (and
            %vice versa)
            string_buttons = {'blue', 'red'};  
            random_num = randi([1,2]);


            %starts timer
            start_time = tic; 

            %Scenario #1
            if strcmp(string_buttons(random_num), 'blue')
                %blue button gets assigned with right answer 
                %wrong answer is assigned to red button
                m5u.lcdCursor(120,70); 
                %displays question to lcd
                m5u.lcdPrintLn(question)
                m5u.lcdCursor(90,100); 
                %displays answer options 
                display_right = ['Blue Button: ' answer]; 
                m5u.lcdPrintLn(display_right)
                m5u.lcdCursor(90,150);
                display_wrong = ['Red Button: ' wrong_ans];
                m5u.lcdPrintLn(display_wrong)
                user_answer = 0; 
                %wait for user to press a button
                while user_answer == 0 
                    %blue button is picked, correct answer
                    if readDigitalPin(m5, 'D36') == 0 
                        m5u.lcdClear();
                        %time to answer the question
                        end_time = toc(start_time);
                        pause(0.3)
                        writeColor(np, 1:10, 'green')
                        %displays message to lcd
                        m5u.lcdCursor(70,70); 
                        m5u.lcdPrintLn("You got it right!");
                        %adds to question_amount count
                        questions_amount = questions_amount + 1;
                        %adds to right answer count
                        right_answers = right_answers + 1; 
                        %adjusts the EMA for the next question
                        total = total + 1; 
                        pause(1);
                        writeColor(np, 1:10, 'off')
                        m5u.lcdClear();
                        %ends while loop on line 80
                        user_answer = 1; 

                    %red button is picked, wrong answer 
                    elseif readDigitalPin(m5, 'D26') == 0
                        m5u.lcdClear();
                        %time to answer the question
                        end_time = toc(start_time);
                        pause(0.3)
                        writeColor(np, 1:10, 'red')
                        %message to lcd
                        m5u.lcdCursor(30,70);
                        m5u.lcdPrintLn("You got it wrong.")
                        %tells user correct answer
                        m5u.lcdCursor(25,100);
                        m5u.lcdPrintLn("The correct answer was: ")
                        m5u.lcdCursor(250,100);
                        m5u.lcdPrint(answer)
                        %adds to question_amount count 
                        questions_amount = questions_amount + 1; 
                        %adjusts the EMA for the next question
                        total = total - 1; 
                        pause(1);
                        writeColor(np, 1:10, 'off')
                        m5u.lcdClear(); 
                        %ends while loop on line 80
                        user_answer = 1;

                    end 

                end 

                             

            %Scenario 2 
            %almost identical code as lines 65 - 130
            elseif strcmp(string_buttons(random_num), 'red')
                %red button is assigned with right answer 
                %wrong answer is the blue button 
                m5u.lcdCursor(120,70); 
                m5u.lcdPrintLn(question)
                m5u.lcdCursor(90,100); 
                display_right = ['Blue Button: ' wrong_ans]; 
                m5u.lcdPrintLn(display_right)
                m5u.lcdCursor(90,150);
                display_wrong = ['Red Button: ' answer];
                m5u.lcdPrintLn(display_wrong)
                user_answer = 0; 
                while user_answer == 0 
                    if readDigitalPin(m5, 'D26') == 0 
                        m5u.lcdClear();
                        %time to answer the question
                        end_time = toc(start_time);
                        pause(0.3)
                        writeColor(np, 1:10, 'green')
                        m5u.lcdCursor(70,70); 
                        m5u.lcdPrintLn("You got it right!");
                        questions_amount = questions_amount + 1; 
                        right_answers = right_answers + 1;
                        total = total + 1; 
                        pause(1);
                        writeColor(np, 1:10, 'off')
                        m5u.lcdClear(); 
                        user_answer = 1; 

                    elseif readDigitalPin(m5, 'D36') == 0
                        m5u.lcdClear();
                        %time to answer the question
                        end_time = toc(start_time);
                        pause(0.3)
                        writeColor(np, 1:10, 'red')
                        m5u.lcdCursor(30,70);
                        m5u.lcdPrintLn("You got it wrong.")
                        m5u.lcdCursor(25,100);
                        m5u.lcdPrintLn("The correct answer was:")
                        m5u.lcdCursor(250,100);
                        m5u.lcdPrint(answer)
                        questions_amount = questions_amount + 1; 
                        total = total - 1; 
                        pause(1);
                        writeColor(np, 1:10, 'off')
                        m5u.lcdClear(); 
                        user_answer = 1; 

                    end 

                end 


            end 
            
            %sends time to answer question to list 
            time_total_list = [time_total_list; end_time]; 

        end 
    
    %once questions = 15, ends program 
    start_game = 1; 
        
    end 




end 

%turns lights off
writeColor(np, 1:10, 'off');
pause(0.2)

%display # of right answers on LCD
right_answers_string = ['You got ' num2str(right_answers) '/15 questions correct' ]; 
m5u.lcdCursor(10,80); 
m5u.lcdPrintLn(right_answers_string) 
m5u.lcdCursor(10,110);
m5u.lcdPrintLn("More infomation coming shortly...")

%starts the GUI app 
app = Results_creativeProject;
%sends the EMA and time list to the GUI
app.EMA_list = EMA_list; 
app.time_total_list = time_total_list; 


