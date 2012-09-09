Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q89HAElu014130
	for <selinux@tycho.nsa.gov>; Sun, 9 Sep 2012 13:10:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 8BCEC1A1AB
	for <selinux@tycho.nsa.gov>; Sun,  9 Sep 2012 19:10:11 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jbH1WMQfmuwc for <selinux@tycho.nsa.gov>;
	Sun,  9 Sep 2012 19:10:10 +0200 (CEST)
Received: from fornost.bigon.be (unknown [IPv6:2a02:578:8500:2601:226:18ff:fe08:6073])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 1A19B1A056
	for <selinux@tycho.nsa.gov>; Sun,  9 Sep 2012 19:10:10 +0200 (CEST)
Date: Sun, 9 Sep 2012 19:10:00 +0200
From: Laurent Bigonville <bigon@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Assertion `new_role != ((void *)0) && new_role->flavor == 1' when
 installing modules
Message-ID: <20120909191000.74e83c73@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

When compiling the GIT HEAD of the refpolicy and then trying to install
the base module with the required dependencies (semodule -b base.pp
-i ...) , I get the following assertion:

Assertion `new_role != ((void *)0) && new_role->flavor == 1'

I've found a previous discussion[0] on the mailing list from some months
ago but unfortunately without any solution.

Does anybody have an idea?

Cheers

Laurent Bigonville

[0] http://www.spinics.net/lists/selinux/msg11809.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
