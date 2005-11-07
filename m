Message-ID: <436F7F36.5080308@cornell.edu>
Date: Mon, 07 Nov 2005 11:22:14 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [ SEMANAGE ] Cleanup : move some things around
References: <436DDB51.2080903@cornell.edu> <1131377599.20591.32.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131377599.20591.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> I'd prefer to hold cleanups until we have stabilized the functionality
> and interfaces as desired for test1.  I'm also not clear on why we want
> a sepol handle in the ps case.  
>   
.. because we'll be using the sepol records either way, so we need the 
sepol handle..
Not using the sepol records requires copying them over into libsemanage.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
