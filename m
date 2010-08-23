Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7NDO1Z2020860
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2010 09:24:01 -0400
Received: from yukon.worldweb2000.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o7NDNqLL005275
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2010 13:23:52 GMT
Received: from mail.puzzle.ch (localhost.localdomain [127.0.0.1])
	(authenticated bits=0)
	by yukon.worldweb2000.com (8.13.8/8.13.8) with ESMTP id o7NDNsO6031934
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2010 15:23:54 +0200
Message-ID: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>
Date: Mon, 23 Aug 2010 15:23:54 +0200 (CEST)
From: imsand@puzzle.ch
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Subject: Enable selinux in SLES 11
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Everybody

For quite a while I've been trying to enable selinux in SLES11, but
sestatus always show DISABLED.

The following steps I've already done:
  * installed all *selinux* packages from yast2
  * add the following boot parameters to the kernel: security=selinux
selinux=1 enforcing=0
  * created /etc/selinux/config file with the that content:
    SELINUX=enforcing
    SELINUXTYPE=targeted

What I've noticed is, that /selinux doesn't exit. I can't create that
mountpoint manually because selinuxfs filesystem doesn't exist.

Does anybody knows if that could be the reason? and if so, how do i get
selinux work on SLES 11.
(As far as I know SLES 11 should be prepared to use selinux as technical
preview).

Thanks in advance
Matthias



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
