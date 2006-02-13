Subject: Re: [PATCH 1/3] libsepol - fix aliased sensitivities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kevin Carr <kcarr@tresys.com>
Cc: selinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>
In-Reply-To: <1139317306.2872.15.camel@moss-spartans.epoch.ncsc.mil>
References: <200602062221.k16MLUNq011736@gotham.columbia.tresys.com>
	 <1139317306.2872.15.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 11:20:00 -0500
Message-Id: <1139847600.14253.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-07 at 08:01 -0500, Stephen Smalley wrote:
> On Mon, 2006-02-06 at 17:21 -0500, Kevin Carr wrote:
> > While testing MLS features in apol we realized a few problems with aliased
> > sensitivities in libsepol.  This first patch fixes a double free in
> > sens_destroy().
> 
> No, the correct solution is to avoid the aliasing in the checkpolicy
> code.  That is what we have been doing for other similar cases;
> policydb_read in libsepol and the kernel doesn't do any such aliasing,
> and neither should checkpolicy.

So I think the patch below should solve the problem for checkpolicy,
while leaving libsepol's behavior unmodified and consistent with the
kernel's behavior (i.e. no pointer aliasing).  Look sane?

Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.57
diff -u -p -r1.57 policy_parse.y
--- checkpolicy/policy_parse.y	13 Feb 2006 13:59:53 -0000	1.57
+++ checkpolicy/policy_parse.y	13 Feb 2006 16:00:20 -0000
@@ -1564,6 +1564,23 @@ static int define_category(void)
 	return -1;
 }
 
+static int clone_level(hashtab_key_t key, hashtab_datum_t datum, void *arg)
+{
+	level_datum_t *levdatum = (level_datum_t *) datum;
+	mls_level_t *level = (mls_level_t *) arg, *newlevel;
+
+	if (levdatum->isalias && levdatum->level == level) {
+		newlevel = (mls_level_t *) malloc(sizeof(mls_level_t));
+		if (!newlevel)
+			return -1;
+		if (mls_level_cpy(newlevel, level)) {
+			free(newlevel);
+			return -1;
+		}
+		levdatum->level = newlevel;
+	}
+	return 0;
+}
 
 static int define_level(void)
 {
@@ -1654,6 +1671,11 @@ static int define_level(void)
 		free(id);
 	}
 
+	if (hashtab_map(policydbp->p_levels.table, clone_level, levdatum->level)) {
+		yyerror("out of memory");
+		return -1;
+	}
+
 	return 0;
 }
 


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
