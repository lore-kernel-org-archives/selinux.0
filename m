Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5H9p1rT008080
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 05:51:02 -0400 (EDT)
Received: from smtp-bedford.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5H9opPh002660
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 09:50:59 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i5H9l5i21312
	for <selinux@tycho.nsa.gov>; Thu, 17 Jun 2004 05:47:05 -0400
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: SE Linux enhanced strace for Fedora Core 2
References: <ogtvfhss8rr.fsf@mitre.org>
	<1087393067.16125.13.camel@moss-spartans.epoch.ncsc.mil>
	<40D07C52.3070805@redhat.com>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 17 Jun 2004 05:47:04 -0400
In-Reply-To: <40D07C52.3070805@redhat.com>
Message-ID: <ogtfz8uqzxj.fsf_-_@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I discovered the sources that make up the distribution of strace I
sent out earlier fail to compile in Fedora Core 2.  Recall that this
distribution builds a version of strace that optionally prints
the security context of some of a system call's arguments.  The
modified strace for Fedora Core 2 is available here:

http://simp.mitre.org/selinux

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
