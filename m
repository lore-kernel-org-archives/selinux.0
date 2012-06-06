From: Chris PeBenito <cpebenito@tresys.com>
To: <SELinux@tycho.nsa.gov>
CC: Chris PeBenito <cpebenito@tresys.com>
Subject: [PATCH 2/2] Update SELinux policy capability to always check peer class.
Date: Wed, 6 Jun 2012 13:28:51 -0400
Message-ID: <1339003731-6743-2-git-send-email-cpebenito@tresys.com>
In-Reply-To: <1339003731-6743-1-git-send-email-cpebenito@tresys.com>
References: <1339003731-6743-1-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Update the always_check_network policy capability which, when enabled,
treats peer labeling as enabled, even if there is no Netlabel or
labeled IPSEC configuration.

Signed-off-by: Chris PeBenito <cpebenito@tresys.com>
---
 security/selinux/hooks.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ec7151b..01c52b7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -149,6 +149,24 @@ static int selinux_secmark_enabled(void)
 		return (atomic_read(&selinux_secmark_refcount) > 0);
 }
 
+/**
+ * selinux_peerlbl_enabled - Check to see if peer labeling is currently enabled
+ *
+ * Description:
+ * This function checks if NetLabel or labeled IPSEC is enabled.  Returns true
+ * (1) if any are enabled or false (0) if neither are enabled.  If the
+ * always_check_network policy capability is enabled, peer labeling
+ * is always considered enabled.
+ *
+ */
+static int selinux_peerlbl_enabled(void)
+{
+	if (selinux_policycap_alwaysnetwork)
+		return 1;
+	else
+		return (netlbl_enabled() || selinux_xfrm_enabled());
+}
+
 /*
  * initialise the security for the init task
  */
@@ -4188,7 +4206,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		return selinux_sock_rcv_skb_compat(sk, skb, family);
 
 	secmark_active = selinux_secmark_enabled();
-	peerlbl_active = netlbl_enabled() || selinux_xfrm_enabled();
+	peerlbl_active = selinux_peerlbl_enabled();
 	if (!secmark_active && !peerlbl_active)
 		return 0;
 
-- 
1.7.8.6


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
