Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA00554
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 13:02:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA12568
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 17:02:02 GMT
Received: from caduceus.jf.intel.com (fmr06.intel.com [134.134.136.7])
	by jazzswing.ncsc.mil  with ESMTP id RAA12564
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 17:02:01 GMT
Received: from talaria.jf.intel.com (talaria.jf.intel.com [10.7.209.7])
	by caduceus.jf.intel.com (8.11.6/8.11.6/d: outer.mc,v 1.48 2002/05/24 00:39:04 root Exp $) with ESMTP id g6TH1Eq14579
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 17:01:14 GMT
Received: from orsmsxvs040.jf.intel.com (orsmsxvs040.jf.intel.com [192.168.65.206])
	by talaria.jf.intel.com (8.11.6/8.11.6/d: inner.mc,v 1.22 2002/05/24 00:38:22 root Exp $) with SMTP id g6TGxSY06798
	for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 16:59:28 GMT
Received: from orsmsx26.jf.intel.com ([192.168.65.26])
 by orsmsxvs040.jf.intel.com (NAVGW 2.5.2.11) with SMTP id M2002072910034218452
 for <selinux@tycho.nsa.gov>; Mon, 29 Jul 2002 10:03:42 -0700
Message-ID: <D9223EB959A5D511A98F00508B68C20C0F2F05CF@orsmsx108.jf.intel.com>
From: "Menon, Sunanda R" <sunanda.r.menon@intel.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: building the kernel
Date: Mon, 29 Jul 2002 10:02:45 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I downloaded 2.4 LSM based SE linux( Option 1 everything in one part),
unzipped into SELinux directory in Redhat 6.2 Linux.
 I went thru the "Building kernel" part of the documentation. When I do the
"make menuconfig", I am getting th efollowing error:
/bin/sh scripts/menuconfig arch/i386/config.in
:commnad not found
:command not found
:command not found
scripts/menuconfig:syntax error on line 104:  'unexpected token {

Does anyone know what is the cause of this problem?



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
