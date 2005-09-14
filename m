Message-ID: <432823F0.3030803@tresys.com>
Date: Wed, 14 Sep 2005 09:21:52 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	<43264DAD.5090903@cornell.edu>	<1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	<4327521D.5020605@cornell.edu>	<1126652637.30915.18.camel@twoface.columbia.tresys.com>	<432799F0.7060706@cornell.edu> <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Tue, 2005-09-13 at 23:33 -0400, Ivan Gyurdiev wrote:
>  
>
>>Yes, I agree here - the DEBUG system is really doing error handling...
>>it detects an error condition, and informs the caller of what went wrong 
>>at every level of
>>the function stack (at least that's how I use it in the user and port 
>>functions). It has no effect
>>if there is no error condition. Perhaps it's a misnomer.
>>    
>>
>
>To be precise, DEBUG() is providing supplemental information when an
>error occurs to help in debugging the underlying cause.  The error
>handling itself consists of just returning an error code up the call
>chain (although they aren't as informative as one might like).
>write_error() is likewise providing supplemental information when an
>error occurs, but is focused on just reporting informative error
>messages to the user rather than helping with debugging the underlying
>cause or the precise point of failure.
>
>  
>
Yes, and I think we all agree that we need better error reporting to the 
calling functions, we particularly need this in things like linking and 
expanding where alot of stuff happens deep in libsepol and there are 
many possible error, conditions, many of which the user needs to know 
about in order to fix the policy (dependancy problems, etc)

>write_error() is also limited to a single error message, whereas DEBUG()
>can emit any number of messages during a single operation.  This shows
>up particularly in the assertion checking code where we'd like (at least
>for checkpolicy) to report all assertion violations in one pass.
>Similarly, it would be nice if the hieararchy checking code could report
>all violations in one pass (and if it provided more detail about the
>actual cause of the violation).
>  
>

Fair enough, for things like assertion and hierarchy checking we can 
pass a function pointer in and use the same basic system without the 
global DEBUG function pointer and still get what we want there. If we 
tried to use DEBUG for error reporting (as I think Ivan is suggesting) 
the calling function wouldn't get an error code, and thus check it's own 
error state until the first call in the chain and could potentially lose 
information. Having the specific error from the lowest point of failure 
seems much more useful than getting a less and less specific error from 
each funtion while propagating error codes.

I know modifying every function in sepol to use a write_error like 
system is undesirable but libsemanage already has write_error used 
exclusively so going to DEBUG with it also seems undesirable. 
libsemanage already passes a handle which contains an error buffer which 
gives us thread safety and the ability to easily return errors in a way 
the client app can use them (semodule will probably just print them out, 
whereas the policy server will have to do more).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
