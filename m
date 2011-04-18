Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3IAfElw000539
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2011 06:41:14 -0400
Received: from nm1.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p3IAfDZ8005130
	for <selinux@tycho.nsa.gov>; Mon, 18 Apr 2011 10:41:13 GMT
Message-ID: <145839.76981.qm@web87007.mail.ird.yahoo.com>
Date: Mon, 18 Apr 2011 11:41:11 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: This patch adds a new subs_dist file.
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4D9CD64B.7020207@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Dan,
This patch always processes the substitution files (if installed) from the active policy contexts/files/file_contexts.subs and subs_dist irrespective of the backend type or SELABEL_OPT_PATH setting. 

Is this what's required ???

If not this patch processes the correct subs files when selabel_open is called with SELABEL_CTX_FILE. The other backends could also process their own substitution files if needed in their own areas.
I've tested with selabel* and matchpathcon functions.

If this patch is okay then I will submit it to the patch queue.

---
 libselinux/src/label.c      |    4 +---
 libselinux/src/label_file.c |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index ba316df..7d71e72 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -56,7 +56,7 @@ static char *selabel_sub(struct selabel_sub *ptr, const char *src)
 	return NULL;
 }
 
-static struct selabel_sub *selabel_subs_init(const char *path,struct selabel_sub *list)
+struct selabel_sub *selabel_subs_init(const char *path,struct selabel_sub *list)
 {
 	char buf[1024];
 	FILE *cfg = fopen(path, "r");
@@ -161,8 +161,6 @@ struct selabel_handle *selabel_open(unsigned int backend,
 	rec->validating = selabel_is_validate_set(opts, nopts);
 
 	rec->subs = NULL;
-	rec->subs = selabel_subs_init(selinux_file_context_subs_dist_path(), rec->subs);
-	rec->subs = selabel_subs_init(selinux_file_context_subs_path(), rec->subs);
 
 	if ((*initfuncs[backend])(rec, opts, nopts)) {
 		free(rec);
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 937e509..619c435 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -395,6 +395,9 @@ static int process_line(struct selabel_handle *rec,
 	return 0;
 }
 
+/* Used to initialise the substitution files in label.c */
+extern struct selabel_sub *selabel_subs_init(const char *path, struct selabel_sub *list);
+
 static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 		unsigned n)
 {
@@ -406,6 +409,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 	FILE *homedirfp = NULL;
 	char local_path[PATH_MAX + 1];
 	char homedir_path[PATH_MAX + 1];
+	char subs_file[PATH_MAX + 1];
 	char *line_buf = NULL;
 	size_t line_len = 0;
 	unsigned int lineno, pass, i, j, maxnspec;
@@ -427,6 +431,17 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
 			break;
 		}
 
+	/* Process local and distribution substitution files */
+	if (!path) {
+		rec->subs = selabel_subs_init(selinux_file_context_subs_dist_path(), rec->subs);
+		rec->subs = selabel_subs_init(selinux_file_context_subs_path(), rec->subs);
+	} else {
+		snprintf(subs_file, sizeof(subs_file), "%s.subs_dist", path);
+		rec->subs = selabel_subs_init(subs_file, rec->subs);
+		snprintf(subs_file, sizeof(subs_file), "%s.subs", path);
+		rec->subs = selabel_subs_init(subs_file, rec->subs);
+	}
+
 	/* Open the specification file. */
 	if (!path)
 		path = selinux_file_context_path();
-- 
1.7.3.2


Richard


--- On Wed, 6/4/11, Daniel J Walsh <dwalsh@redhat.com> wrote:

> From: Daniel J Walsh <dwalsh@redhat.com>
> Subject: This patch adds a new subs_dist file.
> To: "SELinux" <selinux@tycho.nsa.gov>
> Date: Wednesday, 6 April, 2011, 22:08
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The idea is to allow distributions to ship a subs file as
> well as let
> the user modify subs.
> 
> In F16 we are looking at shipping a
> 
> file_contexts.subs_dist file like this
> 
> cat file_contexts.subs_dist
> /run /var/run
> /run/lock /var/lock
> /var/run/lock /var/lock
> /lib64 /lib
> /usr/lib64 /usr/lib
> 
> 
> The we will remove all (64)?  from policy.
> 
> This will allow us to make sure all /usr/lib/libBLAH is
> labeled the same
> as /usr/lib64/libBLAH
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAk2c1ksACgkQrlYvE4MpobNXcQCgqgAiQJxmwa1+NdIq8E3tQRp6
> QT0An0ihA60di9CRsEqEdVbSaHOwtte5
> =LXgd
> -----END PGP SIGNATURE-----
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
