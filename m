Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12518
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 10:47:16 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA29450
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 15:46:48 GMT
Received: from imr2.ericy.com (imr2.ericy.com [198.24.6.3])
	by jazzswing.ncsc.mil  with ESMTP id PAA29446
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 15:46:47 GMT
Received: from mr5.exu.ericsson.se (mr5att.ericy.com [138.85.224.141])
	by imr2.ericy.com (8.11.3/8.11.3) with ESMTP id g07FlEJ09719
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 09:47:14 -0600 (CST)
Received: from noah.lmc.ericsson.se (noah.lmc.ericsson.se [142.133.1.1])
	by mr5.exu.ericsson.se (8.11.3/8.11.3) with ESMTP id g07FlEN06729
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 09:47:14 -0600 (CST)
Received: from EAMMLEX034.lmc.ericsson.se (eammlex034.lmc.ericsson.se [142.133.1.134])
	by noah.lmc.ericsson.se (8.11.2/8.9.2) with ESMTP id g07FlDO17068
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2002 10:47:13 -0500 (EST)
Date: Mon, 7 Jan 2002 10:47:05 -0500
From: Charles Levert <lmcleve@ericsson.ca>
To: selinux@tycho.nsa.gov
Subject: /etc/security/default_context vs. /etc/security/default_contexts
Message-ID: <20020107104705.A857@lmc.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

In libsecure, what is the difference between the following two files
(notice the final "s")?

	/etc/security/default_context
		as used by get_default_user_sid() and get_user_sid()

	/etc/security/default_contexts (and ~user/.default_contexts)
		as used by get_config_priority()

Also, what is the difference between get_default_user_sid() and
get_user_sid() ?

Thanks.


Charles

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
