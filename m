Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108325949E
	for <selinux@vger.kernel.org>; Mon, 30 Dec 2024 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735567062; cv=none; b=k45XS+SSzhaVcP5eUhB44sk4Xp/2Dn6zKSUIIouULdgCCjCmYl/EYy9qgbN9oL5f4fPX7bXUwouKrKRNk590JEs/8cJk1Fx7e8GLSiR++Jy6OkcAUHM4TYUcLx9G4kwa/uvaoNNV2g0yZYlEQghq/y9DOFXvSCA+w0zThzg5Vak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735567062; c=relaxed/simple;
	bh=7ORmchYkXlxdGfzbkr4UhxWF+lrUdqTxhOgmjkM9LNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c3Lxucy2HGHGBgLIKRIx6PD0r2I74Fp64Apuf/H8I0wSc06Envgh/50w883DhCgZevgeLiBUyKnEHqYHZueB5mmPfpQV4dzKIvBYgtwwRBzY4U82cTw/SAj2DwUiMt9QNP1HEkHG5Xj1llVTWJiaAWFGzxmJg+roW2TB7AgjF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=LLPiNd20; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="LLPiNd20"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1735566638;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Iq6luduMJrad+kLJ8pOlf5UfAkNy+dPUTkZtLWgfps8=;
	b=LLPiNd202EDe2KlhxCxh+VbN/wQuXpmrNcrtz7LpjxqVVdt3UmRQSYtsVSrr/wD9A+C9Ew
	ldTq3nNCfjkyl6Dz809PCDkrSF+I48vmYlqG4UKsK+RRBvVX23S0lgMW0McMTTD6i8Fs5h
	bfo5yUbInuv7LV5Dfmli1oX8f6+GiOiz8cniwAgBGrR/mN4MHkd4zBXgZf6P4cX9xI9F5j
	ZTsltSblZfFlL3QhrKB14C97adcL5JnbnRmOfi4/TRF3WKQfq/PAi9zAEjQms5AqDrmkSi
	cDkaA8TvSD1RXALggDm3PTtLVnnRryyzLE+AmmZvy4n96UCumaKw2iQjTv+mFQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] semanage: improve -e documentation and fix delete operation
Date: Mon, 30 Dec 2024 14:50:33 +0100
Message-ID: <20241230135033.41492-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Improve the documentation around the -e/--equal option for semanage
fcontext.

Add support for entry deletion.

Closes: https://github.com/SELinuxProject/selinux/issues/457
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 python/semanage/semanage            | 15 ++++++++-------
 python/semanage/semanage-fcontext.8 |  6 +++---
 python/semanage/seobject.py         | 13 +++++++++++++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index b269b9fc..ec6fa2dd 100644
--- a/python/semanage/semanage
+++ b/python/semanage/semanage
@@ -54,7 +54,7 @@ usage_login = "semanage login [-h] [-n] [-N] [-S STORE] ["
 usage_login_dict = {' --add': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' --modify': ('-s SEUSER', '-r RANGE', 'LOGIN',), ' --delete': ('LOGIN',), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
 
 usage_fcontext = "semanage fcontext [-h] [-n] [-N] [-S STORE] ["
-usage_fcontext_dict = {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --delete': ('(', '-t TYPE', '-f FTYPE', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --modify': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e EQUAL', ')', 'FILE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), ' --deleteall': ('',)}
+usage_fcontext_dict = {' --add': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e TARGET_PATH', ')', 'FILE_SPEC',), ' --delete': ('(', '-t TYPE', '-f FTYPE', '|', '-e TARGET_PATH', ')', 'FILE_SPEC',), ' --modify': ('(', '-t TYPE', '-f FTYPE', '-r RANGE', '-s SEUSER', '|', '-e TARGET_PATH', ')', 'FILE_SPEC',), ' --list': ('[-C]',), ' --extract': ('',), ' --deleteall': ('',)}
 
 usage_user = "semanage user [-h] [-n] [-N] [-S STORE] ["
 usage_user_dict = {' --add': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', 'SEUSER', ')'), ' --delete': ('SEUSER',), ' --modify': ('(', '-L LEVEL', '-R ROLES', '-r RANGE', '-s SEUSER', 'SEUSER', ')'), ' --list': ('-C',), ' --extract': ('',), ' --deleteall': ('',)}
@@ -306,7 +306,7 @@ def setupLoginParser(subparsers):
 def handleFcontext(args):
     fcontext_args = {'list': [('equal', 'ftype', 'seuser', 'type'), ('')], 'add': [('locallist'), ('type', 'file_spec')], 'modify': [('locallist'), ('type', 'file_spec')], 'delete': [('locallist'), ('file_spec')], 'extract': [('locallist', 'equal', 'ftype', 'seuser', 'type'), ('')], 'deleteall': [('locallist'), ('')]}
     # we can not use mutually for equal because we can define some actions together with equal
-    fcontext_equal_args = {'equal': [('list', 'locallist', 'type', 'ftype', 'seuser', 'deleteall', 'extract'), ()]}
+    fcontext_equal_args = {'equal': [('list', 'locallist', 'type', 'ftype', 'seuser', 'deleteall', 'extract'), ('file_spec')]}
 
     if args.action and args.equal:
         handle_opts(args, fcontext_equal_args, "equal")
@@ -327,7 +327,7 @@ def handleFcontext(args):
             OBJECT.modify(args.file_spec, args.type, args.ftype, args.range, args.seuser)
     if args.action == "delete":
         if args.equal:
-            OBJECT.delete(args.file_spec, args.equal)
+            OBJECT.delete_equal(args.file_spec, args.equal)
         else:
             OBJECT.delete(args.file_spec, args.ftype)
     if args.action == "list":
@@ -355,9 +355,10 @@ def setupFcontextParser(subparsers):
     parser_add_extract(fcontext_action, "fcontext")
     parser_add_deleteall(fcontext_action, "fcontext")
 
-    fcontextParser.add_argument('-e', '--equal', help=_(
-        'Substitute target path with sourcepath when generating default label. This is used with fcontext. Requires source and target \
-path arguments. The context labeling for the target subtree is made equivalent to that defined for the source.'
+    fcontextParser.add_argument('-e', '--equal', metavar='TARGET_PATH' help=_(
+        'Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is used with fcontext. Requires source and target \
+path arguments to be path prefixes and does not support regular expressions. \
+The context labeling for the target subtree is made equivalent to that defined for the source.'
     ))
     fcontextParser.add_argument('-f', '--ftype', default="", choices=["a", "f", "d", "c", "b", "s", "l", "p"], help=_(
         'File Type. This is used with fcontext. Requires a file type as shown in the mode field by ls, e.g. use d to match only \
@@ -368,7 +369,7 @@ If you do not specify a file type, the file type will default to "all files".'
     parser_add_seuser(fcontextParser, "fcontext")
     parser_add_type(fcontextParser, "fcontext")
     parser_add_range(fcontextParser, "fcontext")
-    fcontextParser.add_argument('file_spec', nargs='?', default=None, help=_('Path to be labeled (may be in the form of a Perl compatible regular expression)'))
+    fcontextParser.add_argument('file_spec', nargs='?', default=None, metavar='FILE_SPEC', help=_('Path to be labeled (may be in the form of a Perl compatible regular expression)'))
     fcontextParser.set_defaults(func=handleFcontext)
 
 
diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index 3e327d88..3a96c62f 100644
--- a/python/semanage/semanage-fcontext.8
+++ b/python/semanage/semanage-fcontext.8
@@ -3,7 +3,7 @@
 semanage\-fcontext \- SELinux Policy Management file context tool
 
 .SH "SYNOPSIS"
-.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC | \-\-delete ( \-t TYPE \-f FTYPE | \-e EQUAL ) FILE_SPEC | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e EQUAL ) FILE_SPEC ]
+.B semanage fcontext [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e TARGET_PATH ) FILE_SPEC | \-\-delete ( \-t TYPE \-f FTYPE | \-e TARGET_PATH ) FILE_SPEC | \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify ( \-t TYPE \-f FTYPE \-r RANGE \-s SEUSER | \-e TARGET_PATH ) FILE_SPEC ]
 
 .SH "DESCRIPTION"
 semanage is used to configure certain elements of
@@ -66,8 +66,8 @@ Extract customizable commands, for use within a transaction
 .I   \-D, \-\-deleteall
 Remove all local customizations
 .TP
-.I   \-e EQUAL, \-\-equal EQUAL
-Substitute target path with sourcepath when generating default label. This is used with fcontext. Requires source and target path arguments. The context labeling for the target subtree is made equivalent to that defined for the source.
+.I   \-e TARGET_PATH, \-\-equal TARGET_PATH
+Substitute FILE_SPEC with TARGET_PATH for file label lookup. This is used with fcontext. Requires source and target path arguments to be path prefixes and does not support regular expressions. The context labeling for the target subtree is made equivalent to that defined for the source.
 .TP
 .I   \-f [{a,f,d,c,b,s,l,p}], \-\-ftype [{a,f,d,c,b,s,l,p}]
 File Type. This is used with fcontext. Requires a file type as shown in the mode field by ls, e.g. use 'd' to match only directories or 'f' to match only regular files. The following file type options can be passed: f (regular file),d (directory),c (character device), b (block device),s (socket),l (symbolic link),p (named pipe).  If you do not specify a file type, the file type will default to "all files".
diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
index 10963e81..854381d4 100644
--- a/python/semanage/seobject.py
+++ b/python/semanage/seobject.py
@@ -2453,6 +2453,19 @@ class fcontextRecords(semanageRecords):
 
         self.commit()
 
+    def delete_equal(self, target, substitute):
+        self.begin()
+        if target not in self.equiv.keys():
+            raise ValueError(_("Equivalence class for %s does not exist") % target)
+        if substitute != self.equiv[target]:
+            raise ValueError(_("Equivalence class for %s does not match %s but %s") % (target, substitute, self.equiv[target]))
+        del self.equiv[target]
+        self.equal_ind = True
+
+        self.mylog.log_change("resrc=fcontext op=delete-equal %s %s" % (audit.audit_encode_nv_string("sglob", target, 0), audit.audit_encode_nv_string("tglob", substitute, 0)))
+
+        self.commit()
+
     def createcon(self, target, seuser="system_u"):
         (rc, con) = semanage_context_create(self.sh)
         if rc < 0:
-- 
2.45.2

