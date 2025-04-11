Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E578F45
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403796; cv=none; b=k9T/nyMwsILpJGvKSJmN9EJ0RaZJ/sN97fmOCcRQCsMKX6p4vQIRsYbo+T/208U25prwy1GtfT3doEGiMnWYXDnOzzFXbK0oOAFSjB/6m08I3KygFUNTixygpL0g8Bav9m/aa6MuFU/753hts5WIC8HwalIJjZAuElcF860O3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403796; c=relaxed/simple;
	bh=vUrKpHj0arEW+TKo0c9ht0m99tjeU3Ry8atuR91mCQI=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=es/EoLYigOpY39CIV6uIWpGK9ZBypgPCqypV45VJnIC1Fg3DoIVoTBclbEyO3BrpHL941wkfIiWUlujdxZ14/g5iYlQjJDmTbyRbYNbgGfCczTOt6hvskKMuq0KgrzggeU5siLIAfqrIlkvQc5UOJWEgjdsF0vh1IMDEtDevn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IdBhA6lM; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IdBhA6lM"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5aecec8f3so372758685a.1
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744403794; x=1745008594; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8SyV1M8v6IBd03ILhZh79/jYBeQz2umCIkkXwTNFfQ=;
        b=IdBhA6lMZe1vcuz3O2non4stHouTbxN3QcW+VpObs0e5BouNZkwrpHCpj5B/XnwLaO
         rcgrMjO+G9CGGOQJl1/yt5+LaC8sUfHX5jEgAogyYrEX9w8de86zf1xcSRW5HB/MTR/b
         q9dTFQTRzy4w+v7LDucf6SVKQjVi5sE/Ndh8J/1NF5EgB7WBLdlPTtcVG/3Vm3xC/Rwp
         AUzxqFc92Qz6T+CTUvBsaSfMBfgSYb692fB5lU17SzJYkNsAArTrru2PpDMjtcvTyfAM
         i02WOQhDSksKfEK/rs659hLbcKuvuNRY3zk1t9fvBxl3KuKt6/x87OWClEYfS4GgkETf
         onKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403794; x=1745008594;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C8SyV1M8v6IBd03ILhZh79/jYBeQz2umCIkkXwTNFfQ=;
        b=JnDmy8E8Ycnl3/is/YVSgOAcQjs1v6ZNrFQGSY1VAaeu3U7ypx99kxtAMnS+Wnmiw8
         JszmbIs64TwNFwtksXTeAeHA7ui4A65kGprkgXFGitKh0VZ5p+y82Zhmo8pErMaRWtur
         BcEU+WnEMjiiUxNkGsuzRrgYRUJzLa2S8tNBsK/PdyzoOnXAdRf0OqmgqHzlirakeZ4h
         n0SVsWdyu/Y9twJRDiXFlMK3z8L0tTaq/HPybNbnWbFXcLm+E/tH9/3m5N6qtp81889P
         9Su9Dc1RkXMjumVXIaYdK0YZR0eg6jpaYMhq3VlqBu07wyuyDyAJOgw7xJltGokDCY8F
         vSLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPmnPZ6cw+yV+W+8wjCpACXUlCXWPigzd0jlzmpRxqSc5wq7mocubLCBWq7o9sPPD50cFPDL2O@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyH77bma7piWZWUwhZLENihX/SdPHyis0cueVJ/MLyzlirRD8
	nh34WE09COz3e7YKfDDJYQqJZl55E61uN80JZsF5yU8AKX1/oh8D3BKr96bX/Q==
X-Gm-Gg: ASbGncsqjjhSVfwPDD1TRsmh3RB2Fxfn7EGAd4KGxLI5Jd3PPptFwyqDhsImnAsG5bx
	SKxgobQhH1OVBDuJUwYeRw+KCs2kaJYYkTvFtkuP73BtRH8zIgdttTQuciMPi+YGHaeL/byEWO/
	hRzf6sgeD5jT9ehJEkC0IbGMb4p0JVS3/oGBfl+QUOupNS8fajjbYBL6YPE2Fcy20Ga9vKfn1r4
	kKVeSJ70mEcC3yfni3GFODzJY4sCEbKc1N1zFEwMi/FgeM3LImRNvEPcvQaOL+jyHpDJ8ATarkL
	4j7vaZFU05x1+Er7Y2EfxafcLEZ3X8RgFqxrvRfvfg5j6G5EbVkT1UBKnyLHmzp7iH2mw/9zqkE
	kUn+sj9+jb43Rnl2L9NAh
X-Google-Smtp-Source: AGHT+IEMqoWLapD1DaCyeh+gK7JyPIUjwcHY/n56lKyGtuNCB7j5w+KUGs+5UYly8owiZHVqFD78Ag==
X-Received: by 2002:a05:620a:44c6:b0:7c5:4a8e:b6b with SMTP id af79cd13be357-7c7af11f86bmr653043285a.46.1744403794212;
        Fri, 11 Apr 2025 13:36:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8969428sm309109685a.61.2025.04.11.13.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:36:33 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:36:33 -0400
Message-ID: <9e2b3a966867586719e9757402ee3817@paul-moore.com>
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
To: Takaya Saeki <takayas@chromium.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, Nick Kralevich <nnk@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, Junichi <uekawa@chromium.org>, Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org, Takaya Saeki <takayas@chromium.org>
Subject: Re: [PATCH v3] selinux: support wildcard match in genfscon
References: <20250318083139.1515253-1-takayas@chromium.org>
In-Reply-To: <20250318083139.1515253-1-takayas@chromium.org>

On Mar 18, 2025 Takaya Saeki <takayas@chromium.org> wrote:
> 
> Currently, genfscon only supports string prefix match to label files.
> Thus, labeling numerous dynamic sysfs entries requires many specific
> path rules. For example, labeling device paths such as
> `/sys/devices/pci0000:00/0000:00:03.1/<...>/0000:04:00.1/wakeup`
> requires listing all specific PCI paths, which is challenging to
> maintain. While user-space restorecon can handle these paths with
> regular expression rules, relabeling thousands of paths under sysfs
> after it is mounted is inefficient compared to using genfscon.
> 
> This commit adds wildcard matching to genfscon to make rules more
> efficient and expressive. This new behavior is enabled by
> genfs_seclabel_wildcard capability. With this capability, genfscon does
> wildcard matching instead of prefix matching. When multiple wildcard
> rules match against a path, then the longest rule (determined by the
> length of the rule string) will be applied. If multiple rules of the
> same length match, the first matching rule encountered in the given
> genfscon policy will be applied. Users are encouraged to write longer,
> more explicit path rules to avoid relying on this behavior.
> 
> This change resulted in nice real-world performance improvements. For
> example, boot times on test Android devices were reduced by 15%. This
> improvement is due to the elimination of the "restorecon -R /sys" step
> during boot, which takes more than two seconds in the worst case.
> 
> Signed-off-by: Takaya Saeki <takayas@chromium.org>
> ---
> Changelog between v3 and v2
> - Cosmetic changes
> - Mention the new capability in the commit message.
> 
> Changelog between v2 and v1
> - Use given genfs rules by the userspace as is, instead of appending "*".
> - Fix __security_genfs_sid hadn't checked caps of the given argument.
> - Fix the wrong strncmp usage bug.
> 
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  1 +
>  security/selinux/ss/services.c             | 19 +++++++++++++++----
>  3 files changed, 17 insertions(+), 4 deletions(-)

Looks good to me, merged into selinux/dev.  Thanks for your hard work
and patience!

--
paul-moore.com
