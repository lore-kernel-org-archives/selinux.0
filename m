Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA03245
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 18:29:37 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA21785
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 23:27:43 GMT
Received: from figure1.int.wirex.com (cerebus.wirex.com [65.102.14.138])
	by jazzswing.ncsc.mil  with ESMTP id XAA21778
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 23:27:42 GMT
Date: Wed, 30 Oct 2002 15:29:26 -0800
From: Chris Wright <chris@wirex.com>
To: James W Carter <jwcart2@epoch.ncsc.mil>
Cc: linux-security-module@wirex.com, selinux@tycho.nsa.gov
Subject: Re: SELinux Kernel Oops
Message-ID: <20021030152926.B8483@figure1.int.wirex.com>
References: <200210302230.RAA26019@moss-anteater.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210302230.RAA26019@moss-anteater.epoch.ncsc.mil>; from jwcart2@epoch.ncsc.mil on Wed, Oct 30, 2002 at 05:30:22PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* James W Carter (jwcart2@epoch.ncsc.mil) wrote:
> I found a problem with SELinux on a 2.5.44 kernel generating a kernel Oops when 
> running nfsd.

Hmm, this is an ugly one.  Primarily because it touches into the fs
specific code.  I don't see a good way to do this any differently aside
from introducing a wrapper like f_release that just conditionally calls
f->release and ->file_free_security...

BTW, you missed the DTE instance of init_private_file.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
