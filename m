Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h47J3xI4011920
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 15:03:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h47J3w7R020465
	for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 19:03:58 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h47J3vKP020460 for <selinux@tycho.nsa.gov>; Wed, 7 May 2003 19:03:57 GMT
Subject: Re: /dev/pts/* denials w/devfs
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Christopher J. PeBenito" <pebenito@ieee.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1052326645.13937.23.camel@chris.pebenito.net>
References: <1052326645.13937.23.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1052334230.1044.104.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 07 May 2003 15:03:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-05-07 at 12:57, Christopher J. PeBenito wrote:
> I'm trying to integrate SELinux with Gentoo
> (http://www.gentoo.org/proj/en/hardened/), however I'm encountering some
> problems.  The problem surrounds /dev/pts/* denials.  Gentoo uses devfs,
> so I have a feeling that it might be causing some problems.  For
> example, the following are the denials I get when logging in via ssh. 
> The ssh.te is still the stock from selinux-small, and openssh is
> patched.  I also have the devfsd-se.so devfsd module running. 
> Suggestions?

The devfs kernel code really needs to be patched to work properly with
SELinux; your pty problem is just a small part of the problem.  Note
that in 2.4, we have to patch devpts for it to properly set up the
inode's security label; in 2.5, this is handled without patching because
devpts_pty_new now calls d_instantiate, so we can set up the security
label in the usual manner via the d_instantiate hook.  You could patch
the devfs code similarly, but there isn't much point in doing so, as
unix98 pty support has been removed from devfs in 2.5, so everyone needs
to start using devpts anyway if they want unix98 ptys.  A more serious
problem with using devfs with SELinux is preserving security labels on
devfs entries when they are evicted from the dcache; if you don't patch
devfs to preserve the security information, devfs entries will "lose"
any security label when the entry is evicted.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
