Subject: [patch] selinux:  fix endianness bug in network node address
	handling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
        John Weeks <John.Weeks@sun.com>
Content-Type: text/plain
Date: Thu, 05 Jun 2008 09:48:51 -0400
Message-Id: <1212673731.2763.54.camel@moss-spartans.epoch.ncsc.mil>
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

Bug reported by John Weeks of Sun, who noticed that binary policy
files built from the same policy source on x86 and sparc differed and
tracked it down to the ipv4 address handling in checkpolicy.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/ss/policydb.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 84f8cc7..2391761 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1478,7 +1478,8 @@ int policydb_read(struct policydb *p, void *fp)
 	struct ocontext *l, *c, *newc;
 	struct genfs *genfs_p, *genfs, *newgenfs;
 	int i, j, rc;
-	__le32 buf[8];
+	__le32 buf[4];
+	u32 nodebuf[8];
 	u32 len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
@@ -1749,11 +1750,11 @@ int policydb_read(struct policydb *p, void *fp)
 					goto bad;
 				break;
 			case OCON_NODE:
-				rc = next_entry(buf, fp, sizeof(u32) * 2);
+				rc = next_entry(nodebuf, fp, sizeof(u32) * 2);
 				if (rc < 0)
 					goto bad;
-				c->u.node.addr = le32_to_cpu(buf[0]);
-				c->u.node.mask = le32_to_cpu(buf[1]);
+				c->u.node.addr = nodebuf[0]; /* network order */
+				c->u.node.mask = nodebuf[1]; /* network order */
 				rc = context_read_and_validate(&c->context[0], p, fp);
 				if (rc)
 					goto bad;
@@ -1782,13 +1783,13 @@ int policydb_read(struct policydb *p, void *fp)
 			case OCON_NODE6: {
 				int k;
 
-				rc = next_entry(buf, fp, sizeof(u32) * 8);
+				rc = next_entry(nodebuf, fp, sizeof(u32) * 8);
 				if (rc < 0)
 					goto bad;
 				for (k = 0; k < 4; k++)
-					c->u.node6.addr[k] = le32_to_cpu(buf[k]);
+					c->u.node6.addr[k] = nodebuf[k];
 				for (k = 0; k < 4; k++)
-					c->u.node6.mask[k] = le32_to_cpu(buf[k+4]);
+					c->u.node6.mask[k] = nodebuf[k+4];
 				if (context_read_and_validate(&c->context[0], p, fp))
 					goto bad;
 				break;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
