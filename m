Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UGUYrT024403
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 12:30:34 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UGUXog027655
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 16:30:34 GMT
Subject: Re: Access to xdm_t
From: Colin Walters <walters@verbum.org>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20040929163222.GA4125@rom.cip.ifi.lmu.de>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de>
Content-Type: text/plain
Date: Thu, 30 Sep 2004 12:32:07 -0400
Message-Id: <1096561927.4957.15.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-29 at 18:32 +0200, Thomas Bleher wrote:

> If yes, should xdm_t get the attribute privfd?

Actually even moving the log to /tmp you'll still get programs wanting
access to the xdm_t fd.  Ideally we would have a little program run in
its own domain (xdm_launcher_t say) that would simply close all of its
file descriptors, open up the tmp file itself for logging and exec the
user session.  Then you could make the xdm_launcher_t privfd, without
giving users access to any random fd that xdm forgot to close or that
one of PAM libraries xdm is using forgot to close...



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
