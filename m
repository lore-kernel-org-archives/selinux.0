Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8PEKksJ024266
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 10:20:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8PEJ0Zv024907
	for <selinux@tycho.nsa.gov>; Thu, 25 Sep 2003 14:19:01 GMT
Date: Thu, 25 Sep 2003 15:20:42 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, Dale Amon <amon@vnl.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ssh policy hassles
Message-ID: <20030925142042.GA10225@vnl.com>
References: <20030923150926.GG21997@vnl.com> <20030925104456.GD10234@vnl.com> <20030925121733.GF10234@vnl.com> <200309252221.09162.russell@coker.com.au> <1064494538.5099.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1064494538.5099.7.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 25, 2003 at 08:55:38AM -0400, Stephen Smalley wrote:
> There is a security label that is internally maintained by the kernel
> and used for access controls, but it isn't exported to userspace via an
> xattr handler.  We created an xattr handler for the devpts file inodes
> to support relabeling by sshd and similar programs, but there is no such
> requirement for the devpts root inode.  They have different inode
> operation vectors, and we only patched the one used for the files.  The
> root inode uses the simple_dir_inode_operations provided by libfs, which
> only implements a lookup method, and we chose not to fork a separate
> operations vector for it.

Then I guess I'm at a brick wall for the moment. No idea what else
to look at. Perhaps its time for a late lunch break :-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
