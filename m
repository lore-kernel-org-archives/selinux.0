Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j82CYkOb019660
	for <selinux@tycho.nsa.gov>; Fri, 2 Sep 2005 08:34:46 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j82CXWoJ022404
	for <selinux@tycho.nsa.gov>; Fri, 2 Sep 2005 12:33:32 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j82CXYr9027027
	for <selinux@tycho.nsa.gov>; Fri, 2 Sep 2005 08:33:34 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j82CXYGA027026
	for selinux@tycho.nsa.gov; Fri, 2 Sep 2005 08:33:34 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j821iuOb016224
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2005 21:44:56 -0400 (EDT)
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j821gauW012058
	for <selinux@tycho.nsa.gov>; Fri, 2 Sep 2005 01:42:37 GMT
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 7086CC4C08C
	for <selinux@tycho.nsa.gov>; Fri,  2 Sep 2005 03:43:47 +0200 (CEST)
Received: from legolas.drinsama.de ([127.0.0.1])
	by localhost (legolas [127.0.0.1]) (amavisd-new, port 10024)
	with SMTP id 09612-05 for <selinux@tycho.nsa.gov>;
	Fri, 2 Sep 2005 03:43:46 +0200 (CEST)
Received: from wintermute.xmldesign.de (p549A4606.dip.t-dialin.net [84.154.70.6])
	by legolas.drinsama.de (Postfix) with ESMTP id 17734C4C083
	for <selinux@tycho.nsa.gov>; Fri,  2 Sep 2005 03:43:46 +0200 (CEST)
Received: from wintermute.xmldesign.de (wintermute.xmldesign.de [127.0.0.1])
	by wintermute.xmldesign.de (Postfix) with ESMTP id 229A423456A
	for <selinux@tycho.nsa.gov>; Fri,  2 Sep 2005 03:43:44 +0200 (CEST)
Subject: run_init breaks munin
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 02 Sep 2005 03:43:43 +0200
Message-Id: <1125625423.9409.13.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
It took me some hours of debugging to find out that run_init apparently
is blocking the SIGCHLD signal and not unblocking it.
(on Debian sarge with policycoreutils from unstable)

Perl / libnet-server-perl apparently assumes that SIGCHLD is not blocked
when it's started up, and thus never unblocks it...

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  A polar bear is a rectangular bear after a coordinate transform.   //\
    Das größte Hindernis beim Erkennen der Wahrheit ist nicht die    V_/_
       Falschheit, sondern die Halbwahrheit. --- L. N. Tolstoi


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
