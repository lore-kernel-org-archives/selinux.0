Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA04870
	for <selinux@tycho.nsa.gov>; Tue, 18 Jun 2002 17:07:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA01047
	for <selinux@tycho.nsa.gov>; Tue, 18 Jun 2002 21:06:50 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA01043
	for <selinux@tycho.nsa.gov>; Tue, 18 Jun 2002 21:06:49 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id D27F692461
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2002 07:07:06 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8FB4069D
	for <selinux@tycho.nsa.gov>; Tue, 18 Jun 2002 23:06:59 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: iptables
Date: Tue, 18 Jun 2002 23:06:59 +0200
MIME-Version: 1.0
Message-Id: <20020618210659.8FB4069D@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It appears that when netfilter reject rules cause an ICMP message, that 
message has an unlabelled source type...

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
