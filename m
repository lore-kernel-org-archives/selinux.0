Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4EF2F068B
	for <selinux@vger.kernel.org>; Fri,  3 Oct 2025 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759497820; cv=none; b=oKluSUkt9S55347zU190lD2ZcaIoOLXo5rkO2hj8/oDUijojrb2qVWrfjhW9zGCV78vvMa8XzN07LnfmzIvAtLABKIlZDtEw1ojibDhjdHf+aflvMYgJ+QE9AGGid6/s2Vv2qTYDhpte2XXjmA2q/Zvx85R9d7MNckWwRI5CRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759497820; c=relaxed/simple;
	bh=mUKu6iaFo6a3CXPPygm6mszyYA3XUGGIY/VOgs7ytFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtQiWZ1Kxz/oAVtcgvHet0hI/nrYcCyn33HlNNtnj/Q+eSGUfd3D1hIvIsWiG+SBtL2uuvZMX1NERhgdpZUF/RTpAW6+j8GAx7rVRg69ejQgvkwHF434yashMad/IYzf0BtMM2YrQE2esTR6JjnkoYrYfz5bFxGWyfonQctPB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxhv+hux; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxhv+hux"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-875d55217a5so225707285a.2
        for <selinux@vger.kernel.org>; Fri, 03 Oct 2025 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759497817; x=1760102617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVLpi8gkovdhowq1w0/vej7n614rchYweWYGRZNN+Nw=;
        b=Cxhv+hux4dWvEdJAt5n2+FNVxZY7o/xPXeUpPY+rtO0E9ohATiR/jgSA6pV0uaWFfa
         rUDsboURqEvdN+uedsjgMXliAWomaDgTaIrNVt1wLE/8qXlXcaAA2UDC6KjJnIqARs4K
         zzB5Z/Ddkurxu4xXqr+/Z3eKr5FXklFPQ64sM2v626iUg4wwMOYRYOkXzqoyVPmxs7GL
         b9q2GfNvcXndbjzQP6YJxdNUm+98kGBeFdPpmhNQ6CrVdYURf919+/94F1kCFbPAYy7z
         maroODg701e3kX0GdHsJf6RM1fO/UZjtr7v83RRJj0Vx/X7llq+HeNOcqNIod7oMVfP1
         P9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759497817; x=1760102617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVLpi8gkovdhowq1w0/vej7n614rchYweWYGRZNN+Nw=;
        b=B8YpKE1XNawuDx6wu0sINj3zhco8vN8UP4LQ0CYiCUh9vN32iJtDeQG5FCiRLJHG0o
         2kKY8NLOlX00YMQiAypg8OKXiZv0WRW27F/MXWrTkJxv/T4Ymo+PKFnBhyk7C978Lvv6
         7iXRaHvK2TbSKnuXYl06wGdgiq/NV40caOdbqzzyxwzBdt2Nd2C2WcUXdYoPHTUs8V5r
         kRP4YCEmip09/tMf8KpdCF1ScTwoAhd+WDad/c5+bic5QKTPPQM79MEG3LwB6Fw9UJJS
         lhrCKOqf8bzRBQvupEY7v7qNgP8Ww/vMqFwvsqLfMUCS14wS3pNOQvgcmS9GWIvvMRyT
         lq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVx6ljHVmnHMXk/t6ksio2QZEU8PLDm/KHdnMKdD1rFCH1qYlhr+vvN/vk9dh+2bPqNDk53MTef@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1xNy958pdNQEhxhOAiFsPBQ6suNIsfAng02+tNHW1+oslgon
	LjPG3ih1SrIAxbPTEVsy6vNFRlaTbafvImy3gDQWlZg9e4mqDp8ZLZqK
X-Gm-Gg: ASbGncs3aqQzXyQL1QAgzbx7T7Bd+us8jWU7y7Z3cQDUgav0hZo3W0pLRxpppMVB0pO
	B54TCxyzHBLnbRvtjuZnpEk0wXl6JXtLQKhJIUUFsBcxijGs6M+MMDZJdaGh722llGbF69Du5WU
	8zQmdHozMpGKpAuPGXJy7cCc/bYfCizwGmBoT4jc59gET9KoOPV4QYxYuVGSa0YiveNQXwFYb+C
	Fhei9uI7R17HI/5N9a3YxYQ/eFiBYPHIQtyj/J2G2zsZPt+J1fxNCaP8H70juBYPZTOT198i/GU
	yyQ5cDiz7MkP48osQnl5eqQFfmcfs3GK3PxwBiuoToi3JRsxGD4HKR2BMhCJa7dNIBv3N+bBUcG
	ExP7yVtqQaYo0lD6MY2lERicX/Fpx23dJepBR6+s+LmKY8VwWzfJr8RVxQClpGJblQo2/4QZcWG
	aRK7MWHa28tauae8L0H/S5BnG9fn2Cen6lnPBhUflzmCUEZQCuoHnI7dZwMCrloeWrPo/gi1oSF
	Gk=
X-Google-Smtp-Source: AGHT+IGhDylVij/2hFtWThbNacKt93dDCkbiRV1GswK9Qu5CPnTReRpxDkR2sjtI+NXbbfzvDtfG/A==
X-Received: by 2002:a05:620a:28d0:b0:829:62ed:50a9 with SMTP id af79cd13be357-87a3720d3dfmr435160585a.20.1759497816926;
        Fri, 03 Oct 2025 06:23:36 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877725550fcsm420727785a.21.2025.10.03.06.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 06:23:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	john.johansen@canonical.com,
	casey@schaufler-ca.com,
	serge@hallyn.com,
	corbet@lwn.net,
	jmorris@namei.org,
	linux-doc@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] include/uapi/linux/lsm.h,Documentation/userspace-api/lsm.rst: introduce LSM_ATTR_UNSHARE
Date: Fri,  3 Oct 2025 09:20:01 -0400
Message-ID: <20251003131959.23057-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This defines a new LSM_ATTR_UNSHARE attribute for the
lsm_set_self_attr(2) and lsm_get_self_attr(2) system calls. When
passed to lsm_set_self_attr(2), the LSM-specific namespace for the
specified LSM id is immediately unshared in a similar manner to the
unshare(2) system call for other Linux namespaces. When passed to
lsm_get_self_attr(2), the return value is a boolean (0 or 1) that
indicates whether the LSM-specific namespace for the specified LSM id
has been unshared and not yet fully initialized (e.g. no policy yet
loaded).

Link: https://lore.kernel.org/selinux/20250918135904.9997-2-stephen.smalley.work@gmail.com/
Link: https://lore.kernel.org/selinux/CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com/

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 Documentation/userspace-api/lsm.rst | 9 +++++++++
 include/uapi/linux/lsm.h            | 1 +
 2 files changed, 10 insertions(+)

diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
index a76da373841b..93638c1e275a 100644
--- a/Documentation/userspace-api/lsm.rst
+++ b/Documentation/userspace-api/lsm.rst
@@ -48,6 +48,15 @@ creating socket objects.
 The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
 This is supported by the SELinux security module.
 
+``LSM_ATTR_UNSHARE`` is used to unshare the LSM-specific namespace for
+the process. When passed to ``lsm_set_self_attr(2)``, the LSM-specific
+namespace for the specified LSM id is immediately unshared
+in a similar manner to the ``unshare(2)`` system call for other
+Linux namespaces. When passed to ``lsm_get_self_attr(2)``,
+the return value is a boolean (0 or 1) that indicates whether the
+LSM-specific namespace for the specified LSM id has been unshared
+and not yet fully initialized (e.g. no policy yet loaded).
+
 Kernel interface
 ================
 
diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
index 938593dfd5da..fb1b4a8aa639 100644
--- a/include/uapi/linux/lsm.h
+++ b/include/uapi/linux/lsm.h
@@ -83,6 +83,7 @@ struct lsm_ctx {
 #define LSM_ATTR_KEYCREATE	103
 #define LSM_ATTR_PREV		104
 #define LSM_ATTR_SOCKCREATE	105
+#define LSM_ATTR_UNSHARE	106
 
 /*
  * LSM_FLAG_XXX definitions identify special handling instructions
-- 
2.51.0

