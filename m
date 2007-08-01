Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l71EV3Ww031810
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 10:31:03 -0400
Received: from dmzmta103.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l71EV2fE002467
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 14:31:02 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta103.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l71EU7na016258
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 10:30:07 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l71ETdof016336
	for <selinux@tycho.nsa.gov>; Wed, 1 Aug 2007 10:29:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: mounted file systems
Date: Wed, 1 Aug 2007 07:30:58 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01FB761B@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there any way to maintain a file system's labels, when that file
system is mounted from one SELinux box to another?

My experience is that I can only apply a single label to the entire
mounted file system, so that I lose the diversity of labels that existed
on the original file system. 

I'm wondering if there is another approach that would work better or if
there are any plans for future support for this.

Thanks 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
