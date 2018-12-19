Return-Path: <SRS0=VZrA=O4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EB1C43387
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 22:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A29E20879
	for <selinux@archiver.kernel.org>; Wed, 19 Dec 2018 22:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbeLSWOJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:14:09 -0500
Received: from mx3.polytechnique.org ([91.121.62.107]:54425 "EHLO
        mx3.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSWOJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Dec 2018 17:14:09 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4823A1E4D29
        for <selinux@vger.kernel.org>; Wed, 19 Dec 2018 23:14:07 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/3] semanage_migrate_store: fix many Python linter warnings
Date:   Wed, 19 Dec 2018 23:13:18 +0100
Message-Id: <20181219221320.8594-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at mx3.polytechnique.org (Wed Dec 19 23:14:07 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

flake8 reports many warnings on script semanage_migrate_store:

    E225 missing whitespace around operator
    E302 expected 2 blank lines, found 1
    E701 multiple statements on one line (colon)
    E703 statement ends with a semicolon
    E722 do not use bare 'except'
    ...

Fix some of them in order to reduce the noise.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
This patch is needed to prepare making scripts/run-flake8 analyze Python
scripts with names that do not end with ".py".

 libsemanage/utils/semanage_migrate_store | 40 +++++++++++++++---------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
index b789d0424541..7b5bee819e24 100755
--- a/libsemanage/utils/semanage_migrate_store
+++ b/libsemanage/utils/semanage_migrate_store
@@ -27,12 +27,13 @@ def copy_file(src, dst):
 		shutil.copy(src, dst)
 	except OSError as the_err:
 		(err, strerr) = the_err.args
-		print("Could not copy %s to %s, %s" %(src, dst, strerr), file=sys.stderr)
+		print("Could not copy %s to %s, %s" % (src, dst, strerr), file=sys.stderr)
 		exit(1)
 
 
 def create_dir(dst, mode):
-	if DEBUG: print("Making directory %s" % dst)
+	if DEBUG:
+		print("Making directory %s" % dst)
 	try:
 		os.makedirs(dst, mode)
 	except OSError as the_err:
@@ -45,7 +46,8 @@ def create_dir(dst, mode):
 
 
 def create_file(dst):
-	if DEBUG: print("Making file %s" % dst)
+	if DEBUG:
+		print("Making file %s" % dst)
 	try:
 		open(dst, 'a').close()
 	except OSError as the_err:
@@ -55,7 +57,8 @@ def create_file(dst):
 
 
 def copy_module(store, name, base):
-	if DEBUG: print("Install module %s" % name)
+	if DEBUG:
+		print("Install module %s" % name)
 	(file, ext) = os.path.splitext(name)
 	if ext != ".pp":
 		# Stray non-pp file in modules directory, skip
@@ -78,24 +81,25 @@ def copy_module(store, name, base):
 		efile.write("pp")
 		efile.close()
 
-	except:
+	except (IOError, OSError):
 		print("Error installing module %s" % name, file=sys.stderr)
 		exit(1)
 
 
 def disable_module(file, name, disabledmodules):
-	if DEBUG: print("Disabling %s" % name)
+	if DEBUG:
+		print("Disabling %s" % name)
 	(disabledname, disabledext) = os.path.splitext(file)
 	create_file("%s/%s" % (disabledmodules, disabledname))
 
-def migrate_store(store):
 
-	oldstore = oldstore_path(store);
-	oldmodules = oldmodules_path(store);
-	disabledmodules = disabledmodules_path(store);
-	newstore = newstore_path(store);
-	newmodules = newmodules_path(store);
-	bottomdir = bottomdir_path(store);
+def migrate_store(store):
+	oldstore = oldstore_path(store)
+	oldmodules = oldmodules_path(store)
+	disabledmodules = disabledmodules_path(store)
+	newstore = newstore_path(store)
+	newmodules = newmodules_path(store)
+	bottomdir = bottomdir_path(store)
 
 	print("Migrating from %s to %s" % (oldstore, newstore))
 
@@ -134,6 +138,7 @@ def migrate_store(store):
 				else:
 					copy_module(store, name, 0)
 
+
 def rebuild_policy():
 	# Ok, the modules are loaded, lets try to rebuild the policy
 	print("Attempting to rebuild policy from %s" % newroot_path())
@@ -182,24 +187,31 @@ def rebuild_policy():
 def oldroot_path():
 	return "%s/etc/selinux" % ROOT
 
+
 def oldstore_path(store):
 	return "%s/%s/modules/active" % (oldroot_path(), store)
 
+
 def oldmodules_path(store):
 	return "%s/modules" % oldstore_path(store)
 
+
 def disabledmodules_path(store):
 	return "%s/disabled" % newmodules_path(store)
 
+
 def newroot_path():
 	return "%s%s" % (ROOT, PATH)
 
+
 def newstore_path(store):
 	return "%s/%s/active" % (newroot_path(), store)
 
+
 def newmodules_path(store):
 	return "%s/modules" % newstore_path(store)
 
+
 def bottomdir_path(store):
 	return "%s/%s" % (newmodules_path(store), PRIORITY)
 
@@ -257,7 +269,6 @@ if __name__ == "__main__":
 		"pkeys.local",
 		"ibendports.local"]
 
-
 	create_dir(newroot_path(), 0o755)
 
 	stores = None
@@ -286,4 +297,3 @@ if __name__ == "__main__":
 
 	if NOREBUILD is False:
 		rebuild_policy()
-
-- 
2.19.1

