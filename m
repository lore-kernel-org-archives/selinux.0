Date: Fri, 12 Aug 2005 14:28:54 -0500
From: serue@us.ibm.com
To: SELinux@tycho.nsa.gov
Subject: [PATCH] check ebitmap_write return value in policydb_write
Message-ID: <20050812192854.GA7273@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch fixes a bug found by Coverity in libsepol:

	In policydb_write, the return value of ebitmap_write() is not
	checked.

Index: src/write.c
===================================================================
--- src.orig/write.c
+++ src/write.c
@@ -1514,8 +1514,10 @@ int policydb_write(policydb_t * p, struc
         }
 
 	if (policy_type == POLICY_KERN && policyvers >= POLICYDB_VERSION_AVTAB) {
-		for (i = 0; i < p->p_types.nprim; i++)
-			ebitmap_write(&p->type_attr_map[i], fp);
+		for (i = 0; i < p->p_types.nprim; i++) {
+			if (ebitmap_write(&p->type_attr_map[i], fp) == -1)
+				return -1;
+		}
 	}
 
 	return 0;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
