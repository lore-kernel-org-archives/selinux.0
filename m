Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i83Dn5rT007462
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 09:49:05 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i83Dn4UQ019759
	for <selinux@tycho.nsa.gov>; Fri, 3 Sep 2004 13:49:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 0753BC4C09A
	for <selinux@tycho.nsa.gov>; Fri,  3 Sep 2004 15:49:04 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 14560-10 for <selinux@tycho.nsa.gov>;
	Fri, 3 Sep 2004 15:49:03 +0200 (CEST)
Received: from wintermute.xmldesign.de (pD9E4F7B2.dip.t-dialin.net [217.228.247.178])
	by legolas.drinsama.de (Postfix) with ESMTP id D3A2FC4C098
	for <selinux@tycho.nsa.gov>; Fri,  3 Sep 2004 15:49:02 +0200 (CEST)
Received: from [127.0.0.1] (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id D046B234095
	for <selinux@tycho.nsa.gov>; Fri,  3 Sep 2004 15:49:00 +0200 (CEST)
Subject: automatic copying files between machines
From: Erich Schubert <erich@debian.org>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 03 Sep 2004 15:49:00 +0200
Message-Id: <1094219340.22849.26.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
i have some SELinux machines running just fine.
One is doing E-mail, the other is playing filewall and doing DNS etc.

On the mail machine i'd like to do some statistics, using mailgraph.
I've already written a policy for that (except for the cgi), but i don't
have (and want) a webserver on that box. Therefore i'd like to transfer
the rrd files with a cronjob to a nearby machine which does have a web
server (and later on to a central admin machine, collecting all such
data).

What is the best "SELinux-way" of doing such?
Authentication is less an issue - the two machines are on a switched
network, i know their MACs and anyone having physical access to the
switch, well, i can't prevent him from doing bad stuff anyway...
But i'd like to have these things SELinux-clean. ;-)

Greetings,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
    A polar bear is a rectangular bear after a coordinate transform.   //\
 Mancher findet sein Herz nicht eher, als bis er seinen Kopf verliert. V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
