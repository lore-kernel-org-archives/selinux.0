Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <432EF286.7030101@cornell.edu>
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
	 <1127148559.29404.140.camel@moss-spartans.epoch.ncsc.mil>
	 <432EF286.7030101@cornell.edu>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 14:26:49 -0400
Message-Id: <1127154409.29404.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-19 at 13:16 -0400, Ivan Gyurdiev wrote:
> Well, perhaps I should make an effort to generate errors in a different 
> pattern, so the end result is more user friendly (possibly pass down 
> more information to the leaf, so it can generate a single error report).

I think your later idea is better (passing up just error code from the
low level primitives, constructing the single error report in the higher
level).
 
> Yes, you would still need the state object at the leaf node. 
> Alternatively you could make use of more informative error codes in the 
> leaf node, and print errors higher up. You need the state object at the 
> point where the error is printed.

Yes, this approach seems preferable.  Then the call chain info can
become just debug-level info, and omitted from error reports to users /
clients.

> I think if we should wrap policydb into this so-called "state object" 
> for the added benefit of eliminating the global policydb.

As long as you can separately create the policydb, populate it, and
associate it with these state objects, so that the program can still use
a single shared policydb if desired, this is fine.  Userspace security
server shouldn't have a per-thread policydb any more than the kernel
security server does.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
