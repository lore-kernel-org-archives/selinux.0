Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HEFmWt009455
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 10:15:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9HEFd0p011549
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 14:15:39 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
	by jazzswing.ncsc.mil  with ESMTP id h9HEFcr7011546
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 14:15:38 GMT
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 31A42170E995
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 16:15:46 +0200 (CEST)
Date: Fri, 17 Oct 2003 16:17:01 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: selinux@tycho.nsa.gov
Subject: Re: Symlinks with wrong context after copy
Message-ID: <20031017141701.GA2002@suse.de>
References: <20031017133207.GA5665@suse.de> <1066399798.31764.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066399798.31764.132.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Oct 17, Stephen Smalley wrote:

> On Fri, 2003-10-17 at 09:32, Thorsten Kukuk wrote:
> > Hi,
> > 
> > I don't know if this is a libattr or a selinux bug:
> > 
> > Symlinks have wrong attributes after copying:
> > 
> > dilbert:~ # ls --context /lib/ld-*
> > -rwxr-xr-x  root     root     system_u:object_r:ld_so_t        /lib/ld-2.3.2.so
> > lrwxrwxrwx  root     root     system_u:object_r:ld_so_t        /lib/ld-linux.so.2 -> ld-2.3.2.so
> > 
> > dilbert:~ # cp -dp /lib/ld-* .
> > dilbert:~ # ls --context ld-*
> > -rwxr-xr-x  root     root     system_u:object_r:ld_so_t        ld-2.3.2.so
> > lrwxrwxrwx  root     root     system_u:object_r:sysadm_home_dir_t ld-linux.so.2 -> ld-2.3.2.so
> > 
> > any ideas what goes wrong?
> 
> The implication is that the attributes on the copied symlink weren't
> explicitly set, so they were instead left with the default (inheriting
> from the parent directory, unless otherwise configured by policy).

Yes, and the problem is, that somebody follows symlinks instead of
using the attributes of the symlinks itself. 

> Are you using the SELinux coreutils patch or the EA coreutils patch?  

I tried the SELinux coreutils patch on our own coreutils and the
RH binaries.

> Also, IIRC, there was a specific decision in the SELinux coreutils patch
> to not include the SELinux attributes as part of -p; you have to
> explicitly specify -c or --preserve=all or --preserve=context. 
> Otherwise, a number of programs that use -p will break because they
> aren't authorized to preserve the MAC security label.

But this doesn't matter: the binary itself is copied correct with
SElinux attributes, the symlink is not.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
