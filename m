Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82CuRrT028545
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 08:56:27 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82CuQv0007287
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 12:56:26 GMT
Subject: Re: Latest Patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41371628.2020408@redhat.com>
References: <200408241818.40064.russell@coker.com.au>
	 <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>
	 <200408282346.05926.russell@coker.com.au>
	 <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil>
	 <41371628.2020408@redhat.com>
Content-Type: text/plain
Message-Id: <1094129654.17265.30.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 08:54:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-02 at 08:46, Daniel J Walsh wrote:
> Include some stuff from Russell,
> Critical patch for tmpfs to get udev on tmpfs working

You can't change fs_use in that manner; it will break the kernel's
internal usage of tmpfs for shared memory.  The situation is similar to
devpts; fs_use_trans will govern the initial setting of the inode
context, then programs can explicitly set and get the context.  

________________________________________________________________________
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
