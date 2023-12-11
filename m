Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eLzZXgNQ"
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80607C5
	for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 06:55:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54f5469c211so4087536a12.0
        for <selinux@vger.kernel.org>; Mon, 11 Dec 2023 06:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1702306550; x=1702911350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcgNWhrwXnkOAXv98rJM46mprQB0FOQNQ1wtns73WTc=;
        b=eLzZXgNQ3B4xHsWMq0auTtxU1x8yqZJ4z4ddlf8yjoGl54JPBsszRi2526s+9nNJfe
         M7SD4+cyr9ZXmemRFZBnVShUIT9/KrGyT1U2J3yZHwChldbQHH3YFKeb8x9h+TlyDpGN
         MHAGMJ7cUPDsWLs6gXrLKA9q8hxlzdOUsDwZCNarl4fYEO15lxl/ukfbv9+DAYIV+L6/
         BxcEtFMuxhZOwLX5pXx7Nx41fzWWM7ai6c2rd9RfsqOf9ZWGqMW6OuPAv5Q5a6LAPVNc
         Ou4zPixNELEZE1kcExgbwbpfioZFuGNv8AOt9EArsBWBmekt641OLB+IGjnijPdYSuR0
         ZhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702306550; x=1702911350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcgNWhrwXnkOAXv98rJM46mprQB0FOQNQ1wtns73WTc=;
        b=i8uJU8yEvlUbCdMeip8tYLURy5WlZDDvMsBZAAt9YdbrbIwHE0jlBN/BMbMhTb3jqs
         /b9GsYPg6Kyi0MTYzdI4bOq6sUxx0Hmhp6WxI9/UTXyomQR8BYz03EA9VLHmrYMDNdAl
         8N/sWFy5rNiHYUGnpbbmFTh24IljOLPYNp1ISx/rsuhKWtZ6Ue8YhFnHSCiB2XW28t+h
         nHPo+Roe27hLw0Vl/MhGscJLDpSUOaDebS3nI3biyDzeZYMY0+jeYKv46XFEq7Cqv0o3
         Yay5r2Kd+NIkR4ZlbZe8tzfLaWEU5r11Tfj7MU93HUQkfJ+veavfkI+TE1LRopsj18gA
         ipzg==
X-Gm-Message-State: AOJu0YwtWBLC944TAXwioTDUsETZZ1T8Qw3XZZNIP2LCG1ALAI5VoipA
	w1bC/U+ylYKp58Xg1Ixxo8JiTFOLylU=
X-Google-Smtp-Source: AGHT+IHpRonD+70OvsKW5oraJAcegX1xmxuuBng/xz4XRw7y+8GcKukfQy7Se4dBIk7cA75vum8u1g==
X-Received: by 2002:a17:906:24d2:b0:a1d:339d:a065 with SMTP id f18-20020a17090624d200b00a1d339da065mr2029272ejb.155.1702306549689;
        Mon, 11 Dec 2023 06:55:49 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-001-173-175.77.1.pool.telefonica.de. [77.1.173.175])
        by smtp.gmail.com with ESMTPSA id vi7-20020a170907d40700b00a1dc7e789fbsm4871653ejc.21.2023.12.11.06.55.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 06:55:49 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH] libsepol: validate empty common classes in scope indices
Date: Mon, 11 Dec 2023 15:55:40 +0100
Message-ID: <20231211145544.125635-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Validate no common classes inside scope indices are defined.

Reported-by: oss-fuzz (issue 64849)
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
This probably also resolves issue 64854, which I could not reproduce
locally.

Supersedes https://patchwork.kernel.org/project/selinux/patch/20231208151831.48343-1-cgzones@googlemail.com/
---
 libsepol/src/policydb_validate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index bd8e9f8f..d86f885e 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1344,6 +1344,8 @@ bad:
 
 static int validate_scope_index(sepol_handle_t *handle, const scope_index_t *scope_index, validate_t flavors[])
 {
+	if (!ebitmap_is_empty(&scope_index->scope[SYM_COMMONS]))
+		goto bad;
 	if (validate_ebitmap(&scope_index->p_classes_scope, &flavors[SYM_CLASSES]))
 		goto bad;
 	if (validate_ebitmap(&scope_index->p_roles_scope, &flavors[SYM_ROLES]))
-- 
2.43.0

