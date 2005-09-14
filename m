Message-ID: <432799F0.7060706@cornell.edu>
Date: Tue, 13 Sep 2005 23:33:04 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	 <43264DAD.5090903@cornell.edu>	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	 <4327521D.5020605@cornell.edu> <1126652637.30915.18.camel@twoface.columbia.tresys.com>
In-Reply-To: <1126652637.30915.18.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>If you have debug on-by-default it seems like you are really doing error
>handling. If this is the case we may need to consolidate these systems
>but error handling and debugging are hardly the same things.
>  
>
Yes, I agree here - the DEBUG system is really doing error handling...
it detects an error condition, and informs the caller of what went wrong 
at every level of
the function stack (at least that's how I use it in the user and port 
functions). It has no effect
if there is no error condition. Perhaps it's a misnomer.

>iirc, as Steve mentioned, there are some thread safety issues with DEBUG
>and since both the userspace security server and the policy management
>server are threaded this could be problematic. 
>  
>
The issues are not with DEBUG - they're with the general principle
of library-wide debugging/error-messaging vs per-function error handling 
(state object
passed by caller).

>The error system should be about passing descriptive messages to the
>caller and this needs to be done by passing a buffer to the functions
>that may return an error,
>
How do we pass such a buffer without rewriting the libsepol API?
DEBUG has the advantage of being backwards compatible.

> not be setting a function pointer to an
>arbitrary function in the frontend to handle error conditions.
>  
>
That's an implementation detail that you don't like, because of the 
semanage server.
It's not the core issue here - you could have the caller pass a callback 
with argument (for thread id)
to be invoked on error just as easily as passing in a buffer.

The core of the problem is library-wide debugging without 
caller-supplied state object.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
