Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h96HR8Wt006592
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 13:27:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h96HR20p024134
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 17:27:02 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id h96HR1r7024131
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 17:27:01 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h96HR10F006766
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 13:27:01 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h96HR17h006764
	for selinux@tycho.nsa.gov; Mon, 6 Oct 2003 13:27:01 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h96FOGWt005660
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 11:24:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h96FMq7h012036
	for <selinux@tycho.nsa.gov>; Mon, 6 Oct 2003 15:24:14 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id h95AjbRn006498 for <selinux@tycho.nsa.gov>; Sun, 5 Oct 2003 10:48:55 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id 03BAE170021
	for <selinux@tycho.nsa.gov>; Sun,  5 Oct 2003 01:27:09 +0200 (CEST)
Date: Sun, 5 Oct 2003 01:18:32 +0200
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Warnings and 64bit
Message-ID: <20031004231832.GE3573@hydra.joerghoh.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

We've managed to run SELinux on an alpha (Kernel 2.6.0test6). Before that 
we've done lot of patching (the policy compiler was really messy).

Most patches are concerning type conversions (a lot of int -> size_t 
conversion) and invalid comparisons of int (4 byte) and long (8 byte 
on alpha). We also patched the Makefiles, so all files are build with
"-Wall -W -Werror" (most files compile now without warnings, except
for the lexx generated ones):also all utils can built in the source tree.

The probably most intrusive part:

-typedef unsigned int access_vector_t;
-typedef unsigned short security_class_t;
+typedef uint32_t access_vector_t;
+typedef uint32_t security_class_t;

We made security_class_t 32bit. There is probably a problem with 16 Bit
parameters on alpha, I will check this and report here.

The patch is against the latest cvs-version on sourceforge.

Joerg

-- 
..Wenn man sich bei NetBSD auf eines verlassen kann, dann: Egal, WAS[...]
man updated, mplayer hat mit Sicherheit dependencies drauf.
  Rene Schickbauer, news:2591532.ZKZXAUW3eG@gandalf.grumpfzotz.org

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=overall

diff -ru nsa.orig/selinux-usr/checkpolicy/Makefile nsa/selinux-usr/checkpolicy/Makefile
--- nsa.orig/selinux-usr/checkpolicy/Makefile	2003-09-25 16:49:43.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/Makefile	2003-10-04 20:08:45.000000000 +0200
@@ -16,8 +16,10 @@
 OBJS =
 endif
 
-CFLAGS = -g $(OPTIONS) -Wall -O2 -pipe
+CFLAGS = -g $(OPTIONS) -Wall -W -Wconversion -Werror -O2 -pipe
+CFLAGS_PERMISSIVE = -g $(OPTIONS) -Wall -W -Wconversion -O2 -pipe
 override CFLAGS += -include global.h -I. -Iinclude
+override CFLAGS_PERMISSIVE += -include global.h -I. -Iinclude
 
 OBJS += ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o y.tab.o lex.yy.o queue.o write.o checkpolicy.o
 
@@ -31,11 +33,11 @@
 %.o: %.c 
 	$(CC) $(CFLAGS) -o $@ -c $<
 
-y.tab.o: y.tab.c
-	$(CC) $(CFLAGS) -o $@ -c $<
+checkpolicy.o y.tab.o lex.yy.o: %.o: %.c
+	$(CC) $(CFLAGS_PERMISSIVE) -o $@ -c $<
 
-lex.yy.o: lex.yy.c
-	$(CC) $(CFLAGS) -o $@ -c $<
+#lex.yy.o: lex.yy.c
+#	$(CC) $(CFLAGS_PERMISSIVE) -o $@ -c $<
 
 y.tab.c: policy_parse.y
 	$(YACC) -d policy_parse.y
diff -ru nsa.orig/selinux-usr/checkpolicy/avtab.c nsa/selinux-usr/checkpolicy/avtab.c
--- nsa.orig/selinux-usr/checkpolicy/avtab.c	2003-08-14 14:37:34.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/avtab.c	2003-10-04 18:10:50.000000000 +0200
@@ -186,9 +186,10 @@
 }
 
 
-int avtab_read(avtab_t * a, void * fp, __u32 config)
+int avtab_read(avtab_t * a, void * fp, __u32 config __attribute__ ((unused)))
 {
-	int i, rc;
+	unsigned int i;
+        int rc;
 	avtab_key_t avkey;
 	avtab_datum_t avdatum;
 	__u32 *buf;
Only in nsa/selinux-usr/checkpolicy: avtab.o
Only in nsa/selinux-usr/checkpolicy: checkpolicy
diff -ru nsa.orig/selinux-usr/checkpolicy/checkpolicy.c nsa/selinux-usr/checkpolicy/checkpolicy.c
--- nsa.orig/selinux-usr/checkpolicy/checkpolicy.c	2003-08-14 14:37:34.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/checkpolicy.c	2003-10-04 19:42:10.000000000 +0200
@@ -57,7 +57,7 @@
 char *txtfile = "policy.conf";
 char *binfile = "policy";
 
-int avc_ss_reset(__u32 seqno)
+int avc_ss_reset(__u32 seqno __attribute__ ((unused)))
 {
 	return 0;
 }
@@ -69,7 +69,7 @@
 }
 
 static int print_sid(security_id_t sid,
-		     context_struct_t * context, void *data)
+		     context_struct_t * context __attribute__ ((unused)), void *data __attribute__ ((unused)))
 {
 	security_context_t scontext;
 	unsigned int scontext_len;
@@ -105,7 +105,7 @@
 	return 0;
 }
 
-static int type_attr_remove(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int type_attr_remove(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	type_datum_t *typdatum;
 
@@ -244,12 +244,12 @@
 
 extern char *av_to_string(__u32 tclass, access_vector_t av);
 
-void check_assertion_helper(int stype, int ttype, ebitmap_t *tclasses, 
+void check_assertion_helper(unsigned int stype, unsigned int ttype, ebitmap_t *tclasses, 
 			    access_vector_t *avp, unsigned long line) 
 {
 	avtab_key_t avkey;
 	avtab_datum_t *avdatump;
-	int k;
+	unsigned int k;
 	
 
 	for (k = ebitmap_startbit(tclasses); k < ebitmap_length(tclasses); k++) {
@@ -275,7 +275,7 @@
 void check_assertions(void) 
 {
 	te_assert_t *a, *tmp;
-	int i, j;
+	unsigned int i, j;
 
 	a = te_assertions;
 	while (a) {
@@ -313,7 +313,8 @@
 	unsigned int protocol, port, addr;
 	unsigned int binary = 0, debug = 0;
 	struct val_to_name v;
-	int ret, ch, nel, fd;
+	int ret, ch, fd;
+        unsigned int nel;
 	struct stat sb;
 	void *map;
 	FILE *outfp = NULL;
Only in nsa/selinux-usr/checkpolicy: checkpolicy.o
diff -ru nsa.orig/selinux-usr/checkpolicy/constraint.h nsa/selinux-usr/checkpolicy/constraint.h
--- nsa.orig/selinux-usr/checkpolicy/constraint.h	2003-08-14 14:37:34.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/constraint.h	2003-10-04 18:24:38.000000000 +0200
@@ -29,20 +29,20 @@
 #define CEXPR_OR		3 /* expr or expr */
 #define CEXPR_ATTR		4 /* attr op attr */
 #define CEXPR_NAMES		5 /* attr op names */	
-	__u32 expr_type;	/* expression type */
+	uintptr_t expr_type;	/* expression type */
 
 #define CEXPR_USER 1		/* user */
 #define CEXPR_ROLE 2		/* role */
 #define CEXPR_TYPE 4		/* type */
 #define CEXPR_TARGET 8		/* target if set, source otherwise */
-	__u32 attr;		/* attribute */
+	uintptr_t attr;		/* attribute */
 
 #define CEXPR_EQ     1		/* == or eq */
 #define CEXPR_NEQ    2		/* != */
 #define CEXPR_DOM    3		/* dom */
 #define CEXPR_DOMBY  4		/* domby  */
 #define CEXPR_INCOMP 5		/* incomp */
-	__u32 op;		/* operator */
+	uintptr_t op;		/* operator */
 	
 	ebitmap_t names;	/* names */
 
diff -ru nsa.orig/selinux-usr/checkpolicy/context.h nsa/selinux-usr/checkpolicy/context.h
--- nsa.orig/selinux-usr/checkpolicy/context.h	2003-08-14 14:37:34.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/context.h	2003-10-04 18:08:29.000000000 +0200
@@ -80,18 +80,18 @@
 
 #else
 
-static inline void mls_context_init(context_struct_t *c)
+static inline void mls_context_init(context_struct_t *c __attribute__ ((unused)))
 { }
 
-static inline int mls_context_cpy(context_struct_t * dst, 
-				  context_struct_t * src)
+static inline int mls_context_cpy(context_struct_t * dst __attribute__ ((unused)), 
+				  context_struct_t * src __attribute__ ((unused)))
 { return 0; }
 
-static inline int mls_context_cmp(context_struct_t * c1,
-                                  context_struct_t * c2)
+static inline int mls_context_cmp(context_struct_t * c1 __attribute__ ((unused)),
+                                  context_struct_t * c2 __attribute__ ((unused)))
 { return 1; }
 
-static inline void mls_context_destroy(context_struct_t * c)
+static inline void mls_context_destroy(context_struct_t * c __attribute__ ((unused)))
 { }
 
 #endif
diff -ru nsa.orig/selinux-usr/checkpolicy/ebitmap.c nsa/selinux-usr/checkpolicy/ebitmap.c
--- nsa.orig/selinux-usr/checkpolicy/ebitmap.c	2003-08-14 14:37:34.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/ebitmap.c	2003-10-04 19:47:35.000000000 +0200
@@ -139,7 +139,7 @@
 }
 
 
-int ebitmap_get_bit(ebitmap_t * e, unsigned long bit)
+int ebitmap_get_bit(ebitmap_t * e, unsigned int bit)
 {
 	ebitmap_node_t *n;
 
@@ -162,7 +162,7 @@
 }
 
 
-int ebitmap_set_bit(ebitmap_t * e, unsigned long bit, int value)
+int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value)
 {
 	ebitmap_node_t *n, *prev, *new;
 
@@ -269,7 +269,7 @@
 	count = le32_to_cpu(buf[2]);
 
 	if (mapsize != MAPSIZE) {
-		printk("security: ebitmap: map size %d does not match my size %d (high bit was %d)\n", mapsize, MAPSIZE, e->highbit);
+		printk("security: ebitmap: map size %d does not match my size %zu (high bit was %d)\n", mapsize, MAPSIZE, e->highbit);
 		goto out;
 	}
 	if (!e->highbit) {
@@ -277,7 +277,7 @@
 		goto ok;
 	}
 	if (e->highbit & (MAPSIZE - 1)) {
-		printk("security: ebitmap: high bit (%d) is not a multiple of the map size (%d)\n", e->highbit, MAPSIZE);
+		printk("security: ebitmap: high bit (%d) is not a multiple of the map size (%zu)\n", e->highbit, MAPSIZE);
 		goto bad;
 	}
 	l = NULL;
@@ -298,11 +298,11 @@
 		n->startbit = le32_to_cpu(buf[0]);
 
 		if (n->startbit & (MAPSIZE - 1)) {
-			printk("security: ebitmap start bit (%d) is not a multiple of the map size (%d)\n", n->startbit, MAPSIZE);
+			printk("security: ebitmap start bit (%d) is not a multiple of the map size (%zu)\n", n->startbit, MAPSIZE);
 			goto bad_free;
 		}
 		if (n->startbit > (e->highbit - MAPSIZE)) {
-			printk("security: ebitmap start bit (%d) is beyond the end of the bitmap (%d)\n", n->startbit, (e->highbit - MAPSIZE));
+			printk("security: ebitmap start bit (%d) is beyond the end of the bitmap (%zu)\n", n->startbit, (e->highbit - MAPSIZE));
 			goto bad_free;
 		}
 		buf = next_entry(fp, sizeof(__u64));
diff -ru nsa.orig/selinux-usr/checkpolicy/ebitmap.h nsa/selinux-usr/checkpolicy/ebitmap.h
--- nsa.orig/selinux-usr/checkpolicy/ebitmap.h	2003-08-14 14:37:34.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/ebitmap.h	2003-10-04 19:02:00.000000000 +0200
@@ -46,8 +46,8 @@
 int ebitmap_or(ebitmap_t * dst, ebitmap_t * e1, ebitmap_t * e2);
 int ebitmap_cpy(ebitmap_t * dst, ebitmap_t * src);
 int ebitmap_contains(ebitmap_t * e1, ebitmap_t * e2);
-int ebitmap_get_bit(ebitmap_t * e, unsigned long bit);
-int ebitmap_set_bit(ebitmap_t * e, unsigned long bit, int value);
+int ebitmap_get_bit(ebitmap_t * e, unsigned int bit);
+int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value);
 void ebitmap_destroy(ebitmap_t * e);
 int ebitmap_read(ebitmap_t * e, void * fp);
 
Only in nsa/selinux-usr/checkpolicy: ebitmap.o
diff -ru nsa.orig/selinux-usr/checkpolicy/hashtab.c nsa/selinux-usr/checkpolicy/hashtab.c
--- nsa.orig/selinux-usr/checkpolicy/hashtab.c	2003-08-14 14:37:34.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/hashtab.c	2003-10-04 18:10:00.000000000 +0200
@@ -17,7 +17,7 @@
 			 unsigned int size)
 {
 	hashtab_t p;
-	int i;
+	unsigned int i;
 
 
 	p = (hashtab_t) kmalloc(sizeof(hashtab_val_t),GFP_KERNEL);
@@ -187,7 +187,7 @@
 
 void hashtab_destroy(hashtab_t h)
 {
-	int i;
+	unsigned int i;
 	hashtab_ptr_t cur, temp;
 
 
@@ -217,7 +217,7 @@
 			      void *args),
 		void *args)
 {
-	int i, ret;
+	unsigned int i, ret;
 	hashtab_ptr_t cur;
 
 
@@ -246,7 +246,8 @@
 						  void *args),
 				 void *args)
 {
-	int i, ret;
+	unsigned int i;
+        int ret;
 	hashtab_ptr_t last, cur, temp;
 
 
@@ -283,7 +284,8 @@
 
 void hashtab_hash_eval(hashtab_t h, char *tag)
 {
-	int i, chain_len, slots_used, max_chain_len;
+	unsigned int i;
+        int chain_len, slots_used, max_chain_len;
 	hashtab_ptr_t cur;
 
 
Only in nsa/selinux-usr/checkpolicy: hashtab.o
diff -ru nsa.orig/selinux-usr/checkpolicy/include/flask_types.h nsa/selinux-usr/checkpolicy/include/flask_types.h
--- nsa.orig/selinux-usr/checkpolicy/include/flask_types.h	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/include/flask_types.h	2003-10-04 19:21:53.000000000 +0200
@@ -41,7 +41,7 @@
  * with the corresponding constants defined in the automatically 
  * generated header file flask.h.
  */
-typedef __u16 security_class_t;
+typedef __u32 security_class_t;
 #define SECCLASS_NULL			0x0000 /* no class */
 
 #ifdef __KERNEL__
Only in nsa/selinux-usr/checkpolicy: lex.yy.c
Only in nsa/selinux-usr/checkpolicy: lex.yy.o
diff -ru nsa.orig/selinux-usr/checkpolicy/policy_parse.y nsa/selinux-usr/checkpolicy/policy_parse.y
--- nsa.orig/selinux-usr/checkpolicy/policy_parse.y	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/policy_parse.y	2003-10-04 19:33:55.000000000 +0200
@@ -10,6 +10,7 @@
 #include "services.h"
 #include "queue.h"
 #include "checkpolicy.h"
+#include <stdint.h>
 
 #define TRUE 1
 #define FALSE 0
@@ -54,14 +55,14 @@
 static int define_initial_sid_context(void);
 static int define_fs_use(int behavior);
 static int define_genfs_context(int has_type);
-static int define_fs_context(int major, int minor);
-static int define_port_context(int low, int high);
+static int define_fs_context(uintptr_t major, uintptr_t minor);
+static int define_port_context(uintptr_t low, uintptr_t high);
 static int define_netif_context(void);
-static int define_node_context(int addr, int mask);
+static int define_node_context(uintptr_t addr, uintptr_t mask);
 %}
 
 %union {
-	int val;
+	uintptr_t val;
 	void *ptr;
 }
 
@@ -1659,7 +1660,7 @@
 		     char *id)
 {
 	type_datum_t *t;
-	int i;
+	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
 		/* set all types */
@@ -1715,7 +1716,8 @@
 	class_datum_t *cladatum;
 	ebitmap_t stypes, ttypes, tclasses;
 	__u32 newtype = 0;
-	int ret, i, j, k;
+	int ret;
+	unsigned int i, j, k;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -1864,7 +1866,8 @@
 	static char avbuf[1024];
 	class_datum_t *cladatum;
 	char *perm = NULL, *p;
-	int i, rc;
+	unsigned int i;
+	int rc;
 
 	cladatum = policydbp->class_val_to_struct[tclass-1];
 	p = avbuf;
@@ -1891,13 +1894,14 @@
 }
 
 
-static int te_avtab_helper(int which, int stype, int ttype, 
+static int te_avtab_helper(int which, unsigned int stype, unsigned int ttype, 
 			   ebitmap_t *tclasses, access_vector_t *avp)
 
 {
 	avtab_key_t avkey;
 	avtab_datum_t avdatum, *avdatump;
-	int ret, k;
+	int ret;
+	unsigned int k;
 
 	if (which == -AVTAB_ALLOWED) {
 		yyerror("neverallow should not reach this function.");
@@ -1958,7 +1962,8 @@
 	perm_datum_t *perdatum;
 	ebitmap_t stypes, ttypes, tclasses;
 	access_vector_t *avp;
-	int i, j, hiclass, self = 0;
+	unsigned int i, j, hiclass;
+	int self = 0;
 	te_assert_t *newassert;
 
 	if (pass == 1) {
@@ -2021,7 +2026,7 @@
 
 			if (strcmp(id, "*") == 0) {
 				/* set all permissions in the class */
-				avp[i] = ~0;
+				avp[i] = (access_vector_t) -1;
 				continue;
 			}
 
@@ -2219,7 +2224,8 @@
 {
 	role_datum_t *role;
 	char *role_id;
-	int i, ret;
+	unsigned int i;
+	int ret;
 
 	if (pass == 1) {
 		role_id = queue_remove(id_queue);
@@ -2274,7 +2280,7 @@
 		     char *id)
 {
 	role_datum_t *r;
-	int i;
+	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
 		/* set all roles */
@@ -2317,7 +2323,7 @@
 	role_datum_t *role;
 	ebitmap_t roles, types;
 	struct role_trans *tr = 0;
-	int i, j;
+	unsigned int i, j;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2398,7 +2404,7 @@
 	char *id;
 	ebitmap_t roles, new_roles;
 	struct role_allow *ra = 0;
-	int i, j;
+	unsigned int i, j;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2462,7 +2468,8 @@
 	perm_datum_t *perdatum;
 	ebitmap_t classmap;
 	constraint_expr_t *e;
-	int i, depth;
+	unsigned int i;
+	int depth;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2641,12 +2648,12 @@
 		e1->next = expr;
 		return (struct constraint_expr *) arg1;
 	case CEXPR_ATTR:
-		expr->attr = (__u32)arg1;
-		expr->op = (__u32)arg2;
+		expr->attr = (uintptr_t)arg1;
+		expr->op = (uintptr_t)arg2;
 		return expr;
 	case CEXPR_NAMES:
-		expr->attr = (__u32)arg1;
-		expr->op = (__u32)arg2;
+		expr->attr = (uintptr_t)arg1;
+		expr->op = (uintptr_t)arg2;
 		while ((id = (char *) queue_remove(id_queue))) {
 			if (expr->attr & CEXPR_USER) {
 				user = (user_datum_t *) hashtab_search(policydbp->p_users.table,
@@ -2704,7 +2711,7 @@
 			  char *id)
 {
 	role_datum_t *r;
-	int i;
+	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
 		/* set all roles */
@@ -3137,7 +3144,7 @@
 	return 0;
 }
 
-static int define_fs_context(int major, int minor)
+static int define_fs_context(uintptr_t major, uintptr_t minor)
 {
 	ocontext_t *newc, *c, *head;
 
@@ -3154,13 +3161,13 @@
 	}
 	memset(newc, 0, sizeof(ocontext_t));
 
-	newc->u.name = (char *) malloc(6);
+	newc->u.name = malloc((size_t) 6);
 	if (!newc->u.name) {
 		yyerror("out of memory");
 		free(newc);
 		return -1;
 	}
-	sprintf(newc->u.name, "%02x:%02x", major, minor);
+	sprintf(newc->u.name, "%02lx:%02lx", major, minor);
 
 	if (parse_security_context(&newc->context[0])) {
 		free(newc->u.name);
@@ -3193,7 +3200,7 @@
 	return 0;
 }
 
-static int define_port_context(int low, int high)
+static int define_port_context(uintptr_t low, uintptr_t high)
 {
 	ocontext_t *newc;
 	char *id;
@@ -3292,7 +3299,7 @@
 	return 0;
 }
 
-static int define_node_context(int addr, int mask)
+static int define_node_context(uintptr_t addr, uintptr_t mask)
 {
 	ocontext_t *newc, *c, *l, *head;
 
diff -ru nsa.orig/selinux-usr/checkpolicy/policy_scan.l nsa/selinux-usr/checkpolicy/policy_scan.l
--- nsa.orig/selinux-usr/checkpolicy/policy_scan.l	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/policy_scan.l	2003-10-04 19:35:47.000000000 +0200
@@ -19,7 +19,7 @@
 letter  [A-Za-z]
 digit   [0-9]
 %%
-\n.*				{ strncpy(linebuf[lno], yytext+1, 255);
+\n.*				{ strncpy(linebuf[lno], yytext+1, (size_t)255);
                                   linebuf[lno][254] = 0;
                                   lno = 1 - lno; 
                                   policydb_lineno++;
diff -ru nsa.orig/selinux-usr/checkpolicy/policydb.c nsa/selinux-usr/checkpolicy/policydb.c
--- nsa.orig/selinux-usr/checkpolicy/policydb.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/policydb.c	2003-10-04 19:07:19.000000000 +0200
@@ -287,7 +287,7 @@
  * symbol data in the policy database.
  */
 
-static int perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int perm_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	if (key)
 		kfree(key);
@@ -296,7 +296,7 @@
 }
 
 
-static int common_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int common_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	common_datum_t *comdatum;
 
@@ -310,7 +310,7 @@
 }
 
 
-static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int class_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	class_datum_t *cladatum;
 	constraint_node_t *constraint, *ctemp;
@@ -340,7 +340,7 @@
 	return 0;
 }
 
-static int role_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int role_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	role_datum_t *role;
 
@@ -353,7 +353,7 @@
 	return 0;
 }
 
-static int type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int type_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	if (key)
 		kfree(key);
@@ -361,7 +361,7 @@
 	return 0;
 }
 
-static int user_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p)
+static int user_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	user_datum_t *usrdatum;
 
@@ -529,7 +529,7 @@
  */
 static int context_read_and_validate(context_struct_t * c,
 				     policydb_t * p,
-				     void * fp)
+				     struct policy_file * fp)
 {
 	__u32 *buf;
 
@@ -561,11 +561,12 @@
  * binary representation file.
  */
 
-static int perm_read(policydb_t * p, hashtab_t h, void * fp)
+static int perm_read(policydb_t * p __attribute__ ((unused)), hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	perm_datum_t *perdatum;
-	__u32 *buf, len;
+	__u32 *buf;
+        size_t len;
 
 	perdatum = kmalloc(sizeof(perm_datum_t),GFP_KERNEL);
 	if (!perdatum)
@@ -601,12 +602,13 @@
 }
 
 
-static int common_read(policydb_t * p, hashtab_t h, void * fp)
+static int common_read(policydb_t * p, hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	common_datum_t *comdatum;
-	__u32 *buf, len, nel;
-	int i;
+	__u32 *buf;
+        size_t len, nel;
+	unsigned int i;
 
 	comdatum = kmalloc(sizeof(common_datum_t),GFP_KERNEL);
 	if (!comdatum)
@@ -650,14 +652,16 @@
 }
 
 
-static int class_read(policydb_t * p, hashtab_t h, void * fp)
+static int class_read(policydb_t * p, hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	class_datum_t *cladatum;
 	constraint_node_t *c, *lc;
 	constraint_expr_t *e, *le;
-	__u32 *buf, len, len2, ncons, nexpr, nel;
-	int i, j, depth;
+	__u32 *buf;
+        size_t len, len2, ncons, nexpr, nel;
+	unsigned int i, j;
+        int depth;
 
 	cladatum = (class_datum_t *) kmalloc(sizeof(class_datum_t),GFP_KERNEL);
 	if (!cladatum)
@@ -806,11 +810,12 @@
 }
 
 
-static int role_read(policydb_t * p, hashtab_t h, void * fp)
+static int role_read(policydb_t * p __attribute__ ((unused)), hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	role_datum_t *role;
-	__u32 *buf, len;
+	__u32 *buf;
+        size_t len;
 
 	role = kmalloc(sizeof(role_datum_t),GFP_KERNEL);
 	if (!role)
@@ -861,11 +866,12 @@
 }
 
 
-static int type_read(policydb_t * p, hashtab_t h, void * fp)
+static int type_read(policydb_t * p __attribute__ ((unused)), hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	type_datum_t *typdatum;
-	__u32 *buf, len;
+	__u32 *buf;
+        size_t len;
 
 	typdatum = kmalloc(sizeof(type_datum_t),GFP_KERNEL);
 	if (!typdatum)
@@ -899,11 +905,12 @@
 	return -1;
 }
 
-static int user_read(policydb_t * p, hashtab_t h, void * fp)
+static int user_read(policydb_t * p __attribute__ ((unused)), hashtab_t h, struct policy_file * fp)
 {
 	char *key = 0;
 	user_datum_t *usrdatum;
-	__u32 *buf, len;
+	__u32 *buf;
+        size_t len;
 
 
 	usrdatum = kmalloc(sizeof(user_datum_t),GFP_KERNEL);
@@ -944,7 +951,7 @@
 }
 
 
-static int (*read_f[SYM_NUM]) (policydb_t * p, hashtab_t h, void * fp) =
+static int (*read_f[SYM_NUM]) (policydb_t * p, hashtab_t h, struct policy_file * fp) =
 {
 	common_read,
 	class_read,
@@ -961,14 +968,15 @@
  * Read the configuration data from a policy database binary
  * representation file into a policy database structure.
  */
-int policydb_read(policydb_t * p, void * fp)
+int policydb_read(policydb_t * p, struct policy_file * fp)
 {
 	struct role_allow *ra, *lra;
 	struct role_trans *tr, *ltr;
 	ocontext_t *l, *c, *newc;
 	genfs_t *genfs_p, *genfs, *newgenfs;
-	int i, j;
-	__u32 *buf, len, len2, config, nprim, nel, nel2;
+	unsigned int i, j;
+	__u32 *buf, config;
+        size_t len, len2, nprim, nel, nel2;
 	char *policydb_str;
 
 	config = 0;
@@ -991,7 +999,7 @@
 
 	len = buf[1];
 	if (len != strlen(POLICYDB_STRING)) {
-		printk("security:  policydb string length %d does not match expected length %d\n", len, strlen(POLICYDB_STRING));
+		printk("security:  policydb string length %zu does not match expected length %zu\n", len, strlen(POLICYDB_STRING));
 		goto bad;
 	}
 	buf = next_entry(fp, len);
@@ -1001,7 +1009,7 @@
 	}
 	policydb_str = kmalloc(len + 1,GFP_KERNEL);
 	if (!policydb_str) {
-		printk("security:  unable to allocate memory for policydb string of length %d\n", len);
+		printk("security:  unable to allocate memory for policydb string of length %zu\n", len);
 		goto bad;
 	}
 	memcpy(policydb_str, buf, len);
diff -ru nsa.orig/selinux-usr/checkpolicy/policydb.h nsa/selinux-usr/checkpolicy/policydb.h
--- nsa.orig/selinux-usr/checkpolicy/policydb.h	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/policydb.h	2003-10-04 18:57:17.000000000 +0200
@@ -237,7 +237,9 @@
 
 extern int policydb_context_isvalid(policydb_t *p, context_struct_t *c);
 
-extern int policydb_read(policydb_t * p, void * fp);
+struct policy_file;
+
+extern int policydb_read(policydb_t * p, struct policy_file * fp);
 
 #define PERM_SYMTAB_SIZE 32
 
Only in nsa/selinux-usr/checkpolicy: policydb.o
Only in nsa/selinux-usr/checkpolicy: queue.o
diff -ru nsa.orig/selinux-usr/checkpolicy/services.c nsa/selinux-usr/checkpolicy/services.c
--- nsa.orig/selinux-usr/checkpolicy/services.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/services.c	2003-10-04 19:27:13.000000000 +0200
@@ -170,7 +170,7 @@
 static int context_struct_compute_av(context_struct_t *scontext,
 				     context_struct_t *tcontext,
 				     security_class_t tclass,
-				     access_vector_t requested,
+				     access_vector_t requested __attribute__ ((unused)),
 				     struct av_decision *avd)
 {
 	constraint_node_t *constraint;
@@ -315,7 +315,7 @@
 	*scontext_len += mls_compute_context_len(context);
 
 	/* Allocate space for the context; caller must free this space. */
-	scontextp = (char *) kmalloc(*scontext_len+1,GFP_ATOMIC);
+	scontextp = kmalloc((size_t) *scontext_len+1,GFP_ATOMIC);
 	if (!scontextp) {
 		return -ENOMEM;
 	}
@@ -360,7 +360,7 @@
 			char *scontextp;
 
 			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
-			scontextp = kmalloc(*scontext_len,GFP_KERNEL);
+			scontextp = kmalloc((size_t) *scontext_len,GFP_KERNEL);
 			strcpy(scontextp, initial_sid_to_string[sid]);
 			*scontext = (security_context_t) scontextp;
 			return 0;
@@ -417,11 +417,11 @@
 	   null suffix to the copy to avoid problems with the existing
 	   attr package, which doesn't view the null terminator as part
 	   of the attribute value. */
-	scontext2 = kmalloc(scontext_len+1,GFP_KERNEL);
+	scontext2 = kmalloc((size_t) scontext_len+1,GFP_KERNEL);
 	if (!scontext2) {
 		return -ENOMEM;
 	}
-	memcpy(scontext2, scontext, scontext_len);
+	memcpy(scontext2, scontext, (size_t) scontext_len);
 	scontext2[scontext_len] = 0;
 
 	context_init(&context);
@@ -821,7 +821,7 @@
  * in the policy `p->newp'.  Verify that the
  * context is valid under the new policy.
  */
-static int convert_context(security_id_t key,
+static int convert_context(security_id_t key __attribute__ ((unused)),
 			   context_struct_t * c,
 			   void *p)
 {
@@ -1045,8 +1045,8 @@
  * Return the SID of the port specified by
  * `domain', `type', `protocol', and `port'.
  */
-int security_port_sid(__u16 domain,
-		      __u16 type,
+int security_port_sid(__u16 domain __attribute__ ((unused)),
+		      __u16 type __attribute__ ((unused)),
 		      __u8 protocol,
 		      __u16 port,
 		      security_id_t * out_sid)
@@ -1201,7 +1201,8 @@
 	user_datum_t *user;
 	role_datum_t *role;
 	struct av_decision avd;
-	int rc = 0, i, j;
+	int rc = 0;
+        unsigned int i, j;
 
 	if (!ss_initialized) {
 		*nel = 0;
@@ -1245,7 +1246,7 @@
 			mls_for_user_ranges(user,usercon) {
 				rc = context_struct_compute_av(fromcon, &usercon, 
 							       SECCLASS_PROCESS,
-							       PROCESS__TRANSITION, 
+							       (access_vector_t) PROCESS__TRANSITION, 
 							       &avd);
 				if (rc ||  !(avd.allowed & PROCESS__TRANSITION)) 
 					continue;
@@ -1293,7 +1294,7 @@
 		       security_class_t sclass,
 		       security_id_t *sid)
 {
-	int len;
+	size_t len;
 	genfs_t *genfs;
 	ocontext_t *c;
 	int rc = 0, cmp = 0;
Only in nsa/selinux-usr/checkpolicy: services.o
Only in nsa/selinux-usr/checkpolicy: sidtab.o
diff -ru nsa.orig/selinux-usr/checkpolicy/symtab.c nsa/selinux-usr/checkpolicy/symtab.c
--- nsa.orig/selinux-usr/checkpolicy/symtab.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/symtab.c	2003-10-04 18:10:18.000000000 +0200
@@ -24,7 +24,7 @@
 	return val & (h->size - 1);
 }
 
-static int symcmp(hashtab_t h, hashtab_key_t key1, hashtab_key_t key2)
+static int symcmp(hashtab_t h __attribute__ ((unused)), hashtab_key_t key1, hashtab_key_t key2)
 {
 	char *keyp1, *keyp2;
 
Only in nsa/selinux-usr/checkpolicy: symtab.o
diff -ru nsa.orig/selinux-usr/checkpolicy/write.c nsa/selinux-usr/checkpolicy/write.c
--- nsa.orig/selinux-usr/checkpolicy/write.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/checkpolicy/write.c	2003-10-04 20:04:13.000000000 +0200
@@ -18,17 +18,17 @@
 		count++;
 	buf[2] = cpu_to_le32(count);
 
-	items = fwrite(buf, sizeof(__u32), 3, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 3, fp);
 	if (items != 3)
 		return -1;
 
 	for (n = e->node; n; n = n->next) {
 		bit = cpu_to_le32(n->startbit);
-		items = fwrite(&bit, sizeof(__u32), 1, fp);
+		items = fwrite(&bit, sizeof(__u32), (size_t) 1, fp);
 		if (items != 1)
 			return -1;
 		map = cpu_to_le64(n->map);
-		items = fwrite(&map, sizeof(__u64), 1, fp);
+		items = fwrite(&map, sizeof(__u64), (size_t) 1, fp);
 		if (items != 1)
 			return -1;
 
@@ -46,7 +46,7 @@
 	size_t items, items2;
 
 	nel = cpu_to_le32(a->nel);
-	items = fwrite(&nel, sizeof(__u32), 1, fp);
+	items = fwrite(&nel, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 
@@ -101,10 +101,10 @@
 		    FILE * fp)
 {
 	__u32 sens;
-	int items;
+	size_t items;
 
 	sens = cpu_to_le32(l->sens);
-	items = fwrite(&sens, sizeof(__u32), 1, fp);
+	items = fwrite(&sens, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 
@@ -123,7 +123,7 @@
 				  FILE * fp)
 {
 	__u32 buf[3];
-	int items, items2;
+	size_t items, items2;
 	int rel;
 
 	rel = mls_level_relation(r->level[1], r->level[0]);
@@ -163,7 +163,7 @@
 {
 	mls_perms_t *p = &cladatum->mlsperms;
 	__u32 buf[32];
-	int items, items2;
+	size_t items, items2;
 
 	items = 0;
 	buf[items++] = cpu_to_le32(p->read);
@@ -191,7 +191,7 @@
 	for (r = usrdatum->ranges; r; r = r->next)
 		nel++;
 	buf[0] = cpu_to_le32(nel);
-	items = fwrite(buf, sizeof(__u32), 1, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 	for (r = usrdatum->ranges; r; r = r->next) {
@@ -207,7 +207,7 @@
 	size_t items;
 
 	buf[0] = cpu_to_le32(p->nlevels);
-	items = fwrite(buf, sizeof(__u32), 1, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 	return 0;
@@ -227,8 +227,8 @@
 int sens_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	level_datum_t *levdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 	levdatum = (level_datum_t *) datum;
@@ -241,7 +241,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -254,8 +254,8 @@
 int cat_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	cat_datum_t *catdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 
@@ -317,8 +317,8 @@
 static int perm_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	perm_datum_t *perdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 	perdatum = (perm_datum_t *) datum;
@@ -332,7 +332,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -343,8 +343,8 @@
 static int common_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	common_datum_t *comdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 	comdatum = (common_datum_t *) datum;
@@ -359,7 +359,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -375,8 +375,8 @@
 	class_datum_t *cladatum;
 	constraint_node_t *c;
 	constraint_expr_t *e;
-	__u32 buf[32], len, len2, ncons, nexpr;
-	int items, items2;
+	__u32 buf[32], ncons, nexpr;
+	size_t items, items2, len, len2;
 	FILE *fp = p;
 
 	cladatum = (class_datum_t *) datum;
@@ -406,12 +406,12 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
 	if (cladatum->comkey) {
-		items = fwrite(cladatum->comkey, 1, len2, fp);
+		items = fwrite(cladatum->comkey, (size_t) 1, len2, fp);
 		if (items != len2)
 			return -1;
 	}
@@ -425,7 +425,7 @@
 		}
 		buf[0] = cpu_to_le32(c->permissions);
 		buf[1] = cpu_to_le32(nexpr);
-		items = fwrite(buf, sizeof(__u32), 2, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 2, fp);
 		if (items != 2)
 			return -1;
 		for (e = c->expr; e; e = e->next) {
@@ -457,8 +457,8 @@
 static int role_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	role_datum_t *role;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 	role = (role_datum_t *) datum;
@@ -471,7 +471,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -487,8 +487,8 @@
 static int type_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	type_datum_t *typdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 	typdatum = (type_datum_t *) datum;
@@ -502,7 +502,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -512,8 +512,8 @@
 static int user_write(hashtab_key_t key, hashtab_datum_t datum, void *p)
 {
 	user_datum_t *usrdatum;
-	__u32 buf[32], len;
-	int items, items2;
+	__u32 buf[32];
+	size_t items, items2, len;
 	FILE *fp = p;
 
 
@@ -527,7 +527,7 @@
 	if (items != items2)
 		return -1;
 
-	items = fwrite(key, 1, len, fp);
+	items = fwrite(key, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -561,8 +561,8 @@
 	ocontext_t *c;
 	genfs_t *genfs;
 	int i, j;
-	__u32 buf[32], len, config, nel;
-	size_t items, items2;
+	__u32 buf[32], config;
+	size_t items, items2, len, nel;
 	char *policydb_str = POLICYDB_STRING;
 
 	config = 0;
@@ -576,7 +576,7 @@
 	items2 = fwrite(buf, sizeof(__u32), items, fp);
 	if (items != items2)
 		return -1;
-	items = fwrite(policydb_str, 1, len, fp);
+	items = fwrite(policydb_str, (size_t) 1, len, fp);
 	if (items != len)
 		return -1;
 
@@ -596,7 +596,7 @@
 	for (i = 0; i < SYM_NUM; i++) {
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
 		buf[1] = cpu_to_le32(p->symtab[i].table->nel);
-		items = fwrite(buf, sizeof(__u32), 2, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 2, fp);
 		if (items != 2)
 			return -1;
 		if (hashtab_map(p->symtab[i].table, write_f[i], fp))
@@ -610,14 +610,14 @@
 	for (tr = p->role_tr; tr; tr = tr->next) 
 		nel++;
 	buf[0] = cpu_to_le32(nel);
-	items = fwrite(buf, sizeof(__u32), 1, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 	for (tr = p->role_tr; tr; tr = tr->next) {
 		buf[0] = cpu_to_le32(tr->role);
 		buf[1] = cpu_to_le32(tr->type);
 		buf[2] = cpu_to_le32(tr->new_role);
-		items = fwrite(buf, sizeof(__u32), 3, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 3, fp);
 		if (items != 3)
 			return -1;		
 	}
@@ -626,13 +626,13 @@
 	for (ra = p->role_allow; ra; ra = ra->next) 
 		nel++;
 	buf[0] = cpu_to_le32(nel);
-	items = fwrite(buf, sizeof(__u32), 1, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;
 	for (ra = p->role_allow; ra; ra = ra->next) {
 		buf[0] = cpu_to_le32(ra->role);
 		buf[1] = cpu_to_le32(ra->new_role);
-		items = fwrite(buf, sizeof(__u32), 2, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 2, fp);
 		if (items != 2)
 			return -1;		
 	}
@@ -642,14 +642,14 @@
 		for (c = p->ocontexts[i]; c; c = c->next)
 			nel++;
 		buf[0] = cpu_to_le32(nel);
-		items = fwrite(buf, sizeof(__u32), 1, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 		if (items != 1)
 			return -1;
 		for (c = p->ocontexts[i]; c; c = c->next) {
 			switch (i) {
 			case OCON_ISID:
 				buf[0] = cpu_to_le32(c->sid[0]);
-				items = fwrite(buf, sizeof(__u32), 1, fp);
+				items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 				if (items != 1)
 					return -1;
 				if (context_write(&c->context[0], fp))
@@ -659,10 +659,10 @@
 			case OCON_NETIF:
 				len = strlen(c->u.name);
 				buf[0] = cpu_to_le32(len);
-				items = fwrite(buf, sizeof(__u32), 1, fp);
+				items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 				if (items != 1)
 					return -1;
-				items = fwrite(c->u.name, 1, len, fp);
+				items = fwrite(c->u.name, (size_t) 1, len, fp);
 				if (items != len)
 					return -1;
 				if (context_write(&c->context[0], fp))
@@ -677,7 +677,7 @@
 				for (j = 0; j < 3; j++) {
 					buf[j] = cpu_to_le32(buf[j]);
 				}
-				items = fwrite(buf, sizeof(__u32), 3, fp);
+				items = fwrite(buf, sizeof(__u32), (size_t) 3, fp);
 				if (items != 3)
 					return -1;
 				if (context_write(&c->context[0], fp))
@@ -686,7 +686,7 @@
 			case OCON_NODE:
 				buf[0] = cpu_to_le32(c->u.node.addr);
 				buf[1] = cpu_to_le32(c->u.node.mask);
-				items = fwrite(buf, sizeof(__u32), 2, fp);
+				items = fwrite(buf, sizeof(__u32), (size_t) 2, fp);
 				if (items != 2)
 					return -1;
 				if (context_write(&c->context[0], fp))
@@ -696,10 +696,10 @@
 				buf[0] = cpu_to_le32(c->v.behavior);
 				len = strlen(c->u.name);
 				buf[1] = cpu_to_le32(len);
-				items = fwrite(buf, sizeof(__u32), 2, fp);
+				items = fwrite(buf, sizeof(__u32), (size_t) 2, fp);
 				if (items != 2)
 					return -1;
-				items = fwrite(c->u.name, 1, len, fp);
+				items = fwrite(c->u.name, (size_t) 1, len, fp);
 				if (items != len)
 					return -1;
 				if (context_write(&c->context[0], fp))
@@ -713,36 +713,36 @@
 	for (genfs = p->genfs; genfs; genfs = genfs->next) 
 		nel++;
 	buf[0] = cpu_to_le32(nel);
-	items = fwrite(buf, sizeof(__u32), 1, fp);
+	items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 	if (items != 1)
 		return -1;	
 	for (genfs = p->genfs; genfs; genfs = genfs->next) {
 		len = strlen(genfs->fstype);
 		buf[0] = cpu_to_le32(len);
-		items = fwrite(buf, sizeof(__u32), 1, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 		if (items != 1)
 			return -1;
-		items = fwrite(genfs->fstype, 1, len, fp);
+		items = fwrite(genfs->fstype, (size_t) 1, len, fp);
 		if (items != len)
 			return -1;
 		nel = 0;
 		for (c = genfs->head; c; c = c->next)
 			nel++;
 		buf[0] = cpu_to_le32(nel);
-		items = fwrite(buf, sizeof(__u32), 1, fp);
+		items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 		if (items != 1)
 			return -1;
 		for (c = genfs->head; c; c = c->next) {
 			len = strlen(c->u.name);
 			buf[0] = cpu_to_le32(len);
-			items = fwrite(buf, sizeof(__u32), 1, fp);
+			items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 			if (items != 1)
 				return -1;
-			items = fwrite(c->u.name, 1, len, fp);
+			items = fwrite(c->u.name, (size_t) 1, len, fp);
 			if (items != len)
 				return -1;
 			buf[0] = cpu_to_le32(c->v.sclass);
-			items = fwrite(buf, sizeof(__u32), 1, fp);
+			items = fwrite(buf, sizeof(__u32), (size_t) 1, fp);
 			if (items != 1)
 				return -1;
 			if (context_write(&c->context[0], fp))
Only in nsa/selinux-usr/checkpolicy: write.o
Only in nsa/selinux-usr/checkpolicy: y.tab.c
Only in nsa/selinux-usr/checkpolicy: y.tab.h
Only in nsa/selinux-usr/checkpolicy: y.tab.o
diff -ru nsa.orig/selinux-usr/libselinux/include/selinux/selinux.h nsa/selinux-usr/libselinux/include/selinux/selinux.h
--- nsa.orig/selinux-usr/libselinux/include/selinux/selinux.h	2003-10-03 20:16:12.000000000 +0200
+++ nsa/selinux-usr/libselinux/include/selinux/selinux.h	2003-10-04 19:22:03.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _SELINUX_H_
 #define _SELINUX_H_
 
+#include <stdint.h>
 #include <sys/types.h>
 
 /* Return 1 if we are running on a SELinux kernel, or 0 otherwise. */
@@ -63,8 +64,8 @@
 
 /* Wrappers for the selinuxfs (policy) API. */
 
-typedef unsigned int access_vector_t;
-typedef unsigned short security_class_t;
+typedef uint32_t access_vector_t;
+typedef uint32_t security_class_t;
 
 struct av_decision {
 	access_vector_t allowed;
diff -ru nsa.orig/selinux-usr/libselinux/src/Makefile nsa/selinux-usr/libselinux/src/Makefile
--- nsa.orig/selinux-usr/libselinux/src/Makefile	2003-09-25 16:49:43.000000000 +0200
+++ nsa/selinux-usr/libselinux/src/Makefile	2003-10-04 20:22:16.000000000 +0200
@@ -9,7 +9,7 @@
 TARGET=libselinux.so
 LIBSO=$(TARGET).$(LIBVERSION)
 OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
-CFLAGS = -Wall
+CFLAGS = -Wall -W -Werror
 override CFLAGS += -fPIC -I../include 
 
 all: $(LIBA) $(LIBSO)
Only in nsa/selinux-usr/libselinux/src: check_context.o
Only in nsa/selinux-usr/libselinux/src: compute_av.o
Only in nsa/selinux-usr/libselinux/src: compute_create.o
Only in nsa/selinux-usr/libselinux/src: compute_relabel.o
diff -ru nsa.orig/selinux-usr/libselinux/src/compute_user.c nsa/selinux-usr/libselinux/src/compute_user.c
--- nsa.orig/selinux-usr/libselinux/src/compute_user.c	2003-10-03 20:16:13.000000000 +0200
+++ nsa/selinux-usr/libselinux/src/compute_user.c	2003-10-04 20:22:36.000000000 +0200
@@ -16,8 +16,8 @@
 	char **ary;
 	char *buf, *ptr;
 	size_t size;
-	int fd, ret, i;
-	unsigned int nel;
+	int fd, ret;
+	unsigned int i, nel;
 
 	fd = open(SELINUXMNT "user", O_RDWR);
 	if (fd < 0)
Only in nsa/selinux-usr/libselinux/src: compute_user.o
Only in nsa/selinux-usr/libselinux/src: context.o
Only in nsa/selinux-usr/libselinux/src: enabled.o
diff -ru nsa.orig/selinux-usr/libselinux/src/fgetfilecon.c nsa/selinux-usr/libselinux/src/fgetfilecon.c
--- nsa.orig/selinux-usr/libselinux/src/fgetfilecon.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/libselinux/src/fgetfilecon.c	2003-10-04 20:23:43.000000000 +0200
@@ -23,8 +23,8 @@
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
-		size = fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
-		if (size < 0)
+		ret = fgetxattr(fd, XATTR_NAME_SELINUX, NULL, 0);
+		if (ret < 0)
 			goto out;
 
 		size++;
Only in nsa/selinux-usr/libselinux/src: fgetfilecon.o
Only in nsa/selinux-usr/libselinux/src: freecon.o
Only in nsa/selinux-usr/libselinux/src: freeconary.o
Only in nsa/selinux-usr/libselinux/src: fsetfilecon.o
Only in nsa/selinux-usr/libselinux/src: get_context_list.o
Only in nsa/selinux-usr/libselinux/src: get_default_type.o
Only in nsa/selinux-usr/libselinux/src: getcon.o
Only in nsa/selinux-usr/libselinux/src: getexeccon.o
diff -ru nsa.orig/selinux-usr/libselinux/src/getfilecon.c nsa/selinux-usr/libselinux/src/getfilecon.c
--- nsa.orig/selinux-usr/libselinux/src/getfilecon.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/libselinux/src/getfilecon.c	2003-10-04 20:24:11.000000000 +0200
@@ -23,8 +23,8 @@
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
-		size = getxattr(path, XATTR_NAME_SELINUX, NULL, 0);
-		if (size < 0)
+		ret = getxattr(path, XATTR_NAME_SELINUX, NULL, 0);
+		if (ret < 0)
 			goto out;
 
 		size++;
Only in nsa/selinux-usr/libselinux/src: getfilecon.o
Only in nsa/selinux-usr/libselinux/src: getfscreatecon.o
Only in nsa/selinux-usr/libselinux/src: getpidcon.o
Only in nsa/selinux-usr/libselinux/src: getprevcon.o
diff -ru nsa.orig/selinux-usr/libselinux/src/helpers.c nsa/selinux-usr/libselinux/src/helpers.c
--- nsa.orig/selinux-usr/libselinux/src/helpers.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/libselinux/src/helpers.c	2003-10-04 20:24:42.000000000 +0200
@@ -23,7 +23,7 @@
 
 security_class_t string_to_security_class(const char *s)
 {
-	int val;
+	unsigned int val;
 
 	if (isdigit(s[0])) {
 		val = atoi(s);
@@ -45,7 +45,7 @@
 {
         char          **common_pts = 0;
         access_vector_t common_base = 0;
-        int             i, i2, perm;
+        unsigned int             i, i2, perm;
  
  
         if (av == 0) {
Only in nsa/selinux-usr/libselinux/src: helpers.o
diff -ru nsa.orig/selinux-usr/libselinux/src/lgetfilecon.c nsa/selinux-usr/libselinux/src/lgetfilecon.c
--- nsa.orig/selinux-usr/libselinux/src/lgetfilecon.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/libselinux/src/lgetfilecon.c	2003-10-04 20:24:54.000000000 +0200
@@ -23,8 +23,8 @@
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
-		size = lgetxattr(path, XATTR_NAME_SELINUX, NULL, 0);
-		if (size < 0)
+		ret = lgetxattr(path, XATTR_NAME_SELINUX, NULL, 0);
+		if (ret < 0)
 			goto out;
 
 		size++;
Only in nsa/selinux-usr/libselinux/src: lgetfilecon.o
Only in nsa/selinux-usr/libselinux/src: libselinux.a
Only in nsa/selinux-usr/libselinux/src: libselinux.so
Only in nsa/selinux-usr/libselinux/src: libselinux.so.1
Only in nsa/selinux-usr/libselinux/src: load_policy.o
Only in nsa/selinux-usr/libselinux/src: lsetfilecon.o
Only in nsa/selinux-usr/libselinux/src: query_user_context.o
Only in nsa/selinux-usr/libselinux/src: setexeccon.o
Only in nsa/selinux-usr/libselinux/src: setfilecon.o
Only in nsa/selinux-usr/libselinux/src: setfscreatecon.o
diff -ru nsa.orig/selinux-usr/libselinux/utils/Makefile nsa/selinux-usr/libselinux/utils/Makefile
--- nsa.orig/selinux-usr/libselinux/utils/Makefile	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/libselinux/utils/Makefile	2003-10-04 20:29:59.000000000 +0200
@@ -2,7 +2,7 @@
 PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
 
-CFLAGS = -Wall
+CFLAGS = -Wall -W -Werror
 override CFLAGS += -I../include
 LDLIBS += -L../src -lselinux -lattr
 
Only in nsa/selinux-usr/libselinux/utils: compute_av
diff -ru nsa.orig/selinux-usr/libselinux/utils/compute_av.c nsa/selinux-usr/libselinux/utils/compute_av.c
--- nsa.orig/selinux-usr/libselinux/utils/compute_av.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/libselinux/utils/compute_av.c	2003-10-04 20:31:04.000000000 +0200
@@ -32,7 +32,7 @@
 	print_access_vector(tclass, avd.allowed);
 	printf("\n");
 
-	if (avd.decided != ~0) {
+	if (avd.decided != (unsigned) -1) {
 		printf("decided=");
 		print_access_vector(tclass, avd.decided);
 		printf("\n");
@@ -44,7 +44,7 @@
 		printf("\n");
 	}
 
-	if (avd.auditdeny != ~0) {
+	if (avd.auditdeny != (unsigned) -1) {
 		printf("auditdeny");
 		print_access_vector(tclass, avd.auditdeny);
 		printf("\n");
Only in nsa/selinux-usr/libselinux/utils: compute_create
Only in nsa/selinux-usr/libselinux/utils: compute_relabel
Only in nsa/selinux-usr/libselinux/utils: compute_user
Only in nsa/selinux-usr/libselinux/utils: deftype
Only in nsa/selinux-usr/libselinux/utils: execcon
Only in nsa/selinux-usr/libselinux/utils: getcon
diff -ru nsa.orig/selinux-usr/libselinux/utils/getcon.c nsa/selinux-usr/libselinux/utils/getcon.c
--- nsa.orig/selinux-usr/libselinux/utils/getcon.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/libselinux/utils/getcon.c	2003-10-04 20:31:32.000000000 +0200
@@ -3,7 +3,7 @@
 #include <stdlib.h>
 #include <selinux/selinux.h>
 
-int main(int argc, char **argv) 
+int main(int argc __attribute__ ((unused)), char **argv) 
 {
 	char *buf;
 	int rc;
Only in nsa/selinux-usr/libselinux/utils: getconlist
Only in nsa/selinux-usr/libselinux/utils: getfilecon
Only in nsa/selinux-usr/libselinux/utils: getpidcon
Only in nsa/selinux-usr/libselinux/utils: mkdircon
diff -ru nsa.orig/selinux-usr/libselinux/utils/mkdircon.c nsa/selinux-usr/libselinux/utils/mkdircon.c
--- nsa.orig/selinux-usr/libselinux/utils/mkdircon.c	2003-08-14 14:37:35.000000000 +0200
+++ nsa/selinux-usr/libselinux/utils/mkdircon.c	2003-10-04 20:31:48.000000000 +0200
@@ -8,7 +8,7 @@
 int main(int argc, char **argv) 
 {
 	int rc;
-	unsigned i;
+	int i;
 
 	if (argc < 3) {
 		fprintf(stderr, "usage:  %s context dirname...\n",
Only in nsa/selinux-usr/libselinux/utils: setfilecon
diff -ru nsa.orig/selinux-usr/policy/Makefile nsa/selinux-usr/policy/Makefile
--- nsa.orig/selinux-usr/policy/Makefile	2003-09-25 16:49:43.000000000 +0200
+++ nsa/selinux-usr/policy/Makefile	2003-10-04 20:36:12.000000000 +0200
@@ -19,9 +19,12 @@
 PREFIX = /usr
 BINDIR = $(PREFIX)/bin
 SBINDIR = $(PREFIX)/sbin
-LOADPOLICY  = $(SBINDIR)/load_policy
-CHECKPOLICY = $(BINDIR)/checkpolicy
-SETFILES = $(SBINDIR)/setfiles
+LOADPOLICY  = ../policycoreutils/load_policy/load_policy
+CHECKPOLICY = ../checkpolicy/checkpolicy
+SETFILES = ../policycoreutils/setfiles/setfiles
+
+LD_LIBRARY_PATH = ../libselinux/src
+export LD_LIBRARY_PATH
 
 POLICYVER := policy.$(shell $(CHECKPOLICY) -V)
 INSTALLDIR = $(DESTDIR)/etc/security/selinux
Only in nsa/selinux-usr/policy/file_contexts: file_contexts
Only in nsa/selinux-usr/policy: policy.15
Only in nsa/selinux-usr/policy: policy.conf
Only in nsa/selinux-usr/policy: tmp
diff -ru nsa.orig/selinux-usr/policycoreutils/load_policy/Makefile nsa/selinux-usr/policycoreutils/load_policy/Makefile
--- nsa.orig/selinux-usr/policycoreutils/load_policy/Makefile	2003-09-25 16:49:43.000000000 +0200
+++ nsa/selinux-usr/policycoreutils/load_policy/Makefile	2003-10-04 20:28:05.000000000 +0200
@@ -3,8 +3,8 @@
 SBINDIR ?= $(PREFIX)/sbin
 LOCALEDIR ?= /usr/share/locale
 
-CFLAGS = -Wall -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux
+CFLAGS = -Wall -W -Werror -I../../libselinux/include -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+LDLIBS += -L../../libselinux/src -lselinux
 
 # Build static so that we can put it on an initrd.
 LDFLAGS += -static
Only in nsa/selinux-usr/policycoreutils/load_policy: load_policy
diff -ru nsa.orig/selinux-usr/policycoreutils/newrole/Makefile nsa/selinux-usr/policycoreutils/newrole/Makefile
--- nsa.orig/selinux-usr/policycoreutils/newrole/Makefile	2003-09-25 16:49:43.000000000 +0200
+++ nsa/selinux-usr/policycoreutils/newrole/Makefile	2003-10-04 20:28:43.000000000 +0200
@@ -5,9 +5,9 @@
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR = /usr/share/locale
 
-CFLAGS = -Wall -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+CFLAGS = -Wall -W -Werror -I../../libselinux/include -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 override CFLAGS += -DUSE_PAM
-LDLIBS += -lselinux -lattr -ldl -lpam -lpam_misc
+LDLIBS += -L../../libselinux/src -lselinux -lattr -ldl -lpam -lpam_misc
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
Only in nsa/selinux-usr/policycoreutils/newrole: newrole
Only in nsa/selinux-usr/policycoreutils/po: sv.gmo
diff -ru nsa.orig/selinux-usr/policycoreutils/run_init/Makefile nsa/selinux-usr/policycoreutils/run_init/Makefile
--- nsa.orig/selinux-usr/policycoreutils/run_init/Makefile	2003-09-25 16:49:44.000000000 +0200
+++ nsa/selinux-usr/policycoreutils/run_init/Makefile	2003-10-04 20:29:18.000000000 +0200
@@ -6,9 +6,9 @@
 ETCDIR ?= $(DESTDIR)/etc
 LOCALEDIR ?= /usr/share/locale
 
-CFLAGS = -Wall -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+CFLAGS = -Wall -W -Werror -I../../libselinux/include -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
 override CFLAGS += -DUSE_PAM
-LDLIBS += -lselinux -lattr -ldl -lpam -lpam_misc
+LDLIBS += -L../../libselinux/src -lselinux -lattr -ldl -lpam -lpam_misc
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
Only in nsa/selinux-usr/policycoreutils/run_init: run_init
diff -ru nsa.orig/selinux-usr/policycoreutils/setfiles/Makefile nsa/selinux-usr/policycoreutils/setfiles/Makefile
--- nsa.orig/selinux-usr/policycoreutils/setfiles/Makefile	2003-09-25 16:49:44.000000000 +0200
+++ nsa/selinux-usr/policycoreutils/setfiles/Makefile	2003-10-04 20:27:26.000000000 +0200
@@ -3,9 +3,9 @@
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 
-CFLAGS = -Wall
+CFLAGS = -Wall -W -Werror -I../../libselinux/include
 override CFLAGS += -D_FILE_OFFSET_BITS=64
-LDLIBS += -lselinux -lattr
+LDLIBS += -L../../libselinux/src -lselinux -lattr
 
 all: setfiles
 
Only in nsa/selinux-usr/policycoreutils/setfiles: setfiles
diff -ru nsa.orig/selinux-usr/policycoreutils/setfiles/setfiles.c nsa/selinux-usr/policycoreutils/setfiles/setfiles.c
--- nsa.orig/selinux-usr/policycoreutils/setfiles/setfiles.c	2003-09-25 17:09:26.000000000 +0200
+++ nsa/selinux-usr/policycoreutils/setfiles/setfiles.c	2003-10-04 20:27:10.000000000 +0200
@@ -553,7 +553,7 @@
  * the directory traversal.
  */
 static int apply_spec(const char *file,
-		      const struct stat *sb, int flag, struct FTW *s)
+		      const struct stat *sb __attribute__ ((unused)), int flag, struct FTW *s __attribute__ ((unused)))
 {
 	const char *my_file;
 	file_spec_t *fl;
Only in nsa/selinux-usr/policycoreutils/setfiles: setfiles.o
diff -ru nsa.orig/selinux-usr/setools/Makefile nsa/selinux-usr/setools/Makefile
--- nsa.orig/selinux-usr/setools/Makefile	2003-10-02 15:40:04.000000000 +0200
+++ nsa/selinux-usr/setools/Makefile	2003-10-04 20:17:58.000000000 +0200
@@ -3,9 +3,9 @@
 MAKEFILE =  Makefile
 MAKE = make
 
-TCL_INCLUDE	= -I/usr/include
+TCL_INCLUDE	= -I/usr/include/tcl8.4
 TCL_LIBINC	= -L/usr/lib
-TCL_LIBS	= -ltk8.3 -ltcl8.3 -lfl -lm -ldl
+TCL_LIBS	= -ltk8.4 -ltcl8.4 -lfl -lm -ldl
 
 # NOTE: if you are using tcl/tk 8.4 you may want to uncomment the following 
 # three lines and then comment or remove the three lines above. You may still 
Only in nsa/selinux-usr/setools/apol: apol
Only in nsa/selinux-usr/setools/apol: apol.tcl
Only in nsa/selinux-usr/setools/apol: apol_gui.o
Only in nsa/selinux-usr/setools/apol: tmp.tcl
Only in nsa/selinux-usr/setools/awish: awish
Only in nsa/selinux-usr/setools/awish: awish.o
Only in nsa/selinux-usr/setools: lib
Only in nsa/selinux-usr/setools/libapol: analysis.o
Only in nsa/selinux-usr/setools/libapol: apol_tcl.o
Only in nsa/selinux-usr/setools/libapol: avl-util.o
Only in nsa/selinux-usr/setools/libapol: clone.o
Only in nsa/selinux-usr/setools/libapol: lex.yy.c
Only in nsa/selinux-usr/setools/libapol: lex.yy.o
Only in nsa/selinux-usr/setools/libapol: perm-map.o
Only in nsa/selinux-usr/setools/libapol: policy-avl.o
Only in nsa/selinux-usr/setools/libapol: policy.o
Only in nsa/selinux-usr/setools/libapol: queue.o
Only in nsa/selinux-usr/setools/libapol: render.o
Only in nsa/selinux-usr/setools/libapol: util.o
Only in nsa/selinux-usr/setools/libapol: y.tab.c
Only in nsa/selinux-usr/setools/libapol: y.tab.h
Only in nsa/selinux-usr/setools/libapol: y.tab.o
Only in nsa/selinux-usr/setools/libseuser: seuser_db.o
Only in nsa/selinux-usr/setools/libseuser: seuser_tcl.o
Only in nsa/selinux-usr/setools/libseuser: seuser_wrap.o
Only in nsa/selinux-usr/setools/sepct: sepcut
Only in nsa/selinux-usr/setools/sepct: tmp.tcl
Only in nsa/selinux-usr/setools/seuser: se_user.tcl
Only in nsa/selinux-usr/setools/seuser: seuser
Only in nsa/selinux-usr/setools/seuser: seuser_gui.o
Only in nsa/selinux-usr/setools/seuser: tmp.tcl

--4Ckj6UjgE2iN1+kY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
