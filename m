Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GHFk47009814
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 13:15:46 -0400
Received: from dmzmta103.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GHFjAd027028
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 17:15:45 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l7GHEbV4020125
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 13:14:38 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l7GHEVPv026630
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 13:14:31 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: confining the unconfined_t domain
Date: Thu, 16 Aug 2007 10:15:42 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD0219DEFA@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'd like to prevent the unconfined_t domain from executing certain files
associated with domains that I've added. What is the best way to do
this?

I was trying to track down how the unconfined_t domain is given the
executable permissions to all executable files. I assume it is through
the  exec_type attribute somehow. I found the
corecmd_exec_all_executables and corecmd_mmap_all_executables interfaces
in corecommands.if, which both give execute privilege to exec_type, but
I don't see these being called from the unconfined module. Can someone
point out how this privilege is provided to the unconfined_t domain?

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
