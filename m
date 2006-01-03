Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03IxBXf022793
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 13:59:11 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03Iw8qa022210
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 18:58:09 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 78FA361B04
	for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2006 05:59:07 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 20080-03 for <selinux@tycho.nsa.gov>;
	Wed, 4 Jan 2006 05:59:06 +1100 (EST)
Received: from temp.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AEA4361B01
	for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2006 05:59:06 +1100 (EST)
Received: from temp (temp [127.0.0.1])
	by temp.coker.com.au (Postfix) with ESMTP id 49117C7F9A
	for <selinux@tycho.nsa.gov>; Wed,  4 Jan 2006 05:59:05 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: libsepol
Date: Wed, 4 Jan 2006 05:58:53 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4lsuD8XkVJx5nrh"
Message-Id: <200601040559.04895.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_4lsuD8XkVJx5nrh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

policydb.c:2280: warning: 'last_block' may be used uninitialized in this
function
policydb.c:2289: warning: 'last_decl' may be used uninitialized in this
function

It wasn't immediately clear to me what the correct solution to the above
warnings is.

In av_to_string() in assertion.c I added some code to handle the case of
an error >1024 characters.  I don't think it's possible to have such a
long error or likely to be possible in the future.  But I think it's
best to have the code not crash on such a condition anyway.  I've made
it just return nothing in the case of such an overflow, would truncation
be better?

In sepol_context_to_string() I fixed the error handling for the case
where the overflow occurs by more than one byte.

In sepol_set_delusers() I initialised oldc to 0 to avoid a GCC warning.
I checked the code and it seems that it performs correctly.

In hierarchy.c I fixed a couple of memory leaks and changed a comment to
hopefully make it easier for others who work on this to avoid such
leaks.  Also I changed the code in find_parent() to be a little more
efficient.

In sepol_iface_modify() I renamed the variable "c" to "con".  I hate
one-letter variable names because I can't easily search for them in my
editor.  It turned out that a GCC warning was correct about that
variable being possibly used without being initialised, so I initialise
it to NULL and check it's value before freeing it's members.

Also added some __fsetlocking() stuff.


-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_4lsuD8XkVJx5nrh
Content-Type: text/x-diff;
  charset="us-ascii";
  name="libsepol.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="libsepol.diff"

diff -rup libsepol-1.11.1.orig/src/assertion.c libsepol-1.11.1/src/assertion.c
--- libsepol-1.11.1.orig/src/assertion.c	2005-12-17 01:12:38.000000000 +1100
+++ libsepol-1.11.1/src/assertion.c	2006-01-01 20:58:37.000000000 +1100
@@ -56,6 +56,7 @@ static char *av_to_string(policydb_t *po
         char *perm = NULL, *p;
         unsigned int i;
         int rc; 
+        int avlen = 0, len;
                 
         cladatum = policydbp->class_val_to_struct[tclass-1];
         p = avbuf;
@@ -72,8 +73,14 @@ static char *av_to_string(policydb_t *po
                         if (rc)
                                 perm = v.name;
                         if (perm) {
-                                sprintf(p, " %s", perm);
-                                p += strlen(p);
+                                len = snprintf(p, sizeof(avbuf) - avlen, " %s", perm);
+				if(len >= (sizeof(avbuf) - avlen))
+				{
+		/* should have defined way of returning error */
+					avbuf[0] = '\0';
+					return avbuf;
+				}
+                               	p += len;
                         }
                 }
         }
Only in libsepol-1.11.1/src: .assertion.c.swp
diff -rup libsepol-1.11.1.orig/src/context_record.c libsepol-1.11.1/src/context_record.c
--- libsepol-1.11.1.orig/src/context_record.c	2005-12-17 01:12:38.000000000 +1100
+++ libsepol-1.11.1/src/context_record.c	2006-01-01 20:39:47.000000000 +1100
@@ -278,7 +278,7 @@ int sepol_context_to_string(
 	if (con->mls) {
 		rc = snprintf(str, total_sz + 1, "%s:%s:%s:%s", 
 			con->user, con->role, con->type, con->mls);
-		if (rc < 0 || (rc == total_sz + 1)) {
+		if (rc < 0 || (rc >= total_sz + 1)) {
 			ERR(handle, "print error");
 			goto err;
 		}
@@ -286,7 +286,7 @@ int sepol_context_to_string(
 	else { 		
 		rc = snprintf(str, total_sz + 1, "%s:%s:%s",
 			con->user, con->role, con->type);
-		if (rc < 0 || (rc == total_sz + 1)) {
+		if (rc < 0 || (rc >= total_sz + 1)) {
 			ERR(handle, "print error");
 			goto err;
 		}
diff -rup libsepol-1.11.1.orig/src/genbools.c libsepol-1.11.1/src/genbools.c
--- libsepol-1.11.1.orig/src/genbools.c	2005-12-17 01:12:38.000000000 +1100
+++ libsepol-1.11.1/src/genbools.c	2006-01-01 21:03:58.000000000 +1100
@@ -1,4 +1,5 @@
 #include <stdio.h>
+#include <stdio_ext.h>
 #include <stdlib.h>
 #include <ctype.h>
 #include <errno.h>
@@ -69,6 +70,7 @@ static int load_booleans(struct policydb
 	if (boolf == NULL) 
 		goto localbool;
 
+	__fsetlocking(boolf, FSETLOCKING_BYCALLER);
 	while (getline(&buffer, &size, boolf) > 0) {
 		int ret=process_boolean(buffer, name, sizeof(name), &val);
 		if (ret==-1) 
diff -rup libsepol-1.11.1.orig/src/genusers.c libsepol-1.11.1/src/genusers.c
--- libsepol-1.11.1.orig/src/genusers.c	2005-12-17 01:12:38.000000000 +1100
+++ libsepol-1.11.1/src/genusers.c	2006-01-01 21:07:36.000000000 +1100
@@ -26,7 +26,7 @@ void sepol_set_delusers(int on __attribu
 
 static int load_users(struct policydb *policydb, const char *path) {
 	FILE *fp;
-	char *buffer = NULL, *p, *q, oldc;
+	char *buffer = NULL, *p, *q, oldc = 0;
 	size_t len = 0;
 	ssize_t nread;
 	unsigned lineno = 0, islist = 0, bit;
diff -rup libsepol-1.11.1.orig/src/hierarchy.c libsepol-1.11.1/src/hierarchy.c
--- libsepol-1.11.1.orig/src/hierarchy.c	2005-12-17 01:12:38.000000000 +1100
+++ libsepol-1.11.1/src/hierarchy.c	2006-01-01 21:08:46.000000000 +1100
@@ -42,32 +42,31 @@ typedef struct hierarchy_args {
 /* This merely returns the string part before the last '.'
  * it does no verification of the existance of the parent
  * in the policy, you must do this yourself.
+ *
+ * Caller must free parent after use.
  */
 static int find_parent(char *type, char **parent)
 {
 	char *tmp;
-	int i;
+	int len;
 	
 	assert(type);
 
-	tmp = strchr(type, '.');
+	tmp = strrchr(type, '.');
 	/* no '.' means it has no parent */
 	if (!tmp) {
 		*parent = NULL;
 		return 0;
 	}
 
-	for (i = strlen(type) - 1; i > 0; i--) {
-		if (type[i] == '.')
-			break;
-	}
-	
-	*parent = (char *)malloc(sizeof(char) * (i + 1));
+	/* allocate buffer for part of string before the '.' */
+	len = tmp - type;
+	*parent = (char *)malloc(sizeof(char) * (len + 1));
 
 	if (!(*parent))
 		return -1;
-	memset(*parent, 0, (i + 1));
-	memcpy(*parent, type, i);
+	memcpy(*parent, type, len);
+	*parent[len] = '\0';
 		
 	return 0;
 }
@@ -80,7 +79,7 @@ static int check_type_hierarchy_callback
 	char *parent;
 	hierarchy_args_t *a;
 	type_datum_t *t, *t2;
-
+	int rc;
 
 	a = (hierarchy_args_t *)args;
 	t = (type_datum_t *)d;
@@ -98,20 +97,21 @@ static int check_type_hierarchy_callback
 		return 0;
 	}
 
+	rc = 0;
 	t2 = hashtab_search(a->p->p_types.table, parent);
 	if (!t2) {
 		/* If the parent does not exist this type is an orphan, not legal */
 		ERR(a->handle, "type %s does not exist, %s is an orphan",
 			parent,a->p->p_type_val_to_name[t->value - 1]);
-		return 1;
+		rc = 1;
 	} else if (t2->isattr) {
 			/* The parent is an attribute but the child isn't, not legal */
 			ERR(a->handle, "type %s is a child of an attribute",
 			a->p->p_type_val_to_name[t->value - 1]);
-		return 1;
+		rc = 1;
 	}
-	
-	return 0;
+	free(parent);
+	return rc;
 }
 
 /* This function only verifies that the avtab node passed in does not violate any
@@ -336,6 +336,7 @@ static int check_role_hierarchy_callback
 		free(parent);
 		return 1;
 	}
+	free(parent);
 
 	if (ebitmap_or(&eb, &r->types.types, &rp->types.types)) {
 		/* Memory error */
diff -rup libsepol-1.11.1.orig/src/interfaces.c libsepol-1.11.1/src/interfaces.c
--- libsepol-1.11.1.orig/src/interfaces.c	2005-12-17 01:12:38.000000000 +1100
+++ libsepol-1.11.1/src/interfaces.c	2006-01-01 21:15:26.000000000 +1100
@@ -169,7 +169,7 @@ int sepol_iface_modify(
 	sepol_iface_t* data) {
 
 	policydb_t *policydb = &p->p;
-	ocontext_t *head, *prev, *c, *iface = NULL;
+	ocontext_t *head, *prev, *con = NULL, *iface = NULL;
 
 	const char* name;
 	sepol_iface_key_unpack(key, &name);
@@ -179,23 +179,23 @@ int sepol_iface_modify(
 
 	prev = NULL;
 	head = policydb->ocontexts[OCON_NETIF];
-	for (c = head; c; c = c->next) {
-		if (!strcmp(name, c->u.name)) {
+	for (con = head; con; con = con->next) {
+		if (!strcmp(name, con->u.name)) {
 
 			/* Replace */
-			iface->next = c->next;
+			iface->next = con->next;
 			if (prev == NULL)
 				policydb->ocontexts[OCON_NETIF] = iface;
 			else
 				prev->next = iface;
-			free(c->u.name);
-			context_destroy(&c->context[0]);
-			context_destroy(&c->context[1]);
-			free(c);
+			free(con->u.name);
+			context_destroy(&con->context[0]);
+			context_destroy(&con->context[1]);
+			free(con);
 
 			return STATUS_SUCCESS;
 		}
-		prev = c;
+		prev = con;
 	}	
 		
 	/* Attach to context list */
@@ -208,8 +208,11 @@ int sepol_iface_modify(
 
 	if (iface != NULL) {
 		free(iface->u.name);
-		context_destroy(&c->context[0]);
-		context_destroy(&c->context[1]);
+		if(con)
+		{
+			context_destroy(&con->context[0]);
+			context_destroy(&con->context[1]);
+		}
 		free(iface);
 	}
 	return STATUS_ERR;
diff -rup libsepol-1.11.1.orig/src/ports.c libsepol-1.11.1/src/ports.c
--- libsepol-1.11.1.orig/src/ports.c	2005-12-17 01:12:38.000000000 +1100
+++ libsepol-1.11.1/src/ports.c	2006-01-01 21:20:18.000000000 +1100
@@ -246,7 +246,7 @@ int sepol_port_modify(
 	sepol_port_t* data) {
 
 	policydb_t *policydb = &p->p;
-	ocontext_t *c, *head, *prev, *port = NULL;
+	ocontext_t *c, *head, *prev = NULL, *port = NULL;
 
 	int low, high, proto;
 	sepol_port_key_unpack(key, &low, &high, &proto);
diff -rup libsepol-1.11.1.orig/utils/chkcon.c libsepol-1.11.1/utils/chkcon.c
--- libsepol-1.11.1.orig/utils/chkcon.c	2005-12-17 01:12:38.000000000 +1100
+++ libsepol-1.11.1/utils/chkcon.c	2006-01-01 20:04:38.000000000 +1100
@@ -2,6 +2,7 @@
 #include <unistd.h>
 #include <sys/types.h>
 #include <stdio.h>
+#include <stdio_ext.h>
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
@@ -25,6 +26,7 @@ int main(int argc, char **argv)
 			argv[1], strerror(errno));
 		exit(1);
 	}
+	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 	if (sepol_set_policydb_from_file(fp) < 0) {
 		fprintf(stderr, "Error while processing %s:  %s\n",
 			argv[1], strerror(errno));

--Boundary-00=_4lsuD8XkVJx5nrh--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
