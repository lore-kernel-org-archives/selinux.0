Message-ID: <43284A6B.8080507@tresys.com>
Date: Wed, 14 Sep 2005 12:06:03 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>	<43264DAD.5090903@cornell.edu>	<1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>	<4327521D.5020605@cornell.edu>	<1126652637.30915.18.camel@twoface.columbia.tresys.com>	<432799F0.7060706@cornell.edu>	<1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>	<432823F0.3030803@tresys.com>	<1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>	<43283772.7070603@tresys.com>	<1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>	<432842D4.3070905@tresys.com> <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:

>On Wed, 2005-09-14 at 11:33 -0400, Joshua Brindle wrote:
>  
>
>>Omitting it isn't my concern if it is really for debugging, I do not 
>>think that we should try to use the debug system for error reporting to 
>>the originating function if it is going to be a debug system.
>>    
>>
>
>I was thinking that unifying them would be ideal, and the callbacks can
>decide how they want to filter the results.  Just requires that the
>callbacks be provided with a level indicator in addition to the other
>arguments that indicates whether it is debug info only or error info.
>Not unlike syslog(3) or printk(9).
>  
>
So, do you mean taking write_error, optionally passing in a string and 
size, having it write to the string if it's present and then calling the 
debug function pointer if it is present? That way we'll get the error in 
the handle so that the caller can deal with it and the debug function 
would also be called. Then the caller could choose to use debug by 
setting the pointer and other apps that need an error in the handle 
could use that?

This seems reasonable to me.. Ivan?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
