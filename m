Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h69IePHa025535
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 14:40:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h69IeOH5015638
	for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 18:40:24 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h69IeNRX015623 for <selinux@tycho.nsa.gov>; Wed, 9 Jul 2003 18:40:24 GMT
Subject: Re: context trouble with 2.5 bits
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200307091906.14699.russell@coker.com.au>
References: <1057701768.25921.53.camel@columbia>
	 <200307091017.42539.russell@coker.com.au>
	 <1057716690.5878.25.camel@columbia>
	 <200307091906.14699.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1057775931.28674.236.camel@columbia>
Mime-Version: 1.0
Date: 09 Jul 2003 14:38:51 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Have you checked that sshd is running as system_u:system_r:sshd_t 

Ah hah!  That was exactly the problem.  After fixing that it works fine.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
