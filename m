Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD1430EF72
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483584; cv=none; b=iLvh/x9n+cYHprOCkuQmTREOHS4Mcj/yMW5eqqFCYSKuao/q2yo3jDB6lEIcQ6f+LMIjHWSbfu6FjEM6ZQxWCBCn6Q2BSyYz4BJfESgB3xmJccMjpypNyz9KbzYJZCrmA35E1RmnsMVX8PLS/9MG8jvv631im2B+iokGopn2xPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483584; c=relaxed/simple;
	bh=THERYyfWpJts86ukp6+/qN9qrzmQKu6JuEBRRXPCS04=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Bm0RZ+dLtYYJFy9I0m48q1EH9EeWZUy791qurWNMka9NKm3vyKzQIMWUXP1K9MFlC1pMlZwqF6qVasnfOlMztwrnjWVcKXHhQft6flHH8vslvAypAeN4Q9UOUOp0Q/f6GwEVIZhw1yQGNgM2tX+3b7/vtGQa/biKbcxXvZ2WUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GkIkFMgv; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GkIkFMgv"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-854585036e8so840219485a.1
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760483581; x=1761088381; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlJ/rymt2z0wf/HxlvzM0A8sd5hIISBlOct/3Lv9hgc=;
        b=GkIkFMgvsbHSUec2iqXrzQ6YkQNWroORiwcfzim1k+yimK40eAgy/MJ7vsZhnVCart
         eEL43wryNNCskIbZG2i4xyXjsZpW7jE60WE9uuXlFDvar85+RJXi6oEsYueFgaNTO8Ww
         YQuHfv509GC/Femn5YIK/rH54kyHYPj1fMFpxdNPOIgvikS+sraeWxz3eBjg27wkbX3F
         H0QXkiU9qtI9b4LiMp/KB2yPA0ysZuX+EfDeNfkbPKyRQlOHrgHtxfj4YQ3OkcfZLP4L
         4BD8k2RHQlcwYPGeINzZBMHXGM3N4fctvX50MFCmXFK4ZAt22Mb2WV1d+D9LuA2TW3tk
         htEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483581; x=1761088381;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YlJ/rymt2z0wf/HxlvzM0A8sd5hIISBlOct/3Lv9hgc=;
        b=Okhsf2J4axthVWc5VAUlcVaH99EMo9I5d3iEfidWGf/LQa+fNLRnOKC1cHmXWZFKE4
         m8B2H/EChypPeMbKGOnwXXq467Mr5DfqYE+p9XhGuOe1iFC2NFpTs+WQETW2HdbjPH3v
         kD7w5q1BpiECwWFb79uIwCvQ294KGIvMHmLECQ78ZTiEWBPloKCb6k3+tmPDxEcYGOEH
         bpdpbVPm/hLTJO62ZLuuqJ+Qcp9moJRDg1cMgzNC2zVcUAPG5Gadoqb5x+R6Pa3uiWeg
         CKBKg9GSYJCsyHMCuoNyyqA9ADI4olh0mkr6p+oA7/OXeVBPPcptRY69T8O430K17U9k
         77iQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3gg9Q7071XLzLoSzJeP5ZV+TDWUKlgfJticXY8I0vMFFmI1JNvkDY1yoQctytErSki8XD8eyW@vger.kernel.org
X-Gm-Message-State: AOJu0YwZOyfVJtpGI+1BxLBZ57pkxXY0U8soqFw4bZE4ioulpHy3Y8SK
	Vu4yuodkwG4j4/4a76fu2ATiJRvLtkO8Qtk2vegf4R26Dl74nv2Kv7Yr5qt1qFHjiA==
X-Gm-Gg: ASbGnct+a+5uzsNC+xcAB1r7txOJpTdm5xdHBpBWHlTH2UNTY+QT55soT6IuQhdmgYp
	ZxVlgwoY12exue5IS/0UFQ5z9G+Jy9nkJw6E+QZnJLpgOvXFh6tf5hMWQbppypWVdkVBq6lQ4zM
	KSGqq+Sx6s4yRUlvpmj7pZrmDC85nHmu/V6Yybig6fta+Y1FqjRNgITSDRVIUg+EqyQZxgiKg5V
	4B4ppki6bxW1ATnQ9U8YZyJCxrUstP3l/orXnvwMmWgBcsubjgfAlinXrZyLRKtHOdD7FpKjzKF
	w2pXJoEDmWXI4MRSI/ORdofl+LrZK9EJgQ6rk2x6tAqTWynDdBeKwb7t1wXLNdTSqzgoQXT8Y47
	J0mMyCdt3T69infxbv8djmvObcACk7nUNHYg/nhuClUliLuYZkhRWHGvOPumj4reuZ+FB9STWGJ
	m3+gmBTjFVkGo=
X-Google-Smtp-Source: AGHT+IHjfyLXfSHciAF/hfVvhvyE+ji/i+hx1L96OGYtoV5M7LCsXCFga6nnYCODgc+TQMAmXTHAGA==
X-Received: by 2002:a05:620a:4589:b0:84a:af34:5b7f with SMTP id af79cd13be357-88352d9a115mr3780054485a.75.1760483581287;
        Tue, 14 Oct 2025 16:13:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-884a293bcbasm1290971085a.58.2025.10.14.16.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:13:00 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:12:59 -0400
Message-ID: <8f72249ed9358a895e6821495cab933a@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251014_1821/pstg-lib:20251014_1132/pstg-pwork:20251014_1821
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH RFC 12/15] LSM: Allow reservation of netlabel
References: <20250621171851.5869-13-casey@schaufler-ca.com>
In-Reply-To: <20250621171851.5869-13-casey@schaufler-ca.com>

On Jun 21, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Allow LSMs to request exclusive access to the netlabel facility.
> Provide mechanism for LSMs to determine if they have access to
> netlabel. Update the current users of netlabel, SELinux and Smack,
> to use and respect the exclusive use of netlabel.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h           |  1 +
>  security/lsm_init.c                 |  6 +++++
>  security/selinux/hooks.c            |  7 +++---
>  security/selinux/include/netlabel.h |  5 ++++
>  security/selinux/netlabel.c         |  4 ++--
>  security/smack/smack.h              |  5 ++++
>  security/smack/smack_lsm.c          | 36 +++++++++++++++++++++--------
>  security/smack/smackfs.c            | 20 +++++++++++++++-
>  8 files changed, 69 insertions(+), 15 deletions(-)

We discussed this patch in a separate patchset, lore link below.

https://lore.kernel.org/linux-security-module/20251001215643.31465-1-casey@schaufler-ca.com/

--
paul-moore.com
