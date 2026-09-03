Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABE34B66FC
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445919; cv=none; b=BeeMq+P6OIaRXeRCMVL0yDVicmyp0kncf6oj741Ovl2DvF9CTNPUqmZ0Oth4fGrmcTZT0+LSUh47rzYpOyXsnQArwY8DD24WUB22NNYRG/5eSzX7Z2LUinkjYERXpHyj2pY8Jei81M+60FZXUHaGJPwQY24rL4iqsU7aBGqdkjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445919; c=relaxed/simple;
	bh=UxRT3sN+gL2Kus0WUhzbm2K3Ulm+i/bJ6jf/gAyHmu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BgAuGCdFofEwyPIky8y3b3Z2jWMqJnMgfDcUnR1a8pL7OPXQaur78a6GE9B5ujYf0i8Y5gMli9Z4Y92CybQBmQvvWW3FYDwDYKuBbiWGWBEWo6v6o2XG2JvJA9auOZo6Va/g0rch9uNX9ZatZKqvcfbQqrY4vKyX60MISfsrTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2z8/eq6; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2z8/eq6"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51bfe810293so21797941cf.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788445911; x=1789050711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kKet388h6+qtlZ3+6vt8LY8xXRL75AmqocnzA8sL0p0=;
        b=p2z8/eq6RagTlQYN8zoLeA+d8butpSWyxyhRh/J4+xheZ+yU6ytAQFetVJvAbpfJ4K
         FCetV4cJQHISdIB8D6GD9cAKV9uWBBZkfuQA3p1OdImDxD1YgiS+9LjnUlXUXYGKNGCq
         j5jTWbaWvSCj1cA0qK88Djfk7jHvrYPIF3vi7tZUyOsww9ztRsY7mdxxJF/l8jsKqMMa
         cCQH6V6F0UT71Iv+54ys7NsGEnuxlcUYLG34SCQVEqt4PQFZnnzzYcUbBN5oOEiIpitp
         g0ywCY+Xg8vpZ/tn6/0BGH3+d0jxXVqSUF8OaHclj8qDBzwtQCisM4AiMC6LTT/iDS4/
         ADJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445911; x=1789050711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kKet388h6+qtlZ3+6vt8LY8xXRL75AmqocnzA8sL0p0=;
        b=D3kopjVNibdnyoo7PjOIastkOL8Iq4k3nu3jWBhxRMMMmRi8tnGU5iDlM6NQ8QqCF1
         G3mig/wgvfoFq3rl0q6pZ1lDbsFfS7NFB106fG2jSGOytiwgARgjwxP2LqgalY++CLEH
         BrUpynrafogw6CpMt/mKOHjffYWWxZODBW3+GKfluV3QudgAJy8sVA5LCjwYqRuZ9utB
         zlzdCLfpog/Yh1vKNNHTJyVKK9w+Bz9oLM5VCnPsbpUq4VXrvlfYJANgB+TqDUA+Nu5N
         P91ceH9SHitHJObbQjU3adRrBtFP3r6SwNwxpygBluWPZtLQMW288SUveCVDhlxJZibU
         3sVQ==
X-Gm-Message-State: AFuF++mgIyrA6lWg6p/+UIdDbCVcDPhf9qHcTVF44C8ygXAB4Q6Jb646
	Lf6bA3HrAHFLv+NS79RHS5OPB6EhQpDbhEKTL1wui1/mW3qt4WfiU5PNKPfDqg==
X-Gm-Gg: AYBFou1U80xsisEl7TTTeJTQhwmOdh7HhO1hzATtC5CT2R6ozvb5nkcmOW1Q6Bz7o1f
	8nfrau8NrV9ruLZxYQYm235JENXJsyHTCbVED9OgSa8JimU68qwsHcsJ+miPYi2oJEgzRFj5txP
	/Af/tNDFsaz3sT5wNmemIbq2zl4kCMnWig/a2JG1jrlyGbOqCpig5kM0aURbsedqyl7uc5gyEry
	SEavOcmLEMdAL02PDoId9wlVMtKMm/Ki2WY3CedHDpGFI+48UdEAd5vKyIzoEKjR8rdSlkwlB2s
	JRYOsJZB6zjjWsptPJ9j5EPKfSVDR3WGsbAYUN7Av66yW8YZ3hBN1WKIoIV10HtNYVFvjhUG+rN
	uBhMfaczz7zlX2VqBBsL8KNxwB1a2d/1w6jdFw1fa0vPhkwpdA1Dy8VrImEwFb5HhF6mfzC6PR0
	/4VbHy/XN/NieXrxD3tCpTjX0k+LwbMukKNaT49jEGISyjQRUoD5w/T4iiEG2FEJW+/c/mgL/mp
	d0SQtPu91lAkBCrGCGanIsBw4Jk798bxjANSp1CJXHGMjTuAcVUHr78MA35gDM1sC8ZEanomaE=
X-Received: by 2002:ac8:5e4f:0:b0:51c:2022:cef5 with SMTP id d75a77b69052e-53052462f87mr8609741cf.26.1788445906285;
        Thu, 03 Sep 2026 07:31:46 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530330282bfsm43110841cf.11.2026.09.03.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:31:45 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	cahu@suse.de,
	bigon@debian.org,
	russell@coker.com.au,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 2/4] libselinux: search for the binary policy across configuration roots
Date: Thu,  3 Sep 2026 10:25:59 -0400
Message-ID: <20260903142600.19723-5-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903142600.19723-2-stephen.smalley.work@gmail.com>
References: <20260903142600.19723-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

selinux_mkload_policy() and selinux_current_policy_path() now try each
configuration root at a given policy version before falling back to an
older version. An admin-supplied /etc/selinux/<type>/policy/policy.N
therefore shadows a vendor /usr/lib copy at the same version, but a
newer vendor policy is still preferred over an older admin one - the
same behavior a single-root system already has when the running kernel
supports a higher version than the on-disk policy.

The load_policy loop now records the actual path opened so that later
diagnostics name the file that was used, not the /etc path it was
searched under.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/load_policy.c    | 24 ++++++++++++++++--------
 libselinux/src/selinux_config.c | 25 +++++++++++++------------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index a6ec4a59..a64bde89 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -133,14 +133,22 @@ int selinux_mkload_policy(int preservebools __attribute__((unused)))
 
 	vers = maxvers;
 search:
-	snprintf(path, sizeof(path), "%s.%d", selinux_binary_policy_path(),
-		 vers);
-	fd = open(path, O_RDONLY | O_CLOEXEC);
-	while (fd < 0 && errno == ENOENT && --vers >= minvers) {
-		/* Check prior versions to see if old policy is available */
-		snprintf(path, sizeof(path), "%s.%d",
-			 selinux_binary_policy_path(), vers);
-		fd = open(path, O_RDONLY | O_CLOEXEC);
+	/*
+	 * For each version, try each policy root in turn: an admin-supplied
+	 * /etc copy at version N shadows a vendor /usr/lib copy at the same
+	 * version, but a newer vendor policy still beats an older admin one.
+	 */
+	fd = -1;
+	errno = ENOENT;
+	for (; fd < 0 && errno == ENOENT && vers >= minvers; vers--) {
+		const char *const *roots = selinux_policy_roots();
+		for (; *roots; roots++) {
+			snprintf(path, sizeof(path), "%s/policy/policy.%d",
+				 *roots, vers);
+			fd = open(path, O_RDONLY | O_CLOEXEC);
+			if (fd >= 0 || errno != ENOENT)
+				break;
+		}
 	}
 	if (fd < 0) {
 		selinux_log(
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 199f76e0..ef03eea5 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -368,8 +368,8 @@ const char *selinux_binary_policy_path(void)
 
 const char *selinux_current_policy_path(void)
 {
-	int rc = 0;
-	int vers = 0;
+	int vers;
+	unsigned int i;
 	static char policy_path[PATH_MAX];
 
 	if (selinux_mnt) {
@@ -379,16 +379,17 @@ const char *selinux_current_policy_path(void)
 			return policy_path;
 		}
 	}
-	vers = security_policyvers();
-	do {
-		/* Check prior versions to see if old policy is available */
-		snprintf(policy_path, sizeof(policy_path), "%s.%d",
-			 selinux_binary_policy_path(), vers);
-	} while ((rc = access(policy_path, F_OK)) && --vers > 0);
-
-	if (rc)
-		return NULL;
-	return policy_path;
+	__selinux_once(once, init_selinux_config);
+	for (vers = security_policyvers(); vers > 0; vers--) {
+		for (i = 0; selinux_policyroots[i]; i++) {
+			snprintf(policy_path, sizeof(policy_path),
+				 "%s/policy/policy.%d", selinux_policyroots[i],
+				 vers);
+			if (access(policy_path, F_OK) == 0)
+				return policy_path;
+		}
+	}
+	return NULL;
 }
 
 const char *selinux_file_context_path(void)
-- 
2.55.0

