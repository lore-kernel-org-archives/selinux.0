Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <432EE64C.60408@cornell.edu>
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
	 <432CDC23.4010907@cornell.edu>  <432CE470.1020400@cornell.edu>
	 <1127134177.29404.31.camel@moss-spartans.epoch.ncsc.mil>
	 <432EC5BD.2090203@cornell.edu>
	 <1127141128.29404.73.camel@moss-spartans.epoch.ncsc.mil>
	 <432EE64C.60408@cornell.edu>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 12:49:19 -0400
Message-Id: <1127148559.29404.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-19 at 12:24 -0400, Ivan Gyurdiev wrote:
> That's a good question - I'm not entirely sure. I guess that's why I'm 
> trying to push the issue outside the library so we don't have to make 
> that kind of decision.
> 
> It's important, IMHO, that the user not be forced to use stdout/stderr 
> for debugging. I think both approaches accomplish that. Then it's 
> important to allow the caller to recognize which thread created the 
> problem - that's Joshua's concern. This means that we *need* 
> caller-supplied state at the point of debugging, or we can't accomplish 
> this (whether that's the address of a per-thread buffer, or whether it's 
> the thread ID available to a callback function, or whatever).
> 
> The issue of callback vs buffer is less important - I guess it seems 
> more flexible to me to have a callback function, instead of having to 
> worry about allocating buffers, looking inside the buffers, deallocating 
> buffers... but if you disagree we can use buffers.

No, I agree with using callbacks.

> Yes, I wouldn't expect the callback to have the logic to do that - 
> that's just a question of policy on how you use the debug system in your 
> code, and at which point you issue error messages.

Yes, but if the messages are generated in such a form that you need them
all (or at least pieces of several of them) to make sense of the overall
error, then it becomes difficult to implement a sensible callback that
does anything other than output/log/buffer them all (optionally without
the function information).  They can certainly differentiate between
LOG_INFO, LOG_DEBUG, and LOG_ERR, but I think all current DEBUG calls
would be LOG_ERR.

> Which part, specifically, seems like overkill?

If the policy management daemon was going to just discard all messages
except for the leaf node error handling ones, then adding a state object
to the interfaces and pushing it down to all DEBUG calls seemed
pointless; the result would never be used for most of them.  OTOH, you
would still need the state object for all interfaces used by the policy
management daemon, and you would need to push it down to all leaf node
error handlers (whether they would call DEBUG or a separate write_error
interface), so I suppose it might not make a large difference.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
