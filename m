Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9FHx2Wt027229
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 13:59:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9FHx0mR015738
	for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 17:59:00 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9FHx0jp015732 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2003 17:59:00 GMT
Subject: RE: Compile/build problem in Red Hat 9.0
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Richard Herbert Wanner <richard.wanner@cgi.com>
Cc: selinux@tycho.nsa.gov, Kerry Thompson <kerry@crypt.gen.nz>
In-Reply-To: <GMECJOINLDFDGEEPGINLMEGFCKAA.richard.wanner@cgi.com>
References: <GMECJOINLDFDGEEPGINLMEGFCKAA.richard.wanner@cgi.com>
Content-Type: text/plain
Message-Id: <1066240736.7399.74.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Oct 2003 13:58:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-14 at 20:54, Richard Herbert Wanner wrote:
> Thanks.  These steps are quite a bit different from the ones in the docs in the usr package. Did I miss something?
> The 2.6 docs and the 2.4 docs look the same, am I using the wrong ones?
> 
> The docs in the usr package in the 2.4 bundle say.
> 
> 	cd linux-2.4
> 	make menuconfig
> 	make 
> 	make modules_install
> 	make install

Sorry, the 2.4 and 2.6 SELinux share the same userland archive,
including build instructions, but the instructions currently only
describe what to do for 2.6.  The kernel build process has changed for
2.6, hence the difference.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
