Message-ID: <432842D4.3070905@tresys.com>
Date: Wed, 14 Sep 2005 11:33:40 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	<43264DAD.5090903@cornell.edu>	<1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	<4327521D.5020605@cornell.edu>	<1126652637.30915.18.camel@twoface.columbia.tresys.com>	<432799F0.7060706@cornell.edu>	<1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	<432823F0.3030803@tresys.com>	<1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>	<43283772.7070603@tresys.com> <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Wed, 2005-09-14 at 10:45 -0400, Joshua Brindle wrote:
>  
>
>>What I mean is, if there are multiple calls to DEBUG prior to returning 
>>to the originating function then there are multiple error messages of 
>>varying specificity sitting around somewhere, assuming we even store 
>>them all and not just the last one. This isn't ideal for error 
>>reporting, but it is for debugging.
>>    
>>
>
>Even in the error reporting case, allowing for multiple messages (e.g.
>for multiple assertion failures, hierarchy failures, etc) is useful.
>Those would be of comparable specificity rather than varying degrees.
>
>  
>
yes, in those two special cases reporting multiple messages is useful, 
we may need to handle them seperately. There is nothing preventing 
multiple error messages with write_error, we could even add append_error 
and have multiple errors in the same buffer. Granted that, at least with 
assertion failures, the buffer wouldn't be large enough to hold all the 
errors.

>If omitting the traceback data is your primary concern, possibly it
>could be explicitly identified in some manner in the DEBUG() interface
>so that the callback can easily drop it for error reporting purposes.
>
>  
>
Omitting it isn't my concern if it is really for debugging, I do not 
think that we should try to use the debug system for error reporting to 
the originating function if it is going to be a debug system.

>> Personally, again, I feel that gdb 
>>is far superior to any kind of debug system you can put in a library so 
>>I'd rather focus on proper error reporting, which DEBUG doesn't do in a 
>>reasonable way.
>>    
>>
>
>Requiring people to re-run the offending code through a debugger
>significantly reduces your ability to get useful bug reports...
>
>  
>
Fair enough, I had only thought about the developer case, not the user 
case. It seems like the debug system is useful, especially in this case, 
for debugging, but not particularly for error reporting. If Ivan wants 
to put DEBUG in libsemanage we are ok with that, assuming that it is 
used for debugging and corresponding error reporting is also added for 
errors. Since the policy server will be a primary user of libsemanage, 
and is threaded we really need the error reporting in the connection 
handle to report to the user on the other end, but debugging can't hurt.

As for libsepol, I don't think we should go down this road of using 
DEBUG for error reporting. Since parts of libsepol aren't threadsafe 
already (eg., reading, writing) we can use a global error buffer for 
error reporting. If the need for thread safety ever comes up we could 
fix up the API at that point but, as you said before, libsepol is static 
with few users, so API changes aren't a dramatic thing.

In short, it is apparent that we need both debug and write_error, for 
different reasons, and I see no reason why we can't use both. DEBUG, 
then, could be used more liberally for general library information since 
it would presumably default to off.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
