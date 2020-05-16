%% Life Cycle
%{
simulation of choice of life
Life is About Choices and the Decisions We Make

Life is like a road. There are long and short roads; smooth and rocky roads;
crooked and straight paths. In our life many roads would come our way as we journey through life. 
There are roads that lead to a life of single blessedness, marriage, and religious vocation. 
There are also roads that lead to fame and fortune on one hand,
or isolation and poverty on the other. There are roads to happiness as there are roads to sadness, 
roads towards victory and jubilation, and roads leading to defeat and disappointment.


Just like any road, there are corners, detours, and crossroads in life.
Perhaps the most perplexing road that you would encounter is a crossroad. 
With four roads to choose from and with limited knowledge on where they would go,
which road will you take? 
What is the guarantee that we would choose the right one along the way? Would you take any road, 
or just stay where you are: in front of a crossroad?


There are no guarantees.

You do not really know where a road will lead you until you take it. 
There are no guarantees. 
This is one of the most important things you need to realize about life. 
Nobody said that choosing to do the right thing all the time would always lead you to happiness. 
Loving someone with all your heart does not guarantee that it would be returned. 
Gaining fame and fortune does not guarantee happiness.
Accepting a good word from an influential superior to
cut your trip short up the career ladder is not always bad,
especially if you are highly qualified and competent.
There are too many possible outcomes, which your really cannot control.
The only thing you have power over is the decisions that you will make,
and how you would act and react to different situations.

Wrong decisions are always at hindsight.

Had you known that you were making a wrong decision,
would you have gone along with it? Perhaps not,
why would you choose a certain path when you know it would get you lost?
Why make a certain decision if you knew from the very beginning that it is not the right one. 
It is only after you have made a decision and reflected on it that you realize its soundness.
If the consequences or outcomes are good for you, then you have decided correctly.
Otherwise, your decision was wrong.

Take the risk: Decide.

Since life offers no guarantee and you would never know that your decision
would be wrong until you have made it,
then you might as well take the risk and decide.
It is definitely better than keeping yourself in limbo.
Although it is true that one wrong turn could get you lost,
it could also be that such a turn could be an opportunity for an adventure,
moreover open more roads. It is all a matter of perspective.
You have the choice between being a lost traveller or an accidental tourist of life.
But take caution that you do not make decisions haphazardly.
Taking risks is not about being careless and stupid.
Here are some pointers that could help you choose the best option in the face of life's crossroads:

Get as many information as you can about your situation.

You cannot find the confidence to decide when you know so little about what you are faced with.
Just like any news reporter, ask the 5 W's: what, who, when, where, and why.
What is the situation?
Who are the people involved?
When did this happen?
Where is this leading?
Why are you in this situation?
These are just some of the possible questions to ask to know more about your situation.
This is important. Oftentimes,
the reason for indecision is the lack of information about a situation.

Identify and create options.

What options do the situation give you?
Sometimes the options are few,
but sometimes they are numerous.
But what do you do when you think that the situation offers no options?
This is the time that you create your own.
Make your creative mind work.
From the most simplistic to the most complicated,
entertain all ideas.
Do not shoot anything down when an idea comes to your head.
Sometimes the most outrageous idea could prove to be the right one in the end.
You can ask a friend to help you identify options and even make more options
if you encounter some difficulty, but make sure that you make the decision yourself in the end.

Weigh the pros and cons of every option.

Assess each option by looking at the advantages and disadvantages it offers you.
In this way, you get more insights about the consequences of such an option.

Trust yourself and make that decision.

Now that you have assessed your options,
it is now time to trust yourself.
Remember that there are no guarantees and wrong decisions are always at hindsight.
So choose... decide... believe that you are choosing the best option at this point in time.

Now that you have made a decision,
be ready to face its consequences: good and bad.
It may take you to a place of promise or to a land of problems.
But the important thing is that
you have chosen to live your life instead of remaining a bystander
or a passive audience to your own life.
Whether it is the right decision or not, only time can tell.
But do not regret it whatever the outcome.
Instead, learn from it and remember that
you always have the chance to make better decisions in the future.
%}

clc;
try
    close('lifecycle');
catch
end
fprintf("Simulation of choices and decisions of man,\nwhich determines whole life!\n");
% choice function
cfunc = @(x)2./(1 + exp(-10.*x)) - 1;
y = cfunc(rand(2,2));
birth = [2,1];

Points_x = zeros(0);
Points_y = zeros(0);
for i = linspace(1,100,100)
    nextpoint = birth*rand(2,2);
    Points_x(i) = nextpoint(1);
    Points_y(i) = nextpoint(2);
    birth = nextpoint;
end
figure('name','lifecycle')
scatter(Points_x,Points_y)

