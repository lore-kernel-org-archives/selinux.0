Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87CuXrT025988
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 08:56:33 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87CuXll008596
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 12:56:33 GMT
Subject: Re: SuSE 9.1 SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: stefano.zanarini@yacme.com, selinux@tycho.nsa.gov
In-Reply-To: <200409061316.i86DGhWU026428@mms-r00.iijmio.jp>
References: <1094456102.2213.3.camel@pignoletto.cantina.yacme>
	 <200409061316.i86DGhWU026428@mms-r00.iijmio.jp>
Content-Type: text/plain
Message-Id: <1094561676.15891.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 07 Sep 2004 08:54:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-09-06 at 09:16, Yuichi Nakamura wrote:
> Stephen Smalley said that there is a deadlock in reiserfs with SELinux.
> http://marc.theaimsgroup.com/?l=selinux&m=109422792406335&w=2
> 
> But I would like to know the detail of deadlock.
> Could someone tell me where is the deadlock or the condition that the deadlock happens??
> A Novell Japan person will report to Bugzilla.

There are two issues:
1) Deadlock in the reiserfs xattr code when reiserfs creates the xattr
directory or files since this leads to a reiserfs->SELinux->reiserfs
cycle upon the d_instantiate on the newly created inode (before said
inode is marked private by reiserfs).  Patch proposed on lkml:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108635056719373&w=2

2) Permission denial by SELinux when reiserfs internally tries to access
the xattr directory or files, as there is no security label on such
inodes.  Proposal for a new security hook so that reiserfs can tell
SELinux that these inodes are private and should not be mediated by
SELinux:
http://marc.theaimsgroup.com/?l=reiserfs&m=108747586800352&w=2
Proposal still requires an implementation of the hook for SELinux, but
that shouldn't be difficult if the hook itself is accepted.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
