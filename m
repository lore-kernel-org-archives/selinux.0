Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2IKA0i7010763
	for <selinux@tycho.nsa.gov>; Wed, 18 Mar 2009 16:10:00 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id n2IK6BaH021559
	for <selinux@tycho.nsa.gov>; Wed, 18 Mar 2009 20:06:11 GMT
Date: Wed, 18 Mar 2009 16:09:59 -0400
Subject: [ANN] CLIP v3.1.0 for RHEL 5.3
From: Brandon Whalen <bwhalen@tresys.com>
To: <selinux@tycho.nsa.gov>
Message-ID: <C5E6CD57.1D3AE%bwhalen@tresys.com>
In-Reply-To: <C5E6C84E.1D3A9%bwhalen@tresys.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Version 3.1.0 of the Certifiable Linux Integration Platform (CLIP) for RHEL
5.3 is now publicly available. Pre compiled RPMS are available for download
at [1] and the entire source tree is available for download at [2]. Any
feedback about this release can be sent to the CLIP mailing list[3].

CLIP is a toolkit that creates a base platform upon which system developers
can produce secure, certifiable solutions. The major benefits of the CLIP
toolkit are:
* A system configured to meet a set of security requirements
* A mapping of the configured system against a set of security requirents
* Updated packages to provide support in meeting the security requirements

CLIP version 3.1.0 for RHEL 5.3 specifically provides:
* A system configuration mapped against every impact level of the National
Security Systems Instruction (NSSI) 1253
* Updated IPTables package to support SECMARK
* Updated SELinux policy tuned to the specific needs of the NSSI 1253
* Updated PAM module to support the dynamic login requirements of the NSSI
1253
* Updated SELinux userland packages to support new features of the SELinux
policy
* A system configuration that meets the DISA SRR released in February 2009
* Documentation mapping the default system configuration against all impact
levels of the NSSI 1253[4]


[1] http://oss.tresys.com/projects/clip/wiki/DownloadRelease
[2] http://oss.tresys.com/projects/clip/wiki/SubversionCheckout
[3] http://oss.tresys.com/mailman/listinfo/clip
[4] This document will be available after customer approval


Brandon Whalen        Tresys Technology
v: 443-539-0747       Suite 2100
f: 410-953-0494       8840 Stanford Blvd
bwhalen@tresys.com    Columbia, MD 21045


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
