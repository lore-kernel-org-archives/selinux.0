Message-ID: <43287BDC.1090004@cornell.edu>
Date: Wed, 14 Sep 2005 15:37:00 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	<43264DAD.5090903@cornell.edu>	<1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	<4327521D.5020605@cornell.edu>	<1126652637.30915.18.camel@twoface.columbia.tresys.com>	<432799F0.7060706@cornell.edu>	<1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	<432823F0.3030803@tresys.com>	<1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>	<43283772.7070603@tresys.com>	<1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>	<432842D4.3070905@tresys.com> <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil> <43284A6B.8080507@tresys.com>
In-Reply-To: <43284A6B.8080507@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> So, do you mean taking write_error, optionally passing in a string and 
> size, having it write to the string if it's present and then calling 
> the debug function pointer if it is present? That way we'll get the 
> error in the handle so that the caller can deal with it and the debug 
> function would also be called. Then the caller could choose to use 
> debug by setting the pointer and other apps that need an error in the 
> handle could use that?
>
> This seems reasonable to me.. Ivan?

So, I'm not clear on the exact migration steps that need to be taken here.
I've just changed a lot of printfs to DEBUG calls. I'm not entirely sure 
whether
they qualify as error reporting or debugging (probably the former). In 
fact,
the distinction is still a bit lost to me - it seems as if all current 
uses of DEBUG
are for error handling, and none are for debugging. Perhaps you could 
give an
example to clarify the situation...

Next, what to do we do with all those printf calls that remain, and the ones
that are now DEBUG calls.... if they are in fact error-reporting statements,
then I understand you want them written in an error buffer. Where does
the buffer come from, given the current API?

I am in favor of moving all messaging systems into one .c and .h file,
and making things more consistent.  I also like the idea of output
levels for debugging and error-messaging, although I'm not entirely sure
where I would use which.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
