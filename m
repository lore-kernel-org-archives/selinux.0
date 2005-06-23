Subject: Re: [PATCH] disallow * and ~ in rules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200506231529.07106.jbrindle@tresys.com>
References: <1119543471.8955.5.camel@localhost>
	 <1119552466.8955.22.camel@localhost>
	 <1119553228.28493.197.camel@moss-spartans.epoch.ncsc.mil>
	 <200506231529.07106.jbrindle@tresys.com>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 16:19:25 -0400
Message-Id: <1119557965.28493.273.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-23 at 15:29 -0400, Joshua Brindle wrote:
> in the constraint case * seems to be entirely unnecessary. However I'm not 
> convinced that a compliment would never be useful in a constraint. 

I'm not sure why you'd ever use set complement (~b) rather than type set
exclusion (a -b).

> As for roles, it certainly isn't an issue now but one can easily concieve a 
> policy that creates a role for each user on the system. Then something like 
> allow system_r * would actually make sense (err, more sense than now) but 
> still isn't the best way, which would be adding the allow when the role is 
> created. I don't think it's a problem to remove * and ~ from role sets, at 
> least not yet.

If we do retain them (or later restore them), it occurs to me that they
need to exclude the implicitly defined object_r; otherwise, they are
useless.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
