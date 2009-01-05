Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n05MSSml026641
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2009 17:28:28 -0500
Received: from g5t0007.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n05MSRgh026835
	for <selinux@tycho.nsa.gov>; Mon, 5 Jan 2009 22:28:27 GMT
Received: from g4t0009.houston.hp.com (g4t0009.houston.hp.com [16.234.32.26])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id D3B7C146E8
	for <selinux@tycho.nsa.gov>; Mon,  5 Jan 2009 22:28:26 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g4t0009.houston.hp.com (Postfix) with ESMTP id A30D2C038
	for <selinux@tycho.nsa.gov>; Mon,  5 Jan 2009 22:28:26 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 3B61D39C074
	for <selinux@tycho.nsa.gov>; Mon,  5 Jan 2009 15:28:26 -0700 (MST)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A3WAOA-Gtasp for <selinux@tycho.nsa.gov>;
	Mon,  5 Jan 2009 15:28:24 -0700 (MST)
Received: from flek.lan (squirrel.fc.hp.com [15.11.146.57])
	by ldl.fc.hp.com (Postfix) with ESMTP id A72A939C00E
	for <selinux@tycho.nsa.gov>; Mon,  5 Jan 2009 15:28:24 -0700 (MST)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: ANN: netlabel_tools version 0.19
Date: Mon, 5 Jan 2009 17:28:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200901051728.23731.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello everyone,

A new year (2009), a new kernel (2.6.28) and now a new netlabel_tools 
package (0.19).  The most important part of the new NetLabel userspace 
package is support for the new features added to kernel 2.6.28: address 
selectors and native LSM/SELinux labeling.  The full changelog is 
posted below.

I'll be "documenting" the new features soon but in the meantime you can 
always check the included documentation (I may be biased but I think 
the netlabelctl manpage is quite good) or send mail to me or the list.

Thanks, and enjoy!

 * http://netlabel.sf.net

ChangeLog:
o Added address selector support to the LSM domain mapping mechanism
o Added support for the new CIPSO_V4_MAP_LOCAL CIPSO mapping type to
  allow native LSM security labels over local connections
o General code cleanup, including style changes/fixes; focused primarily
  on libnetlabel
o Initial doxygen support, including slightly improved documentation for
  the libnetlabel API; doxygen docs built by default if doxygen is
  detected
o Man page updates for netlabelctl
o Preliminary support for building libnetlabel as a shared library, not
  enabled by default (see libnetlabel/Makefile to enable)
o Removed empty and unused directories to make the package cleaner and
  easier to understand

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
