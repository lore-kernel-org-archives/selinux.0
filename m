Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q99DWj3K016029
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2012 09:32:45 -0400
Received: from moss-pluto.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-pluto.epoch.ncsc.mil (8.14.5/8.14.5) with ESMTP id q99DVQgK015304
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2012 09:31:26 -0400
Received: (from sds@localhost)
	by moss-pluto.epoch.ncsc.mil (8.14.5/8.14.5/Submit) id q99DVQaY015303
	for selinux@tycho.nsa.gov; Tue, 9 Oct 2012 09:31:26 -0400
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "rpm-maint@lists.rpm.org" <rpm-maint@lists.rpm.org>,
        "pmatilai@laiskiainen.org" <pmatilai@laiskiainen.org>
CC: "Ware, Ryan R" <ryan.r.ware@intel.com>,
        "SELinux@tycho.nsa.gov"
	<SELinux@tycho.nsa.gov>
Subject: First attempt for the patch on extending the plugin interface for
 rpm
Date: Mon, 8 Oct 2012 12:03:02 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612B19449DCA@IRSMSX102.ger.corp.intel.com>
Content-Type: multipart/signed; micalg=SHA1;
	protocol="application/x-pkcs7-signature";
	boundary="----=_NextPart_000_001E_01CDA566.02C5D820"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_NextPart_000_001E_01CDA566.02C5D820
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Following up our recent discussion, I have composed a first patch in order
not to talk about the abstract concepts only.
I have taken the less intrusive approach and tried to integrate the new
hooks and the notion of "security plugin"
 into the code with least amount of changes for core rpm and for existing
collection hooks.  This would also allow to leave the existing
SELinux collection hooks as they are and only move the integrated SElinux
functionality from rpm to the hooks. 

Please note that this patch is very rough and I would like to post it only
for the purpose of asking if this approach is valid. 
There are a number of decisions that I had to make about this patch that are
worth discussing: 

- The patch defines a new type of rpm plugin, called security plugin and add
a rpmpluginsAddSecurityPlugin() function to initialize it.
This is done in the similar style as rpmpluginsAddCollectionPlugin()
function. The top level function that uses it is rpmteSetupSecurityPlugins()
from transaction.c. The main difference from the collection plugin case is
that this function can automatically discover the security plugins
that should be loaded based on the %__security_plugins macro from macros.in
that contains comma separated list of security plugins to be loaded. 
I don't know how viable this approach is, but it seemed for me the easiest
way to make the plugins to be configured. 

-Due to necessity of calling the plugins hooks with the plugin struct that
is stored in ts, some rpm functions have to pass the rpmts struct. 
In addition since the ts->plugins is the actual needed parameter,
ts_internal.h has to be exposed to couple of more .c file. I find it to be
quite 
ugly, but could not figure out the better way with the current plugin
definition. I was especially annoyed by the script functions that now have
to pass ts, too.
Any suggestion on this?

- Instead of making a loop for each plugin hook to be called for each
plugin, I am iterating by the plugins and calling the hook for each plugin
inside the rpmpluginsCallxxx() functions. IMO it makes the hook code
scattered through the rpm cleaner, but this is just my opinion. 

>From 0c04ff99a00e747899137be41dca5eae72e423e4 Mon Sep 17 00:00:00 2001
From: Elena Reshetova <elena.reshetova@intel.com>
Date: Mon, 8 Oct 2012 14:21:53 +0300
Subject: [PATCH] Extending the plugin interface

---
 lib/fsm.c                   |   42 ++++++--
 lib/package.c               |   14 ++-
 lib/psm.c                   |    2 +-
 lib/rpmplugins.c            |  228
+++++++++++++++++++++++++++++++++++++++++++
 lib/rpmplugins.h            |  136 +++++++++++++++++++++++++-
 lib/rpmscript.c             |   18 ++--
 lib/rpmscript.h             |    2 +-
 lib/rpmte.c                 |   14 ++-
 lib/transaction.c           |   52 ++++++++++
 macros.in                   |    7 ++
 plugins/Makefile.am         |    5 +-
 plugins/plugin.h            |   22 +++++
 plugins/sec-sample-plugin.c |   82 ++++++++++++++++
 13 files changed, 599 insertions(+), 25 deletions(-)
 create mode 100644 plugins/sec-sample-plugin.c

diff --git a/lib/fsm.c b/lib/fsm.c
index 5ebf28d..e1cec85 100644
--- a/lib/fsm.c
+++ b/lib/fsm.c
@@ -718,11 +718,12 @@ static int fsmMapAttrs(FSM_t fsm)
 
 /** \ingroup payload
  * Create file from payload stream.
+ * @param ts		rpm transaction
  * @param fsm		file state machine data
  * @param archive	payload archive
  * @return		0 on success
  */
-static int expandRegular(FSM_t fsm, rpmpsm psm, rpmcpio_t archive, int
nodigest)
+static int expandRegular(rpmts ts, FSM_t fsm, rpmpsm psm, rpmcpio_t
archive, int nodigest)
 {
     FD_t wfd = NULL;
     const struct stat * st = &fsm->sb;
@@ -753,6 +754,13 @@ static int expandRegular(FSM_t fsm, rpmpsm psm,
rpmcpio_t archive, int nodigest)
             rc = CPIOERR_READ_FAILED;
 	    goto exit;
         }
+
+        /* Run file updated hook for all plugins */
+        rc = rpmpluginsCallFileUpdated(ts->plugins, fsm->path, fsm->buf,
len);
+        if (rc) {
+	        goto exit;
+        }
+
 	if ((Fwrite(fsm->buf, sizeof(*fsm->buf), len, wfd) != len) ||
Ferror(wfd)) {
 	    rc = CPIOERR_WRITE_FAILED;
 	    goto exit;
@@ -1050,14 +1058,15 @@ static int fsmMakeLinks(FSM_t fsm, hardLink_t li)
     return ec;
 }
 
-static int fsmCommit(FSM_t fsm, int ix);
+static int fsmCommit(rpmts ts, FSM_t fsm, int ix);
 
 /** \ingroup payload
  * Commit hard linked file set atomically.
+ * @param ts		rpm transaction
  * @param fsm		file state machine data
  * @return		0 on success
  */
-static int fsmCommitLinks(FSM_t fsm)
+static int fsmCommitLinks(rpmts ts, FSM_t fsm)
 {
     char * path = fsm->path;
     const char * nsuffix = fsm->nsuffix;
@@ -1078,7 +1087,7 @@ static int fsmCommitLinks(FSM_t fsm)
 	if (li->filex[i] < 0) continue;
 	rc = fsmMapPath(fsm, li->filex[i]);
 	if (!XFA_SKIPPING(fsm->action))
-	    rc = fsmCommit(fsm, li->filex[i]);
+	    rc = fsmCommit(ts, fsm, li->filex[i]);
 	fsm->path = _free(fsm->path);
 	li->filex[i] = -1;
     }
@@ -1149,11 +1158,12 @@ static int fsmMknod(const char *path, mode_t mode,
dev_t dev)
 
 /**
  * Create (if necessary) directories not explicitly included in package.
+ * @param ts		rpm transaction
  * @param dnli		file state machine data
  * @param sehandle	selinux label handle (bah)
  * @return		0 on success
  */
-static int fsmMkdirs(rpmfi fi, rpmfs fs, struct selabel_handle *sehandle)
+static int fsmMkdirs(rpmts ts, rpmfi fi, rpmfs fs, struct selabel_handle
*sehandle)
 {
     DNLI_t dnli = dnlInitIterator(fi, fs, 0);
     struct stat sb;
@@ -1216,7 +1226,8 @@ static int fsmMkdirs(rpmfi fi, rpmfs fs, struct
selabel_handle *sehandle)
 		rc = fsmMkdir(dn, mode);
 		if (!rc) {
 		    rc = fsmSetSELabel(sehandle, dn, mode);
-
+                    if (!rc)
+                        rc = rpmpluginsCallDirCreated(ts->plugins, dn,
mode);
 		    rpmlog(RPMLOG_DEBUG,
 			    "%s directory created with perms %04o\n",
 			    dn, (unsigned)(mode & 07777));
@@ -1524,7 +1535,7 @@ static int fsmBackup(FSM_t fsm)
     return rc;
 }
 
-static int fsmCommit(FSM_t fsm, int ix)
+static int fsmCommit(rpmts ts, FSM_t fsm, int ix)
 {
     int rc = 0;
     struct stat * st = &fsm->sb;
@@ -1551,6 +1562,10 @@ static int fsmCommit(FSM_t fsm, int ix)
         if (!rc && !getuid()) {
             rc = fsmSetSELabel(fsm->sehandle, fsm->path, fsm->sb.st_mode);
         }
+        /* Run  file closed hook for all plugins */
+        if (!rc) {
+                rc = rpmpluginsCallFileClosed(ts->plugins, fsm->path);
+        }
         if (S_ISLNK(st->st_mode)) {
             if (!rc && !getuid())
                 rc = fsmLChown(fsm->path, fsm->sb.st_uid, fsm->sb.st_gid);
@@ -1645,7 +1660,7 @@ int rpmPackageFilesInstall(rpmts ts, rpmte te, rpmfi
fi, FD_t cfd,
 
     /* Detect and create directories not explicitly in package. */
     if (!rc) {
-	rc = fsmMkdirs(fi, rpmteGetFileStates(te), fsm->sehandle);
+	rc = fsmMkdirs(ts, fi, rpmteGetFileStates(te), fsm->sehandle);
     }
 
     while (!rc) {
@@ -1684,6 +1699,13 @@ int rpmPackageFilesInstall(rpmts ts, rpmte te, rpmfi
fi, FD_t cfd,
             break;
         }
 
+        /* Run file opened hook for all plugins  */
+	rc = rpmpluginsCallFileOpened(ts->plugins, fsm->path);
+	if (rc) {
+            fsm->postpone = 1;
+            break;
+	}
+
 	if (S_ISREG(fsm->sb.st_mode) && fsm->sb.st_nlink > 1)
 	    fsm->postpone = saveHardLink(fsm, &li);
 
@@ -1693,7 +1715,7 @@ int rpmPackageFilesInstall(rpmts ts, rpmte te, rpmfi
fi, FD_t cfd,
             if (S_ISREG(st->st_mode)) {
                 rc = fsmVerify(fsm);
                 if (!(rc == CPIOERR_ENOENT)) return rc;
-                rc = expandRegular(fsm, psm, archive, nodigest);
+                rc = expandRegular(ts, fsm, psm, archive, nodigest);
             } else if (S_ISDIR(st->st_mode)) {
 		/* Directories replacing something need early backup */
                 rc = fsmBackup(fsm);
@@ -1766,7 +1788,7 @@ int rpmPackageFilesInstall(rpmts ts, rpmte te, rpmfi
fi, FD_t cfd,
 
         if (!fsm->postpone) {
             rc = ((S_ISREG(st->st_mode) && st->st_nlink > 1)
-                  ? fsmCommitLinks(fsm) : fsmCommit(fsm, fsm->ix));
+                  ? fsmCommitLinks(ts, fsm) : fsmCommit(ts, fsm, fsm->ix));
         }
         if (rc) {
             break;
diff --git a/lib/package.c b/lib/package.c
index 6fb95a6..b63ba28 100644
--- a/lib/package.c
+++ b/lib/package.c
@@ -18,6 +18,9 @@
 #include "rpmio/rpmio_internal.h"	/* fd digest bits */
 #include "lib/header_internal.h"	/* XXX headerCheck */
 
+#include "lib/rpmplugins.h"             /* rpm plugins hooks */
+#include "lib/rpmts_internal.h"         /* rpm ts struct */
+
 #include "debug.h"
 
 static const unsigned int nkeyids_max = 256;
@@ -495,7 +498,7 @@ rpmRC rpmReadHeader(rpmts ts, FD_t fd, Header *hdrp,
char ** msg)
     return rc;
 }
 
-static rpmRC rpmpkgRead(rpmKeyring keyring, rpmVSFlags vsflags, 
+static rpmRC rpmpkgRead(rpmts ts, rpmKeyring keyring, rpmVSFlags vsflags, 
 			FD_t fd, const char * fn, Header * hdrp)
 {
     pgpDigParams sig = NULL;
@@ -640,9 +643,14 @@ static rpmRC rpmpkgRead(rpmKeyring keyring, rpmVSFlags
vsflags,
 	break;
     }
 
+    /* run verify hook for all plugins */
+    if (rpmpluginsCallVerify(ts->plugins, keyring, &sigtd, sig) ==
RPMRC_FAIL) {
+       goto exit;  
+    }
+
     /** @todo Implement disable/enable/warn/error/anal policy. */
     rc = rpmVerifySignature(keyring, &sigtd, sig, ctx, &msg);
-	
+
     switch (rc) {
     case RPMRC_OK:		/* Signature is OK. */
 	rpmlog(RPMLOG_DEBUG, "%s: %s", fn, msg);
@@ -710,7 +718,7 @@ rpmRC rpmReadPackageFile(rpmts ts, FD_t fd, const char *
fn, Header * hdrp)
     rpmVSFlags vsflags = rpmtsVSFlags(ts);
     rpmKeyring keyring = rpmtsGetKeyring(ts, 1);
 
-    rc = rpmpkgRead(keyring, vsflags, fd, fn, hdrp);
+    rc = rpmpkgRead(ts, keyring, vsflags, fd, fn, hdrp);
 
     rpmKeyringFree(keyring);
 
diff --git a/lib/psm.c b/lib/psm.c
index 8f5376d..dac3b0d 100644
--- a/lib/psm.c
+++ b/lib/psm.c
@@ -420,7 +420,7 @@ static rpmRC runScript(rpmpsm psm, ARGV_const_t
prefixes,
 	sfd = rpmtsScriptFd(psm->ts);
 
     rpmswEnter(rpmtsOp(psm->ts, RPMTS_OP_SCRIPTLETS), 0);
-    rc = rpmScriptRun(script, arg1, arg2, sfd,
+    rc = rpmScriptRun(psm->ts, script, arg1, arg2, sfd,
 		      prefixes, warn_only, selinux);
     rpmswExit(rpmtsOp(psm->ts, RPMTS_OP_SCRIPTLETS), 0);
 
diff --git a/lib/rpmplugins.c b/lib/rpmplugins.c
index 9098aa5..daa53d9 100644
--- a/lib/rpmplugins.c
+++ b/lib/rpmplugins.c
@@ -110,6 +110,43 @@ rpmRC rpmpluginsAddCollectionPlugin(rpmPlugins plugins,
const char *name)
     return rc;
 }
 
+rpmRC rpmpluginsAddSecurityPlugin(rpmPlugins plugins, const char *name)
+{
+    char *path;
+    char *options;
+    int rc = RPMRC_FAIL;
+
+    path = rpmExpand("%{?__security_}",name, "}", NULL);
+    if (!path || rstreq(path, "")) {
+#ifdef ENFORCE_SECURITY
+	rpmlog(RPMLOG_ERR, _("Failed to expand %%__security_%s macro\n"),
name);
+#else
+	rpmlog(RPMLOG_INFO, _("Failed to expand %%__security_%s macro\n"),
name);
+#endif
+	goto exit;
+    }
+
+    /* split the options from the path */
+#define SKIPSPACE(s)    { while (*(s) &&  risspace(*(s))) (s)++; }
+#define SKIPNONSPACE(s) { while (*(s) && !risspace(*(s))) (s)++; }
+    options = path;
+    SKIPNONSPACE(options);
+    if (risspace(*options)) {
+	*options = '\0';
+	options++;
+	SKIPSPACE(options);
+    }
+    if (*options == '\0') {
+	options = NULL;
+    }
+
+    rc = rpmpluginsAdd(plugins, name, path, options);
+
+  exit:
+    _free(path);
+    return rc;
+}
+
 rpmPlugins rpmpluginsFree(rpmPlugins plugins)
 {
     int i;
@@ -195,3 +232,194 @@ rpmRC rpmpluginsCallCollectionPreRemove(rpmPlugins
plugins, const char *name)
     RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_COLL_PRE_REMOVE);
     return hookFunc();
 }
+
+rpmRC rpmpluginsCallTsmPre(rpmPlugins plugins, rpmts ts)
+{
+    rpmRC (*hookFunc)(rpmts);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_TSM_PRE);
+    	if ( hookFunc(ts) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
+rpmRC rpmpluginsCallTsmPost(rpmPlugins plugins, rpmts ts)
+{
+    rpmRC (*hookFunc)(rpmts);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_TSM_POST);
+    	if ( hookFunc(ts) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
+rpmRC rpmpluginsCallPsmPre(rpmPlugins plugins, rpmte te)
+{
+    rpmRC (*hookFunc)(rpmte);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_PSM_PRE);
+    	if ( hookFunc(te) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
+rpmRC rpmpluginsCallPsmPost(rpmPlugins plugins, rpmte te)
+{
+    rpmRC (*hookFunc)(rpmte);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_PSM_POST);
+    	if ( hookFunc(te) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
+rpmRC rpmpluginsCallVerify(rpmPlugins plugins, rpmKeyring keyring,
+                           rpmtd sigtd, pgpDigParams sig)
+{
+    rpmRC (*hookFunc)(rpmKeyring, rpmtd, pgpDigParams);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_VERIFY);
+    	if ( hookFunc(keyring, sigtd, sig) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
+rpmRC rpmpluginsCallFileOpened(rpmPlugins plugins, const char* path)
+{
+    rpmRC (*hookFunc)(const char*);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_FILE_OPENED);
+    	if ( hookFunc(path) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
+rpmRC rpmpluginsCallFileUpdated(rpmPlugins plugins, const char* path,
+                                char *buf, size_t len)
+{
+    rpmRC (*hookFunc)(const char*, char*, size_t);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_FILE_UPDATED);
+    	if ( hookFunc(path, buf, len) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
+rpmRC rpmpluginsCallFileClosed(rpmPlugins plugins, const char* path)
+{
+    rpmRC (*hookFunc)(const char*);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_FILE_CLOSED);
+    	if ( hookFunc(path) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
+rpmRC rpmpluginsCallDirCreated(rpmPlugins plugins, const char* path, mode_t
mode)
+{
+    rpmRC (*hookFunc)(const char*, mode_t);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_DIR_CREATED);
+    	if ( hookFunc(path, mode) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
+rpmRC rpmpluginsCallFileConflict(rpmPlugins plugins, rpmts ts, rpmte te,
rpmfi fi,
+				  rpmfi oldFi, Header oldHeader)
+{
+    rpmRC (*hookFunc)(rpmts, rpmte, rpmfi, rpmfi, Header);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_FILE_CONFLICT);
+    	if ( hookFunc(ts, te, fi, oldFi, oldHeader) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
+rpmRC rpmpluginsCallScriptExec(rpmPlugins plugins, ARGV_const_t argv)
+{
+    rpmRC (*hookFunc)(ARGV_const_t);
+    int i;
+    rpmRC rc = RPMRC_OK;
+    const char *name = NULL;
+
+    for (i = 0; i < plugins->count; i++) {
+	name = plugins->names[i];
+    	RPMPLUGINS_SET_HOOK_FUNC(PLUGINHOOK_SCRIPT_EXEC);
+    	if ( hookFunc(argv) == RPMRC_FAIL )
+		rc = RPMRC_FAIL;
+    }
+
+    return rc;
+}
+
diff --git a/lib/rpmplugins.h b/lib/rpmplugins.h
index 7985559..c5434bb 100644
--- a/lib/rpmplugins.h
+++ b/lib/rpmplugins.h
@@ -11,11 +11,28 @@ extern "C" {
 
 #define PLUGINHOOK_INIT_FUNC			pluginhook_init
 #define PLUGINHOOK_CLEANUP_FUNC			pluginhook_cleanup
+
 #define PLUGINHOOK_OPENTE_FUNC			pluginhook_opente
 #define PLUGINHOOK_COLL_POST_ADD_FUNC		pluginhook_coll_post_add
 #define PLUGINHOOK_COLL_POST_ANY_FUNC		pluginhook_coll_post_any
 #define PLUGINHOOK_COLL_PRE_REMOVE_FUNC
pluginhook_coll_pre_remove
 
+#define PLUGINHOOK_TSM_PRE_FUNC			pluginhook_tsm_pre
+#define PLUGINHOOK_TSM_POST_FUNC		pluginhook_tsm_post
+
+#define PLUGINHOOK_PSM_PRE_FUNC			pluginhook_psm_pre
+#define PLUGINHOOK_PSM_POST_FUNC		pluginhook_psm_post
+#define PLUGINHOOK_VERIFY_FUNC			pluginhook_verify
+
+#define PLUGINHOOK_FILE_OPENED_FUNC		pluginhook_file_opened
+#define PLUGINHOOK_FILE_UPDATED_FUNC		pluginhook_file_updated
+#define PLUGINHOOK_FILE_CLOSED_FUNC		pluginhook_file_closed
+#define PLUGINHOOK_DIR_CREATED_FUNC		pluginhook_dir_created
+#define PLUGINHOOK_FILE_CONFLICT_FUNC		pluginhook_file_conflict
+
+#define PLUGINHOOK_SCRIPT_EXEC_FUNC		pluginhook_script_exec
+
+
 enum rpmPluginHook_e {
     PLUGINHOOK_NONE		= 0,
     PLUGINHOOK_INIT		= 1 << 0,
@@ -23,7 +40,18 @@ enum rpmPluginHook_e {
     PLUGINHOOK_OPENTE		= 1 << 2,
     PLUGINHOOK_COLL_POST_ADD	= 1 << 3,
     PLUGINHOOK_COLL_POST_ANY	= 1 << 4,
-    PLUGINHOOK_COLL_PRE_REMOVE	= 1 << 5
+    PLUGINHOOK_COLL_PRE_REMOVE	= 1 << 5,
+    PLUGINHOOK_TSM_PRE		= 1 << 6,
+    PLUGINHOOK_TSM_POST		= 1 << 7,
+    PLUGINHOOK_PSM_PRE		= 1 << 8,			
+    PLUGINHOOK_PSM_POST	                = 1 << 9,		
+    PLUGINHOOK_VERIFY		= 1 << 10,		
+    PLUGINHOOK_FILE_OPENED	= 1 << 11,		
+    PLUGINHOOK_FILE_UPDATED	= 1 << 12,		
+    PLUGINHOOK_FILE_CLOSED	= 1 << 13,
+    PLUGINHOOK_DIR_CREATED	= 1 << 14,
+    PLUGINHOOK_FILE_CONFLICT	= 1 << 15,
+    PLUGINHOOK_SCRIPT_EXEC	= 1 << 16
 };
 
 typedef rpmFlags rpmPluginHook;
@@ -61,6 +89,14 @@ rpmRC rpmpluginsAdd(rpmPlugins plugins, const char *name,
const char *path, cons
 rpmRC rpmpluginsAddCollectionPlugin(rpmPlugins plugins, const char *name);
 
 /** \ingroup rpmplugins
+ * Add and open a security plugin
+ * @param plugins	plugins structure to add a security plugin to
+ * @param name		name of security plugin to open
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsAddSecurityPlugin(rpmPlugins plugins, const char *name);
+
+/** \ingroup rpmplugins
  * Determine if a plugin has been added already
  * @param plugins	plugins structure
  * @param name		name of plugin to check
@@ -119,6 +155,104 @@ rpmRC rpmpluginsCallCollectionPostAny(rpmPlugins
plugins, const char *name);
  */
 rpmRC rpmpluginsCallCollectionPreRemove(rpmPlugins plugins, const char
*name);
 
+/** \ingroup rpmplugins
+ * Call the pre transaction plugin hook
+ * @param plugins	plugins structure
+ * @param ts		processed transaction
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallTsmPre(rpmPlugins plugins, rpmts ts);
+
+/** \ingroup rpmplugins
+ * Call the post transaction plugin hook
+ * @param plugins	plugins structure
+ * @param ts		processed transaction
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallTsmPost(rpmPlugins plugins, rpmts ts);
+
+/** \ingroup rpmplugins
+ * Call the post transaction element plugin hook
+ * @param plugins	plugins structure
+ * @param te		processed transaction element
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallPsmPre(rpmPlugins plugins, rpmte te);
+
+/** \ingroup rpmplugins
+ * Call the post transaction element plugin hook
+ * @param plugins	plugins structure
+ * @param te		processed transaction element
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallPsmPost(rpmPlugins plugins, rpmte te);
+
+/** \ingroup rpmplugins
+ * Call the verify plugin hook
+ * @param plugins	plugins structure
+ * @param keyring	rpm keyring
+ * @param sigtd		rpm tag data
+ * @param sig		pgpDig parameters
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallVerify(rpmPlugins plugins, rpmKeyring keyring, rpmtd
sigtd, pgpDigParams sig);
+
+/** \ingroup rpmplugins
+ * Call the file opened plugin hook
+ * @param plugins	plugins structure
+ * @param path		filepath
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallFileOpened(rpmPlugins plugins, const char* path);
+
+/** \ingroup rpmplugins
+ * Call the file updated plugin hook
+ * @param plugins	plugins structure
+ * @param path		filepath
+ * @param buf		buffer with file chunk
+ * @param len		length of the buffer
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallFileUpdated(rpmPlugins plugins, const char* path, char
*buf, size_t len);
+
+/** \ingroup rpmplugins
+ * Call the file closed plugin hook
+ * @param plugins	plugins structure
+ * @param path		filepath
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallFileClosed(rpmPlugins plugins, const char* path);
+
+/** \ingroup rpmplugins
+ * Call the directory created plugin hook
+ * @param plugins	plugins structure
+ * @param path		filepath
+ * @param mode		file mode
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallDirCreated(rpmPlugins plugins, const char* path, mode_t
mode);
+
+/** \ingroup rpmplugins
+ * Call the file conflict plugin hook
+ * @param plugins	plugins structure
+ * @param ts		processed transaction
+ * @param te		processed transaction element
+ * @param fi		new conflicting file
+ * @param oldfi		previously installed file
+ * @param oldHeader	package header that provided the file previously
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallFileConflict(rpmPlugins plugins, rpmts ts, rpmte te,
+				 rpmfi fi, rpmfi oldFi, Header oldHeader);
+
+/** \ingroup rpmplugins
+ * Call the script execution plugin hook
+ * @param plugins	plugins structure
+ * @param argv		script arguments
+ * @return		RPMRC_OK on success, RPMRC_FAIL otherwise
+ */
+rpmRC rpmpluginsCallScriptExec(rpmPlugins plugins, ARGV_const_t argv);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/rpmscript.c b/lib/rpmscript.c
index 57c24c6..3adde0d 100644
--- a/lib/rpmscript.c
+++ b/lib/rpmscript.c
@@ -14,6 +14,9 @@
 #include "rpmio/rpmlua.h"
 #include "lib/rpmscript.h"
 
+#include "lib/rpmplugins.h"     /* rpm plugins hooks */
+#include "lib/rpmts_internal.h" /* ts struct */
+
 #include "debug.h"
 
 struct rpmScript_s {
@@ -91,7 +94,7 @@ static rpmRC runLuaScript(int selinux, ARGV_const_t
prefixes,
 
 static const char * const SCRIPT_PATH =
"PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin";
 
-static void doScriptExec(int selinux, ARGV_const_t argv, ARGV_const_t
prefixes,
+static void doScriptExec(rpmts ts, int selinux, ARGV_const_t argv,
ARGV_const_t prefixes,
 			FD_t scriptFd, FD_t out)
 {
     int pipes[2];
@@ -169,7 +172,10 @@ static void doScriptExec(int selinux, ARGV_const_t
argv, ARGV_const_t prefixes,
 	}
 
 	if (xx == 0) {
-	    xx = execv(argv[0], argv);
+                /* Run script exec hook for all plugins */
+                if (rpmpluginsCallScriptExec(ts->plugins, argv) !=
RPMRC_FAIL) {
+		        xx = execv(argv[0], argv);
+                }
 	}
     }
     _exit(127); /* exit 127 for compatibility with bash(1) */
@@ -202,7 +208,7 @@ exit:
 /**
  * Run an external script.
  */
-static rpmRC runExtScript(int selinux, ARGV_const_t prefixes,
+static rpmRC runExtScript(rpmts ts, int selinux, ARGV_const_t prefixes,
 		   const char *sname, rpmlogLvl lvl, FD_t scriptFd,
 		   ARGV_t * argvp, const char *script, int arg1, int arg2)
 {
@@ -258,7 +264,7 @@ static rpmRC runExtScript(int selinux, ARGV_const_t
prefixes,
     } else if (pid == 0) {/* Child */
 	rpmlog(RPMLOG_DEBUG, "%s: execv(%s) pid %d\n",
 	       sname, *argvp[0], (unsigned)getpid());
-	doScriptExec(selinux, *argvp, prefixes, scriptFd, out);
+	doScriptExec(ts, selinux, *argvp, prefixes, scriptFd, out);
     }
 
     do {
@@ -296,7 +302,7 @@ exit:
     return rc;
 }
 
-rpmRC rpmScriptRun(rpmScript script, int arg1, int arg2, FD_t scriptFd,
+rpmRC rpmScriptRun(rpmts ts, rpmScript script, int arg1, int arg2, FD_t
scriptFd,
 		   ARGV_const_t prefixes, int warn_only, int selinux)
 {
     ARGV_t args = NULL;
@@ -315,7 +321,7 @@ rpmRC rpmScriptRun(rpmScript script, int arg1, int arg2,
FD_t scriptFd,
     if (rstreq(args[0], "<lua>")) {
 	rc = runLuaScript(selinux, prefixes, script->descr, lvl, scriptFd,
&args, script->body, arg1, arg2);
     } else {
-	rc = runExtScript(selinux, prefixes, script->descr, lvl, scriptFd,
&args, script->body, arg1, arg2);
+	rc = runExtScript(ts, selinux, prefixes, script->descr, lvl,
scriptFd, &args, script->body, arg1, arg2);
     }
     argvFree(args);
 
diff --git a/lib/rpmscript.h b/lib/rpmscript.h
index 7d584bc..61f02a2 100644
--- a/lib/rpmscript.h
+++ b/lib/rpmscript.h
@@ -28,7 +28,7 @@ RPM_GNUC_INTERNAL
 rpmScript rpmScriptFree(rpmScript script);
 
 RPM_GNUC_INTERNAL
-rpmRC rpmScriptRun(rpmScript script, int arg1, int arg2, FD_t scriptFd,
+rpmRC rpmScriptRun(rpmts ts, rpmScript script, int arg1, int arg2, FD_t
scriptFd,
                    ARGV_const_t prefixes, int warn_only, int selinux);
 
 RPM_GNUC_INTERNAL
diff --git a/lib/rpmte.c b/lib/rpmte.c
index 35b8e3e..4e98c32 100644
--- a/lib/rpmte.c
+++ b/lib/rpmte.c
@@ -941,7 +941,7 @@ int rpmteProcess(rpmte te, pkgGoal goal)
     int scriptstage = (goal != PKG_INSTALL && goal != PKG_ERASE);
     int test = (rpmtsFlags(te->ts) & RPMTRANS_FLAG_TEST);
     int reset_fi = (scriptstage == 0 && test == 0);
-    int failed = 1;
+    int failed = 0;
 
     /* Dont bother opening for elements without pre/posttrans scripts */
     if (goal == PKG_PRETRANS || goal == PKG_POSTTRANS) {
@@ -955,7 +955,17 @@ int rpmteProcess(rpmte te, pkgGoal goal)
     }
 
     if (rpmteOpen(te, reset_fi)) {
-	failed = rpmpsmRun(te->ts, te, goal);
+
+    	/* Run pre transaction element hook for all plugins */
+    	if (goal != PKG_PRETRANS && goal != PKG_POSTTRANS) {
+    		failed = rpmpluginsCallPsmPre(rpmtsPlugins(te->ts), te);
+    	}
+	if (!failed) {
+		failed = rpmpsmRun(te->ts, te, goal);
+        	/* Run post transaction element hook for all plugins*/
+        	if (goal != PKG_PRETRANS && goal != PKG_POSTTRANS)
+    			failed = rpmpluginsCallPsmPre(rpmtsPlugins(te->ts),
te);
+		}
 	rpmteClose(te, reset_fi);
     }
     
diff --git a/lib/transaction.c b/lib/transaction.c
index c05d3af..56e840c 100644
--- a/lib/transaction.c
+++ b/lib/transaction.c
@@ -21,6 +21,8 @@
 #include "lib/rpmts_internal.h"
 #include "rpmio/rpmhook.h"
 
+#include "lib/rpmplugins.h"
+
 /* XXX FIXME: merge with existing (broken?) tests in system.h */
 /* portability fiddles */
 #if STATFS_IN_SYS_STATVFS
@@ -409,6 +411,9 @@ static void handleInstInstalledFile(const rpmts ts,
rpmte p, rpmfi fi, int fx,
 	if (rpmtsFilterFlags(ts) & RPMPROB_FILTER_REPLACEOLDFILES)
 	    rConflicts = 0;
 
+        /* run file conflict hook for all plugins */
+        rpmpluginsCallFileConflict(ts->plugins, ts, p, fi, otherFi,
otherHeader);
+
 	if (rConflicts) {
 	    char *altNEVR = headerGetAsString(otherHeader, RPMTAG_NEVRA);
 	    char *fn = rpmfiFNIndex(fi, fx);
@@ -1414,6 +1419,34 @@ static int rpmtsProcess(rpmts ts)
     return rc;
 }
 
+static rpmRC rpmteSetupSecurityPlugins(rpmts ts)
+{
+    rpmRC rc = 0;
+    char *plugins = NULL, *plugin = NULL;
+    char delims[] = ",";
+
+    plugins = rpmExpand("%{?__security_plugins}", NULL);
+    if (!plugins || rstreq(plugins, "")) {
+#ifdef ENFORCE_SECURITY
+	rpmlog(RPMLOG_ERR, _("Failed to expand %%__security_plugins
macro\n"));
+#else
+	rpmlog(RPMLOG_INFO, _("Failed to expand %%__security_plugins
macro\n"));
+#endif
+	return -1;
+    }
+
+    plugin = strtok(plugins, delims);
+    while(plugin != NULL) {
+	rpmlog(RPMLOG_DEBUG, _("plugin is %s\n"), plugin);
+        if (!rpmpluginsPluginAdded(ts->plugins, (const char*)plugin)) {
+	        rc = rpmpluginsAddSecurityPlugin(ts->plugins, (const
char*)plugin);
+        }
+        plugin = strtok(NULL, delims);
+    }
+    free(plugins);
+    return rc;
+}
+
 int rpmtsRun(rpmts ts, rpmps okProbs, rpmprobFilterFlags ignoreSet)
 {
     int rc = -1; /* assume failure */
@@ -1441,11 +1474,25 @@ int rpmtsRun(rpmts ts, rpmps okProbs,
rpmprobFilterFlags ignoreSet)
 	goto exit;
     }
 
+
+    rc = rpmteSetupSecurityPlugins(ts);
+
+#ifdef ENFORCE_SECURITY
+    if (rc == -1) {
+	goto exit;
+    }
+#endif
+
     rpmtsSetupCollections(ts);
 
     /* Check package set for problems */
     tsprobs = checkProblems(ts);
 
+    /* Run pre transaction hook for all plugins */
+    if ( rpmpluginsCallTsmPre(ts->plugins, ts) == RPMRC_FAIL) {
+	goto exit;
+    }
+
     /* Run pre-transaction scripts, but only if there are no known
      * problems up to this point and not disabled otherwise. */
     if (!((rpmtsFlags(ts) &
(RPMTRANS_FLAG_BUILD_PROBS|RPMTRANS_FLAG_NOPRE))
@@ -1489,6 +1536,11 @@ int rpmtsRun(rpmts ts, rpmps okProbs,
rpmprobFilterFlags ignoreSet)
 	runTransScripts(ts, PKG_POSTTRANS);
     }
 
+    /* Run post transaction hook for all plugins */
+    if ( rpmpluginsCallTsmPost(ts->plugins, ts) == RPMRC_FAIL) {
+	goto exit;
+    }
+
 exit:
     /* Finish up... */
     (void) umask(oldmask);
diff --git a/macros.in b/macros.in
index f55dcbe..b8e7f3c 100644
--- a/macros.in
+++ b/macros.in
@@ -1031,6 +1031,13 @@ done \
 %__collection_sepolicy_flags	1
 
 
#---------------------------------------------------------------------------
---
+# Security specific macros
+%__security_plugins     sample
+%__plugindir		%{_libdir}/rpm-plugins
+%__security_sample	%{__plugindir}/sec-sample-plugin.so
+
+
+#--------------------------------------------------------------------------
----
 # Macros for further automated spec %setup and patch application
 
 # default to plain patch
diff --git a/plugins/Makefile.am b/plugins/Makefile.am
index 69230de..b15417f 100644
--- a/plugins/Makefile.am
+++ b/plugins/Makefile.am
@@ -13,7 +13,7 @@ AM_LDFLAGS = -avoid-version -module -shared
 
 pluginsdir = $(libdir)/rpm-plugins
 
-plugins_LTLIBRARIES = exec.la sepolicy.la
+plugins_LTLIBRARIES = exec.la sepolicy.la sec-sample-plugin.la
 
 exec_la_SOURCES = plugin.h exec.c
 exec_la_LIBADD = $(top_builddir)/lib/librpm.la
$(top_builddir)/rpmio/librpmio.la
@@ -21,3 +21,6 @@ exec_la_LIBADD = $(top_builddir)/lib/librpm.la
$(top_builddir)/rpmio/librpmio.la
 sepolicy_la_SOURCES = plugin.h sepolicy.c
 sepolicy_la_LIBADD = $(top_builddir)/lib/librpm.la
$(top_builddir)/rpmio/librpmio.la @WITH_SELINUX_LIB@ @WITH_SEMANAGE_LIB@
 
+secsampleplugin_la_SOURCES = plugin.h sec-sample-plugin.c
+secsampleplugin_la_LIBADD = $(top_builddir)/lib/librpm.la
$(top_builddir)/rpmio/librpmio.la
+
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 5156f93..9aedd19 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -7,9 +7,31 @@
 #include "lib/rpmplugins.h"
 #include "lib/rpmchroot.h"
 
+/* general plugin hooks */
 rpmRC PLUGINHOOK_INIT_FUNC(rpmts ts, const char * name, const char * opts);
 rpmRC PLUGINHOOK_CLEANUP_FUNC(void);
+
+/* collection plugin hooks */
 rpmRC PLUGINHOOK_OPENTE_FUNC(rpmte te);
 rpmRC PLUGINHOOK_COLL_POST_ANY_FUNC(void);
 rpmRC PLUGINHOOK_COLL_POST_ADD_FUNC(void);
 rpmRC PLUGINHOOK_COLL_PRE_REMOVE_FUNC(void);
+
+/* per transaction plugin hooks */
+rpmRC PLUGINHOOK_TSM_PRE_FUNC(rpmts ts);
+rpmRC PLUGINHOOK_TSM_POST_FUNC(rpmts ts);
+
+/* per transaction element plugin hooks */
+rpmRC PLUGINHOOK_PSM_PRE_FUNC(rpmte te);
+rpmRC PLUGINHOOK_PSM_POST_FUNC(rpmte te);
+rpmRC PLUGINHOOK_VERIFY_FUNC(rpmKeyring keyring, rpmtd sigtd, pgpDig sig);
+
+/* per file plugin hooks */
+rpmRC PLUGINHOOK_FILE_OPENED_FUNC(const char* path); 
+rpmRC PLUGINHOOK_FILE_UPDATED_FUNC(const char* path, char *buf, size_t
len);
+rpmRC PLUGINHOOK_FILE_CLOSED_FUNC(const char* path);
+rpmRC PLUGINHOOK_DIR_CREATED_FUNC(const char* path, mode_t mode);
+rpmRC PLUGINHOOK_FILE_CONFLICT_FUNC(rpmts ts, rpmte te, rpmfi fi, rpmfi
oldFi, Header oldHeader);
+
+/*per script plugin hooks */
+rpmRC PLUGINHOOK_SCRIPT_EXEC_FUNC(ARGV_const_t argv);
diff --git a/plugins/sec-sample-plugin.c b/plugins/sec-sample-plugin.c
new file mode 100644
index 0000000..bc59225
--- /dev/null
+++ b/plugins/sec-sample-plugin.c
@@ -0,0 +1,82 @@
+#include "plugin.h"
+
+rpmPluginHook PLUGIN_HOOKS = \
+	PLUGINHOOK_INIT | \
+	PLUGINHOOK_CLEANUP | \
+        PLUGINHOOK_TSM_PRE | \
+        PLUGINHOOK_TSM_POST | \
+        PLUGINHOOK_PSM_PRE | \			
+        PLUGINHOOK_PSM_POST | \		
+        PLUGINHOOK_VERIFY | \		
+        PLUGINHOOK_FILE_OPENED | \	
+        PLUGINHOOK_FILE_UPDATED | \
+        PLUGINHOOK_FILE_CLOSED | \
+        PLUGINHOOK_DIR_CREATED | \
+        PLUGINHOOK_FILE_CONFLICT | \
+        PLUGINHOOK_SCRIPT_EXEC;
+
+rpmRC PLUGINHOOK_INIT_FUNC(rpmts ts, const char *name, const char *opts)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_CLEANUP_FUNC(void)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_TSM_PRE_FUNC(rpmts ts)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_TSM_POST_FUNC(rpmts ts)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_PSM_PRE_FUNC(rpmte te)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_PSM_POST_FUNC(rpmte te)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_VERIFY_FUNC(rpmKeyring keyring, rpmtd sigtd, pgpDig sig)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_FILE_OPENED_FUNC(const char* path)
+{
+    return RPMRC_OK;
+}
+ 
+rpmRC PLUGINHOOK_FILE_UPDATED_FUNC(const char* path, char *buf, size_t len)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_FILE_CLOSED_FUNC(const char* path)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_DIR_CREATED_FUNC(const char* path, mode_t mode)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_FILE_CONFLICT_FUNC(rpmts ts, rpmte te, rpmfi fi, rpmfi
oldFi, Header oldHeader)
+{
+    return RPMRC_OK;
+}
+
+rpmRC PLUGINHOOK_SCRIPT_EXEC_FUNC(ARGV_const_t argv)
+{
+    return RPMRC_OK;
+}
+
-- 
1.7.9.5


------=_NextPart_000_001E_01CDA566.02C5D820
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIYcDCCAyAw
ggKJoAMCAQICBDXe9M8wDQYJKoZIhvcNAQEFBQAwTjELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0Vx
dWlmYXgxLTArBgNVBAsTJEVxdWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTAeFw05
ODA4MjIxNjQxNTFaFw0xODA4MjIxNjQxNTFaME4xCzAJBgNVBAYTAlVTMRAwDgYDVQQKEwdFcXVp
ZmF4MS0wKwYDVQQLEyRFcXVpZmF4IFNlY3VyZSBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwgZ8wDQYJ
KoZIhvcNAQEBBQADgY0AMIGJAoGBAMFdsVhnCGLuoJotHwhtkRRomAoe/toEbxOEYiHD0XzOnwXg
uAHwTjTs4oqVBGSs8WtTXwWzy2eAv0ICjv7dAQns4QAUT/z78AzdQ7pbK+EfgHCZFVeTFvEPl2q3
wmgjHMxNWTCsUR47ryvW7mNFe8XZX1DS41APOojnvxT94Me5AgMBAAGjggEJMIIBBTBwBgNVHR8E
aTBnMGWgY6BhpF8wXTELMAkGA1UEBhMCVVMxEDAOBgNVBAoTB0VxdWlmYXgxLTArBgNVBAsTJEVx
dWlmYXggU2VjdXJlIENlcnRpZmljYXRlIEF1dGhvcml0eTENMAsGA1UEAxMEQ1JMMTAaBgNVHRAE
EzARgQ8yMDE4MDgyMjE2NDE1MVowCwYDVR0PBAQDAgEGMB8GA1UdIwQYMBaAFEjmaPkr0rKV10fY
IyAQTzOYkJ/UMB0GA1UdDgQWBBRI5mj5K9KylddH2CMgEE8zmJCf1DAMBgNVHRMEBTADAQH/MBoG
CSqGSIb2fQdBAAQNMAsbBVYzLjBjAwIGwDANBgkqhkiG9w0BAQUFAAOBgQBYzinq/Pfetc4CuRe1
hdG54+CVzCUxDQCmkm5/tpJjnlCV0Zpv5BHeY4VumO6o/1rI01WyZnFX3sAh6z0qpyNJAQSGQnv8
7n+iFlK1Z2fTQNs7JliyKHc9rhR3Ydb6KmYnoA36p3Nc6nDxlCFlRF/6/O8paKmih3nvee9PrAd3
ODCCAz0wggKmoAMCAQICAwWw/zANBgkqhkiG9w0BAQUFADBOMQswCQYDVQQGEwJVUzEQMA4GA1UE
ChMHRXF1aWZheDEtMCsGA1UECxMkRXF1aWZheCBTZWN1cmUgQ2VydGlmaWNhdGUgQXV0aG9yaXR5
MB4XDTA2MDIxNjE4MDEzMFoXDTE2MDIxOTE4MDEzMFowUjELMAkGA1UEBhMCVVMxGjAYBgNVBAoT
EUludGVsIENvcnBvcmF0aW9uMScwJQYDVQQDEx5JbnRlbCBFeHRlcm5hbCBCYXNpYyBQb2xpY3kg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBpd/XOb9QVqEZ8mQ1042TdOIq3ATD
IsV2xDyt30yLyMR5Wjtus0bn3B+he89BiNO/LP6+rFzEwlD55PlX+HLGIKeNNG97dqyc30FElEUj
ZzTZFq2N4e3kVJ/XAEEgANzV8v9qp7qWwxugPgfc3z9BkYot+CifozexHLb/hEZj+yISCU61kRZv
uSQ0E11yYL4dRgcglJeaHo3oX57rvIckaLsYV5/1Aj+R8DM1Ppk965XQAKsHfnyT7C4S50T4lVn4
lz36wOdNZn/zegG1zp41lnoTFfT4KuKVJH5x7YD1p6KbgJCKLovnujGuohquBNfdXKpZkvz6pGv+
iC1HawJdAgMBAAGjgaAwgZ0wDgYDVR0PAQH/BAQDAgEGMB0GA1UdDgQWBBQaxgxKxEdvqNutK/D0
Vgaj7TdUDDA6BgNVHR8EMzAxMC+gLaArhilodHRwOi8vY3JsLmdlb3RydXN0LmNvbS9jcmxzL3Nl
Y3VyZWNhLmNybDAfBgNVHSMEGDAWgBRI5mj5K9KylddH2CMgEE8zmJCf1DAPBgNVHRMBAf8EBTAD
AQH/MA0GCSqGSIb3DQEBBQUAA4GBABMQOK2kVKVIlUWwLTdywJ+e2O+PC/uQltK2F3lRyrPfBn69
tOkIP4SgDJOfsxyobIrPLe75kBLw+Dom13OBDp/EMZJZ1CglQfVV8co9mT3aZMjSGGQiMgkJLR3j
Mfr900fXZKj5XeqCJ+JP0mEhJGEdVCY+FFlksJjV86fDrq1QMIIFijCCBHKgAwIBAgIKYSCKYgAA
AAAACDANBgkqhkiG9w0BAQUFADBSMQswCQYDVQQGEwJVUzEaMBgGA1UEChMRSW50ZWwgQ29ycG9y
YXRpb24xJzAlBgNVBAMTHkludGVsIEV4dGVybmFsIEJhc2ljIFBvbGljeSBDQTAeFw0wOTA1MTUx
OTI3MjZaFw0xNTA1MTUxOTM3MjZaMFYxCzAJBgNVBAYTAlVTMRowGAYDVQQKExFJbnRlbCBDb3Jw
b3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSAzQjCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKQEM1Wn9TU9vc9C+/Tc7KB+eiYElmrcEWE32WUd
HvWG+IcQHVQsikTmMyKKojNLw2B5s6Iekc8ivDo/wCfjZzX9JyftMnc+AArc0la87Olybzm8K9jX
EfTBvTnUSFSiI9ZYefITdiUgqlAFuljFZEHYKYtLuhrRacpmQfP4mV63NKdc2bT804HRf6YptZFa
4k6YN94zlrGNrBuQQ74WFzz/jLBusbUpEkro6Mu/ZYFOFWQrV9lBhF9Ruk8yN+3N6n9fUo/qBigi
F2kEn9xVh1ykl7SCGL2jBUkXx4qgV27a6Si8lRRdgrHGtN/HWnSWlLXTH5l575H4Lq++77OFv38C
AwEAAaOCAlwwggJYMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFA7GKvdZsggQkCVvw939imYx
MCvFMAsGA1UdDwQEAwIBhjASBgkrBgEEAYI3FQEEBQIDAQABMCMGCSsGAQQBgjcVAgQWBBQ5oFY2
ekKQ/5Ktim+VdMeSWb4QWTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAfBgNVHSMEGDAWgBQa
xgxKxEdvqNutK/D0Vgaj7TdUDDCBvQYDVR0fBIG1MIGyMIGvoIGsoIGphk5odHRwOi8vd3d3Lmlu
dGVsLmNvbS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBQb2xpY3kl
MjBDQS5jcmyGV2h0dHA6Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRvcnkvQ1JML0lu
dGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMFBvbGljeSUyMENBLmNybDCB4wYIKwYBBQUHAQEEgdYw
gdMwYwYIKwYBBQUHMAKGV2h0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNh
dGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMFBvbGljeSUyMENBLmNydDBsBggrBgEFBQcw
AoZgaHR0cDovL2NlcnRpZmljYXRlcy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMv
SW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwUG9saWN5JTIwQ0EuY3J0MA0GCSqGSIb3DQEBBQUA
A4IBAQCxtQEHchVQhXyjEqtMVUMe6gkmPsIczHxSeqNbo9dsD+6xbT65JT+oYgpIAtfEsYXeUJu1
cChqpb22U5bMAz7eaQcW5bzefufWvA6lg2048B8oczBj/q+5P5NpYrUO8jOmN4jTjfJq3ElZ7yFW
py7rB3Vm/aN6ATYqWfMbS/xfh+JCxmH3droUmMJI0/aZJHsLtjbjFnNsHDNrJZX1vxlM78Lb1hjs
kTENPmhbVbfTj5i/ZGnhv4tmI8QZPCNtcegXJrfhRl2D9bWpdTOPrWiLDUqzy1Z6KL7TcOS/PCl8
RHCJXkPau/thTQCpIoDa2+c+3XA++gRTfAQ4svTO260NMIIGFzCCBP+gAwIBAgIKFK5E0wABAABw
3zANBgkqhkiG9w0BAQUFADBWMQswCQYDVQQGEwJVUzEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRp
b24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgM0IwHhcNMTEwNjIy
MDc0NTU3WhcNMTQwNjA2MDc0NTU3WjBFMRkwFwYDVQQDExBSZXNoZXRvdmEsIEVsZW5hMSgwJgYJ
KoZIhvcNAQkBFhllbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAkJBksYl07CDjgHAP6wh1fGfcyo781oAHbErHy7PTDenky7LA1Eh/xFEGSWGT
CgkDw0zIn6ks/P5eFFU/vAkHe0mbMt7vyV9naFDjzbaGXNxob4wHZ7gi1kLSKTUKJ65QDPemIMIl
HL9QUQNAUx/YGLcbJzEc14Oy3e5JFBq9MF3y+PnZNbKHZUHcbET7MTxfyIYCfpZkb7M5qn3w9k4h
V7JRB+9yjYU9YtSzU1Ta3o8qpvr8R5lEnfkX8vuO4UXj6L58Zkh4g6ziOHNp4r7L7LVGU+Wzl2rW
EX5vIeQdAtobnETi8/5MtAM7mE2wP8MN/h53kCZ2DKYDjsMFo36zYwIDAQABo4IC9jCCAvIwCwYD
VR0PBAQDAgeAMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIbDjHWEmeVRg/2BKIWOn1OCkcAJ
Z4HevTmV8EMCAWQCAQgwHQYDVR0OBBYEFJuyxFahPWHR2D/W/zaCv7xOGAKuMB8GA1UdIwQYMBaA
FA7GKvdZsggQkCVvw939imYxMCvFMIHPBgNVHR8EgccwgcQwgcGggb6ggbuGV2h0dHA6Ly93d3cu
aW50ZWwuY29tL3JlcG9zaXRvcnkvQ1JML0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3Vp
bmclMjBDQSUyMDNCKDEpLmNybIZgaHR0cDovL2NlcnRpZmljYXRlcy5pbnRlbC5jb20vcmVwb3Np
dG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwM0IoMSku
Y3JsMIH1BggrBgEFBQcBAQSB6DCB5TBsBggrBgEFBQcwAoZgaHR0cDovL3d3dy5pbnRlbC5jb20v
cmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwM0IoMSkuY3J0MHUGCCsGAQUFBzAChmlodHRwOi8vY2VydGlmaWNhdGVzLmludGVs
LmNvbS9yZXBvc2l0b3J5L2NlcnRpZmljYXRlcy9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJ
c3N1aW5nJTIwQ0ElMjAzQigxKS5jcnQwHwYDVR0lBBgwFgYIKwYBBQUHAwQGCisGAQQBgjcKAwww
KQYJKwYBBAGCNxUKBBwwGjAKBggrBgEFBQcDBDAMBgorBgEEAYI3CgMMME8GA1UdEQRIMEagKQYK
KwYBBAGCNxQCA6AbDBllbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tgRllbGVuYS5yZXNoZXRvdmFA
aW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQCS9KPzLdkyXSfW4t23uCaLiX3KDGl1hLtJeArD
BH8DP3sQXzgCIl7ThVjLOZALz5dkuSVkbnN+zrsTsVzKeJMgjOAkkRbOISPE/OxCi/m8jWGW5STb
tvpmZxReDRWBdlBMM+CBA+6PZivDPEAOeXIy5E5rlh6hvpXSLrllbDVmvF3MvsxKdoa5AKaCJ+Kd
mCQkmS+zuzcoRnZs1jMc1/Sj6GEHhCoCNxxaey7WXTv2o3FNZgp/ey2aocpSQdYmNCl51BRACc7k
xZEPU7/yDYgBgmD+yq6SrDWWO4/3EA40s4NeG7P3uMUFK0c8U00gGAch5mXO76laZ7dQtvfqhC4F
MIIGXjCCBUagAwIBAgIKFK2UbgABAABw3jANBgkqhkiG9w0BAQUFADBWMQswCQYDVQQGEwJVUzEa
MBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2lj
IElzc3VpbmcgQ0EgM0IwHhcNMTEwNjIyMDc0NTEwWhcNMTQwNjA2MDc0NTEwWjBFMRkwFwYDVQQD
ExBSZXNoZXRvdmEsIEVsZW5hMSgwJgYJKoZIhvcNAQkBFhllbGVuYS5yZXNoZXRvdmFAaW50ZWwu
Y29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu1J1LJZazMfHPPgGKE7jqHsih1UY
a1oR82+Mi+ZOlgAnRG71m/pn8nvwjDDHclvFnrsTHVzpym24AxqZs86GQ7qLfx95opPji90dbhRO
82glMVJt0zzVl7RnmB0nRpumK/NWija7/gO95TyrdpYlujGCiuISNKI9tPa7ZWVjvUsaKqeZU0gO
3eiP8NdRHzGKNSw2q2SMpt32sgmUquS1Rnb43JOKsaa0v/hhuhDjFLSIoURJQ75eiH4hm+gKKq6G
ygGXYDTA3O2WIAyAZjv0jJ3kqAq1BiTWu+NjptGmCYMMyyRtkEyesbkLH5nS/fV+VWG5ATJnwHea
qXZtF9O9CQIDAQABo4IDPTCCAzkwCwYDVR0PBAQDAgQwMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQB
gjcVCIbDjHWEmeVRg/2BKIWOn1OCkcAJZ4S52UGHhP9OAgFkAgEMMEQGCSqGSIb3DQEJDwQ3MDUw
DgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNV
HQ4EFgQUdgb4/btn47AP1ZPTlBKvHCCQxWEwHwYDVR0jBBgwFoAUDsYq91myCBCQJW/D3f2KZjEw
K8Uwgc8GA1UdHwSBxzCBxDCBwaCBvqCBu4ZXaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9y
eS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwM0IoMSkuY3Js
hmBodHRwOi8vY2VydGlmaWNhdGVzLmludGVsLmNvbS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4
dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjAzQigxKS5jcmwwgfUGCCsGAQUFBwEBBIHo
MIHlMGwGCCsGAQUFBzAChmBodHRwOi8vd3d3LmludGVsLmNvbS9yZXBvc2l0b3J5L2NlcnRpZmlj
YXRlcy9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjAzQigxKS5jcnQw
dQYIKwYBBQUHMAKGaWh0dHA6Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2Vy
dGlmaWNhdGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDNCKDEp
LmNydDAfBgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGCNwoDBDApBgkrBgEEAYI3FQoEHDAaMAoG
CCsGAQUFBwMEMAwGCisGAQQBgjcKAwQwTwYDVR0RBEgwRqApBgorBgEEAYI3FAIDoBsMGWVsZW5h
LnJlc2hldG92YUBpbnRlbC5jb22BGWVsZW5hLnJlc2hldG92YUBpbnRlbC5jb20wDQYJKoZIhvcN
AQEFBQADggEBAErbqIMGr07dFTHfcifpkF3yklZqYlSi3kJVQLcef8e6SEyurN+9wBZbheJEo/lg
N53Hjmt9hyLHjnsHNQQ1XIGV3SIO0nS6Vf0scWhUyI95cLxDw1zsbNJdRtcF9HgeqDeio8jXuA+c
9HUXIxClFsVwa9w9504bElE8IHGdq+AwAziUZEZaV6v9IaEefZWDO7onthD1Ff1ZyIfc6fnhVmIZ
1hUUty5xfeBXmnulvDEiHNpUnz8XjUF+K4kYQs0hMEwNHjf3wArRDYjbomysBnkrAIZgZGw2S4uU
uLeIu5H0kuLCP5808v8UPke1oCp5v2T91unfvm+IXDSMUXnqLLUxggOGMIIDggIBATBkMFYxCzAJ
BgNVBAYTAlVTMRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0
ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSAzQgIKFK5E0wABAABw3zAJBgUrDgMCGgUAoIIB9zAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMjEwMDgxMjAzMDFaMCMGCSqG
SIb3DQEJBDEWBBS0wX6byvUg9+93VSjXa3hupBhPtzBzBgkrBgEEAYI3EAQxZjBkMFYxCzAJBgNV
BAYTAlVTMRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJu
YWwgQmFzaWMgSXNzdWluZyBDQSAzQgIKFK2UbgABAABw3jB1BgsqhkiG9w0BCRACCzFmoGQwVjEL
MAkGA1UEBhMCVVMxGjAYBgNVBAoTEUludGVsIENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBF
eHRlcm5hbCBCYXNpYyBJc3N1aW5nIENBIDNCAgoUrZRuAAEAAHDeMIGrBgkqhkiG9w0BCQ8xgZ0w
gZowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwDgYI
KoZIhvcNAwICAgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgFAMA0GCCqGSIb3DQMCAgEoMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUA
BIIBABU0evBIWDKIgaEd5+65MGTuXsFA5/agSxtMYZA5/cxrz2rdd3cxLQV4MUSjeeJXK7u1mdSC
PPgc8OM3zg7mVnXsft5t9Ms/3diSYldR0LvKkajwk28jX7ui+qry3PtpcWC+lvnUsw/zn/FBT656
jinZ3OeLxVkYCh4+ZyuiXOAjneoyJlQDmWRJZokR8KAEVBRzqLxC0xcjo3o5DbmV6LbBTnBFZq29
5HYyvqulgt9H3ezDXoBOS72d0q44jdto40lZNvzzoWI86rSB7nnuhj3J8doHUz+f4jbYRcI71Fp/
3d53U3/zhdLIXfbhpkjOknSXqQSRkjwK//ccMdcVjUsAAAAAAAA=

------=_NextPart_000_001E_01CDA566.02C5D820--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
