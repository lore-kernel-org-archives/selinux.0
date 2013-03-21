Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2LBWw4T012172
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2013 07:33:06 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id DD2C41A05F
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2013 12:33:01 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
	by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eFId5GwuTUEw for <selinux@tycho.nsa.gov>;
	Thu, 21 Mar 2013 12:32:59 +0100 (CET)
Received: from soldur.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id A523D1A054
	for <selinux@tycho.nsa.gov>; Thu, 21 Mar 2013 12:32:59 +0100 (CET)
Date: Thu, 21 Mar 2013 12:32:56 +0100
From: Laurent Bigonville <bigon@debian.org>
To: <selinux@tycho.nsa.gov>
Subject: File context not applied due to regex ordering
Message-ID: <20130321123256.198ba5b6@soldur.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I remember that I already talk about this on IRC a while back, but I
don't remember if there was any outcome.

The refpolicy is containing the following filecontext:

/usr/(s)?bin/gdm(3)?    --      gen_context(system_u:object_r:xdm_exec_t,s0)

But for some reasons /usr/sbin/gdm3 is labeled on disk as bin_t instead
of xdm_exec_t. matchpathcon is giving me this:

/usr/bin/gdm	system_u:object_r:xdm_exec_t:SystemLow
/usr/bin/gdm3	system_u:object_r:xdm_exec_t:SystemLow
/usr/sbin/gdm	system_u:object_r:bin_t:SystemLow
/usr/sbin/gdm3	system_u:object_r:bin_t:SystemLow

Changing the regex to /usr/s?bin/gdm(3)? fix the issue.

Shouldn't this be fixed in the userspace libraries?

Cheers

Laurent Bigonville

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
