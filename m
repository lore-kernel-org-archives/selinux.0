Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037432F90C5
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049686; cv=none; b=oujDrOo8mn1gHbXoqWXm7BjtG/KzxcIv40KcejLZsMexJaDMQO8mlhtXsLp8/NGiFzGv8YHau4QQM13LRtrGymj7BtvbzRCNvocBnUuQSOnqLsOml/d1oNsneLD/ZBslzl+SbT919TtsVf0uqomrvipdpMFesKp2gg5FghNj0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049686; c=relaxed/simple;
	bh=x3tqhV9Olle7rmOnzByYzJ9ESWOMGf4vmEoK23iSpLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FWayV2SDQWFIr6Lj7MLnPvMtZXQXrRO2hRfuZNfnkASsjqdmsNjxoXFOPQhnYP6TZdcjv1/KlkllDmmkLswTVOGke+cPYI0o5wQe2rxOiVbfkgk+jGbq+Sa7+uYG5Nuax/yjQn+SoFx7NVZFObFoBid7Pk8EbgGSWtrw5iG26as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SE+tjIlH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SE+tjIlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H/vDFAbjmKyadjE9sNvUJxRLO0/03Ztq1NP0dJrlB4s=;
	b=SE+tjIlHupYbs9XkqMf6g3b358M3OhAosC63rPSImiYEl0pJ+/5Dy7tN+j8m9jHjdMFomk
	VncNCHPtnTekr1rYoSWwoy9N4sHFDICmskLKGM+pVlUyxzgqshQvlzQV5b+DTWBeb8DiNd
	7ZNlyuOpANQxH7SMOZDbeeSHpmO7JXw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-aIwM7bbHOX-brpoXL_R21Q-1; Tue, 21 Oct 2025 08:28:01 -0400
X-MC-Unique: aIwM7bbHOX-brpoXL_R21Q-1
X-Mimecast-MFC-AGG-ID: aIwM7bbHOX-brpoXL_R21Q_1761049680
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso3156861f8f.0
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 05:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049680; x=1761654480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/vDFAbjmKyadjE9sNvUJxRLO0/03Ztq1NP0dJrlB4s=;
        b=sDOE8gH3XekbvyZdbwr3fc/10+xRFdj3zMxYoaNOn07iVr9aj6Dmkn4GhskufmeqjL
         F4lB6bjJ5669SjD/BpcYQvSDJhi+45IkHzgQBl2yIw429V3NlQi5Po9rqExWtKcN5k1W
         bIXWOJ8vHAjUGwn7U6PzTLa7fuf1GgfxcubsXcrW7xudbtnf/radvkDhE6G7ZtcSXfJj
         SE1/XUs1mVLuS7bamsyT3LSFwhiM6NzLrMol4dFjgOQFAw4rW42bjbIpou/iwMpYKih+
         yx8eCVq9UYVRL5B0YiXvQ309AcSraE44v7XLQaTBXXeqzCR4qHj6cXBYj07q5zrpQKAY
         McRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwsrcGvn6t4wtZehl4uBhb01N6UHtCWTMY6VHbPW54ltxp0AbEhxjoD8BDdD4N5T6MFEo49Of2@vger.kernel.org
X-Gm-Message-State: AOJu0YybbBV2DqxP+N5Jwcn5pDfaQ43ZajLIFOcZRamBIFqWEJYKH0Yr
	Xjgrexx4X7DfFNuWJT7YuxzSs0GVfE/t8I4BizU5GtK9oLpi/1c4gAXqW3teOsu/1mudabFfsLB
	PmnzJaoEYxCo/gvzw6BlsBtrz+KmLIynbBaG1hVxx8ZhO4fI8P37XuJ/RLqM=
X-Gm-Gg: ASbGncuSbH3iuE5tNdZioXw2O0REPcBAEaYLCzMMBgQHbrbzJ0TWmbrZOrLncoiTmVk
	fHODrWZM3a6GWJXIypTA0ekIToIebHnnJtsdXjoWhZqyUqyFBNfg+LlP7IRBv61nD3E2UbBH5Iq
	9n5/PzflyfpCFohp+VFTzNlcAVeAMoLAJ2HipiX2N3YhN2CRj2jPuZ6H2MlyJPVnc1AfCz1v41y
	51TmgpSqwc1C3fRKa6AED/Q0HsIORB8cUTUwqcYZNYaktiX5janK92NepYD+ezBwVssRoBmh1iV
	DLSUg7FIQLoPuVK0d+DZR5q/AGFWqdjyKJyFKZpxmz70kqL48fcIVHn2YwepRmnOeQ==
X-Received: by 2002:a05:6000:3108:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-42704bc0d07mr12668343f8f.18.1761049680398;
        Tue, 21 Oct 2025 05:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1T4QV5qRlsX4CYwsG5oN1xf2PIguQmX22CXcPAmlJ9zIRBsNadHzlZspnxlqbPcWGqFc5PA==
X-Received: by 2002:a05:6000:3108:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-42704bc0d07mr12668326f8f.18.1761049679993;
        Tue, 21 Oct 2025 05:27:59 -0700 (PDT)
Received: from fedora ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5bbc50sm20425188f8f.21.2025.10.21.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:27:59 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH v2] x86/bpf: do not audit capability check in do_jit()
Date: Tue, 21 Oct 2025 14:27:58 +0200
Message-ID: <20251021122758.2659513-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The failure of this check only results in a security mitigation being
applied, slightly affecting performance of the compiled BPF program. It
doesn't result in a failed syscall, an thus auditing a failed LSM
permission check for it is unwanted. For example with SELinux, it causes
a denial to be reported for confined processes running as root, which
tends to be flagged as a problem to be fixed in the policy. Yet
dontauditing or allowing CAP_SYS_ADMIN to the domain may not be
desirable, as it would allow/silence also other checks - either going
against the principle of least privilege or making debugging potentially
harder.

Fix it by changing it from capable() to ns_capable_noaudit(), which
instructs the LSMs to not audit the resulting denials.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2369326
Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on exit")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v1: https://lore.kernel.org/selinux/20250806143105.915748-1-omosnace@redhat.com/
Changes in v2:
 - just silence the audit records instead of switching to bpf_capable()

 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4c93d9e73e40..de5083cb1d374 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2701,7 +2701,7 @@ emit_jmp:
 			/* Update cleanup_addr */
 			ctx->cleanup_addr = proglen;
 			if (bpf_prog_was_classic(bpf_prog) &&
-			    !capable(CAP_SYS_ADMIN)) {
+			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 				u8 *ip = image + addrs[i - 1];
 
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
-- 
2.51.0

