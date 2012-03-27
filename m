Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2R9uqQB002868
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 05:56:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 057AD1A15A
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:56:51 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N2otEQ3zEqMg for <selinux@tycho.nsa.gov>;
	Tue, 27 Mar 2012 11:56:49 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id B43391A044
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:56:49 +0200 (CEST)
Date: Tue, 27 Mar 2012 11:56:44 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: Please update .po files in policycoreutils source tree
Message-ID: <20120327115644.17025830@eldamar.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

The policycoreutils module is containing .po files that do not match
the source anymore. During the build, these files are updated, but this
is causing some troubles with the debian build system (it doesn't like
when already present files are getting modified during the build).

Could you please update these files in your source tree?

cd policycoreutils/po; make && make clean

is doing the trick for me.

Cheers

Laurent Bigonville

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
