Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E63F1640
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 08:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671340; cv=none; b=hCWf4lcIJOf5mavdQJ7Dx3MwQL9I8FhEpP3k43a6hYGhIX1Wh2cgMnq39CKvtoFJCwnkHRRm+W7jNGva4YBcWtZ1LCqJcA2dBYoRe21+RiRQEpu59kjgrmZHViURtyjGN7wuoD08kZvluxXS576FAUFt8knfJuYjIBWm9keMr6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671340; c=relaxed/simple;
	bh=zEg6y5N0q2QUlS3wfyLg4QmIvpOfWUZE2040HK0ZAVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pa0W3Bsz4Y2DjOgrJnWcnXPMY7C0Q7JwxQY7W1jzoWOfegYWXK2Aw8Qz+2VGmKEQE8T5k6gF0YrQagpKjdWxYj9IJ0JmaVHqjet/jK49eXOTkW533CHVg/d5jUMJ4APoz2vuUt7Of1ZlFi/FJG/ZuzaJ186Ve3f/Vmw6oQh57uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPi4sJP1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YqRlubOH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPi4sJP1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqRlubOH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783671338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z3iCHY48naw0yNHqqlbmkHn2MkoKgLURvdtGfp/VNWQ=;
	b=iPi4sJP1dCCTirE/Bvjl3YqLNEhOFvisOXK1wwHyAYfxg10vSfImvNnGFRBtBRmByVsqj6
	q/8VwWhuDaUz+nAbY+uQ/HM47QHzs0P7/+IsPC0+SiJ5s4httai05wggF1orrnkHpb30Yy
	nwZmfAJwp2tlEqYa8A0xMIWcNX0oJMc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-e4ESwS9HMWiiFR9gqBD9JA-1; Fri, 10 Jul 2026 04:15:36 -0400
X-MC-Unique: e4ESwS9HMWiiFR9gqBD9JA-1
X-Mimecast-MFC-AGG-ID: e4ESwS9HMWiiFR9gqBD9JA_1783671336
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-472a798fc7cso378885f8f.1
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 01:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783671336; x=1784276136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3iCHY48naw0yNHqqlbmkHn2MkoKgLURvdtGfp/VNWQ=;
        b=YqRlubOH6jf0CdEvh3ZTFHIkBMmvy4QCCDKhE8p+T3zHDRLo6rizRubP1+O+WXFuCA
         857Pd1PNABQfVsYbFh7r0lqusnEknIdJxOCB517xj0sTYtCddbgGha1Qydibr9kkaCFf
         53YGMnGDr0+NTGzES5/Ka4f8KEOKuFO2MHGO4rE7IJI9sq5ZuxC5Uzd9oXmhcRhyrH40
         IlFnolR+n0ieammQCHKqVP7IpZsf3CuZIByENhPBRmzZHrWzrJdcLBMPFzwEv4FOU1Dx
         umzs2nosAR43Xm6MR5gXR37KAv/I0B08aTmlRlJEA66mnuEBYixXBkZZ0Utk5VHKysAP
         +bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783671336; x=1784276136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z3iCHY48naw0yNHqqlbmkHn2MkoKgLURvdtGfp/VNWQ=;
        b=AGh/0QtkYvM0f7JyCNe6N5vWOQOAWNdW5OzloWgD0bmgc6V1NC3V96QQBCSY0lF0Y3
         5yTiUC/IkMukFUWPoZctX61RtXF/Sv1rjxmhEbGIrVCdPXA2CMHR3wPVNoTJrJUmXAIu
         uOdTE0mFqmX15dEcI1poo5Y/r5sypf5kMGSNzfFBC3ZPsIVwAzh1clC0cAQWUwTRhKI/
         b0RkdZhAoMumKMIw9+/FOlfvvr/pMIdLSHsIXRGURNdWMX6+EOz8j7nnbrITq5POZ7l1
         nADc4oAQaGFvFD0xtUMbQ8LY+7yo7cyqas0hUxGTG+ZzGlTRT3yU8TfOwAivEtgNngy0
         jKrA==
X-Gm-Message-State: AOJu0YxolGs7Re82DIQW+N1mwmMIfF/D7nIJb3a3ojz2CA57QQWp52yG
	wsm94r4gTjjTNEmaDgdY+b0ChZTjhQbJauExTMlqnHurw2mmjbdW50YiL3g2rECkChCeROmjOOq
	4p4+zGqRBGVc5oCOjrIgWWXjui66q2KAoFMKkNyW9dMb+A3BR0UIetL96rG6eNO/lFHw9R0ChIG
	qwP6+ig6yhxectXFotPTt8QDac562/JLQuwmZ90vzGVb4=
X-Gm-Gg: AfdE7ckHLrsZJ0uahoA7hQ7PK46KgbTN02u2ka5qOSzlzZQrb3I7ptT+T2MdQdhfUbk
	h+jaLJZAX3uLPGaaEObPV6SQVfEr16jemCYLjA0ljC7VX2+i2Uo7/JfMeOSTrhSOrxf/5bRyLBv
	uqxPi3jIGdFOnkX3FY6ujIky9Z7I7Cm6gTAZzBUI1XSXYkAD85o9pILcHIuDAVOHaHfdyFXQyqu
	xInF+fckwCxeJy2YATpWXz7ZtmRY+fBnGiaktbITtm4xCsIlybw87j0UfXXxH0Ug3bDqNdMz9oL
	tP60O8nzJLMIY5kYQeJYPHkMYt/F0Wpmum2bgbUa7xkKuGy+oEYMADUr0gWLZBgv22sh6cgb6N2
	zKh8eY1r5t+izs1rTW2p5cV2ksXger3BZ+RDXM50caJEYQmacp+NG7NgumxNwx95ild0=
X-Received: by 2002:a5d:6f09:0:b0:460:51f6:6248 with SMTP id ffacd0b85a97d-47df07bd8f5mr11554495f8f.27.1783671335591;
        Fri, 10 Jul 2026 01:15:35 -0700 (PDT)
X-Received: by 2002:a5d:6f09:0:b0:460:51f6:6248 with SMTP id ffacd0b85a97d-47df07bd8f5mr11554446f8f.27.1783671335145;
        Fri, 10 Jul 2026 01:15:35 -0700 (PDT)
Received: from jonderka-thinkpadp16vgen1.rmtcz.csb (90-177-145-101.rck.o2.cz. [90.177.145.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b0cesm59056678f8f.22.2026.07.10.01.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:15:34 -0700 (PDT)
From: Jan Onderka <jonderka@redhat.com>
To: selinux@vger.kernel.org
Cc: jonderka@redhat.com
Subject: [PATCH] skip inet_socket/mptcp when CONFIG_MPTCP is not enabled
Date: Fri, 10 Jul 2026 10:15:33 +0200
Message-ID: <20260710081533.451115-1-jonderka@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jan Onderka <jonderka@redhat.com>
---
 tests/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index 4fe6f3c..6db1ae6 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -148,10 +148,12 @@ endif
 endif
 
 # MPTCP is supported since kernel 5.6, but only works with SELinux
-# since 6.5
+# since 6.5. Skip when the running kernel was built without MPTCP.
 ifneq ($(shell ./kvercmp $$(uname -r) 6.5),-1)
+ifeq ($(shell grep -qE '^CONFIG_MPTCP=(y|m)' /lib/modules/$$(uname -r)/config 2>/dev/null && echo true),true)
 SUBDIRS += inet_socket/mptcp
 endif
+endif
 
 # nlmsg test dependencies: policy >= 30, nlmsg permission, netlink_xperm capability
 ifeq ($(shell [ $(MOD_POL_VERS) -ge 18 -a $(MAX_KERNEL_POLICY) -ge 30 ] && [ -f /sys/fs/selinux/class/netlink_route_socket/perms/nlmsg ] && grep -q 1 $(SELINUXFS)/policy_capabilities/netlink_xperm && echo true),true)
-- 
2.55.0

