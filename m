Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB3AKDRb020352
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 05:20:13 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB3AJ8p5010773
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 10:19:24 GMT
Received: from nox.lemuria.org ([213.191.86.35])
	by jazzswing.ncsc.mil  with ESMTP id hB3AIVt0010720
	for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2003 10:18:48 GMT
Date: Wed, 3 Dec 2003 11:17:47 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: the /etc/selinux problem
Message-ID: <20031203111746.A27632@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Someone here had an install problem - sorry, I don't remember your
name.

I stepped back through my install and found your solution:


There is a hen-egg problem in /etc/dpkg/postinst.d/selinux when you
upgrade (don't know about fresh installs). Here's what I did to get it
solved:

dpkg --purge selinux-policy-default
manually rm -r /etc/selinux and rm -r /usr/share/selinux/policy
now vi /etc/dpkg/postinst.d/selinux and put an exit 0 right at the
start.
now dpkg -i selinux-policy-default_1.2.real-13_all.deb

should now work. Remove the exit 0 from the script. You may have to
issue a make relabel, but that's a good idea anyways.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
