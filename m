Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h987KvWt017357
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 03:20:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h987Kt0p006071
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 07:20:55 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h987Kqr7006068
	for <selinux@tycho.nsa.gov>; Wed, 8 Oct 2003 07:20:54 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: mag@bunuel.tii.matav.hu (=?iso-8859-2?q?Magos=E1nyi?= =?iso-8859-2?q?=20=C1rp=E1d?=)
Subject: Re: [selinux] init
Date: Wed, 8 Oct 2003 17:20:39 +1000
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
References: <200310080111.50210.russell@coker.com.au> <200310081424.19249.russell@coker.com.au> <20031008064149.GA22314@bunuel.tii.matav.hu>
In-Reply-To: <20031008064149.GA22314@bunuel.tii.matav.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200310081720.39268.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Oct 2003 16:41, Magosányi Árpád wrote:
> A levelezõm azt hiszi, hogy Russell Coker a következõeket írta:
> > On Wed, 8 Oct 2003 06:27, Magosányi Árpád wrote:
> > > I would vote for 5 being
> > > < 5) if policy isn't loaded and we don't have [some indication that we
> > > do not insist on selinux], halt the system with an appropriate message.
> > >
> > > The indication could be that there is no selinux support in the kernel,
> > > or some boot option.
> >
> > Currently we have been working towards making a SE Linux system be usable
> > if booted with a non-SE kernel.  We could have a compile option to do
> > what you
>
> This is the very reason I proposed checking selinux support in the kernel.
> What you have proposed is a fail-open solution. The theoretically
> correct solution would be fail-safe. A good compromise would be to
> assume if theadministrator boots a non-se kernel or gives a special
> boot option, then she knows what she does.

OK, it seems that I didn't understand your initial request.  What you want is 
for a system that is designed to be running SE Linux to refuse to boot if the 
policy can not be loaded (IE the file is corrupt).  But if the kernel is a 
non-SE kernel (or has the boot option to not enable SE Linux) then it will 
continue in the non-SE manner.

This makes sense.

Steve and James, please advise me on how I should determine the difference 
between a kernel where we don't desire/support SE Linux and a kernel that 
should have SE Linux but has encountered some error.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
