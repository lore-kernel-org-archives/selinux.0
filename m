Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4E94gI4011694
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2003 05:04:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4E94NjN025199
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2003 09:04:23 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id h4E94MTU025196
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2003 09:04:22 GMT
Date: Wed, 14 May 2003 11:04:58 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Debian SELinux Mirror
Message-ID: <20030514110452.A26915@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've set up a mirror for Brian and Russells stuff, which is hosted in
Australia and at times fairly slow from over here. My mirror is located
in Germany.

http://selinux.lemuria.org


/etc/apt/sources.list:

For unstable: deb http://selinux.lemuria.org/coker/ ./
For stable: deb http://selinux.lemuria.org/debian/ stable selinux main


The mirror is synced twice daily. It's on a permanent 100mbit link.
There will be an IP change sometime next week because I move the server
to a different building, but other than that it has been very, very
reliable (500+ days uptime before the ptrace bug forced a kernel update
on me).

-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
