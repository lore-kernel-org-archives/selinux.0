Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82JbMrT002449
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 15:37:23 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82JaP3w008036
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 19:36:33 GMT
Date: Thu, 2 Sep 2004 20:48:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Russell Coker <russell@coker.com.au>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Latest Patches
Message-ID: <20040902194822.GI5745@lkcl.net>
References: <200408241818.40064.russell@coker.com.au> <1093640295.24188.29.camel@moss-lions.epoch.ncsc.mil> <200408282346.05926.russell@coker.com.au> <1093897455.3227.6.camel@moss-lions.epoch.ncsc.mil> <41371628.2020408@redhat.com> <1094129654.17265.30.camel@moss-spartans.epoch.ncsc.mil> <41373AEE.1040206@redhat.com> <1094139993.17265.232.camel@moss-spartans.epoch.ncsc.mil> <41374200.3000005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41374200.3000005@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 02, 2004 at 11:53:36AM -0400, Daniel J Walsh wrote:

> >That doesn't make it correct.  You can't just change the existing
> >labeling behavior and superblock type for the tmpfs internal mount for
> >shmem.  As per prior discussions on this list with Luke, you want to:
> >- mount tmpfs on /dev with fscontext=system_u:object_r:device_t (James
> >sent Arjan the necessary patch for that along with the xattr handler
> >based on the earlier patches by Luke)
> > 
> >
> We can't do that because the file system is mounted in the initrd before 
> context is loaded

 um.  why?  *curious*.

 i mean, why mount the /dev filesystem in the initrd ?

 and, also, why before running /sbin/init? [hope i'm right about that]
 
 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
