Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82GoVrT000903
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 12:50:31 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82GoTv0016514
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 16:50:30 GMT
Subject: Re: Latest Patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41374200.3000005@redhat.com>
References: <200408241818.40064.russell@coker.com.au>
	 <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>
	 <200408282346.05926.russell@coker.com.au>
	 <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil>
	 <41371628.2020408@redhat.com>
	 <1094129654.17265.30.camel@moss-spartans.epoch.ncsc.mil>
	 <41373AEE.1040206@redhat.com>
	 <1094139993.17265.232.camel@moss-spartans.epoch.ncsc.mil>
	 <41374200.3000005@redhat.com>
Content-Type: text/plain
Message-Id: <1094143691.17265.300.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 12:48:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-02 at 11:53, Daniel J Walsh wrote:
> We can't do that because the file system is mounted in the initrd before 
> context is loaded
> We tried to do a remount with the correct context but that is not allowed.

Pity.  Ok, then you have to make the policy work with tmpfs_t as the
initial type on /dev.  You _cannot_ change the fs_use rule for tmpfs; it
will break all users of shared anonymous mappings and System V shared
memory (leaves their inodes as unlabeled_t rather than computing them
based on type_transition rules).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
