Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hABGvwSf009423
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2003 11:57:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hABGvXBb027563
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2003 16:57:33 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hABGvX4o027560
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2003 16:57:33 GMT
Date: Tue, 11 Nov 2003 16:57:52 +0000
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: Policy error report for Russ
Message-ID: <20031111165752.GO23277@vnl.com>
References: <20031110143234.R16119@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031110143234.R16119@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This doesn't really matter to me since I don't use it, but
I thought I'd pass it on:

assertion on line 134090 violated by allow gatekeeper_t etc_t:lnk_file { write create setattr append unlink link rename };

the particular policy is what results if you say yes
to everything.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
