Subject: RE: [PATCH 1/3] libsepol - fix aliased sensitivities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kevin Carr <kcarr@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Jason Tang'" <jtang@tresys.com>
In-Reply-To: <1139851503.14253.66.camel@moss-spartans.epoch.ncsc.mil>
References: <200602131712.k1DHBuNq002624@gotham.columbia.tresys.com>
	 <1139851503.14253.66.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 15:41:18 -0500
Message-Id: <1139949678.14253.317.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-02-13 at 12:25 -0500, Stephen Smalley wrote:
> On Mon, 2006-02-13 at 12:11 -0500, Kevin Carr wrote:
> > > > > sensitivities in libsepol.  This first patch fixes a double free in
> > > > > sens_destroy().
> > > >
> > > > No, the correct solution is to avoid the aliasing in the checkpolicy
> > > > code.  That is what we have been doing for other similar cases;
> > > > policydb_read in libsepol and the kernel doesn't do any such aliasing,
> > > > and neither should checkpolicy.
> > > 
> > > So I think the patch below should solve the problem for checkpolicy,
> > > while leaving libsepol's behavior unmodified and consistent with the
> > > kernel's behavior (i.e. no pointer aliasing).  Look sane?
> > 
> > If an aliased sensitivity is never used in a level definition there will
> > still be problems since the hashtab_map() is being done over levels in
> > define_level().  So we are still able to produce a segfault in that case.  
> 
> Failure to define a level for each sensitivity would be a bug in the
> policy; checkpolicy should likely check for that case and treat it as a
> fatal error.

Patch below, relative to the prior one (which was already merged), adds
such checking.

Index: libsepol/include/sepol/policydb/policydb.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/policydb/policydb.h,v
retrieving revision 1.8
diff -u -p -r1.8 policydb.h
--- libsepol/include/sepol/policydb/policydb.h	1 Feb 2006 13:59:19 -0000	1.8
+++ libsepol/include/sepol/policydb/policydb.h	14 Feb 2006 20:02:19 -0000
@@ -152,6 +152,7 @@ typedef struct user_datum {
 typedef struct level_datum {
 	mls_level_t *level;	/* sensitivity and associated categories */
 	unsigned char isalias;  /* is this sensitivity an alias for another? */
+	unsigned char defined;
 } level_datum_t;
 
 /* Category attributes */
Index: checkpolicy/checkpolicy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/checkpolicy.c,v
retrieving revision 1.45
diff -u -p -r1.45 checkpolicy.c
--- checkpolicy/checkpolicy.c	13 Feb 2006 13:59:53 -0000	1.45
+++ checkpolicy/checkpolicy.c	14 Feb 2006 20:22:10 -0000
@@ -355,6 +355,17 @@ int change_bool(char *name, int state)
 	return 0;
 }
 
+static int check_level(hashtab_key_t key, hashtab_datum_t datum, void *arg)
+{
+	level_datum_t *levdatum = (level_datum_t *) datum;
+
+	if (!levdatum->isalias && !levdatum->defined) {
+		fprintf(stderr, "Error:  sensitivity %s was not used in a level definition!\n", key);
+		return -1;
+	}
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	sepol_security_class_t tclass;
@@ -526,6 +537,9 @@ int main(int argc, char **argv)
 		if (policydb_errors) 
 			exit(1);
 
+		if (hashtab_map(policydbp->p_levels.table, check_level, NULL))
+			exit(1);
+
 		if (policydb_init(&policydb)) {
 			fprintf(stderr, "%s:  policydb_init failed\n", argv[0]);
 			exit(1);
Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.58
diff -u -p -r1.58 policy_parse.y
--- checkpolicy/policy_parse.y	13 Feb 2006 16:30:34 -0000	1.58
+++ checkpolicy/policy_parse.y	14 Feb 2006 20:20:59 -0000
@@ -1569,7 +1569,10 @@ static int clone_level(hashtab_key_t key
 	level_datum_t *levdatum = (level_datum_t *) datum;
 	mls_level_t *level = (mls_level_t *) arg, *newlevel;
 
-	if (levdatum->isalias && levdatum->level == level) {
+	if (levdatum->level == level) {
+		levdatum->defined = 1;
+		if (!levdatum->isalias)
+			return 0;
 		newlevel = (mls_level_t *) malloc(sizeof(mls_level_t));
 		if (!newlevel)
 			return -1;
@@ -1619,6 +1622,8 @@ static int define_level(void)
 	}
 	free(id);
 
+	levdatum->defined = 1;
+
 	while ((id = queue_remove(id_queue))) {
 		cat_datum_t *cdatum;
 		int range_start, range_end, i;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
