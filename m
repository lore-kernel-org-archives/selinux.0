Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9A352030
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 05:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782884902; cv=none; b=XAtA+YdiYLVvO5nMZRY/mcNvjnqwCHRf8R7fH5upUff0/U08m8DA8puoo0WCvt7lPLi4iJaIVfoNy1GH1KNflj0kmDFqBeOQBHXQFP4S5hUrTt1h4HAHIGXcZknuIivpfAS1+PMmVKK4AeYK781oFI2cqXBSyKRYbKjEqk2o2UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782884902; c=relaxed/simple;
	bh=yA1c+0JF9UOhV/Xl3MBhcGiz3Vb5PDYxSqgvBiOfjW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gi4bDS8VIxcs/zMw9UddJeLDS23PH3HaMgY7Hbl+zd6a7s36k3y0A4idXrhPEWMuJlS8Pe77v8YSN+ZKXWyzCv+83gjfL6MHhmLR8b7RZBWxYJZSDAssEE2HMHzUW7LwRN5ARQ6IH6nUDMbmmtS/yPkSWDtBXDP2bYyp8E2MMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VwNUQ5PV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M7oga2xk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwNUQ5PV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7oga2xk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782884900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BK91mNMyJzJGSST7TtRI84EslAmBYoPdq+3G8AAlgvw=;
	b=VwNUQ5PVt3Tsh5YUgySy2Sru0OSpi+KFHr2XMOQbsfx7dz5jhAcGWoDO6OTzj+UyOPwn8g
	XDxmvjKmbLH1fn+/ErtMUUAbsaeWMEGwzGjlDWY9zGczzGqZxVXD/+mpjRzq0lYuO4A6gs
	BZ6jKqdBxtqtw5dHHBwcWaf9ddZIchA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-UXHU2DDDMFaC__-c5H6wDQ-1; Wed, 01 Jul 2026 01:48:17 -0400
X-MC-Unique: UXHU2DDDMFaC__-c5H6wDQ-1
X-Mimecast-MFC-AGG-ID: UXHU2DDDMFaC__-c5H6wDQ_1782884897
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4924725bec9so1985945e9.1
        for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 22:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782884896; x=1783489696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BK91mNMyJzJGSST7TtRI84EslAmBYoPdq+3G8AAlgvw=;
        b=M7oga2xkwDPlD+fbI0wh0Eib2LUJJfW8xN0dA29ZuTv6OzW5ZcfNAkY1sJ1zdQ7lnD
         m0xLIsOrGoVEXf5rugGTT3S30LJrjLk2VmT94vQgF43kqtY1ks8XR7lrQIFgiLnNG7xa
         gOWn7Gm0d5LthJcwtc5hnvnYRyYNxoJ/401Hn+5xhwHzjWMVAZxwk/9Gq3ZbzJWvnxi9
         gySLsgZIUeWOi98s9UiEiynMJlCzOYewDa4uk6cohqRTL0ZrHK76TzVdKHvQRO4r9fzq
         kciF/3cgdKjS9ucSsdszMHOHTDtRwWI0CZwze8nHKTBFr7m5lYfGesDoY/zmYJMnLkNS
         Cfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782884896; x=1783489696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BK91mNMyJzJGSST7TtRI84EslAmBYoPdq+3G8AAlgvw=;
        b=j5KQgCfnBqJ3dHM+iDreTZ1YX2QcJEntiqZwHVcDGkBuyGCuoYTXJNPWqldTBujBjt
         Z+BUqVbWQ/TRtJeQzAgSsdZUV+AMhVxXqFTj1Ks1SNS3dsFwv0qOOiuNw6OQr9ne/oz2
         ayVAFdt/t4vKA5lmJWHisnPE8CLNrMU3ybSRnpjdx5JASut7TUsV9FU492sQ2PrYFIb3
         jV07/GCmdRxSmaLQysDnIv1wZcXHErPIounMgjtSk25am4N3aCNGgS6o5KkSPgkhJa8G
         aSxloY9I0r3z6keAd+FQ8eF82qHxJyL5TXKieDnF0SOdZ2P2kTwMnhKQR3wNrK4ucNaD
         cnvw==
X-Forwarded-Encrypted: i=1; AFNElJ9Zrgi0qruooHSwiJj0Ga+csVzOpQwurbuQfX3aT4pzZ2CNffDagKw6Z+7F67U3FG9GLfcnBOex@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lxZlduc+bmwg2dungyuN/0XZ6lT038zQMXNSU4erHK1ibGUN
	vGdicZfEBKk49SnJmIDGVDqXEG1GrSea3dvPuQ3mGDM/6xZhJv1Ixv5WiRGHUCDfPnXLD95Be8c
	MjHhEFNWlLn/z0jRDhMALnqMfYRg2ow+XM/LfVVlvPKWMvRApwhVjJ42MVlMhusLkydc=
X-Gm-Gg: AfdE7cloqwEHKrmmMQTVXdZHvO+7zY0YP/kve8WMaRBZTyH+h6WoXwpsEI+1Bdr7Ie7
	Oq7ak1UaumN3E4OaeLjTSXLwuQ6/LZCZEl2ZUX1w7XAFiaXlbOKxMqt8T554f+skz/szfLheb33
	evUl9utWO8zZWgmJ7tIztxTiKTrQNAYkj10Hc/owVSByh83oI1sRMGL4WhQrx76B+Iv+C3HrPOT
	fDd5lyity8C/jK0GXPX9wPfr5EQXpStpWYq1CnF5D0sbHP12qA8dpPNTlynTMbFdR6tU13erNxp
	6Av/ElhuuVnJj9hw9Rpz7P48QxhWYk1X5q7dBYNDw/d3FCc1NSwmB0saLRWWmASUyuzB
X-Received: by 2002:a05:600d:8445:20b0:493:2805:ae06 with SMTP id 5b1f17b1804b1-493c2b38e31mr1466825e9.2.1782884896658;
        Tue, 30 Jun 2026 22:48:16 -0700 (PDT)
X-Received: by 2002:a05:600d:8445:20b0:493:2805:ae06 with SMTP id 5b1f17b1804b1-493c2b38e31mr1466575e9.2.1782884896276;
        Tue, 30 Jun 2026 22:48:16 -0700 (PDT)
Received: from fedora ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be81df2asm85299695e9.12.2026.06.30.22.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 22:48:15 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf test amd ibs: avoid using executable heap
Date: Wed,  1 Jul 2026 07:48:07 +0200
Message-ID: <20260701054807.508994-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Making [parts of] the heap executable is dangerous and is blocked by
SELinux on Fedora/RHEL even for an unconfined user. Replace the malloc()
+ mprotect() combo with just mmap(), creating a private anonymous rwx
mapping, which only requires the more commonly allowed "execmem"
permission under SELinux (things like JIT or regex compilation need it
as well). mmap() with MAP_ANONYMOUS will give us a zeroed mapping that
begins on a page boundary, so the result is equivalent to the original
code even without a memset() or the page-alignment dance.

Verified that the test still passes on a machine with an AMD CPU that
has the "ibs" CPU flag.

Fixes: 35db59fa8ea2 ("perf test amd ibs: Add sample period unit test")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tools/perf/arch/x86/tests/amd-ibs-period.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/x86/tests/amd-ibs-period.c b/tools/perf/arch/x86/tests/amd-ibs-period.c
index 6a92b3a23ed7a..b2210b1aa09fb 100644
--- a/tools/perf/arch/x86/tests/amd-ibs-period.c
+++ b/tools/perf/arch/x86/tests/amd-ibs-period.c
@@ -46,7 +46,6 @@ static int dummy_workload_1(unsigned long count)
 {
 	int (*func)(void);
 	int ret = 0;
-	char *p;
 	char insn1[] = {
 		0xb8, 0x01, 0x00, 0x00, 0x00, /* mov 1,%eax */
 		0xc3, /* ret */
@@ -59,18 +58,11 @@ static int dummy_workload_1(unsigned long count)
 		0xcc, /* int 3 */
 	};
 
-	p = calloc(2, page_size);
-	if (!p) {
-		printf("malloc() failed. %m");
-		return 1;
-	}
-
-	func = (void *)((unsigned long)(p + page_size - 1) & ~(page_size - 1));
-
-	ret = mprotect(func, page_size, PROT_READ | PROT_WRITE | PROT_EXEC);
-	if (ret) {
-		printf("mprotect() failed. %m");
-		goto out;
+	func = mmap(NULL, page_size, PROT_READ | PROT_WRITE | PROT_EXEC,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!func) {
+		pr_debug("mmap() failed. %m\n");
+		return -1;
 	}
 
 	if (count < 100000)
@@ -93,7 +85,7 @@ static int dummy_workload_1(unsigned long count)
 	}
 
 out:
-	free(p);
+	munmap(func, page_size);
 	return ret;
 }
 
-- 
2.54.0

