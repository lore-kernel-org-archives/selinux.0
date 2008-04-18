From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 03/13] SELinux: netlink.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:24 -0400
Message-Id: <12085547142711-git-send-email-eparis@redhat.com>
In-Reply-To: <12085547142360-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes netlink.c to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

whitespace at end of lines
spaces followed by tabs
spaces used instead of tabs
spacing around parenthesis
locateion of { around struct and else clauses
location of * in pointer declarations
removal of initialization of static data to keep it in the right section
useless {} in if statemetns
useless checking for NULL before kfree
fixing of the indentation depth of switch statements
and any number of other things I forgot to mention

Signed-off-by: Eric Paris <eparis@redhat.com>

---
 security/selinux/netlink.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 6214a7a..1ae5564 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -24,16 +24,16 @@ static struct sock *selnl;
 static int selnl_msglen(int msgtype)
 {
 	int ret = 0;
-	
+
 	switch (msgtype) {
 	case SELNL_MSG_SETENFORCE:
 		ret = sizeof(struct selnl_msg_setenforce);
 		break;
-	
+
 	case SELNL_MSG_POLICYLOAD:
 		ret = sizeof(struct selnl_msg_policyload);
 		break;
-		
+
 	default:
 		BUG();
 	}
@@ -45,15 +45,15 @@ static void selnl_add_payload(struct nlmsghdr *nlh, int len, int msgtype, void *
 	switch (msgtype) {
 	case SELNL_MSG_SETENFORCE: {
 		struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
-		
+
 		memset(msg, 0, len);
 		msg->val = *((int *)data);
 		break;
 	}
-	
+
 	case SELNL_MSG_POLICYLOAD: {
 		struct selnl_msg_policyload *msg = NLMSG_DATA(nlh);
-		
+
 		memset(msg, 0, len);
 		msg->seqno = *((u32 *)data);
 		break;
@@ -70,9 +70,9 @@ static void selnl_notify(int msgtype, void *data)
 	sk_buff_data_t tmp;
 	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
-	
+
 	len = selnl_msglen(msgtype);
-	
+
 	skb = alloc_skb(NLMSG_SPACE(len), GFP_USER);
 	if (!skb)
 		goto oom;
@@ -85,7 +85,7 @@ static void selnl_notify(int msgtype, void *data)
 	netlink_broadcast(selnl, skb, 0, SELNLGRP_AVC, GFP_USER);
 out:
 	return;
-	
+
 nlmsg_failure:
 	kfree_skb(skb);
 oom:
@@ -109,7 +109,7 @@ static int __init selnl_init(void)
 				      SELNLGRP_MAX, NULL, NULL, THIS_MODULE);
 	if (selnl == NULL)
 		panic("SELinux:  Cannot create netlink socket.");
-	netlink_set_nonroot(NETLINK_SELINUX, NL_NONROOT_RECV);	
+	netlink_set_nonroot(NETLINK_SELINUX, NL_NONROOT_RECV);
 	return 0;
 }
 
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
