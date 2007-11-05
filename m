Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA5MXgX6008522
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 17:33:42 -0500
Received: from dmzmta102.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA5MXeZr002429
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 22:33:41 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id lA5MVmVQ011580
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 17:31:48 -0500
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id lA5MWd1G012329
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 17:32:40 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: permissions to create directories in the /tmp directory
Date: Mon, 5 Nov 2007 14:33:37 -0800
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD02554E7E@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there an interface that gives permissions to create directories in
the /tmp dir (allow ... tmp_t:dir create)?

I couldn't find one. I found files_manage_generic_tmp_files in files.if,
but this doesn't do it. It allows creating files but not directories of
type tmp_t. I ended up adding an interface to files.if myself, but I
figure that has to have come up already.

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
