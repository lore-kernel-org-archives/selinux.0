Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D692356DC
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403379; cv=none; b=B/n1jN6ImqcRugA4ZlEnvKnsYjAPZs+rzbr8/E0ZUzdaDmSucd7FmbqUgTlEPoN51dabfWWmp+/yd7yZAPE+FNbvgL1kBx1VQe/uBTHhCoa/K1sqQFsv2TpvOCk7RqEccV+Kawe302CUIKA9HrQgIY864qBO3AVKteKYMsENKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403379; c=relaxed/simple;
	bh=G2upKdynmt1RjnHyNCDv/lSNPDpDWCongvD075BmuaE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=AASwd5/yg8dU2dRHsmHIewnDfErP1Rf94oaIH9JmJqRno4uUck6CeCihy8b04k0SuyME0Hl4f7/M6E1wxnikX0D6aIvN+F/RIO3O3/lER7rcpc0LSz/fi1zaYxwavSO0YgJcV96rY8VufvnD0XD6HxXq6QhTLP7PfXQ+4jPhhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BEwZzqKt; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BEwZzqKt"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c08fc20194so467343785a.2
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744403374; x=1745008174; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Si33EQaNiOX83vVGoKq7qCxj0Ykt9ILvVjkrrHoUTd8=;
        b=BEwZzqKtTCCRpPmb8EBcqXZE7UzA21ssZcrMCGaHR7q91HjkVsHNyPxzFgtuJNecN4
         XIf+OyMuJjCj5671MIV4W/VI+Mr/TwXmQ5GgkCuiImGjgGmuMRKHSAqUtv6q5/QmR4EJ
         qA7XB3L3D85CrFfYr5ACp8V0n7aksCTwJEtCWzo7baMjQMgsaqTIl8ET9BZr9uQrNG2A
         6G++uAbuqbFa45eQT4flB7AdXLjGYY5lxS635U0igzPZl2UQ2gWZR7VSA+qB82peocgl
         L5rtQkHJgDXuDav7m4rLcxfa5lpnKlmfg2SA3kWThxAAC3afptgTQC8aDOFZPxH2nxy8
         0Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744403374; x=1745008174;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Si33EQaNiOX83vVGoKq7qCxj0Ykt9ILvVjkrrHoUTd8=;
        b=CEqkJwe0n4MQRI9ROz/CP3jzsJdSQHASUM7S8aTz0/wYm+/zCUzuXS6rBDCJTzXvNK
         aSKpN0VmUIeHexuOog+pigkaxWB9c4v6VZ34RSPtszC9xx4r6ElW93MU1ziP0f+r3FCA
         WQW4aCxWevrqcmE3KIKVqpcOB7n72QTBROAOVsEMOJ/ze++SGsE9ews/ZHWA7UbGmhEH
         5/+iafPW9BBHv4NqgjWS4LYcR3WaLevAa8OGOz6O6Bgqny89AU7di7gwKAGXQ2AdQiZT
         +3zSrYe0U0/Br2fevxBWGV39x89N8rt84z6n3Po27snWxGwrm8q6U4qS97GFSObMMdYr
         zLMA==
X-Forwarded-Encrypted: i=1; AJvYcCVb7Aoe/ExXkXWbMYfVnqnsP4m/51PqlRtE7pt1OjAafcRMMYcryuepsj2YSGYr9ONDX1XkpWUk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw783zn/L+VgaXHfsP/TUjV6XfuaUsnb6/Z9Y/XMDFQlE2/DXez
	p4W/6Az2Hd6YJM+/xak2HDVifq0DxGlj/mp97t0MdXBrP1kWtMMYydJe+QT0bw==
X-Gm-Gg: ASbGncsjmHIhd0D9SycfFIvT1waAqyRDiE1B4EI4ViQz2gDU2TBrZULxSuypopbfWFi
	0xzogPQezHSORjw2lfpG2yVxFE05oAYqjx2SE5dr0TCToMEQvGvqlBanGcsVzUwj7fcAnUHkYmX
	Fh+ogwD3vC2djazq+2j13MlWNcBg394YOnzIO8XYJ9I9B1fPg5PktaWGR9wP3qPZErAq0tPuEaC
	c6qEuk6MJGcR8cC/2wxtV/FE/OwdQmY9vkl9/2Wz3X93sOgRDkGzzkz42t52E0abJ9CDy+AaoD0
	604mwwKbRGyVEqBACzhoIKdlakolB1/DPVE0DCArrz37K49YpbU3gisPv8s8Kr5/UWXIxRgY0nK
	RAH5DQvjZ3pNu9LOc0AfS
X-Google-Smtp-Source: AGHT+IGX8jjaOEeQbsS4xcs3SmPRbhfdrNv00id6cLRqMi8NgNQGE8aExoTjJ+O834zObzXAxutypg==
X-Received: by 2002:a05:620a:4555:b0:7c3:d5a4:3df3 with SMTP id af79cd13be357-7c7af0e4069mr643280685a.34.1744403374553;
        Fri, 11 Apr 2025 13:29:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8951f5esm311259085a.48.2025.04.11.13.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 13:29:34 -0700 (PDT)
Date: Fri, 11 Apr 2025 16:29:33 -0400
Message-ID: <937e51d0b9babb8edd206c7f4eee230e@paul-moore.com>
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
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Casey Schaufler <casey@schaufler-ca.com>, Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] selinux: constify network address pointer
References: <20250318083422.21489-6-cgoettsche@seltendoof.de>
In-Reply-To: <20250318083422.21489-6-cgoettsche@seltendoof.de>

On Mar 18, 2025 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> The network address, either an IPv4 or IPv6 one, is not modified.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/netnode.h  | 2 +-
>  security/selinux/include/security.h | 2 +-
>  security/selinux/netnode.c          | 8 ++++----
>  security/selinux/ss/services.c      | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
