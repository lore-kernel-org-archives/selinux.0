Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185D9C4332F
	for <selinux@archiver.kernel.org>; Thu, 13 Oct 2022 13:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJMNXu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Oct 2022 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJMNXc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Oct 2022 09:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5C24F1E
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665667410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKsVu5aGnj02CFrkPR2THpY5F8dmpeE8AjakglD/cqI=;
        b=e63Ej9/RsOY59sMTc4q9/g9GE2qXlSpXf2A1+hHN8vN/uNOVwQx/zyErpQqmnmLDWdaiwn
        lQzwycna1j8eeADOdqwk4KoRXOrPX2AZjdLqN/p5ia7k3P0ptk3iBBdbRPRkse6f7NhjZ+
        WeCj/dSxvRsFH5y4TkREAcfrr8aSzsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-bGyAAGx8OM6PLVZIhBUk8w-1; Thu, 13 Oct 2022 09:23:29 -0400
X-MC-Unique: bGyAAGx8OM6PLVZIhBUk8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C70EB811E81
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 13:23:28 +0000 (UTC)
Received: from localhost.localdomain (ovpn-193-3.brq.redhat.com [10.40.193.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3347200D8C3;
        Thu, 13 Oct 2022 13:23:26 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 2/2] sandbox: Use temporary directory for XDG_RUNTIME_DIR
Date:   Thu, 13 Oct 2022 15:23:12 +0200
Message-Id: <20221013132312.294095-2-plautrba@redhat.com>
In-Reply-To: <20221013132312.294095-1-plautrba@redhat.com>
References: <20221013132312.294095-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

XDG_RUNTIME_DIR (/run/user/$UID) is used for user-specific data files
such as sockets, named pipes and so on. Therefore, it should not be
available to sandboxed processes.

Usage:
    # ls -a $XDG_RUNTIME_DIR
    .  ..  bus  pipewire-0  systemd
    # sandbox -R /root/sandbox/user -- sh -c "ls -a $XDG_RUNTIME_DIR"
    .  ..

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 sandbox/sandbox     | 15 ++++++++++++++-
 sandbox/sandbox.8   |  7 +++++--
 sandbox/seunshare.8 |  3 +++
 sandbox/seunshare.c | 45 +++++++++++++++++++++++++++++++++++----------
 4 files changed, 57 insertions(+), 13 deletions(-)

diff --git a/sandbox/sandbox b/sandbox/sandbox
index ffac70232875..770807345858 100644
--- a/sandbox/sandbox
+++ b/sandbox/sandbox
@@ -209,6 +209,7 @@ class Sandbox:
         self.__level = None
         self.__homedir = None
         self.__tmpdir = None
+        self.__runuserdir = None
 
     def __validate_mount(self):
         if self.__options.level:
@@ -357,6 +358,11 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
                           action="callback", callback=self.__validdir,
                           help=_("alternate /tmp directory to use for mounting"))
 
+        parser.add_option("-R", "--runuserdir", dest="runuserdir",
+                          type="string",
+                          action="callback", callback=self.__validdir,
+                          help=_("alternate XDG_RUNTIME_DIR - /run/user/$UID - directory to use for mounting"))
+
         parser.add_option("-w", "--windowsize", dest="windowsize",
                           type="string", default=DEFAULT_WINDOWSIZE,
                           help="size of the sandbox window")
@@ -401,10 +407,12 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
             self.__options.X_ind = True
             self.__homedir = self.__options.homedir
             self.__tmpdir = self.__options.tmpdir
+            self.__runuserdir = self.__options.runuserdir
         else:
             if self.__options.level:
                 self.__homedir = self.__options.homedir
                 self.__tmpdir = self.__options.tmpdir
+                self.__runuserdir = self.__options.runuserdir
 
             if len(cmds) == 0:
                 self.usage(_("Command required"))
@@ -442,9 +450,14 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
             self.__tmpdir = self.__options.tmpdir
         else:
             self.__tmpdir = mkdtemp(dir="/tmp", prefix=".sandbox_tmp_")
+        if self.__options.runuserdir:
+            self.__runuserdir = self.__options.runuserdir
+        else:
+            self.__runuserdir = mkdtemp(dir="/tmp", prefix=".sandbox_runuser_")
         self.__copyfiles()
         selinux.chcon(self.__homedir, self.__filecon, recursive=True)
         selinux.chcon(self.__tmpdir, self.__filecon, recursive=True)
+        selinux.chcon(self.__runuserdir, self.__filecon, recursive=True)
         selinux.setfscreatecon(None)
 
     def __execute(self):
@@ -453,7 +466,7 @@ sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-
             if self.__options.usecaps:
                 cmds.append('-C')
             if self.__mount:
-                cmds += ["-t", self.__tmpdir, "-h", self.__homedir]
+                cmds += ["-t", self.__tmpdir, "-h", self.__homedir, "-r", self.__runuserdir]
 
                 if self.__options.X_ind:
                     if self.__options.dpi:
diff --git a/sandbox/sandbox.8 b/sandbox/sandbox.8
index d83fee76f335..1ee0ecea96d1 100644
--- a/sandbox/sandbox.8
+++ b/sandbox/sandbox.8
@@ -3,11 +3,11 @@
 sandbox \- Run cmd under an SELinux sandbox
 .SH SYNOPSIS
 .B sandbox
-[\-C] [\-s] [ \-d DPI ] [\-l level ] [[\-M | \-X]  \-H homedir \-T tempdir ] [\-I includefile ] [ \-W windowmanager ] [ \-w windowsize ] [[\-i file ]...] [ \-t type ] cmd
+[\-C] [\-s] [ \-d DPI ] [\-l level ] [[\-M | \-X]  \-H homedir \-T tempdir ] [ \-R runuserdir ] [\-I includefile ] [ \-W windowmanager ] [ \-w windowsize ] [[\-i file ]...] [ \-t type ] cmd
 
 .br
 .B sandbox
-[\-C] [\-s] [ \-d DPI ] [\-l level ] [[\-M | \-X]  \-H homedir \-T tempdir ] [\-I includefile ] [ \-W windowmanager ] [ \-w windowsize ] [[\-i file ]...] [ \-t type ] \-S
+[\-C] [\-s] [ \-d DPI ] [\-l level ] [[\-M | \-X]  \-H homedir \-T tempdir ] [ \-R runuserdir ] [\-I includefile ] [ \-W windowmanager ] [ \-w windowsize ] [[\-i file ]...] [ \-t type ] \-S
 .br
 .SH DESCRIPTION
 .PP
@@ -67,6 +67,9 @@ sandbox_net_client_t	\-	All network ports
 \fB\-T\fR \fB\-\-tmpdir\fR
 Use alternate temporary directory to mount on /tmp.  Defaults to tmpfs. Requires \-X or \-M.
 .TP
+\fB\-R\fR \fB\-\-runuserdir\fR
+Use alternate temporary directory to mount on XDG_RUNTIME_DIR (/run/user/$UID).
+.TP
 \fB\-S\fR \fB\-\-session\fR
 Run a full desktop session, Requires level, and home and tmpdir.
 .TP
diff --git a/sandbox/seunshare.8 b/sandbox/seunshare.8
index 0da352613485..09cf7feae45d 100644
--- a/sandbox/seunshare.8
+++ b/sandbox/seunshare.8
@@ -18,6 +18,9 @@ Alternate homedir to be used by the application.  Homedir must be owned by the u
 \fB\-t\ tmpdir
 Use alternate temporary directory to mount on /tmp.  tmpdir must be owned by the user.
 .TP
+\fB\-r\ runuserdir
+Use alternate temporary directory to mount on XDG_RUNTIME_DIR (/run/user/$UID). runuserdir must be owned by the user.
+.TP
 \fB\-C --capabilities\fR
 Allow apps executed within the namespace to use capabilities.  Default is no capabilities.
 .TP
diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index dd1d7ddbdc89..1d38ea92b9ae 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -52,7 +52,7 @@
 
 #define BUF_SIZE 1024
 #define DEFAULT_PATH "/usr/bin:/bin"
-#define USAGE_STRING _("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] [ -Z CONTEXT ] -- executable [args] ")
+#define USAGE_STRING _("USAGE: seunshare [ -v ] [ -C ] [ -k ] [ -t tmpdir ] [ -h homedir ] [ -r runuserdir ] [ -Z CONTEXT ] -- executable [args] ")
 
 static int verbose = 0;
 static int child = 0;
@@ -623,15 +623,20 @@ int main(int argc, char **argv) {
 	char *homedir_s = NULL;	/* homedir spec'd by user in argv[] */
 	char *tmpdir_s = NULL;	/* tmpdir spec'd by user in argv[] */
 	char *tmpdir_r = NULL;	/* tmpdir created by seunshare */
+	char *runuserdir_s = NULL;	/* /var/run/user/UID spec'd by user in argv[] */
+	char *runuserdir_r = NULL;	/* /var/run/user/UID created by seunshare */
 
 	struct stat st_curhomedir;
 	struct stat st_homedir;
 	struct stat st_tmpdir_s;
 	struct stat st_tmpdir_r;
+	struct stat st_runuserdir_s;
+	struct stat st_runuserdir_r;
 
 	const struct option long_options[] = {
 		{"homedir", 1, 0, 'h'},
 		{"tmpdir", 1, 0, 't'},
+		{"runuserdir", 1, 0, 'r'},
 		{"kill", 1, 0, 'k'},
 		{"verbose", 1, 0, 'v'},
 		{"context", 1, 0, 'Z'},
@@ -665,7 +670,7 @@ int main(int argc, char **argv) {
 	}
 
 	while (1) {
-		clflag = getopt_long(argc, argv, "Ccvh:t:Z:", long_options, NULL);
+		clflag = getopt_long(argc, argv, "Ccvh:r:t:Z:", long_options, NULL);
 		if (clflag == -1)
 			break;
 
@@ -679,6 +684,9 @@ int main(int argc, char **argv) {
 		case 'h':
 			homedir_s = optarg;
 			break;
+		case 'r':
+			runuserdir_s = optarg;
+			break;
 		case 'v':
 			verbose++;
 			break;
@@ -729,6 +737,10 @@ int main(int argc, char **argv) {
 	if (tmpdir_s && (
 		verify_directory(tmpdir_s, NULL, &st_tmpdir_s) < 0 ||
 		check_owner_uid(uid, tmpdir_s, &st_tmpdir_s))) return -1;
+	if (runuserdir_s && (
+		verify_directory(runuserdir_s, NULL, &st_runuserdir_s) < 0 ||
+		check_owner_uid(uid, runuserdir_s, &st_runuserdir_s))) return -1;
+
 	if ((uid_t)setfsuid(0) != uid) return -1;
 
 	/* create runtime tmpdir */
@@ -737,6 +749,12 @@ int main(int argc, char **argv) {
 		fprintf(stderr, _("Failed to create runtime temporary directory\n"));
 		return -1;
 	}
+	/* create runtime runuserdir */
+	if (runuserdir_s && (runuserdir_r = create_tmpdir(runuserdir_s, &st_runuserdir_s,
+						  &st_runuserdir_r, pwd, execcon)) == NULL) {
+		fprintf(stderr, _("Failed to create runtime $XDG_RUNTIME_DIR directory\n"));
+		return -1;
+	}
 
 	/* spawn child process */
 	child = fork();
@@ -775,7 +793,21 @@ int main(int argc, char **argv) {
 		if (check_owner_uid(uid, resolved_path, &st_curhomedir) < 0)
 			goto childerr;
 
-		/* mount homedir and tmpdir, in this order */
+		if ((RUNTIME_DIR = getenv("XDG_RUNTIME_DIR")) != NULL) {
+			if ((RUNTIME_DIR = strdup(RUNTIME_DIR)) == NULL) {
+				perror(_("Out of memory"));
+				goto childerr;
+			}
+		} else {
+			if (asprintf(&RUNTIME_DIR, "/run/user/%d", uid) == -1) {
+				perror(_("Out of memory\n"));
+				goto childerr;
+			}
+		}
+
+		/* mount homedir, runuserdir and tmpdir, in this order */
+		if (runuserdir_s &&	seunshare_mount(runuserdir_s, RUNTIME_DIR,
+			&st_runuserdir_s) != 0) goto childerr;
 		if (homedir_s && seunshare_mount(homedir_s, resolved_path,
 			&st_homedir) != 0) goto childerr;
 		if (tmpdir_s &&	seunshare_mount(tmpdir_r, "/tmp",
@@ -799,13 +831,6 @@ int main(int argc, char **argv) {
 			}
 		}
 
-		if ((RUNTIME_DIR = getenv("XDG_RUNTIME_DIR")) != NULL) {
-			if ((RUNTIME_DIR = strdup(RUNTIME_DIR)) == NULL) {
-				perror(_("Out of memory"));
-				goto childerr;
-			}
-		}
-
 		if ((rc = clearenv()) != 0) {
 			perror(_("Failed to clear environment"));
 			goto childerr;
-- 
2.37.3

