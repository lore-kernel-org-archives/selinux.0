Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i92INjrT009385
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 14:23:45 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i92IMdnE029523
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 18:22:39 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 8884EBFAC
	for <selinux@tycho.nsa.gov>; Sat,  2 Oct 2004 19:23:37 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CDoia-0001cj-RD
	for selinux@tycho.nsa.gov; Sat, 02 Oct 2004 19:34:52 +0100
Date: Sat, 2 Oct 2004 19:34:52 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: fuse + selinux
Message-ID: <20041002183452.GA5827@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

okay, i tried rewriting fuse + the fusexmp userspace program into a
kernel module called "fsproxy".  i got as far as doing everything but
moving the userspace-inode-allocation code into the kernel, and at
that point i tried examining how smbfs does pseudo-and-on-demand inode
creation, and it's all gone slightly pear-shaped.

fuse really doesn't do a good job of allocating inodes because
the code does the allocation in userspace instead of using a
dentry-to-inode thing what like it _should_ be doing.


so what i have gone back to is the original hacks to fuse... but adding
in-kernel redirection of any xattr calls to the same locations that the
fusexmp code does.

so what i have is a partial hacked combination of userspace +
kernelspace which i could really do without... but it works, it actually
works.

so, bearing that in mind, i have a question:

if i view an autofs-mount point /media through the real filesystem, it
shows up as (null) selinux permissions.

if i view the same mount mount through my modified-fuse system [which
is a bit like mount --rbind /Documents / only with a totally different
inode set] the same point - /Documents/media - shows up as unlabeled_t.

could the reason for that be that my code is, instead of showing the
filesystem that is mounted on /media, it's showing the _mountpoint_?

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
