Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E33264DD
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680147; cv=none; b=W161sAW9qKn/D5w14wYy71B88QLghCCxVAtP/XK9A/apjepHmn5mC4/D3nfxo0Js4XoT/MKIcMYybKREiYES63IQZBX5IhLbxEMTWFCD5b6pjbOtfyb5mbMJMe8PCrIFPmzPbcX2E68MV9ZQc/CUZ1tu6TlNzshyZezvNFr351U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680147; c=relaxed/simple;
	bh=2btxb2lGBhZARE2ueNhGgzbmX8RVY6jOrTab+4ztxv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfAc9KK+yIjnZAIjZzK07m9fOACQtt03TZdeEJT88QBulzlWOU6KPFzKEtz4Jsp+ZZmj7yKn24B41ZwgHGt6jSqn+QlYlq891NMivov7fF1KzEMyusAIDoGHyLek/q2iUKHkUjOG9HhNEBkXeKFPK3K2YC5+2b6cydnQMpos8Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=VpICsmwX; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="VpICsmwX"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780680144;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGD6GshZehob2+psjx0npzSM5fZwbSRmdOPuPeJVmD0=;
	b=VpICsmwXpbJt2EM1M7nziJ/SV0Xe7m/SKRvvUBbOKJ8JfeL2S+6epwkY5wbobBah4pBXHZ
	eENorcdFNYI8dWrxqtGqxqpOPzwldWpAsOFBggftaPi6pgtUc8egYKr1aWlwXmqjx4M6bV
	m4HODRU969kLDcS8ldaN/BhR4FIAXtJ+B3QiaxWdyfzM1Pr5AIjy7lcqqP1EUmwqCP0LYV
	XG9e6o5tME5oJiC7HsHIb/pug9sPL+mvWgzZ/3xRoyKYR0Ygqc6nnpEVZIdhIDwAOU52gA
	kZbFSJYMO84HpHFwKDGptOZcLp4GgdRLiS2DXoL0gUEa0vJApDTptLDBvrqgMg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 04/11] policycoreutils: declare local variables static
Date: Fri,  5 Jun 2026 19:21:59 +0200
Message-ID: <20260605172207.222382-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-1-cgoettsche@seltendoof.de>
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
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

Variables that are only used inside a translation unit can be declared
static.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/hll/pp/pp.c           | 2 +-
 policycoreutils/secon/secon.c         | 2 +-
 policycoreutils/semodule/semodule.c   | 2 +-
 policycoreutils/setfiles/restore.c    | 2 +-
 policycoreutils/setsebool/setsebool.c | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 823e339d..7280a70b 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -30,7 +30,7 @@
 #include <sepol/module_to_cil.h>
 #include <sepol/policydb/module.h>
 
-char *progname;
+static const char *progname;
 
 __attribute__((format(printf, 1, 2))) static void log_err(const char *fmt, ...)
 {
diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.c
index 4f38f6b8..df32c830 100644
--- a/policycoreutils/secon/secon.c
+++ b/policycoreutils/secon/secon.c
@@ -48,7 +48,7 @@ struct context_color_t {
 	char *range_bg;
 };
 
-struct {
+static struct {
 	unsigned int disp_user : 1;
 	unsigned int disp_role : 1;
 	unsigned int disp_type : 1;
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 87a95c86..14e2f201 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -65,7 +65,7 @@ static int priority_set = 0;
 static semanage_handle_t *sh = NULL;
 static char *store;
 static char *store_root;
-int extract_cil = 0;
+static int extract_cil = 0;
 static int checksum = 0;
 
 extern char *optarg;
diff --git a/policycoreutils/setfiles/restore.c b/policycoreutils/setfiles/restore.c
index 38f24326..1e3644f5 100644
--- a/policycoreutils/setfiles/restore.c
+++ b/policycoreutils/setfiles/restore.c
@@ -15,7 +15,7 @@
 #endif
 
 char **exclude_list;
-int exclude_count;
+static int exclude_count;
 
 void restore_init(struct restore_opts *opts)
 {
diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
index 0a7227c5..e019e43b 100644
--- a/policycoreutils/setsebool/setsebool.c
+++ b/policycoreutils/setsebool/setsebool.c
@@ -17,9 +17,9 @@
 #include <semanage/boolean_record.h>
 #include <errno.h>
 
-int permanent = 0;
-int no_reload = 0;
-int verbose = 0;
+static int permanent = 0;
+static int no_reload = 0;
+static int verbose = 0;
 
 int setbool(char **list, size_t start, size_t end);
 
-- 
2.53.0

