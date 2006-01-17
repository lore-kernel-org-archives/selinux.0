Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0H7aNXf029373
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 02:36:23 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0H7aLRq027549
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 07:36:21 GMT
Message-ID: <43CC9E6D.9090509@cornell.edu>
Date: Tue, 17 Jan 2006 00:36:13 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why are we managing seusers file via libsemanage?
References: <43CC6953.4060901@redhat.com> <43CC8040.1060704@tresys.com> <43CC81C2.5010104@tresys.com>
In-Reply-To: <43CC81C2.5010104@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
> To clarify: The library needs to do the validation no matter what. The 
> policy isn't exposed to any userland tools so semanage can't do 
> checking itself. 

Not entirely true - the client could query the necessary information via 
semanage, and do validation itself. You can take the entire 
seuser_validate function, take it out of semanage, change it a little 
bit, and put put in a transaction, and it would work just fine.

> So whether the semanage tool writes the file or libsemanage writes the 
> file the library does validation, I don't see a compelling reason to 
> push this parsing/writing code to the client.
My reasoning is - whether the info is stored in LDAP or not is an 
implementation detail. It should not affect the data model that we're 
working with. It makes sense to put seusers in libsemanage, because that 
allows management of all selinux-related things from a single shared 
library in a consistent interface, with shared transactions and 
validation. It's also a good point for integration with the policy server.

In other words, libsemanage should pull the data out of LDAP, hiding the 
implementation details. I'm not sure how it would do that exactly - 
dlopen another library, call outside tool, will have to look into that. 
I've tried to make the libsemanage part of it flexible, to deal with 
this issue eventually. However, I think libsemanage should be the 
management frontend. Letting the storage backend determine interface 
structure seems like the wrong approach - either the interface makes 
sense, or it doesn't - why should we change it, if the info is backed in 
LDAP?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
