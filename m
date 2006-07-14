Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6EIxLGQ003851
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 14:59:21 -0400
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6EIxK48023453
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 18:59:20 GMT
Message-Id: <20060714185918.218850000@flek.zko.hp.com>
References: <20060714185739.780700000@flek.zko.hp.com>
Date: Fri, 14 Jul 2006 14:57:46 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: davem@davemloft.net, sds@epoch.ncsc.mil, jmorris@redhat.com,
        pratt@argus-systems.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 7/7] NetLabel: tie NetLabel into the Kconfig system
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Modify the net/Kconfig file to enable selecting the NetLabel Kconfig options.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/Kconfig |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.18-rc1/net/Kconfig
===================================================================
--- linux-2.6.18-rc1.orig/net/Kconfig
+++ linux-2.6.18-rc1/net/Kconfig
@@ -249,6 +249,8 @@ source "net/ieee80211/Kconfig"
 config WIRELESS_EXT
 	bool
 
+source "net/netlabel/Kconfig"
+
 endif   # if NET
 endmenu # Networking
 

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
