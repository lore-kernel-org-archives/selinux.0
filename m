Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n8AKNoog028674
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 16:23:50 -0400
Received: from e32.co.us.ibm.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n8AKNAB2025712
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 20:23:10 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8AKJFRl000349
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 14:19:15 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n8AKNUH5152514
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 14:23:31 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n8AKNUJg031956
	for <selinux@tycho.nsa.gov>; Thu, 10 Sep 2009 14:23:30 -0600
Date: Thu, 10 Sep 2009 15:23:31 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Oren Laadan <orenl@cs.columbia.edu>
Cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 1/1] mktree: accept the lsm_name field in header and add -k
	flag
Message-ID: <20090910202331.GE7072@us.ibm.com>
References: <20090910202219.GA6778@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090910202219.GA6778@us.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[ This patch is against the userspace checkpoint/restart code,
available at git://git.ncl.cs.columbia.edu/pub/git/user-cr.git ]

The checkpoint file header now has an 11-character string
containing the name of the active LSM, following the uts
info, and a variable length buffer type conaining LSM-specific
version information (for instance a sha1sum of policy).
Handle these.

Also add a -k (--keeplsm) flag to tell mktree to set the
RESTART_KEEP_LSM flag to sys_restart().

Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 mktree.c |   32 ++++++++++++++++++++++++++++++--
 1 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/mktree.c b/mktree.c
index 2d8d796..3785ebc 100644
--- a/mktree.c
+++ b/mktree.c
@@ -45,6 +45,7 @@ static char usage_str[] =
 "\t -P,--no-pidns         do not create a new pid namspace (default)\n"
 "\t    --pids             restore original pids (default with --pidns)\n"
 "\t -w,--wait             wait for (root) task to termiate (default)\n"
+"\t -k,--keeplsm          Try to recreate original LSM labels on all objects\n"
 "\t    --show-status      show exit status of (root) task (implies -w)\n"
 "\t    --copy-status      imitate exit status of (root) task (implies -w)\n"
 "\t -W,--no-wait          do not wait for (root) task to terminate\n"
@@ -259,6 +260,8 @@ struct args {
 	char *freezer;
 };
 
+int keep_lsm;
+
 static void usage(char *str)
 {
 	fprintf(stderr, "%s", str);
@@ -273,6 +276,7 @@ static void parse_args(struct args *args, int argc, char *argv[])
 		{ "pidns-signal",	required_argument,	NULL, '4' },
 		{ "no-pidns",	no_argument,		NULL, 'P' },
 		{ "pids",	no_argument,		NULL, 3 },
+		{ "keeplsm",	no_argument,		NULL, 'k' },
 		{ "wait",	no_argument,		NULL, 'w' },
 		{ "show-status",	no_argument,	NULL, 1 },
 		{ "copy-status",	no_argument,	NULL, 2 },
@@ -282,7 +286,7 @@ static void parse_args(struct args *args, int argc, char *argv[])
 		{ "debug",	no_argument,		NULL, 'd' },
 		{ NULL,		0,			NULL, 0 }
 	};
-	static char optc[] = "hdvpPwWF:";
+	static char optc[] = "hdvpPkwWF:";
 
 	int sig;
 
@@ -320,6 +324,9 @@ static void parse_args(struct args *args, int argc, char *argv[])
 			args->pids = 1;
 			args->pidns = 1;  /* implied */
 			break;
+		case 'k':
+			keep_lsm = RESTART_KEEP_LSM;
+			break;
 		case 'w':
 			args->wait = 1;
 			break;
@@ -750,6 +757,7 @@ static int ckpt_coordinator(struct ckpt_ctx *ctx)
 	if (ctx->args->freezer)
 		flags |= RESTART_FROZEN;
 
+	flags |= keep_lsm;
 	ret = restart(root_pid, STDIN_FILENO, flags);
 
 	if (ret < 0) {
@@ -1309,7 +1317,7 @@ static int ckpt_make_tree(struct ckpt_ctx *ctx, struct task *task)
 
 	/* on success this doesn't return */
 	ckpt_dbg("about to call sys_restart()\n");
-	ret = restart(0, STDIN_FILENO, 0);
+	ret = restart(0, STDIN_FILENO, keep_lsm);
 	if (ret < 0)
 		perror("task restore failed");
 	return ret;
@@ -1704,6 +1712,7 @@ static int ckpt_read_obj_buffer(struct ckpt_ctx *ctx, void *buf, int n)
  * read/write the checkpoint image: similar to in-kernel code
  */
 
+#define SECURITY_NAME_MAX 10
 static int ckpt_read_header(struct ckpt_ctx *ctx)
 {
 	struct ckpt_hdr_header *h;
@@ -1737,6 +1746,16 @@ static int ckpt_read_header(struct ckpt_ctx *ctx)
 	if (ret < 0)
 		return ret;
 
+	ptr += ((struct ckpt_hdr *) ptr)->len;
+	ret = ckpt_read_obj_buffer(ctx, ptr, SECURITY_NAME_MAX + 1);
+	if (ret < 0)
+		return ret;
+
+	ptr += ((struct ckpt_hdr *) ptr)->len;
+	ret = ckpt_read_obj_type(ctx, ptr, 200, CKPT_HDR_LSM_INFO);
+	if (ret < 0)
+		return ret;
+
 	/* FIXME: skip version validation for now */
 
 	return 0;
@@ -1815,6 +1834,15 @@ static int ckpt_write_header(struct ckpt_ctx *ctx)
 		return ret;
 	ptr += ((struct ckpt_hdr *) ptr)->len;
 	ret = ckpt_write_obj(ctx, (struct ckpt_hdr *) ptr);
+	if (ret < 0)
+		return ret;
+	ptr += ((struct ckpt_hdr *) ptr)->len;
+	ret = ckpt_write_obj(ctx, (struct ckpt_hdr *) ptr);
+	if (ret < 0)
+		return ret;
+
+	ptr += ((struct ckpt_hdr *) ptr)->len;
+	ret = ckpt_write_obj(ctx, (struct ckpt_hdr *) ptr);
 
 	return ret;
 }
-- 
1.6.1.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
