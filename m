Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i82KAurT002866
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 16:10:56 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i82KA63w010276
	for <selinux@tycho.nsa.gov>; Thu, 2 Sep 2004 20:10:06 GMT
Subject: Re: Proposed Hardware File Context file.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Colin Walters <walters@redhat.com>
In-Reply-To: <41377DD5.8010500@redhat.com>
References: <200408241818.40064.russell@coker.com.au>
	 <41371628.2020408@redhat.com>
	 <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil>
	 <200409022338.20644.russell@coker.com.au>
	 <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil>
	 <413741A3.3070305@redhat.com>
	 <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil>
	 <41377927.3080703@redhat.com>
	 <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil>
	 <41377DD5.8010500@redhat.com>
Content-Type: text/plain
Message-Id: <1094155749.17265.392.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 02 Sep 2004 16:09:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-02 at 16:08, Daniel J Walsh wrote:
> Ok so the original context as specified in the file context file with 
> hardware type.   IE
> PATH  MODETYPE CONTEXT HARDWARE
> /dev/hd.* -b  system_u:object_r:removable_disk_device_t     cdrom
> /dev/hd.* -b  system_u:object_r:fixed_disk_device_t              disk

No, I meant just a separate config with 'hardware unit context' or
similar.  No pathname regexes or modes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
