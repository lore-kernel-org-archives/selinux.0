Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3LFisI4020818
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 11:44:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3LFir7R005049
	for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 15:44:53 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h3LFinKP005025 for <selinux@tycho.nsa.gov>; Mon, 21 Apr 2003 15:44:50 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Joshua Brindle" <JBrindle@snu.edu>, <selinux@tycho.nsa.gov>
Subject: Re: SELinux ISO...
Date: Tue, 22 Apr 2003 01:44:37 +1000
References: <sea3c1c6.012@atlas.snu.edu>
In-Reply-To: <sea3c1c6.012@atlas.snu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304220144.37792.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 22 Apr 2003 01:02, Joshua Brindle wrote:
> won't the filesystem already be labeled? i don't understand the need
> for an initrd.

Previously the policy needed to be loaded on the initrd for best operation.  
Since then things have changed, but there is still some conveniant support 
for having a small policy and then boot-strapping something bigger.

You can set things up without needing an initrd if you are compiling a kernel 
for exactly the hardware you are using.

> We are looking at some logistical issues now. First we need a good way
> of transporting policies. Portage does all the package downloads itself,
> and limited files can be stored directly in portage, we are looking into
> distributing application specific policies with the accompanying
> application rather than having a giant policy package with everything
> possible.

Yes, I've been dealing with the same issue for Debian.  So far I have decided 
not to bundle policy with application packages.

> Second, we are looking into labeling files before they are installed to
> the live filesystem and then moving them while preserving permissions.
> One thing we have discussed (and will probably be working on soon) is
> adding an argument to setfiles to tell it where to pretend the root is.

I've been thinking about the same things for installation purposes.

Also I've been thinking of making the core setfiles code into a shared object 
so it can be easily called from other applications in a manner similar to the 
"setfiles -s" mode of operation (IE labelling individual files not entire 
filesystems).  Then I would add a way of specifying both the file name and 
the name it is installed on the file system.

So installing a new file can have the following proceedure:
1)  Create /bin/bash.tmp .
2)  Tell setfiles to label /bin/bash.tmp as /bin/bash would be labeled.
3)  Rename it to the correct name.

> Portage compiles and installes apps in a separate part of the
> filesystem (/var/tmp/portage/app-ver/) to be exact, and then installs
> everything to /var/tmp/portage/app-ver/image and gets a manifest of the
> package contents for use later when upgrading or removing. Our idea is
> to label all the files in /var/tmp/portage/app-ver/image/ as if they
> were on / using the base-policy and the application specific policy and
> then move them to the live filesystem while preserving permissions.

Of course a statically linked setfiles that could be hard-linked to 
/var/tmp/portage/app-ver before being run in a chroot() setup could do well.

For copying files the only special thing you have to do is to use "cp -a" and 
use the SE Linux modified coreutils.


PS  When you get this done you should run a SE Linux play machine.  At FOSDEM 
people couldn't get to the Gentoo stand for most of the show because of the 
crowd at the Debian stand looking at the SE play machine.  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
