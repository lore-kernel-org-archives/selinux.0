Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA17040
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 13:24:35 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA03352
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:23:58 GMT
Received: from mail.simplyaquatics.com (66-0-92-223.deltacom.net [66.0.92.223])
	by jazzswing.ncsc.mil  with ESMTP id RAA03348
	for <selinux@tycho.nsa.gov>; Thu, 11 Jul 2002 17:23:57 GMT
Reply-To: <blacknet@simplyaquatics.com>
From: "Ed Street" <blacknet@simplyaquatics.com>
To: "'Stephen Smalley'" <sds@tislabs.com>
Cc: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: RE: sysadm_tty_device_t
Date: Thu, 11 Jul 2002 13:24:32 -0400
Message-ID: <00d901c228ff$d2589f30$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0207111319430.15869-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

And sysadm_tty_device_t?

Ed

=> 
=> ttys are initialized to tty_device_t by 'make relabel'.  They are
then
=> relabeled by the modified login program based on the user's context
for
=> user sessions, and are also relabeled by the newrole program for
shells
=> in different roles.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
