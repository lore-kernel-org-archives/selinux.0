Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i96HV3rT006805
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 13:31:03 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i96HV2co024245
	for <selinux@tycho.nsa.gov>; Wed, 6 Oct 2004 17:31:02 GMT
Subject: Re: ReiserFS
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
In-Reply-To: <200409300512.44632.russell@coker.com.au>
References: <200409300512.44632.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1097083678.11370.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 06 Oct 2004 13:27:59 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-29 at 15:12, Russell Coker wrote:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=134111
> 
> We are having some discussions of ReiserFS in the Red Hat bugzilla.
> 
> fs_use_xattr reiserfs system_u:object_r:fs_t;
> 
> It seems to me that the easiest solution is to remove the above line from 
> fs_use and add the following to genfs_contexts:
> 
> genfscon reiserfs /                     system_u:object_r:nfs_t
> 
> The reason for this hack is that we already have the policy for home 
> directories on NFS.  ReiserFS will never work for a root FS and isn't worth 
> any more effort than this hack.

This seems reasonable, at least until someone chooses to pursue the
necessary patches to the reiserfs xattr support to allow proper
interaction with SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
