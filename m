Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82FmerT000300
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 11:48:41 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82Fmdv0013761
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:48:40 GMT
Subject: Re: Latest Patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41373AEE.1040206@redhat.com>
References: <200408241818.40064.russell@coker.com.au>
	 <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil>
	 <200408282346.05926.russell@coker.com.au>
	 <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil>
	 <41371628.2020408@redhat.com>
	 <1094129654.17265.30.camel@moss-spartans.epoch.ncsc.mil>
	 <41373AEE.1040206@redhat.com>
Content-Type: text/plain
Message-Id: <1094139993.17265.232.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 11:46:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-02 at 11:23, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> >You can't change fs_use in that manner; it will break the kernel's
> >internal usage of tmpfs for shared memory.  The situation is similar to
> >devpts; fs_use_trans will govern the initial setting of the inode
> >context, then programs can explicitly set and get the context.  
>
> We get a discretionary Access control error "Permission Denied" message 
> on on a restorecon /dev without making this change
> on bootup.  Everything seemed to be working ok Well at least to the 
> point of booting the machine and logging in.

That doesn't make it correct.  You can't just change the existing
labeling behavior and superblock type for the tmpfs internal mount for
shmem.  As per prior discussions on this list with Luke, you want to:
- mount tmpfs on /dev with fscontext=system_u:object_r:device_t (James
sent Arjan the necessary patch for that along with the xattr handler
based on the earlier patches by Luke)
- adjust the policy accordingly, including the necessary filesystem
associate permissions between device_type and device_t:filesystem.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
