Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA17180
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2001 16:10:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA19731
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2001 21:10:04 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
	by jazzswing.ncsc.mil  with ESMTP id VAA19727
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2001 21:10:03 GMT
Received: from [10.0.1.20] (dhcp20.xiat.org [10.0.1.20])
	(authenticated)
	by khaipur.xiat.org (8.11.6/8.11.6) with ESMTP id fBDLABu17480
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2001 13:10:11 -0800
Date: Thu, 13 Dec 2001 13:06:30 -0800
From: Paul Krumviede <pwk@acm.org>
To: selinux <selinux@tycho.nsa.gov>
Subject: freeswan ipsec, 2.4.16-selinux and pclose
Message-ID: <97333588.1008248790@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i built and installed the latest release with the frees/wan
1.94 package, rebooted and tried to start ipsec. but i
noticed some new errors: pclose() fails, with errno set
to ECHILD, when pluto runs the _updown script to
prepare, route, or "up" a host. frees/wan 1.94 didn't
manifest such problems with the previous release (2.4.14
kernel).

has anybody gotten this working, seen a similar problem,
or have suggestions?

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
