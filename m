Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB4Cf1Rb027110
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 07:41:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB4CexRX006465
	for <selinux@tycho.nsa.gov>; Thu, 4 Dec 2003 12:41:00 GMT
Date: Thu, 4 Dec 2003 12:40:47 +0000
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>, Dale Amon <amon@vnl.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy error of the day
Message-ID: <20031204124047.GQ25416@vnl.com>
References: <20031129123120.GI18062@vnl.com> <200312010708.37773.russell@coker.com.au> <1070288825.12270.72.camel@moss-spartans.epoch.ncsc.mil> <1070288999.12270.76.camel@moss-spartans.epoch.ncsc.mil> <20031201143409.GI11972@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031201143409.GI11972@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen: I've sorted out my upgrades so it's time to
get back to the selinux building...

I'm preparing a new kernel for the machine I build on
and have just hesitated over the enabling of xattr's
in the kernel config. I'm pretty sure the file system
won't be automatically affected, but I want to do
a "tell me three times on it" because I simply cannot
afford to make this machine unable to boot under
old kernels.

So, do all swear on a stack of bible and assorted other
holy or unholy books that booting a kernel with xattr ext2
support enabled will *NOT* touch an existing file system 
and make it unuseable in, say a 2.2 kernel?

I would be *most* upset if that were to happen.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
