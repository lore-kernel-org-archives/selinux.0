Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3N9WRI4000629
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 05:32:28 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3N9WR7R002967
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 09:32:27 GMT
Received: from mail.vegaa.de (mail.vegaa.de [213.203.196.181])
        by jazzband.ncsc.mil  with ESMTP id h3N9WQKP002964 for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 09:32:26 GMT
Received: from localhost (unknown [127.0.0.1])
	by mail.vegaa.de (Postfix) with ESMTP id D2A4C174015
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 11:32:04 +0200 (CEST)
Received: from mail.dr-baldeweg.de (pD9E87FA3.dip.t-dialin.net [217.232.127.163])
	by mail.vegaa.de (Postfix) with ESMTP id 9C748174012
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 11:32:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.dr-baldeweg.de (Postfix) with ESMTP id 065081BBC9
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 11:31:58 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: SELinux <selinux@tycho.nsa.gov>
Subject: selinux programming: security_get_sids
Date: Wed, 23 Apr 2003 11:31:52 +0200
MIME-Version: 1.0
Message-Id: <200304231131.52183.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

is it possible to call security_get_sids and others with nel=0? 
Thus I could allocate the necessary memory without to check to less 
memory and call realloc.

Carsten


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
