Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LH3dKg019045
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 13:03:39 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LH39cD001837
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 17:03:10 GMT
Message-Id: <20060921165703.251871000@hp.com>
Date: Thu, 21 Sep 2006 12:57:03 -0400
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org
Cc: sds@epoch.ncsc.mil, jmorris@redhat.com, tgraf@suug.ch
Subject: [PATCH 0/6] NetLabel fixes and reworked Netlink interface
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset, made against net-2.6.19, contains a collection of fixes for bugs found over the past few weeks as well as reworked Netlink interface which should bring NetLabel more inline with common Netlink methods.  My apologies for not getting this out sooner, but the Netlink interface rewrite was a bit more involved than I originally thought.  For those wishing to test/use these patches you will need a new copy of netlabel_tools; you can get a working version from the SVN respository at http://netlabel.sf.net.

I have tested these patches and verified that they work and solve all known issues.  Please review and consider them for 2.6.19.

Thanks.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
