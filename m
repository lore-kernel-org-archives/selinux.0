Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AIH8La010818
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 14:17:08 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8AIH7mw019519
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 18:17:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h8AIH69d019516 for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 18:17:06 GMT
Subject: Re: rfs xattr's, mkinitrd and other stories
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Dale Amon <amon@vnl.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20030910175914.GP5397@vnl.com>
References: <20030910164854.GO5397@vnl.com>
	 <1063213343.14458.35.camel@moss-spartans.epoch.ncsc.mil>
	 <20030910175914.GP5397@vnl.com>
Content-Type: text/plain
Message-Id: <1063217825.14458.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 10 Sep 2003 14:17:05 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-10 at 13:59, Dale Amon wrote:
> How so? It's still marked experimental in fact. devpts has been
> made independant but I can't imagine why devfs would ever be
> removed. If anything it is superseding the old static /dev.

See ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm1/broken-out/mark-devfs-obsolete.patch

And the related discussions on lkml.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
