Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GIP6L9018789
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 13:25:06 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GILTNj017542
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 18:21:30 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by open.hands.com (Postfix) with ESMTP id 0ED90C724
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 18:23:38 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1D1Tzh-0001pn-VG
	for selinux@tycho.nsa.gov; Wed, 16 Feb 2005 18:33:49 +0000
Date: Wed, 16 Feb 2005 18:33:49 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [owner@bugs.debian.org: Bug#258725 acknowledged by developer (Bug#258725: fixed in hotplug 0.0.20040329-17)]
Message-ID: <20050216183349.GD6802@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hooray!

expect an /etc/hotplug/run (or is that .run??) directory to
exist soon for Debian hotplug package.

----- Forwarded message from Debian Bug Tracking System <owner@bugs.debian.org> -----

Envelope-to: lkcl@localhost
Delivery-date: Wed, 16 Feb 2005 18:25:33 +0000
X-Sieve: CMU Sieve 2.2
From: Debian Bug Tracking System <owner@bugs.debian.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Bug#258725 acknowledged by developer
         (Bug#258725: fixed in hotplug 0.0.20040329-17)
X-Debian-PR-Message: they-closed 258725
X-Debian-PR-Package: hotplug
X-Debian-PR-Keywords: 
Reply-To: 258725@bugs.debian.org
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: debbugs@bugs.debian.org

This is an automatic notification regarding your Bug report
#258725: net.rc writing to /etc/hotplug/net.enable is banned under SE/Linux,
which was filed against the hotplug package.

[...]

   * Modified patch 050_net.agent_ifupdown to move the net.enable flag file
     to /etc/hotplug/.run/. (Closes: #258725)
        ^^^^^^^^^^^^^^^^^


[...]

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
