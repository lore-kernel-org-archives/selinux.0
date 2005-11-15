Message-ID: <43795DEC.6080506@cornell.edu>
Date: Mon, 14 Nov 2005 23:02:52 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Chad Sellers <csellers@tresys.com>, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   selinux-dev@tresys.com, Stephen Smalley <sds@tycho.nsa.gov>,
   selinux@tycho.nsa.gov
Subject: Re: [PATCH] move genhomedircon call out of transaction
References: <BF9E9FD2.8085%csellers@tresys.com> <4379548D.3010801@cornell.edu>
In-Reply-To: <4379548D.3010801@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
> On the other hand, genhomedir called outside libsemanage has a race in 
> itself, because changes can be introduced between the time you call 
> user_list, and seuser_list. It seems you're moving the place it's 
> called to the end of install_sandbox (hard to tell without -p flag), 
> so if it's called within libsemanage, that won't be a problem (active 
> lock released, transaction lock still held, concurrent commit not 
> possible).

Really, genhomedircon should be using a transaction, which is both safer 
(avoids race), and faster (requires only 1 policydb_read, as opposed to 
2). However, I don't know how you'd call it within the original 
transaction...

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
