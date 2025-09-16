Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237F2F83CD
	for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060859; cv=none; b=jLeF5fZ3uzeNzbTxPEbdEUAq6NdcMXVnl19K7PmR2N59YDPLA24/x9/Qdyqx3CU7tFW9uYxd44BxKAADbOmVaYQ3BRx/sAFo+zqkhy0rFLXzlARQnrDySNs/Wyllt7NkQNGjv5/kqK11p4K0FRCVsBSb4Cgmg4QfALVezjCOwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060859; c=relaxed/simple;
	bh=mxWOt/QfOPynu27LGFwEWBMjDUdtN++5Bedij6GpAjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJUHgIETg2vbUxPDW3/JeDMhUBL2sunhTC7Q582hOSuMDKl63VjDODLzuwm6/su642CqQvTYYbQhEjlVoAFEeBt/iHjBqujUGZTIFQigj82O7UenzHRnA/PADCIDFEr+BlaKCYSYxgO/xUevoWJPu1FxvQOeecus6KlwOXZKO/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cHigG6mx; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cHigG6mx"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-76c20428924so50948786d6.0
        for <selinux@vger.kernel.org>; Tue, 16 Sep 2025 15:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060855; x=1758665655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXlP2xfeOwc91rtsroIiOk1xbw0q6aJwxeDjrHWGJ2E=;
        b=cHigG6mxwCQh6avSyio917KxcRVa1uNJgHXtWakCbddMefg2vYSiCDfpg1qKQ8TNR5
         D8EX6r3xVnr92PBTVVdXaxO6DK8jdYhaE1LGoCmqnZZZoeBzUCVhPPcENhiE19pXWFoX
         PkKWmrwjqlZsWbHYepOObHartPlY0xcQAxkFqkbebVS4vOPJ832a2OW8iwyCaIHhVzkZ
         Ly14nP0RxhjeXdh2fhR3O4ZRKUs4aXIQr7gBPc1KqBCHmZBzUQCsTCl0wqDhE7r2537c
         UycfqsPCiFGwcDPBzQGC30FdPtfbrr8sBH5whf1mR5chzRlftlv3Gf3OnAgMN1LArYav
         trfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060855; x=1758665655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXlP2xfeOwc91rtsroIiOk1xbw0q6aJwxeDjrHWGJ2E=;
        b=vRwhynYbGA5Ew31iRRVDA8dBez97IdQdQ2jkukV0qYPXn5eB/pVLOj6grcSBUPyjyS
         4KV2TP7bu7mozU39wsUV6bWriW+GHZsBukug1hkCDbAHTB+YZqqNXJJLi2q3Ecg23htv
         xEjtzyqoqQxU/dBU1l19d8ThaszjCOvpwcsDYnj8cCfDNhmm0Os65CemVXdLEINFRJii
         hKxVNxcBMTn6/PC05OZQ0X5B3wQqeAZd9FQMv9szIMUH/8fN0I12Q/q0e9zM9GRvpbTO
         8ZSbpDQZeyLkN39BddWMfAYwz0rfA9c0AjNimSXL6+NjpF1Gww5tPq6F+r6UK3caRuxx
         DGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdRMmVlrYi57z8a3WLV+cb2KkSwqTbSDIGsuNV4q6O6KA9CRVQ39Z7M7ajmzGxb81w6IJmmA2I@vger.kernel.org
X-Gm-Message-State: AOJu0YybIz+pL2HsBAHrPw78U87IIm6QsMLxk3T6w8Dnkt7YaOU+RxEs
	7YSaBNn9zaILtudNt1X+NvDuwCxWglArASpbXoWa2OoXdAyHblAsHgpDS7iwzuov8Q==
X-Gm-Gg: ASbGncs0ib4LVcabZruS3e4UCVEWmGrOBDqvrU91UlHL7//ts+crNYjU/yk9f6IZqAi
	AzRPspVZsPAwk6TuuCmi/kb7pjclmrNOuX0oig/3pe4dXpfgl8hVHzwMqnep/YQF69hnlPrDKxQ
	9bKvXMbm8cWeNZxqbOGCHNGseoDXE2YN02PJ/O25vHBjoeWO6QQpD3xEdN7iJzeufGOePOdRC3I
	M0ZWw3o2KWz8CMBmoQWp1anMF3u7SrfkHC/GNB50i7W9LNBFTUEJal9RgQMZkuMO84qaERR0IMD
	k8Djn5BdYdTZa027zUBCvCeQAYNfBS0QSxZ+oSrsT5uwhA+jy7/D40JqoXJWzbl1ejdEqOFlDl4
	93qPVuyRs2EUARyz6iB1YYIAUyBhzcc7vT4k7INodBvNcR7DV9fDItxZ+kjFDCNgTj0NU
X-Google-Smtp-Source: AGHT+IGlQb4O56RcZ4ylTBXgCWNuaTwSMFmIebR2dbaChI61VMHDSvMSlxRjrKHoEFne+mEtL+qt4A==
X-Received: by 2002:a05:6214:518e:b0:70d:a712:617e with SMTP id 6a1803df08f44-767c88fa900mr200388196d6.66.1758060854823;
        Tue, 16 Sep 2025 15:14:14 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-78903aec245sm32296966d6.23.2025.09.16.15.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:13 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v4 21/34] lsm: output available LSMs when debugging
Date: Tue, 16 Sep 2025 18:03:48 -0400
Message-ID: <20250916220355.252592-57-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1605; i=paul@paul-moore.com; h=from:subject; bh=mxWOt/QfOPynu27LGFwEWBMjDUdtN++5Bedij6GpAjQ=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8NaXL+K4fUF/H2+19CGhugn2zEze67+0sJb JqKrSmUNTyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfDQAKCRDqIPLalzeJ c/glEAC4NHWsVWv7ikvgcv3hX1kPj7CeduZjh1nnJWB0ZK4OsOxK+uMIHdOfvNmHTNlWrlhaVUt N6RZkQRTpUDlwJ8yvNio58EKkjE6Fe384Nu84/ALe1EJZl54mz5tYUhe9WVvV7FMmKl0FzpLD+t EYV8pCx/KYR1bnor2VxWnY467kCvkzttyauTNe6ZdDQeSCGAOqIZvsITBFk4P51xp0uISr1QciX e/v6dQRd6O+xfOxI2cAApkwBzxwzmWB2x4gHvtnGrvjwXxzKyCy0RIjQKWqrt5m/eGJ9UKkg34q HRdwmSmi69RDdj9xEpyAwDpyw/GwKngNfPZ0OipUxRI3w1B25LEpRPJBLKrcRygUoLXhs276pJk d4LpsbUex3vPWy8aoioVCef/Zgtf15NnEAV0mWAHUNRkNQOeJtKOgO4CBvrrTZ2vXaMOZRjmFIc k3czBF7QcZWC+HwhmiTCrm0rH8kZr6rs3kEBfkTYLknBkUHCAQiqpoKAab56de63mXWfC7ZlkfF 9VNvOb3+Nh3i3Y9zMVIBtOSS1g+AnaXR+Ds5Sexvv6tDFwqlbdEL/KiYEp9JT/nAZEVGLuqJHXZ +A02WKJquMYijGGRIxTUVXXgIwmYnY2g3hS1x1GXLGZHgwhaXPyjVLp9wttefgtMqhkCo/GMFsh aP4SmcQi8iHqGNA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This will display all of the LSMs built into the kernel, regardless
of if they are enabled or not.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2f7ae26fca0f..c6aea57a01e6 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -363,6 +363,8 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
+	/* NOTE: lsm_pr_dbg() doesn't work here as lsm_debug is not yet set */
+
 	lsm_early_for_each_raw(lsm) {
 		lsm_enabled_set(lsm, true);
 		lsm_order_append(lsm, "early");
@@ -385,9 +387,24 @@ int __init security_init(void)
 	struct lsm_info **lsm;
 
 	if (lsm_debug) {
-		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
+		struct lsm_info *i;
+
+		cnt = 0;
+		lsm_pr("available LSMs: ");
+		lsm_early_for_each_raw(i)
+			lsm_pr_cont("%s%s(E)", (cnt++ ? "," : ""), i->id->name);
+		lsm_for_each_raw(i)
+			lsm_pr_cont("%s%s", (cnt++ ? "," : ""), i->id->name);
+		lsm_pr_cont("\n");
+
+		lsm_pr("built-in LSM config: %s\n", lsm_order_builtin);
+
 		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
 		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
+
+		/* see the note about lsm_pr_dbg() in early_security_init() */
+		lsm_early_for_each_raw(i)
+			lsm_pr("enabled LSM early:%s\n", i->id->name);
 	}
 
 	if (lsm_order_cmdline) {
-- 
2.51.0

