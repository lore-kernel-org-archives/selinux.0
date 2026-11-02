Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624754;
	b=MKz/RdVnr7vVsaoWXnwhHWvg7/kWPrVn2LJw/9+lzw2bp0GDyrSWfMY/1U+jLYBfU0zh
	 xQaGZxiVKlUyOeDL/RKzvJkcGnI7p/6tCDhHduFHslhafEvWZVxgV9GNsjf2ZK4ypLjoG
	 KvxlWZ+1Atv7uczGgALJx7nv1ukoh+uUJYXMEgKAWeM7/luvq/9XkmqoZ6knjRSRJnq3k
	 eg2pVSo2ZEcMBHAIga48NnPlzxhqOdQrQ8J5a+aETEAFxdWdJElsWt2IAdZmttimBAFvE
	 cRxzzN7bXxgPcyCsZNPyjWWbx/U7DLEiZ6ViOqnX0OaJ/yIEieI0IKOMTqzhhQuBHkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5+CKV2a9uSJXE8IL7OEAdMc0Gl4AXPHPPqbNXqoLHZg=;
	b=3S2x32VJf1n1yiyw8pIKWCgJ0DK3L8f0PbZUoVOE4UgHZXY/MtOfH0XmdG8iFyKGh2yZ
	 1c2j52QQWwR9J2zLT9Ui9ZZGbHoyGBm48yHekqtux4S/Rf91vD3GJ73pw22TbRXGkBJi5
	 qr9cuPIu88sJK4RDwzJGA4XOQdURYDnxsS+fj7aV7v/i4mzP08vnYqO2wbu/HOqcZHnnX
	 xxXVKY3LANTzR0rjdm4BJINfVYWSlcJhe0ufYySptAE7PoWWGvzcYRRk8Ef3jle059SZU
	 sO8Q8KiOTy8SqH6OXPOlrHH/EGn+a1fi+/FpeJOnuZdNQM4CmOrkm3qwW5LD5DIKiNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TeXZTA7G;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D7606A32C
	for <selinux@vger.kernel.org>; Mon,  2 Nov 2026 13:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D6D7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TeXZTA7G
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a210470b49so23930335e9.2
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2026 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793624752; x=1794229552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5+CKV2a9uSJXE8IL7OEAdMc0Gl4AXPHPPqbNXqoLHZg=;
        b=TeXZTA7GEKZehOoXEp7egkFOJZBhnkKzBulDhjNUKEE5IVaO13Za/OnkuhFhN4Vv6M
         6p0sq5msqhGIoSl0/OAOgqaBand7bEe8qdu4hKnx6i5z+g0Lzoa/bA7wNO/ZQR1liqzm
         Y3UVQekkDd+L8AakxpJG11/gLOIqAxHj4zD1WHhTCYW7lmKZAwRBmSVgC6HhDw9GTFxh
         y9xbXf41jcONWDdYe8Y5D5m5MwkSa+AM0aEzrg7bz5plV3DfmJW3v0uRe5s33qv6dtap
         k6aq/wTCXU1wyEPRViS5ONu3nGifXIBJdoZYYkLmonVLlWeiRwsVXU9yvBHDRrTuLeN9
         WtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793624752; x=1794229552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5+CKV2a9uSJXE8IL7OEAdMc0Gl4AXPHPPqbNXqoLHZg=;
        b=N2hw0sj4Iv9OcsGAS3Hainh3LE46gq88DrhPyg66hD/qNdvKiy6SVHvbgR22/vSpDA
         ISMW6CoAjgUZftstvCQXGKHmjRhD0+SIaQHnEfuSGXKMohL80WpsKd7E9fbbQxq3ndWe
         ZN8ZzB2c+P751YT6SoRjDzVKTGczdlbfH4N2FLey47uq2+4lfiMJAALE5Q2xcnyaOprz
         6ceuEOkwI4Edjg8ukWRkIug69MQYf3Qq78uDGSqrAeIXitYeKRxnGmxQ0jEB4SFUBh9l
         Z4U7iE455B+XHhBO/ku5LyfGB8O4m+aeIxq3UtOFdBFJsR382kWQy2z1T3hCPwH4iieR
         ESNg==
X-Gm-Message-State: AFq9FYLlinD7NE0OunSO122vyf2KTLa1oVygbfTWpQyPAjCYovXlIhJo
	u2g8awls9YllqMTM+UFXiEiGDtnmcZp/zDxRYDFMbi+UiJQKivhLs0eOMAuuJf+F
X-Gm-Gg: AYBFou3f1FjNj7J7ftk/0uLqWWhXsKIRH/QN+4Hv0t+14j2oPWmQawEKKNAlwBUexWN
	DLjE7hxI+8/NzybqOebLhWR/eEHL0bs9yJWpPf8n3j4RlI1z0LLDoChPLEbVuUA6OExGWI3Lq4Y
	nOxyfCDQhb4Qlal5bfFv9EgOXNc/mYYfLXlxTKyeL0936iwoLJN3sDsU5esFBHu7iQ+Tz1nGdkm
	hH5ql11dE+m32IcT1ledfVeFAHA60cVQYultb0kSK8wTkJdrSriW6aOPxqCpiKkAfimr9iy8MLQ
	CNfN9LDsVdAzknhh31Js1BYvWWGTZqYgN0Fp4VDr5RNYj2lF5twKUp/USsTxjcuWETbYBF0mKy4
	S2jikOGUWi11WlHeI9clpgXpnnvt3Lzd8/+oQOmZ10VMXFxfiYANpwwsX2LDw2SPEzS2OtzUx4O
	dRkVcHcwDjsCoLZCCYjWakjxrLd0wxI66OyRDxjZyxzP1epPRYmJ2ytaMB7XkgdppFjRN4qi7IU
	rXkMbSwRo9p4Hp7dC2DVyt4h9/lUe/5Y15vnfp7SyIWbO89jDJ9OW3uAfkubRDlPG9I+sVo1N87
	/2YnZSw0f+YHry36rFzOnjTf9aQimiSkWBb0zhS1aGt7T+z3v8SoSWxY0uuLGFsoewvM2AdTOVT
	e3zH82A18
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id 5b1f17b1804b1-4b2406bf3d2mr10347125e9.23.1793624751927;
        Mon, 02 Nov 2026 05:05:51 -0800 (PST)
Received: from omos-acer.lan (109-81-86-162.rct.o2.cz. [109.81.86.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09bcc967sm204846215e9.3.2026.11.02.05.05.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:05:51 -0800 (PST)
From: =?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH testsuite 1/2] DEBUG
Date: Mon,  2 Nov 2026 14:05:48 +0100
Message-ID: <20261102130549.252935-1-omosnacek@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 tests/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/Makefile b/tests/Makefile
index 4c8e82b..8108b40 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -202,6 +202,8 @@ ifeq ($(DISTRO),RHEL7)
     SUBDIRS:=$(filter-out netlink_socket, $(SUBDIRS))
 endif
 
+SUBDIRS:=unix_socket
+
 .PHONY: all test clean
 
 all:
-- 
2.54.0

