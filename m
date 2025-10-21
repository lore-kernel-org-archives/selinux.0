Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0F32E754
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050337; cv=none; b=jDTHwCK2d5gUjCD3ZaWyiLE9WucaaAGLZp7f0/BAPcljdpaLVbrmxdWr+5wWBpr7FJaYx0Tlh9g4GH/P23sNYlUmjChW+SLWaX2itrHn4dHaSn1MJgej86Ova3FfP7EHVJ0Jku7Xa8Pjg8AsBU3SCkDaWjY6JBx1hK/Vy6vh9gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050337; c=relaxed/simple;
	bh=mHDkxZIgV1WlRJbMtp+HutFhcDGsU2i3APvf9PfVJzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+VYCNtPk52MUr6YrQvh3DgBLRWAn6p3Faz6xBz1CAdPCB+54E4RAAE1HSNLG3oPY+Omr7aMJwGDTpgz+U1VqHag1Tv8Ub0bsMZ1mOz4TLu2O2b8h9psn1N8Una3FZFgcMZ8Be26d3/JPPuwf0vNu78iPKrsXIIUgOAo01diIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLy1KFH0; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLy1KFH0"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-79af647cef2so4682356b3a.3
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761050334; x=1761655134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nouOVrwQ50AtkUiwuvOBNTOWEJPD1kyilpHzlZVLbTA=;
        b=hLy1KFH0orXV0mUdn2nvl5ogcLgJTYxOORH0DnfMX0kIQhraGGs9GnHQ91Hv4fyLBu
         CeUug0bb0OHWKV95Ce5Gjv4/3+9QFAPQ9WIY5PVpbqrDHzQnqNzPrLqVT7zHuwxPpu5/
         6GNiVmXfMLJdGSaGGHxAXbQOBX8+BaKEfjgWKqc/3fAQdEFs5q2CPQXt503uU2Ajj0Oj
         SU/Od+lul81/YyY5t5a7X79wRjgylqiUU3qBGtqAuZ0Rf7WUZ0QJn8P73+RGSZuL3lB/
         zNIOajCHdjEYdqr4n5YUvnzA2ztT/cCuXIVljGXSrkm76OO3skI/xipzMiOIQJzzaByW
         bzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761050334; x=1761655134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nouOVrwQ50AtkUiwuvOBNTOWEJPD1kyilpHzlZVLbTA=;
        b=CXQhBd6LHiU66OB4iDCBmhdNLmYMbHL8Nf2jRfctHrLYZzLq9Q+WajjYhAva3PCNpR
         94LPZuj+IXfcue2D0ZEPmFlvJXnzuki/SlBGH43cFuNC43u6f1l6nS1hnnlhBpzl6L75
         Cgu7ZJcgfERoZRLvAu9epKCnWa6Ee5yqj4D8/xjSSnVVouA4886FeoAo80/Ldp5kzkeO
         SJzg//62svOfjFJi7RZPKlyWam5jCQaN5i7wlPoP93xv1DHvjJef/3Tzd6RhOnB81Dri
         +gJhvS5R6+NwJfwQtf7OSozu5wSpHWS3mK0wDGg6biuyXES1KSlLtIeOUfRqEj37PG4p
         uIsg==
X-Forwarded-Encrypted: i=1; AJvYcCWIFhx1/cJxKYIG8yWZIsFieq6E7wj7BOVqC0GQyH96IgRUXzX8U+xo/zIOR7Rl15ab1Z777/Be@vger.kernel.org
X-Gm-Message-State: AOJu0YzLiejWkrgzPdXGCW7Fm3gIboXISmI113XUVS+W2wbbJDac5O31
	UFVq96onGlBL4tFH2IBrPU0iHPOH1FGMt8MDwN4ri3X3ogXRnifIHCKj
X-Gm-Gg: ASbGncvjhajnqyBfu77U2ze3SqZxVHK70YDRdPd/HjVEZQBDLZM8ZoijUCjjaYJ7I0z
	YSWwvnZlUxx9otIT5YfOY8ylyvA0nn80riAngaBpSS7Etdy/ZFsLdAlQq1iEuPVDGXKM6rTSg4U
	luSFO7iOn7MxI1brR91XbbnGGvR/ff2y3tN+UfTz/kjvjYg2HlXR6Bntf1AE/Tw8NI6itaZddBO
	IxAWautkxG7NBoEHRB4ZbytuyFLG07m1CddS2SbUTFwla+F3r1boUTCWKVmLMEvFN4W7uP9Nd+U
	Tke32CAdIuHQGmpdSeco852HKbocMjAXCDygPxByhfn0r3uqz+nWIs3QbSES4KMeuh7+bKGpKpT
	+dOoJnpTEys0cSvZ5fnsrsRFsI6jpW0RWoBhD0SRzfFSxjg8gx3F9SIwy2HDOTA2/BqOOs4bx+y
	Xi9B86ZFOhrHuEw/NAVMed3YyibdHx52i1SYJ2MJw=
X-Google-Smtp-Source: AGHT+IFwl7RUH1by8AgGc+oNOKvpnFXUyqZAom8I7koI3NV7bibbAKhuB2xsuiXOSaExjXPs0nuRqg==
X-Received: by 2002:a05:6a00:c94:b0:781:2ba:ef21 with SMTP id d2e1a72fcca58-7a220b1d061mr17172564b3a.23.1761050334408;
        Tue, 21 Oct 2025 05:38:54 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff35a59sm11169428b3a.25.2025.10.21.05.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:38:54 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH v3 1/2] selinux: Make avc cache slot size configurable during boot
Date: Tue, 21 Oct 2025 20:38:38 +0800
Message-ID: <20251021123842.968605-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAHC9VhQ_hv1ri1csrgGP+9RssCuJBDuOLSDowZRD5xZcDD2mPA@mail.gmail.com>
References: <CAHC9VhQ_hv1ri1csrgGP+9RssCuJBDuOLSDowZRD5xZcDD2mPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> I would imagine that a very simple implementation would simply convert
> the selinux_avc variable from an instance of selinux_avc to a RCU
> protected selinux_avc pointer.  As the AVC already uses RCU, I think
> the number of changes should be relatively minimal:
> 
> * Ensure we wrap selinux_avc derefs with rcu_dereference().  This
> should be the only real change needed for lookups and insertions as
> every search through the AVC will start with deref'ing the selinux_avc
> pointer.
> 
> * Update avc_init() to allocate the cache slots with a default value,
> fail if unable to allocate the cache memory.  If we ensure that the
> selinux_avc pointer will always be valid, we can avoid having to check
> it.
> 
> * Policy (re)loads which would change the number of AVC cache slots
> would allocate and initialize a new selinux_avc then swap the global
> selinux_avc pointer under spinlock.  The old AVC cache could then be
> free'd according to RCU rules.  I haven't thought about it too much,
> but I suspect we could do away with flushing the old AVC in these
> cases, even if we can't, flushing the old AVC is easy enough.
> 
> > When increasing slot size, we could directly copy the contents from the
> > old table. When decreasing slot size, nodes exceeding the new slot size
> > would need to be re-hashed and attached to appropriate positions.
> 
> Changing the number of cache slots should happen infrequently enough
> that I see no need to migrate the old entries to the new cache
> instance.  It's a cache, it will fill back up naturally.
> 
> > On my Android device, policies are fixed before system image release and
> > don't change or load dynamically during system running. Using kernel
> > parameters for adjustment ensures no additional locks or checks are neede=
> d
> > during runtime table access, maintaining simplicity and efficiency of the
> > lookup code.
> 
> If your system does not update its policy over the course of a single
> boot, and presumably doesn't drastically change its behavior during
> that time, there is another, simpler option that we should consider:
> setting AVC_CACHE_SLOTS at compile time based on a Kconfig tunable.
> The code change would essentially be one line:
> 
>  #define AVC_CACHE_SLOTS   (2 << CONFIG_SECURITY_SELINUX_AVC_HASH_BITS)
> 
> ... with a corresponding entry in security/selinux/Kconfig.  That
> should be a very easy change, and if you set the default value such
> that AVC_CACHE_SLOTS remains at 512, there should be no impact on
> existing systems.
> 

Alright，I will add a CONFIG_SECURITY_SELINUX_AVC_HASH_BITS in
security/selinux/Kconfig, the range is between 9 and 14 (512 : 16384),
with a default value of 9. And then I will send a new patchset version.

I will try to submit the final version in Q1 2026 based on the discussion
(Because I have some planned Q4 work that hasn't been completed yet).
