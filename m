Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TGWPrT016914
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 12:32:25 -0400 (EDT)
Received: from kokytos.rz.informatik.uni-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TGWMjQ016559
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 16:32:23 GMT
Received: from rom.cip.ifi.lmu.de (rom.cip.informatik.uni-muenchen.de [141.84.214.183])
	by kokytos.rz.informatik.uni-muenchen.de (Postfix) with ESMTP id 2DBB4436F7
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 18:32:23 +0200 (CEST)
Date: Wed, 29 Sep 2004 18:32:22 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Access to xdm_t
Message-ID: <20040929163222.GA4125@rom.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a question about access to xdm_t:
With KDM 3.3 I am seeing a lot of accesses to xdm_t:fd and
xdm_t:fifo_file from user processes (say user_lpr_t and user_gpg_t)
Should these be allowed?
If yes, should xdm_t get the attribute privfd?

Also, is it OK to dontaudit access to .xsession-errors (on SuSE it lives
under ~ and I do not want to give all derived user domains access to user's
home dir). Or will this cause errors with some programs?

Thanks for your answers,
Thomas

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
