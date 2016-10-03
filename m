Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93AkQaC004966
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 06:46:26 -0400
Received: from workstation.home ([86.151.246.244]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0LrePN-1avAN009mf-013R5m for
 <selinux@tycho.nsa.gov>; Mon, 03 Oct 2016 12:46:23 +0200
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsepol/cil: create user and role caches when building
 binary policy
Date: Mon,  3 Oct 2016 11:46:19 +0100
Message-Id: <ee13bc88daffcc4d136ed0d41ca8348ca3c16e36.1475491349.git.gary.tierney@gmx.com>
In-Reply-To: <cover.1475491349.git.gary.tierney@gmx.com>
References: <cover.1475491349.git.gary.tierney@gmx.com>
In-Reply-To: <cover.1475491349.git.gary.tierney@gmx.com>
References: <cover.1475491349.git.gary.tierney@gmx.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Pre-expands the role and user caches used in context validation when
conerting a cildb to a binary policydb.  This is currently only done
when loading a binary policy and prevents context validation from
working correctly with a newly built policy (i.e., when semanage builds
a new policy and then runs genhomedircon).

Also adds declarations for the hashtable mapping functions used:
policydb_role_cache and policydb_user_cache().

Signed-off-by: Gary Tierney <gary.tierney@gmx.com>
---
 libsepol/cil/src/cil_binary.c              | 7 +++++++
 libsepol/include/sepol/policydb/policydb.h | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index cc73648..200101e 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4794,6 +4794,13 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 
 	}
 
+	/* This pre-expands the roles and users for context validity checking */
+	if (hashtab_map(pdb->p_roles.table, policydb_role_cache, pdb))
+		return -1;
+
+	if (hashtab_map(pdb->p_users.table, policydb_user_cache, pdb))
+		return -1;
+
 	rc = SEPOL_OK;
 
 exit:
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 26cec13..d99fcf4 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -608,6 +608,14 @@ extern int policydb_index_bools(policydb_t * p);
 extern int policydb_index_others(sepol_handle_t * handle, policydb_t * p,
 				 unsigned int verbose);
 
+extern int policydb_role_cache(hashtab_key_t key,
+			       hashtab_datum_t datum,
+			       void *arg);
+
+extern int policydb_user_cache(hashtab_key_t key,
+			       hashtab_datum_t datum,
+			       void *arg);
+
 extern int policydb_reindex_users(policydb_t * p);
 
 extern void policydb_destroy(policydb_t * p);
-- 
2.4.11
