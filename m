Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90ED186294
	for <selinux@vger.kernel.org>; Fri, 13 Dec 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734125740; cv=none; b=teeQQNzwjjA+txK9SBQAJHr9OnWqVTqNDU0W4aiQFfsf7TEA+ZsLMcviCE40Q0eCXCw8KJOKFYY0m7SRM94mOoVErmK7VeT4Lbq74K7U8WOI/z48TGxK+nb1Hs5s7VWAEq8O1jCJJo67AFSLhSOriZ+rjyATA0qcxAIBPhBte2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734125740; c=relaxed/simple;
	bh=x3GHhDDz+w/e2kTp0CgeTu7Ox8Xxto17JSa17pTcRhE=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=LluyRnElPG89ZLv8m4OYsTzI7X5LNeye3w3hDVHltP73TQJOB1N3XEmo/ZWOOuGZLECFE2QMEy6njgqy0KIzv9oCOt+xwARZqhuT6q6mtqD3eJ6F8HlGfjGBkEeND0B5A49pxtSBPs0gLF9JhEpifHcgKRV8NiLmrRUmEzui72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dEOKJqTJ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dEOKJqTJ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6eeff1fdfso168572385a.2
        for <selinux@vger.kernel.org>; Fri, 13 Dec 2024 13:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734125737; x=1734730537; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HFHmZqO8rwrFHWPgtsb6iToA/B4b/YAVHMgtPHT7prE=;
        b=dEOKJqTJ2bXaVkBjsAJwpnmXxrLrGGw5AJFRSPJ+wnJcPmO0Pjvj3DoI6mUQgAWzAQ
         IzoXyzo23IsUYdkHA2vIgcyrZWArGXMU/AzSnD/xwLxTDyYMpDvuDjqu5T7eIZm5+iLH
         1NFwxtObE5qsSaCPjECFgWxeVN1WZ4WxMUzvfhPwSzZYCIrD9iKWU+FjmLBMnbp8WxaQ
         r3urnAwldzpAF746ozEmWMTUW7xBS95pzFTC1755KXCsc30AlcRSuP9OzNqbCEbGvh6X
         ux8ZRaw5DVH0RVa3n/etlhjKY8kgg1OC4/Z1U6ltA41uQ48n6BURI8UJnIbmXRQaGGak
         7v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125737; x=1734730537;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HFHmZqO8rwrFHWPgtsb6iToA/B4b/YAVHMgtPHT7prE=;
        b=FljnFlxZpEbpwFa3Wv7vhvPWwvgQ4ZMdmDPXgbDEN8yGIbIT9vuG8ERYV3BLSnvkrf
         dyjmVR3hWaZux1uP50NzBm588bi4jyKenJEi8YHwr7Ta+0XS+hzCfTamtlkQ5MPop/Zh
         EhycMqx9DmsbLkALyNKGJ2HzjJWcrlUK3pXQft0lY6VHNOtuY5kt/5FNwIly7tlyH7rw
         ojW558Lg8bsbHpxc8HP2szHNi5c/EnLQEEhecadchNjDBiFCAOHAIIxAt8rUs8C99Bh5
         UtjnXxaVqrZQQlE0e2my0o9M2y4nNql3hp+68UUOjX5l8H5Wk5L/GCbbFmAdchYZ131Q
         9Rpg==
X-Forwarded-Encrypted: i=1; AJvYcCWBMl9Z0db3IoM3C9cIdMjCpuZczjYeKXactdIhPxfTlvm+EIlc8C8LdlpyQD1aKPzoLo86pYej@vger.kernel.org
X-Gm-Message-State: AOJu0YyVgW2ltXAo24lr7ZOq1lO4Nxll4TkyZH3w/UNSYBUCGZoXb2v+
	HcKovuFoIVYHaceuzYXjQXjVqKanY27dQzE5HAgVfDx6WT1Zfa0r0gjTeyVEHA==
X-Gm-Gg: ASbGncuZDEf1IFYXwOhs5AvsJF29xfE/0HDSXM7lY1YFItUdUOTyJmrSa028vioB+qQ
	tZgBdLgI1+AWUi0Phuxi3r/8hSS0vznl5bKxf/BJbF1GhjmMnLxgv4VDOAkL8qWiayNkMxkJIl3
	M6QAez/4dhk4VI5qNYMPHYUX/XWdCpDbq2Kkc3znsBZxX6CPSTD+K0FKikCQKWoz2iqlkNu2BXx
	cif5vknkNzYvsvhAxMb1Je56Aefp4mXCA7cLFkPRNPVrru115U=
X-Google-Smtp-Source: AGHT+IG+fLiThWzfd2vnNSoUStixEM3TTG2o3/E9Its8SqN9dsLcqFmi2iUwPpvSIVoZOiYVmfrKAA==
X-Received: by 2002:a05:620a:414a:b0:7b3:577b:6d9c with SMTP id af79cd13be357-7b6fbf42174mr600237685a.38.1734125737584;
        Fri, 13 Dec 2024 13:35:37 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048bbef7sm16364285a.90.2024.12.13.13.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:35:37 -0800 (PST)
Date: Fri, 13 Dec 2024 16:35:36 -0500
Message-ID: <dd43826c8fb600f967196c72958fc6e5@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241213_1548/pstg-lib:20241213_1547/pstg-pwork:20241213_1548
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>, =?UTF-8?q?Bram=20Bonn=C3=A9?= <brambonne@google.com>, Jacob Satterfield <jsatterfield.linux@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selinux: add support for xperms in conditional policies
References: <20241023152719.24118-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241023152719.24118-1-cgoettsche@seltendoof.de>

On Oct 23, 2024 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de> wrote:
> 
> Add support for extended permission rules in conditional policies.
> Currently the kernel accepts such rules already, but evaluating a
> security decision will hit a BUG() in
> services_compute_xperms_decision().  Thus reject extended permission
> rules in conditional policies for current policy versions.
> 
> Add a new policy version for this feature.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2:
>   rebased onto the netlink xperm patch
> ---
>  security/selinux/include/security.h |  3 ++-
>  security/selinux/ss/avtab.c         | 11 +++++++++--
>  security/selinux/ss/avtab.h         |  2 +-
>  security/selinux/ss/conditional.c   |  2 +-
>  security/selinux/ss/policydb.c      |  5 +++++
>  security/selinux/ss/services.c      | 12 ++++++++----
>  6 files changed, 26 insertions(+), 9 deletions(-)

Merged into selinux/dev, thanks for working on this and your patience!

--
paul-moore.com
