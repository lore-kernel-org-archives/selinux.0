Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6PGehgA024386
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 12:40:44 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6PGYYAP029887
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 16:34:34 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6PGZK51018189
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 12:35:20 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6PGZKV30136
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 12:35:20 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6PGZKMT012659
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2005 12:35:20 -0400
Subject: [ libsepol 9 ] remove printf from write and services
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-cIwvqOc01+lelAogu5kR"
Date: Mon, 25 Jul 2005 12:32:43 -0400
Message-Id: <1122309163.3546.54.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-cIwvqOc01+lelAogu5kR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch converts write.c and services.c 
to the new debug system merged. There's more files
left to be changed.

Note: We need to decide what's the goal with debugging messages.
Some code assumes the goal to be status-like output, to 
be read by the end user. Other code writes cryptic messages
not suitable for such a purpose. I personally think
the goal of the debugging system should be for debugging,
while status codes should be used for other purposes.
That's what I've assumed in the other patches which
I sent earlier - they provide extra-verbose output
at every level of the function stack, to make debugging
easier. They might confuse the end user.

This patch will now print "libsepol.fname: "
for every error message, which is not too user 
friendly, but neither is "security_compute_av: blah".

Also, this allows callback I/O, rather than
hardcoding stdout/stderr, and allows the user
to drop the function name if desired 
(since it's a separate argument).



--=-cIwvqOc01+lelAogu5kR
Content-Disposition: attachment; filename=libsepol-3.1-write_services_printf.diff
Content-Type: text/x-patch; name=libsepol-3.1-write_services_printf.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -p -aru libsepol.work/src/services.c libsepol-3.1-write_services_printf/src/services.c
--- libsepol.work/src/services.c	2005-07-25 12:20:55.000000000 -0400
+++ libsepol-3.1-write_services_printf/src/services.c	2005-07-25 12:20:26.000000000 -0400
@@ -61,8 +61,8 @@
 #include "private.h"
 #include "av_permissions.h"
 
-#define BUG() do { printf("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); } while (0)
-#define BUG_ON(x) do { if (x) printf("Badness in %s at %s:%d\n", __FUNCTION__, __FILE__, __LINE__); } while (0)
+#define BUG() do { DEBUG(__FUNCTION__, "Badness at %s:%d\n", __FILE__, __LINE__); } while (0)
+#define BUG_ON(x) do { if (x) DEBUG(__FUNCTION__, "Badness at %s:%d\n", __FILE__, __LINE__); } while (0)
 
 static int selinux_enforcing = 1;
 
@@ -87,7 +87,7 @@ int sepol_set_policydb_from_file(FILE *f
 	pf.fp = fp;
 	pf.type = PF_USE_STDIO;
 	if (policydb_read(&mypolicydb, &pf, 0)) {
-		fprintf(stderr, "Can't read binary policy:  %s\n",
+		DEBUG(__FUNCTION__, "can't read binary policy: %s\n",
 			strerror(errno));
 		return -1;
 	}
@@ -308,8 +308,7 @@ static int context_struct_compute_av(con
 	class_datum_t *tclass_datum;
 
 	if (!tclass || tclass > policydb->p_classes.nprim) {
-		printf("security_compute_av:  unrecognized class %d\n",
-		       tclass);
+		DEBUG(__FUNCTION__, "unrecognized class %d\n", tclass);
 		return -EINVAL;
 	}
 	tclass_datum = policydb->class_val_to_struct[tclass - 1];
@@ -404,30 +403,26 @@ int sepol_validate_transition(sepol_secu
 	constraint_node_t *constraint;
 
 	if (!tclass || tclass > policydb->p_classes.nprim) {
-		printf("sepol_validate_transition:  "
-		       "unrecognized class %d\n", tclass);
+		DEBUG(__FUNCTION__, "unrecognized class %d\n", tclass);
 		return -EINVAL;
 	}
 	tclass_datum = policydb->class_val_to_struct[tclass - 1];
 
 	ocontext = sepol_sidtab_search(sidtab, oldsid);
 	if (!ocontext) {
-		printf("sepol_validate_transition: "
-		       " unrecognized SID %d\n", oldsid);
+		DEBUG(__FUNCTION__, "unrecognized SID %d\n", oldsid);
 		return -EINVAL;
 	}
 
 	ncontext = sepol_sidtab_search(sidtab, newsid);
 	if (!ncontext) {
-		printf("sepol_validate_transition: "
-		       " unrecognized SID %d\n", newsid);
+		DEBUG(__FUNCTION__, "unrecognized SID %d\n", newsid);
 		return -EINVAL;
 	}
 
 	tcontext = sepol_sidtab_search(sidtab, tasksid);
 	if (!tcontext) {
-		printf("sepol_validate_transition: "
-		       " unrecognized SID %d\n", tasksid);
+		DEBUG(__FUNCTION__, "unrecognized SID %d\n", tasksid);
 		return -EINVAL;
 	}
 
@@ -455,13 +450,13 @@ int sepol_compute_av_reason(sepol_securi
 
 	scontext = sepol_sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		printf("security_compute_av:  unrecognized SID %d\n", ssid);
+		DEBUG(__FUNCTION__, "unrecognized SID %d\n", ssid);
 		rc = -EINVAL;
 		goto out;
 	}
 	tcontext = sepol_sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		printf("security_compute_av:  unrecognized SID %d\n", tsid);
+		DEBUG(__FUNCTION__, "unrecognized SID %d\n", tsid);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -507,7 +502,7 @@ int sepol_sid_to_context(sepol_security_
 
 	context = sepol_sidtab_search(sidtab, sid);
 	if (!context) {
-		printf("security_sid_to_context:  unrecognized SID %d\n", sid);
+		DEBUG("unrecognized SID %d\n", sid);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -566,10 +561,9 @@ static inline int compute_sid_handle_inv
 		context_struct_to_string(scontext, &s, &slen);
 		context_struct_to_string(tcontext, &t, &tlen);
 		context_struct_to_string(newcontext, &n, &nlen);
-		printf("security_compute_sid:  invalid context %s", n);
-		printf(" for scontext=%s", s);
-		printf(" tcontext=%s", t);
-		printf(" tclass=%s\n", policydb->p_class_val_to_name[tclass-1]);
+		DEBUG(__FUNCTION__, "invalid context %s for "
+			"scontext=%s tcontext=%s tclass=%s\n",
+			n, s, t, policydb->p_class_val_to_name[tclass-1]);
 		free(s);
 		free(t);
 		free(n);
@@ -593,13 +587,13 @@ static int sepol_compute_sid(sepol_secur
 
 	scontext = sepol_sidtab_search(sidtab, ssid);
 	if (!scontext) {
-		printf("security_compute_sid:  unrecognized SID %d\n", ssid);
+		DEBUG(__FUNCTION__, "unrecognized SID %d\n", ssid);
 		rc = -EINVAL;
 		goto out;
 	}
 	tcontext = sepol_sidtab_search(sidtab, tsid);
 	if (!tcontext) {
-		printf("security_compute_sid:  unrecognized SID %d\n", tsid);
+		DEBUG(__FUNCTION__, "unrecognized SID %d\n", tsid);
 		rc = -EINVAL;
 		goto out;
 	}
@@ -764,11 +758,12 @@ static int validate_perm(hashtab_key_t k
 
 	perdatum2 = (perm_datum_t *) hashtab_search(h, key);
 	if (!perdatum2) {
-		printf("security:  permission %s disappeared", key);
+		DEBUG(__FUNCTION__, "permission %s disappeared\n", key);
 		return -1;
 	}
 	if (perdatum->value != perdatum2->value) {
-		printf("security:  the value of permission %s changed", key);
+		DEBUG(__FUNCTION__, "the value of permissions "
+			"%s changed\n", key);
 		return -1;
 	}
 	return 0;
@@ -790,28 +785,31 @@ static int validate_class(hashtab_key_t 
 
 	cladatum2 = (class_datum_t *) hashtab_search(newp->p_classes.table, key);
 	if (!cladatum2) {
-		printf("security:  class %s disappeared\n", key);
+		DEBUG(__FUNCTION__, "class %s disappeared\n", key);
 		return -1;
 	}
 	if (cladatum->value != cladatum2->value) {
-		printf("security:  the value of class %s changed\n", key);
+		DEBUG(__FUNCTION__, "the value of class %s changed\n", key);
 		return -1;
 	}
 	if ((cladatum->comdatum && !cladatum2->comdatum) ||
 	    (!cladatum->comdatum && cladatum2->comdatum)) {
-		printf("security:  the inherits clause for the access vector definition for class %s changed\n", key);
+		DEBUG(__FUNCTION__, "the inherits clause for the access "
+			"vector definition for class %s changed", key);
 		return -1;
 	}
 	if (cladatum->comdatum) {
 		if (hashtab_map(cladatum->comdatum->permissions.table, validate_perm,
 				cladatum2->comdatum->permissions.table)) {
-			printf(" in the access vector definition for class %s\n", key);
+			DEBUG(__FUNCTION__, " in the access vector definition "
+				"for class %s\n", key);
 			return -1;
 		}
 	}
 	if (hashtab_map(cladatum->permissions.table, validate_perm,
 			cladatum2->permissions.table)) {
-		printf(" in access vector definition for class %s\n", key);
+		DEBUG(__FUNCTION__, " in access vector definition "
+			"for class %s\n", key);
 		return -1;
 	}
 	return 0;
@@ -837,7 +835,7 @@ static inline int convert_context_handle
 		size_t len;
 
 		context_struct_to_string(context, &s, &len);
-		printf("security:  context %s is invalid\n", s);
+		DEBUG(__FUNCTION__, "context %s is invalid\n", s);
 		free(s);
 		return 0;
 	}
@@ -916,7 +914,7 @@ static int convert_context(sepol_securit
       bad:
 	context_struct_to_string(&oldc, &s, &len);
 	context_destroy(&oldc);
-	printf("security:  invalidating context %s\n", s);
+	DEBUG(__FUNCTION__, "invalidating context %s\n", s);
 	free(s);
 	return rc;
 }
@@ -954,8 +952,10 @@ int sepol_load_policy(void * data, size_
 	sepol_sidtab_init(&newsidtab);
 
 	/* Verify that the existing classes did not change. */
-	if (hashtab_map(policydb->p_classes.table, validate_class, &newpolicydb)) {
-		printf("security:  the definition of an existing class changed\n");
+	if (hashtab_map(
+		policydb->p_classes.table, validate_class, &newpolicydb)) {
+		DEBUG(__FUNCTION__, "the definition of an existing "
+			"class changed\n");
 		rc = -EINVAL;
 		goto err;
 	}
diff -p -aru libsepol.work/src/write.c libsepol-3.1-write_services_printf/src/write.c
--- libsepol.work/src/write.c	2005-07-18 15:05:30.000000000 -0400
+++ libsepol-3.1-write_services_printf/src/write.c	2005-07-25 12:20:13.000000000 -0400
@@ -139,12 +139,13 @@ static int avtab_write_item(avtab_ptr_t 
 	buf[items++] = cpu_to_le32(cur->key.target_class);
 	buf[items++] = cpu_to_le32(cur->datum.specified);
 	if (!(cur->datum.specified & (AVTAB_AV | AVTAB_TYPE))) {
-		printf("security: avtab: null entry\n");
+		DEBUG(__FUNCTION__, "null entry\n");
 		return -1;
 	}
 	if ((cur->datum.specified & AVTAB_AV) &&
 	    (cur->datum.specified & AVTAB_TYPE)) {
-		printf("security: avtab: entry has both access vectors and types\n");
+		DEBUG(__FUNCTION__, "entry has both access " 
+			"vectors and types\n");
 		return -1;
 	}
 	if (cur->datum.specified & AVTAB_AV) {
@@ -1274,7 +1275,8 @@ int policydb_write(policydb_t * p, struc
 	items = 0;
 	info = policydb_lookup_compat(policyvers, p->policy_type);
 	if (!info) {
-		fprintf(stderr, "policydb_lookup_compat() failed for %d\n", policyvers);
+		DEBUG(__FUNCTION__, "compatibility lookup failed for policy "
+			"version %d\n", policyvers);
 		return -1;
 	}
 
@@ -1325,7 +1327,8 @@ int policydb_write(policydb_t * p, struc
 			return -1;
                 if (policyvers < POLICYDB_VERSION_BOOL) {
                         if (p->p_bools.nprim)
-                                fprintf(stderr, "warning: discarding booleans and conditional rules\n");
+				DEBUG(__FUNCTION__, "Warning! Discarding "
+					"booleans and conditional rules\n");
                 }
                 else {
                         if (cond_write_list(p->cond_list, fp))

--=-cIwvqOc01+lelAogu5kR--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
