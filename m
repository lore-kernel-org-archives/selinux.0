Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519633;
	b=YzGTaDSftBv14KkttrI66jj9jwAdyp18i0764EgwvswDhaARN/6bCKD0PLkqOeJwte2m
	 dEHCBcH1ZgItXZTXA7LeRT7s0CgEt/ukZdvCCdk+gSBQK+ze1hsy7yX3s1r+GZlbajdMU
	 ShyypUAQeOLUAm4FsCtAB7sef1pzuc8fUOmZYD1T3Q76v6S2sd6fFYPsNrkiQyCQaV8G7
	 mIID8/gjtKItATsDWV09CHh5PiQaXFoglCmTM8LiYeR2u3oEy5uUfXtxnTdTrIqIi0nb4
	 msn3n07LV0eGH+aeYkwT0Fw/cWakvgMaWpD5ISZwvdHtmQ8M7UROHyjlQ9Ic1AEagDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519633;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=5rbfWMtif59M6Kp8Q47mGPLGXlNhOu7pa8aU9t8ceGo=;
	b=pqAmycZBvTQ8KAGoiSpEP7TElqXARhuNlkxhcWudsqocyyUE7y4GKQ50RIY/iOGOsU8K
	 p+sAT9lUGoslD66oJD/dhYMzXzTomyzYn1wRPYEsdf5YiKm/anB34IU1XS9LjdCvv3/YD
	 Ci63WfAFyA3bk7kb4VM3MpASUIYnZDwwuwfIlctAvg5zyVfcBlAgzAnlny+xQ0qCMRBP/
	 Ftl3IZdWx9WSjzT7wykPU/wxYjodpyzjSfoBOGSIk6hNob0tk0F8SIrsZxs1aQ/h9CZ0m
	 gOoBLPzn8vnLtfR5Gk6pLMswpbZWBPcbhLI8sNlQy5im692tmlgqcdMQ+k1z0RIXndw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0ibMrb+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="Oq/xYCO/";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E164606A319
	for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 18:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E164606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0ibMrb+;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Oq/xYCO/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792519631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5rbfWMtif59M6Kp8Q47mGPLGXlNhOu7pa8aU9t8ceGo=;
	b=A0ibMrb+O6Y8qt5VORk/CWsT2cbLGpXvoYZZGIs0znSdJyUu54Ppv22g+YOn2VW4u3WJIb
	EnikyQZIZU6tawTBONKNorf7MNxEvO15YGy+3aM7tBrJSKPQ6TNBy4gjZVQQuJ5qMlJL3c
	opMejomSAXUYtQhj1iSY1oQJNwY8KoU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-CosakB_LMLCYTaprhNEPOg-1; Tue, 20 Oct 2026 18:07:06 +0000
X-MC-Unique: CosakB_LMLCYTaprhNEPOg-1
X-Mimecast-MFC-AGG-ID: CosakB_LMLCYTaprhNEPOg_1792519626
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eacc615f73so2186724e0c.1
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2026 11:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792519626; x=1793124426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5rbfWMtif59M6Kp8Q47mGPLGXlNhOu7pa8aU9t8ceGo=;
        b=Oq/xYCO/h30FeGm/w0hlpMn+j97TbPQCfJxSQBwjptGq7hNi2q77RGproRoM4oeO71
         SGe1eEzKj1csN9cV1sMZUVlX/YCUQlptuwB8hFwotPn0zgxze5lkveHHV+otba14yYLU
         8PEY6xbFdiXYGuzD7sCYJ1MuPDpBmyZp5pRjrMPOV9zAmnIdGLNs+nBqyJwGoZb3O2aB
         PrsPl6XMWA9/epzEebZdZKZyudjHMO8fhgQ2ieJc5opzaH6erH5T6vMWqI+cMM071E3u
         wX2v15G01UholE3HB25gpglEfFG5qZkR80xolIeqVdxr8lU/PYMgoCnSi17w3R+UPNbt
         jhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519626; x=1793124426;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5rbfWMtif59M6Kp8Q47mGPLGXlNhOu7pa8aU9t8ceGo=;
        b=czxkpV6o1o56UAizEGaiCj1t5ZDPD+qfwA82MJNjpRbDG7hvNYuEDvaLn1zPx4ytQM
         Eddvck6BQ05NcIAF2HslBUjEhGkqlf6nugvYMq/xstoqNaOo7D9VeeubgpasL/XtRG0R
         APxqjEhuTCFe2Li9X4W0TrMEGH2MID+TsC3QGs+5VCIrafBQxl/Qf8LizsKN29zBEW1j
         AcYB6nUwL5KRYKxBTP3Vt9AGls9I7wZgux1PgXyM3kFpgXF3H38b/NYRLHBfShKIzXxU
         n+1WOcFGs9bbsl8gAES/7MDJOi0I+ILUiRgmG2aN4K7Ox/uDzMdquS8oPc4TXA4Q0kpA
         RIjQ==
X-Gm-Message-State: AFq9FYKD+ZfP+Pu3v1ubt+O/lSvioUeQ1lGT1u48rEIRwwrd8uo8MPD6
	TxphAwk9pC8ua/5kyOy4rZLRMWmGuuzyy548CqO90oWpcdUeX7KVXnYjS2hN0gGKB62iX+7TT0z
	WE6uGqRjL6nWfPCRe3ETpIwjY0Cfvk/NnuBOzXIFzDu6h26YOVHZQiKx9tRlXjfnE9jC+S+MkFu
	WEeEqJvSXKbKBQW2wR/fKuVDw9FKhss7OHE0u6XAuU
X-Gm-Gg: AYBFou2jlmWvWWrFqZ26whLhqfuSqZ1AX2KOFPKywliVJ2o6sZ1nWct6dz7oRZTtg5m
	21ZVWQ6x9JRRRnFTVuQjjMG6IMzKYYJAOFPYS3IQmMhAYDv8db4NmZ6V7S8kksojA6ckY8/zl9/
	qI00AN+mtPQNxP5ObjYl1gASW+jPhz4pZ+hP0Ct3GJ+7J6J7PJj7mTbWLqm4+CEimsrwxzn4TRF
	Vc4B9yoksvPVfzENJuwP2yYTVXUqxGHJq5r51RlDTonlD+lTZm4wRZBsM/EDcSRv3CwW4DfmND2
	Z21rI/3+8SUFMd/va8RfpeyVAGSQlUu91ywdGp3yYUEhisGbvUnMCXBu78tzbLnpuSJqw5/mj7g
	2HJdAmQXx
X-Received: by 2002:a05:6122:d19:b0:5ea:c90d:d1b2 with SMTP id 71dfb90a1353d-5eac90dd9bfmr2159265e0c.13.1792519625993;
        Tue, 20 Oct 2026 11:07:05 -0700 (PDT)
X-Received: by 2002:a05:6122:d19:b0:5ea:c90d:d1b2 with SMTP id 71dfb90a1353d-5eac90dd9bfmr2159246e0c.13.1792519625412;
        Tue, 20 Oct 2026 11:07:05 -0700 (PDT)
Received: from thiccpad.inf.ufrgs.br ([143.54.53.81])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae9787f03sm264665e0c.4.2026.10.20.11.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:07:05 -0700 (PDT)
From: Pablo Alessandro Santos Hugen <phugen@redhat.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	omosnacek@gmail.com
Subject: [PATCH v2] tests/keys: skip KEYCTL_DH_COMPUTE when unavailable
Date: Tue, 20 Oct 2026 15:06:37 -0300
Message-ID: <20261020180701.2710971-1-phugen@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018012855.1795025-1-phugen@redhat.com>
References: <20261018012855.1795025-1-phugen@redhat.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since 32f07cc40c9b ("crypto: dh - disallow plain "dh" usage in
FIPS mode") landed in linux 5.18, plain "dh" is disallowed in
FIPS mode per SP800-56Arev3. keyctl(KEYCTL_DH_COMPUTE) returns
ENOENT in FIPS mode.

Treat ENOENT and EOPNOTSUPP as non-fatal in keyctl.c and
request_keys.c (the operation is unavailable, not denied by
policy). SELinux denials (EACCES) still exit 9/8.

Fixes: 2d7aad8a1f8c ("selinux-testsuite: Add keys tests")
Signed-off-by: Pablo Alessandro Santos Hugen <phugen@redhat.com>
---
Changes in v2 (Stephen Smalley):
 - Replace ENOSYS with EOPNOTSUPP — KEYCTL_DH_COMPUTE never
   returns ENOSYS; the !CONFIG_KEY_DH_OPERATIONS stub returns
   EOPNOTSUPP
 - Drop SKIP blocks in Perl test — SELinux denial fires before
   DH computation (EACCES -> ENOKEY), so no_read_t tests still
   pass under FIPS

 tests/keys/keyctl.c       | 15 ++++++++++-----
 tests/keys/request_keys.c | 15 ++++++++++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/tests/keys/keyctl.c b/tests/keys/keyctl.c
index e13c655..5e98f11 100644
--- a/tests/keys/keyctl.c
+++ b/tests/keys/keyctl.c
@@ -142,12 +142,17 @@ int main(int argc, char *argv[])
 	/* Requires key { create read write } */
 	compute = keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
 	if (compute < 0) {
-		fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
-			strerror(errno));
-		exit(9);
-	}
-	if (verbose)
+		if (errno == ENOENT || errno == EOPNOTSUPP) {
+			if (verbose)
+				printf("KEYCTL_DH_COMPUTE not available, skipping\n");
+		} else {
+			fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
+				strerror(errno));
+			exit(9);
+		}
+	} else if (verbose) {
 		printf("KEYCTL_DH_COMPUTE key ID size: %d\n", compute);
+	}
 
 	/* Requires key { write link } */
 	link = keyctl(KEYCTL_LINK, base, KEY_SPEC_PROCESS_KEYRING);
diff --git a/tests/keys/request_keys.c b/tests/keys/request_keys.c
index 43b20d9..291a522 100644
--- a/tests/keys/request_keys.c
+++ b/tests/keys/request_keys.c
@@ -127,12 +127,17 @@ int main(int argc, char **argv)
 	/* Requires key { read write } */
 	compute = keyctl(KEYCTL_DH_COMPUTE, &params, NULL, 0, 0);
 	if (compute < 0) {
-		fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
-			strerror(errno));
-		exit(8);
-	}
-	if (verbose)
+		if (errno == ENOENT || errno == EOPNOTSUPP) {
+			if (verbose)
+				printf("\tKEYCTL_DH_COMPUTE not available, skipping\n");
+		} else {
+			fprintf(stderr, "Failed KEYCTL_DH_COMPUTE: %s\n",
+				strerror(errno));
+			exit(8);
+		}
+	} else if (verbose) {
 		printf("\tKEYCTL_DH_COMPUTE key ID size: %d\n", compute);
+	}
 
 	exit(0);
 }
-- 
2.56.0

