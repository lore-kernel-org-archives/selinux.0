Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AJBxLa011337
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 15:12:00 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8AJBvmw023960
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:11:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h8AJBu9d023957 for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 19:11:56 GMT
Subject: Re: rfs xattr's, mkinitrd and other stories
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1063220599.29764.6.camel@chris.pebenito.net>
References: <20030910164854.GO5397@vnl.com>
	 <1063220599.29764.6.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1063221114.14458.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 10 Sep 2003 15:11:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-10 at 15:03, Chris PeBenito wrote:
> Is there going to be any work getting the handler for the 2.4?  I tried
> to add it on to Jeff's 2.4 patches on ftp.suse.com, but was
> unsuccessful.

You should just be able to copy the trusted handler and tweak it
slightly for the "security." namespace.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
