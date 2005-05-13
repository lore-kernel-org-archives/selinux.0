Subject: Re: Busted by constraints.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <42836C4C.6010301@redhat.com>
References: <428368FF.2080603@redhat.com>
	 <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>
	 <42836C4C.6010301@redhat.com>
Content-Type: multipart/mixed; boundary="=-6qrRsFS8JvwOfNQOP0vy"
Date: Fri, 13 May 2005 11:00:28 -0400
Message-Id: <1115996428.3576.47.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-6qrRsFS8JvwOfNQOP0vy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-05-12 at 10:46 -0400, Daniel J Walsh wrote:
> Well I would have no idea how to do it, but it is going to be 
> increasingly needed
> as constraints grow.
> 
> Something to tell me the failure is caused by a missing role or 
> constraint would be great.
> audit2why :^)

Ok, just committed the two attached patches for libsepol and
policycoreutils to introduce an audit2why utility.  A sample of the
output of audit2why is below from running:
$ /usr/sbin/audit2why < /var/log/audit/audit.log

type=KERNEL msg=audit(1115316525.803:399552): avc:  denied  { getattr } for  path=/home/sds dev=hda5 ino=1175041 scontext=root:secadm_r:secadm_t:s0-s9:c0.c127 tcontext=user_u:object_r:user_home_dir_t:s0 tclass=dir
	Was caused by:
		Missing TE allow rule for the type pair (use audit2allow).

type=KERNEL msg=audit(1115320071.648:606858): avc:  denied  { append } for  name=.bash_history dev=hda5 ino=1175047 scontext=user_u:user_r:user_t:s1-s9:c0.c127 tcontext=user_u:object_r:user_home_t:s0 tclass=file
	Was caused by:
		Constraint violation (add type attribute to domain to satisfy constraints or alter constraint).

-- 
Stephen Smalley
National Security Agency

--=-6qrRsFS8JvwOfNQOP0vy
Content-Description: 
Content-Disposition: attachment; filename=libsepol-audit2why.patch
Content-Type: text/x-patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: selinux-usr/libsepol/ChangeLog
diff -u selinux-usr/libsepol/ChangeLog:1.27 selinux-usr/libsepol/ChangeLog:1.28
--- selinux-usr/libsepol/ChangeLog:1.27	Mon Apr 25 15:55:29 2005
+++ selinux-usr/libsepol/ChangeLog	Fri May 13 10:40:56 2005
@@ -1,3 +1,6 @@
+1.5.7 2005-05-13
+	* Added sepol_compute_av_reason() for audit2why.
+
 1.5.6 2005-04-25
 	* Fixed bug in role hierarchy checker.
 
Index: selinux-usr/libsepol/VERSION
diff -u selinux-usr/libsepol/VERSION:1.22 selinux-usr/libsepol/VERSION:1.23
--- selinux-usr/libsepol/VERSION:1.22	Mon Apr 25 15:55:29 2005
+++ selinux-usr/libsepol/VERSION	Fri May 13 10:40:56 2005
@@ -1 +1 @@
-1.5.6
+1.5.7
Index: selinux-usr/libsepol/libsepol.spec
diff -u selinux-usr/libsepol/libsepol.spec:1.24 selinux-usr/libsepol/libsepol.spec:1.25
--- selinux-usr/libsepol/libsepol.spec:1.24	Mon Apr 25 15:55:29 2005
+++ selinux-usr/libsepol/libsepol.spec	Fri May 13 10:40:56 2005
@@ -1,6 +1,6 @@
 Summary: SELinux binary policy manipulation library 
 Name: libsepol
-Version: 1.5.6
+Version: 1.5.7
 Release: 1
 License: GPL
 Group: System Environment/Libraries
Index: selinux-usr/libsepol/include/sepol/services.h
diff -u selinux-usr/libsepol/include/sepol/services.h:1.3 selinux-usr/libsepol/include/sepol/services.h:1.4
--- selinux-usr/libsepol/include/sepol/services.h:1.3	Wed Aug 11 09:34:16 2004
+++ selinux-usr/libsepol/include/sepol/services.h	Fri May 13 10:40:57 2005
@@ -40,6 +40,18 @@
 	access_vector_t requested,		/* IN */
 	struct av_decision *avd);               /* OUT */
 
+/* Same as above, but also return the reason(s) for any
+   denials of the requested permissions. */
+#define SEPOL_COMPUTEAV_TE   1
+#define SEPOL_COMPUTEAV_CONS 2
+#define SEPOL_COMPUTEAV_RBAC 4
+int sepol_compute_av_reason(security_id_t ssid,
+			    security_id_t tsid,
+			    security_class_t tclass,
+			    access_vector_t requested,
+			    struct av_decision *avd,
+			    unsigned int *reason);
+
 /*
  * Compute a SID to use for labeling a new object in the 
  * class `tclass' based on a SID pair.  
Index: selinux-usr/libsepol/src/services.c
diff -u selinux-usr/libsepol/src/services.c:1.10 selinux-usr/libsepol/src/services.c:1.11
--- selinux-usr/libsepol/src/services.c:1.10	Thu Feb 17 09:59:27 2005
+++ selinux-usr/libsepol/src/services.c	Fri May 13 10:40:59 2005
@@ -73,7 +73,7 @@
 		return -1;
 	}
 	policydb = &mypolicydb;
-	return 0;
+	return sepol_sidtab_init(sidtab);
 }
 
 
@@ -278,8 +278,9 @@
 static int context_struct_compute_av(context_struct_t *scontext,
 				     context_struct_t *tcontext,
 				     security_class_t tclass,
-				     access_vector_t requested __attribute__ ((unused)),
-				     struct av_decision *avd)
+				     access_vector_t requested,
+				     struct av_decision *avd,
+				     unsigned int *reason)
 {
 	constraint_node_t *constraint;
 	struct role_allow *ra;
@@ -302,6 +303,7 @@
 	avd->auditallow = 0;
 	avd->auditdeny = 0xffffffff;
 	avd->seqno = latest_granting;
+	*reason = 0;
 
 	/*
 	 * If a specific type enforcement rule was defined for
@@ -319,10 +321,15 @@
 		if (avdatum->specified & AVTAB_AUDITALLOW)
 			avd->auditallow = avtab_auditallow(avdatum);
 	}
-	
+
 	/* Check conditional av table for additional permissions */
 	cond_compute_av(&policydb->te_cond_avtab, &avkey, avd);
 
+	if (requested & ~avd->allowed) {
+		*reason |= SEPOL_COMPUTEAV_TE;
+		requested &= avd->allowed;
+	}
+	
 	/* 
 	 * Remove any permissions prohibited by a constraint (this includes
 	 * the MLS policy).
@@ -337,6 +344,11 @@
 		constraint = constraint->next;
 	}
 
+	if (requested & ~avd->allowed) {
+		*reason |= SEPOL_COMPUTEAV_CONS;
+		requested &= avd->allowed;
+	}
+
 	/* 
 	 * If checking process transition permission and the
 	 * role is changing, then check the (current_role, new_role) 
@@ -353,7 +365,12 @@
 		if (!ra)
 			avd->allowed = (avd->allowed) & ~(PROCESS__TRANSITION |
 			                                PROCESS__DYNTRANSITION);
-	}	
+	}
+
+	if (requested & ~avd->allowed) {
+		*reason |= SEPOL_COMPUTEAV_RBAC;
+		requested &= avd->allowed;
+	}
 
 	return 0;
 }
@@ -407,11 +424,12 @@
 	return 0;
 }
 
-int sepol_compute_av(security_id_t ssid,
-			security_id_t tsid,
-			security_class_t tclass,
-			access_vector_t requested,
-			struct av_decision *avd)
+int sepol_compute_av_reason(security_id_t ssid,
+			    security_id_t tsid,
+			    security_class_t tclass,
+			    access_vector_t requested,
+			    struct av_decision *avd,
+			    unsigned int *reason)
 {
 	context_struct_t *scontext = 0, *tcontext = 0;
 	int rc = 0;
@@ -430,11 +448,20 @@
 	}
 
 	rc = context_struct_compute_av(scontext, tcontext, tclass, 
-				       requested, avd);
+				       requested, avd, reason);
 out:
 	return rc;
 }
 
+int sepol_compute_av(security_id_t ssid,
+		     security_id_t tsid,
+		     security_class_t tclass,
+		     access_vector_t requested,
+		     struct av_decision *avd)
+{
+	unsigned int reason = 0;
+	return sepol_compute_av_reason(ssid, tsid, tclass, requested, avd, &reason);
+}
 
 /*
  * Write the security context string representation of 
@@ -1302,7 +1329,7 @@
 	role_datum_t *role;
 	struct av_decision avd;
 	int rc = 0;
-	unsigned int i, j;
+	unsigned int i, j, reason;
 
 	fromcon = sepol_sidtab_search(sidtab, fromsid);
 	if (!fromcon) {
@@ -1343,7 +1370,7 @@
 			rc = context_struct_compute_av(fromcon, &usercon, 
 						       SECCLASS_PROCESS,
 						       PROCESS__TRANSITION, 
-						       &avd);
+						       &avd, &reason);
 			if (rc ||  !(avd.allowed & PROCESS__TRANSITION)) 
 				continue;
 			rc = sepol_sidtab_context_to_sid(sidtab, &usercon, &sid);

--=-6qrRsFS8JvwOfNQOP0vy
Content-Disposition: attachment; filename=policycoreutils-audit2why.patch
Content-Type: text/x-patch; name=policycoreutils-audit2why.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: selinux-usr/policycoreutils/ChangeLog
diff -u selinux-usr/policycoreutils/ChangeLog:1.112 selinux-usr/policycoreutils/ChangeLog:1.113
--- selinux-usr/policycoreutils/ChangeLog:1.112	Fri Apr 29 11:26:54 2005
+++ selinux-usr/policycoreutils/ChangeLog	Fri May 13 10:42:19 2005
@@ -1,3 +1,6 @@
+1.23.8 2005-05-13
+	* Added audit2why utility.
+
 1.23.7 2005-04-29
 	* Merged patch for fixfiles from Dan Walsh.
 	  Allow passing -F to force reset of customizable contexts.
Index: selinux-usr/policycoreutils/Makefile
diff -u selinux-usr/policycoreutils/Makefile:1.6 selinux-usr/policycoreutils/Makefile:1.7
--- selinux-usr/policycoreutils/Makefile:1.6	Wed Mar 31 16:07:41 2004
+++ selinux-usr/policycoreutils/Makefile	Fri May 13 10:42:19 2005
@@ -1,4 +1,4 @@
-SUBDIRS=setfiles load_policy newrole run_init restorecon audit2allow scripts po  sestatus
+SUBDIRS=setfiles load_policy newrole run_init restorecon audit2allow audit2why scripts po  sestatus
 
 all install relabel clean: 
 	@for subdir in $(SUBDIRS); do \
Index: selinux-usr/policycoreutils/VERSION
diff -u selinux-usr/policycoreutils/VERSION:1.51 selinux-usr/policycoreutils/VERSION:1.52
--- selinux-usr/policycoreutils/VERSION:1.51	Fri Apr 29 11:26:54 2005
+++ selinux-usr/policycoreutils/VERSION	Fri May 13 10:42:19 2005
@@ -1 +1 @@
-1.23.7
+1.23.8
Index: selinux-usr/policycoreutils/policycoreutils.spec
diff -u selinux-usr/policycoreutils/policycoreutils.spec:1.74 selinux-usr/policycoreutils/policycoreutils.spec:1.75
--- selinux-usr/policycoreutils/policycoreutils.spec:1.74	Fri Apr 29 11:26:54 2005
+++ selinux-usr/policycoreutils/policycoreutils.spec	Fri May 13 10:42:19 2005
@@ -1,6 +1,6 @@
 Summary: SELinux policy core utilities.
 Name: policycoreutils
-Version: 1.23.7
+Version: 1.23.8
 Release: 1
 License: GPL
 Group: System Environment/Base
@@ -68,6 +68,7 @@
 %{_sbindir}/load_policy
 %{_bindir}/newrole
 %{_bindir}/audit2allow
+%{_sbindir}/audit2why
 %{_mandir}/man1/newrole.1.gz
 %{_mandir}/man1/audit2allow.1.gz
 %config %{_sysconfdir}/pam.d/newrole
Index: selinux-usr/policycoreutils/audit2why/Makefile
diff -u /dev/null selinux-usr/policycoreutils/audit2why/Makefile:1.1
--- /dev/null	Fri May 13 10:52:35 2005
+++ selinux-usr/policycoreutils/audit2why/Makefile	Fri May 13 10:42:21 2005
@@ -0,0 +1,24 @@
+# Installation directories.
+PREFIX ?= ${DESTDIR}/usr
+BINDIR ?= $(PREFIX)/sbin
+LIBDIR ?= ${PREFIX}/lib
+MANDIR ?= $(PREFIX)/share/man
+LOCALEDIR ?= /usr/share/locale
+
+
+CFLAGS = -Werror
+override CFLAGS += -Wall -W
+LDLIBS += ${LIBDIR}/libsepol.a -lselinux
+
+TARGETS=audit2why
+
+all: $(TARGETS)
+
+install: all
+	-mkdir -p $(BINDIR)
+	install -m 755 $(TARGETS) $(SBINDIR)
+
+clean:
+	rm -f $(TARGETS) *.o
+
+relabel:
Index: selinux-usr/policycoreutils/audit2why/audit2why.c
diff -u /dev/null selinux-usr/policycoreutils/audit2why/audit2why.c:1.1
--- /dev/null	Fri May 13 10:52:35 2005
+++ selinux-usr/policycoreutils/audit2why/audit2why.c	Fri May 13 10:42:21 2005
@@ -0,0 +1,239 @@
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <ctype.h>
+#include <errno.h>
+#include <getopt.h>
+#include <limits.h>
+#include <sepol/sepol.h>
+#include <sepol/services.h>
+
+#define AVCPREFIX "avc:  denied  { "
+#define SCONTEXT "scontext="
+#define TCONTEXT "tcontext="
+#define TCLASS "tclass="
+
+/* Copied from selinux/selinux.h.
+   Should be replaced with #include <selinux/selinux.h>,
+   but first requires elimination of namespace collisions
+   between libselinux and libsepol. */
+extern const char *selinux_binary_policy_path(void);
+extern security_class_t string_to_security_class(const char *name);
+extern access_vector_t string_to_av_perm(security_class_t tclass, const char *name);
+extern int security_policyvers(void);
+extern int is_selinux_enabled(void);
+
+void usage(char *progname, int rc) 
+{
+ 	fprintf(stderr, "usage:  %s [-p policy] < /var/log/audit/audit.log\n", progname);
+	exit(rc);
+}
+
+int main(int argc, char **argv) 
+{
+	char path[PATH_MAX];
+	char *buffer = NULL, *bufcopy = NULL;
+	unsigned int lineno = 0;
+	size_t len = 0, bufcopy_len = 0;
+	FILE *fp;
+	int opt, rc, set_path = 0;
+	char *p, *scon, *tcon, *tclassstr, *permstr;
+	security_id_t ssid, tsid;
+	security_class_t tclass;
+	access_vector_t perm, av;
+	struct av_decision avd;
+	unsigned int reason;
+	int vers = 0;
+
+	while ((opt = getopt(argc, argv, "p:?h")) > 0) {
+		switch (opt) {
+		case 'p':
+			set_path = 1;
+			strncpy(path, optarg, PATH_MAX);
+			fp = fopen(path, "r");
+			if (!fp) {
+				fprintf(stderr, "%s:  unable to open %s:  %s\n",
+					argv[0], path, strerror(errno));
+				exit(1);
+			}
+			break;
+		default:
+			usage(argv[0], 0);
+		}
+	}
+
+	if (argc - optind)
+		usage(argv[0], 1);
+
+	if (!set_path) {
+		if (!is_selinux_enabled()) {
+			fprintf(stderr, "%s:  Must specify -p policy on non-SELinux systems\n", argv[0]);
+			exit(1);
+		}
+		vers = security_policyvers();
+		snprintf(path, PATH_MAX, "%s.%d", 
+			 selinux_binary_policy_path(), vers);
+		fp = fopen(path, "r");
+		while (!fp && errno == ENOENT && --vers) {
+			snprintf(path, PATH_MAX, "%s.%d", 
+				 selinux_binary_policy_path(), vers);
+			fp = fopen(path, "r");
+		}
+		if (!fp) {
+			snprintf(path, PATH_MAX, "%s.%d", 
+				 selinux_binary_policy_path(), security_policyvers());
+			fprintf(stderr, "%s:  unable to open %s:  %s\n",
+				argv[0], path, strerror(errno));
+			exit(1);
+		}
+	}
+
+	rc = sepol_set_policydb_from_file(fp);
+	if (rc < 0) {
+		fprintf(stderr, "%s:  unable to load policy from %s:  %s\n",
+			argv[0], path, strerror(errno));
+		exit(1);
+	}
+	fclose(fp);
+	
+	while (getline(&buffer, &len, stdin) > 0) {
+		size_t len2 = strlen(buffer);
+
+		if (buffer[len2-1] == '\n') 
+			buffer[len2-1] = 0;
+		lineno++;
+
+		p = buffer;
+		while (*p && strncmp(p, AVCPREFIX, sizeof(AVCPREFIX) - 1))
+			p++;
+		if (!(*p))
+			continue; /* not an avc denial */
+
+		p += sizeof(AVCPREFIX) - 1;
+
+		/* Save a copy of the original unmodified buffer. */
+		if (!bufcopy) {
+			/* Initial allocation */
+			bufcopy_len = len;
+			bufcopy = malloc(len);
+		} else if (bufcopy_len < len) {
+			/* Grow */
+			bufcopy_len = len;
+			bufcopy = realloc(bufcopy, len);
+		}
+		if (!bufcopy) {
+			fprintf(stderr, "%s:  OOM on buffer copy\n", argv[0]);
+			exit(2);
+		}
+		memcpy(bufcopy, buffer, len);
+
+		/* Remember where the permission list begins,
+		   and terminate the list. */
+		permstr = p;
+		while (*p && *p != '}') 
+			p++;
+		if (!(*p)) {
+			fprintf(stderr, "Missing closing bracket on line %u, skipping...\n", lineno);
+			continue;
+		}
+		*p++ = 0;
+
+		/* Get scontext and convert to SID. */
+		while (*p && strncmp(p, SCONTEXT, sizeof(SCONTEXT)-1))
+			p++;
+		if (!(*p)) {
+			fprintf(stderr, "Missing %s on line %u, skipping...\n", SCONTEXT, lineno);
+			continue;
+		}
+		p += sizeof(SCONTEXT) - 1;
+		scon = p;
+		while (*p && !isspace(*p))
+			p++;
+		if (*p)
+			*p++ = 0;
+		rc = sepol_context_to_sid(scon, strlen(scon)+1, &ssid);
+		if (rc < 0) {
+			fprintf(stderr, "Invalid %s%s on line %u, skipping...\n", SCONTEXT, scon, lineno);
+			continue;
+		}
+
+		/* Get tcontext and convert to SID. */
+		while (*p && strncmp(p, TCONTEXT, sizeof(TCONTEXT)-1))
+			p++;
+		if (!(*p)) {
+			fprintf(stderr, "Missing %s on line %u, skipping...\n", TCONTEXT, lineno);
+			continue;
+		}
+		p += sizeof(TCONTEXT) - 1;
+		tcon = p;
+		while (*p && !isspace(*p))
+			p++;
+		if (*p)
+			*p++ = 0;
+		rc = sepol_context_to_sid(tcon, strlen(tcon)+1, &tsid);
+		if (rc < 0) {
+			fprintf(stderr, "Invalid %s%s on line %u, skipping...\n", TCONTEXT, tcon, lineno);
+			continue;
+		}
+
+		/* Get tclass= and convert to value. */
+		while (*p && strncmp(p, TCLASS, sizeof(TCLASS) - 1))
+			p++;
+		if (!(*p)) {
+			fprintf(stderr, "Missing %s on line %u, skipping...\n", TCLASS, lineno);
+			continue;
+		}
+		p += sizeof(TCLASS) - 1;
+		tclassstr = p;
+		while (*p && !isspace(*p))
+			p++;
+		if (*p)
+			*p = 0;
+		tclass = string_to_security_class(tclassstr);
+		if (!tclass) {
+			fprintf(stderr, "Invalid %s%s on line %u, skipping...\n", TCLASS, tclassstr, lineno);
+			continue;
+		}
+
+		/* Convert the permission list to an AV. */
+		p = permstr;
+		av = 0;
+		while (*p) {
+			while (*p && !isspace(*p))
+				p++;
+			if (*p)
+				*p++ = 0;
+			perm = string_to_av_perm(tclass, permstr);
+			if (!perm) {
+				fprintf(stderr, "Invalid permission %s on line %u, skipping...\n", permstr, lineno);
+				continue;
+			}
+			av |= perm;
+			permstr = p;
+		}
+
+		/* Reproduce the computation. */
+		rc = sepol_compute_av_reason(ssid, tsid, tclass, av, &avd,
+					     &reason);
+		if (rc < 0) {
+			fprintf(stderr, "Error during access vector computation on line %u, skipping...\n", lineno);
+			continue;
+		}
+
+		if (!reason)
+			continue; /* Denial would not occur under specified policy. */
+
+		printf("%s\n\tWas caused by:\n", bufcopy);
+		if (reason & SEPOL_COMPUTEAV_TE)
+			printf("\t\tMissing TE allow rule for the type pair (use audit2allow).\n");
+		if (reason & SEPOL_COMPUTEAV_CONS)
+			printf("\t\tConstraint violation (add type attribute to domain to satisfy constraints or alter constraint).\n");
+		if (reason & SEPOL_COMPUTEAV_RBAC)
+			printf("\t\tMissing role allow rule for the role pair (add role allow rule).\n");
+		printf("\n");
+	}
+	free(buffer);
+	free(bufcopy);
+	exit(0);
+}
Index: selinux-usr/policycoreutils/load_policy/Makefile
diff -u selinux-usr/policycoreutils/load_policy/Makefile:1.13 selinux-usr/policycoreutils/load_policy/Makefile:1.14
--- selinux-usr/policycoreutils/load_policy/Makefile:1.13	Tue Feb 22 11:07:51 2005
+++ selinux-usr/policycoreutils/load_policy/Makefile	Fri May 13 10:42:23 2005
@@ -2,6 +2,7 @@
 PREFIX ?= ${DESTDIR}/usr
 SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
+LIBDIR ?= ${PREFIX}/lib
 LOCALEDIR ?= /usr/share/locale
 
 CFLAGS = -Werror

--=-6qrRsFS8JvwOfNQOP0vy--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
