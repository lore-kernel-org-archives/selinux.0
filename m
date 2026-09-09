Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C406F5678D8
	for <selinux@vger.kernel.org>; Wed,  9 Sep 2026 14:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962417; cv=none; b=JJyWGZSZJ7M8MSfLdSSdmxtL2XR5uPxBcpZ+qQkug0jx+c5lUTg7xzJVcihyCfq+rMR5/CjuSQujwReCNAmtk+0Jz4bRTFJUHcT9DW3Zizfdg+2/CjsaKZYZCQZx22LlSrcjsFypVY7VB4c/FSVEgPCVx69xHzqCUAIzEuu8epU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962417; c=relaxed/simple;
	bh=/JCunUKT7SIZWZXDrjUzmS7zVvsFjGrkUIOjIcnnOow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNiE6Ft/mtsXBxOi9zVtWGzJOmNPw3kdioVFZeNyaHFnnYsrjA9XjKyQzAiiLaPrevJ8vYBFi6Hak8rJ2ft20G0XuAjNoUaHKg/TMygD8kDCC9qBJeiTNC1RLXUrCzEmfXvXT1Y/v76oxSB5ud0IeM72N3rZqgQsMq3drFXvWvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxdBMfYX; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxdBMfYX"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-86c0e4dd49cso76299777b3.3
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2026 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788962415; x=1789567215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wSpGFth7dJMu64AIVpd7w7rlAothUfpOs/+CNj+UQro=;
        b=SxdBMfYXwKPGgF0GcRuVqB8tplzuny0KlbzEAbegxljVpYrY/mhkoz5lR9cEF90PbM
         8y1lDtsQXbfZAdQc6omQfBXcqzCzWQiStHH3eeUszm59ME4LYYKS963moctqGotq32YT
         xOL0Y1+mpf+FOc6t2IOltm+kcVspswPGI9S716R7KnsOvVlA7hlNXZ6KQRsm3LZSCQsQ
         wU2xa/uykA0Q8qrPmnvNk6pvv9qR2A1WibgGx2om61pp337D8rCD56mYIiwNoSbRW+8x
         nhu0Y0QW7QyZrP4Kb5DJB6mCqgg2Koj3awwFokJ65s+lchtnpoUGzJQMDtMSIVb1NqKY
         RY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788962415; x=1789567215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wSpGFth7dJMu64AIVpd7w7rlAothUfpOs/+CNj+UQro=;
        b=PU//LcbDZ+CDQn3bYdSyoxR/TDmQTTG1jQ/+VJKKBYOcUv/Z0pUPvESIiGJICHRrQg
         nXWPk7Wo8La8Mpk9D5GgvN1EOHrR+uDZF5XvpGA5dKuudnWzsr06zGaeYaLgsvRoEF1N
         DSuNQJ285A8cnJ12e8qP4D14MwB3bldDOuKmhsmkQz4H/fGOs2O0zGZG2LXqZBhSf527
         QIqFIGmByoMy8f6Rt9cYUqXufQsVBbobg5/BKjz/Dlw7P2zjgCFpWjhcmsZCv0XthQJN
         4gXhJSHaU91HGo4AH0oIYgp/2se/lYSyPb9cajjVySe1oUTTV9lbZMKPxukiRO12DDCP
         60sA==
X-Gm-Message-State: AFuF++nk9d6dOQ+p3CecsGn4pRS7qh/W5fAgj29fnoCN2orS6HwdpOPj
	emRsM+vxnXfECckhhm8tOUQ3kkFW0GKLLT1wguEBAsrYyFwvp3wuxScmI8zkwg==
X-Gm-Gg: AYBFou3qg3cC4lDGRErRUYiae4zCBAnlhYcNXDCtgc+bWX2nNo7MGxEexDHajIhSbKI
	VuIUx5shTt8/gj+el6vVLXwipeTPbd0WaNy+4GitK13yZF4X0/CZupsHZjK/arsi1zf/mF6vrFq
	kgqCFZa52+f3lq1T9SOUwHubp2HmUz7kkAuvAq+fxM+QcT2EtudhE5Dtr0V8prO02WNn1jxvKVz
	NcWfzn8DF7mTDi+CPfDzKUoFmUjXlbybsbzpnR7M6aadDhfT0mzlcxTRHHib1oAPIfsjRQdvb1G
	WYouy/SKvTvrho1pjnzt0fTdYMYUBNsp8LcVI3I6Q/2SERoltANntW7cSPToRk9uqy7W4up2Zos
	MC2HHSXIrZqIMRnJoW4VQ2oJ23qmHv6RREjhyMkyc5UgZhMuRmDcf2as1b8EZtwIdp/nbjX5xvg
	qzh0sYt3LI5gv1nYI+Lmi9cKiZ7mk5Vjccn7a3hFMlK4pryMV0DCAgji1UsW8+RV1PAPZ+QvfLA
	bTW+rcDOSttc0OwaIkv/WD9XtwpEwQM8PRfOfqm4TP4SHllTF08pGhXH6qkUqq0CUzhjIoJwWc=
X-Received: by 2002:a05:690c:e3e7:b0:87f:8860:5740 with SMTP id 00721157ae682-87f8860577cmr22643267b3.62.1788962414536;
        Wed, 09 Sep 2026 07:00:14 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-910406afe48sm143593906d6.43.2026.09.09.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:00:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/2] libsemanage: fall through on an unreadable semanage.conf
Date: Wed,  9 Sep 2026 09:59:18 -0400
Message-ID: <20260909135918.29943-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909135918.29943-2-stephen.smalley.work@gmail.com>
References: <20260909135918.29943-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When searching the configuration roots for semanage.conf, check that
the file is readable, not just that it exists, and fall through to the
next configuration root if not.

This prevents an unreadable /etc/selinux/semanage.conf from causing
libsemanage to fall back to the built-in defaults instead of using
/usr/lib/selinux/semanage.conf.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/semanage_store.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 8aa1abc8..89e7456f 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -564,14 +564,17 @@ char *semanage_conf_path(void)
 
 	/*
 	 * Rooted at each configuration directory, then (for a chroot
-	 * build) fall back to the host directory.
+	 * build) fall back to the host directory. Probe R_OK rather
+	 * than F_OK: semanage_conf_parse() treats a fopen() failure as
+	 * "use compiled-in defaults", so an unreadable higher-priority
+	 * copy would otherwise mask a readable vendor copy under /usr/lib.
 	 */
 	for (i = 0; dirs[i]; i++) {
 		free(conf);
 		if (asprintf(&conf, "%s%s%s", semanage_root(), dirs[i],
 			     SEMANAGE_CONF_FILE) < 0)
 			return NULL;
-		if (access(conf, F_OK) == 0)
+		if (access(conf, R_OK) == 0)
 			return conf;
 	}
 	if (semanage_root()[0] != '\0') {
@@ -580,7 +583,7 @@ char *semanage_conf_path(void)
 			if (asprintf(&conf, "%s%s", dirs[i],
 				     SEMANAGE_CONF_FILE) < 0)
 				return NULL;
-			if (access(conf, F_OK) == 0)
+			if (access(conf, R_OK) == 0)
 				return conf;
 		}
 	}
-- 
2.55.0

