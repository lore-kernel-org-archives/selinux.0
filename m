Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43284A6B.8080507@tresys.com>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
	 <4327521D.5020605@cornell.edu>
	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>
	 <432799F0.7060706@cornell.edu>
	 <1126702811.12299.29.camel@moss-spartans.epoch.ncsc.mil>
	 <432823F0.3030803@tresys.com>
	 <1126705868.12299.71.camel@moss-spartans.epoch.ncsc.mil>
	 <43283772.7070603@tresys.com>
	 <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>
	 <432842D4.3070905@tresys.com>
	 <1126712325.12299.95.camel@moss-spartans.epoch.ncsc.mil>
	 <43284A6B.8080507@tresys.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 12:24:24 -0400
Message-Id: <1126715064.12299.126.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 12:06 -0400, Joshua Brindle wrote:
> So, do you mean taking write_error, optionally passing in a string and 
> size, having it write to the string if it's present and then calling the 
> debug function pointer if it is present? That way we'll get the error in 
> the handle so that the caller can deal with it and the debug function 
> would also be called. Then the caller could choose to use debug by 
> setting the pointer and other apps that need an error in the handle 
> could use that?

I think you'd still want a level/priority value to distinguish debug
from error messages, with only the latter being written to the buffer
and all of them being fed to the debug callback if it is defined.  

If using write_error, it needs a standard interface defined in a
single .h file with a single shared implementation in a .c file in
libsepol and libsemanage, rather than multiple variants spread around.
No private state data types passed to it, just the common error
buffer/size arguments.

> This seems reasonable to me.. Ivan?

BTW, I just noticed - aren't the calls to sepol_debug() by
sepol_enable/disable_debug() broken?  If you just set the function
pointer, you don't want to clobber it using the old interface.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
