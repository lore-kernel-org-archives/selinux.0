Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9IBZ2Wt013625
	for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 07:35:02 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9IBYq0p013382
	for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 11:34:52 GMT
Received: from extern.mail.waldi.eu.org (nat.moeglingen.waldi.eu.org [82.139.201.30] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id h9IBYpr7013374
	for <selinux@tycho.nsa.gov>; Sat, 18 Oct 2003 11:34:52 GMT
Date: Sat, 18 Oct 2003 13:34:55 +0200
From: Bastian Blank <bastian+selinux=tycho.nsa.gov@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: libselinux.so.1 and some utils shouldn't be in /usr
Message-ID: <20031018113455.GA22140@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi folks

libselinux.so.1 and some of the utils shouldn't be in /usr.
this applies to anything which is needed to restore a broken system
because /usr may on an extra partition.

bastian

-- 
Men will always be men -- no matter where they are.
		-- Harry Mudd, "Mudd's Women", stardate 1329.8

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
