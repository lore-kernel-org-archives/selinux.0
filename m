Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LH3fWP019081
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 13:03:41 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LH3BcD001848
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 17:03:12 GMT
Message-Id: <20060921170338.666423000@hp.com>
References: <20060921165703.251871000@hp.com>
Date: Thu, 21 Sep 2006 12:57:09 -0400
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org
Cc: sds@epoch.ncsc.mil, jmorris@redhat.com, tgraf@suug.ch,
        Paul Moore <paul.moore@hp.com>
Subject: [PATCH 6/6] NetLabel: update docs with website information
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now that all of the supporting pieces of NetLabel have a home at SourceForge
update the Kconfig help text and add an entry to the MAINTAINERS file.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 MAINTAINERS          |    7 +++++++
 net/netlabel/Kconfig |    5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

Index: net-2.6.19/MAINTAINERS
===================================================================
--- net-2.6.19.orig/MAINTAINERS
+++ net-2.6.19/MAINTAINERS
@@ -2008,6 +2008,13 @@ L:	netfilter@lists.netfilter.org
 L:	netfilter-devel@lists.netfilter.org
 S:	Supported
 
+NETLABEL
+P:	Paul Moore
+M:	paul.moore@hp.com
+W:	http://netlabel.sf.net
+L:	netdev@vger.kernel.org
+S:	Supported
+
 NETROM NETWORK LAYER
 P:	Ralf Baechle
 M:	ralf@linux-mips.org
Index: net-2.6.19/net/netlabel/Kconfig
===================================================================
--- net-2.6.19.orig/net/netlabel/Kconfig
+++ net-2.6.19/net/netlabel/Kconfig
@@ -9,6 +9,9 @@ config NETLABEL
 	---help---
 	  NetLabel provides support for explicit network packet labeling
 	  protocols such as CIPSO and RIPSO.  For more information see
-	  Documentation/netlabel.
+	  Documentation/netlabel as well as the NetLabel SourceForge project
+	  for configuration tools and additional documentation.
+
+	   * http://netlabel.sf.net
 
 	  If you are unsure, say N.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
