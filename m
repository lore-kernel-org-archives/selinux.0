Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8BBliLa014928
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 07:47:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8BBk7LY012911
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 11:46:07 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h8BBk7sG012908
	for <selinux@tycho.nsa.gov>; Thu, 11 Sep 2003 11:46:07 GMT
Subject: Re: rfs xattr's, mkinitrd and other stories
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200309111048.16590.russell@coker.com.au>
References: <20030910164854.GO5397@vnl.com> <20030910230519.GU5397@vnl.com>
	 <20030910233424.GV5397@vnl.com>  <200309111048.16590.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1063280832.16884.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 11 Sep 2003 07:47:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-09-10 at 20:48, Russell Coker wrote:
> none                    /selinux                selinuxfs       noauto  0 0

Why noauto?  It needs to be mounted if you are running SELinux, and it
will just fail with a warning if the kernel doesn't have SELinux
enabled.

> A special file system for SE Linux related entries.  I can't understand why it 
> wasn't just made part of /proc, Steve, perhaps you could explain.

Misuse of /proc isn't viewed favorably by the kernel developers.  The
preferred approach is to create your own pseudo filesystem type. 
selinuxfs was based on the nfsd pseudo filesystem in 2.5/6.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
