Message-ID: <4787DB82.70609@redhat.com>
Date: Fri, 11 Jan 2008 16:11:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to use new audit2why interface in via audit2allow
Content-Type: multipart/mixed;
 boundary="------------080001010806040501050102"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080001010806040501050102
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Added a --why qualifier to audit2allow, which gives the same output as
audit2why.

Removed audit2why.c and replaced it with a script

#!/bin/sh
/usr/bin/audit2allow -w $*

This way audit2why can take advantage of the parsing available in
audit2allow.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeH24EACgkQrlYvE4MpobMSagCgmK5S8TGx8485X1769oqrzLF6
iuwAoKUWB6tGrrTHFkDJqz41xTSv1Tvy
=M+CO
-----END PGP SIGNATURE-----

--------------080001010806040501050102
Content-Type: text/plain;
 name="policycoreutils-audit2why.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-audit2why.patch"

diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-2.0.35/audit2allow/audit2allow
--- nsapolicycoreutils/audit2allow/audit2allow	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.35/audit2allow/audit2allow	2008-01-11 11:17:46.000000000 -0500
@@ -60,7 +60,10 @@
         parser.add_option("-o", "--output", dest="output",
                           help="append output to <filename>, conflicts with -M")
         parser.add_option("-R", "--reference", action="store_true", dest="refpolicy",
-                          default=False, help="generate refpolicy style output")
+                          default=True, help="generate refpolicy style output")
+
+        parser.add_option("-N", "--noreference", action="store_false", dest="refpolicy",
+                          default=False, help="do not generate refpolicy style output")
         parser.add_option("-v", "--verbose", action="store_true", dest="verbose",
                           default=False, help="explain generated output")
         parser.add_option("-e", "--explain", action="store_true", dest="explain_long",
@@ -72,6 +75,9 @@
         parser.add_option("--debug", dest="debug", action="store_true", default=False,
                           help="leave generated modules for -M")
 
+        parser.add_option("-w", "--why", dest="audit2why",  action="store_true", default=False,
+                          help="Translates SELinux audit messages into a description of why the access was denied")
+
         options, args = parser.parse_args()
 
         # Make -d, -a, and -i conflict
@@ -149,8 +155,10 @@
         if self.__options.type:
             filter = audit.TypeFilter(self.__options.type)
             self.__avs = self.__parser.to_access(filter)
+            self.__selinux_errs = self.__parser.to_role(filter)
         else:
             self.__avs = self.__parser.to_access()
+            self.__selinux_errs = self.__parser.to_role()
 
     def __load_interface_info(self):
         # Load interface info file
@@ -210,7 +218,71 @@
         sys.stdout.write((_("To make this policy package active, execute:" +\
                                 "\n\nsemodule -i %s\n\n") % packagename))
 
+    def __output_audit2why(self):
+            import selinux
+            import selinux.audit2why as audit2why
+            audit2why.init("%s.%s" % (selinux.selinux_binary_policy_path(), selinux.security_policyvers()))
+            for i in self.__parser.avc_msgs:
+                rc, bools = audit2why.analyze(i.scontext.to_string(), i.tcontext.to_string(), i.tclass, i.accesses)
+                if rc >= 0:
+                    print "%s\n\tWas caused by:" % i.message
+                if rc == audit2why.NOPOLICY:
+                    raise "Must call policy_init first"
+                if rc == audit2why.BADTCON:
+                    print "Invalid Target Context %s\n" % i.tcontext
+                    continue
+                if rc == audit2why.BADSCON:
+                    print "Invalid Source Context %s\n" % i.scontext
+                    continue
+                if rc == audit2why.BADSCON:
+                    print "Invalid Type Class %s\n" % i.tclass
+                    continue
+                if rc == audit2why.BADPERM:
+                    print "Invalid permission %s\n" % i.accesses
+                    continue
+                if rc == audit2why. BADCOMPUTE:
+                    raise "Error during access vector computation"
+                if rc == audit2why.ALLOW:
+                    print "\t\tUnknown - would be allowed by active policy\n",
+                    print "\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n"
+                    print "\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n"
+                    continue
+                if rc == audit2why.BOOLEAN:
+                    if len(bools) > 1:
+                        print "\tOne of the following booleans being set incorrectly."
+                        for b in bools:
+                            print "\n\tBoolean %s is %d. Allow access by executing:" % (b[0], not b[1])
+                            print "\t# setsebool -P %s %d"  % (b[0], b[1])
+                    else:
+                        print "\tThe boolean %s set incorrectly.  Allow access by executing:" % bools[0][0]
+                        print "\t# setsebool -P %s %d\n"  % (bools[0][0], bools[0][1])
+
+                    continue
+
+                if rc == audit2why.TERULE:
+                    print "\t\tMissing or disabled type enforcingment (TE) allow rule.\n"
+                    print "\t\tYou can use audit2allow to generate the missing allow rules and/or load policy to allow this access.\n"
+                    continue
+
+                if rc == audit2why.CONSTRAINT:
+                    print "\t\tConstraint violation.\n"
+                    print "\t\tCheck policy/constraints.\n"
+                    print "\t\tTypically, you just need to add a type attribute to the domain to satisfy the constraint.\n"
+                    continue
+
+                if rc == audit2why.RBAC:
+                    print "\t\tMissing role allow rule.\n"
+                    print "\t\tAdd allow rule for the role pair.\n"
+                    continue
+
+            audit2why.finish()
+            return
+
     def __output(self):
+        
+        if self.__options.audit2why:
+            return self.__output_audit2why()
+
         g = policygen.PolicyGenerator()
 
         if self.__options.module:
@@ -251,6 +323,12 @@
                 fd = sys.stdout
             writer.write(g.get_module(), fd)
 
+            if len(self.__selinux_errs) > 0:
+                fd.write("\n=========== ROLES ===============\n")
+
+            for role in self.__selinux_errs:
+                fd.write(role.output())
+
     def main(self):
         try:
             self.__parse_options()
diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2allow/audit2allow.1 policycoreutils-2.0.35/audit2allow/audit2allow.1
--- nsapolicycoreutils/audit2allow/audit2allow.1	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.35/audit2allow/audit2allow.1	2008-01-11 11:25:54.000000000 -0500
@@ -24,7 +24,12 @@
 .\"
 .TH AUDIT2ALLOW "1" "January 2005" "Security Enhanced Linux" NSA
 .SH NAME
-audit2allow \- generate SELinux policy allow rules from logs of denied operations
+.BR audit2allow
+	\- generate SELinux policy allow rules from logs of denied operations
+
+.BR audit2why  
+	\- translates SELinux audit messages into a description of why the access was denied (audit2allow -w)
+
 .SH SYNOPSIS
 .B audit2allow
 .RI [ options "] "
@@ -65,12 +70,19 @@
 .B "\-r" | "\-\-requires"
 Generate require output syntax for loadable modules.
 .TP
+.B "\-N" | "\-\-noreference"
+Do not generate reference policy, traditional style allow rules.
+.TP
 .B "\-R" | "\-\-reference"
-Generate reference policy using installed macros.  Requires the selinux-policy-devel package.
+Generate reference policy using installed macros.Default
 .TP
 .B "\-t "  | "\-\-tefile"
 Indicates input file is a te (type enforcement) file.  This can be used to translate old te format to new policy format.
 .TP
+.B "\-w" | "\-\-why"
+Translates SELinux audit messages into a description of why the access wasn denied
+
+.TP
 .B "\-v" | "\-\-verbose"
 Turn on verbose output
 
diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2why/audit2why policycoreutils-2.0.35/audit2why/audit2why
--- nsapolicycoreutils/audit2why/audit2why	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-2.0.35/audit2why/audit2why	2008-01-11 11:26:34.000000000 -0500
@@ -0,0 +1,2 @@
+#!/bin/sh
+/usr/bin/audit2allow -w $*
diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2why/audit2why.1 policycoreutils-2.0.35/audit2why/audit2why.1
--- nsapolicycoreutils/audit2why/audit2why.1	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-2.0.35/audit2why/audit2why.1	2008-01-11 11:30:41.000000000 -0500
@@ -0,0 +1 @@
+.so man1/audit2allow.1
diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2why/audit2why.8 policycoreutils-2.0.35/audit2why/audit2why.8
--- nsapolicycoreutils/audit2why/audit2why.8	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.35/audit2why/audit2why.8	1969-12-31 19:00:00.000000000 -0500
@@ -1,79 +0,0 @@
-.\" Hey, Emacs! This is an -*- nroff -*- source file.
-.\" Copyright (c) 2005 Dan Walsh <dwalsh@redhat.com>
-.\"
-.\" This is free documentation; you can redistribute it and/or
-.\" modify it under the terms of the GNU General Public License as
-.\" published by the Free Software Foundation; either version 2 of
-.\" the License, or (at your option) any later version.
-.\"
-.\" The GNU General Public License's references to "object code"
-.\" and "executables" are to be interpreted as the output of any
-.\" document formatting or typesetting system, including
-.\" intermediate and printed output.
-.\"
-.\" This manual is distributed in the hope that it will be useful,
-.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\" GNU General Public License for more details.
-.\"
-.\" You should have received a copy of the GNU General Public
-.\" License along with this manual; if not, write to the Free
-.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
-.\" USA.
-.\"
-.\"
-.TH AUDIT2WHY "8" "May 2005" "Security Enhanced Linux" NSA
-.SH NAME
-audit2why \- Translates SELinux audit messages into a description of why the access was denied
-.SH SYNOPSIS
-.B audit2why
-.RI [ options "] "
-.SH OPTIONS
-.TP
-
-.B "\-\-help"
-Print a short usage message
-.TP
-.B "\-p <policyfile>"
-Specify an alternate policy file.
-.SH DESCRIPTION
-.PP
-This utility processes SELinux audit messages from standard
-input and and reports which component of the policy caused each
-permission denial based on the specified policy file if the -p option
-was used or the active policy otherwise.  There are three possible
-causes: 1) a missing or disabled TE allow rule, 2) a constraint violation, 
-or 3) a missing role allow rule.   In the first case, the TE allow
-rule may exist in the policy but may be disabled due to boolean settings.
-See 
-.BR booleans (8).
-If the allow rule is not present at all, it can be generated via
-.BR audit2allow (1).
-In the second case, a constraint is being violated; see policy/constraints
-or policy/mls to identify the particular constraint.  Typically, this can
-be resolved by adding a type attribute to the domain.  In the third case,
-a role transition was attempted but no allow rule existed for the role pair.
-This can be resolved by adding an allow rule for the role pair to the policy.
-.PP
-.SH EXAMPLE
-.nf
-$ /usr/sbin/audit2why < /var/log/audit/audit.log
-
-type=KERNEL msg=audit(1115316408.926:336418): avc:  denied  { getattr } for  path=/home/sds dev=hda5 ino=1175041 scontext=root:secadm_r:secadm_t:s0-s9:c0.c127 tcontext=user_u:object_r:user_home_dir_t:s0 tclass=dir
-        Was caused by:
-                Missing or disabled TE allow rule.
-                Allow rules may exist but be disabled by boolean settings; check boolean settings.
-                You can see the necessary allow rules by running audit2allow with this audit message as input.
-
-type=KERNEL msg=audit(1115320071.648:606858): avc:  denied  { append } for  name=.bash_history dev=hda5 ino=1175047 scontext=user_u:user_r:user_t:s1-s9:c0.c127 tcontext=user_u:object_r:user_home_t:s0 tclass=file
-        Was caused by:
-                Constraint violation.
-                Check policy/constraints.
-                Typically, you just need to add a type attribute to the domain to satisfy the constraint.
-.fi
-.PP
-.SH AUTHOR
-This manual page was written by 
-.I Dan Walsh <dwalsh@redhat.com>,
-.B audit2why
-utility was written by Stephen Smalley <sds@tycho.nsa.gov>.
diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2why/audit2why.c policycoreutils-2.0.35/audit2why/audit2why.c
--- nsapolicycoreutils/audit2why/audit2why.c	2008-01-11 10:52:37.000000000 -0500
+++ policycoreutils-2.0.35/audit2why/audit2why.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,313 +0,0 @@
-#define _GNU_SOURCE
-#include <unistd.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <errno.h>
-#include <getopt.h>
-#include <limits.h>
-#include <sepol/sepol.h>
-#include <sepol/policydb/services.h>
-#include <selinux/selinux.h>
-
-#define AVCPREFIX "avc:  denied  { "
-#define SCONTEXT "scontext="
-#define TCONTEXT "tcontext="
-#define TCLASS "tclass="
-
-void usage(char *progname, int rc)
-{
-	fprintf(stderr, "usage:  %s [-p policy] < /var/log/audit/audit.log\n",
-		progname);
-	exit(rc);
-}
-
-int main(int argc, char **argv)
-{
-	char path[PATH_MAX];
-	char *buffer = NULL, *bufcopy = NULL;
-	unsigned int lineno = 0;
-	size_t len = 0, bufcopy_len = 0;
-	FILE *fp = NULL;
-	int opt, rc, set_path = 0;
-	char *p, *scon, *tcon, *tclassstr, *permstr;
-	sepol_security_id_t ssid, tsid;
-	sepol_security_class_t tclass;
-	sepol_access_vector_t perm, av;
-	struct sepol_av_decision avd;
-	unsigned int reason;
-	int vers = 0;
-	sidtab_t sidtab;
-	policydb_t policydb;
-	struct policy_file pf;
-
-	while ((opt = getopt(argc, argv, "p:?h")) > 0) {
-		switch (opt) {
-		case 'p':
-			set_path = 1;
-			strncpy(path, optarg, PATH_MAX);
-			fp = fopen(path, "r");
-			if (!fp) {
-				fprintf(stderr, "%s:  unable to open %s:  %s\n",
-					argv[0], path, strerror(errno));
-				exit(1);
-			}
-			break;
-		default:
-			usage(argv[0], 0);
-		}
-	}
-
-	if (argc - optind)
-		usage(argv[0], 1);
-
-	if (!set_path) {
-		if (!is_selinux_enabled()) {
-			fprintf(stderr,
-				"%s:  Must specify -p policy on non-SELinux systems\n",
-				argv[0]);
-			exit(1);
-		}
-		vers = security_policyvers();
-		if (vers < 0) {
-			fprintf(stderr,
-				"%s:  Could not get policy version:  %s\n",
-				argv[0], strerror(errno));
-			exit(1);
-		}
-		snprintf(path, PATH_MAX, "%s.%d",
-			 selinux_binary_policy_path(), vers);
-		fp = fopen(path, "r");
-		while (!fp && errno == ENOENT && --vers) {
-			snprintf(path, PATH_MAX, "%s.%d",
-				 selinux_binary_policy_path(), vers);
-			fp = fopen(path, "r");
-		}
-		if (!fp) {
-			snprintf(path, PATH_MAX, "%s.%d",
-				 selinux_binary_policy_path(),
-				 security_policyvers());
-			fprintf(stderr, "%s:  unable to open %s:  %s\n",
-				argv[0], path, strerror(errno));
-			exit(1);
-		}
-	}
-
-	/* Set up a policydb directly so that we can mutate it later
-	   for booleans and user settings.  Otherwise we would just use
-	   sepol_set_policydb_from_file() here. */
-	pf.fp = fp;
-	pf.type = PF_USE_STDIO;
-	if (policydb_init(&policydb)) {
-		fprintf(stderr, "%s:  policydb_init failed: %s\n",
-			argv[0], strerror(errno));
-		exit(1);
-	}
-	if (policydb_read(&policydb, &pf, 0)) {
-		fprintf(stderr, "%s:  invalid binary policy %s\n",
-			argv[0], path);
-		exit(1);
-	}
-	fclose(fp);
-	sepol_set_policydb(&policydb);
-
-	if (!set_path) {
-		/* If they didn't specify a full path of a binary policy file,
-		   then also try loading any boolean settings and user
-		   definitions from the active locations.  Otherwise,
-		   they can use genpolbools and genpolusers to build a
-		   binary policy file that includes any desired settings
-		   and then apply audit2why -p to the resulting file. 
-		   Errors are non-fatal as such settings are optional. */
-		sepol_debug(0);
-		(void)sepol_genbools_policydb(&policydb,
-					      selinux_booleans_path());
-		(void)sepol_genusers_policydb(&policydb, selinux_users_path());
-	}
-
-	/* Initialize the sidtab for subsequent use by sepol_context_to_sid
-	   and sepol_compute_av_reason. */
-	rc = sepol_sidtab_init(&sidtab);
-	if (rc < 0) {
-		fprintf(stderr, "%s:  unable to init sidtab\n", argv[0]);
-		exit(1);
-	}
-	sepol_set_sidtab(&sidtab);
-
-	/* Process the audit messages. */
-	while (getline(&buffer, &len, stdin) > 0) {
-		size_t len2 = strlen(buffer);
-
-		if (buffer[len2 - 1] == '\n')
-			buffer[len2 - 1] = 0;
-		lineno++;
-
-		p = buffer;
-		while (*p && strncmp(p, AVCPREFIX, sizeof(AVCPREFIX) - 1))
-			p++;
-		if (!(*p))
-			continue;	/* not an avc denial */
-
-		p += sizeof(AVCPREFIX) - 1;
-
-		/* Save a copy of the original unmodified buffer. */
-		if (!bufcopy) {
-			/* Initial allocation */
-			bufcopy_len = len;
-			bufcopy = malloc(len);
-		} else if (bufcopy_len < len) {
-			/* Grow */
-			bufcopy_len = len;
-			bufcopy = realloc(bufcopy, len);
-		}
-		if (!bufcopy) {
-			fprintf(stderr, "%s:  OOM on buffer copy\n", argv[0]);
-			exit(2);
-		}
-		memcpy(bufcopy, buffer, len);
-
-		/* Remember where the permission list begins,
-		   and terminate the list. */
-		permstr = p;
-		while (*p && *p != '}')
-			p++;
-		if (!(*p)) {
-			fprintf(stderr,
-				"Missing closing bracket on line %u, skipping...\n",
-				lineno);
-			continue;
-		}
-		*p++ = 0;
-
-		/* Get scontext and convert to SID. */
-		while (*p && strncmp(p, SCONTEXT, sizeof(SCONTEXT) - 1))
-			p++;
-		if (!(*p)) {
-			fprintf(stderr, "Missing %s on line %u, skipping...\n",
-				SCONTEXT, lineno);
-			continue;
-		}
-		p += sizeof(SCONTEXT) - 1;
-		scon = p;
-		while (*p && !isspace(*p))
-			p++;
-		if (*p)
-			*p++ = 0;
-		rc = sepol_context_to_sid(scon, strlen(scon) + 1, &ssid);
-		if (rc < 0) {
-			fprintf(stderr,
-				"Invalid %s%s on line %u, skipping...\n",
-				SCONTEXT, scon, lineno);
-			continue;
-		}
-
-		/* Get tcontext and convert to SID. */
-		while (*p && strncmp(p, TCONTEXT, sizeof(TCONTEXT) - 1))
-			p++;
-		if (!(*p)) {
-			fprintf(stderr, "Missing %s on line %u, skipping...\n",
-				TCONTEXT, lineno);
-			continue;
-		}
-		p += sizeof(TCONTEXT) - 1;
-		tcon = p;
-		while (*p && !isspace(*p))
-			p++;
-		if (*p)
-			*p++ = 0;
-		rc = sepol_context_to_sid(tcon, strlen(tcon) + 1, &tsid);
-		if (rc < 0) {
-			fprintf(stderr,
-				"Invalid %s%s on line %u, skipping...\n",
-				TCONTEXT, tcon, lineno);
-			continue;
-		}
-
-		/* Get tclass= and convert to value. */
-		while (*p && strncmp(p, TCLASS, sizeof(TCLASS) - 1))
-			p++;
-		if (!(*p)) {
-			fprintf(stderr, "Missing %s on line %u, skipping...\n",
-				TCLASS, lineno);
-			continue;
-		}
-		p += sizeof(TCLASS) - 1;
-		tclassstr = p;
-		while (*p && !isspace(*p))
-			p++;
-		if (*p)
-			*p = 0;
-		tclass = string_to_security_class(tclassstr);
-		if (!tclass) {
-			fprintf(stderr,
-				"Invalid %s%s on line %u, skipping...\n",
-				TCLASS, tclassstr, lineno);
-			continue;
-		}
-
-		/* Convert the permission list to an AV. */
-		p = permstr;
-		av = 0;
-		while (*p) {
-			while (*p && !isspace(*p))
-				p++;
-			if (*p)
-				*p++ = 0;
-			perm = string_to_av_perm(tclass, permstr);
-			if (!perm) {
-				fprintf(stderr,
-					"Invalid permission %s on line %u, skipping...\n",
-					permstr, lineno);
-				continue;
-			}
-			av |= perm;
-			permstr = p;
-		}
-
-		/* Reproduce the computation. */
-		rc = sepol_compute_av_reason(ssid, tsid, tclass, av, &avd,
-					     &reason);
-		if (rc < 0) {
-			fprintf(stderr,
-				"Error during access vector computation on line %u, skipping...\n",
-				lineno);
-			continue;
-		}
-
-		printf("%s\n\tWas caused by:\n", bufcopy);
-
-		if (!reason) {
-			printf("\t\tUnknown - would be allowed by %s policy\n",
-			       set_path ? "specified" : "active");
-			printf
-			    ("\t\tPossible mismatch between this policy and the one under which the audit message was generated.\n");
-			printf
-			    ("\t\tPossible mismatch between current in-memory boolean settings vs. permanent ones.\n");
-		}
-
-		if (reason & SEPOL_COMPUTEAV_TE) {
-			printf("\t\tMissing or disabled TE allow rule.\n");
-			printf
-			    ("\t\tAllow rules may exist but be disabled by boolean settings; check boolean settings.\n");
-			printf
-			    ("\t\tYou can see the necessary allow rules by running audit2allow with this audit message as input.\n");
-		}
-
-		if (reason & SEPOL_COMPUTEAV_CONS) {
-			printf("\t\tConstraint violation.\n");
-			printf("\t\tCheck policy/constraints.\n");
-			printf
-			    ("\t\tTypically, you just need to add a type attribute to the domain to satisfy the constraint.\n");
-		}
-
-		if (reason & SEPOL_COMPUTEAV_RBAC) {
-			printf("\t\tMissing role allow rule.\n");
-			printf("\t\tAdd allow rule for the role pair.\n");
-		}
-
-		printf("\n");
-	}
-	free(buffer);
-	free(bufcopy);
-	exit(0);
-}
diff --exclude-from=exclude --exclude=sepolgen-1.0.10 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/audit2why/Makefile policycoreutils-2.0.35/audit2why/Makefile
--- nsapolicycoreutils/audit2why/Makefile	2007-07-16 14:20:41.000000000 -0400
+++ policycoreutils-2.0.35/audit2why/Makefile	2008-01-11 11:39:04.000000000 -0500
@@ -1,15 +1,7 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
-INCLUDEDIR ?= ${PREFIX}/include
-
-
-CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
-LDLIBS = ${LIBDIR}/libsepol.a -lselinux -L$(LIBDIR)
 
 TARGETS=audit2why
 
@@ -18,13 +10,5 @@
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 $(TARGETS) $(BINDIR)
-	-mkdir -p $(MANDIR)/man8
-	install -m 644 audit2why.8 $(MANDIR)/man8/
-
-clean:
-	-rm -f $(TARGETS) *.o
-
-indent:
-	../../scripts/Lindent $(wildcard *.[ch])
-
-relabel:
+	-mkdir -p $(MANDIR)/man1
+	install -m 644 audit2why.1 $(MANDIR)/man1/
 

--------------080001010806040501050102
Content-Type: application/octet-stream;
 name="policycoreutils-audit2why.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="policycoreutils-audit2why.patch.sig"

iEYEABECAAYFAkeH24IACgkQrlYvE4MpobP8UgCfVj9wtuxEUY4l5ZLob2+UgpPuimcAoJXE
ykHeeEIboxBbuad/z3m/r2CF
--------------080001010806040501050102--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
