Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B42D1E7C27
	for <selinux@vger.kernel.org>; Fri, 30 May 2025 05:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748582012; cv=none; b=SN7ppUlyoKUIubFCpUZO6aOHvMadG+2tGX+g807elSroYnZYou250Vnuqof2Ci1CCPvZ+2lUvx3kf4qvnoUqr+7VAcVEVLn+H2Dsh7xCWvKMzi9AYzzIjCOoSOTID1+H1k8TLcf8bD9vsoFqJ/GFT6Oc64kauUDd94z0PzcqNLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748582012; c=relaxed/simple;
	bh=cLuYw5Io37lxfQ+DCOCd3TdPUmQdH/06Y29vE5CztT4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U+f4R1y/9zQAGZWHocINyKfFdXL9CMOC7raL8UjSlTQTQGYe4/AmsB0zq8Nf9otuzwQ7QHEtFYR9CDvg8+uIF4+jqmC9QM98oNy2ANiDR4vt2RavbYy0dtkcXRK7HhQ/aA3z3iwvtjqbrUTy4ZNFpo6yuqFRbYs+n8BqLos2sQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s98qSu4b; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s98qSu4b"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-745e89b0c32so2429351b3a.3
        for <selinux@vger.kernel.org>; Thu, 29 May 2025 22:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748582010; x=1749186810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6YnW4s53nli6bKfwS2RUJX9h7H2bVx7eSfbdlmCtPoA=;
        b=s98qSu4b6j+1A1gFeWxQnx2LXovgiKBONX2nEj5gpctN3D/o9+a8ykOpxO2eG614bs
         RBldUplR9iiIdgaJl4iALIHy96xa25dUPLIspKyEM2nuLXqvbzo2kwry/IRvGG8gURZ+
         HJFk+VY9qBC3gAvhPI3pQo47hansEyY/neW1NjhVkYzMxETIwUreN7O55RPxSU/25bKO
         b8ganbXQYaSxWSbt1SEXyi6PUD4W4xEv4pdYynp29IJ4s1Vd6f/Q4PbSSMKNyLR9M/HS
         twhJMQU3U7ewskRbqp17llEzHoPfs7UJLZff8o4gJLDCHkH7c4jI4mmBtt/GgawK5OxL
         D3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748582010; x=1749186810;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YnW4s53nli6bKfwS2RUJX9h7H2bVx7eSfbdlmCtPoA=;
        b=SmOIADwcZwEXQJqHRc2kSARaTuvGDi6MupfXg88jEfAwvQ77FvaxZnRKoc1RJBQ8hs
         rFhBAx3g767fsncK2gHcoyxBwzSL6oIz5RDNizsJVlPzQaGOm5Wc6DNza83N/4eOiPU+
         lakZXo4RGx/dCKVdTFJbftAQR8Wh9I9PSS3BLHQdbLlWTQvdUdvWh3dozhevHmz8bj/7
         f49unGPhH3BDrDnXb1zCm8MiKT+PBOUAoDgQG9Q8pzoFq6NH8oJzmuTDpUOCSXUeRjop
         ajGyC2OMFAHBYsczZLnGDLigzj+1DGPBVBxvmLGmiWPYRcePZq63o8UdlsQv0oVBbLgU
         YG6Q==
X-Gm-Message-State: AOJu0YzR5xysLLqNcI5IQIeI7IzfrXXss+Zqv8u4dEjJpBdJVKeujwRJ
	2LDOAoT4fcQr2+uIUook6a9/ZJsodr7PxJzLpk96Wan3+MTF8hXxlKFsJz4F9jBCZKa1qUQOitE
	1Lf7cDz6ROXbxk7ijCystqedKnIvWE/GcteDPOxbZ7eiPXn1LHhhH5lzx47ZmoQPx/vTyrUq/Oj
	Z5Z4uC3lBcDbghkrjdqAxtOis4LY0dW+BYzTDXMw==
X-Google-Smtp-Source: AGHT+IEY+u3QER72BntTAMQ2kdTZRierFleLJV/Ch2GFkZcT+zp6CMrZT3uQzjp0zIJmu+dsOc/aGcNVquc=
X-Received: from pfbih20.prod.google.com ([2002:a05:6a00:8c14:b0:741:cbad:dafb])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1743:b0:736:31cf:2590
 with SMTP id d2e1a72fcca58-747c1c25aecmr1214424b3a.16.1748582010182; Thu, 29
 May 2025 22:13:30 -0700 (PDT)
Date: Fri, 30 May 2025 05:13:20 +0000
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1238.gf8c92423fb-goog
Message-ID: <20250530051322.1678251-1-inseob@google.com>
Subject: [PATCH v2 1/3] libsepol: support wildcard network interface names
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: takayas@google.com, tweek@google.com, stephen.smalley.work@gmail.com, 
	cgzones@googlemail.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for wildcard matching of network interface names.  This is
useful for auto-generated interfaces, for example podman creates network
interfaces for containers with the naming scheme podman0, podman1,
podman2, ...

To maintain backward compatibility guard this feature with a new policy
capability 'netif_wildcard'.

Netifcon definitions are compared against in the order given by the
policy, so userspace tools should sort them in a reasonable order.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 1aa9b30a..7bebe4da 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -17,6 +17,7 @@ enum {
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	POLICYDB_CAP_NETLINK_XPERM,
+	POLICYDB_CAP_NETIF_WILDCARD,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 6b28c84e..ec6c902d 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -16,6 +16,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
 	[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]		= "ioctl_skip_cloexec",
 	[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]	= "userspace_initial_context",
 	[POLICYDB_CAP_NETLINK_XPERM]			= "netlink_xperm",
+	[POLICYDB_CAP_NETIF_WILDCARD]			= "netif_wildcard",
 };
 
 int sepol_polcap_getnum(const char *name)
-- 
2.49.0.1238.gf8c92423fb-goog

