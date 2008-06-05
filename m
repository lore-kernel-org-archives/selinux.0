Subject: [patch] libsepol:  fix endianness bug in network node address
	handling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Eric Paris <eparis@parisplace.org>, Joshua Brindle <jbrindle@tresys.com>,
        John Weeks <John.Weeks@sun.com>
Content-Type: text/plain
Date: Thu, 05 Jun 2008 09:45:33 -0400
Message-Id: <1212673533.2763.50.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix an endianness bug in the handling of network node addresses by
SELinux.  This yields no change on little endian hardware but fixes
the incorrect handling on big endian hardware.  The network node
addresses are stored in network order in memory by checkpolicy, not in
cpu/host order, and thus should not have cpu_to_le32/le32_to_cpu
conversions applied upon policy write/read unlike other data in the
policy.

Note that checkpolicy was also broken in its handling of ipv4
addresses on big endian hardware prior to checkpolicy 2.0.5 when the
ipv4 address handling was changed to be more like the ipv6 address
handling.

Bug reported by John Weeks of Sun, who noticed that binary policy
files built from the same policy source on x86 and sparc differed and
tracked it down to the ipv4 address handling in checkpolicy.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libsepol/include/sepol/policydb/policydb.h |    8 ++++----
 libsepol/src/policydb.c                    |   10 ++++------
 libsepol/src/write.c                       |   10 ++++------
 3 files changed, 12 insertions(+), 16 deletions(-)

Index: trunk/libsepol/include/sepol/policydb/policydb.h
===================================================================
--- trunk/libsepol/include/sepol/policydb/policydb.h	(revision 2890)
+++ trunk/libsepol/include/sepol/policydb/policydb.h	(working copy)
@@ -257,12 +257,12 @@
 			uint16_t high_port;
 		} port;		/* TCP or UDP port information */
 		struct {
-			uint32_t addr;
-			uint32_t mask;
+			uint32_t addr; /* network order */
+			uint32_t mask; /* network order */
 		} node;		/* node information */
 		struct {
-			uint32_t addr[4];
-			uint32_t mask[4];
+			uint32_t addr[4]; /* network order */
+			uint32_t mask[4]; /* network order */
 		} node6;	/* IPv6 node information */
 	} u;
 	union {
Index: trunk/libsepol/src/policydb.c
===================================================================
--- trunk/libsepol/src/policydb.c	(revision 2890)
+++ trunk/libsepol/src/policydb.c	(working copy)
@@ -2114,8 +2114,8 @@
 				rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 				if (rc < 0)
 					return -1;
-				c->u.node.addr = le32_to_cpu(buf[0]);
-				c->u.node.mask = le32_to_cpu(buf[1]);
+				c->u.node.addr = buf[0]; /* network order */
+				c->u.node.mask = buf[1]; /* network order */
 				if (context_read_and_validate
 				    (&c->context[0], p, fp))
 					return -1;
@@ -2145,11 +2145,9 @@
 					if (rc < 0)
 						return -1;
 					for (k = 0; k < 4; k++)
-						c->u.node6.addr[k] =
-						    le32_to_cpu(buf[k]);
+						c->u.node6.addr[k] = buf[k]; /* network order */
 					for (k = 0; k < 4; k++)
-						c->u.node6.mask[k] =
-						    le32_to_cpu(buf[k + 4]);
+						c->u.node6.mask[k] = buf[k + 4]; /* network order */
 					if (context_read_and_validate
 					    (&c->context[0], p, fp))
 						return -1;
Index: trunk/libsepol/src/write.c
===================================================================
--- trunk/libsepol/src/write.c	(revision 2890)
+++ trunk/libsepol/src/write.c	(working copy)
@@ -1097,8 +1097,8 @@
 					return POLICYDB_ERROR;
 				break;
 			case OCON_NODE:
-				buf[0] = cpu_to_le32(c->u.node.addr);
-				buf[1] = cpu_to_le32(c->u.node.mask);
+				buf[0] = c->u.node.addr; /* network order */
+				buf[1] = c->u.node.mask; /* network order */
 				items = put_entry(buf, sizeof(uint32_t), 2, fp);
 				if (items != 2)
 					return POLICYDB_ERROR;
@@ -1120,11 +1120,9 @@
 				break;
 			case OCON_NODE6:
 				for (j = 0; j < 4; j++)
-					buf[j] =
-					    cpu_to_le32(c->u.node6.addr[j]);
+					buf[j] = c->u.node6.addr[j]; /* network order */
 				for (j = 0; j < 4; j++)
-					buf[j + 4] =
-					    cpu_to_le32(c->u.node6.mask[j]);
+					buf[j + 4] = c->u.node6.mask[j]; /* network order */
 				items = put_entry(buf, sizeof(uint32_t), 8, fp);
 				if (items != 8)
 					return POLICYDB_ERROR;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
