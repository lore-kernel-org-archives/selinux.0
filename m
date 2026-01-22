Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055872DEA8F
	for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100369; cv=none; b=BkDa5dscXp6DSgAPmEE8TA9bKNUkeQzlFlO6DfHBcMWjFDOWqLU4MbF8y/eQZ8fJra+UPBgBCrsmEs3WYfzHfQAvsGF0amQOCC8UK2O8pmJtiU915xcmrOu7/gzcb5o4cpsbwQhndEEmbrgwz0WNBEIyYbuTiXqo3EA+hBo1pH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100369; c=relaxed/simple;
	bh=K/m7RxFpr45JB15KeowDtqNhPyBCkgDg20EoSBLnt8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4E+oikcUW76xARpioKToGnslsNag6j1APlZ2LglYKfdtx6aY39h+2UrJiwTv6dtxYqrwHaISpAydgKtEi5GNb7LhygibVhWLwRmbxEY4mJq8Pnvjio0pZZdfVHDWUQmpb7s8nHeNoBR95lTw8DsehQA/TKULNxQ1LRReGh0ToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihvPfia4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihvPfia4"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c6a822068eso152266685a.3
        for <selinux@vger.kernel.org>; Thu, 22 Jan 2026 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769100358; x=1769705158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HtVIjkjq27DY7iX0hFU6RWSaZgYAd+VXW3JtQs0FcZ8=;
        b=ihvPfia4FXu0Iu8iNbZEic4hhbckxd0UC1C2sluJ8py/EIxu6o0nvVvIJJryGTK8B7
         oobZBlMDMaEYiAkY/E0JN0valtIsvmmR293hftVm6JpEvMlWAEHxjey9JEHfXaezKp0f
         MtA66rt5UVB572SRWDV29anHA8a1gV738lUbgKbreyoSy1g4TEucYR6OUCQQoTIbkzao
         SR6oH0BaFJ+4x1INLgVvG6wuT+r4Jp5gDKPFrhsyuc/Ilrkhe5KKnQitrqck7H8EdIP8
         mdMFQnOu5nYOHWfV1uljXYfocVnkWy5dXLZwB87el3u0ppoipMZZyplFFIYEe0yBZ5f2
         Nnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100358; x=1769705158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtVIjkjq27DY7iX0hFU6RWSaZgYAd+VXW3JtQs0FcZ8=;
        b=rQgV/ujJ3S3Estb2PpsKOD3BsCa+tBistdBaBiRKATjfbIk4SETPFPHC8wfbB7jKGy
         OG7KW1thW/3AnztG5IZTSTHNb/bvSHJZw0KNDJqI+j0btY2XeFOY/5Afz8xSbcGrKw4Q
         xFH745QreO4jsfNibU+4JhjSpcrfb7uIieD/ZtNj/Nq+tRbKYWzyXDHPczUgk4KvuXG3
         3P1PO+TNVsPJlTJv9J0fV+EDal7jgps97Xy4nEXATSToB/iiIi/917RX8YZgTrRpVMRF
         z3xMZiwtDrL+kcSJwkyggCz3DFk3QAHgxSXy7YJ57PaTboogK8cs/0kVL299e6xinve3
         rwYQ==
X-Gm-Message-State: AOJu0YwWSA0u3CsYQFEKdbkFOI068jVfylUx5tFMDNd+mnm0lTp/6R0A
	vJIFCicg4fy+UX3NAHRfzjRcwJNHao2IBoUEIUBEpLXbL5+XblG7WMXdY4B19w==
X-Gm-Gg: AZuq6aKtvg4cCk1cdTVnOipxD7jpdVXcBS+smgjBE3bQd07raXKkFXXgp1Wor9rAY2O
	8z2mcgW0rz+4fbhn61biymmAa4At7YVah5AZXkT0fZ+yRy6CgbzJyaj0NO6NvARaqO86bG3bBlO
	+H/fZaTy0SDB9wsrP5EspT7QYrJPIb0i+NPWqC/d0ZZz5BwRD/eskbpi8qZDjMRd6I0vYZ2hbJS
	XzecKEGs5J7lF4TMhpHBdj2TJdANo13zr2ecfgxOA8DRQ1nPWg5ONv8RQ62nUb5cbHs2xMrfK3U
	6M0RYCZjQlim9mKxbOfST52gz4HKGhW2DSAyHNrHZjUuTrd31+VclLruH1PPHtfGqvhpD6PGgPM
	qWVdXNzaqE4B3ADB4EBmXhqJ31QZC6CorI22a8xI+sD4MPCj9SFn8BaHImSrRAzy5+9qS+HxmsR
	1Z3OMYZFtlbQIiswsFLt+6Rg0huvoNHQ==
X-Received: by 2002:a05:622a:58e:b0:4ee:28b8:f110 with SMTP id d75a77b69052e-502f774bb1bmr3130951cf.29.1769100358289;
        Thu, 22 Jan 2026 08:45:58 -0800 (PST)
Received: from fedora ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1efb778sm126476521cf.23.2026.01.22.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:45:57 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH] libsepol: Fix potential NULL dereference in policydb_read()
Date: Thu, 22 Jan 2026 11:45:45 -0500
Message-ID: <20260122164545.77705-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since there can be gaps in the type_val_to_struct array for very
old policies (version < POLICYDB_VERSION_BOUNDARY), need to
that it is not NULL for a particular index before using.

Reported-by: oss-fuzz (issue 474424148)
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 6aaa18f2..9760b164 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -4513,7 +4513,7 @@ int policydb_read(policydb_t * p, struct policy_file *fp, unsigned verbose)
 					if (j >= p->p_types.nprim)
 						goto bad;
 
-					if (p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
+					if (p->type_val_to_struct[i] && p->type_val_to_struct[i]->flavor == TYPE_ATTRIB) {
 						ERR(fp->handle, "Invalid to have type attributes associated with an attribute for a kernel policy");
 						goto bad;
 					}
-- 
2.52.0

