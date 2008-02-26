Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QIibJs030435
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 13:44:37 -0500
Received: from g4t0017.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1QIiaQG003738
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:36 GMT
Received: from g4t0017.houston.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id BBCCF380A5
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:04 +0000 (UTC)
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0017.houston.hp.com (Postfix) with ESMTP id B9D9B38041
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 18:44:04 +0000 (UTC)
Message-Id: <20080226184032.834798290@hp.com>
Date: Tue, 26 Feb 2008 13:40:32 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/5] New labeled networking permissions for 2.6.25
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patches add the new labeled networking permission to the
Reference Policy as previously discussed.  It is important to note that
while this patchset adds the permissions required it doesn't enable the
"network_peer_controls" policy capability.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
