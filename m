Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5PK1HgA015143
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 16:01:17 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5PK13N4029436
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 20:01:04 GMT
Message-ID: <42BDB86A.5050502@redhat.com>
Date: Sat, 25 Jun 2005 16:02:50 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: Alternative user management approach
References: <20050624225217.97028.qmail@web31614.mail.mud.yahoo.com> <42BD31CE.9090908@redhat.com> <42BD7A43.909@tresys.com>
In-Reply-To: <42BD7A43.909@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:

> Daniel J Walsh wrote:
>
>> Ok this all sounds good, but how do we come to a consensus.
>> Do we need an "role attribute" to define "user" roles.
>>
>> roleattribute staff_r user;
>> roleattribute user_r user;
>> roleattribute sysadm_r user;
>>
>> Then do we need a mechanism in policy to associate roles with "user" 
>> roles?
>
>
> no language changes are necessary
>
>> How does all this work with MLS ranges?
>>
>> Should we have a brainstorming session?  It is important to us (Red 
>> Hat) that we get this settled soon.
>>
>> Do we have a new file which associates uids to user roles?
>>
> yes, from the policy language and kernel perspectives there need not 
> be any changes, basically instead of creating specific users:
>
> user jbrindle { staff_r sysadm_r }
>
> you create generic users:
>
> user admin { staff_r sysadm_r }
> user user_u { user_r }
>
> and then associate linux logins (or groups!) with those generic users: 
> (libselinux will read this file instead of using the implicit login 
> name -> selinux name mapping)
>
> group:wheel   admin
> default            user_u
>
> MLS would work the same way, the only difference being that you may 
> need more generic users to sufficiently cover all the role + level 
> combinations you need.
>
> To make this backend independant the same mapping info could be 
> sitting in ldap or some other database.
>
> The biggest challenge after this is labeling, how to label home 
> directories (Probably should only be done at useradd time, or when you 
> log into a computer the first time with LDAP, the utilities will have 
> to be a bit smarter about labeling)
>
> Joshua Brindle
>
Ok what does a third party vendor then do.  Say they create a role of 
nurse_r, doctor_r, labtech_r?

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
