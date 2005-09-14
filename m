Subject: Re: [ SEPOL ] Move more things to newer debug system
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, Joshua Brindle <jbrindle@tresys.com>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <20050914070022.GD1257@lkcl.net>
References: <43256F48.7060909@cornell.edu> <43258D48.80702@cornell.edu>
	 <43264DAD.5090903@cornell.edu>
	 <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil>
	 <4327521D.5020605@cornell.edu>
	 <1126652637.30915.18.camel@twoface.columbia.tresys.com>
	 <432799F0.7060706@cornell.edu>  <20050914070022.GD1257@lkcl.net>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 08:11:04 -0400
Message-Id: <1126699864.12299.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-09-14 at 08:00 +0100, Luke Kenneth Casson Leighton wrote:
>  given that there have now been at least three messages bouncing
>  back-and-forth indicating that there have been some quite
>  serious basic design mistakes (global variables, printfs for debug
>  reporting etc.), i thought it best to chip in.

Hi,

Point of clarification:  libsepol was originally just pulled out of the
checkpolicy program, so these characteristics reflect its origins as a
single monolithic program.   

>  design the library properly.

By all means, do things right going forward, but don't overengineer a
library that was only ever intended to share some implementation details
previously hidden within checkpolicy with some other users, and that is
going back toward being a static library only for a very small set of
users.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
