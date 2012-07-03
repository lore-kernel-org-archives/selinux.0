Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q63Hja0c022407
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2012 13:45:37 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q63HjYOi006138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2012 13:45:35 -0400
Subject: [RFC PATCH v2 1/2] selinux: cleanup the security_node_sid() function
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: dwalsh@redhat.com, eparis@redhat.com
Date: Tue, 03 Jul 2012 13:45:30 -0400
Message-ID: <20120703174512.10504.97654.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove some unnecessary arguments and simplify the function as a
result.

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/include/security.h |    3 +--
 security/selinux/netnode.c          |    6 ++----
 security/selinux/ss/services.c      |   28 ++++++----------------------
 3 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index dde2005..81c5838 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -144,8 +144,7 @@ int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
 
 int security_netif_sid(char *name, u32 *if_sid);
 
-int security_node_sid(u16 domain, void *addr, u32 addrlen,
-	u32 *out_sid);
+int security_node_sid(u16 family, void *addr, u32 *out_sid);
 
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 				 u16 tclass);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 28f911c..8d5a490 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -213,13 +213,11 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
 		goto out;
 	switch (family) {
 	case PF_INET:
-		ret = security_node_sid(PF_INET,
-					addr, sizeof(struct in_addr), sid);
+		ret = security_node_sid(PF_INET, addr, sid);
 		new->nsec.addr.ipv4 = *(__be32 *)addr;
 		break;
 	case PF_INET6:
-		ret = security_node_sid(PF_INET6,
-					addr, sizeof(struct in6_addr), sid);
+		ret = security_node_sid(PF_INET6, addr, sid);
 		new->nsec.addr.ipv6 = *(struct in6_addr *)addr;
 		break;
 	default:
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4321b8f..e8fd07d 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2070,30 +2070,20 @@ static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
 
 /**
  * security_node_sid - Obtain the SID for a node (host).
- * @domain: communication domain aka address family
+ * @family: address family
  * @addrp: address
- * @addrlen: address length in bytes
  * @out_sid: security identifier
  */
-int security_node_sid(u16 domain,
-		      void *addrp,
-		      u32 addrlen,
-		      u32 *out_sid)
+int security_node_sid(u16 family, void *addrp, u32 *out_sid)
 {
-	int rc;
+	int rc = 0;
 	struct ocontext *c;
 
 	read_lock(&policy_rwlock);
 
-	switch (domain) {
+	switch (family) {
 	case AF_INET: {
-		u32 addr;
-
-		rc = -EINVAL;
-		if (addrlen != sizeof(u32))
-			goto out;
-
-		addr = *((u32 *)addrp);
+		u32 addr = *((u32 *)addrp);
 
 		c = policydb.ocontexts[OCON_NODE];
 		while (c) {
@@ -2105,9 +2095,6 @@ int security_node_sid(u16 domain,
 	}
 
 	case AF_INET6:
-		rc = -EINVAL;
-		if (addrlen != sizeof(u64) * 2)
-			goto out;
 		c = policydb.ocontexts[OCON_NODE6];
 		while (c) {
 			if (match_ipv6_addrmask(addrp, c->u.node6.addr,
@@ -2118,7 +2105,6 @@ int security_node_sid(u16 domain,
 		break;
 
 	default:
-		rc = 0;
 		*out_sid = SECINITSID_NODE;
 		goto out;
 	}
@@ -2132,11 +2118,9 @@ int security_node_sid(u16 domain,
 				goto out;
 		}
 		*out_sid = c->sid[0];
-	} else {
+	} else
 		*out_sid = SECINITSID_NODE;
-	}
 
-	rc = 0;
 out:
 	read_unlock(&policy_rwlock);
 	return rc;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
