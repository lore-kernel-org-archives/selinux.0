Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB4EG4Rb027733
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 09:16:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB4EG3RV010793
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 14:16:04 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hB4EG3ta010788 for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 14:16:03 GMT
Subject: Re: Policy error of the day
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20031204124047.GQ25416@vnl.com>
References: <20031129123120.GI18062@vnl.com>
	 <200312010708.37773.russell@coker.com.au>
	 <1070288825.12270.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1070288999.12270.76.camel@moss-spartans.epoch.ncsc.mil>
	 <20031201143409.GI11972@vnl.com>  <20031204124047.GQ25416@vnl.com>
Content-Type: text/plain
Message-Id: <1070547359.17837.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 04 Dec 2003 09:15:59 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-12-04 at 07:40, Dale Amon wrote:
> I'm preparing a new kernel for the machine I build on
> and have just hesitated over the enabling of xattr's
> in the kernel config. I'm pretty sure the file system
> won't be automatically affected, but I want to do
> a "tell me three times on it" because I simply cannot
> afford to make this machine unable to boot under
> old kernels.
> 
> So, do all swear on a stack of bible and assorted other
> holy or unholy books that booting a kernel with xattr ext2
> support enabled will *NOT* touch an existing file system 
> and make it unuseable in, say a 2.2 kernel?
> 
> I would be *most* upset if that were to happen.

No promises, but my experience has been that unless you set the
attributes on the filesystem, there is no harm.  I've never had a
problem until _after_ I've run setfiles to label the filesystem.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
