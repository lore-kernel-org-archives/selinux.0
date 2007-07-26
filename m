Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6QITsx6012271
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2007 14:29:54 -0400
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6QITron025032
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2007 18:29:53 GMT
Received: from BLUMS0034.bluelnk.net (blums0034.bluelnk.net [10.40.96.55])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l6QIT4MW030335
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2007 14:29:04 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta002.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l6QITZTW000339
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2007 14:29:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: newrole and ftp
Date: Thu, 26 Jul 2007 11:29:50 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01FB7440@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I use newrole to start up an ftp server at a particular mls level,
it doesn't start the server at the specified level. For instance:

newrole -l SystemHigh -- -c "/etc/init.d/vsftpd start"

The server starts up with the range SystemLow-SystemHigh.

However, this works:

runcon -t ftpd_t -l SystemHigh /etc/init.d/vsftpd start

Anyone know why?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
