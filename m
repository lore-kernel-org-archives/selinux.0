Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031C41E6DA
	for <selinux@vger.kernel.org>; Tue,  4 Aug 2026 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827706; cv=none; b=QqLaMjPO6pbD3/iw91q9ZwBEm0BbwQr5oRsj/9bA8VMC4Bbyj4m6an5u2LUkuaWgt+q2PKic7jArL+1PHd2TYJVihKopYAEBUfkJBmqPr/rtygAy/1sZjnLzd4aXxo4NK311Hvr+C5sZm+CycivTsTV/WPyzMeGj1XTEvZHdVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827706; c=relaxed/simple;
	bh=5SjCoQ3h3N9tVpxoKsGCWCS6QP1x1dou3q2i7SPMwHw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FAOsazxuD8yYKm5MP+oxm0Pn/YK8G/Y8HrdT1oqWQwW9iVyUZCC0jQ40uPwgcCWT68aRugucwhBW1bKL49paw7lQM5i8hyPqEjl9vgnPTtpkY7gMYFmO4bTNXQCk7Tup3DCJqFCiaqmi3N5QQSOzNwTIrtqpfkkgaGy4TS/fNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFJbDMlu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIFwyM30; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFJbDMlu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIFwyM30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785827703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HGRuNrOZJLGjPgyJcTq9PCn8zCdqI+t9HvJj92sOlsU=;
	b=dFJbDMlurABqvkFs8zwxgNxQTUy7mvTKM3kOHeCFI2uXSzwgysl7KynKKgUbOjyXbQcYSD
	nN9CxWD0vxREwKVlQ2n3ir5kj5hdCC+AkxrWelDPS9i1rSc6+dJrOsYwpa6SssTMOgOnkc
	isaSG9B8iDNw2LrhWaiMObCaiiY9nSY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-7L13aOEVMBKVUXLpgDftJg-1; Tue, 04 Aug 2026 03:15:02 -0400
X-MC-Unique: 7L13aOEVMBKVUXLpgDftJg-1
X-Mimecast-MFC-AGG-ID: 7L13aOEVMBKVUXLpgDftJg_1785827701
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47fe85684b9so493509f8f.3
        for <selinux@vger.kernel.org>; Tue, 04 Aug 2026 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785827701; x=1786432501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HGRuNrOZJLGjPgyJcTq9PCn8zCdqI+t9HvJj92sOlsU=;
        b=iIFwyM30OqAtUD6ZzrrViP1tc2//QFZi2J5lOtaJ3cug8yfEIGPeqiEx5QK1Rh3ei6
         vGVmNRb7w8/uhPKrGLDKsP/zUpJAc6yzpVadczNUoKMlm7FD3xhox/nFOh6zfUk8fDbT
         dulhUInkOC64VF0IESJHjN/MA5VsIGSpezNV1MeoM7VXuSSjmXwcX+tPCfXuaLEIZTos
         AALeCB5pMu49KGcVwxluoa9B+wSZHbouPjZ0cfPt06A5Fww1nHn1pzlJGqqWoqa7X/fH
         SVbT3OGE9Wlq0MjoD3cQ/v9/wJztyWW12A1RJjUXDWt4/Fd5KbSZkzSx35hkuw0XgJOF
         uTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827701; x=1786432501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HGRuNrOZJLGjPgyJcTq9PCn8zCdqI+t9HvJj92sOlsU=;
        b=kpY33vyDJnFsdj4a3PZypTwBwjOuxAtYAa4+aVPeaJ0zHWHqWJWONctOOLcpLfqC+y
         CIYLV2PJa3I1PMwxCOzzbZZp7dsSYrTURPHxNJzL1SbiaZaEdAOgoq1wYFmr5ESHGi9m
         P7CSoUXEhm1aODoEI//iOs0g8SpKZdbGsSl29uwvOEv6x8DSLhNdq2cUF3W2rZXOGvPZ
         CHtn1s7Hsq27rbG7QFVHLfPs+4pyrhxGS8rrs8oi8lwY31gPQVBVh5zN6IrMBemXFrX9
         zD+1498bVxgpzQOtlD/zF8yKVx+ADlqfmxCFEdYv4/YOCjZ3ySKA//u6ATo4w4Wj/MKW
         DkpQ==
X-Gm-Message-State: AOJu0Yweis5UBp0/eZujj/ytkn3GOQ10E1gkeIC0ni1Kq9ppjk2UpSke
	0rvoOjw6D6kqfxLCoo+l5tNrzRXDSCEUdiGEPf1tRhJx+D+oiow3AwEX5zt8JNbeOvhI7sj1nre
	EBQknjb1Jlm2M99Vria1WPjidQ4NK5bZOALS4hmukJjQX3itzqlhDNG2takVv8F0g+ytuSKSnll
	4lcb1Nj8cUmDebdVGglM/89EMGIkhrfRHzZu1azfdox+w=
X-Gm-Gg: AR+sD12BHgZG8PIY/yxj/NCJBvG1qKIwxJU77fFyW7iGHsDZuKnRCPH8VrSVHyenutd
	VNEJvo1cTKRu2H0YTPuBnDa/mc37bGwY+M9uDe0F86YRnadZvBnUMivbg3D/2WNSWY9j+1vocJs
	jKSCHIMcCTCHwehh2eFVe9q8cFQqMkWuqqzYcXED22rM21YWQ6kpUigcUlmtc7m6/3loNBJlPL1
	AaQO+oD93lLHAQa/3cyyQzXm2yym5hTh3qSSp1WAJxw9fHUmTamA33kefkkdyy32ud4Y38L3vXM
	mZvT3Mbyd2yeG/mUFcU3KQ66U2MQ/oprqy8UWP962OIBgReNE8wjLBpC+Q==
X-Received: by 2002:a05:6000:188f:b0:47f:c62e:9cca with SMTP id ffacd0b85a97d-47fd9cfd167mr33583555f8f.22.1785827701459;
        Tue, 04 Aug 2026 00:15:01 -0700 (PDT)
X-Received: by 2002:a05:6000:188f:b0:47f:c62e:9cca with SMTP id ffacd0b85a97d-47fd9cfd167mr33583473f8f.22.1785827701033;
        Tue, 04 Aug 2026 00:15:01 -0700 (PDT)
Received: from fedora ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e2abbsm41292923f8f.9.2026.08.04.00.15.00
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:15:00 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] policy: allow all test domains to inherit limits
Date: Tue,  4 Aug 2026 09:14:54 +0200
Message-ID: <20260804071454.2122438-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the "minimal" test domains aren't allowed to inherit resource
limits from other domains. However, that means that their resource
limits get reset to at most the init task's limits, which on some
distros and platforms (e.g. CentOS Stream 9 / RHEL 9 + ppc64le) isn't
enough to run the io_uring tests.

Since the rlimitinh permission isn't tested by the testsuite, it can be
safely granted even to the minimal domains, so do just that.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/test_policy.if | 1 +
 1 file changed, 1 insertion(+)

diff --git a/policy/test_policy.if b/policy/test_policy.if
index ea15ca6..2a1a575 100644
--- a/policy/test_policy.if
+++ b/policy/test_policy.if
@@ -42,6 +42,7 @@ interface(`testsuite_domain_type_minimal',`
 	testsuite_domain_type_common($1)
 
 	# minimal set of rules to substitute missing domain_type()
+	allow { domain testsuite_domain } $1:process { rlimitinh };
 	allow $1 proc_t:dir { search };
 	allow $1 proc_t:lnk_file { read };
 	allow $1 self:dir { search };
-- 
2.55.0

