Subject: Re: restorecon and symbolic links
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Martin Orr <martin@martinorr.name>
Cc: Manoj Srivastava <srivasta@golden-gryphon.com>, selinux@tycho.nsa.gov,
        544215-forwarded@bugs.debian.org, Chad Sellers <csellers@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <4A9E6406.5000501@martinorr.name>
References: <4A996106.4060604@martinorr.name>
	 <87my5ijji4.fsf@anzu.internal.golden-gryphon.com>
	 <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9BCE45.7060704@martinorr.name>
	 <1251750471.27334.4.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9D2500.8050008@martinorr.name>  <4A9D30F8.1040707@martinorr.name>
	 <1251816403.27334.114.camel@moss-pluto.epoch.ncsc.mil>
	 <4A9E6406.5000501@martinorr.name>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 08:52:03 -0400
Message-Id: <1251895923.2785.94.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-02 at 13:24 +0100, Martin Orr wrote:
> The reason I named the function that way was because the function with
> _realpath expects a real path as an argument, but if this is confusing or
> goes against a convention used elsewhere then it could be changed.

Except that symlink_realpath() internally calls realpath().  I think it
makes more sense to use process_one_realpath() for the function that
invokes realpath(), and process_one() for the function that merely acts
on its argument.  

> I copied the symlink_realpath code from what used to be in match.  I assumed
> that it needed a buffer on the stack because it then concatenates the last
> component of the path on to that buffer, and realpath might not allocate a
> long enough buffer.

That's fair.

> > > Not sure it is worth warning about the broken symlink case, and that
> > > will trigger warnings for your existing users in the
> > > restorecon /dev/stdin case, right?
> 
> I agree, it is not worth warning about broken symlinks, except maybe if -v
> is specified.

If the behavior of restorecon on symlinks is to always relabel the
symlink and then if the target exists, relabel it as well, then it isn't
truly an error if the target doesn't exist.  It would be a bit clearer
if we used an explicit flag like -h, as existing utilities like chown
and chcon do, when we want to act on symlinks rather than their targets,
but that would break existing usage it seems.

Modified patch below.  Seem reasonable?

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 4c47f21..313767a 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -545,7 +545,47 @@ int canoncon(char **contextp)
 	return rc;
 }
 
-static int process_one(char *name)
+static int symlink_realpath(char *name, char *path)
+{
+	char *p = NULL, *file_sep;
+	char *tmp_path = strdupa(name);
+	size_t len = 0;
+
+	if (!tmp_path) {
+		fprintf(stderr, "strdupa on %s failed:  %s\n", name,
+			strerror(errno));
+		return -1;
+	}
+	file_sep = strrchr(tmp_path, '/');
+	if (file_sep == tmp_path) {
+		file_sep++;
+		p = strcpy(path, "");
+	} else if (file_sep) {
+		*file_sep = 0;
+		file_sep++;
+		p = realpath(tmp_path, path);
+	} else {
+		file_sep = tmp_path;
+		p = realpath("./", path);
+	}
+	if (p)
+		len = strlen(p);
+	if (!p || len + strlen(file_sep) + 2 > PATH_MAX) {
+		fprintf(stderr, "symlink_realpath(%s) failed %s\n", name,
+			strerror(errno));
+		return -1;
+	}
+	p += len;
+	/* ensure trailing slash of directory name */
+	if (len == 0 || *(p - 1) != '/') {
+		*p = '/';
+		p++;
+	}
+	strcpy(p, file_sep);
+	return 0;
+}
+
+static int process_one(char *name, int recurse_this_path)
 {
 	int rc = 0;
 	const char *namelist[2];
@@ -553,18 +593,6 @@ static int process_one(char *name)
 	FTS *fts_handle;
 	FTSENT *ftsent;
 
-	if (expand_realpath) {
-		char *p;
-		p = realpath(name, NULL);
-		if (!p) {
-			fprintf(stderr, "realpath(%s) failed %s\n", name,
-				strerror(errno));
-			return -1;
-		}
-		name = p;
-	}
-
-
 	if (!strcmp(name, "/"))
 		mass_relabel = 1;
 
@@ -604,7 +632,7 @@ static int process_one(char *name)
 			fts_set(fts_handle, ftsent, FTS_SKIP);
 		if (rc == ERR)
 			goto err;
-		if (!recurse)
+		if (!recurse_this_path)
 			break;
 	} while ((ftsent = fts_read(fts_handle)) != NULL);
 
@@ -619,8 +647,6 @@ out:
 	}
 	if (fts_handle)
 		fts_close(fts_handle);
-	if (expand_realpath)
-		free(name);
 	return rc;
 
 err:
@@ -630,6 +656,52 @@ err:
 	goto out;
 }
 
+static int process_one_realpath(char *name)
+{
+	int rc = 0;
+	char *p;
+	struct stat sb;
+
+	if (!expand_realpath) {
+		return process_one(name, recurse);
+	} else {
+		rc = lstat(name, &sb);
+		if (rc < 0) {
+			fprintf(stderr, "%s:  lstat(%s) failed:  %s\n",
+				progname, name,	strerror(errno));
+			return -1;
+		}
+
+		if (S_ISLNK(sb.st_mode)) {
+			char path[PATH_MAX + 1];
+
+			rc = symlink_realpath(name, path);
+			if (rc < 0)
+				return rc;
+			rc = process_one(path, 0);
+			if (rc < 0)
+				return rc;
+
+			p = realpath(name, NULL);
+			if (p) {
+				rc = process_one(p, recurse);
+				free(p);
+			}
+			return rc;
+		} else {
+			p = realpath(name, NULL);
+			if (!p) {
+				fprintf(stderr, "realpath(%s) failed %s\n", name,
+					strerror(errno));
+				return -1;
+			}
+			rc = process_one(p, recurse);
+			free(p);
+			return rc;
+		}
+	}
+}
+
 #ifndef USE_AUDIT
 static void maybe_audit_mass_relabel(void)
 {
@@ -987,13 +1059,13 @@ int main(int argc, char **argv)
 		delim = (null_terminated != 0) ? '\0' : '\n';
 		while ((len = getdelim(&buf, &buf_len, delim, f)) > 0) {
 			buf[len - 1] = 0;
-			errors |= process_one(buf);
+			errors |= process_one_realpath(buf);
 		}
 		if (strcmp(input_filename, "-") != 0)
 			fclose(f);
 	} else {
 		for (i = optind; i < argc; i++) {
-			errors |= process_one(argv[i]);
+			errors |= process_one_realpath(argv[i]);
 		}
 	}
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
