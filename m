Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6B2B1tZ003775
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 22:11:01 -0400
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6B2B0eY021748
	for <selinux@tycho.nsa.gov>; Wed, 11 Jul 2007 02:11:00 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l6B2AJBd027588
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 22:10:19 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta003.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l6B2AKDJ011836
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2007 22:10:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: using semodule_package
Date: Tue, 10 Jul 2007 19:10:57 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD01FB6DF2@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The manpage for semodule_package gives examples for how to use it:
	semodule_package -o httpd.pp -m httpd.mod -f httpd.fc

Am I supposed to get the *.mod files for modules when I compile the
policy? I have a base.mod file, but no *.mod files for the loadable
modules. The closest that I have is <module_name>.mod.role files under
the .../policy/tmp directory.

I'd like to be able to use semodule_package to update file contexts
without having to recompile.

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
