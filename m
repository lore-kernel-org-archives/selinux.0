Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9JEAsM6001288
	for <selinux@tycho.nsa.gov>; Fri, 19 Oct 2007 10:10:54 -0400
Received: from dmzmta102.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l9JEArio017085
	for <selinux@tycho.nsa.gov>; Fri, 19 Oct 2007 14:10:53 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l9JE9CvS014131
	for <selinux@tycho.nsa.gov>; Fri, 19 Oct 2007 10:09:12 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l9JEA86I006624
	for <selinux@tycho.nsa.gov>; Fri, 19 Oct 2007 10:10:09 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: thread level controls
Date: Fri, 19 Oct 2007 07:10:50 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02554940@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Are there any plans to extend SELinux to provide thread level controls?

I recognize that this is considerably harder than process level controls
given that threads share a number of resources, but it would be quite
useful, at least from an MLS perspective.

Today, most systems are going to contain web servers, corba services, or
some other form of client-server architecture where a server runs as a
single process and starts separate threads for client connections. It's
often not going to be viable to have separate servers for each different
compartment/classification, especially when considering the rainbow of
possible compartment combinations (x, y, z, xy, xz, yz, xyz)

Any thought?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
