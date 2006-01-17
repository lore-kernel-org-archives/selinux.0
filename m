Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0H8AbXf029631
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 03:10:37 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0H8AZRq000768
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 08:10:35 GMT
Message-ID: <43CCA675.3000508@cornell.edu>
Date: Tue, 17 Jan 2006 01:10:29 -0700
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Why are we managing seusers file via libsemanage?
References: <43CC6953.4060901@redhat.com> <43CC8040.1060704@tresys.com> <43CC81C2.5010104@tresys.com> <43CC9E6D.9090509@cornell.edu>
In-Reply-To: <43CC9E6D.9090509@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>>
>> To clarify: The library needs to do the validation no matter what. 
>> The policy isn't exposed to any userland tools so semanage can't do 
>> checking itself. 
>
> Not entirely true - the client could query the necessary information 
> via semanage, and do validation itself. You can take the entire 
> seuser_validate function, take it out of semanage, change it a little 
> bit, and put put in a transaction, and it would work just fine.
>
Well, allright... that used to be true before I put in the MLS checks. 
Now seuser validation would require a backend-neutral way to check mls 
dominance and mls validity, which libsemanage does not provide at the 
current time (we could add it, but it doesn't exist right now, client 
has to assume direct backend, no policy server).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
