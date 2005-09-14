Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43279AED.7040605@cornell.edu>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
	 <4327521D.5020605@cornell.edu>
	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>
	 <432799F0.7060706@cornell.edu>  <43279AED.7040605@cornell.edu>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 09:16:19 -0400
Message-Id: <1126703779.12299.43.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-13 at 23:37 -0400, Ivan Gyurdiev wrote:
>  > The core of the problem is library-wide debugging without 
> caller-supplied state object.
>  
> By the way, the same thing applies to all those functions that use a 
> library-wide policydb.
> I think that's a mistake, and they should take the policydb as an 
> argument. Global variables
> are evil and not thread-friendly.

Shrug.  In the kernel security server, from which this code originated,
there is a single active policydb and sidtab at a time, and the service
functions operate on them.  I'm dubious that one truly needs per-thread
policydb/sidtab instances in the userspace security server.  In any
event, as noted repeatedly, libsepol is just a blob of code taken from
checkpolicy much of which was taken from the kernel security server, so
let's get over its deficiencies and move on.  

As for threads, Alan Cox said it best:  "A computer is a state machine.
Threads are for people who cant program state machines.".

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
