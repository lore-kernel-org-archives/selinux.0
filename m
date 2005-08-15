Subject: Re: [patch 1/2] Fix memory leaks in libsepol/checkpolicy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1123879137.23483.117.camel@moss-spartans.epoch.ncsc.mil>
References: <1123879137.23483.117.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 12:46:43 -0400
Message-Id: <1124124403.15009.90.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Additional memory leak fixes.  This patch for libsepol fixes leakage of
the role and user ebitmap caches (upon multiple calls to the index
functions), and leakage of the attribute type datums when attributes are
finally removed from the types symtab for the expanded kernel policy.

---

 src/expand.c   |    9 ++++++++-
 src/policydb.c |    2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

Index: libsepol/src/policydb.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/policydb.c,v
retrieving revision 1.23
retrieving revision 1.24
diff -u -p -r1.23 -r1.24
--- libsepol/src/policydb.c	12 Aug 2005 21:10:15 -0000	1.23
+++ libsepol/src/policydb.c	15 Aug 2005 14:05:39 -0000	1.24
@@ -429,6 +429,7 @@ int policydb_role_cache(hashtab_key_t ke
 	role = (role_datum_t *)datum;
 	p = (policydb_t *)arg;
 
+	ebitmap_destroy(&role->cache);
 	if (type_set_expand(&role->types, &role->cache, p, 1)) {
 		return -1;
 	}
@@ -444,6 +445,7 @@ int policydb_user_cache(hashtab_key_t ke
 	user = (user_datum_t *)datum;
 	p = (policydb_t *)arg;
 
+	ebitmap_destroy(&user->cache);
 	if (role_set_expand(&user->roles, &user->cache, p)) {
 		return -1;
 	}
Index: libsepol/src/expand.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/expand.c,v
retrieving revision 1.5
diff -u -p -r1.5 expand.c
--- libsepol/src/expand.c	11 Aug 2005 15:43:14 -0000	1.5
+++ libsepol/src/expand.c	15 Aug 2005 15:56:04 -0000
@@ -1433,6 +1433,13 @@ static int type_attr_map(hashtab_key_t k
 	return 0;
 }
 
+static void type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
+{
+	free(key);
+	type_datum_destroy((type_datum_t*) datum);
+	free(datum);
+}
+
 static int type_attr_remove(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	type_datum_t *typdatum;
@@ -1886,7 +1893,7 @@ int expand_module(policydb_t *base, poli
 			&state))
 		goto cleanup;
 	hashtab_map_remove_on_error(state.out->p_types.table, 
-				    type_attr_remove, 0, 0);
+				    type_attr_remove, type_destroy, 0);
 	
         retval = 0;
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
