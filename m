Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0I33IXf012289
	for <selinux@tycho.nsa.gov>; Tue, 17 Jan 2006 22:03:19 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0I327P2018852
	for <selinux@tycho.nsa.gov>; Wed, 18 Jan 2006 03:02:08 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH] sereference: enable local login
Date: Wed, 18 Jan 2006 14:01:56 +1100
Cc: SELinux <selinux@tycho.nsa.gov>
References: <20060111213646.GA30428@sergelap.austin.ibm.com> <200601171908.04196.russell@coker.com.au> <20060117125706.GC20632@sergelap.austin.ibm.com>
In-Reply-To: <20060117125706.GC20632@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601181403.04005.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 17 January 2006 23:57, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > > @@ -14,6 +15,7 @@
> > >  /dev/rfcomm[0-9]+	-c	gen_context(system_u:object_r:tty_device_t,s0)
> > >  /dev/tty		-c	gen_context(system_u:object_r:devtty_t,s0)
> > >  /dev/ttySG.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
> > > +/dev/tts/[0-9]		-c	gen_context(system_u:object_r:tty_device_t,s0)
> > >
> > >  /dev/pty/.*		-c	gen_context(system_u:object_r:bsdpty_device_t,s0)
> >
> > Is Gentoo still using devfs device names?  If so you might want to make
> > it work for more than 10 serial ports.
>
> (I'm using udev)  Makes no absolutely sense in hindsight, but I was
> erring on the 'safe' side.  I almost picked [0-4]  :)

udev in Fedora doesn't use such names.  It seems that Gentoo has been 
configured to use devfs style names, so that would be a Gentoo specific 
thing.

> > Also Gentoo specific changes should have ifdef(`distro_gentoo' around
> > them.
>
> Ok - I didn't think these were distro specific, but if in fact gentoo's
> pam is patched differently, the authlogin.if patch would certainly be.
> Hopefully there's a better way to fix that problem though.

If Gentoo's PAM works differently in this regard then Gentoo's PAM has to be 
fixed.  This issue makes a significant difference to the attack vectors that 
can be used.  It's not a difficult code change to make either (apart from the 
issue of everything being painful in PAM).

As for the Gentoo specific device names, we could have things perfectly 
functional with all possible device names represented.  But I don't want to 
do that.  Firstly if a section of policy has ifdef(`distro_whatever' around 
it then a developer for that distribution can remove the section if their 
needs change and they don't need to consult with anyone else.  A significant 
problem we face is in getting unneeded policy removed due to the fear of 
breakage.  Something that has ifdef(`distro_gentoo' around it can be removed 
by any Gentoo developer without complaints from anyone who doesn't use 
Gentoo.  The next issue is that of understanding what the policy does.  At 
some future time someone will want to analyse the labels on device nodes and 
spurious entries will complicate that.  Finally every file contexts entry has 
a performance impact on setfiles/restorecon.  According to the last tests I 
performed /dev entries don't make much difference as there aren't that many 
device nodes on a system, but it's good to avoid needless delays anyway.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
