Return-Path: <SRS0=IDnY=ST=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D85C10F12
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 09:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D467A20835
	for <selinux@archiver.kernel.org>; Wed, 17 Apr 2019 09:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfDQJPa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Apr 2019 05:15:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbfDQJPa (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 17 Apr 2019 05:15:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 84B9ABE6E9C2EEBAC0FA;
        Wed, 17 Apr 2019 17:15:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Wed, 17 Apr 2019 17:15:24 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <paul@paul-moore.com>, <sds@tycho.nsa.gov>
CC:     <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH net] selinux: fix potential memory leak in selinux_socket_bind()
Date:   Wed, 17 Apr 2019 17:26:00 +0800
Message-ID: <20190417092600.161770-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There might be memory leak if avc_has_perm() is failed after calling
sel_netport_sid() or sel_netnode_sid(), port and node list must be deleted
and freed firstly before it goto out.
call trace:
__sys_bind
 security_socket_bind
  selinux_socket_bind
   sel_netport_sid
   sel_netnode_sid

Fixes: 3e11217263("SELinux: Add network port SID cache")
Fixes: 88b7d370bb("selinux: fix address family in bind() and connect() to match address/port")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 security/selinux/hooks.c           | 15 +++++++++++----
 security/selinux/include/netnode.h |  1 +
 security/selinux/include/netport.h |  1 +
 security/selinux/netnode.c         | 38 ++++++++++++++++++++++++++++++++++++++
 security/selinux/netport.c         | 27 +++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d5fdcb0..9f60336 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4570,8 +4570,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 						   sksec->sid, sid,
 						   sksec->sclass,
 						   SOCKET__NAME_BIND, &ad);
-				if (err)
+				if (err) {
+					sel_netport_remove(sk->sk_protocol, snum);
 					goto out;
+				}
 			}
 		}
 
@@ -4598,9 +4600,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		}
 
 		err = sel_netnode_sid(addrp, family_sa, &sid);
-		if (err)
+		if (err) {
+			sel_netport_remove(sk->sk_protocol, snum);
 			goto out;
-
+		}
 		if (family_sa == AF_INET)
 			ad.u.net->v4info.saddr = addr4->sin_addr.s_addr;
 		else
@@ -4609,9 +4612,13 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		err = avc_has_perm(&selinux_state,
 				   sksec->sid, sid,
 				   sksec->sclass, node_perm, &ad);
-		if (err)
+		if (err) {
+			sel_netport_remove(sk->sk_protocol, snum);
+			sel_netnode_remove(addrp, family_sa);
 			goto out;
+		}
 	}
+
 out:
 	return err;
 err_af:
diff --git a/security/selinux/include/netnode.h b/security/selinux/include/netnode.h
index 937668d..a5b2221 100644
--- a/security/selinux/include/netnode.h
+++ b/security/selinux/include/netnode.h
@@ -30,5 +30,6 @@
 void sel_netnode_flush(void);
 
 int sel_netnode_sid(void *addr, u16 family, u32 *sid);
+void sel_netnode_remove(void *addr, u16 family);
 
 #endif
diff --git a/security/selinux/include/netport.h b/security/selinux/include/netport.h
index d1ce896..5bd4d04 100644
--- a/security/selinux/include/netport.h
+++ b/security/selinux/include/netport.h
@@ -29,5 +29,6 @@
 void sel_netport_flush(void);
 
 int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid);
+void sel_netport_remove(u8 protocol, u16 pnum);
 
 #endif
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index afa0d43..a91fbd9 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -185,6 +185,44 @@ static void sel_netnode_insert(struct sel_netnode *node)
 }
 
 /**
+ * sel_netnode_remove - Remove a node from the table
+ * @node: the node to remove
+ *
+ * Description:
+ * Remove a node record from the network address hash table.
+ *
+ */
+void sel_netnode_remove(void *addr, u16 family)
+{
+	unsigned int idx;
+	struct sel_netnode *node;
+
+	spin_lock_bh(&sel_netnode_lock);
+	node = sel_netnode_find(addr, family);
+	if (node == NULL) {
+		spin_unlock_bh(&sel_netnode_lock);
+		return;
+	}
+
+	switch (node->nsec.family) {
+	case PF_INET:
+		idx = sel_netnode_hashfn_ipv4(node->nsec.addr.ipv4);
+		break;
+	case PF_INET6:
+		idx = sel_netnode_hashfn_ipv6(&node->nsec.addr.ipv6);
+		break;
+	default:
+		BUG();
+		return;
+	}
+
+	list_del_rcu(&node->list);
+	kfree_rcu(node, rcu);
+	sel_netnode_hash[idx].size--;
+	spin_unlock_bh(&sel_netnode_lock);
+}
+
+/**
  * sel_netnode_sid_slow - Lookup the SID of a network address using the policy
  * @addr: the IP address
  * @family: the address family
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 7a141ca..258db2f 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -134,6 +134,33 @@ static void sel_netport_insert(struct sel_netport *port)
 }
 
 /**
+ * sel_netport_remove - Remove a port from the table
+ * @port: the port to remove
+ *
+ * Description:
+ * Remove a port record from the network address hash table.
+ *
+ */
+void sel_netport_remove(u8 protocol, u16 pnum)
+{
+	unsigned int idx;
+	struct sel_netport *port;
+
+	spin_lock_bh(&sel_netport_lock);
+	port = sel_netport_find(protocol, pnum);
+	if (port == NULL) {
+		spin_unlock_bh(&sel_netport_lock);
+		return;
+	}
+
+	idx = sel_netport_hashfn(port->psec.port);
+	list_del_rcu(&port->list);
+	kfree_rcu(port, rcu);
+	sel_netport_hash[idx].size--;
+	spin_unlock_bh(&sel_netport_lock);
+}
+
+/**
  * sel_netport_sid_slow - Lookup the SID of a network address using the policy
  * @protocol: protocol
  * @pnum: port
-- 
2.7.4

