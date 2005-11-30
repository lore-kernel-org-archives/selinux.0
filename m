Subject: matchpathcon_init overhead
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: SELinux-dev@tresys.com, Tom London <selinux@gmail.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
   Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/mixed; boundary="=-ntswzN07YH9NzOInRnPv"
Date: Wed, 30 Nov 2005 16:18:16 -0500
Message-Id: <1133385496.26593.405.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ntswzN07YH9NzOInRnPv
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

As has been pointed out recently on fedora-selinux-list and
fedora-devel-list, it seems that udev and install are much slower now
than they were previously, and the culprit seems to be the fact that
matchpathcon/matchpathcon_init process the entire file_contexts
configuration rather than just relevant entries, and these particular
programs are bearing that cost for every file (unlike
setfiles/restorecon, where we process it once and then apply the result
to potentially many files).  The cost has increased recently due to the
context canonicalization, although there was some cost there already for
context validation.  We may be able to optimize that somewhat, but it
seems like the real problem is selecting a subset of file_contexts to
process.

The patch below introduces a matchpathcon_init_prefix() function that
allows a caller to optionally specify one or both of the path to the
file contexts configuration (already an argument to matchpathcon_init,
can be left NULL to use the default as before) and a prefix to use in
selecting which entries to load from that configuration.  Given a
non-NULL prefix, it will then only load entries whose regex either has
no identifiable stem or that have a stem that is a prefix of the
"prefix".  Thus, udev can call it with a prefix of "/dev" to exclude
most non-/dev entries, and install can just call it with the destination
path.   Since it includes prefixes of the prefix, we still get fallback
matching on entries like /.* to provide higher level defaults.  We end
up with some entries that aren't actually needed still due to certain
regexes that have no identifiable stem, e.g. /opt(/.*)?, since the stem
logic looks for a terminal / prior to regex characters, but it still
trims the number of entries considerably.

udev and install would then need to be modified to call
matchpathcon_init_prefix() once at startup prior to calling
matchpathcon() as usual.  

Does this seem reasonable?
  
-- 
Stephen Smalley
National Security Agency

--=-ntswzN07YH9NzOInRnPv
Content-Disposition: attachment; filename=matchpathcon.diff
Content-Type: text/x-patch; name=matchpathcon.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/include/selinux/selinux.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/include/selinux/selinux.h,v
retrieving revision 1.51
diff -u -p -r1.51 selinux.h
--- libselinux/include/selinux/selinux.h	8 Nov 2005 19:26:33 -0000	1.51
+++ libselinux/include/selinux/selinux.h	30 Nov 2005 20:28:14 -0000
@@ -305,6 +305,10 @@ extern void set_matchpathcon_flags(unsig
    from them if present. */
 extern int matchpathcon_init(const char *path);
 
+/* Same as matchpathcon_init, but only load entries with
+   regexes that have stems that are prefixes of 'prefix'. */
+extern int matchpathcon_init_prefix(const char *path, const char *prefix);
+
 /* Match the specified pathname and mode against the file contexts
    configuration and set *con to refer to the resulting context.
    'mode' can be 0 to disable mode matching.
Index: libselinux/src/matchpathcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/matchpathcon.c,v
retrieving revision 1.34
diff -u -p -r1.34 matchpathcon.c
--- libselinux/src/matchpathcon.c	29 Nov 2005 16:51:08 -0000	1.34
+++ libselinux/src/matchpathcon.c	30 Nov 2005 20:25:58 -0000
@@ -463,10 +463,11 @@ static void spec_hasMetaChars(struct spe
 	}
 	return;
 }
-static int process_line( const char *path, char *line_buf, int pass, unsigned lineno, int mls_enabled) {
+static int process_line( const char *path, const char *prefix, char *line_buf, int pass, unsigned lineno, int mls_enabled) {
 	int items, len, regerr;
 	char *buf_p;
 	char *regex, *type, *context;
+	const char *reg_buf;
 	char *anchored_regex;
 	len = strlen(line_buf);
 	if (line_buf[len - 1] == '\n')
@@ -489,10 +490,19 @@ static int process_line( const char *pat
 		context = type;
 		type = 0;
 	}
-	
+
+	reg_buf = regex;
+	len = get_stem_from_spec(reg_buf);
+	if (len && prefix && strncmp(prefix, regex, len)) {
+		/* Stem of regex does not match requested prefix, discard. */
+		free(regex);
+		free(type);
+		free(context);
+		return 0;
+	}
+
 	if (pass == 1) {
 		/* On the second pass, compile and store the specification in spec. */
-		const char *reg_buf = regex;
 		char *cp;
 		spec_arr[nspec].stem_id = find_stem_from_spec(&reg_buf);
 		spec_arr[nspec].regex_str = regex;
@@ -617,7 +627,7 @@ skip_trans:
 	return 0;
 }
 
-int matchpathcon_init(const char *path)
+int matchpathcon_init_prefix(const char *path, const char *prefix)
 {
 	FILE *fp;
 	FILE *localfp = NULL;
@@ -663,20 +673,20 @@ int matchpathcon_init(const char *path)
 		lineno = 0;
 		nspec = 0;
 		while (getline(&line_buf, &line_len, fp) > 0 && nspec < maxnspec) {
-			if (process_line(path, line_buf, pass, ++lineno, mls_enabled) != 0)
+			if (process_line(path, prefix, line_buf, pass, ++lineno, mls_enabled) != 0)
 				goto finish;
 		}
 		lineno = 0;
 		if (homedirfp) 
 			while (getline(&line_buf, &line_len, homedirfp) > 0 && nspec < maxnspec) {
-				if (process_line(homedir_path, line_buf, pass, ++lineno, mls_enabled) != 0)
+				if (process_line(homedir_path, prefix, line_buf, pass, ++lineno, mls_enabled) != 0)
 					goto finish;
 			}
 
 		lineno = 0;
 		if (localfp) 
 			while (getline(&line_buf, &line_len, localfp) > 0 && nspec < maxnspec) {
-				if (process_line(local_path, line_buf, pass, ++lineno, mls_enabled) != 0)
+				if (process_line(local_path, prefix, line_buf, pass, ++lineno, mls_enabled) != 0)
 					goto finish;
 			}
 
@@ -723,7 +733,12 @@ int matchpathcon_init(const char *path)
 	if (localfp) fclose(localfp);
 	return status;
 }
-hidden_def(matchpathcon_init)
+hidden_def(matchpathcon_init_prefix)
+
+int matchpathcon_init(const char *path)
+{
+	return matchpathcon_init_prefix(path, NULL);
+}
 
 static int matchpathcon_common(const char *name, 
 			       mode_t mode)
@@ -732,7 +747,7 @@ static int matchpathcon_common(const cha
 	const char *buf = name;
 
 	if (!nspec) {
-		ret = matchpathcon_init(NULL);
+		ret = matchpathcon_init_prefix(NULL, NULL);
 		if (ret < 0)
 			return ret;
 		if (!nspec) {
Index: libselinux/src/selinux_internal.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_internal.h,v
retrieving revision 1.16
diff -u -p -r1.16 selinux_internal.h
--- libselinux/src/selinux_internal.h	7 Nov 2005 19:30:37 -0000	1.16
+++ libselinux/src/selinux_internal.h	30 Nov 2005 20:27:05 -0000
@@ -59,7 +59,7 @@ hidden_proto(selinux_customizable_types_
 hidden_proto(selinux_media_context_path)
 hidden_proto(selinux_path)
 hidden_proto(selinux_check_passwd_access)
-hidden_proto(matchpathcon_init)
+hidden_proto(matchpathcon_init_prefix)
 hidden_proto(selinux_users_path)
 hidden_proto(selinux_usersconf_path);
 hidden_proto(selinux_translations_path);
Index: libselinux/utils/matchpathcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/utils/matchpathcon.c,v
retrieving revision 1.5
diff -u -p -r1.5 matchpathcon.c
--- libselinux/utils/matchpathcon.c	29 Nov 2005 16:50:15 -0000	1.5
+++ libselinux/utils/matchpathcon.c	30 Nov 2005 20:31:40 -0000
@@ -8,30 +8,47 @@
 
 void usage(const char *progname) 
 {
-	fprintf(stderr, "usage:  %s [-n] [-f file_contexts] path...\n", progname);
+	fprintf(stderr, "usage:  %s [-n] [-f file_contexts] [-p prefix] path...\n", progname);
 	exit(1);
 }
 
 int main(int argc, char **argv) 
 {
 	char *buf;
-	int rc, i;
+	int rc, i, init = 0;
 	int header=1, opt;
 
 	if (argc < 2) usage(argv[0]);
 
-	while ((opt = getopt(argc, argv, "nf:")) > 0) {
+	while ((opt = getopt(argc, argv, "nf:p:")) > 0) {
 		switch (opt) {
 		case 'n':
 			header=0;
 			break;
 		case 'f':
+			if (init) {
+				fprintf(stderr, "%s:  -f and -p are exclusive\n", argv[0]);
+				exit(1);
+			}
+			init = 1;
 			if (matchpathcon_init(optarg)) {
 				fprintf(stderr, "Error while processing %s:  %s\n",
 					optarg, errno ? strerror(errno) : "invalid");
 				exit(1);
 			}
 			break;
+		case 'p':
+			if (init) {
+				fprintf(stderr, "%s:  -f and -p are exclusive\n", argv[0]);
+				exit(1);
+			}
+			init = 1;
+			if (matchpathcon_init_prefix(NULL, optarg)) {
+				fprintf(stderr, "Error while processing %s:  %s\n",
+					optarg, errno ? strerror(errno) : "invalid");
+				exit(1);
+			}
+			break;
 		default:
 			usage(argv[0]);
 		}

--=-ntswzN07YH9NzOInRnPv--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
