Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATGvZ6B023224
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 11:57:35 -0500
Received: from smtp.nextra.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kATGuoa4011535
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 16:56:52 GMT
Received: from linpro2.corki.info (195.47.80.232.adsl.nextra.cz [195.47.80.232])
	by smtp.nextra.cz (Postfix) with ESMTP id D28355F04
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 17:57:54 +0100 (CET)
Subject: CentOS and SELinux refpolicy trouble
From: Filip Bartmann <filbar@centrum.cz>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 29 Nov 2006 17:57:38 +0100
Message-Id: <1164819458.4109.14.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I try use SELinux refpolicy from oss.tresys.com with CentOS 4.4.
Refpolicy I configure as targeted, and name ref-targeted. If I load the
policy into running system, then all is OK, but if I try to boot system
with this policy, then I have after "Switching to new root" first
error's, about some Unkown's booleans, then about "Error while
reading /etc/selinux/ref-targeted/booleans: Invalid argument"
Then system hangs up with killing init and : "Kernel panic - not
syncing. Out of memory and no killablable processes ..."
What I have wrong?
Filip Bartmann


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
