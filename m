Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9HEAAWt009388
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 10:10:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9HEA10p011162
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 14:10:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9HEA0r7011159
	for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2003 14:10:00 GMT
Subject: Re: Symlinks with wrong context after copy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20031017133207.GA5665@suse.de>
References: <20031017133207.GA5665@suse.de>
Content-Type: text/plain
Message-Id: <1066399798.31764.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 17 Oct 2003 10:09:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-17 at 09:32, Thorsten Kukuk wrote:
> Hi,
> 
> I don't know if this is a libattr or a selinux bug:
> 
> Symlinks have wrong attributes after copying:
> 
> dilbert:~ # ls --context /lib/ld-*
> -rwxr-xr-x  root     root     system_u:object_r:ld_so_t        /lib/ld-2.3.2.so
> lrwxrwxrwx  root     root     system_u:object_r:ld_so_t        /lib/ld-linux.so.2 -> ld-2.3.2.so
> 
> dilbert:~ # cp -dp /lib/ld-* .
> dilbert:~ # ls --context ld-*
> -rwxr-xr-x  root     root     system_u:object_r:ld_so_t        ld-2.3.2.so
> lrwxrwxrwx  root     root     system_u:object_r:sysadm_home_dir_t ld-linux.so.2 -> ld-2.3.2.so
> 
> any ideas what goes wrong?

The implication is that the attributes on the copied symlink weren't
explicitly set, so they were instead left with the default (inheriting
from the parent directory, unless otherwise configured by policy).
Are you using the SELinux coreutils patch or the EA coreutils patch?  
Also, IIRC, there was a specific decision in the SELinux coreutils patch
to not include the SELinux attributes as part of -p; you have to
explicitly specify -c or --preserve=all or --preserve=context. 
Otherwise, a number of programs that use -p will break because they
aren't authorized to preserve the MAC security label.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
