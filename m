Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA24263
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 13:44:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA06509
	for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 18:43:28 GMT
Received: from c001.snv.cp.net (c001-h001.c001.snv.cp.net [209.228.32.115])
        by jazzband.ncsc.mil  with SMTP id SAA06504 for <selinux@tycho.nsa.gov>; Wed, 20 Mar 2002 18:43:26 GMT
From: "Leslie J. French" <ljf@semandex.net>
To: <selinux@tycho.nsa.gov>
Subject: SMP mode?
Date: Wed, 20 Mar 2002 13:44:51 -0500
Message-ID: <BFEMIIHKHLALNELLMPOMGEMDCAAA.ljf@semandex.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Apologies for a newbie question, but I can't find anything explicit in the
archive.

Is it known if SELinux works/doesn't work when installed on top of
RedHat7.1-smp? I'm running a dual-processor system and the apps (which are
very CPU & network intensive) work OK in the normal boot and fail
mysteriously in SELinux (e.g. "Operation not permitted" but with nothing in
the log, even in avc "permissive" mode). It's running 2002011718 version.

I'll repeat the experiment on a single-CPU box, since it is most likely my
fault, but I'd appreciate it if it's *known* that there are problems in this
area.

Leslie French
Semandex Networks


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
