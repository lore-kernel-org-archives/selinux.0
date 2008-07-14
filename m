Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6EGAKGP029644
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 12:10:20 -0400
Received: from dmzmta102.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6EGABiV016714
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 16:10:20 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m6EG9ma8001064
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 12:09:49 -0400
Received: from blums0042.bluelnk.net ([134.120.81.54])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m6EG6vEC022849
	for <selinux@tycho.nsa.gov>; Mon, 14 Jul 2008 12:06:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: ping and the /tmp directory
Date: Mon, 14 Jul 2008 09:10:05 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70F010A9C12@blums0042.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does the ping utility normally read/write to the /tmp directory?

I've got a domain that uses ping in the ping_t domain, using the
netutils_domtrans_ping interface, and I'm getting the following from
audit2allow:

allow ping_t tmp_t:file { read write getattr ioctl };

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
