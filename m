Message-ID: <42152EAB.8090600@redhat.com>
Date: Thu, 17 Feb 2005 18:54:19 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: sepol_genusers
References: <1108656216.24494.65.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1108656216.24494.65.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok I have a version of init with the genusers stuff in it.  I am not 
sure of the way we should react to errors though.

What should init do if local.users is missing?  Has bad data in it?  My 
current patch panics the kernel and I don't think that
is a great idea.   IE the user screws up the local.users file and we 
can't boot.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
