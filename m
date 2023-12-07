Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Prm84jT6"
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9F81704
	for <selinux@vger.kernel.org>; Thu,  7 Dec 2023 08:53:27 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54dcfca54e0so1130220a12.1
        for <selinux@vger.kernel.org>; Thu, 07 Dec 2023 08:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1701968006; x=1702572806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYJX8rbnHUVlWgN4hVuJTqWt7cSG1tCoTM2aUHd6lZs=;
        b=Prm84jT6kxXTWlW/yFKwoe6vnyt5KZvNFyqfJYJHs3sOex5ejvG9YPTHn2KqK2eu3l
         tC4xclpQS4obO7IVJrEAk0pQDvJ+8pbGEVXsT7Wp5QHC7AIF09txzTHH9pyYWUdyqea2
         n61TxIQNoPXjdU717Opa7pX6h8OwXB/AcClOVfR1/Urq7R+r7woyGuhZbNxq13ScM7ov
         ZV2FRNuwWgyVJ1Pln59h9rCJYEougNq982WsDbAcEzrO4uNtBZoSuOFpFqX6MyISM6n6
         m/aNcRQ1bdVjX+lp8zz3cMGqAivnWG3mWwfKcJG2csfngBe+krMj7VRZJpmSyk6NQE/n
         Dbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701968006; x=1702572806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYJX8rbnHUVlWgN4hVuJTqWt7cSG1tCoTM2aUHd6lZs=;
        b=nAclYJRF5is8Rr1R50oqJCR9xqw8L5sVuAnwKIB2ok12P+IqvokTliX+7oNh80wz6c
         ztVZTy9IsKNU2OafVMsCG5vL/kZg7h7OR8r2TzUlsDZPcEV0p+HX7mMq7uVGeMzEbM1X
         b+BPO61U3CN5lxkUSSGBrexXjgArg2Axxou8cuOe4hVv4UzYv70tffLgrtb9KmvD9Ox9
         L+hHNsiUiaGKxeh53rbCGNZNJLBGeQZemKC6p6ixGRDIUPXHNcIzEdKAr9Rrmkhd3k2Y
         bck33fBAuuXkq5Rf9z0zRF4c5wCH5ICkiWD6mahsJ5tEZQF3dRCjhbMIQm03w7TZMV7t
         cj9g==
X-Gm-Message-State: AOJu0YxfA+G4RSDbk0csuiefP1iq2rn/4XnRDZ8qTrzHHxMwPD+yiLRt
	WDrM+3qJx32cW2DXIpI48h0x95rTVrA=
X-Google-Smtp-Source: AGHT+IGfnlf8cJXjqM1Je7pmLzYEzp4RFz1H1was6mAN8hJt6HvcobM/wlFZVs07zVPHknStWNtn5w==
X-Received: by 2002:a17:906:454:b0:a1c:566d:fe50 with SMTP id e20-20020a170906045400b00a1c566dfe50mr2116187eja.47.1701968006111;
        Thu, 07 Dec 2023 08:53:26 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-172-210.77.10.pool.telefonica.de. [77.10.172.210])
        by smtp.gmail.com with ESMTPSA id jg13-20020a170907970d00b009fcb10eecb2sm1030276ejc.84.2023.12.07.08.53.25
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:53:25 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH] libsepol: validate permission identifier length
Date: Thu,  7 Dec 2023 17:53:19 +0100
Message-ID: <20231207165319.63889-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Limit the maximum length of permission identifiers.  Otherwise
formatting an access vector might fail in the common used helper
sepol_av_to_string().

The current longest permission within the Reference Policy is
x_application_data { paste_after_confirm } with a length of 19.

Reported-by: oss-fuzz (issue 64832)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
The oss-fuzz issue got closed by the latest fuzzer updates (due to
unrelated changes that invalid the current reproducer), but the issue is
still valid.
---
 libsepol/src/policydb_validate.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index bd8e9f8f..72681120 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -366,12 +366,30 @@ bad:
 	return -1;
 }
 
+static int validate_permission_wrapper(hashtab_key_t k, __attribute__((unused)) hashtab_datum_t d, void *args)
+{
+	sepol_handle_t *handle = args;
+	const char *name = k;
+	size_t len = strlen(name);
+
+	if (len == 0 || len >= 32)
+		goto bad;
+
+	return 0;
+
+bad:
+	ERR(handle, "Invalid permission");
+	return -1;
+}
+
 static int validate_common_datum(sepol_handle_t *handle, const common_datum_t *common, validate_t flavors[])
 {
 	if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
 		goto bad;
 	if (common->permissions.table->nel == 0 || common->permissions.nprim > PERM_SYMTAB_SIZE)
 		goto bad;
+	if (hashtab_map(common->permissions.table, validate_permission_wrapper, handle))
+		goto bad;
 
 	return 0;
 
@@ -395,6 +413,8 @@ static int validate_class_datum(sepol_handle_t *handle, const class_datum_t *cla
 		goto bad;
 	if (class->permissions.nprim > PERM_SYMTAB_SIZE)
 		goto bad;
+	if (hashtab_map(class->permissions.table, validate_permission_wrapper, handle))
+		goto bad;
 	if (validate_constraint_nodes(handle, class->permissions.nprim, class->constraints, flavors))
 		goto bad;
 	if (validate_constraint_nodes(handle, 0, class->validatetrans, flavors))
-- 
2.43.0

