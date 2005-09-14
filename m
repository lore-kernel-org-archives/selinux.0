Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1126727413.12299.208.camel@moss-spartans.epoch.ncsc.mil>
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
	 <1126727413.12299.208.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 16:01:34 -0400
Message-Id: <1126728094.12299.219.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 15:50 -0400, Stephen Smalley wrote:
> On Wed, 2005-09-14 at 15:37 -0400, Ivan Gyurdiev wrote:
> >  In 
> > fact,
> > the distinction is still a bit lost to me - it seems as if all current 
> > uses of DEBUG
> > are for error handling, and none are for debugging. Perhaps you could 
> > give an
> > example to clarify the situation...
> 
> Offhand, I don't know of an actual debugging user of DEBUG() yet,

Ah, sorry.  I think Joshua wanted to omit the function name and
traceback info from the error message saved in the buffer for return to
the client/user.  Which would mean that only the deepest level DEBUG()
calls would qualify as "errors" in his thinking.  But you just noted in
your other reply that this doesn't work very well.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
