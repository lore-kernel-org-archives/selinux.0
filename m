Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1FGUTL9008614
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 11:30:29 -0500 (EST)
Received: from mx-4.zoominternet.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1FGTLEP005889
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 16:29:21 GMT
Received: from mua-4.zoominternet.net (mua-4.zoominternet.net [24.154.1.47])
	by mx-4.zoominternet.net (8.12.11/8.12.11) with ESMTP id j1FGSGZ8008532
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 11:29:08 -0500
Received: from 192.168.1.101 (acs-24-144-213-127.zoominternet.net [24.144.213.127])
	by mua-4.zoominternet.net (Postfix) with ESMTP id 464F17F42D
	for <selinux@tycho.nsa.gov>; Tue, 15 Feb 2005 11:21:01 -0500 (EST)
Subject: Determining if SELinux is installed
From: Scott Cain <cain@cshl.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 15 Feb 2005 11:18:40 -0500
Message-Id: <1108484321.3297.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Is there a programmatic way to determine if SELinux is installed and
enabled?  I would like to know so that I can let the installer I've
written take appropriate action if it detects that it is there.

Thanks,
Scott

-- 
------------------------------------------------------------------------
Scott Cain, Ph. D.                                         cain@cshl.org
GMOD Coordinator (http://www.gmod.org/)                     216-392-3087
Cold Spring Harbor Laboratory


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
