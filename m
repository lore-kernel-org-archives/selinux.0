Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i66H2irT000964
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2004 13:02:44 -0400 (EDT)
Received: from smtp-mclean.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i66H2gZn027900
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2004 17:02:42 GMT
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (8.11.6/8.11.6) with ESMTP id i66HELU20683
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2004 13:14:21 -0400
Received: from MAILHUB2 (mailhub2.mitre.org [129.83.221.18])
	by smtp-mclean.mitre.org (8.11.6/8.11.6) with ESMTP id i66HEDA20319
	for <selinux@tycho.nsa.gov>; Tue, 6 Jul 2004 13:14:13 -0400
From: "Joseph M.Kusmiss" <jkusmiss@mitre.org>
To: <selinux@tycho.nsa.gov>
Subject: Serviceusers File Question?
Date: Tue, 6 Jul 2004 12:42:17 -0400
Message-ID: <001401c46378$334c4bc0$33395381@MITRE.ORG>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I am trying to understand the serviceusers file. It seems to have the same
syntax as the users file, i.e., a userid and its role(s). How are these
users treated differently from the users in the users file? What would be
required to start a daemon using a userid and role from this file (and a
particular domain)? I can take my answer(s) offline. Thank you.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
