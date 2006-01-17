Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0H7vSXf029514
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 02:57:28 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0H7uLP2008964
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 07:56:21 GMT
Message-ID: <43CCA359.8030109@cornell.edu>
Date: Tue, 17 Jan 2006 00:57:13 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why are we managing seusers file via libsemanage?
References: <43CC6953.4060901@redhat.com>
In-Reply-To: <43CC6953.4060901@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> I don't recall why we did this?
>
> I am now thinking this is not a good idea.  People were told to edit 
> the /etc/selinux/POLICYTYPE/seusers file to change the default level 
> at login, now we do this via libsemanage.  But doing this via 
> libsemanage eliminates us from being able to distribute this 
> information via say LDAP.
I think the issue of management and of distribution are completely 
independent from each other (or if not, they should be made so). 
Distribution gets the data from A to B. Management interprets the data, 
and decides what to do with it.

I don't understand the way Unix updates the password for example - it 
doesn't make sense to me, I would appreciate an explanation from someone 
who knows better. It provides a shared read interface on the passwd file 
(with backend switching via nss). It doesn't provide a shared write 
interface - why? That seems to me like a design mistake, where 
distribution/backend is tied to management. Why should I care where the 
password is kept if all I want to do is update it. I don't think we 
should replicate that behavior, and copy the read/write code in 10 
places, like it's done for passwd - not until it's clear why this is the 
correct way to go.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
