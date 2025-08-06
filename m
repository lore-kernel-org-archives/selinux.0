Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC228AAFC
	for <selinux@vger.kernel.org>; Wed,  6 Aug 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490673; cv=none; b=gJIDKiFDttAU2H5KsQCfi7NclKxKXvkZlGjUmmzSkqQTfm7FBNIylVmlaGb/SS7h92vHSpGiNdLdvtAKYIaSeNOK3FGSY7i+zaf0vDP+RNpzgw3io9oBCBHrGLFRvAI5iLet6iCGQGNLPC79jFWfMxZfE1d8hsq8/5kQ9BmNUb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490673; c=relaxed/simple;
	bh=InkPhHeic8qB1Cg9YLB67GOAs9m8OvwtVDVuqy0Xq2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=db2utXjdRg4IaHhE9rVMwqQsAJSnwvcaRkWk5a3eF6rECUCrQGTYymdNKn71v3TaYQvonwRU/AEoKWkU5JHHlITsCLXxtgs5UZRcpYtu8716zkqYzXwwLpDlcVqHhg7HqaF0jFrHu2G+ZTfwxWtC6cqyfksoTchNWgQcm0UqEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHDxpXJU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHDxpXJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754490670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QRCxO5LEsmHWpUSNSPauqINHADCftQQ6v6EfUX21S/M=;
	b=DHDxpXJUT7s+5QTuKpZKjt/AR+6azcTfirzJdPtoQwmsWDF9g87u9RRbR8Ue6mIPywIL+6
	IJwp2NzttDnOGJY04CYzQwccx70YcRgQeVLHPglQGFNy95BnV6ht+fQ9lXIopP7z4bxUuw
	3y/bbMZymRI+a2FVLgPhvNEUSZTz14I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-r0aFwbftN2GvCgTQbLFPtg-1; Wed, 06 Aug 2025 10:31:08 -0400
X-MC-Unique: r0aFwbftN2GvCgTQbLFPtg-1
X-Mimecast-MFC-AGG-ID: r0aFwbftN2GvCgTQbLFPtg_1754490668
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so30156475e9.0
        for <selinux@vger.kernel.org>; Wed, 06 Aug 2025 07:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490667; x=1755095467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRCxO5LEsmHWpUSNSPauqINHADCftQQ6v6EfUX21S/M=;
        b=V3qUP7bKBoz9yLyZyuVNSjASeHYL+63EydXUaHHtFycZqgksAwXvCHlMYTpp27Ph03
         dExnjLWG0nz+EtI4//YdEaBNhBM/tLK2PkmXOKRIU9USPoVZJHW4kuqEQ0dqkJbiMAcD
         QUmFiFf2iC21qRpgd8C0lo8JWScs7E6oYp+yTKSkT+VyCHV4yGt8KhhF2jmzXDc66Jqr
         TbGgOJorBWXM2jPbvwM09pT5yY/qa+17DIeA/Uyukl0dqUmHDMFEMFl+YgAI8NFUtY7v
         3Vzjd0ck77QDG1med8CAiTBbF8SCLQR2eCBk3wtNUN2RcXoCe7+Vswmh5HEP0hsDcCNy
         rqnw==
X-Forwarded-Encrypted: i=1; AJvYcCVWQ1rT8ZdBZsiDug9j2AuH1/Yar/BEDMWojhSK4VmNJPMR5pC6w/Y/5wack93bK/8x8obE4erZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzfApLNie8h8p0HNLxZf6V0WtRu00B2hwLx9o4GZL7DWO1NblXC
	zyGpg0dVugEnghD1L/NMyIwNqaqWgyCW4ThkWbQ2C8tgmE37ZgMRjgo7YMxZQ5P8zPPI9fqPjka
	EgGmIZ4VrW5LrqxwQA/aMZNOyquRvjq4AP+NLUDKnkRIOTcNBUBxbPvKt5Fc=
X-Gm-Gg: ASbGncuiAdqHArPkJnyyBQSvMbip33CYony+KfSsF1CrGPW9mzpH62vSeTLL9SoYfwL
	xmOPy7vcBwUOmCeeeObn+7k7TzXPS5HyuY1PJyzkhckq2O/P8syv10ig6CPQfG7IWHKR+W+QrKI
	AJqKgrKbM/MpsVpOQ4XD9S1Vs0iTDswfKr240fP4DNdvIEdzrqONB66Ibat5XzZAhtbMaTYBPl8
	odXYB2ULfz1K9rRy14uwJrvth0TQW9Ip61s+UTkOC0d11JRuqq0JR1pcFdATodxRFSzyN8VHABG
	NY/y6GLYZ5HjwNhiiWX4yFS1tvINCllcAkY=
X-Received: by 2002:a05:6000:4029:b0:3b7:8fcc:a1e3 with SMTP id ffacd0b85a97d-3b8f421057fmr2658545f8f.48.1754490667552;
        Wed, 06 Aug 2025 07:31:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiJBQ1yelVUM9E1lMgUijAACK9NPTXg6PpQUczFaIPct+wwXKaPFImCbN1OzlcZ3oUMOB6dg==
X-Received: by 2002:a05:6000:4029:b0:3b7:8fcc:a1e3 with SMTP id ffacd0b85a97d-3b8f421057fmr2658518f8f.48.1754490667074;
        Wed, 06 Aug 2025 07:31:07 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e009e465sm14204156f8f.43.2025.08.06.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:31:06 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] x86/bpf: use bpf_capable() instead of capable(CAP_SYS_ADMIN)
Date: Wed,  6 Aug 2025 16:31:05 +0200
Message-ID: <20250806143105.915748-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't check against the overloaded CAP_SYS_ADMINin do_jit(), but instead
use bpf_capable(), which checks against the more granular CAP_BPF first.
Going straight to CAP_SYS_ADMIN may cause unnecessary audit log spam
under SELinux, as privileged domains using BPF would usually only be
allowed CAP_BPF and not CAP_SYS_ADMIN.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2369326
Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on exit")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 arch/x86/net/bpf_jit_comp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15672cb926fc1..2a825e5745ca1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2591,8 +2591,7 @@ emit_jmp:
 			seen_exit = true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr = proglen;
-			if (bpf_prog_was_classic(bpf_prog) &&
-			    !capable(CAP_SYS_ADMIN)) {
+			if (bpf_prog_was_classic(bpf_prog) && !bpf_capable()) {
 				u8 *ip = image + addrs[i - 1];
 
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
-- 
2.50.1

