Message-Id: <200502180253.j1I2rl8R004666@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Subject: RE: sepol_genusers
Date: Thu, 17 Feb 2005 21:53:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <42152EAB.8090600@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Any reason this shouldn't generate a new policy that is saved to disc? How are
the booleans handled when the config file is corrupt? Also, there doesn't seem
to be a security reason not to continue the boot with the missing users.

Karl

---
Karl MacMillan
Tresys Technology
http://www.tresys.com
(410) 290-1411 ext 134  

> -----Original Message-----
> From: Daniel J Walsh [mailto:dwalsh@redhat.com] 
> Sent: Thursday, February 17, 2005 6:54 PM
> To: Stephen Smalley
> Cc: selinux@tycho.nsa.gov; Karl MacMillan
> Subject: Re: sepol_genusers
> 
> Ok I have a version of init with the genusers stuff in it.  I 
> am not sure of the way we should react to errors though.
> 
> What should init do if local.users is missing?  Has bad data 
> in it?  My current patch panics the kernel and I don't think that
> is a great idea.   IE the user screws up the local.users file and we 
> can't boot.
> 
> Dan
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
