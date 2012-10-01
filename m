Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GWubc017392
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:32:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id E87601AAEC
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:10 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id swWBZscLFQKf for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:09 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 4CEF71A095
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:08 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 00/15] Patches from the Debian packages
Date: Mon,  1 Oct 2012 18:31:42 +0200
Message-Id: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Please find in the following mails patches that are coming from the debian
packages or that fix issues that were detected using some debian tools.

Most of the patches are fixing build system or manpage formating issues.

One is adding a reworked open_init_pty executable (patch made by Russell).

An other one is adding handeling of UID_MAX (similar to UID_MIN) in
genhomedircon.

Cheers

Laurent Bigonville

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
