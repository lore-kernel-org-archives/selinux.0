Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i74ARSrT027078
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 06:27:29 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i74ARQWC013200
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 10:27:27 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5C46461C1E
	for <selinux@tycho.nsa.gov>; Wed,  4 Aug 2004 20:27:26 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 13217-02 for <selinux@tycho.nsa.gov>;
	Wed, 4 Aug 2004 20:27:26 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1E83E61BBE
	for <selinux@tycho.nsa.gov>; Wed,  4 Aug 2004 20:27:26 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 94F90B59A7
	for <selinux@tycho.nsa.gov>; Wed,  4 Aug 2004 20:27:24 +1000 (EST)
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: make policy
Date: Wed, 4 Aug 2004 20:27:24 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200408042027.24036.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does "make policy" serve any purpose any more?  It seems to me that the below 
part of the Makefile is obsolete and should be removed.


policy: $(POLICYVER)

$(POLICYVER):  policy.conf $(CHECKPOLICY)
        $(CHECKPOLICY) -o $@ policy.conf


-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
