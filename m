Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PI6f06021606
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 14:06:41 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PI69aU017029
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 18:06:10 GMT
Message-Id: <20060925180412.715069000@hp.com>
Date: Mon, 25 Sep 2006 14:04:12 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: tgraf@suug.ch, jmorris@redhat.com, sds@epoch.ncsc.mil
Subject: [PATCH v2 0/8] Updated patchset with Thomas' comments
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an updated patchset which takes into account Thomas' comments.  This
includes the addition of two new patches in the patchset which add a new
Netlink interface as well as correct the list of interfaces in the large
comment block at the top of include/net/netlink.h.

Please consider these patches for 2.6.19, thanks.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
