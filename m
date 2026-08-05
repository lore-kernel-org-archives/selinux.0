Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430AF374E76
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785941067; cv=none; b=anlHwp/i9s35x3+TyS0forFn2jJf6a9nNxexym5KDHpRWwJ8vbEdK5rBbCRRhiQGQoFlVVk9D2pAJVtkghcJrUw7nTD+Y4qTP9XwT2Ptw1XFyT2+hrK/JN60GzPTO25SkHhO+T7ogHqIywKAl3AHy8x4LLe6devTylTP6xjU5SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785941067; c=relaxed/simple;
	bh=ptGpJ4LLE8+hHueyLa+hfp5WbZC+c9mUdDTts+uPQfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsPI917sbJlryjV+QUhhJuksLla0Mg5v95Rf50HXCCF7dvwxQ7ENtjkUXQzZfkYBQK5hoMoTP5M8lthr5u4r4u6jHbcAkH+jp9AHF3DFNK37w/pMi5YQbNF291kE2E/BxjJlpGw+7/g7/KebtnlmwXK7u/YfOycObcQG3fPhvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOwyFlze; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOwyFlze"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c8e2e39easo10395921cf.0
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 07:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785941064; x=1786545864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AV8XM3H+YYXNJzPqvJbfLh53MsNSIfL6ESq2KKEEfDM=;
        b=oOwyFlzeVtMrnMJX2pLwJ/rMNT6MwdYSAwglyAe+UlrKwygh1asQoFLy9udAExwS2b
         TINiKtBhHyPPu4G6Ue9zjgSi3y1XDTlnzswQ4xyZjyWpeQMHIdAGEDWkXXazBDB483kG
         5elsImQ9PrhJpr4KkEmX9ry0g7+qicB+Y2RYDLZ/NHMNF3PsWSPUDXfXPICU3aYpY2tM
         YNFNYIXEE/R4SIDLgZZExCxLdMIAbeB7fgnnhPw2c4UkxJf20B4FHD9Ms3vni3nQ2R6s
         uz2Lh4JiJuhRJollN7smfVSOoWZE5x6X6jOw4Wca8HEJEVbf+t8GpW0OkWBJi2/pqGZD
         Nr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785941064; x=1786545864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AV8XM3H+YYXNJzPqvJbfLh53MsNSIfL6ESq2KKEEfDM=;
        b=l+Dvb/v7gg+wRMNHXprnyaUHZsCzDFIjZKbv4y0eJF1CH2tTcnzJ/v3goyns28PQyU
         7tNv9cYK0NZfTACwuFXmyO6HttsfwDQhzUfhQGWe+HFccHcwB9PwtdvQfHHoKLPToWfn
         oDAT/I5foSULg7lYV/dTvQvotNGSou/WsizDD4XeKK6vVgVOYQIpOdBNUkrUFHtnw84D
         TyzF//+N9u14JO3z9JaYk4ApkSv7jKtr1zt36r8dfm55zJ3WGpJ1av7VTb8W1GgAJqdB
         SM3rstWaJ/Q3PBoxiVLkgLEGk43nvhbIF+RjIj70txt3Q47r53SZ1KSc3i5tjZTKqDAk
         MAcg==
X-Gm-Message-State: AOJu0YyrNARUZjcppp+PxIDNI/WjerlX+A+iVQfu1AnLpZG5sRfO9h7G
	SOaQKdjQTK2VmfJbjQRLXq5ujtIMKKq8bYtgVBECpOLvzBSfBZhrVYPJLdgbjw==
X-Gm-Gg: AR+sD11dKtsrYNVw3wmImLvVlqA8LOpRBi6ROmS9mdYjBadd+PuwdugD85zderPwGkc
	HSBNKM7TNL98kNfgjOW61QpZvZvEC8bsVQ0OoWc5Uu0Q4LKd97KduGiuiIqpqh7DMkSthaYyMlk
	NZn9Yl0I6e8NjalECKpRgSdsCWGbQPgHUrAEbpOywP+rwvKSZAt5Gk8ubJSbSJGhmJilBLwrU+c
	g4opaIX5OViPD2zWKXOlSrn44Ypf1Va5k5Zvothx9klN489kYJ1MF4bs9/lU7xenlcTtHsaELa0
	LuvynaylmGqNQxJQPpSw7ZgJqRYmFGaLL5RBczrTlo9FNpcggel7cCoiOt5t0QlYKRuvxOZybbl
	XhoIvBorrd1KDI2MHcNiIDuOMmI9Rwawsu5L6t0RSXcqj874X0xhWQJKJAxVzLe/Czt4Ghz7G9P
	61GElAuBxlqParQzho+yHRK23PCupXVMGTkVqkTKTiCL5f7XrQw7Q66RRr9IWSf6D84yZrDLuW0
	IUXKjDSd41vd2HOUI/6CS/nsz+PlakzBXK/CpYriv4ymqbK10XZaYAdTP7FGLYN
X-Received: by 2002:ac8:5acd:0:b0:50e:635b:5579 with SMTP id d75a77b69052e-52ce608e48emr59680861cf.19.1785941063856;
        Wed, 05 Aug 2026 07:44:23 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce8975b3dsm21669371cf.30.2026.08.05.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:44:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Chen Gong <reister@ruc.edu.cn>
Subject: [PATCH 2/2] libsepol: Prevent NULL dereference in hierarchy_add_type_callback
Date: Wed,  5 Aug 2026 10:44:01 -0400
Message-ID: <20260805144401.55963-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805144401.55963-1-stephen.smalley.work@gmail.com>
References: <20260805144401.55963-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on policy version, the type_val_to_name[] array may contain
NULL values. Check for and handle them.

Reported-by: Chen Gong <reister@ruc.edu.cn>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/hierarchy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
index 5e19ddda..0499bdfa 100644
--- a/libsepol/src/hierarchy.c
+++ b/libsepol/src/hierarchy.c
@@ -634,6 +634,8 @@ int bounds_check_users(sepol_handle_t *handle, policydb_t *p)
 				p->p_##prefix##_val_to_name[datum->s.value -     \
 							    1];                  \
                                                                                  \
+			if (!datum_name)                                         \
+				return 0;                                        \
 			tmp = strrchr(datum_name, '.');                          \
 			/* no '.' means it has no parent */                      \
 			if (!tmp)                                                \
-- 
2.55.0

