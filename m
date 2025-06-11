Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189711C8632
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666544; cv=none; b=r0bnjZOqN/0hrfVtdUHQ/Vf2UKLvUqWOzchUhbVle41c7JK++NjW84CmYSzcDDhD83uZpV8d6/qj0a6dYMstBZBfoFZr534GNlGN7jDlpktNAnv7ysfWwKGpFI/kmImH3gUlwoWuYNtmbPSfn3xFzDKf+JRcxOUve+2ElRRf4Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666544; c=relaxed/simple;
	bh=o3G32p+/7T9V4EPfX/5IyW1VFyaaDZevh5M1vhvxmbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5fB91ZzV+/3jnfL5p/qxC8lIvI+AxbaE3mcKipqoiE7f/Q9vDPj2Tx8jumAbIpcNV/T7xzErjBH7UIjw7Dfn+ikZxFtCcvqA3IlW5iqUYlWjHk18fCHgS/wK7IlTmwERwIYyQcN7EPiD/toRHqh5WllSRM4PRdOYE+Y73UNPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijc7mFb4; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijc7mFb4"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d21cecc11fso22677785a.3
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749666542; x=1750271342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HHv6pGLEsGeCa4flySzHfBdyukgGzvA+LU3/VHbbpF4=;
        b=ijc7mFb4PFgt9prjoMVaiITdWTlgBprzdAKsW4QIjWyNtP6bjo/ztfpr4kOZEe1HJD
         ETC+MvYTihTnpveExHMzvt1yIZ88lrdyTenm1GQpB5nM9VP6Ux2ni9WGEZmisNzYZ0Na
         UDU/UlZiRsme766BLWDc/bPa0t38lkR3Ua41j1bCpqogmzLwYKiXoxWlDrNWKN1Q5P/s
         0nHA3DPjPlBEFehgD6lZO/7mbboWS/cHGWZYkgNLAD3O/l6TH8s7VlBRN6TkbyBE08bB
         MIZsy6xSIO6meDqbWxN8VcPhhMFO3WwfSNA+DuVzgif8j/9ErbM2zRzg3oj6f9n3zm26
         pyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749666542; x=1750271342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHv6pGLEsGeCa4flySzHfBdyukgGzvA+LU3/VHbbpF4=;
        b=MPT7AAYblDqfVaUdGIARWdqjpemvNPl34lQuaHBASo3KKtHEQPQ7CCVnOqeO1pOllS
         /YGsuNhVYC6ZhB24VtHdFd0sRfWVE0uBrBWKcD/D+nOCVpxYCLh1IR/7031JhzLjaJLa
         lwJD3Djj/fJqFXoHMxjPvP83Nw/NPmHtsNJiA2oUeWY6UNR507RCnUI4uohrOLYP5HJQ
         SYnlQoNKinf427+xHoHqQB/h74VJaZDwOP+hDO41RMCXYgIXYvHA6Qfu4BlrkRBoj/iM
         0EO5VFp4Q25iSnfAmdwYJY7RWgxHqKRYhXJ2jGdk+i0G/5AHe9ffhSmmI3o8jKzHclh/
         M32Q==
X-Gm-Message-State: AOJu0YxiNofSDMfMHwWsHSh3v8NJP/hjpXQPJpe4sZAEGMOO+nqIU5sX
	R6udDuyYvTB6Rdbmmucrmgi0OCAg7dxDLTx+w4FoKnwL0fNIhQYBG6C1OdQAOw==
X-Gm-Gg: ASbGnct42Mfhnj3UHVRFILdD9DftTbzjU2u0z28wU5uK2YXLjB1mxaS5kIlgP2U5JxB
	EAlnCCyKek/BIb8obZfx4kwatyOjkq9y/r5XnFM/DUemFM68GGlqvIcYXsd1GExiHC1HrpLumsI
	fyQmE3CKXvtN0RSizxTjXh2b7PkUSCuYme+J3mft+aMDw0hAZTTVXD1iH2lXFZkMJhjGBeI7yDE
	oHVzviS5yA4sunWFQFipPdozbrTfQ/c0Fxs7g+99C1WHQ2JsOCE35V7QMF0RhviKSQlY6INsInA
	qUe9x0mVV8R3MIkWdKBXKqUIaHQcrjfyuRLN3Kkb7XDT5WrhrxVjzYzAwOfVbQB/ZOXH8HitBzs
	wFME2l4IGjNUPdqmYKYqU1yP/FrDc5hvqos0oWkctxfMxpgyFcJzA8fqCTU0=
X-Google-Smtp-Source: AGHT+IFLjPQdiKtHpBJUx2Oh/0kywbKO5Z25tZitSrNE5SEsyJGyO3IDMXbb++lgaSTDEflcn0SSeg==
X-Received: by 2002:a05:622a:4ccd:b0:4a4:2f42:a671 with SMTP id d75a77b69052e-4a7229efcd0mr11579691cf.29.1749666531367;
        Wed, 11 Jun 2025 11:28:51 -0700 (PDT)
Received: from FUSE-FED34-SVR2.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a6f59c6a43sm64506751cf.20.2025.06.11.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 11:28:51 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libselinux: Do not inline compile_regex()
Date: Wed, 11 Jun 2025 14:28:46 -0400
Message-ID: <20250611182846.236298-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit bdcbbf89b9548afd452449835e58e84105a71a9a (libselinux:
limit fcontext regex path length), an error would be given if
libselinux was compiled directly. (Though, building the whole SELinux
userspace still worked.) This is because the flag "-Winline" is used
when building libselinux directly, but not when building the whole
userspace.

Remove "inline" from the function compile_regex() in label_file.h
to allow libselinux to be built directly.

There are four functions defined in label_file.h that are not inlined:
regex_has_meta_chars(), regex_simplify(), compile_regex(), and
insert_spec(). The first three functions are called by insert_spec()
which is called by the inlined function process_line(). This last
function is called by utils/sefcontext_compile.c which prevents
relocating the non-inlined functions to label_file.c.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libselinux/src/label_file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index d1a0713a..8fcf74e3 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -390,7 +390,7 @@ static inline void sort_specs(struct saved_data *data)
 	sort_spec_node(data->root, NULL);
 }
 
-static inline int compile_regex(struct regex_spec *spec, char *errbuf, size_t errbuf_size)
+static int compile_regex(struct regex_spec *spec, char *errbuf, size_t errbuf_size)
 {
 	const char *reg_buf;
 	char *anchored_regex, *cp;
-- 
2.49.0

