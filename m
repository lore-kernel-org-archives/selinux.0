Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DBDC43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 22:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43EAC20874
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 22:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeLSWON (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:14:13 -0500
Received: from mx3.polytechnique.org ([91.121.62.107]:46771 "EHLO
        mx3.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbeLSWOM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Dec 2018 17:14:12 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 569851E4D24
        for <selinux@vger.kernel.org>; Wed, 19 Dec 2018 23:14:10 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] semanage_migrate_store: switch to space indentation
Date:   Wed, 19 Dec 2018 23:13:20 +0100
Message-Id: <20181219221320.8594-3-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181219221320.8594-1-nicolas.iooss@m4x.org>
References: <20181219221320.8594-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at mx3.polytechnique.org (Wed Dec 19 23:14:10 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The script used both tabs and space to indent the code, using a tab
length of 8 (in calls to parser.add_option(...)). Make the code more
readable by using spaces for indentation everywhere.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/utils/semanage_migrate_store | 438 +++++++++++------------
 1 file changed, 219 insertions(+), 219 deletions(-)

diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index 360f143e9fca..018b1a3e62c2 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -10,287 +10,287 @@ from optparse import OptionParser
 
 
 try:
-	import selinux
-	import semanage
+    import selinux
+    import semanage
 except ImportError:
-	print("You must install libselinux-python and libsemanage-python before running this tool", file=sys.stderr)
-	exit(1)
+    print("You must install libselinux-python and libsemanage-python before running this tool", file=sys.stderr)
+    exit(1)
 
 
 def copy_file(src, dst):
-	if DEBUG:
-		print("copying %s to %s" % (src, dst))
-	try:
-		shutil.copy(src, dst)
-	except OSError as the_err:
-		(err, strerr) = the_err.args
-		print("Could not copy %s to %s, %s" % (src, dst, strerr), file=sys.stderr)
-		exit(1)
+    if DEBUG:
+        print("copying %s to %s" % (src, dst))
+    try:
+        shutil.copy(src, dst)
+    except OSError as the_err:
+        (err, strerr) = the_err.args
+        print("Could not copy %s to %s, %s" % (src, dst, strerr), file=sys.stderr)
+        exit(1)
 
 
 def create_dir(dst, mode):
-	if DEBUG:
-		print("Making directory %s" % dst)
-	try:
-		os.makedirs(dst, mode)
-	except OSError as the_err:
-		(err, stderr) = the_err.args
-		if err == errno.EEXIST:
-			pass
-		else:
-			print("Error creating %s" % dst, file=sys.stderr)
-			exit(1)
+    if DEBUG:
+        print("Making directory %s" % dst)
+    try:
+        os.makedirs(dst, mode)
+    except OSError as the_err:
+        (err, stderr) = the_err.args
+        if err == errno.EEXIST:
+            pass
+        else:
+            print("Error creating %s" % dst, file=sys.stderr)
+            exit(1)
 
 
 def create_file(dst):
-	if DEBUG:
-		print("Making file %s" % dst)
-	try:
-		open(dst, 'a').close()
-	except OSError as the_err:
-		(err, stderr) = the_err.args
-		print("Error creating %s" % dst, file=sys.stderr)
-		exit(1)
+    if DEBUG:
+        print("Making file %s" % dst)
+    try:
+        open(dst, 'a').close()
+    except OSError as the_err:
+        (err, stderr) = the_err.args
+        print("Error creating %s" % dst, file=sys.stderr)
+        exit(1)
 
 
 def copy_module(store, name, base):
-	if DEBUG:
-		print("Install module %s" % name)
-	(file, ext) = os.path.splitext(name)
-	if ext != ".pp":
-		# Stray non-pp file in modules directory, skip
-		print("warning: %s has invalid extension, skipping" % name, file=sys.stderr)
-		return
-	try:
-		if base:
-			root = oldstore_path(store)
-		else:
-			root = oldmodules_path(store)
+    if DEBUG:
+        print("Install module %s" % name)
+    (file, ext) = os.path.splitext(name)
+    if ext != ".pp":
+        # Stray non-pp file in modules directory, skip
+        print("warning: %s has invalid extension, skipping" % name, file=sys.stderr)
+        return
+    try:
+        if base:
+            root = oldstore_path(store)
+        else:
+            root = oldmodules_path(store)
 
-		bottomdir = bottomdir_path(store)
+        bottomdir = bottomdir_path(store)
 
-		os.mkdir("%s/%s" % (bottomdir, file))
+        os.mkdir("%s/%s" % (bottomdir, file))
 
-		copy_file(os.path.join(root, name), "%s/%s/hll" % (bottomdir, file))
+        copy_file(os.path.join(root, name), "%s/%s/hll" % (bottomdir, file))
 
-		# This is the ext file that will eventually be used to choose a compiler
-		efile = open("%s/%s/lang_ext" % (bottomdir, file), "w+", 0o600)
-		efile.write("pp")
-		efile.close()
+        # This is the ext file that will eventually be used to choose a compiler
+        efile = open("%s/%s/lang_ext" % (bottomdir, file), "w+", 0o600)
+        efile.write("pp")
+        efile.close()
 
-	except (IOError, OSError):
-		print("Error installing module %s" % name, file=sys.stderr)
-		exit(1)
+    except (IOError, OSError):
+        print("Error installing module %s" % name, file=sys.stderr)
+        exit(1)
 
 
 def disable_module(file, name, disabledmodules):
-	if DEBUG:
-		print("Disabling %s" % name)
-	(disabledname, disabledext) = os.path.splitext(file)
-	create_file("%s/%s" % (disabledmodules, disabledname))
+    if DEBUG:
+        print("Disabling %s" % name)
+    (disabledname, disabledext) = os.path.splitext(file)
+    create_file("%s/%s" % (disabledmodules, disabledname))
 
 
 def migrate_store(store):
-	oldstore = oldstore_path(store)
-	oldmodules = oldmodules_path(store)
-	disabledmodules = disabledmodules_path(store)
-	newstore = newstore_path(store)
-	newmodules = newmodules_path(store)
-	bottomdir = bottomdir_path(store)
-
-	print("Migrating from %s to %s" % (oldstore, newstore))
-
-	# Build up new directory structure
-	create_dir("%s/%s" % (newroot_path(), store), 0o755)
-	create_dir(newstore, 0o700)
-	create_dir(newmodules, 0o700)
-	create_dir(bottomdir, 0o700)
-	create_dir(disabledmodules, 0o700)
-
-	# Special case for base since it was in a different location
-	copy_module(store, "base.pp", 1)
-
-	# Dir structure built, start copying files
-	for root, dirs, files in os.walk(oldstore):
-		if root == oldstore:
-			# This is the top level directory, need to move
-			for name in files:
-				# Check to see if it is in TOPPATHS and copy if so
-				if name in TOPPATHS:
-					if name == "seusers":
-						newname = "seusers.local"
-					else:
-						newname = name
-					copy_file(os.path.join(root, name), os.path.join(newstore, newname))
-
-		elif root == oldmodules:
-			# This should be the modules directory
-			for name in files:
-				(file, ext) = os.path.splitext(name)
-				if name == "base.pp":
-					print("Error installing module %s, name conflicts with base" % name, file=sys.stderr)
-					exit(1)
-				elif ext == ".disabled":
-					disable_module(file, name, disabledmodules)
-				else:
-					copy_module(store, name, 0)
+    oldstore = oldstore_path(store)
+    oldmodules = oldmodules_path(store)
+    disabledmodules = disabledmodules_path(store)
+    newstore = newstore_path(store)
+    newmodules = newmodules_path(store)
+    bottomdir = bottomdir_path(store)
+
+    print("Migrating from %s to %s" % (oldstore, newstore))
+
+    # Build up new directory structure
+    create_dir("%s/%s" % (newroot_path(), store), 0o755)
+    create_dir(newstore, 0o700)
+    create_dir(newmodules, 0o700)
+    create_dir(bottomdir, 0o700)
+    create_dir(disabledmodules, 0o700)
+
+    # Special case for base since it was in a different location
+    copy_module(store, "base.pp", 1)
+
+    # Dir structure built, start copying files
+    for root, dirs, files in os.walk(oldstore):
+        if root == oldstore:
+            # This is the top level directory, need to move
+            for name in files:
+                # Check to see if it is in TOPPATHS and copy if so
+                if name in TOPPATHS:
+                    if name == "seusers":
+                        newname = "seusers.local"
+                    else:
+                        newname = name
+                    copy_file(os.path.join(root, name), os.path.join(newstore, newname))
+
+        elif root == oldmodules:
+            # This should be the modules directory
+            for name in files:
+                (file, ext) = os.path.splitext(name)
+                if name == "base.pp":
+                    print("Error installing module %s, name conflicts with base" % name, file=sys.stderr)
+                    exit(1)
+                elif ext == ".disabled":
+                    disable_module(file, name, disabledmodules)
+                else:
+                    copy_module(store, name, 0)
 
 
 def rebuild_policy():
-	# Ok, the modules are loaded, lets try to rebuild the policy
-	print("Attempting to rebuild policy from %s" % newroot_path())
+    # Ok, the modules are loaded, lets try to rebuild the policy
+    print("Attempting to rebuild policy from %s" % newroot_path())
 
-	curstore = selinux.selinux_getpolicytype()[1]
+    curstore = selinux.selinux_getpolicytype()[1]
 
-	handle = semanage.semanage_handle_create()
-	if not handle:
-		print("Could not create semanage handle", file=sys.stderr)
-		exit(1)
+    handle = semanage.semanage_handle_create()
+    if not handle:
+        print("Could not create semanage handle", file=sys.stderr)
+        exit(1)
 
-	semanage.semanage_select_store(handle, curstore, semanage.SEMANAGE_CON_DIRECT)
+    semanage.semanage_select_store(handle, curstore, semanage.SEMANAGE_CON_DIRECT)
 
-	if not semanage.semanage_is_managed(handle):
-		semanage.semanage_handle_destroy(handle)
-		print("SELinux policy is not managed or store cannot be accessed.", file=sys.stderr)
-		exit(1)
+    if not semanage.semanage_is_managed(handle):
+        semanage.semanage_handle_destroy(handle)
+        print("SELinux policy is not managed or store cannot be accessed.", file=sys.stderr)
+        exit(1)
 
-	rc = semanage.semanage_access_check(handle)
-	if rc < semanage.SEMANAGE_CAN_WRITE:
-		semanage.semanage_handle_destroy(handle)
-		print("Cannot write to policy store.", file=sys.stderr)
-		exit(1)
+    rc = semanage.semanage_access_check(handle)
+    if rc < semanage.SEMANAGE_CAN_WRITE:
+        semanage.semanage_handle_destroy(handle)
+        print("Cannot write to policy store.", file=sys.stderr)
+        exit(1)
 
-	rc = semanage.semanage_connect(handle)
-	if rc < 0:
-		semanage.semanage_handle_destroy(handle)
-		print("Could not establish semanage connection", file=sys.stderr)
-		exit(1)
+    rc = semanage.semanage_connect(handle)
+    if rc < 0:
+        semanage.semanage_handle_destroy(handle)
+        print("Could not establish semanage connection", file=sys.stderr)
+        exit(1)
 
-	semanage.semanage_set_rebuild(handle, 1)
+    semanage.semanage_set_rebuild(handle, 1)
 
-	rc = semanage.semanage_begin_transaction(handle)
-	if rc < 0:
-		semanage.semanage_handle_destroy(handle)
-		print("Could not begin transaction", file=sys.stderr)
-		exit(1)
+    rc = semanage.semanage_begin_transaction(handle)
+    if rc < 0:
+        semanage.semanage_handle_destroy(handle)
+        print("Could not begin transaction", file=sys.stderr)
+        exit(1)
 
-	rc = semanage.semanage_commit(handle)
-	if rc < 0:
-		print("Could not commit transaction", file=sys.stderr)
+    rc = semanage.semanage_commit(handle)
+    if rc < 0:
+        print("Could not commit transaction", file=sys.stderr)
 
-	semanage.semanage_handle_destroy(handle)
+    semanage.semanage_handle_destroy(handle)
 
 
 def oldroot_path():
-	return "%s/etc/selinux" % ROOT
+    return "%s/etc/selinux" % ROOT
 
 
 def oldstore_path(store):
-	return "%s/%s/modules/active" % (oldroot_path(), store)
+    return "%s/%s/modules/active" % (oldroot_path(), store)
 
 
 def oldmodules_path(store):
-	return "%s/modules" % oldstore_path(store)
+    return "%s/modules" % oldstore_path(store)
 
 
 def disabledmodules_path(store):
-	return "%s/disabled" % newmodules_path(store)
+    return "%s/disabled" % newmodules_path(store)
 
 
 def newroot_path():
-	return "%s%s" % (ROOT, PATH)
+    return "%s%s" % (ROOT, PATH)
 
 
 def newstore_path(store):
-	return "%s/%s/active" % (newroot_path(), store)
+    return "%s/%s/active" % (newroot_path(), store)
 
 
 def newmodules_path(store):
-	return "%s/modules" % newstore_path(store)
+    return "%s/modules" % newstore_path(store)
 
 
 def bottomdir_path(store):
-	return "%s/%s" % (newmodules_path(store), PRIORITY)
+    return "%s/%s" % (newmodules_path(store), PRIORITY)
 
 
 if __name__ == "__main__":
 
-	parser = OptionParser()
-	parser.add_option("-p", "--priority", dest="priority", default="100",
-			  help="Set priority of modules in new store (default: 100)")
-	parser.add_option("-s", "--store", dest="store", default=None,
-			  help="Store to read from and write to")
-	parser.add_option("-d", "--debug", dest="debug", action="store_true", default=False,
-			  help="Output debug information")
-	parser.add_option("-c", "--clean", dest="clean", action="store_true", default=False,
-			  help="Clean old modules directory after migrate (default: no)")
-	parser.add_option("-n", "--norebuild", dest="norebuild", action="store_true", default=False,
-			  help="Disable rebuilding policy after migration (default: no)")
-	parser.add_option("-P", "--path", dest="path",
-			  help="Set path for the policy store (default: /var/lib/selinux)")
-	parser.add_option("-r", "--root", dest="root",
-			  help="Set an alternative root for the migration (default: /)")
-
-	(options, args) = parser.parse_args()
-
-	DEBUG = options.debug
-	PRIORITY = options.priority
-	TYPE = options.store
-	CLEAN = options.clean
-	NOREBUILD = options.norebuild
-	PATH = options.path
-	if PATH is None:
-		PATH = "/var/lib/selinux"
-
-	ROOT = options.root
-	if ROOT is None:
-		ROOT = ""
-
-	# List of paths that go in the active 'root'
-	TOPPATHS = [
-		"commit_num",
-		"ports.local",
-		"interfaces.local",
-		"nodes.local",
-		"booleans.local",
-		"file_contexts.local",
-		"seusers",
-		"users.local",
-		"users_extra",
-		"users_extra.local",
-		"disable_dontaudit",
-		"preserve_tunables",
-		"policy.kern",
-		"file_contexts",
-		"homedir_template",
-		"pkeys.local",
-		"ibendports.local"]
-
-	create_dir(newroot_path(), 0o755)
-
-	stores = None
-	if TYPE is not None:
-		stores = [TYPE]
-	else:
-		stores = os.listdir(oldroot_path())
-
-	# find stores in oldroot and migrate them to newroot if necessary
-	for store in stores:
-		if not os.path.isdir(oldmodules_path(store)):
-			# already migrated or not an selinux store
-			continue
-
-		if os.path.isdir(newstore_path(store)):
-			# store has already been migrated, but old modules dir still exits
-			print("warning: Policy type %s has already been migrated, but modules still exist in the old store. Skipping store." % store, file=sys.stderr)
-			continue
-
-		migrate_store(store)
-
-		if CLEAN is True:
-			def remove_error(function, path, execinfo):
-				print("warning: Unable to remove old store modules directory %s. Cleaning failed." % oldmodules_path(store), file=sys.stderr)
-			shutil.rmtree(oldmodules_path(store), onerror=remove_error)
-
-	if NOREBUILD is False:
-		rebuild_policy()
+    parser = OptionParser()
+    parser.add_option("-p", "--priority", dest="priority", default="100",
+                      help="Set priority of modules in new store (default: 100)")
+    parser.add_option("-s", "--store", dest="store", default=None,
+                      help="Store to read from and write to")
+    parser.add_option("-d", "--debug", dest="debug", action="store_true", default=False,
+                      help="Output debug information")
+    parser.add_option("-c", "--clean", dest="clean", action="store_true", default=False,
+                      help="Clean old modules directory after migrate (default: no)")
+    parser.add_option("-n", "--norebuild", dest="norebuild", action="store_true", default=False,
+                      help="Disable rebuilding policy after migration (default: no)")
+    parser.add_option("-P", "--path", dest="path",
+                      help="Set path for the policy store (default: /var/lib/selinux)")
+    parser.add_option("-r", "--root", dest="root",
+                      help="Set an alternative root for the migration (default: /)")
+
+    (options, args) = parser.parse_args()
+
+    DEBUG = options.debug
+    PRIORITY = options.priority
+    TYPE = options.store
+    CLEAN = options.clean
+    NOREBUILD = options.norebuild
+    PATH = options.path
+    if PATH is None:
+        PATH = "/var/lib/selinux"
+
+    ROOT = options.root
+    if ROOT is None:
+        ROOT = ""
+
+    # List of paths that go in the active 'root'
+    TOPPATHS = [
+        "commit_num",
+        "ports.local",
+        "interfaces.local",
+        "nodes.local",
+        "booleans.local",
+        "file_contexts.local",
+        "seusers",
+        "users.local",
+        "users_extra",
+        "users_extra.local",
+        "disable_dontaudit",
+        "preserve_tunables",
+        "policy.kern",
+        "file_contexts",
+        "homedir_template",
+        "pkeys.local",
+        "ibendports.local"]
+
+    create_dir(newroot_path(), 0o755)
+
+    stores = None
+    if TYPE is not None:
+        stores = [TYPE]
+    else:
+        stores = os.listdir(oldroot_path())
+
+    # find stores in oldroot and migrate them to newroot if necessary
+    for store in stores:
+        if not os.path.isdir(oldmodules_path(store)):
+            # already migrated or not an selinux store
+            continue
+
+        if os.path.isdir(newstore_path(store)):
+            # store has already been migrated, but old modules dir still exits
+            print("warning: Policy type %s has already been migrated, but modules still exist in the old store. Skipping store." % store, file=sys.stderr)
+            continue
+
+        migrate_store(store)
+
+        if CLEAN is True:
+            def remove_error(function, path, execinfo):
+                print("warning: Unable to remove old store modules directory %s. Cleaning failed." % oldmodules_path(store), file=sys.stderr)
+            shutil.rmtree(oldmodules_path(store), onerror=remove_error)
+
+    if NOREBUILD is False:
+        rebuild_policy()
-- 
2.19.1

