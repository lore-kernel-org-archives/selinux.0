Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8BDIXLa015420
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 09:18:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8BDIVmw012887
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 13:18:31 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8BDIT9d012880 for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 13:18:30 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: rfs xattr's, mkinitrd and other stories
Date: Thu, 11 Sep 2003 23:18:15 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030910164854.GO5397@vnl.com> <200309111048.16590.russell@coker.com.au> <1063280832.16884.9.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1063280832.16884.9.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309112318.15845.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 11 Sep 2003 21:47, Stephen Smalley wrote:
> On Wed, 2003-09-10 at 20:48, Russell Coker wrote:
> > none                    /selinux                selinuxfs       noauto  0
> > 0
>
> Why noauto?  It needs to be mounted if you are running SELinux, and it
> will just fail with a warning if the kernel doesn't have SELinux
> enabled.

When booting without an initrd I have to mount it before init is run.  This 
means that I have two options, "mount -n" or mounting the root fs rw to allow 
writing to /etc/mtab and then umounting it again (for a possible fsck).  
However if the file system is inconsistent then this would be a bad idea, so 
"mount -n" seems the only option for a non-initrd system.

Using "mount -n" means that "mount -a" will try to mount it again if it is set 
for auto-mount, so "noauto" solves this (as long as there is an explicit 
mount command).

> > A special file system for SE Linux related entries.  I can't understand
> > why it wasn't just made part of /proc, Steve, perhaps you could explain.
>
> Misuse of /proc isn't viewed favorably by the kernel developers.  The
> preferred approach is to create your own pseudo filesystem type.
> selinuxfs was based on the nfsd pseudo filesystem in 2.5/6.

So instead of having a dozen different sub-directories of /proc we'll have a 
dozen different file systems to be individually mounted, umounted, and 
tracked.  This does not seem to be a benefit to me.  Of course my opinion 
counts for nothing in this debate even though I'm the one that'll do much of 
the user-space work of supporting this.  :(

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
