Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7FFv6dp030069
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:57:06 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7FFupFK020519
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 15:56:52 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k7FFv3iN029401
	for <selinux@tycho.nsa.gov>; Tue, 15 Aug 2006 11:57:03 -0400 (EDT)
Date: Tue, 15 Aug 2006 10:56:49 -0500
From: Cory Olmo <colmo@TrustedCS.com>
To: selinux@tycho.nsa.gov
Subject: [RFC Patch 3/3] Context Mounts and Unsupported Contexts: nfs-utils
Message-Id: <20060815105649.54e05309.colmo@TrustedCS.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__15_Aug_2006_10_56_49_-0500_41e6qVDROTTggI71"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Tue__15_Aug_2006_10_56_49_-0500_41e6qVDROTTggI71
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This patch performs the same type of modifications to option parsing as done 
to util-linux.

 nfs-utils/utils/mount/mount.c    |   22 ++++++++++++++++++++--
 nfs-utils/utils/mount/nfsmount.c |   39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 54 insertions(+), 7 deletions(-)

--Multipart=_Tue__15_Aug_2006_10_56_49_-0500_41e6qVDROTTggI71
Content-Type: text/x-patch;
 name="nfs-utils-1.0.9-quoted_context.patch"
Content-Disposition: attachment;
 filename="nfs-utils-1.0.9-quoted_context.patch"
Content-Transfer-Encoding: 7bit

diff --git a/utils/mount/mount.c b/utils/mount/mount.c
index a10b398..86899a7 100644
--- a/utils/mount/mount.c
+++ b/utils/mount/mount.c
@@ -275,12 +275,30 @@ static void parse_opts (const char *opti
 		char *opts = xstrdup(options);
 		char *opt;
 		int len = strlen(opts) + 20;
+		int open_quote = 0;
+		char *opt_start = NULL;
+		char *opt_end = NULL;
 
 		*extra_opts = xmalloc(len);
 		**extra_opts = '\0';
 
-		for (opt = strtok(opts, ","); opt; opt = strtok(NULL, ","))
-			parse_opt(opt, flags, *extra_opts, len);
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
+				parse_opt(opt, flags, *extra_opts, len);
+				opt_start = opt_end + 1;
+				free(opt);
+				opt = NULL;
+			}
+		} while (*opt_end++);
 
 		free(opts);
 	}
diff --git a/utils/mount/nfsmount.c b/utils/mount/nfsmount.c
index fb40bc8..0b44492 100644
--- a/utils/mount/nfsmount.c
+++ b/utils/mount/nfsmount.c
@@ -550,12 +550,28 @@ parse_options(char *old_opts, struct nfs
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
@@ -670,14 +686,24 @@ #endif
 						   strcspn(opteq+1," \t\n\r,"));
 			 else if (!strcmp(opt, "context")) {
  				char *context = opteq + 1;
- 				
+
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
- 			} else
+				/* The context string is in the format of
+				 * "system_u:object_r:...".  We only want
+				 * the context str between the quotes.
+				 */
+ 				strncpy(data->context, context+1, 
+						strlen(context)-2);
+ 			} else 
 				goto bad_parameter;
 			sprintf(cbuf, "%s=%s,", opt, opteq+1);
 		} else {
@@ -780,7 +806,10 @@ #endif
 			goto out_bad;
 		}
 		strcat(new_opts, cbuf);
-	}
+		free(opt);
+		opt = NULL;
+	} while (*opt_end++);
+
 	/* See if the nfs host = mount host. */
 	if (mounthost) {
 		if (!nfs_gethostbyname(mounthost, mnt_saddr))

--Multipart=_Tue__15_Aug_2006_10_56_49_-0500_41e6qVDROTTggI71--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
