Subject: [RFC][PATCH] setfiles:  only call realpath if the path is relative
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Thu, 30 Jul 2009 11:17:55 -0400
Message-Id: <1248967075.11627.170.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Since we can now safely use restorecon -R / on kernels >= 2.6.30 without
concern about restorecon descending into filesystems that do not support
labeling, I wanted to compare it against running setfiles on the list of
filesystems that support labeling.  I noticed a significant difference
in performance that I traced to the use of realpath() when setfiles is
called as restorecon.

When called as restorecon, setfiles calls realpath() so that sequences
like:
	cd /etc
	restorecon shadow gshadow
will work as expected.

This patch changes the logic to only apply realpath() if the pathname is
relative, which covers the above case.  However, if a user runs
restorecon /a/b/c and any of the components is a symlink, restorecon
won't apply realpath after this patch and thus may not match the correct
file contexts entry.  Thoughts?

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 5e5d957..996d230 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -311,7 +311,7 @@ int match(const char *name, struct stat *sb, char **con)
 {
 	char path[PATH_MAX + 1];
 
-	if (expand_realpath) {
+	if (expand_realpath && name[0] != '/') {
 		if (S_ISLNK(sb->st_mode)) {
 			if (verbose > 1)
 				fprintf(stderr,


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
