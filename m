From: Faye Coker <faye@lurking-grue.org>
Reply-To: faye@lurking-grue.org
To: =?iso-8859-2?q?Magos=E1nyi=20=C1rp=E1d?= <mag@bunuel.tii.matav.hu>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: dumb auditdeny question
Date: Wed, 11 Feb 2004 23:31:42 +1100
References: <1076486595.2415.134.camel@kusturica>
In-Reply-To: <1076486595.2415.134.camel@kusturica>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200402112331.42106.faye@lurking-grue.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Feb 2004 19:03, Magosányi Árpád wrote:

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
> What did I do wrong?

Change the "auditdeny" to "dontaudit".

What you are saying with the auditdeny line is "audit a denial of these 
operations" { ioctl, append, rename, create }.  dontaudit means don't audit 
what you have listed.

Use of auditdeny tends to cause confusion, so use dontaudit instead  :)


faye

-- 
Faye Coker
faye@lurking-grue.org



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
