Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k85IfkQM014184
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 14:41:46 -0400
Received: from fryspc.bruzenak.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k85If1N8025452
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 18:41:02 GMT
Received: from fryspc.bruzenak.com (localhost.localdomain [127.0.0.1])
	by fryspc.bruzenak.com (8.13.1/8.13.1) with ESMTP id k85Ifgnu005073
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 13:41:42 -0500
Received: (from lenny@localhost)
	by fryspc.bruzenak.com (8.13.1/8.13.1/Submit) id k85Ifg8u005072
	for selinux@tycho.nsa.gov; Tue, 5 Sep 2006 13:41:42 -0500
Subject: mls policy problem
From: LC Bruzenak <lenny@bruzenak.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 05 Sep 2006 13:41:41 -0500
Message-Id: <1157481701.4164.13.camel@fryspc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Trying to yum install the selinux-policy-mls policy I get:
  
Installing: selinux-policy-mls           ######################### [1/1]
libsepol.sepol_module_package_read: unknown magic number at section 4,
offset: a2ba9e, number: 159186835x
/var/tmp/rpm-tmp.90280: line 4:  2833 Segmentation fault      semodule -
b base.pp -s mls

# uname -a:

Linux ibm 2.6.17-1.2614.fc6 #1 SMP Sun Sep 3 15:16:56 EDT 2006 x86_64
x86_64 x86_64 GNU/Linux

Let me know what info I should send; didn't want to overload the first
plea for help.

Thanks,
Lenny.

-- 
LC Bruzenak
lenny@bruzenak.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
