Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98IwLrT024501
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 14:58:21 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98IwKZ2016116
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 18:58:20 GMT
Subject: Re: fuse + setfilecon - need some userspace / libselinux1
	assistance
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041008183601.GR5551@lkcl.net>
References: <20040928140351.GA12119@lkcl.net>
	 <1097258612.16641.227.camel@moss-spartans.epoch.ncsc.mil>
	 <20041008183601.GR5551@lkcl.net>
Content-Type: text/plain
Message-Id: <1097261729.16641.299.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 08 Oct 2004 14:55:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-10-08 at 14:36, Luke Kenneth Casson Leighton wrote:
> the one outstanding question that _is_ still relevant is the
> one about security/selinux/hooks.c treating a vfs's "-512"
> error code response [please try later] as an error.
> 
> why, well just in case some other [more mainstream] filesystem
> e.g. a selinuxed version of nfs does the same sort of thing
> [responds to a vfs_xxxx() call or a vfs_getxattr() call with
> -512 and actually expects hooks.c _to_ try later]

You would have to either change d_instantiate() to return an error code
and fix all callers to check and propagate it upwards to where it can be
handled sanely in the usual manner, or move the inode security
initialization from d_instantiate to somewhere that already allows such
error propagation, e.g. iget() - but that has its own problems for lots
of filesystems.  I don't think you can handle it sanely within hooks.c
itself.  Use of d_instantiate for inode security initialization has
always been controversial, but no one has come up with a better
suggestion yet.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
