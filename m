Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7DEkwHa023780
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2003 10:46:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7DEjbOD019383
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2003 14:45:37 GMT
Received: from smtp4.poczta.onet.pl (smtp4.poczta.onet.pl [213.180.130.28])
	by jazzswing.ncsc.mil  with ESMTP id h7DEjaKO019376
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2003 14:45:37 GMT
Message-ID: <013a01c361a9$c57f7de0$260b0aac@MWPCNOWY>
Reply-To: "Marcin Wasilewski" <marcinwasilewski@poczta.onet.pl>
From: "Marcin Wasilewski" <marcinwasilewski@poczta.onet.pl>
To: <selinux@tycho.nsa.gov>
Subject: Policy problem
Date: Wed, 13 Aug 2003 16:47:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I'm still trying to install the policy for selinux but could not find the
right solution for my problem:
make -C /etc/selinux policy - is OK
make -C /etc/selinux install - is also OK
make -C /etc/selinux load - gives an error:

/usr/sbin/load_policy /etc/security/selinux/policy.12
security_load_policy: Function not implemented

any idea why?
Best regards
Marcin


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
