Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAR0TFRb022570
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 19:29:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAR0TEqY000429
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 00:29:14 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAR0TD0o000426 for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 00:29:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Carlos =?iso-8859-1?q?An=EDsio=20Monteiro?= <monteiro@ipen.br>,
   selinux <selinux@tycho.nsa.gov>
Subject: Re: fs_use and genfscon
Date: Thu, 27 Nov 2003 11:29:02 +1100
References: <3FC4FE11.8020003@ipen.br>
In-Reply-To: <3FC4FE11.8020003@ipen.br>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311271129.02179.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Nov 2003 06:25, Carlos Anísio Monteiro <monteiro@ipen.br> wrote:
> About *fs_use* and *genfscon*, I can take that: *fs_use* is used with
> filesystems that use extended attributes (xattr) and *genfscon* is to
> filesystems that not use.

fs_use is for everything that doesn't use genfscon.  Note that fs_use has 
fs_use_task and fs_use_trans as well as fs_use_xattr.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
