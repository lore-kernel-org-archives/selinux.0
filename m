Received: from epoch.ncsc.mil (facesaver [144.51.25.10])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA16260
	for <selinux@tycho.ncsc.mil>; Tue, 2 Jan 2001 17:28:53 -0500 (EST)
Received: from coalstack.epoch.ncsc.mil (coalstack [144.51.25.12])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA22216
	for <selinux@tycho.ncsc.mil>; Tue, 2 Jan 2001 17:28:51 -0500 (EST)
Date: Tue, 2 Jan 2001 17:28:48 -0500 (EST)
From: pal@epoch.ncsc.mil (Pete Loscocco)
Message-Id: <200101022228.RAA19010@coalstack.epoch.ncsc.mil>
To: selinux@tycho.ncsc.mil
Subject: Updated release
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

An updated release of Security-enhanced Linux that corrects some of the
minor problems in the original release has been posted on the NSA web
site (www.nsa.gov/selinux).

Changes include:

- moving the numbers of the new system calls to avoid conflicts
- fixing the buffer overflow problem discovered in the
  find_default_type function in libsecure
- removed extra ';' in policy grammar
- minor adjustments in kernel/flask/Makefile

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
