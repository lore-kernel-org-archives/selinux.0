From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Fix a potentially uninitialised variable in SELinux hooks
To: sds@tycho.nsa.gov, jmorris@namei.org
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov
Date: Wed, 09 Jul 2008 17:10:43 +0100
Message-ID: <20080709161043.24255.62312.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix a potentially uninitialised variable in SELinux hooks that's given a
pointer to the network address by selinux_parse_skb() passing a pointer back
through its argument list.  By restructuring selinux_parse_skb(), the compiler
can see that the error case need not set it as the caller will return
immediately.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/selinux/hooks.c |   42 ++++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 18 deletions(-)


diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 85f74f6..3c87c59 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3513,38 +3513,44 @@ out:
 #endif /* IPV6 */
 
 static int selinux_parse_skb(struct sk_buff *skb, struct avc_audit_data *ad,
-			     char **addrp, int src, u8 *proto)
+			     char **_addrp, int src, u8 *proto)
 {
-	int ret = 0;
+	char *addrp;
+	int ret;
 
 	switch (ad->u.net.family) {
 	case PF_INET:
 		ret = selinux_parse_skb_ipv4(skb, ad, proto);
-		if (ret || !addrp)
-			break;
-		*addrp = (char *)(src ? &ad->u.net.v4info.saddr :
-					&ad->u.net.v4info.daddr);
-		break;
+		if (ret)
+			goto parse_error;
+		addrp = (char *)(src ? &ad->u.net.v4info.saddr :
+				       &ad->u.net.v4info.daddr);
+		goto okay;
 
 #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
 	case PF_INET6:
 		ret = selinux_parse_skb_ipv6(skb, ad, proto);
-		if (ret || !addrp)
-			break;
-		*addrp = (char *)(src ? &ad->u.net.v6info.saddr :
-					&ad->u.net.v6info.daddr);
-		break;
+		if (ret)
+			goto parse_error;
+		addrp = (char *)(src ? &ad->u.net.v6info.saddr :
+				       &ad->u.net.v6info.daddr);
+		goto okay;
 #endif	/* IPV6 */
 	default:
-		break;
+		addrp = NULL;
+		goto okay;
 	}
 
-	if (unlikely(ret))
-		printk(KERN_WARNING
-		       "SELinux: failure in selinux_parse_skb(),"
-		       " unable to parse packet\n");
-
+parse_error:
+	printk(KERN_WARNING
+	       "SELinux: failure in selinux_parse_skb(),"
+	       " unable to parse packet\n");
 	return ret;
+
+okay:
+	if (_addrp)
+		*_addrp = addrp;
+	return 0;
 }
 
 /**


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
