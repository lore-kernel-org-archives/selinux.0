Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2G6APRb018227
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 01:10:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2G68d6Q012285
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 06:08:40 GMT
Received: from internode.on.net (bep1.adl2.internode.on.net [203.16.214.212])
	by jazzswing.ncsc.mil  with ESMTP id i2G68b5t012282
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 06:08:38 GMT
Received: from internode.on.net (unverified [203.16.214.212])
	by internode.on.net (SurgeMail 1.6e10) with ESMTP id 26149938
	for <selinux@tycho.nsa.gov>; Tue, 16 Mar 2004 16:38:52 +1030 (CDT)
From: "keen@internode.on.net" <keen@internode.on.net>
Reply-to: keen@internode.on.net
To: selinux@tycho.nsa.gov
Subject: macros/vi
Date: Tue, 16 Mar 2004 17:08:52 +1100
Message-id: <405699f4.146.40ec.155106242@internode.on.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

would like to find out is there any technical difference by
defining TE rules for an application in
domains/program/app.te and macros/programs/app.te ? When
would it be better to use it as a macro, or would it be
better to list it just in the domains directory?

As a way to learn configuring the policy, I am currently
still experimenting with configuring TE rules for vi(vim).
Would it be necessary for vi to run in its own domain as
such? Or running it under the invoking user's domain would
suffice?

Regards,
Keen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
