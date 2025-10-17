Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96822DC321
	for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694835; cv=none; b=I504U7wgOh8U7FvlhgYCIzg7Rl2gSukW6hPDBbmT9xbbw5EUBN2FggT0jr0csf3LLmsUy0Szu9I1vheglMITO3rMeX1AthllJGn73Ziq5VGuY8CLyTkLHtiOp2HA0IKvg228eWZEa7pv2h9AUvsDNpdxZxm/hLqewvS5lYvD628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694835; c=relaxed/simple;
	bh=SJKbAe0vpzUNEkwkegpehh3VBYpD3L5PhpvDwlgAtBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8CfFL/TmVkbsmGHbm1J23zFkig92dsrpm5Wr/AP4hnQiuOr4r49VvbuB5U8q5KW3EonzlhuE/O8Pp2wouywDrdV9LLMiu9XTaH5r8g09hlJApmPzOGNLoaQOLKboZhydxjUH5l5g2sNODMGM2kT8Z+GySoh8WvQemCgizLX1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVd+gr+2; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVd+gr+2"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-33ba38ed94eso1934436a91.1
        for <selinux@vger.kernel.org>; Fri, 17 Oct 2025 02:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760694833; x=1761299633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kt/XeVFqD6Rzbs61qBcoYplbjOAGUFl2Umd5p/S7zyw=;
        b=GVd+gr+2/vWT1j+L3T3lAhPo6+MXz2jjZIZm50qDrj4kiELUy43i2LlDxDgUAduKot
         xSFvy852UL6+CowZLHjHDZhKuxlt4OtO+WNF/H0JYxAF7qZWLEjHa6VQtZ8hiIRjWaMh
         uzuWacR9po9EOCsngPVu/rIZ/k2++xdE21EbTu+k43IiX/zsxv4REXtzFtHlDSD1eQI8
         utuVZARIhrxdOyli4MwOPx38BD3gLYl+cKTGHA3Dh1f9FFKWEQ5YcLLmKewPa/xqq2ee
         Jo6um8PfEhVWS4FsKymeq40qaO5yW1cYq11WMP4ibtEP8vrh5AeYK3dZCckMgIqETsTH
         mAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694833; x=1761299633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kt/XeVFqD6Rzbs61qBcoYplbjOAGUFl2Umd5p/S7zyw=;
        b=kn77zQJllWQC3D0pQD6p+6RZ2ejdXl/XuI5jYeLQpkz8bi/xEnEx4Gr7yiAY1JsidH
         d6ICKkMJVta3FSfE/g7r5R5i+oZ0bBBdQU9KyNkAn7PWBWIM+TKqxfL98tv1euifN6fV
         QX0o/eQTTaY1F6eV4cxjjR/XL/4PQlhdFkiApldEwg0oh3MDh6o9jQ1RaSQxzuyZGnUr
         shN60dBgsSOsTjxrndwEhwXjCbeqbG3P4haBXzSWeuXtl42vJ7nZIha2hHfaVXXpwOzd
         YVbUuv5OsngPg6PvMZ8EMxd3wiHPbqar4223Qkv4QhAhw0A8gxp5JKBn+flWiqQuNAl9
         zcJw==
X-Forwarded-Encrypted: i=1; AJvYcCWk3j4Gglbw5YI/IHIMxM9suB0Z5BgyZZFTkcQWhi/XqYYAaa0X3SaaGIhMAGRNaZNp4hnxVOvD@vger.kernel.org
X-Gm-Message-State: AOJu0YybHHAVKw7PBdqVJ3qQf/0MCv7eu3lM1ypBKPsa4ZtanCGAMJyY
	3VY4w0Oy+2DpnjaZeHKaXKYa5LZc1RIJ60Ax0u1pgixknB/VgAPLVz9u
X-Gm-Gg: ASbGncs+sZR/TCizasTV/j9ja36KjTYsIEPvwYzA7NKh3T+GPwTJjpI2k+a1/cusbrG
	QrasQTmR5SFfvXyFA+eUD3yQlGdOFABQZyn8u+T8/j2eML4dsx5JVArcgpmbkatIA4n2d901Yhv
	K85kdr2+xU6uE0ACCLdGzygUz1cZ/EHkOie0qLYVDoQ4zW1v4NBSYRujDeDblYufHAL3X9fhf8R
	pdjHR2ZTHiqjCI769XfaDzHoeKLLdvqdT2Xw/H9HETLLFZrSxSMuC48hEyBSx5ULacsqKuO1BdO
	9UudpZx04v9NnW42et1od1e81ENg5zBBKFmOuoOOUYCkvF3JFw/2SfN/uXBP5SZmJUR/y5w/9x1
	zR6NOJzGS+TIZqekosWiNYpMWv8+5528VppxjH8UiKKMj33NanqBMG53B8j0DMahfFcRWycDD51
	47HtDYUdDMv2v8/aUafnRN6ek4Rkfe
X-Google-Smtp-Source: AGHT+IESLqUj5tacW+LOLrtZkLLHSEgVkkYATroByIesNP3cZS7zmn/U3CpO/pPdJ85Sq056ceamOA==
X-Received: by 2002:a17:90b:2ec7:b0:33b:6650:57c3 with SMTP id 98e67ed59e1d1-33bcf8ec60dmr3394842a91.21.1760694832944;
        Fri, 17 Oct 2025 02:53:52 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd79b2fdesm2371163a91.2.2025.10.17.02.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 02:53:52 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com
Cc: linux-kernel@vger.kernel.org,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com,
	zhanghongru06@gmail.com,
	zhanghongru@xiaomi.com
Subject: Re: [PATCH v3 2/2] selinux: improve bucket distribution uniformity of avc_hash()
Date: Fri, 17 Oct 2025 17:53:42 +0800
Message-ID: <20251017095342.1180797-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c77eac51a26a0248980027e9f3b3b564@paul-moore.com>
References: <c77eac51a26a0248980027e9f3b3b564@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Sep 26, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
> > 
> > Under heavy stress testing (on an 8-core system sustaining over 50,000
> > authentication events per second), sample once per second and take the
> > mean of 1800 samples:
> > 
> > 1. Bucket utilization rate and length of longest chain
> > +--------------------------+-----------------------------------------+
> > |                          | bucket utilization rate / longest chain |
> > |                          +--------------------+--------------------+
> > |                          |      no-patch      |     with-patch     |
> > +--------------------------+--------------------+--------------------+
> > |  512 nodes,  512 buckets |      52.5%/7.5     |     58.2%/6.2      |
> > +--------------------------+--------------------+--------------------+
> > | 1024 nodes,  512 buckets |      68.9%/12.1    |     82.4%/8.9      |
> > +--------------------------+--------------------+--------------------+
> > | 2048 nodes,  512 buckets |      83.7%/19.4    |     94.8%/15.2     |
> > +--------------------------+--------------------+--------------------+
> > | 8192 nodes, 8192 buckets |      49.5%/11.4    |     61.9%/6.6      |
> > +--------------------------+--------------------+--------------------+
> > 
> > 2. avc_search_node latency (total latency of hash operation and table
> > lookup)
> > +--------------------------+-----------------------------------------+
> > |                          |   latency of function avc_search_node   |
> > |                          +--------------------+--------------------+
> > |                          |      no-patch      |     with-patch     |
> > +--------------------------+--------------------+--------------------+
> > |  512 nodes,  512 buckets |        87ns        |        79ns        |
> > +--------------------------+--------------------+--------------------+
> > | 1024 nodes,  512 buckets |        97ns        |        91ns        |
> > +--------------------------+--------------------+--------------------+
> > | 2048 nodes,  512 buckets |       118ns        |       110ns        |
> > +--------------------------+--------------------+--------------------+
> > | 8192 nodes, 8192 buckets |       106ns        |        94ns        |
> > +--------------------------+--------------------+--------------------+
> > 
> > Although the multiplication in the new hash algorithm has higher overhead
> > than the bitwise operations in the original algorithm, the data shows
> > that the new algorithm achieves better distribution, reducing average
> > lookup time. Consequently, the total latency of hashing and table lookup
> > is lower than before.
> > 
> > Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> > Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/avc.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> My understanding from previous iterations of this patch is that this new
> hash function was AI generated and hasn't really gone through the any
> rigorus analysis beyond the performance measurements above, is that
> correct?  I'm not opposed to using AI to assist in patch development or
> algorithm creation, especially if there is some acknowledgement in the
> commit description, but I do hold the patches to the same standard as
> any other proposed change.  For this reason, I would expect some third
> party review of the hash function by someone with enough experience to
> provide a reasonable analysis of the hash function in comparison to
> other existing options.
> 
> ... and yes, I do recognize that the existing AVC hash function likely
> did not have to go through the same level of scrutiny, but it has the
> significant advantage of being a known quantity, problems and all.
> 
> If you want to change the AVC hash to something else with better
> performance, I suggest sticking with a well known hash algorithm,
> ideally one already present in the kernel; that is going to be the
> quickest path towards acceptance.

Stephen initially suggested I refer to the jhash or MurmurHash3 algorithms
in the kernel. In my previous testing, MurmurHash3 also achieved
performance improvements compared to the original algorithm, so it's good.

I plan to move the MurmurHash3 implementation from avtab_hash() to a newly
created file security/selinux/include/hash.h as a public function, which
will be called by both avtab_hash() and avc_hash(). Is this ok?

