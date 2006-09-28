Date: Thu, 28 Sep 2006 08:21:49 -0500
From: Cory Olmo <colmo@TrustedCS.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, eparis@redhat.com, jmorris@namei.org,
        chanson@TrustedCS.com, dgoeddel@TrustedCS.com, kzak@redhat.com
Subject: [Patch 3/3] nfsmount: quote context mount option to avoid comma
 collision
Message-Id: <20060928082149.aaaa7973.colmo@TrustedCS.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

To avoid the collision between commas in security contexts and the 
delimiter betweeen mount options this patch introduces support for 
quoting the context option.

It modifies the option parsing in parse_opts(), contained in mount.c, 
and parse_options(), in nfsmount.c, to process an option after finding 
a comma only if it hasn't seen a quote or if the quotes are matched.

Signed-off-by: Cory Olmo <colmo@TrustedCS.com>
---

 mount.c    |   19 +++++++++++++++++--
 nfsmount.c |   33 ++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 5 deletions(-)


diff --git a/utils/mount/mount.c b/utils/mount/mount.c
index cb646d6..6c6de9b 100644
--- a/utils/mount/mount.c
+++ b/utils/mount/mount.c
@@ -277,12 +277,27 @@ static void parse_opts (const char *opti
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
+			if (*opt_end == '"') {
+				open_quote = !open_quote;
+			}
+			if ((*opt_end == ',' && open_quote == 0) ||
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
index cef13d3..3c55835 100644
--- a/utils/mount/nfsmount.c
+++ b/utils/mount/nfsmount.c
@@ -551,12 +551,27 @@ parse_options(char *old_opts, struct nfs
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
+		if (*opt_end == '"') {
+			open_quote = !open_quote;
+		}
+		if (!((*opt_end == ',' && open_quote == 0) ||
+				*opt_end == '\0')) {
+			continue;
+		}
+		opt = xstrndup(opt_start, opt_end - opt_start);
+		opt_start = opt_end + 1;
+		if (*opt == '\0')
+			continue;
+
 		if (strlen(opt) >= sizeof(cbuf))
 			goto bad_parameter;
 		if ((opteq = strchr(opt, '=')) && isdigit(opteq[1])) {
@@ -677,7 +692,16 @@ #endif
  						 NFS_MAX_CONTEXT_LEN);
 					goto bad_parameter;
  				}
- 				strncpy(data->context, context, NFS_MAX_CONTEXT_LEN);
+				/* The context string is in the format of
+				 * "system_u:object_r:...".  We only want
+				 * the context str between the quotes.
+				 */
+				if (*context == '"')
+					strncpy(data->context, context+1, 
+							strlen(context)-2);
+				else
+					strncpy(data->context, context, 
+							NFS_MAX_CONTEXT_LEN);
  			} else if (!sloppy)
 				goto bad_parameter;
 			sprintf(cbuf, "%s=%s,", opt, opteq+1);
@@ -783,7 +807,10 @@ #endif
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

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
