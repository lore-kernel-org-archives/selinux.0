Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 20 Jan 2006 08:54:06 -0500
Message-Id: <1137765246.3648.118.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-01-19 at 16:45 -0500, Joshua Brindle wrote:
> - add semanage_can_write to libsemanage which does a silent check for
> access on the active store, modules directory and binary policy
> directory
> - chance semanage_is_managed to use can_write instead of create_store
> for access check
> - add access check to seobject.py, in semanageRecord init
> - remove dans UID == 0 check
> - make the bottom level Makefile propagate install-pywrap target
> - make install-pywrap target in libselinux depend on pywrap
> 
> 
> It appears that the last commit didn't have make swigify run in
> libsemanage so the generated swig wrappers were out of date, the ones in
> this patch include my changes as well as the last ones.
> 
> Also, it seems that the current semanage is not disconnecting from the
> store or freeing the handle. While this isn't too much of a problem
> (aside from memory leaks) now, it will be in the future with the policy
> server.

diff -purN -x.svn libsemanage/include/semanage/handle.h libsemanage/include/semanage/handle.h
--- libsemanage/include/semanage/handle.h	2006-01-18 11:54:04.000000000 -0500
+++ libsemanage/include/semanage/handle.h	2006-01-19 16:33:23.000000000 -0500
@@ -100,6 +100,9 @@ int semanage_begin_transaction(semanage_
  */
 int semanage_commit(semanage_handle_t *);
 
+/* returns -1 if the store is probably not writable by the current UID/GID */
+int semanage_can_write(semanage_handle_t *sh);

The comment might be a little misleading, as:
a) access(2) checks against the real UID/GID of the process, not its
effective or fs identities; not presently an issue since the caller is
not a setuid or setgid program, but could be an issue at some point,
b) access(2) internally calls permission(9), and permission(9) calls the
security hook, so SELinux checks are also applied here.

diff -purN -x.svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2006-01-18 11:56:33.000000000 -0500
+++ libsemanage/src/semanage_store.c	2006-01-19 16:36:53.000000000 -0500
@@ -281,7 +281,41 @@ int semanage_create_store(semanage_handl
 	return 0;
 }
 
+/* returns -1 if the store or binary policy directory 
+ * is probably not writable by the current UID/GID */
+int semanage_store_writable(semanage_handle_t *sh) {

Ditto.

+	const char *path;
+	char *path2, *path3, polpath[PATH_MAX];
+	int rc;
 
+	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(), sh->conf->store_path);
+
+	if (semanage_check_init(polpath))
+		return -1;

These calls presently occur from semanage_direct* functions only, prior
to calling semanage_create_store.  Not sure why this would be different.
+
+	/* check the active directory */
+	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
+	if ((rc = access(path, R_OK | W_OK | X_OK)) != 0)
+		return rc;
+
+	/* check the binary policy install directory */
+	path = selinux_binary_policy_path();
+	path2 = strdup(path);
+	path3 = dirname(path2);
+
+	if ((rc = access(path3, R_OK | W_OK | X_OK)) != 0) {
+		free(path2);
+		return rc;
+	}
+	free(path2);

Not sure about requiring rwx to the installed policy directory for this
test.  As far as DAC permissions are concerned, this ends up being
equivalent presently to checking rwx to the module store, as they are
both root owned and only writable by owner, but conceptually being able
to manipulate the store (particularly for read ops) differs from being
able to install a new policy.  SELinux policy might allow one but not
the other.

+
+	/* check the modules directory */
+	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
+	if ((rc = access(path, R_OK | W_OK | X_OK)) != 0)
+		return rc;
+	
+	return 0;
+}

Do we need both checks (active toplevel and active modules), or will one do?
semanage_create_store() ends up doing multiple checks since it also
creates the directories along the way, but if we are just checking
access, it is likely sufficient to check the most restrictive one (i.e.
active modules), right?
 
 /********************* other I/O functions *********************/
 
diff -purN -x.svn policycoreutils/semanage/seobject.py policycoreutils/semanage/seobject.py
--- policycoreutils/semanage/seobject.py	2006-01-19 15:04:23.000000000 -0500
+++ policycoreutils/semanage/seobject.py	2006-01-19 16:34:36.000000000 -0500
@@ -142,6 +142,11 @@ class setransRecords:
 class semanageRecords:
 	def __init__(self):
 		self.sh = semanage_handle_create()
+		rc = semanage_can_write(self.sh)
+		if rc:
+			semanage_handle_destroy(self.sh)
+			raise ValueError("Cannot write to policy directory.")
+
 		self.semanaged = semanage_is_managed(self.sh)
 		if self.semanaged:
 			semanage_connect(self.sh)

Particularly given that this is called from __init__, it seems like the
check on the installed policy directory is too strong, as it could
interfere with module store read operations.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
