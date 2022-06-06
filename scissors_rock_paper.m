clc, clear
close all
disp('paper are red');
disp('rock are blue');
disp('scissors are green');

MARKER_SIZE = 15;
RANGE_LENGTH = 50;
PAPER_AMOUNT = 500;
ROCK_AMOUNT = 500;
SCISSORS_AMOUNT = 500;
BOUNDS_MIN_VALUE = -20;
BOUNDS_MAX_VALUE = 20;

% rock_img = imread('D:\Users\Mitja\Downloads\rock.jpg');
% rock_img = imresize(rock_img, 0.0005);
% rock_img = flipud(rock_img);
% paper_img = imread('D:\Users\Mitja\Downloads\paper1.png');
% % paper_img = imresize(paper_img, [32 NaN]);
% paper_img = flipud(paper_img);
% scissors_img = imread('D:\Users\Mitja\Downloads\scissors.png');
% scissors_img = imresize(scissors_img, 0.0005);
% scissors_img = flipud(scissors_img);

paper=[];
rock=[];
scissors=[];
for i = 1:PAPER_AMOUNT
    paper = [paper randi([BOUNDS_MIN_VALUE BOUNDS_MAX_VALUE], 2, 1)];
end
for i = 1:ROCK_AMOUNT
    rock = [rock randi([BOUNDS_MIN_VALUE BOUNDS_MAX_VALUE], 2, 1)];
end
for i = 1:SCISSORS_AMOUNT
    scissors = [scissors randi([BOUNDS_MIN_VALUE BOUNDS_MAX_VALUE], 2, 1)];
end
% paper = randi([BOUNDS_MIN_VALUE BOUNDS_MAX_VALUE], 2, PAPER_AMOUNT);
% rock = randi([BOUNDS_MIN_VALUE BOUNDS_MAX_VALUE], 2, ROCK_AMOUNT);
% scissors = randi([BOUNDS_MIN_VALUE BOUNDS_MAX_VALUE], 2, SCISSORS_AMOUNT);

figure
plot(paper(1, :), paper(2, :), 'r.', 'MarkerSize', MARKER_SIZE)
hold on
plot(rock(1, :), rock(2, :), 'b.', 'MarkerSize', MARKER_SIZE)
hold on
plot(scissors(1, :), scissors(2, :), 'g.', 'MarkerSize', MARKER_SIZE)

% for i = 1:PAPER_AMOUNT
%     h = image(paper(1, i), paper(2, i), paper_img);            
% end
% for i = 1:ROCK_AMOUNT
%     h = image(rock(1, i), rock(2, i), rock_img);            
% end
% for i = 1:SCISSORS_AMOUNT
%     h = image(scissors(1, i), scissors(2, i), scissors_img);            
% end

grid on
current_paper_amount = PAPER_AMOUNT;
current_rock_amount = ROCK_AMOUNT;
current_scissors_amount = SCISSORS_AMOUNT;

isGameEnded = false;
pause(3)
while(~isGameEnded)

    if (current_paper_amount < 1 && current_scissors_amount < 1) || (current_paper_amount < 1 && current_rock_amount < 1) || (current_scissors_amount < 1 && current_rock_amount < 1)
        isGameEnded = true;
    end
    
    for i = 1:current_paper_amount
        tempDiff = randi([-1 1], 2, 1);
        paper(:, i) = paper(:, i) + tempDiff;
        if (paper(1, i) < BOUNDS_MIN_VALUE) || (paper(1, i) > BOUNDS_MAX_VALUE)
            paper(1, i) = paper(1, i) - 2 * tempDiff(1, 1);
        elseif (paper(2, i) < BOUNDS_MIN_VALUE) || (paper(2, i) > BOUNDS_MAX_VALUE)
            paper(2, i) = paper(2, i) - 2 * tempDiff(2, 1);
        end
    end
    for i = 1:current_scissors_amount
        tempDiff = randi([-1 1], 2, 1);
        scissors(:, i) = scissors(:, i) + tempDiff;
        if (scissors(1, i) < BOUNDS_MIN_VALUE) || (scissors(1, i) > BOUNDS_MAX_VALUE)
            scissors(1, i) = scissors(1, i) - 2 * tempDiff(1, 1);
        elseif (scissors(2, i) < BOUNDS_MIN_VALUE) || (scissors(2, i) > BOUNDS_MAX_VALUE)
            scissors(2, i) = scissors(2, i) - 2 * tempDiff(2, 1);
        end
    end
    for i = 1:current_rock_amount
        tempDiff = randi([-1 1], 2, 1);
        rock(:, i) = rock(:, i) + tempDiff;
        if (rock(1, i) < BOUNDS_MIN_VALUE) || (rock(1, i) > BOUNDS_MAX_VALUE)
            rock(1, i) = rock(1, i) - 2 * tempDiff(1, 1);
        elseif (rock(2, i) < BOUNDS_MIN_VALUE) || (rock(2, i) > BOUNDS_MAX_VALUE)
            rock(2, i) = rock(2, i) - 2 * tempDiff(2, 1);
        end
    end
    
    clf;
    plot(paper(1, :), paper(2, :), 'r.', 'MarkerSize', MARKER_SIZE)
    hold on
    plot(rock(1, :), rock(2, :), 'b.', 'MarkerSize', MARKER_SIZE)
    hold on
    plot(scissors(1, :), scissors(2, :), 'g.', 'MarkerSize', MARKER_SIZE)
    grid on
%     for i = 1:current_paper_amount
%         h = image(paper(1, i), paper(2, i), paper_img);            
%     end
%     for i = 1:current_rock_amount
%         h = image(rock(1, i), rock(2, i), rock_img);            
%     end
%     for i = 1:current_scissors_amount
%         h = image(scissors(1, i), scissors(2, i), scissors_img);            
%     end
%     pause(0.5)
    
    tempIndexes =[];
    for i = 1:current_paper_amount
        if ismember(paper(:, i), scissors)
            tempIndexes = [tempIndexes i];
        end
    end
    tempIndexes = sort(tempIndexes, 'descend');
    for i = 1:length(tempIndexes)
        paper(:, tempIndexes(i)) = [];
    end
    current_paper_amount = current_paper_amount - length(tempIndexes);
    
    tempIndexes =[];
    for i = 1:current_scissors_amount
        if ismember(scissors(:, i), rock)
            tempIndexes = [tempIndexes i];
        end
    end
    tempIndexes = sort(tempIndexes, 'descend');
    for i = 1:length(tempIndexes)
        scissors(:, tempIndexes(i)) = [];
    end
    current_scissors_amount = current_scissors_amount - length(tempIndexes);
    
    tempIndexes =[];
    for i = 1:current_rock_amount
        if ismember(rock(:, i), paper)
            tempIndexes = [tempIndexes i];
        end
    end
    tempIndexes = sort(tempIndexes, 'descend');
    for i = 1:length(tempIndexes)
        rock(:, tempIndexes(i)) = [];
    end
    current_rock_amount = current_rock_amount - length(tempIndexes);

end


if ~isempty(rock) > 0
    disp('ROCK IS A WINNER');
    [n, m] = size(rock);
    disp(m);
elseif ~isempty(paper)
    disp('PAPER IS A WINNER');
    [n, m] = size(paper);
    disp(m);
else
    disp('SCISSORS IS A WINNER'); 
    [n, m] = size(scissors);
    disp(m);
end