Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA10550
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2003 11:34:53 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h24GYq912566
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2003 16:34:52 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id h24GYpR12559 for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2003 16:34:52 GMT
Received: from localhost (wsalamon@localhost)
	by vox.gw.tislabs.com (8.11.2/8.11.2) with ESMTP id h24GYGH15914
	for <selinux@tycho.nsa.gov>; Tue, 4 Mar 2003 11:34:16 -0500
Date: Tue, 4 Mar 2003 11:34:16 -0500 (EST)
From: Wayne Salamon <wsalamon@tislabs.com>
To: <selinux@tycho.nsa.gov>
Subject: Core policy on Sourceforge
Message-ID: <Pine.LNX.4.33.0303041130180.15723-100000@vox.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  We've pushed the changes to Sourceforge to move non-core .te files
into the unused directory.  We've tagged the selinux module with
'before_core_policy' before making these changes.

  We did make inetd part of non-core for now. That can be changed if
necessary.

-- 
Wayne Salamon
wsalamon@tislabs.com



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
