Message-ID: <4A9D30F8.1040707@martinorr.name>
Date: Tue, 01 Sep 2009 15:34:32 +0100
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Manoj Srivastava <srivasta@golden-gryphon.com>, selinux@tycho.nsa.gov,
        544215-forwarded@bugs.debian.org, Chad Sellers <csellers@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: restorecon and symbolic links
References: <4A996106.4060604@martinorr.name>	 <87my5ijji4.fsf@anzu.internal.golden-gryphon.com>	 <1251721031.16143.15.camel@moss-pluto.epoch.ncsc.mil>	 <4A9BCE45.7060704@martinorr.name> <1251750471.27334.4.camel@moss-pluto.epoch.ncsc.mil> <4A9D2500.8050008@martinorr.name>
In-Reply-To: <4A9D2500.8050008@martinorr.name>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 01/09/09 14:43, Martin Orr wrote:
> On 31/08/09 21:27, Stephen Smalley wrote:
>> On Mon, 2009-08-31 at 14:21 +0100, Martin Orr wrote:
>>> On 31/08/09 13:17, Stephen Smalley wrote:
>>>> On Sat, 2009-08-29 at 18:19 -0500, Manoj Srivastava wrote:
>>>>> On Sat, Aug 29 2009, Martin Orr wrote:
>>>>>
>>>>>> With policycoreutils 2.0.71, "restorecon /dev/stdin" fails if stdin is a pipe:
>>>>>> martin@caligula:~$ echo hi | sudo restorecon /dev/stdin
>>>>>> realpath(/dev/stdin) failed No such file or directory
>>>>>>
>>>>>> The intention here (and what happened with policycoreutils 2.0.69) is to
>>>>>> relabel the symbolic link.  But the recent realpath patch changed this, and
>>>>>> I don't think there is a way now to ask restorecon to relabel an individual
>>>>>> symlink.
>>>> The particular commit was:
>>>>
>>>> commit 37c5c30998b73d9c6efe53fd0534256463991c5e
>>>> Author: Stephen Smalley <sds@tycho.nsa.gov>
>>>> Date:   Mon Aug 3 09:34:52 2009 -0400
>>>>
>>>>     setfiles: only call realpath() on user-supplied pathnames
>>>>     
>>>>     Change setfiles/restorecon to only call realpath() on the user-supplied
>>>>     pathnames prior to invoking fts_open().  This ensures that commands such
>>>>     as restorecon -R /etc/init.d and (cd /etc && restorecon shadow gshadow)
>>>>     will work as expected while avoiding the overhead of calling realpath()
>>>>     on each file during a file tree walk.
>>>>     
>>>>     Since we are now only acting on user-supplied pathnames, drop the
>>>>     special case handling of symlinks (when a user invokes restorecon
>>>>     -R /etc/init.d he truly wants it to descend /etc/rc.d/init.d).  We can
>>>>     also defer allocation of the pathname buffer to libc by passing NULL
>>>>     (freeing on the out path) and we can drop the redundant exclude() check
>>>>     as it will now get handled on the normal path.
>>>>     
>>>>     Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>>
>>>> What behavior would you like instead?  I'd still like to have restorecon
>>>> -R /etc/init.d to do what the user expects, which isn't just relabel the
>>>> symlink.
>>> True, but I would expect restorecon -R /etc/init.d to relabel the symlink as
>>> well as descend into the directory.  On the whole I would expect it not to
>>> relabel the target of the symlink itself but I don't have a strong opinion
>>> on that, as long as it doesn't fail if the symlink is broken.
>> How about this for a compromise?
>>
>> Add a -h option to restorecon so that the user can explicitly ask to
>> relabel a symlink (as with chcon), but also fall back to proceeding with
>> the original path if realpath() fails, in which case we will relabel the
>> symlink if the path was a broken symlink.
> 
> I think that this is pretty complicated and the fallback behaviour is
> potentially confusing.  I still think that restorecon -R /etc/init.d should
> by default change the context on the symlink as well as descending into the
> directory.
> 
> Also, I think it is necessary to restore the code to compute the real path
> of all but the last component of a symlink when relabelling the link itself.
> 
> The following patch shows approximately the behaviour I would like, except
> that it doesn't work, because apply_spec needs an FTSENT:

Here's a patch that works, and does what I want.

It moves most of process_one into process_one_realpath, which assumes that
the path it is given requires no further expansion.
Now if given a symlink, call symlink_realpath to get the real path ignoring
the last component, and give that to process_one_realpath; tell
process_one_realpath not to recurse so this acts on the symlink only.
Then call process_one_realpath again with the real path of the target, to
recurse into it.

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 4c47f21..c84cd6f 100644
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
+static int process_one_realpath(char *name, int recurse_this_path)
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
@@ -630,6 +656,55 @@ err:
 	goto out;
 }
 
+static int process_one(char *name)
+{
+	int rc = 0;
+	char *p;
+	struct stat sb;
+
+	if (!expand_realpath) {
+		return process_one_realpath(name, recurse);
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
+			rc = process_one_realpath(path, 0);
+			if (rc < 0)
+				return rc;
+
+			p = realpath(name, NULL);
+			if (!p) {
+				fprintf(stderr, "Warning: %s: Broken symlink: %s\n",
+					name, strerror(errno));
+				return 0;
+			}
+			rc = process_one_realpath(p, recurse);
+			free(p);
+			return rc;
+		} else {
+			p = realpath(name, NULL);
+			if (!p) {
+				fprintf(stderr, "realpath(%s) failed %s\n", name,
+					strerror(errno));
+				return -1;
+			}
+			rc = process_one_realpath(p, recurse);
+			free(p);
+			return rc;
+		}
+	}
+}
+
 #ifndef USE_AUDIT
 static void maybe_audit_mass_relabel(void)
 {

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
