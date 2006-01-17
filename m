Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0H7H4Xf029233
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 02:17:04 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0H7H2Rq025549
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 07:17:02 GMT
Message-ID: <43CC99DF.40508@cornell.edu>
Date: Tue, 17 Jan 2006 00:16:47 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why are we managing seusers file via libsemanage?
References: <43CC6953.4060901@redhat.com> <43CC8040.1060704@tresys.com>
In-Reply-To: <43CC8040.1060704@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>> I don't recall why we did this?
>>
>> I am now thinking this is not a good idea.  People were told to edit 
>> the /etc/selinux/POLICYTYPE/seusers file to change the default level 
>> at login, now we do this via libsemanage.  But doing this via 
>> libsemanage eliminates us from being able to distribute this 
>> information via say LDAP.
>>
> so that there could be a system + local (combined at commit time) iirc.
Actually that's a bad example for seusers, which are the one case where 
there is no system + local currently...
>
> the database design of libsemanage should be conducive to distributing 
> this info with LDAP and still adding it to the policy at commit time. 
> Ivan made the database implementation fairly flexible about changing 
> the storage backend while still pulling the data in and using it to 
> rebuild policies.
Yes, hopefully we should be able to write an LDAP backend for this data 
model.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
