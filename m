Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA4FQmAE011359
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2013 10:26:48 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E5965208E2
	for <selinux@tycho.nsa.gov>; Mon,  4 Nov 2013 10:26:41 -0500 (EST)
Received: from [192.168.1.2] (unknown [66.31.18.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id A19A06800A1
	for <selinux@tycho.nsa.gov>; Mon,  4 Nov 2013 10:26:41 -0500 (EST)
Subject: review of a dbus-selinux patch
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Nov 2013 10:26:41 -0500
Message-ID: <1383578801.23834.59.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Does anyone have comments on:
https://bugs.freedesktop.org/show_bug.cgi?id=71187

We expect people to be able to change major policy types without
recompiling userspace, correct?

The patch makes sense to me (just needs some style fixups per smcv's
comments).  However, from a quick look at the X.org xselinux code, it
looks like it also hardcodes e.g. SECCLASS_X_DRAWABLE; we'd need
a similar change there, right?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
