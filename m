Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4B41C71
	for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760649544; cv=none; b=VVKucLI5spdaXAQJ6iifXKbWMo9omZYwnQMSKS7IZhgdS07yOAJBltE6jNXxEVQbe7TVVKJqXBKSbaT8dwevjswD3wONr1FCD4akNDh4VnfluwWBrtumiHIBFkt03ls4kawTwTDgowxemR4Xud3caX8iFtc42Svr6HKkLkm8Alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760649544; c=relaxed/simple;
	bh=oEq7krugDJTA+w+mWfevAp59eUOZjk7fwVyk9SAIAZo=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=YbjIPBaX1RgeHzd2lZep3MgRAaLjyxV523RjaRzDg7MYAkJGy1dsa2A7lj9uj4NsD5aPU6ovkl91bxApGhgNVgUYzqz1KTcN+ZjoxjlGbWn/xLskpzhNppo7rhIB2eEGdYJwWxBQcSaW+xOR7SMY5/1GGnzYGRM61eTSCb4TlBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JFdLfToK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JFdLfToK"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-87a0801ba1aso237949585a.2
        for <selinux@vger.kernel.org>; Thu, 16 Oct 2025 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760649542; x=1761254342; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohEP9vmDzdNDw2wyJvX2m18Ru5DuXlVzONp6Y0tHUlk=;
        b=JFdLfToKj1bhe8weP6RwVrMkFv0kUdhhcQuDUHl7Vv2tAZiKzYkBb82rlv4OXZ1OwK
         oAkWIIXN/Uvl4uTcYdcQKlNIVzB/aMZ1NP/jgtnen50uSxexZirIxbYvQq9bGxosc3pE
         IECO8n/tw/fU3RqEUZd+TKDKrt6c5IhKjWY+g7+aiOBl5BNHEqI9RXPrgjWVJaIV6Hoq
         GO2O7mIA00MU4c5TD8FGubpsbiW4HAs549THczDU0QCschHosm94Ya1r25TyDDsqLtnf
         +Upjcvs1bQULTWBOA/d8h6sj9wHl+zUNiBgRMpYzDW3DY2SJYiCzHfjQ1tUBpAllY3VE
         iPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649542; x=1761254342;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ohEP9vmDzdNDw2wyJvX2m18Ru5DuXlVzONp6Y0tHUlk=;
        b=VvJPB7goY34F5UNPigcAgwJuSW+tW7vw6ExhzOilPx1KIdExd8lPxNoFqTL4CIrUBP
         dWSf2yOYsE5mHvcxFFJcVOlKdLEGhb+ELj1rmM4p17GlClFEOoIb+dPER6IEqAZNJKf4
         xetHr0Y0O5rK0Uql1NAq+L/R6NMVu6bm2LaV42rIXwJTYl6W3BYvV5IypmoH2r7xvlIu
         UdzhCoHiva9ycy6v0lmdJ1yPT9GkbTap1ePpOHhpkhqbz6DWGhJtCdvRxqkwkSAMMInH
         fOvEv7/bUiFGutYgcIhnCMd7kxs6yuD1ix+kWba2JShBk/QeqEnioOSS3mjF7xrHW5Tz
         RJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCUwrujBD8NtMEPZDuYdqaI+gq2pGPZsq+uTOOAlmspi7TkxxxvhUStNkmZ/R65ckj8NDI4tchfi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2+Kdlkikp0jv/ygz0Z8Mhw83MtVqa3Qatuh3Zt2orYt2K8oO/
	/NY2sczSu4QxrJg9G7nVO04xmqFZFf2XiN3Uj1oQOi3HxKu7feu2MQ9E64kWwukkZg==
X-Gm-Gg: ASbGnct+qBj1DipPDg3zHfJWtwV0GNiHOHtkfB4xVWAKiywQpWKPvP+UnAZh2pmnqAr
	CxRQ86FNzE6SCQTR6pPVbVGEy749ppAeHPXgBKGiJuOTYVBM9+sSr8rKmM18DQJq1gQQrCLMd6i
	QDoj73fMMYhS4HBjDmB/f5yaH7a+IVPSi3c+1T4i9EgT40uV8JLW1MFVGDisW82md2Nv5kjxDVW
	PWyWEqlrMyd38tChhUKsSzYHTtxeLwkKP/CZmk/u/Z1VIOpSFsQkPxly157VHKMlg6bpG38dO7p
	pxp7JWRohtxYhOBq6vPIrL88MB1GjyBvcPIqkY1EcevmUBDAF8EicZUjU7abXz424VQ9qLVZkKd
	PzaU8fgd2iBjTBlyCJme4xiycC4pCzVEIKXndOz9SYMi/a/fGjQVksgVdPKowmR49g6TSC/5qw0
	FzQ78Y8UiUz49O3gmbCzpZZFECb/felCy9FJLmLO2K8YYGHQ==
X-Google-Smtp-Source: AGHT+IGhPPSGnaEYxwJthVZ66B+DjXF19ZDlohxPofSyke9ghcptO97DdQtWNBAXkLHCXWo+9/Uffw==
X-Received: by 2002:a05:620a:3955:b0:849:2a77:5612 with SMTP id af79cd13be357-8906e2ce121mr210451185a.17.1760649541812;
        Thu, 16 Oct 2025 14:19:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f37e4b953sm281282885a.29.2025.10.16.14.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:19:00 -0700 (PDT)
Date: Thu, 16 Oct 2025 17:18:59 -0400
Message-ID: <c77eac51a26a0248980027e9f3b3b564@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251016_1653/pstg-lib:20251016_1653/pstg-pwork:20251016_1653
From: Paul Moore <paul@paul-moore.com>
To: Hongru Zhang <zhanghongru06@gmail.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org, selinux@vger.kernel.org, zhanghongru@xiaomi.com
Subject: Re: [PATCH v3 2/2] selinux: improve bucket distribution uniformity of  avc_hash()
References: <000bce8f11d06684f70a29705dfd417747475b1a.1758859391.git.zhanghongru@xiaomi.com>
In-Reply-To: <000bce8f11d06684f70a29705dfd417747475b1a.1758859391.git.zhanghongru@xiaomi.com>

On Sep 26, 2025 Hongru Zhang <zhanghongru06@gmail.com> wrote:
> 
> Under heavy stress testing (on an 8-core system sustaining over 50,000
> authentication events per second), sample once per second and take the
> mean of 1800 samples:
> 
> 1. Bucket utilization rate and length of longest chain
> +--------------------------+-----------------------------------------+
> |                          | bucket utilization rate / longest chain |
> |                          +--------------------+--------------------+
> |                          |      no-patch      |     with-patch     |
> +--------------------------+--------------------+--------------------+
> |  512 nodes,  512 buckets |      52.5%/7.5     |     58.2%/6.2      |
> +--------------------------+--------------------+--------------------+
> | 1024 nodes,  512 buckets |      68.9%/12.1    |     82.4%/8.9      |
> +--------------------------+--------------------+--------------------+
> | 2048 nodes,  512 buckets |      83.7%/19.4    |     94.8%/15.2     |
> +--------------------------+--------------------+--------------------+
> | 8192 nodes, 8192 buckets |      49.5%/11.4    |     61.9%/6.6      |
> +--------------------------+--------------------+--------------------+
> 
> 2. avc_search_node latency (total latency of hash operation and table
> lookup)
> +--------------------------+-----------------------------------------+
> |                          |   latency of function avc_search_node   |
> |                          +--------------------+--------------------+
> |                          |      no-patch      |     with-patch     |
> +--------------------------+--------------------+--------------------+
> |  512 nodes,  512 buckets |        87ns        |        79ns        |
> +--------------------------+--------------------+--------------------+
> | 1024 nodes,  512 buckets |        97ns        |        91ns        |
> +--------------------------+--------------------+--------------------+
> | 2048 nodes,  512 buckets |       118ns        |       110ns        |
> +--------------------------+--------------------+--------------------+
> | 8192 nodes, 8192 buckets |       106ns        |        94ns        |
> +--------------------------+--------------------+--------------------+
> 
> Although the multiplication in the new hash algorithm has higher overhead
> than the bitwise operations in the original algorithm, the data shows
> that the new algorithm achieves better distribution, reducing average
> lookup time. Consequently, the total latency of hashing and table lookup
> is lower than before.
> 
> Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/avc.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

My understanding from previous iterations of this patch is that this new
hash function was AI generated and hasn't really gone through the any
rigorus analysis beyond the performance measurements above, is that
correct?  I'm not opposed to using AI to assist in patch development or
algorithm creation, especially if there is some acknowledgement in the
commit description, but I do hold the patches to the same standard as
any other proposed change.  For this reason, I would expect some third
party review of the hash function by someone with enough experience to
provide a reasonable analysis of the hash function in comparison to
other existing options.

... and yes, I do recognize that the existing AVC hash function likely
did not have to go through the same level of scrutiny, but it has the
significant advantage of being a known quantity, problems and all.

If you want to change the AVC hash to something else with better
performance, I suggest sticking with a well known hash algorithm,
ideally one already present in the kernel; that is going to be the
quickest path towards acceptance.

--
paul-moore.com
