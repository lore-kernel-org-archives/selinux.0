Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAHJmBRb008025
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 14:48:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAHJm9qY008676
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 19:48:09 GMT
Received: from sentry.rv.nailabs.com (sentry.rv.nailabs.com [204.254.155.100])
        by jazzband.ncsc.mil  with ESMTP id hAHJm40o008667 for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 19:48:04 GMT
Received: from raven.rv.nailabs.com (localhost [127.0.0.1])
	by raven.rv.nailabs.com (8.12.10/8.12.10) with ESMTP id hAHJkt2G006088
	for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2003 14:46:55 -0500 (EST)
Received: (from areisse@localhost)
	by raven.rv.nailabs.com (8.12.10/8.12.10/Submit) id hAHJktxq006087
	for selinux@tycho.nsa.gov; Mon, 17 Nov 2003 14:46:55 -0500 (EST)
Date: Mon, 17 Nov 2003 14:46:55 -0500
From: Andrew Reisse <areisse@nailabs.com>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: relabelling processes
Message-ID: <20031117144655.A25938@raven.rv.nailabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


For the SEdarwin project, we need a process to change its label during 
execution, because it acts as both a system service and a user session
manager. (Apple does not release the source). Is there a security risk
in allowing this for other processes as well, performing the relabelfrom/
relabelto checks as with file relabelling? If so, we will probably need
to introduce a new permission so that the window server can change its
label, but no user process can.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
