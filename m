Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410C878F45
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404093; cv=none; b=G3k7t4BvaKwjN4Yp4IZryEnqFdgqesd7aCKhRnp0AFZMFazdYRjzmVMgL2+bi2XcRRnYS8VDPAM/0uvqq1qTxQqcqglhIr+u/dJ/QMvNOzZFqWgEv1jDefiV6cUFhfUBQH/KnfRN8fAQV4yf4xTDrzfQTbftX4Pt7uOBxTJbWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404093; c=relaxed/simple;
	bh=/dgl9jVljVQyvrN/x4UstHoe5tBgYHTRdd0LuJbKEO8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=O62LKLvvIp1i1ZXnZrwka6EgI97zjCQux89DEqLHyX5ba4dlrnz9TSRqPitP8UJB+fs5qXZKl+IJVo1o+E0HGZl7PndkHkZGVjiWJ1oRenwRKnEGM7pxDyNrp2w+VBqHVHPgTXSyzmXS4w3RCjI788GykjLfgGjg/0Fkt6ZUWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HYPlWH79; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HYPlWH79"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be49f6b331so276305385a.1
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744404091; x=1745008891; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eemIWGOQMNisEyM3YOBb6l7UfkDUY9gnvJnHEJXTT8o=;
        b=HYPlWH790m2wmYiN/0YcKMO9/moVMpeydTssQ7CCnIn4QymKnSK3NfZR5ZHyfLlIXc
         B5q3L2MlztuvmuNFZbBxaYf7pUiXFhkoix9QGPj+eJ3oV9+tCwmf3Ft3cj/7jBDrcwjT
         75Os7Iuyxb4vGN6S2+9KdPc3n1dJlzL/KtckrowxJhkwgbTsoJiuC8gSniep2WbwQ0MO
         +dPdJwZQGRYqdmqVJ7Q5d5Lw+bYMDXJO1U9fC3zQJspb6y1TdU9FJgaXSL1ZT/zMVzno
         s3xoZvpGT2DnqNwYEJlK1boWC26jirill84OEmT/Vpcr5cIwI0ltm5vb5Aqsga6M/RxM
         t6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744404091; x=1745008891;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eemIWGOQMNisEyM3YOBb6l7UfkDUY9gnvJnHEJXTT8o=;
        b=ciUuobrV+bCM5V/1F3bhMFNqJY4CDauN3s9QSKN0JWJ4L5iRRZfpGS5cG4wY9K1VeJ
         ZOmPZNbfB1pJzP75TYrzjJ+rf85dUH90h+v9ldL7v/SkgXH7MsQGXNIQa+Q7mq5QD6bp
         XRUDDxsZ1eRuQcneYP9ybG2s9emOxQu4bh5eHmSZ0xAcsBGJaA/zilst8L3TSMF5l5WD
         qhaOuZkcr59331mhjpUeTM89zvsI+N4kX2rRLf93OQVLFM33XPcJbH5+xDkBijuj2maD
         1WyIXg4lmYfL5DPGCTg69MbbOIuZi9XT0ZWDJqMxUK2gOMZsviwQoOhdzyxssRmn2LUh
         /6MA==
X-Gm-Message-State: AOJu0YyzeG9uYhXLpqn04WryVlVnYzZdcqlSz7bq/7MlRIWDuOlr+XgT
	ntJR1cLoVyFEUb70dgilpIs86r9rQ4XPLZHGka8DiUzwulLD2y3SnYIXLIffLgX+jXx0zgAD5gE
	=
X-Gm-Gg: ASbGncu9GQNPYcU0WE2Mss/0CujR4H2R8GNJmUnP5z8w81+QvP7TNIOnhKy7W/dm31/
	y99fGUXzS1O0eZWBqfW0Zam759LNfFUQ5xKewpvsQcggLONm2/9B6bPUor46jxKCPWfLAqbmcGq
	1cciVrnvLeOvxNUabw22uF/e1lVuemX6frFA3Hm0SuxtaQDw7/xZY0I8beVxgybjP9jkXPYQMnn
	/X4SWYCFQc5OiNvGGJw4kjzImcG/9EE926DE4b6Ae5xfOXjrZbwPebc2/VVKxjVCtYU8m5pPUAx
	gXCuNTNFY7Rl5Ixvwk53wgwzLV3hWDplhzhPS836Rhj6O2/UaRbH5QH17c3GJXL03p3fcd+X/XE
	zRaNJsaiUEQ==
X-Google-Smtp-Source: AGHT+IHXZtlWUOFRnfVnUDoBSMwJFlVVi1VCUSHibHMLwMpSejJW7/2P09JpqK98nLOzC2DtgTR+rw==
X-Received: by 2002:a05:620a:24c1:b0:7c5:9788:1762 with SMTP id af79cd13be357-7c7af115a88mr695605585a.45.1744404090943;
        Fri, 11 Apr 2025 13:41:30 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796ed9ccd0sm30797121cf.57.2025.04.11.13.41.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:41:30 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:41:30 -0400
Message-ID: <97208482c11a257821c7865bdd40c0de@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250411_1406/pstg-lib:20250411_1552/pstg-pwork:20250411_1406
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: Re: [PATCH v2] selinux: reduce path walk overhead
References: <20250410192031.259180-2-paul@paul-moore.com>
In-Reply-To: <20250410192031.259180-2-paul@paul-moore.com>

On Apr 10, 2025 Paul Moore <paul@paul-moore.com> wrote:
> 
> Reduce the SELinux performance overhead during path walks through the
> use of a per-task directory access cache and some minor code
> optimizations.  The directory access cache is per-task because it allows
> for a lockless cache while also fitting well with a common application
> pattern of heavily accessing a relatively small number of SELinux
> directory labels.  The cache is inherited by child processes when the
> child runs with the same SELinux domain as the parent, and invalidated
> on changes to the task's SELinux domain or the loaded SELinux policy.
> A cache of four entries was chosen based on testing with the Fedora
> "targeted" policy, a SELinux Reference Policy variant, and
> 'make allmodconfig' on Linux v6.14.
> 
> Code optimizations include better use of inline functions to reduce
> function calls in the common case, especially in the inode revalidation
> code paths, and elimination of redundant checks between the LSM and
> SELinux layers.
> 
> As mentioned briefly above, aside from general use and regression
> testing with the selinux-testsuite, performance was measured using
> 'make allmodconfig' with Linux v6.14 as a base reference.  As expected,
> there were variations from one test run to another, but the measurements
> below are a good representation of the test results seen on my test
> system.
> 
>  * Linux v6.14
>    REF
>      1.26%  [k] __d_lookup_rcu
>    SELINUX (1.31%)
>      0.58%  [k] selinux_inode_permission
>      0.29%  [k] avc_lookup
>      0.25%  [k] avc_has_perm_noaudit
>      0.19%  [k] __inode_security_revalidate
> 
>  * Linux v6.14 + patch
>    REF
>      1.41%  [k] __d_lookup_rcu
>    SELINUX (0.89%)
>      0.65%  [k] selinux_inode_permission
>      0.15%  [k] avc_lookup
>      0.05%  [k] avc_has_perm_noaudit
>      0.04%  [k] avc_policy_seqno
>      X.XX%  [k] __inode_security_revalidate (now inline)
> 
> In both cases the __d_lookup_rcu() function was used as a reference
> point to establish a context for the SELinux related functions.  On a
> unpatched Linux v6.14 system we see the time spent in the combined
> SELinux functions exceeded that of __d_lookup_rcu(), 1.31% compared to
> 1.26%.  However, with this patch applied the time spent in the combined
> SELinux functions dropped to roughly 65% of the time spent in
> __d_lookup_rcu(), 0.89% compared to 1.41%.  Aside from the significant
> decrease in time spent in the SELinux AVC, it appears that any additional
> time spent searching and updating the cache is offset by other code
> improvements, e.g. time spent in selinux_inode_permission() +
> __inode_security_revalidate() + avc_policy_seqno() is less on the
> patched kernel than the unpatched kernel.
> 
> It is worth noting that in this patch the use of the per-task cache is
> limited to the security_inode_permission() LSM callback,
> selinux_inode_permission(), but future work could expand the cache into
> inode_has_perm(), likely through consolidation of the two functions.
> While this would likely have little to no impact on path walks, it
> may benefit other operations.
> 
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c          | 225 +++++++++++++++++++++++-------
>  security/selinux/include/objsec.h |  14 ++
>  2 files changed, 185 insertions(+), 54 deletions(-)

Merged into selinux/dev.

--
paul-moore.com
