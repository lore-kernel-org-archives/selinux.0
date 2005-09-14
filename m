Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43283772.7070603@tresys.com>
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
Content-Type: text/plain
Date: Wed, 14 Sep 2005 11:04:36 -0400
Message-Id: <1126710276.12299.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 10:45 -0400, Joshua Brindle wrote:
> What I mean is, if there are multiple calls to DEBUG prior to returning 
> to the originating function then there are multiple error messages of 
> varying specificity sitting around somewhere, assuming we even store 
> them all and not just the last one. This isn't ideal for error 
> reporting, but it is for debugging.

Even in the error reporting case, allowing for multiple messages (e.g.
for multiple assertion failures, hierarchy failures, etc) is useful.
Those would be of comparable specificity rather than varying degrees.

If omitting the traceback data is your primary concern, possibly it
could be explicitly identified in some manner in the DEBUG() interface
so that the callback can easily drop it for error reporting purposes.

>  Personally, again, I feel that gdb 
> is far superior to any kind of debug system you can put in a library so 
> I'd rather focus on proper error reporting, which DEBUG doesn't do in a 
> reasonable way.

Requiring people to re-run the offending code through a debugger
significantly reduces your ability to get useful bug reports...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
