Message-ID: <402A3505.2030809@tresys.com>
Date: Wed, 11 Feb 2004 08:58:29 -0500
From: David Caplan <dac@tresys.com>
MIME-Version: 1.0
To: =?ISO-8859-2?Q?Magos=E1nyi_=C1rp=E1d?= <mag@bunuel.tii.matav.hu>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: dumb auditdeny question
References: <1076486595.2415.134.camel@kusturica>
In-Reply-To: <1076486595.2415.134.camel@kusturica>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Magosányi Árpád wrote:
> Hi!
> 
> I wanted to get rid of the following message:
> 
>  avc:  denied  { create } for  pid=400 exe=/usr/bin/vim
> scontext=kernel_u:kernel_r:kernel_d tcontext=kernel_u:object_r:tcb_t
> tclass=file
> 
> so I have the following in my policy:
> 
> auditdeny kernel_d tcb_t:{ file lnk_file sock_file fifo_file chr_file }
>         { ioctl append rename create };
> 
> But I still get the message.
> 
> What did I do wrong?
> 

You want to use the "dontaudit" command.  Auditdeny says to generate a 
message only when permission was denied on the specified access.  So you 
probably want:

dontaudit kernel_d tcb_t:{ file lnk_file sock_file fifo_file chr_file } 
            { ioctl append rename create };

It's not a dumb question; the auditdeny keyword is confusing.  That's 
one reason the dontaudit syntax was introduced.  I believe in the base 
(NSA) policy there are no uses of auditdeny.

David

__________________________________

David Caplan     410 290 1411 x105
dac@tresys.com
Tresys Technology, LLC
8840 Stanford Blvd., Suite 2100
Columbia, MD 21045

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
