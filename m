Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19902
	for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2003 11:39:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h1KGd0I05495
	for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2003 16:39:00 GMT
Received: from torexch1.mykotronx.com (host-65-119-11-194.mykotronx.com [65.119.11.194] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h1KGcwf05490 for <selinux@tycho.nsa.gov>; Thu, 20 Feb 2003 16:38:58 GMT
Message-ID: <FD2221F5E1A8184DB61AFCE064C395F1C91CE5@torexch1.mykotronx.com>
From: CNGUYEN <CNguyen@mykotronx.com>
To: "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Switching Security Policies
Date: Thu, 20 Feb 2003 08:40:31 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I understand that SELinux is not quite Multi-Level Security (MLS) yet, but
is it possible to switch security policies w/o having to reboot SELinux? For
example: if I need Security Policy A for environment A, and Security Policy
B for environment B, is there a (secure, of course) method to allow
authorized user to switch from one policy to the other as the user moves
from one  environment to the other environment?

Chieu Nguyen
Mykotronx

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
