Message-ID: <432EC5BD.2090203@cornell.edu>
Date: Mon, 19 Sep 2005 10:05:49 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	 <43264DAD.5090903@cornell.edu>	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	 <4327521D.5020605@cornell.edu>	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>	 <432799F0.7060706@cornell.edu>	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	 <432823F0.3030803@tresys.com>	 <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>	 <43283772.7070603@tresys.com>	 <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>	 <432842D4.3070905@tresys.com>	 <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>	 <432CDC23.4010907@cornell.edu>  <432CE470.1020400@cornell.edu> <1127134177.29404.31.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127134177.29404.31.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Sat, 2005-09-17 at 23:52 -0400, Ivan Gyurdiev wrote:
>  
>
>>I'm not sure we need both a filtering mechanism, and two systems - one 
>>for debugging and one for error reporting.  That looks like redundancy 
>>to me. I think we need to choose one debug system, add a filtering 
>>mechanism to it, and convert everything to use it. The filtering 
>>mechanism would then determine what's done with the different types of 
>>messages (which are not too clear at the moment).
>>    
>>
>
>I viewed it more as:
>- drop the notion of level/priority since you explained how you can't
>truly classify the different DEBUG messages into those categorizations,
>  
>
I was saying that I'm not convinced you can consider the lowest-level 
message of type ERROR, and the ones above it in the call chain of type 
DEBUG. A different classification system might work, however... the 
level argument could be useful.

>- don't clutter a single interface trying to support both variants, just
>keep them as separate interfaces,
>  
>
We could easily move the level argument into the function name (support 
WARN(), ERROR()), etc.

>- recognize that both DEBUG and write_error are doing error reporting,
>but with differing feedback mechanisms (global callback vs. per-call
>error buffering) and with differing levels of detail.
>  
>
This is the important part - do we want to keep both feedback 
mechanisms, or not.
If the former, then yes - we should keep both write_error and DEBUG. 
However, I think
that's not necessary, because if we implement callbacks, and add a state 
object to pass to
the callbacks, the user of libsepol/libsemanage can design any error 
system they feel like,
which is more flexible than making that choice in the library.

Regarding the differing levels of detail - the callback can make that 
decision if we provide it
with the level of  message (error/debug..etc).

>I expected to use DEBUG() pervasively as the default mechanism, and only
>selectively insert write_error calls (and extend interfaces to take the
>buffers) as needed to support the specific needs of the policy
>management daemon.  Policy management daemon would then disable the
>DEBUG output or redirect it to a log file and only feed the buffered
>error messages back to the client.
>  
>
If we design the debug system properly, we can handle any usage pattern, 
including this one.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
