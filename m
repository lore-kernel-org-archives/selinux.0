Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1378223242C
	for <selinux@vger.kernel.org>; Tue, 14 Jan 2025 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869963; cv=none; b=tm/bf4hMilhTvwOoiDbFvJaVQ5sypTUGi/DPw2WuKC5MecL9sWrkslXg4bWdLhTFYvg8yT3rYS2Bp1GMkzVHlbHs0j/ZUSxJSasZya14xipFQUTn/TWF+VK3nFN0eHHfsOt7rVy2eOxzusCZHphKc1gzmg4hvVOwNPdq61pD3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869963; c=relaxed/simple;
	bh=6/TZEXurcrLeu+ybqLbQRsUbTJ03VME25vy+Siu/2Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1d/lYe/bmvG1V6hBgUjsiHOhdXD418Xe4JJO/HDRqAmUTCIXSNHSgybG3jo/rs1L8DrFGV+E6lTXjS69NNd7DQt90Gywq/lOq6fvKzYOaxFS3jrRiau8+H0YquvBHCrkSm8wGGmqMWCbzaG1wj+u7pd77T75+RnbWA5ccVnafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=GOUMmNqG; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="GOUMmNqG"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736869952;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JwHyEQFJQzk47NB+mwyOZQkUGmaUVW5TA/pUB68oAvY=;
	b=GOUMmNqGyyE3dvwF+4DXv/KGA3e98w/u2Z5Eg9bEV/nv0V5rx+n0fvrEHJjMihdOngdaAZ
	8w3SkHsm/YzVq6SMfqT61CDlvKPjG8qqbcYsw9rUxZsdjngAoGTn7aL8G14z7vpDw3G2sv
	glLNRa1f3LlyIIFVwK5Y7v6ktj6lgSKHTszz8s7GO9XOAqVYsYCOUNBnRCDeqAV25bOhVh
	LX9urOPWvjxfY8EzKrfcvk1a1GmLnDVq044KsGf+xE/V2R7xfSF023KnvTcSJghkOmORro
	IEJcZXDdAIN5UdziFs+kmZiCR1ILyYBGdzykPl8wi9zQZqbALGmD6Pkt9mu3VA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2] semanage: improve -e documentation and fix delete operation
Date: Tue, 14 Jan 2025 16:52:28 +0100
Message-ID: <20250114155228.72450-1-cgoettsche@seltendoof.de>
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

Closes: https://github.com/SELinuxProject/selinux/issues/457
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: drop delete_equal() addition
---
 python/semanage/semanage            | 13 +++++++------
 python/semanage/semanage-fcontext.8 |  6 +++---
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/python/semanage/semanage b/python/semanage/semanage
index b269b9fc..dd5066bf 100644
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
-- 
2.47.1

