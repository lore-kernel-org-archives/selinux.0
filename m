Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m07HsmTW029900
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 12:54:48 -0500
Received: from g4t0016.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m07Hsllk006659
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 17:54:47 GMT
Received: from g4t0016.houston.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 34C2514491
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:54:47 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by g4t0016.houston.hp.com (Postfix) with ESMTP id 2971314382
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:54:47 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v11 00/19] Labeled networking changes for 2.6.25
To: selinux@tycho.nsa.gov
Date: Mon, 07 Jan 2008 12:54:43 -0500
Message-ID: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After thinking about it this weekend I made some more updates to the
ingres/egress patch to properly integrate secmark support (I forgot to include
it in the patch posted last Friday) and cleanup some residual mess from the
change in approach.

Also, for the record, I just posted the skb_clone() fix and the ingress/egress
patch to netdev for review.  With a little bit of luck there won't be any
serious objections.  I've also started working on the related policy changes
to support the new functionality, I hope to have a simple patch posted later
this week that others can use to start playing with the new controls.

As usual, any comments or feedback are encouraged.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
