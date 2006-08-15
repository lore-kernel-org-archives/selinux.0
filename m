Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7FFup3Q030053
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:56:51 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7FFuaFK020508
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 15:56:38 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k7FFulEQ014616
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:56:47 -0400 (EDT)
Date: Tue, 15 Aug 2006 10:56:35 -0500
From: Cory Olmo <colmo@TrustedCS.com>
To: selinux@tycho.nsa.gov
Subject: [RFC Patch 2/3] Context Mounts and Unsupported Contexts: util-linux
Message-Id: <20060815105635.c441e80a.colmo@TrustedCS.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__15_Aug_2006_10_56_35_-0500__XtFHsBATVsav9FO"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Tue__15_Aug_2006_10_56_35_-0500__XtFHsBATVsav9FO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This patch modifies the option parsing in parse_opts(), contained in 
mount.c, and parse_options(), contained in nfsmount.c, to take options 
after finding a comma only if it hasn't seen a quote or if the quotes 
are matched.  It also will strip the quotes from the context option prior 
to translation and then replace them after the translation.  

There's an unrelated update in the patch for parse_opt() which includes 
the latest rootcontext option.

 util-linux/mount/mount.c    |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 util-linux/mount/nfsmount.c |   34 +++++++++++++++++++++++--
 2 files changed, 103 insertions(+), 12 deletions(-)

--Multipart=_Tue__15_Aug_2006_10_56_35_-0500__XtFHsBATVsav9FO
Content-Type: text/x-patch;
 name="util-linux-2.13-quoted_context.patch"
Content-Disposition: attachment;
 filename="util-linux-2.13-quoted_context.patch"
Content-Transfer-Encoding: 7bit

diff --git a/mount/mount.c b/mount/mount.c
index dbbb92e..49a6c38 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -265,6 +265,32 @@ my_free(const void *s) {
 }
 
 #ifdef HAVE_LIBSELINUX
+/* strip quotes from a context string
+ * returns Null on error and char * to new string
+ * caller responsible for freeing returned memory
+ */
+static char *
+strip_quotes(const char *opt_str)
+{
+	char *new_str = NULL;
+	char *str_end = NULL;
+
+	if (*opt_str != '\"') {
+		new_str = xstrdup(opt_str);
+		return new_str;
+	}
+
+	str_end = rindex(opt_str, '\"');
+	if (!str_end || str_end == opt_str) {
+		printf(_("mount: improperly quoted context string '%s'\n"), 
+			opt_str);
+		return NULL;
+	}
+
+	new_str = xstrndup(opt_str+1, str_end - (opt_str+1));
+	return new_str;
+}
+
 /* translates SELinux context from human to raw format and 
  * appends it to the mount extra options.
  *
@@ -274,6 +300,7 @@ static int
 append_context(const char *optname, const char *optdata, char *extra_opts, int *len)
 {
 	security_context_t raw = NULL;
+	char *stripped_data = NULL;
 	char *buf = NULL;
 	int bufsz;
 	
@@ -284,19 +311,32 @@ append_context(const char *optname, cons
 	if (optdata==NULL || *optdata=='\0' || optname==NULL)
 		return -1;
 	
-	if (selinux_trans_to_raw_context(
-			(security_context_t) optdata, &raw)==-1 ||
-			raw==NULL)
-		return -1;
+	if (*optdata =='\"') {
+		stripped_data = strip_quotes(optdata);
+		if (!stripped_data) 
+			return -1;
+		if (selinux_trans_to_raw_context(
+				(security_context_t) stripped_data, &raw)==-1 ||
+				raw==NULL) {
+			my_free(stripped_data);
+			return -1;
+		}
+		my_free(stripped_data);
+	} else {
+		if (selinux_trans_to_raw_context(
+				(security_context_t) optdata, &raw)==-1 ||
+				raw==NULL)
+			return -1;
+	}
 	
 	if (verbose)
 		printf(_("mount: translated %s '%s' to '%s'\n"), 
 				optname, optdata, (char *) raw);
 
-	bufsz = strlen(optname) + strlen(raw) + 2;	/* 2 is \0 and '=' */ 
+	bufsz = strlen(optname) + strlen(raw) + 2 + 2;	/* 2 is \0 and '=' */ 
 	buf = xmalloc(bufsz);
 
-	snprintf(buf, bufsz, "%s=%s", optname, (char *) raw);
+	snprintf(buf, bufsz, "%s=\"%s\"", optname, (char *) raw);
 	freecon(raw);
 	
 	if ((*len -= bufsz-1) > 0)
@@ -378,6 +418,10 @@ parse_opt(const char *opt, int *mask, ch
 		if (append_context("defcontext", opt+11, extra_opts, &len)==0)
 			return;
 	}
+	if (strncmp(opt, "rootcontext=", 12)==0 && *(opt+12)) {
+		if (append_context("rootcontext", opt+12, extra_opts, &len)==0)
+			return;
+	}
 #endif
 	if ((len -= strlen(opt)) > 0)
 		strcat(extra_opts, opt);
@@ -396,13 +440,32 @@ parse_opts (const char *options, int *fl
 		char *opts = xstrdup(options);
 		char *opt;
 		int len = strlen(opts) + 256;
+		int open_quote = 0;
+		char *opt_start = NULL;
+		char *opt_end = NULL;
 
 		*extra_opts = xmalloc(len); 
 		**extra_opts = '\0';
 
-		for (opt = strtok(opts, ","); opt; opt = strtok(NULL, ","))
-			if (!parse_string_opt(opt))
-				parse_opt(opt, flags, *extra_opts, len);
+		opt_start = opt_end = opts;
+		do {
+			if ((*opt_end == '"')) {
+				if (open_quote < 0)
+					open_quote += 1;
+				else
+					open_quote -= 1;
+			}
+			if (((*opt_end == ',') && (open_quote == 0)) ||
+					*opt_end == '\0') {
+				opt = xstrndup(opt_start, opt_end - opt_start);
+				if (!parse_string_opt(opt))
+					parse_opt(opt, flags, *extra_opts, len);
+				opt_start = opt_end + 1;
+				free(opt);
+				opt = NULL;
+			}
+		} while (*opt_end++);
+
 
 		free(opts);
 	}
diff --git a/mount/nfsmount.c b/mount/nfsmount.c
index 362ef33..783994e 100644
--- a/mount/nfsmount.c
+++ b/mount/nfsmount.c
@@ -756,12 +756,28 @@ parse_options(char *old_opts, struct nfs
 	char *opt, *opteq;
 	char *mounthost = NULL;
 	char cbuf[128];
+	char *opt_start, *opt_end;
+	int open_quote = 0;
 
 	data->flags = 0;
 	*bg = 0;
 
 	len = strlen(new_opts);
-	for (opt = strtok(old_opts, ","); opt; opt = strtok(NULL, ",")) {
+	opt_start = opt_end = old_opts;
+	do {
+		if ((*opt_end == '"')) {
+			if (open_quote < 0)
+				open_quote += 1;
+			else
+				open_quote -= 1;
+		}
+		if (!(((*opt_end == ',') && (open_quote == 0)) ||
+				*opt_end == '\0')) {
+			continue;
+		}
+		opt = xstrndup(opt_start, opt_end - opt_start);
+		opt_start = opt_end + 1;
+
 		if (strlen(opt) >= sizeof(cbuf))
 			goto bad_parameter;
 		if ((opteq = strchr(opt, '=')) && isdigit(opteq[1])) {
@@ -877,12 +893,22 @@ parse_options(char *old_opts, struct nfs
 			 else if (!strcmp(opt, "context")) {
  				char *context = opteq + 1;
  				
+				/* XXX: The size of cbuf would have to be
+				 * more than doubled or NFS_MAX_CONTEXT_LEN
+				 * reduced to <128 before this would ever be 
+				 * a factor.
+				 */
  				if (strlen(context) > NFS_MAX_CONTEXT_LEN) {
  					printf(_("context parameter exceeds limit of %d\n"),
  						 NFS_MAX_CONTEXT_LEN);
 					goto bad_parameter;
  				}
- 				strncpy(data->context, context, NFS_MAX_CONTEXT_LEN);
+				/* The context string is in the format of
+				 * "system_u:object_r:...". We only want 
+				 * the context str between the quotes.
+				 */
+ 				strncpy(data->context, context+1, 
+						strlen(context)-2);
  			} else if (!sloppy)
 				goto bad_parameter;
 			sprintf(cbuf, "%s=%s,", opt, opteq+1);
@@ -988,7 +1014,9 @@ parse_options(char *old_opts, struct nfs
 			goto out_bad;
 		}
 		strcat(new_opts, cbuf);
-	}
+		free(opt);
+		opt = NULL;
+	} while (*opt_end++);
 	/* See if the nfs host = mount host. */
 	if (mounthost) {
 		if (!nfs_gethostbyname(mounthost, mnt_saddr))

--Multipart=_Tue__15_Aug_2006_10_56_35_-0500__XtFHsBATVsav9FO--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
