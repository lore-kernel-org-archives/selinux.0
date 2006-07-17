Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6HFwTaE022647
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 11:58:29 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6HFwRuq027542
	for <selinux@tycho.nsa.gov>; Mon, 17 Jul 2006 15:58:28 GMT
Message-Id: <20060717155825.957956000@hp.com>
References: <20060717155224.060020000@hp.com>
Date: Mon, 17 Jul 2006 11:52:31 -0400
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

Index: linux-2.6.18-rc2/net/Kconfig
===================================================================
--- linux-2.6.18-rc2.orig/net/Kconfig
+++ linux-2.6.18-rc2/net/Kconfig
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
