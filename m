Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6CK0N7R025327
	for <selinux@tycho.nsa.gov>; Wed, 12 Jul 2006 16:00:23 -0400
Received: from ppsw-9.csi.cam.ac.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6CK0L4K005638
	for <selinux@tycho.nsa.gov>; Wed, 12 Jul 2006 20:00:22 GMT
Received: from cpc5-cmbg1-0-0-cust453.cmbg.cable.ntl.com ([86.6.1.198]:27842 helo=localhost)
	by ppsw-9.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.159]:25)
	with esmtpsa (LOGIN:spb42) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1G0ksa-0004rc-VD (Exim 4.54) for selinux@tycho.nsa.gov
	(return-path <spb42@hermes.cam.ac.uk>); Wed, 12 Jul 2006 21:00:16 +0100
Date: Wed, 12 Jul 2006 21:09:09 +0100
From: Stephen Bennett <spb@gentoo.org>
To: selinux@tycho.nsa.gov
Subject: semanage and RHPL
Message-ID: <20060712210909.575163ad@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

After encountering some problems with modular policy in the released
toolchain packages, it was suggested to me that I try the svn
toolchain. I did this, and found that semanage and genhomedircon both
traceback when run, failing to import functions from rhpl.translate.
This package doesn't appear to be available in Gentoo's repository, and
a quick bit of searching suggests that it's a Red Hat-specific library.
Is this dependency intentional or desirable? If yes, where can we get
the sources to package it for other distros?

Thanks in advance for any input.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
