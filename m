Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA23640
	for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2001 18:11:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA17815
	for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2001 22:10:38 GMT
Received: from truffula.epoch.ncsc.mil (truffula.epoch.ncsc.mil [144.51.25.134])
	by jazzband.ncsc.mil  with ESMTP id WAA17811
	for <selinux@tycho.nsa.gov>; Thu, 27 Sep 2001 22:10:38 GMT
Received: (from hdholm@localhost)
	by truffula.epoch.ncsc.mil (8.11.2/8.11.2) id f8RMB5R18094
	for selinux@tycho.nsa.gov; Thu, 27 Sep 2001 18:11:05 -0400
Date: Thu, 27 Sep 2001 18:11:05 -0400
From: Howard Holm <hdholm@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Subject: Updated release
Message-ID: <20010927181105.E17962@truffula.epoch.ncsc.mil>
References: <20010824103052.A29235@truffula.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010824103052.A29235@truffula.epoch.ncsc.mil>; from hdholm@epoch.ncsc.mil on Fri, Aug 24, 2001 at 10:30:52AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux web site including the mail list archive has been updated.
The site includes a new release of the LSM-based SELinux prototype.
This release contains many bug fixes and improvements to both LSM and
SELinux and is based on the lsm-2001_09_23 patch against kernel 2.4.10.
The release includes new and reworked hooks to control additional
operations.

The policy now includes hwclock_t and ping_t domains for hwclock and
ping (from David Wheeler,) an ipsec_t domain for the FreeSWAN IKE
daemon and programs (from Mark Westerman,) and an httpd_t domain
for Apache (from MITRE.)  None of these has been extensively tested
by the NSA SELinux team, and they may require some additional work.
Note that we have not yet included any FreeSWAN or Apache components
in the material distributed with SELinux.

We have chosen not to release patches to our previous patches.  You will
need a complete set of patches or the complete (already patched) source
code.  We believe that the patches to patches were not being utilized
enough to justify the work to create them.  If you would rather apply
updates as patches to our previous patches, please notify me directly
at the address below so we can gauge the interest.

--
Howard Holm <hdholm@epoch.ncsc.mil>
Secure Systems Research Office
National Security Agency

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
