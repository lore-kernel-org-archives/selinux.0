Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KJ1trT006387
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 15:01:55 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KJ1D4v028452
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 19:01:13 GMT
Subject: Re: conflict between libselinux and libsepol
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
	 <1092972342.29540.35.camel@nexus.verbum.private>
	 <1093002523.16585.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1093013527.9495.0.camel@nexus.verbum.private>
	 <1093015484.16585.199.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-zTIOM3vF6Drjq4edFCDM"
Message-Id: <1093028441.16585.265.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 20 Aug 2004 15:00:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-zTIOM3vF6Drjq4edFCDM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-08-20 at 11:24, Stephen Smalley wrote:
> Hence, I would recommend that we add a function to libsepol to provide a
> higher level interface for context validation against a given binary
> policy, add it to libsepol.map, and declare the prototype in sepol.h for
> use by setfiles.

Patch for libsepol attached, along with a sample program.  I'll add it
to the sourceforge CVS.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-zTIOM3vF6Drjq4edFCDM
Content-Disposition: attachment; filename=libsepol-chkcon.patch
Content-Type: text/x-patch; name=libsepol-chkcon.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libsepol/include/sepol/sepol.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/sepol.h,v
retrieving revision 1.3
diff -u -r1.3 sepol.h
--- libsepol/include/sepol/sepol.h	10 Aug 2004 14:45:39 -0000	1.3
+++ libsepol/include/sepol/sepol.h	20 Aug 2004 18:45:46 -0000
@@ -2,6 +2,7 @@
 #define _SEPOL_H_
 
 #include <sys/types.h>
+#include <stdio.h>
 
 /* Given an existing binary policy (starting at 'data', with length 'len')
    and a boolean configuration file named by 'boolpath', rewrite the binary
@@ -17,5 +18,11 @@
    Returns 0 upon success or -1 otherwise. */
 extern int sepol_genbools_array(void *data, size_t len, char **names, int *values, int nel);
 
+/* Set internal policydb from a file for subsequent service calls. */
+extern int sepol_set_policydb_from_file(FILE *fp);
+
+/* Check context validity against currently set binary policy. */
+extern int sepol_check_context(char *context);
+
 
 #endif
Index: libsepol/src/libsepol.map
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/libsepol.map,v
retrieving revision 1.1
diff -u -r1.1 libsepol.map
--- libsepol/src/libsepol.map	10 Aug 2004 18:54:38 -0000	1.1
+++ libsepol/src/libsepol.map	20 Aug 2004 18:46:54 -0000
@@ -1,4 +1,4 @@
 {
-  global: sepol_genbools*;
+  global: sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context;
   local: *;
 };
Index: libsepol/src/private.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/private.h,v
retrieving revision 1.2
diff -u -r1.2 private.h
--- libsepol/src/private.h	11 Aug 2004 16:06:24 -0000	1.2
+++ libsepol/src/private.h	20 Aug 2004 18:53:35 -0000
@@ -39,7 +39,7 @@
 	switch (fp->type) {
 	case PF_USE_STDIO:
 		nread = fread(buffer, bytes, 1, fp->fp);
-		if (nread != bytes)
+		if (nread != 1)
 			return NULL;
 		break;
 	case PF_USE_MEMORY:
Index: libsepol/src/services.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/services.c,v
retrieving revision 1.5
diff -u -r1.5 services.c
--- libsepol/src/services.c	11 Aug 2004 14:57:07 -0000	1.5
+++ libsepol/src/services.c	20 Aug 2004 18:52:35 -0000
@@ -56,6 +56,21 @@
 	return 0;
 }
 
+int sepol_set_policydb_from_file(FILE *fp) 
+{
+	struct policy_file pf;
+	pf.fp = fp;
+	pf.type = PF_USE_STDIO;
+	if (policydb_read(&mypolicydb, &pf, 0)) {
+		fprintf(stderr, "Can't read binary policy:  %s\n",
+			strerror(errno));
+		return -1;
+	}
+	policydb = &mypolicydb;
+	return 0;
+}
+
+
 /*
  * The largest sequence number that has been used when
  * providing an access decision to the access vector cache.
@@ -399,7 +414,8 @@
 	char *scontextp, *p, oldc;
 	int rc = 0;
 
-	*sid = SECSID_NULL;
+	if (sid)
+		*sid = SECSID_NULL;
 
 	/* Copy the string so that we can modify the copy as we parse it.
 	   The string should already by null terminated, but we append a
@@ -414,7 +430,6 @@
 	scontext2[scontext_len] = 0;
 
 	context_init(&context);
-	*sid = SECSID_NULL;
 
 	/* Parse the security context. */
 
@@ -484,13 +499,19 @@
 		goto out;
 	}
 	/* Obtain the new sid. */
-	rc = sepol_sidtab_context_to_sid(sidtab, &context, sid);
+	if (sid)
+		rc = sepol_sidtab_context_to_sid(sidtab, &context, sid);
 out:
 	context_destroy(&context);
 	free(scontext2);
 	return rc;
 }
 
+int sepol_check_context(char *context) 
+{
+	return sepol_context_to_sid(context, strlen(context)+1, NULL);
+}
+
 static inline int compute_sid_handle_invalid_context(
 	context_struct_t *scontext,
 	context_struct_t *tcontext,

--=-zTIOM3vF6Drjq4edFCDM
Content-Disposition: attachment; filename=chkcon.c
Content-Type: text/x-csrc; name=chkcon.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <sepol/sepol.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

void usage(char *progname)
{
	printf("usage:  %s policy context\n", progname);
	exit(1);
}

int main(int argc, char **argv)
{
	FILE *fp;

	if (argc != 3) 
		usage(argv[0]);

	fp = fopen(argv[1], "r");
	if (!fp) {
		fprintf(stderr, "Can't open '%s':  %s\n",
			argv[1], strerror(errno));
		exit(1);
	}
	if (sepol_set_policydb_from_file(fp) < 0) {
		fprintf(stderr, "Error while processing %s:  %s\n",
			argv[1], strerror(errno));
		exit(1);
	}
	fclose(fp);

	if (sepol_check_context(argv[2]) < 0) {
		fprintf(stderr, "%s is not valid\n",argv[2]);
		exit(1);		
	}

	printf("%s is valid\n", argv[2]);
	exit(0);
}

--=-zTIOM3vF6Drjq4edFCDM--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
