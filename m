Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id WAA15094
	for <selinux@tycho.nsa.gov>; Sat, 19 Jan 2002 22:19:19 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA07284
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 03:18:28 GMT
Received: from blackbird.intercode.com.au (blackbird.intercode.com.au [203.32.101.10])
        by jazzband.ncsc.mil  with ESMTP id DAA07280 for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 03:18:25 GMT
Received: from localhost (jmorris@localhost)
	by blackbird.intercode.com.au (8.9.3/8.9.3) with ESMTP id OAA30132
	for <selinux@tycho.nsa.gov>; Sun, 20 Jan 2002 14:19:06 +1100
Date: Sun, 20 Jan 2002 14:19:06 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: selinux@tycho.nsa.gov
Subject: Selopt 0.08 released.
Message-ID: <Pine.LNX.4.44.0201201412270.30122-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Version 0.08 of Selopt (Labeled IPv4 networking for SELinux) has been 
released and is available for download at:

http://www.intercode.com.au/jmorris/selopt/

This version brings the Selopt kernel patch up to date with the current 
SELinux release, and includes some documentation updates.

Currently, only the lsm-2.5 kernel is supported, although Selopt may be 
backported to lsm-2.4 kernels in the future.

ChangeLog entries since the last release are provided below.

- James
-- 
James Morris
<jmorris@intercode.com.au>


ChangeLog:

* Version 0.08, Sun 20 Jan 2002.
general:
  - Updated to SELinux release 2002011718 (2.5 version only).
  - Misc. documentation updates.

scmpd:
  - Added support for new error types: security context and SID
    lookup failures.


* Version 0.07, internal release.
general:
  - Documentation updates: scmp draft.



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
