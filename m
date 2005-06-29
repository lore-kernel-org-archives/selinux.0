Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5SNq8gA008650
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 19:52:08 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5SNokxl017043
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 23:50:46 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by free.hands.com (Postfix) with ESMTP id F344CBEE4
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 00:51:14 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1DnPzt-0002VB-7c
	for selinux@tycho.nsa.gov; Wed, 29 Jun 2005 01:00:09 +0100
Date: Wed, 29 Jun 2005 01:00:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: http://sourceforge.net/mailarchive/forum.php?thread_id=6364737&forum_id=35600
Message-ID: <20050629000009.GA9566@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

of interest to some mad people somewhere: ibm research's "sHype"
hypervisor security architecture.

annoyingly, it is "modelled" on flask [i say annoyingly because
they "modelled" sHype on selinux instead of incorporating
support for selinux into sHype and xen]

over the next year (starting jan 2005) they plan to do the following:

* Port sHype to Xen 

* Add stronger security/isolation guarantees (confinement)
  to what is currently available through Xen"s (and other
  hypervisors") address space separation mechanisms, e.g.,
  to enable information flow control in Xen

*  Enhance Xen to support trusted computing under Linux using
  TCG/TPM-based attestation mechanisms

*  Enhance Xen to support secure resource metering,
  verification, and control.

* Apply our experience in automated security analysis to Xen
  to make it more robust

* Make Xen suitable for Common Criteria evaluation 

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
