Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA02208
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 08:53:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA15733
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 13:50:33 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id NAA15729
	for <selinux@tycho.nsa.gov>; Fri, 17 Jan 2003 13:50:32 GMT
Date: Fri, 17 Jan 2003 13:51:11 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: KDM login trouble
Message-ID: <20030117135111.A16515@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For the first time since I started working with SELinux I've done it to
a desktop machine today.

Works fine, except for kdm. For one thing, run_init /etc/init.d/kdm
exits immediately. doh.
On boot, however, kdm fires up just right.

But, it doesn't let anyone log in. The logfile says
UNABLE TO GET VALID SID for ...

Even though all users, including root, can log on just fine one the
console, so they _do_ have valid SIDs. And I'm still running in
permissive mode. No denied log entries, either.

What am I missing?

This is a Debian woody system with kdm 2.2.2-14.se2.bam


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
