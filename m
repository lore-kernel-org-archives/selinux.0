Subject: [PATCH] setfiles:  only call realpath() on user-supplied pathnames
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        Chad Sellers <csellers@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Mon, 03 Aug 2009 09:34:52 -0400
Message-Id: <1249306492.7050.11.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Change setfiles/restorecon to only call realpath() on the user-supplied
pathnames prior to invoking fts_open().  This ensures that commands such
as restorecon -R /etc/init.d and (cd /etc && restorecon shadow gshadow)
will work as expected while avoiding the overhead of calling realpath()
on each file during a file tree walk.

Since we are now only acting on user-supplied pathnames, drop the
special case handling of symlinks (when a user invokes restorecon
-R /etc/init.d he truly wants it to descend /etc/rc.d/init.d).  We can
also defer allocation of the pathname buffer to libc by passing NULL
(freeing on the out path) and we can drop the redundant exclude() check
as it will now get handled on the normal path.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 5e5d957..d219225 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -309,65 +309,6 @@ static int exclude(const char *file)
 
 int match(const char *name, struct stat *sb, char **con)
 {
-	char path[PATH_MAX + 1];
-
-	if (expand_realpath) {
-		if (S_ISLNK(sb->st_mode)) {
-			if (verbose > 1)
-				fprintf(stderr,
-					"Warning! %s refers to a symbolic link, not following last component.\n",
-					name);
-			char *p = NULL, *file_sep;
-			char *tmp_path = strdupa(name);
-			size_t len = 0;
-			if (!tmp_path) {
-				fprintf(stderr, "strdupa on %s failed:  %s\n", name,
-					strerror(errno));
-				return -1;
-			}
-			file_sep = strrchr(tmp_path, '/');
-			if (file_sep == tmp_path) {
-				file_sep++;
-				p = strcpy(path, "");
-			} else if (file_sep) {
-				*file_sep = 0;
-				file_sep++;
-				p = realpath(tmp_path, path);
-			} else {
-				file_sep = tmp_path;
-				p = realpath("./", path);
-			}
-			if (p)
-				len = strlen(p);
-			if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
-				fprintf(stderr, "realpath(%s) failed %s\n", name,
-					strerror(errno));
-				return -1;
-			}
-			p += len;
-			/* ensure trailing slash of directory name */
-			if (len == 0 || *(p - 1) != '/') {
-				*p = '/';
-				p++;
-			}
-			strcpy(p, file_sep);
-			name = path;
-			if (excludeCtr > 0 && exclude(name))
-				return -1;
-		} else {
-			char *p;
-			p = realpath(name, path);
-			if (!p) {
-				fprintf(stderr, "realpath(%s) failed %s\n", name,
-					strerror(errno));
-				return -1;
-			}
-			name = p;
-			if (excludeCtr > 0 && exclude(name))
-				return -1;
-		}
-	}
-
 	if (NULL != rootpath) {
 		if (0 != strncmp(rootpath, name, rootpathlen)) {
 			fprintf(stderr, "%s:  %s is not located in %s\n",
@@ -619,14 +560,28 @@ int canoncon(char **contextp)
 static int process_one(char *name)
 {
 	int rc = 0;
-	const char *namelist[2] = {name, NULL};
+	const char *namelist[2];
 	dev_t dev_num = 0;
 	FTS *fts_handle;
 	FTSENT *ftsent;
 
+	if (expand_realpath) {
+		char *p;
+		p = realpath(name, NULL);
+		if (!p) {
+			fprintf(stderr, "realpath(%s) failed %s\n", name,
+				strerror(errno));
+			return -1;
+		}
+		name = p;
+	}
+
+
 	if (!strcmp(name, "/"))
 		mass_relabel = 1;
 
+	namelist[0] = name;
+	namelist[1] = NULL;
 	fts_handle = fts_open((char **)namelist, fts_flags, NULL);
 	if (fts_handle  == NULL) {
 		fprintf(stderr,
@@ -676,6 +631,8 @@ out:
 	}
 	if (fts_handle)
 		fts_close(fts_handle);
+	if (expand_realpath)
+		free(name);
 	return rc;
 
 err:


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
