Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6K9aqrT018704
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 05:36:52 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6K9aoYW016068
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 09:36:51 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 761E8C4C0A4
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 11:36:45 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 19299-08 for <selinux@tycho.nsa.gov>;
	Tue, 20 Jul 2004 11:36:44 +0200 (CEST)
Received: from wintermute.xmldesign.de (pD9E4F11C.dip.t-dialin.net [217.228.241.28])
	by legolas.drinsama.de (Postfix) with ESMTP id 004A0C4C09B
	for <selinux@tycho.nsa.gov>; Tue, 20 Jul 2004 11:36:44 +0200 (CEST)
Date: Tue, 20 Jul 2004 11:37:04 +0200
From: Erich Schubert <erich@debian.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Troubles with etc/passwd being relabeled to shadow_t upon useradd/usermod
Message-ID: <20040720093704.GD21906@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
i'm using SELinux from Russels Debian packages.
Whenever i (or an dpkg postinst script) modifies the etc/passwd,
or etc/group files they are transferred to the
  "root:object_r:shadow_t" type, thus being unable to be read
even by root.
What is causing this, and how can i prevent this?
(doing a "make relabel" is the only way i found to solve this)

Greetings,
Erich Schubert
-- 
    erich@(mucl.de|debian.org)      --      GPG Key ID: 4B3A135C    (o_
   There was never a good war or a bad peace. - Benjamin Franklin   //\
               Für jedes Problem gibt es eine Lösung,               V_/_
                  die einfach, klar und falsch ist.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
