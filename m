Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5PFbsgA014169
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 11:37:54 -0400 (EDT)
Received: from rwcrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5PFb8s8020467
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 15:37:09 GMT
Message-ID: <42BD7A43.909@tresys.com>
Date: Sat, 25 Jun 2005 11:37:39 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Alternative user management approach
References: <20050624225217.97028.qmail@web31614.mail.mud.yahoo.com> <42BD31CE.9090908@redhat.com>
In-Reply-To: <42BD31CE.9090908@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:

> Ok this all sounds good, but how do we come to a consensus.
> Do we need an "role attribute" to define "user" roles.
>
> roleattribute staff_r user;
> roleattribute user_r user;
> roleattribute sysadm_r user;
>
> Then do we need a mechanism in policy to associate roles with "user" 
> roles?

no language changes are necessary

> How does all this work with MLS ranges?
>
> Should we have a brainstorming session?  It is important to us (Red 
> Hat) that we get this settled soon.
>
> Do we have a new file which associates uids to user roles?
>
yes, from the policy language and kernel perspectives there need not be 
any changes, basically instead of creating specific users:

user jbrindle { staff_r sysadm_r }

you create generic users:

user admin { staff_r sysadm_r }
user user_u { user_r }

and then associate linux logins (or groups!) with those generic users: 
(libselinux will read this file instead of using the implicit login name 
-> selinux name mapping)

group:wheel   admin
default            user_u

MLS would work the same way, the only difference being that you may need 
more generic users to sufficiently cover all the role + level 
combinations you need.

To make this backend independant the same mapping info could be sitting 
in ldap or some other database.

The biggest challenge after this is labeling, how to label home 
directories (Probably should only be done at useradd time, or when you 
log into a computer the first time with LDAP, the utilities will have to 
be a bit smarter about labeling)

Joshua Brindle


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
