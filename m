Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4P1xLI4002445
	for <selinux@tycho.nsa.gov>; Sat, 24 May 2003 21:59:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4P1xKtV023113
	for <selinux@tycho.nsa.gov>; Sun, 25 May 2003 01:59:20 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4P1xHal023110 for <selinux@tycho.nsa.gov>; Sun, 25 May 2003 01:59:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: some policy patches
Date: Sun, 25 May 2003 11:57:16 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <20030524180730.C8251@lemuria.org> <200305250355.11583.russell@coker.com.au> <20030524231554.C8955@lemuria.org>
In-Reply-To: <20030524231554.C8955@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305251157.16430.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 25 May 2003 07:16, Tom wrote:
> > Bad.  XDM is not something that you want to allow reading all kernel
> > memory. It should use /dev/random instead if you block /dev/mem.
>
> It actually accesses /dev/mem, not /dev/kmem. Shouldn't /dev/kmem have
> its own type?

Why?  Physical RAM and kernel virtual memory are equally dangerous and give 
access to the same stuff.

> > > +# but xdm_xserver wants to write, too
> > > +allow xdm_xserver_t memory_device_t:chr_file { read write };
> >
> > That is only if you are not using the frame-buffer.  See the below
> > snippet from macros/program/xserver_macros.te (which is where you want to
> > do this if you want to support "startx" as well as an xdm).
>
> The framebuffer support for sis chipsets is, to put it friendly,
> slightly buggy. I have not yet found a way to use it in any reasonable
> way on this machine. (it works, but it's not useable)

In that case you have to change the xserver_macros.te accordingly.  I don't 
think that should be the default however, people who are using the 
frame-buffer should be able to grant their X server minimal access.

> > This is bad in several ways.  Firstly it's probably good style to use
> > domain_trans() for such things, then people who read your policy can find
> > what they expect to fine.  Secondly, why is an xdm_exec_t program being
> > used?
>
> wdm has several startup files in /etc/X11/wdm/ - I've labelled them
> xdm_exec_t. Should they get their own type? They are, for all I can
> see, executed after the domain transition has taken place.

What about xsession_exec_t?

> Absolutely. My goal was to get a working policy and a working graphical
> login. I've done that.

That's a great start!  Now we just have to work out which types of access are 
really enabled, which aren't needed, which can be avoided by correct 
configuration, and which require changes to the applications.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
