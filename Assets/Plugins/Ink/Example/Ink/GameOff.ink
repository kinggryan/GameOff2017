-> invitation

VAR time_waited = -1
VAR temperment = 0

== function increase_stat(ref x)
~  x += 1

== function decrease_stat(ref x)
~ x -= 1

== function waited
~time_waited += 1 

== invitation ==
Standing before an impressive manor, you quickly check the invitaion you received a fortnight prior, disbelieving your good fortnue. 
"The Marquess and Marchioness of Derby request the pleasure of Miss Ruth Leigh's company at dinner on Thursday, the 14th of April, at 5 o’clock."//Will displayed on a fancy calling card
Along with the decandent note came a glorious gown and heels, which you now don. You are not used to such elaborate garments and buckle under the weight of the many layers. Attached to the dress was a short note, in a script dissimilar to what appeared on the invitation
"Surely, my dear Ruth, you have nothing to wear?" // also on fancy paper

*  You were disarmed by hostile familarity of the note, <>
-> hostile

* You thought the note strange, <>
-> hostile

*You thought nothing of the note <>
->nothing

- (hostile) but the chance to mingle with the likes of high society were too promising to miss. ->exitce

- (nothing) and were overjoyed that some guardian had placed you in good hands. {increase_stat(temperment)}

- (exitce) With anxious exitcement, you stare expecetedly at Rose House, wondering what the evening holds for you.  

-> arrived_at_Rose_House

=== arrived_at_Rose_House ===

-(outside)
{time_waited < 4} {You arrive at the townhouse | After occupying ourself for a short while, you arrived |Surely, you figure, it is time to enter | If fifteen minutes is fashionably late, then I must be excelling in style at}{five minutes before the hour.|at Rose House again at exactly five o'clock. | fifteen minutes past the hour. | thirty minutes past the hour. | fourty-five past the hour}

    *You enter Rose House
    <> with much trepadiation.
    
    Temperment is now {temperment} //Test for stat_increase(). Will remove in game
    ->DONE
    
     + (wait) {time_waited < 3} [Wait] 
    You wait {and take a stroll around the block. A street barker shouts the news of the day and you intently listen. |{increase_stat(temperment)} and hoped to find something of interest on the street. You glance at your heels, wishing you had a more comfortable option.| {decrease_stat(temperment)}, and feel as if you will truly make quite an entrance. }
    {waited()}
    ->outside
    
  





