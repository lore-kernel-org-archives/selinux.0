Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5AHAX2f007656
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 13:10:33 -0400
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5AHAWF6024264
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 17:10:32 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5AHAN3n022001
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 13:10:25 -0400
Received: from blums0042.bluelnk.net ([134.120.81.54])
	by usdmta002.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m5AH8kVT002566
	for <selinux@tycho.nsa.gov>; Tue, 10 Jun 2008 13:08:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: tracking down execstack & execmem violations
Date: Tue, 10 Jun 2008 10:10:22 -0700
Message-ID: <0794F277152EF94AA637E3AECF5CB70FB9EAC8@blums0042.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm writing a policy for a very large legacy CORBA application, with
many separate processes. Without fail, every one of our processes
requires execstack & execmem privileges. I would like to track down the
cause, but I really don't have any idea how. Does anybody have any good
recommendations?

I'd like to at least be able to determine whether the offending code is
ours or some vender's (like our CORBA vender), and if it is ours I'd
like to track down the source. I'm betting there is a common source
causing the issue.

Thanks







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
