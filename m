Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SN32rT011806
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 19:03:03 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SN20uK015034
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 23:02:00 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 8B481BF89
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 00:02:47 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CCRAY-0001ol-84
	for selinux@tycho.nsa.gov; Wed, 29 Sep 2004 00:14:02 +0100
Date: Wed, 29 Sep 2004 00:14:02 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: fuse and selinux
Message-ID: <20040928231402.GD6287@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ah... i hit a snag.

fuse always always always returns error code 512 which is
"-ERESTARTSYS".

i.e. "please try later".

i.e. the design of fuse is to be accessed via userspace.

uh-oh.

and on setup of the fuse fs [as a fs_t] security/selinux/hooks.c
goes "oh, an error message i can't cope with".

in fact it's worse than that because on _every_ getxattr()
call not just the one that tests whether xattr is supported
it gets a "please try later" response.

so:

option 1)

	turn selinux/hooks.c into a state machine, decoupled around the
	getxattr() calls, dealing correctly with the -ERESTARTSYS calls.

	somehow... i don't _quite_ think i'm ready to tackle this one!

option 2)

	copy the fuse module, trash all of the code that calls out to
	userspace... and merge the functionality of the fusexmp userspace
	example code into a new fsproxy module.

	this i _can_ cope with.

	wheee.

all because of some stupid bug in 2.6 ioctl blkrrdpart *grumble*
mount -l *grumble*.


the reason why i am mentioning all this is because:

has anyone come across any circumstances - e.g. an NFS or SMBFS
filesystem [with xattrs of course] - where -ERESTARTSYS would
become or might become an issue?

i understand that NFS has been modified to support selinux:
where there are delays in the mounting of the filesystem,
might such an error occur?

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
