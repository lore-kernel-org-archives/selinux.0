Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8PCtisJ023694
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 08:55:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8PCs0Zt017307
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 12:54:00 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8PCs0M3017304
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 12:54:00 GMT
Subject: Re: ssh policy hassles
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200309252221.09162.russell@coker.com.au>
References: <20030923150926.GG21997@vnl.com>
	 <20030925104456.GD10234@vnl.com> <20030925121733.GF10234@vnl.com>
	 <200309252221.09162.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1064494538.5099.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 25 Sep 2003 08:55:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-09-25 at 08:21, Russell Coker wrote:
> > Okay, I find this, which doesn't seem right:
> >
> > drwxr-xr-x  root     root     (null)                           /dev/pts
> 
> It doesn't seem right, but it apparently is.  On my 2.4.21 SE2 system it has 
> no label on /dev/pts and sshd works perfectly.

There is a security label that is internally maintained by the kernel
and used for access controls, but it isn't exported to userspace via an
xattr handler.  We created an xattr handler for the devpts file inodes
to support relabeling by sshd and similar programs, but there is no such
requirement for the devpts root inode.  They have different inode
operation vectors, and we only patched the one used for the files.  The
root inode uses the simple_dir_inode_operations provided by libfs, which
only implements a lookup method, and we chose not to fork a separate
operations vector for it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
