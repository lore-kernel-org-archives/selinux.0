Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43299B5D.7070000@cornell.edu>
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
	 <43284A6B.8080507@tresys.com>  <43287BDC.1090004@cornell.edu>
	 <1126797429.10727.95.camel@moss-spartans.epoch.ncsc.mil>
	 <43299B5D.7070000@cornell.edu>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 08:19:55 -0400
Message-Id: <1126873195.25919.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-15 at 12:03 -0400, Ivan Gyurdiev wrote:
> >Ok, suggestion:
> >- Leave write_error() and DEBUG() separate,
> >- Move write_error() to a unified interface and shared implementation,
> >and have it internally call DEBUG() as well as saving the message in the
> >buffer,
> >- Convert remaining printf/fprintf occurrences to DEBUG(),
> >- Convert direct snprintf calls into error buffers to use the shared
> >write_error() interface.
> >  
> >
> Do you see DEBUG as being off by default or on by default?
> I'm trying to understand what the role of DEBUG is here... currently it 
> handles
> important printfs that will disappear if turned off.

I think on by default, but still with the ability for explicit disable,
which will likely be used by the policy server.

> Also, should write_error be paying attention to security_debug() ?

No, I think write_error should always write the formatted message to the
error buffer, regardless of debug settings.  Then it calls DEBUG(),
which does its thing.  Hence, all error messages find their way to DEBUG
eventually (which may then discard them based on its setting), whereas
write_error is called more selectively and only when the calling
interface has error buffer arguments available.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
