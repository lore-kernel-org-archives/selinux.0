Message-Id: <20060803201559.266161000@flek.zko.hp.com>
References: <20060803200928.721027000@flek.zko.hp.com>
Date: Thu, 03 Aug 2006 16:09:35 -0400
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: linda.knippers@hp.com, sds@tycho.nsa.gov, jmorris@namei.org,
        davem@davemloft.net, Paul Moore <paul.moore@hp.com>
Subject: [PATCH-v01 7/7] NetLabel: tie NetLabel into the Kconfig system
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Modify the net/Kconfig file to enable selecting the NetLabel Kconfig options.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/Kconfig |    2 ++
 1 files changed, 2 insertions(+)

Index: net-2.6.19/net/Kconfig
===================================================================
--- net-2.6.19.orig/net/Kconfig
+++ net-2.6.19/net/Kconfig
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
