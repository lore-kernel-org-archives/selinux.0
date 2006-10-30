Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9UI86tc018469
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 13:08:06 -0500
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9UI7IZZ008181
	for <selinux@tycho.nsa.gov>; Mon, 30 Oct 2006 18:07:18 GMT
Message-Id: <20061030180331.404950000@hp.com>
Date: Mon, 30 Oct 2006 13:03:31 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@redhat.com, sds@epoch.ncsc.mil, eparis@redhat.com
Subject: [patch 0/1] NetLabel bugfix for 2.6.19
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry, but another bugfix patch for NetLabel which I think should be included
2.6.19.

The problem is that the SELinux reference policy is a bit more free in allowing
applications to call setsockopt() than I had originally thought, which means
that normal applications could add or tamper with the NetLabel/CIPSO options on
a socket causing all sorts of nastiness.  This patch should solve these
problems.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
