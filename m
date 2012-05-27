Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q4RCZQ6d026625
	for <selinux@tycho.nsa.gov>; Sun, 27 May 2012 08:35:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 33EDE1A190
	for <selinux@tycho.nsa.gov>; Sun, 27 May 2012 14:34:51 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pMpFOS7oQb6Q for <selinux@tycho.nsa.gov>;
	Sun, 27 May 2012 14:34:50 +0200 (CEST)
Received: from fornost.bigon.be (unknown [IPv6:2a02:578:8500:2601:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id E6CEF1A0D3
	for <selinux@tycho.nsa.gov>; Sun, 27 May 2012 14:34:49 +0200 (CEST)
Date: Sun, 27 May 2012 14:34:44 +0200
From: Laurent Bigonville <bigon@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Assertion failed in checkmodule
Message-ID: <20120527143444.7dc8cba5@fornost.bigon.be>
In-Reply-To: <20120513104346.6c188436@fornost.bigon.be>
References: <20120513104346.6c188436@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Le Sun, 13 May 2012 10:43:46 +0200,
Laurent Bigonville <bigon@debian.org> a écrit :

> Hi,
> 
> When compiling the latest release of refpolicy I get the following
> assertion:
> 
> checkmodule: expand.c:700: role_fix_callback: Assertion `new_role !=
> ((void *)0) && new_role->flavor == 1' failed.
> 
> Google helps me to find an old discussion about this on the mailing
> list but it seems that unfortunately nothing has been fixed.
> 
> Any clue?

No idea? (shameless ping)

Cheers

Laurent Bigonville


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
