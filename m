Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5NAwGrT015131
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2004 06:58:18 -0400 (EDT)
Received: from smtp-mclean.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5NAwEDm012426
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2004 10:58:14 GMT
Received: from smtp-mclean.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-mclean.mitre.org (8.11.6/8.11.6) with ESMTP id i5NB7X308759
	for <selinux@tycho.nsa.gov>; Wed, 23 Jun 2004 07:07:33 -0400
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Subject: ANN: slat 1.2 released
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 23 Jun 2004 06:58:10 -0400
Message-ID: <ogtn02usfr1.fsf@mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Version 1.2 of slat has been released.  This version handles text
policy configuration files that use the recent additions to the
configuration language.  In particular, it handles the policy.conf
file that is distributed with Fedora Core 2.

You will find a source and an RPM distribution here:

http://simp.mitre.org/selinux

If you have root access and you're on a variety of GNU/Linux that
supports RPMs, I encourage you to use the RPM, as it does not require
the installation of O'Caml.  Once installed, type "info slat".

We expect this release will be the last release that is not capable of
reading binary policy configuration files.

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
