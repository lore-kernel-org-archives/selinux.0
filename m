Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79JrGrT028194
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 15:53:16 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i79JrFIn007417
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 19:53:15 GMT
Subject: Re: different selinux file-context root
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040809195721.GP3868@lkcl.net>
References: <20040809195721.GP3868@lkcl.net>
Content-Type: text/plain
Message-Id: <1092081142.29199.194.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 09 Aug 2004 15:52:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-09 at 15:57, Luke Kenneth Casson Leighton wrote:
> i'm thinking of doing installs of selinux systems and online
> backups/restores from an initial ramdisk.
> 
> e.g. modifying rsync to cope with selinux file contexts.
> 
> e.g. there are several backup programs that create bootable CDs, that
> then redo the entire system.
> 
> what would make sense is for rsync, star etc. to have a context-"chroot"
> under which the selinux file contexts get recreated relative to that
> directory as the root filesystem.
> 
> then i don't have to mess about ensuring that the entire filesystem
> is correctly there and then doing something like this:
> 
> 	chroot /mnt-point make -C /etc/selinux/src relabel

setfiles has a -r rootpath option (contributed by the Gentoo folks) that
causes it to strip the specified rootpath prior to matching against
file_contexts.  Or, if using matchpathcon() directly, you can always
have the caller strip the rootpath itself prior to invoking
matchpathcon().

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
