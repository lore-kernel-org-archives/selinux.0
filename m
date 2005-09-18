Message-ID: <432CE470.1020400@cornell.edu>
Date: Sat, 17 Sep 2005 23:52:16 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	 <43264DAD.5090903@cornell.edu>	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	 <4327521D.5020605@cornell.edu>	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>	 <432799F0.7060706@cornell.edu>	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	 <432823F0.3030803@tresys.com>	 <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>	 <43283772.7070603@tresys.com>	 <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>	 <432842D4.3070905@tresys.com> <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil> <432CDC23.4010907@cornell.edu>
In-Reply-To: <432CDC23.4010907@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>
>> I was thinking that unifying them would be ideal, and the callbacks can
>> decide how they want to filter the results.  Just requires that the
>> callbacks be provided with a level indicator in addition to the other
>> arguments that indicates whether it is debug info only or error info.
>> Not unlike syslog(3) or printk(9).
>>  
>>
> Which messages would be marked at what levels?
> Example?


Never mind, you already answered that question.

> Offhand, I don't know of an actual debugging user of DEBUG() yet,
> although it seems that the if (state->verbose) printf statements in the
> Tresys code would qualify as potential debugging users.  There are also
> "informational" cases, like the printfs in policydb_index_others.
> syslog(3) does have distinct notions of debug, info, warning, error,
> critical, alert, and emergency as its priority values.

I'm not sure we need both a filtering mechanism, and two systems - one 
for debugging and one for error reporting.  That looks like redundancy 
to me. I think we need to choose one debug system, add a filtering 
mechanism to it, and convert everything to use it. The filtering 
mechanism would then determine what's done with the different types of 
messages (which are not too clear at the moment).

There's the issue of global vs per-function-state. I think the second 
one wins here, and we'll just have to adjust the shared APIs. We could 
create something similar to the semanage handle, which encompasses a 
policydb, as well as error handling. I think libsepol should be the 
library that manages the policydb object.

There's the issue of multiple errors - I think any error system needs to 
support multiple error messages.

Then there's the issue of buffer vs callback. I think callback wins 
here. Provided function-local state, there's no reason not to have a 
callback. If you want buffering services, you can arrange for that in 
the callback. We should add a void* argument to the callback, and keep 
that in the state object, passing it at every invocation.

The function name.... is irrelevant if we go with the callback system - 
callback can drop the name. I think it's useful, and it should stay.

Callback should look something like this, maybe ?
We can write macros to reduce arguments...

int (*DEBUG_v2) (
    void* arg,               /* Caller supplied argument */
    int level,                 /* WARN, ERROR, DEBUG ...kind of like MLS 
level - notion of rank */
    int channel,            /* Wine has this...not sure we need it... 
similar to MLS category - area of debugging */
    const char* fname,  /* Function name */
    const char* fmt,      /* Format string */
    ...)                         /* Format arguments */
   
   










--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
