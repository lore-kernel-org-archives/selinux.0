Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VGZz8NCY"
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F74F1
	for <selinux@vger.kernel.org>; Fri,  8 Dec 2023 07:19:05 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a1ef2f5ed01so233575966b.0
        for <selinux@vger.kernel.org>; Fri, 08 Dec 2023 07:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1702048744; x=1702653544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fVrY7lq3tcRDIPnQRte10mn0n6fHeOqmdrmYSgUOfSw=;
        b=VGZz8NCYGc+Rqj9jUDChu/7t+l0NeyCT/YwibnHqEh5aIOhWT0Y5/KxHM2iUbv9bad
         A+KT/d05vhixs/tMwTH+YCTs05eo86fTcPAEuRo8wodTS7JnidhpTAuOqPiJZqCQMo38
         gUiWSUsoVDXgKf0ASQZRyUycu+MqYc+F/Ex1ENxverWGX0vlMPKvBdqOpxHYWMZBrYuN
         yfFx5AMCdxx6g/TQKiduln9qz/tf3+onUWwdgTan2v7QQ+n99t/3CP5MCGPES5jHJZzX
         O8SBCpQ3OlFx/ry3Boiie5j92JeFilLqdI5PICGISU2rjSxQUv6+V4FxaU2e006Hfge5
         lBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048744; x=1702653544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVrY7lq3tcRDIPnQRte10mn0n6fHeOqmdrmYSgUOfSw=;
        b=AjGDi3jHyunZyUgbewpVgK7axk0cagqnj6+dbdE63tODuFHRe/fbjYQwChG2daq3J6
         25MM425dJkyRkAtg1fkaQ0jvyHT4ntgiMIglCkUrMs8xN5KyNm7835gR4soyvhqxQeOy
         k2cGWwapdfHXl4zuLYig3B9oC7noYU9F4K4oRgjkCIw1FbKPXeQtozXUUHb+F0lRQGT7
         IMFoQ5EWUCvQxfF7hGMffGVwfjOr4qdV6q8dNBeDT7Hum6UNx59DV6F+8DmGPx52tjCF
         6f2MzbUfxd3783EC53kcTcarEGs+B+uq3z6o1Hw3YLFna9riNKiAql2O7XpcNRikbqR6
         gwqQ==
X-Gm-Message-State: AOJu0YztbBfjQSeD7BF2SnR9ZQzJsg0qazP4Snmqz+7DMONFnvOcm4Bp
	V6mp87HHD8Zk/O/0qMp/2NGAep5hShU=
X-Google-Smtp-Source: AGHT+IEjEutkT1CjqtkKeNYxCxYbLvbCDDIU9BqZ4S3UX3+G4BPl1B+i3MOfuq3GCgkXU+gAr7SoUg==
X-Received: by 2002:a17:906:c14c:b0:a19:a1ba:babd with SMTP id dp12-20020a170906c14c00b00a19a1bababdmr47515ejc.99.1702048744239;
        Fri, 08 Dec 2023 07:19:04 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-001-160-242.77.1.pool.telefonica.de. [77.1.160.242])
        by smtp.gmail.com with ESMTPSA id cb6-20020a170906a44600b00a1e2aa3d093sm1091667ejb.202.2023.12.08.07.19.03
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:19:04 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsepol: validate common classes in scope indices
Date: Fri,  8 Dec 2023 16:18:31 +0100
Message-ID: <20231208151831.48343-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Validate common classes inside scope indices similar to all other symbol
table types.

Reported-by: oss-fuzz (issue 64849)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
This probably also resolves issue 64854, which I could not reproduce
locally.
---
 libsepol/include/sepol/policydb/policydb.h | 1 +
 libsepol/src/policydb_validate.c           | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 6682069e..658b25d4 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -430,6 +430,7 @@ typedef struct genfs {
  * subtract one) into the global policydb->scope array. */
 typedef struct scope_index {
 	ebitmap_t scope[SYM_NUM];
+#define p_commons_scope scope[SYM_COMMONS]
 #define p_classes_scope scope[SYM_CLASSES]
 #define p_roles_scope scope[SYM_ROLES]
 #define p_types_scope scope[SYM_TYPES]
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index bd8e9f8f..4919f674 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1344,6 +1344,8 @@ bad:
 
 static int validate_scope_index(sepol_handle_t *handle, const scope_index_t *scope_index, validate_t flavors[])
 {
+	if (validate_ebitmap(&scope_index->p_commons_scope, &flavors[SYM_COMMONS]))
+		goto bad;
 	if (validate_ebitmap(&scope_index->p_classes_scope, &flavors[SYM_CLASSES]))
 		goto bad;
 	if (validate_ebitmap(&scope_index->p_roles_scope, &flavors[SYM_ROLES]))
-- 
2.43.0

