Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <43285B07.2070402@cornell.edu>
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
	 <1126715064.12299.126.camel@moss-spartans.epoch.ncsc.mil>
	 <43285B07.2070402@cornell.edu>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 14:53:37 -0400
Message-Id: <1126724017.12299.184.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 13:16 -0400, Ivan Gyurdiev wrote:
> The old interface is supposed to go away, but until it does, the new 
> interface must provide the same functionality, which is why it maintains 
> printing to stdout using the old system. By the way, this is *yet 
> another* debug system - __sepol_debug_printf...

Well, it was another debug system (introduced by Dan earlier for
genbools/genusers), but your recent patches replaced all occurrences
AFAICS.

What remains are:
- the DEBUG(<function name>, <fmt>, ...) interface you introduced,
- the write_error(<state == buffer, size>, <fmt>, ...) interface Tresys
introduced with the module infrastructure,
- direct snprintf calls on error buffer parameters (hierarchy.c,
module.c) in the hierarchy checking and module infrastructure,
- if (state->verbose) printf calls (expand.c, link.c) for debugging in
the module infrastructure, 
- lingering printf/fprintf occurrences, most of which are from the
original inherited checkpolicy/security server code.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
