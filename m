Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772202F7F00
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153179; cv=none; b=kC6OAQZccqNW2l/A4IjQ0cVzFEZqT2I+/Dlr8FGFNMzOoZnueUxa/JgXQEIvwcCVt0KNtadhwOI/YaYHXTY8O+pgwG523dLHKJoHhpoOg/QCcPyHTM2ANHqUPxLK6X9L+xKcdIJqj+jsaimVVtj3YiueE/5KTVSkAVz4RpPHajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153179; c=relaxed/simple;
	bh=yAYtOucJ0rIXPBCqqV/MQCF6f++xnSJG9BbJdRR9UN0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kY2LpYusY5cNF8OwK4lzaQcFIL/pByiOmP6PLSXt8sK04xav1mrnjhKvGHj9pIdZjjBGvPP5ltLClMYPioMjCduQOhpq2eQqPEKXwbWAqkEp8mNgdieHzYX6bBPeeG52mffJYPxOqPHtimCOsydqm3bNcWoTLb+gBHbwMH71T5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYmGGUG5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FayRGzbl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYmGGUG5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FayRGzbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785153177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dT2pZru7DhE+FIRyt/8RsNPGIuwOkcBH6IziAfBaEQY=;
	b=VYmGGUG57b0afNU6yUI5B8Yve1IXYrkPgPwEhXLuz7GeQrVChv3LvS/M+DLt0Vn0LyX+CJ
	t/B6j8+jiVcb1xt/3EWowRHXjwZWc2WPhtBQtEz/2K+AslVfT7rQsGCKqgiHDxmRO7LqHH
	P9agN6ZKbQhqFRbmfM8po3Ls6TtYyqw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-0RCA5faCNv-zofkwXdvodw-1; Mon, 27 Jul 2026 07:52:55 -0400
X-MC-Unique: 0RCA5faCNv-zofkwXdvodw-1
X-Mimecast-MFC-AGG-ID: 0RCA5faCNv-zofkwXdvodw_1785153174
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1c25c44d15so372035866b.1
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 04:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785153174; x=1785757974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dT2pZru7DhE+FIRyt/8RsNPGIuwOkcBH6IziAfBaEQY=;
        b=FayRGzblUCc7irIOK/zyXBCQ4t2HTajheYOwxRLvFgjOHU/JxPQ3r9k/cEXGFElgWv
         +3uOrAtPLeip7bG8PNg1a+76wDdRrZTX57bvas3tR7hTKOkLJiIitQ11WKS9HqsjRyqh
         ezyH8t/qVPcgYI2EGwfyNrQJDZnPJaUKoFVYL4g+vfG67KNnNNWBQFWT9rNIw5MssWgO
         BzhcPHIqfqtVMF9D/XdJdgDpX/U7P8B9XaOD1VNLfYQvlgOYo9n9lHGXF1YGOOXWWcdl
         sla/J+LZRhlS4HEtQ+ZL5aJx2o78yTGOwAj0m4ub8sEfydcaA9onbXF6gJMrXx94U5Ej
         Tkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785153174; x=1785757974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dT2pZru7DhE+FIRyt/8RsNPGIuwOkcBH6IziAfBaEQY=;
        b=HQopg34O+3CqcnjYa4pICcFsgLsqZRm9EXic6cl4qlzWSRKSreZpO9l/n9OBHhiPeo
         3v7vv6GyQgiAY9yrlk/vx21mRpqGvmpo06JMjnFhReECPLIwYfzE5UjOIdTqzllR8rVc
         U5gEVv/FbjEAp6H9xOkiRQZNWIkODq/QKMY6VmTPOZoCGZPvOez5NKTZKuL2GonKXjGY
         NwVBBZ3Qv1oIa6s/8k4kRt611HwYLHE8Am9ziZwPGdBj/YIkYJqbYttb8H1PhFCgS8uc
         JU4D9LvNvu8JPmiQ+bNIXApo5sTlTaQVIz0id+gtiPzL9x07WYGWBxDUnthqDIXVILIp
         U49Q==
X-Gm-Message-State: AOJu0YzmkGtFZEBfY+untLNzBFijIoIQbjk8OURFiMDUlm3pg8jszSvV
	bE13+uzByPRzfc7rYDnfXov4hkwAcSOzZR1/c75eDe2exnaNLWSl8YItA8zofoc2XCSmtkn8x+o
	BVbhjOUnZVuEHrzrqwy2IDs+T6ChTn3uMDxaNucCRDXo9KQoZ+rKV7UntLYlf9tYnAT0WTjzrkJ
	jYlBx1YqNIxjmTCzLWQPZFcL4+jUuFrOpV1lOh/e9C2QM=
X-Gm-Gg: AR+sD12IViP71VpPJNikCHFhbUv2wArB6+m0I2/60sFG8F8QSPYwzkmhHrvoNnQCpHO
	/slTOa4yD44akD5oxETYFlBs/jeLA1Eoj+q7Z9+W1jZu6hnDF4Hb5bM9AtHaDG21v+qJ6J3qOLA
	6ASbGZJtdPlwNFWBoUvuIgnTvvKPFNpi5D3fwDN+Q/btak5tp/LKKD+jEAP9iPt/L0Wdfq6tYUI
	KoJx4LF77sfd/C2vaJFXcEkgEOM4KUbdsNz2rTTciwr1oYv7nPBUCscsXnplKbYy71dbhAEp+lC
	9qihJhLO3hbYmSb8odsDs7quPQkHebRDl1GctrI0517KMRxFhJRDpZiLtw==
X-Received: by 2002:a17:906:9fca:b0:c1c:1e4e:f911 with SMTP id a640c23a62f3a-c1f1f0ab15amr357114066b.30.1785153174512;
        Mon, 27 Jul 2026 04:52:54 -0700 (PDT)
X-Received: by 2002:a17:906:9fca:b0:c1c:1e4e:f911 with SMTP id a640c23a62f3a-c1f1f0ab15amr357112866b.30.1785153174013;
        Mon, 27 Jul 2026 04:52:54 -0700 (PDT)
Received: from fedora ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac6ff3sm629489166b.19.2026.07.27.04.52.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 04:52:53 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: selinux@vger.kernel.org
Subject: [PATCH testsuite] tests/file_contexts: avoid using a C99-style for loop
Date: Mon, 27 Jul 2026 13:52:47 +0200
Message-ID: <20260727115247.365341-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The for loop in assertContextsMatch() seems to be the only code that
makes use of C99 features, which means that it fails to build with older
compilers, such as GCC on RHEL-7. Avoid this by moving the declaration
out of the for loop.

An alternative would be to instead add -std=c99 to CFLAGS, but it seems
simpler to just revert to the C90 status quo ante.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

If someone strongly prefers the -std=c99 solution, feel free to submit
an alternative patch. I don't have a strong preference here.

 tests/file_contexts/internal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/file_contexts/internal.c b/tests/file_contexts/internal.c
index 22b5790..20ab428 100644
--- a/tests/file_contexts/internal.c
+++ b/tests/file_contexts/internal.c
@@ -13,7 +13,9 @@
 void assertContextsMatch(struct selabel_handle *hnd, struct test_t *tests,
 			 size_t n)
 {
-	for (int i = 0; i < n; i++) {
+	int i;
+
+	for (i = 0; i < n; i++) {
 		char *context = NULL;
 		struct test_t test = tests[i];
 
-- 
2.55.0

