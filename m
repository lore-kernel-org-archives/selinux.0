Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1HFC6Rb015590
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 10:12:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1HFC5c3020847
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 15:12:06 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1HFC5R0020844 for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2004 15:12:05 GMT
Subject: Re: setfiles sorting
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov, Russell Coker <russell@coker.com.au>
In-Reply-To: <1077024390.16139.29.camel@moss-spartans.epoch.ncsc.mil>
References: <1076745885.13876.12.camel@nexus.verbum.private>
	 <1077024390.16139.29.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1077030711.16139.53.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 17 Feb 2004 10:11:51 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-02-17 at 08:26, Stephen Smalley wrote:
> In any event, the fact that qsort does not guarantee stable ordering for
> entries that compare to equal does make it unsuitable for this purpose,
> but we still need to address the underlying problem, e.g. we could
> simply move the entries to the end directly without relying on qsort.

Patch below.

Index: policycoreutils/setfiles/setfiles.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/setfiles/setfiles.c,v
retrieving revision 1.12
diff -u -r1.12 setfiles.c
--- policycoreutils/setfiles/setfiles.c	17 Feb 2004 14:02:48 -0000	1.12
+++ policycoreutils/setfiles/setfiles.c	17 Feb 2004 15:07:52 -0000
@@ -437,15 +437,6 @@
 	return i;
 }
 
-/* Used with qsort to sort specs from lowest to highest hasMetaChars value */
-int spec_compare(const void* specA, const void* specB)
-{
-	return(
-		((const struct spec *)specB)->hasMetaChars -
-		((const struct spec *)specA)->hasMetaChars
-		); 
-}
-
 /*
  * Check for duplicate specifications. If a duplicate specification is found 
  * and the context is the same, give a warning to the user. If a duplicate 
@@ -685,7 +676,8 @@
 	char line_buf[255 + 1], *buf_p;
 	char *regex, *type, *context;
 	char *anchored_regex;
-	int opt, items, len, lineno, pass, regerr, i;
+	int opt, items, len, lineno, pass, regerr, i, j;
+	spec_t *spec_copy;
 
 	/* Process any options. */
 	while ((opt = getopt(argc, argv, "dnqrsvW")) > 0) {
@@ -916,8 +908,25 @@
 	}
 	fclose(fp);
 
-	/* Sort the specifications with most general first */
-	qsort(spec_arr, nspec, sizeof(struct spec), spec_compare);
+	/* Move exact pathname specifications to the end. */
+	spec_copy = malloc(sizeof(spec_t) * nspec);
+	if (!spec_copy) {
+		fprintf(stderr,
+			"%s:  insufficient memory for specifications\n",
+			argv[0]);
+		exit(1);
+	}
+	j = 0;
+	for (i = 0; i < nspec; i++) {
+		if (spec_arr[i].hasMetaChars)
+			memcpy(&spec_copy[j++], &spec_arr[i], sizeof(spec_t));
+	}
+	for (i = 0; i < nspec; i++) {
+		if (!spec_arr[i].hasMetaChars)
+			memcpy(&spec_copy[j++], &spec_arr[i], sizeof(spec_t));
+	}
+	free(spec_arr);
+	spec_arr = spec_copy;
 
 	/* Verify no exact duplicates */
 	if (nodups_specs() != 0) {


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
