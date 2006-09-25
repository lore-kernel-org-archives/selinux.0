Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PI6iUH021652
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 14:06:44 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PI6CaU017038
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 18:06:12 GMT
Message-Id: <20060925180641.353879000@hp.com>
References: <20060925180412.715069000@hp.com>
Date: Mon, 25 Sep 2006 14:04:16 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: tgraf@suug.ch, jmorris@redhat.com, sds@epoch.ncsc.mil,
        Paul Moore <paul.moore@hp.com>
Subject: [PATCH v2 4/8] Netlink: add nla_for_each_nested() to the interface list
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At the top of include/net/netlink.h is a list of Netlink interfaces, however,
the nla_for_each_nested() macro was not listed.  This patch adds this interface
to the list at the top of the header file.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 include/net/netlink.h |    1 +
 1 files changed, 1 insertion(+)

Index: net-2.6.19/include/net/netlink.h
===================================================================
--- net-2.6.19.orig/include/net/netlink.h
+++ net-2.6.19/include/net/netlink.h
@@ -151,6 +151,7 @@
  *   nla_parse()			parse and validate stream of attrs
  *   nla_parse_nested()			parse nested attribuets
  *   nla_for_each_attr()		loop over all attributes
+ *   nla_for_each_nested()		loop over the nested attributes
  *=========================================================================
  */
 

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
