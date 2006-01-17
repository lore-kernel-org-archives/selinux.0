Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0HI2RXf006370
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 13:02:27 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0HI2PRq000029
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 18:02:25 GMT
Message-ID: <43CD3129.6060405@redhat.com>
Date: Tue, 17 Jan 2006 13:02:17 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why are we managing seusers file via libsemanage?
References: <43CC6953.4060901@redhat.com> <43CCA359.8030109@cornell.edu>
In-Reply-To: <43CCA359.8030109@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Daniel J Walsh wrote:
>> I don't recall why we did this?
>>
>> I am now thinking this is not a good idea.  People were told to edit 
>> the /etc/selinux/POLICYTYPE/seusers file to change the default level 
>> at login, now we do this via libsemanage.  But doing this via 
>> libsemanage eliminates us from being able to distribute this 
>> information via say LDAP.
> I think the issue of management and of distribution are completely 
> independent from each other (or if not, they should be made so). 
> Distribution gets the data from A to B. Management interprets the 
> data, and decides what to do with it.
>
> I don't understand the way Unix updates the password for example - it 
> doesn't make sense to me, I would appreciate an explanation from 
> someone who knows better. It provides a shared read interface on the 
> passwd file (with backend switching via nss). It doesn't provide a 
> shared write interface - why? That seems to me like a design mistake, 
> where distribution/backend is tied to management. Why should I care 
> where the password is kept if all I want to do is update it. I don't 
> think we should replicate that behavior, and copy the read/write code 
> in 10 places, like it's done for passwd - not until it's clear why 
> this is the correct way to go.
>
>
Ok well the seusers file should indicate that it is machine generated 
and should not be edited then, or can it be eliminated all together.  
Users will edit this file...

We still need a mechanism for managing setrans.conf but I understand why 
that is separate from libsemanage currently.  I also think we need to 
look into a  semachine type interface that indicates that maximum 
security level for a particular machine.


Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
