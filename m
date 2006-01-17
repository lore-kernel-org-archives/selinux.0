Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0H5SlXf028517
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 00:28:47 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0H5SjRq014980
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 05:28:45 GMT
Message-ID: <43CC8040.1060704@tresys.com>
Date: Tue, 17 Jan 2006 00:27:28 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why are we managing seusers file via libsemanage?
References: <43CC6953.4060901@redhat.com>
In-Reply-To: <43CC6953.4060901@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> I don't recall why we did this?
> 
> I am now thinking this is not a good idea.  People were told to edit the 
> /etc/selinux/POLICYTYPE/seusers file to change the default level at 
> login, now we do this via libsemanage.  But doing this via libsemanage 
> eliminates us from being able to distribute this information via say LDAP.
> 
so that there could be a system + local (combined at commit time) iirc.

the database design of libsemanage should be conducive to distributing 
this info with LDAP and still adding it to the policy at commit time. 
Ivan made the database implementation fairly flexible about changing the 
storage backend while still pulling the data in and using it to rebuild 
policies.

> I think that seusers and setrans.conf should be left as flat files and 
> allowed to be distributed via ldap.  We can allow the semanage tool and 
> others to modify them and verify the data entry, but not manage them via 
> the library.
> 

I'd rather a central point for SELinux management. Also, if not through 
libsemanage the seuser file couldn't be managed through the policy 
server. Further, libsemanage gives the ability to sanity check the input 
  against the policy for error checking at modify time. This should 
potentially cut down on bugs caused by modifying this by hand.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
