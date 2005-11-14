Message-ID: <4379179A.3090501@cornell.edu>
Date: Mon, 14 Nov 2005 18:02:50 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Chad Sellers <csellers@tresys.com>
CC: "'Daniel J Walsh'" <dwalsh@redhat.com>, selinux-dev@tresys.com,
   Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] move genhomedircon call out of transaction
References: <200511141709.43445.csellers@tresys.com>
In-Reply-To: <200511141709.43445.csellers@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Sellers wrote:
> Attached is a patch that moves the genhomedircon patch out of the libsemanage 
> transaction.  This is necessary since genhomedircon now uses libsemanage, and 
> enters a transaction itself.
>   
I don't think genhomedircon enters a transaction... nor should it - it's 
a read-only operation with respect to the objects that we manage 
(currently). I could be wrong, but I can't find where it enters a 
transaction in the patch.

Also, even if it did enter transaction, exiting and re-entering 
"immediatly" would create a race condition.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
