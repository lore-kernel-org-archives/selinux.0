Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8073E63A1
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766442; cv=pass; b=SlKI94ItM9TmLYlYGaluvVQ6Tm2erlr7xtxc3xICF4vGheDCmsX2OawqPy/vjggbEhzLcNmb2uNp88yVhPsU+fJDGkLbfz9t+QRBqWtx2fRseysXDbQeFCtkv5SUSZwWqJt63E/2ss6oFssnNV7mH2zk5xT/kGpGG0AXXLgxTzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766442; c=relaxed/simple;
	bh=so6b2mJY1YlsnRLZq/rNwb1+qfGvMVA55kllYXIVqOU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sLgyiFd5iNHrjiJutjg6nBM+Z4vxM5xJMNLRXbeWHj3Wg9U188arBLzsdEIuADGBr8hNoTk+yZ3MgRMW5Hu1Kl0NW50BB00t5l6W8uzJi8NipjhqnlM2/TA6QfD6yMWRjTv9cXpTuEFDJzQNIiTpmk/KkaNsIXq2Uh+GTpN6QfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvECI4h1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eWaenCET; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvECI4h1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWaenCET"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778766438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=0O0lTKQV+N3k9HmKyysD2R8j5FJHbqe2XUK7zTkQeII=;
	b=DvECI4h1XEQIavUfnIK12djHE+m/BSLmYLHGTbeQUW+qko2zXq8gffQ2KBFWSgEgmKVsNX
	ZMy5KcQOuv3c9a0wS2qP1V1FDFhqwrx2ciB/ZqqJ37EBnvg5evh0n7lkfq4d8lCkXDQiy4
	FV3NCSx9eL9TY41KJMp59BA2lXKr9K4=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-qo0tpq0lMLOmIWeYWLhSJQ-1; Thu, 14 May 2026 09:47:12 -0400
X-MC-Unique: qo0tpq0lMLOmIWeYWLhSJQ-1
X-Mimecast-MFC-AGG-ID: qo0tpq0lMLOmIWeYWLhSJQ_1778766432
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65c396d3940so17037987d50.3
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 06:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778766432; cv=none;
        d=google.com; s=arc-20240605;
        b=a/1DjGh/Yz7p6d8IJ1iOmJ1e+p2Q4MwhgerNeITiIer3akbx221Mb2bcdA0sUgOaVV
         HCVnsDIDwdyGf734BrPC+jyGrVnUgNHiBW/aZuokkkN+pY2Bw4jp3/Bluf9o3TNjEUcR
         3azRbeDwl2dUkrVMvaR+S2jNCauXpHTMo3CD/dn+kSl4ndrm/GR40u7Eeay4G1BSUQz5
         V0CU1l0x7a3LFS5iAKQCN7LTqR/JKGIxVHQi2vhinoknKuu2RVve5H19TLVhD2Z2ZkjC
         AS5+ykM4SyqzlD05Dh0370+rsyrbuWNZ/O/UB8n3a1hahJfx+dt62ut0ziLvDPcjjnFo
         dNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0O0lTKQV+N3k9HmKyysD2R8j5FJHbqe2XUK7zTkQeII=;
        fh=EgpXT4/ELoVMoyaDFDG9IqPLBj40pWDbnldnx43xM5k=;
        b=Mo0ElJIjgFxm2S44lhuNAX0wdIdHjhzYmE6++dIMKsJonJavac+VY+x+dc5XbDPRQv
         OpCY7a3huej5kNJ0v3b5ItBBg+YNXEpHYPF31+RrLOzouOfdLNkGbn1tg4dnMdEhnws5
         aBlkqbE9WioK3zrW9KA7YYMxZPBSCV1di980acv5cSf9PBVL8pGg4BBCKTghhiNOtdZ7
         N1CnOa+fvuwN6pM6Cbm1YZVJ2cDrjFbmQZN2TtwCfKBLvM8Ftlkqul+dsGU7USnIboY+
         iKhKy8lLi7uhHWGVk9U+5MYaxX++90QN5Lnn0LvaDcuETn2q+ToN6gQCgx/fS+h76z3D
         o8KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778766432; x=1779371232; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0O0lTKQV+N3k9HmKyysD2R8j5FJHbqe2XUK7zTkQeII=;
        b=eWaenCEToGP27i/yEVa/DwK7u3L4pKdKrDbvnCKsGqU0jyyGmGQhvcLJ7mSb9QaBGY
         vGjDtogeIsVYqO7VNPQi8E4yfvRLj0TX4PqEvLPLF4AHku/8cZQe4f7AWSwjjo+HU5MK
         bQj0/bv/rYZgG7KocHXEJKI22Sz09WwX9TfRxt25K7teVARx53BRR7qtzFe26Xt6S80J
         xHG7stPMIU0yJyEqS+hOVAHWmg13uv7kK4TsGX0OgFwlXpWVk4LV8nlTYD8VRjdYd2u0
         p4r7LL2OYEa41gJsyrvX4gmxJ3pANh7XXH4SxvqsiGxH+ln+6gDFjXbvNFkt57MX++Te
         RxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766432; x=1779371232;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0O0lTKQV+N3k9HmKyysD2R8j5FJHbqe2XUK7zTkQeII=;
        b=elT4cmgdBSys6gwAHTNpi9DkxsgkfLtF5bGtMplLyDONyvydV6+MpLAsSx/qaHXBCI
         /FcI2+9PojrNq3UTTT+9ETgdk72Zrppu3gaAMkCQVpNTJM8ete5/JgmgRxf/de82NawL
         a4y7ir0WyUhUIacngq2TMHFl066erdOznzTM0lGXCzsWgN/wGi5Nj0COO60pCTYhyVbc
         Yntomwfx4woQKTJzxWAYP4TJ2ZqyHj/maPJUMXrz3TpINjomUNjEocwGKcPZzxEuXEE0
         /ILo4pAh5fwb0k6v+b2alOql1gIW6aLa1HrkMNn57+ctMsIlyIFtuCkqv1AGHPNhnUAC
         ReuQ==
X-Gm-Message-State: AOJu0YzhLYWPAW+IkByXj13s9czLs6q48vlIx/XD7gJjCHqB5g3kXU/o
	XQ5VjrJLwHzEtNey+c8qTrACEoXf3S32HTpzg6qv2DSL4AWShNn6ISlRYr02nDX6vwEhyLW4FMY
	N1QNCzeuMNYGmfpYxnmGMJGqhObRSTun2srVMXHs/bfF6vB2HTHU46EkROqHxMmM7MMsvK+T4g+
	GriJBLc2y4Tf4vViwSE390p6AQHY4g6bfJcltRVLjt/Bmx
X-Gm-Gg: Acq92OEclrFZddos9x23fgzJ/UYYnHO0sipOg0UG+CrWdhfqA2VLYgjnPt9u9XQiIXt
	gmZopR4rZoaQyw27R1GRqWEdIo9AkiSUEtKVl3dr8s7UnvegtJ+EB8imcTkjrQ3Bqt0K9X75g3P
	oD0cvaMqWCalIyRvswBIIB8DQ4SHyzaQaO/wWBB/5ob/qYjSc7yavATY2LwQIKxDLermXjok+/P
	gwr5w==
X-Received: by 2002:a05:690c:8:b0:7bb:eaf:5101 with SMTP id 00721157ae682-7c6aa2183d1mr83409917b3.16.1778766432224;
        Thu, 14 May 2026 06:47:12 -0700 (PDT)
X-Received: by 2002:a05:690c:8:b0:7bb:eaf:5101 with SMTP id
 00721157ae682-7c6aa2183d1mr83409517b3.16.1778766431385; Thu, 14 May 2026
 06:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Thu, 14 May 2026 15:47:00 +0200
X-Gm-Features: AVHnY4Ioyhw55LSZ1f5AVLtpTA9kd3JfA0WRiQ4z9YYX-WHCw2x5C7RgYHVq3-E
Message-ID: <CAOssrKcz2w1A465OUGr9jnWDAd+AN-Mt_AL_xxuWQOqAz8PRAA@mail.gmail.com>
Subject: selinux_inode_init_security() weirdness
To: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"

This calls lsm_get_xattr_slot() at the very top of the function, which
increments *xattr_count, but can later return -EOPNOTSUPP, signalling
"ignore this LSM".

At this point, there's an empty slot at the front and any xattr added
by other LSMs will be ignored by the filesystem.

Another issue is that the initxattrs callback will be called because
the count is positive.  This results in e.g. tmpfs allocating the
per-inode simple_xattrs, but then no xattrs are added.

I noticed this because I was checking the overhead of xattrs on tmpfs
and turns out that on this particular kernel tmpfs inodes get a 1kB
overhead even without any xattrs.

Thanks,
Miklos

