Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA11072
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 20:05:14 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA28409
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 00:05:03 GMT
Received: from rj.sgi.com (rj.SGI.COM [192.82.208.96])
	by jazzswing.ncsc.mil  with ESMTP id AAA28405
	for <selinux@tycho.nsa.gov>; Tue, 4 Jun 2002 00:05:03 GMT
Received: from relay1.corp.sgi.com (ether-spindle.corp.sgi.com [192.26.51.29])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with ESMTP id g53M55il018901
	for <@external-mail-relay.sgi.com:selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 15:05:05 -0700
Received: from stantz.corp.sgi.com (stantz.corp.sgi.com [130.62.4.42]) by relay1.corp.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA43007 for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 17:05:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by stantz.corp.sgi.com (Postfix) with ESMTP id 3788F1363FB
	for <selinux@tycho.nsa.gov>; Mon,  3 Jun 2002 17:05:11 -0700 (PDT)
Subject: SELinux RPMs + Red Hat installer
From: Florin Andrei <florin@sgi.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 03 Jun 2002 17:05:11 -0700
Message-Id: <1023149111.5701.32.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

According to the TODO list, there's still a need to create RPM packages
for the SELinux project.

I think i can do that, and besides i want to create a modified Red Hat
installer (perhaps v7.3) based on SELinux.
It shouldn't be difficult, i created customised RH installers in the
past and, besides, at SGI we already have a customised installer for the
XFS-enabled Red Hat distribution. So, i won't miss either experience or
know-how. ;-)

If anyone is already doing that, please tell me, in order to not
duplicate efforts.

-- 
Florin Andrei

"You can get excited about just any subject if you study it enough.
It's the deep knowledge that makes a topic interesting." - Larry McVoy


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
