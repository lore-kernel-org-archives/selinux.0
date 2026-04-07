Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD3972617
	for <selinux@vger.kernel.org>; Tue,  7 Apr 2026 05:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775540416; cv=none; b=KTSNtt25BuYQ8LomSY/k+OBgRJepXrvrjE3gzO4ZUBntzPNe4HMPr+I/G11gHbUiOuQKNBPn6uEJ7yzVAXlPMplYvLyTnLyHuIxXVLorCv+x9jrA7DM9Kr1j12/s+CG+MP5FJrlpvOvPstnWKsbgizA5HTG/LzIkWRxM7G1kwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775540416; c=relaxed/simple;
	bh=qNsFvmsSJ3WqsJm/a7qedzo2WdZzh1DDGQtzpEzoHMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=UJ+gsgyGK/Ekat2rkGpYZlf3P7GWUPgaHFpIPQdlcHZHKQWWZv3TvuMdoDiW4ok5znPiGFG27vjHtOg9fAt/aAM+bDxqmYe969X+mX7/DumVfA8v79bCOPoiNkOEH0nbonNwlqdaS1lxJKb93VymVMI4mt1gFyihvQtJVXNRfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dB+esQ55; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dB+esQ55"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775540414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QkLHcjyZR9wSljO5Q1Q2TPqybPd/h9zm/9DoV6Pi78g=;
	b=dB+esQ55Iv1ncfhzaCt5palGdSKPPt607TwuuGeEAJMhKhnRnD2ctqGF+X9CbCVaTtiVK4
	MAruyy3AJt4JSfl+1yFHkRiObDLmRgzjpGeRE/rjBEj/ZmjOHNPXPYTVml8irGiS1t8Ovr
	hpQu5d5HWou2a2juMij7B5PCXvmOYSo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-HT3eJ1n4NGSOrby9HXxu6A-1; Tue,
 07 Apr 2026 01:40:12 -0400
X-MC-Unique: HT3eJ1n4NGSOrby9HXxu6A-1
X-Mimecast-MFC-AGG-ID: HT3eJ1n4NGSOrby9HXxu6A_1775540412
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10B4F1800372
	for <selinux@vger.kernel.org>; Tue,  7 Apr 2026 05:40:12 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECCF01800576;
	Tue,  7 Apr 2026 05:40:10 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH 1/2] restorecond: Add -F for run in foreground
Date: Tue,  7 Apr 2026 07:39:49 +0200
Message-ID: <20260407054003.801744-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---
 restorecond/restorecond.8 |  5 ++++-
 restorecond/restorecond.c | 13 ++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/restorecond/restorecond.8 b/restorecond/restorecond.8
index bf8ec87562f8..bb99b24a2d69 100644
--- a/restorecond/restorecond.8
+++ b/restorecond/restorecond.8
@@ -3,7 +3,7 @@
 restorecond \- daemon that watches for file creation and then sets the default SELinux file context
 
 .SH "SYNOPSIS"
-.B restorecond  [\-d] [-h] [\-f restorecond_file ] [\-u] [\-v]
+.B restorecond  [\-d] [-h] [\-f restorecond_file ] [\-F] [\-u] [\-v]
 .P
 
 .SH "DESCRIPTION"
@@ -26,6 +26,9 @@ Print usage statement.
 .B \-f restorecond_file
 Use alternative restorecond.conf file.
 .TP
+.B \-F
+Run in foreground, do not become a daemon.
+.TP
 .B \-u
 Turns on user mode.  Runs restorecond in the user session and reads /etc/selinux/restorecond_user.conf.  Uses dbus to make sure only one restorecond is running per user session.
 .TP
diff --git a/restorecond/restorecond.c b/restorecond/restorecond.c
index d5f70fc2e2c1..36f82ae5e9cb 100644
--- a/restorecond/restorecond.c
+++ b/restorecond/restorecond.c
@@ -76,6 +76,7 @@ int debug_mode = 0;
 int terminate = 0;
 int master_wd = -1;
 int run_as_user = 0;
+int foreground_mode = 0;
 
 static void done(void) {
 	watch_list_free(master_fd);
@@ -124,7 +125,7 @@ static void term_handler(int s __attribute__ ((unused)))
 
 static void usage(char *program)
 {
-	printf("%s [-d] [-f restorecond_file ] [-u] [-v] \n", program);
+	printf("%s [-d] [-f restorecond_file ] [-F] [-n] [-u] [-v] \n", program);
 }
 
 void exitApp(const char *msg)
@@ -165,7 +166,7 @@ int main(int argc, char **argv)
 	sigaction(SIGTERM, &sa, NULL);
 
 	atexit( done );
-	while ((opt = getopt(argc, argv, "hdf:uv")) > 0) {
+	while ((opt = getopt(argc, argv, "hdf:Fuv")) > 0) {
 		switch (opt) {
 		case 'd':
 			debug_mode = 1;
@@ -173,6 +174,9 @@ int main(int argc, char **argv)
 		case 'f':
 			watch_file = optarg;
 			break;
+		case 'F':
+			foreground_mode = 1;
+			break;
 		case 'u':
 			run_as_user = 1;
 			break;
@@ -209,13 +213,12 @@ int main(int argc, char **argv)
 
 	read_config(master_fd, watch_file);
 
-	if (!debug_mode) {
+	if (!debug_mode && !foreground_mode) {
 		if (daemon(0, 0) < 0)
 			exitApp("daemon");
+		write_pid_file();
 	}
 
-	write_pid_file();
-
 	while (watch(master_fd, watch_file) == 0) {
 	}
 
-- 
2.53.0

