Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6ECXGHa011851
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 08:33:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6ECWGnJ000604
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:32:16 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6ECWFhr000601
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2003 12:32:15 GMT
Subject: Re: enforcement and initrds
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1058151822.9620.25.camel@columbia>
References: <1058151822.9620.25.camel@columbia>
Content-Type: text/plain
Message-Id: <1058185993.13738.597.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Jul 2003 08:33:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-07-13 at 23:03, Colin Walters wrote:
> Hi,
> 
> I'm having trouble booting up my SE 2.5 system in enforcing mode,
> because my initrd (which uses ramfs) is completely unlabelled (because
> ramfs doesn't support xattrs).  
> 
> When I add enforcing=1 to the Linux command line, it therefore dies
> almost immediately upon bootup.  Perhaps it would be better to have the
> kernel not do anything with the enforcing=1 commandline, but instead
> have special code on the initrd to look at /proc/cmdline and if
> necessary set enforcing mode right before booting init?

If CONFIG_SECURITY_SELINUX_DEVELOP=n, then the kernel is always in
enforcing mode, so you won't be able to defer setting enforcing mode to
the initrd.  You can assign a single type to all of the ramfs entries
via genfs_contexts (but nothing more granular without further support
either in the ramfs code or in the SELinux module) and then grant
permissions to it.  Or you can grant permissions to unlabeled_t to
permit booting.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
