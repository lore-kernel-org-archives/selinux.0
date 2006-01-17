Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0H5YlXf028570
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 00:34:47 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0H5XdP2025678
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 05:33:40 GMT
Message-ID: <43CC81C2.5010104@tresys.com>
Date: Tue, 17 Jan 2006 00:33:54 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why are we managing seusers file via libsemanage?
References: <43CC6953.4060901@redhat.com> <43CC8040.1060704@tresys.com>
In-Reply-To: <43CC8040.1060704@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Daniel J Walsh wrote:
> 
>> I don't recall why we did this?
>>
>> I am now thinking this is not a good idea.  People were told to edit 
>> the /etc/selinux/POLICYTYPE/seusers file to change the default level 
>> at login, now we do this via libsemanage.  But doing this via 
>> libsemanage eliminates us from being able to distribute this 
>> information via say LDAP.
>>
> so that there could be a system + local (combined at commit time) iirc.
> 
> the database design of libsemanage should be conducive to distributing 
> this info with LDAP and still adding it to the policy at commit time. 
> Ivan made the database implementation fairly flexible about changing the 
> storage backend while still pulling the data in and using it to rebuild 
> policies.
> 
>> I think that seusers and setrans.conf should be left as flat files and 
>> allowed to be distributed via ldap.  We can allow the semanage tool 
>> and others to modify them and verify the data entry, but not manage 
>> them via the library.
>>
> 
> I'd rather a central point for SELinux management. Also, if not through 
> libsemanage the seuser file couldn't be managed through the policy 
> server. Further, libsemanage gives the ability to sanity check the input 
>  against the policy for error checking at modify time. This should 
> potentially cut down on bugs caused by modifying this by hand.
> 

To clarify: The library needs to do the validation no matter what. The 
policy isn't exposed to any userland tools so semanage can't do checking 
itself. So whether the semanage tool writes the file or libsemanage 
writes the file the library does validation, I don't see a compelling 
reason to push this parsing/writing code to the client.

I'd like the policy server to be capable of enforcing access on this 
file or else all the policy access controls are for naught, since the 
seuser file becomes an all-or-nothing point to give permissions to users.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
