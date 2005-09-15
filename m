Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <4329235B.6030109@cornell.edu>
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
	 <432888C8.3090700@cornell.edu>  <4329235B.6030109@cornell.edu>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 09:01:18 -0400
Message-Id: <1126789278.10727.64.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-15 at 03:31 -0400, Ivan Gyurdiev wrote:
> So, if you deprecate the shared sepol_gen*, you're left 
> with...sepol_check_context (which makes use of sepol_context_to_sid, and 
> sepol_ctx_*)... and also sepol_set_policydb_from_file (which I think 
> should also be deprecated, along with the global policydb).

BTW, keep in mind that most programs that want to check context validity
are going to use security_check_context() from libselinux, which has no
threading issues.  It is only specialized cases where you specifically
want to check against a binary policy rather than the active kernel
policy that you need the libsepol functions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
