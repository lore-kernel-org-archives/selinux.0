Date: Thu, 28 Sep 2006 08:21:05 -0500
From: Cory Olmo <colmo@TrustedCS.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com, jmorris@namei.org,
        chanson@TrustedCS.com, dgoeddel@TrustedCS.com, kzak@redhat.com
Subject: [Patch 2/3] mount: quote context option to avoid comma collision
Message-Id: <20060928082105.4b7d71f7.colmo@TrustedCS.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To avoid the collision between commas in security contexts and the 
delimiter betweeen mount options this patch introduces support for 
quoting the context option.

It modifies the option parsing in parse_opts(), contained in mount.c,
to take options after finding a comma only if it hasn't seen a quote 
or if the quotes are matched.  It also introduces a new function that 
will strip the quotes from the context option prior to translation.  
The quotes are replaced after the translation is completed to insure 
that in the event the raw context contains commas the kernel will be
able to interpret the correct context.

Signed-off-by: Cory Olmo <colmo@TrustedCS.com>
---

 mount.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 9 deletions(-)


diff --git a/mount/mount.c b/mount/mount.c
index d2c6404..795b2c2 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -266,6 +266,32 @@ my_free(const void *s) {
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
@@ -275,6 +301,7 @@ static int
 append_context(const char *optname, const char *optdata, char *extra_opts, int *len)
 {
 	security_context_t raw = NULL;
+	char *stripped_data = NULL;
 	char *buf = NULL;
 	int bufsz;
 	
@@ -285,19 +312,32 @@ append_context(const char *optname, cons
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
@@ -397,13 +437,29 @@ parse_opts (const char *options, int *fl
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
+			if (*opt_end == '"') {
+				open_quote = !open_quote;
+			}
+			if ((*opt_end == ',' && open_quote == 0) ||
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

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
