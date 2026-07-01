Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A43348C7B
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940663; cv=none; b=aFZqTH/0ovZiA1+71Q5g5lyeB54XwnYiWUlVAstESwxTKQefbKYv0vflCV8Sj/PRd7HJjyOuPkTJs4GX4IH/uEsvyPOk9i14BqXN/U957L4jc//S3gH3pF8Uiusw5uGGJ8yZSBM+av8hsnY0HNmMwDzSa9kbFHFKfOUL0ljwNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940663; c=relaxed/simple;
	bh=Vz32z21t7N6QDvCWFa+4HnqwVdRj+wM5kqXaX9IPP+Y=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=bcOskztUfhdMLkUS3qxQoLNkWpfL+12PVwbaURT2v3VuL4sSpRrtddhlt76aQJNVxwCaT5Y3h9MpGR9YsXwIKBo4YmkOqCciO/Uz+DayzfDIKgSNpM0T6HxOofk5c/vVdwPLb/SHSrytHRPhjj9ZxRAO68+uXazgONSKP+qDLlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZbcM6/8z; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZbcM6/8z"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f0079614b2so10967276d6.1
        for <selinux@vger.kernel.org>; Wed, 01 Jul 2026 14:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782940661; x=1783545461; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZbPHu0imB0owCgWS3wUk9cCK5G2nV/1iLDVGI58C8w=;
        b=ZbcM6/8z9dh/LiMJLWgbWfmcXCGWu9z7YH3qfLxuJOz+6LxXwNnXrMG8gk/W1B5sdV
         2ntVCAJXFhcMoP5HW5zRo+qIsmUK+OE3iRasAg1NxK0qrNPOE1RJSkBO0rXwiYuSLXpa
         5SHxQnq/vtlACfkR4hNdrbKPZxhIYsU/iyMgx4Gw+22OcKEDXOnz54oS52ZCA/OF+IVW
         LAz15Xp8BeOHT/lTyYYVE5RbHK3GpGR4EJyvAAL08FlXrt1Hw8n9nVuNkURSwgRpEnij
         YRawCQEhwOMfLRoYxeBdWOeZgq4KqYMZpmTg3GMgb3cYFnDBYygD2ze2VRMyDZhxMA9g
         6BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940661; x=1783545461;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZbPHu0imB0owCgWS3wUk9cCK5G2nV/1iLDVGI58C8w=;
        b=m788pHWwL4k+ERzxeTeeKIw+h41n5FdXeIRp4EKmkhJobNrANpSJldkoO0LIm3ocun
         dE9kqZM1ijq23lTGz5W8KLyRL9DJRDonDwShGlg0VOLzlbzTvjfsy6WG/+Gr4wVbkO1l
         b74JRT45gIxSq78uzw3pdItLBimyBIU6NTCqb5qjU2xSMlMSt4vT8UDm9zmWsoyDVldl
         wNqrGIG1xovd7nRkbNTlFjgBDTy2t6CCqGZWn6ZtTMnI9xmKuLxGwBw/kv7XAWD+fnUv
         tWY9xXKvJtOnDWZ022mCVE3gMbfD+Wq+ZfrdrbOgk9YNJSYnxtN7M7vZESU1/y6nye/A
         PvjA==
X-Gm-Message-State: AOJu0Yx6sc6vUgCsChalUmdPTydWUD8WoY5s2BXuZS0MMfyr5u/qDsPQ
	sjTtTzRQ4ifoQ1UKnx24lwo79mJGG4CsLTNcDhS5MSL5K+SbvUzc+4Im/zpuTdCL9Q==
X-Gm-Gg: AfdE7cnLh+1GrkfD/gAc9e2OOt5OM8qXP7onkZ55LXoWV/zbKL/cErt9ZWYPP/Dk5Gd
	1p4nAbMuz6gOMgz8rZ4jlXqwIKR5SLSVXsMTlvWJ0Jij1Lu6x8FFXkp948veg2JEjeUYAHRfHr2
	dNz5kdFAZrJuDBa5O66zxo/xCwWgs+lK0PpPr58mLt83KDzeH5ARtbST2GvqZJTvNVWeEWaz6Ja
	MjXBzeJVCuVIiraCyTkPfRaom15iVP06dHyFgbiuNfVqOK0+2VOiDXKAgFnkqavBoxxEYe9aQv/
	AuwskKiojuAJQbeF/fGz4diWWoA2dLet57jK2/KGkLoCULsJn0uFJ6lLaUIDpO7UKLTfOvEIT4B
	x3Gu0piLMxX8hOPNXJkCVGsE6gpCo4IpmzOXrY6XIzWWw67w/3vdpruxz13OVjfqtXfMlwlmrmS
	2ber22f0GCQYCMuN2xKTte5vmEgNFyc8JReOnBdcZFZ8bTeS5wzWWe5lTkdw==
X-Received: by 2002:a05:6214:84cb:b0:8cc:f074:95e with SMTP id 6a1803df08f44-8f3c8b16eeamr43341866d6.30.1782940661502;
        Wed, 01 Jul 2026 14:17:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f112547sm8046916d6.17.2026.07.01.14.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:17:40 -0700 (PDT)
Date: Wed, 01 Jul 2026 17:17:40 -0400
Message-ID: <b64e16449728cd72ed3968986f5ab166@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260701_1640/pstg-lib:20260701_1540/pstg-pwork:20260701_1640
From: Paul Moore <paul@paul-moore.com>
To: Haoxiang Li <haoxiang_li2024@163.com>, stephen.smalley.work@gmail.com, omosnace@redhat.com
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org, Haoxiang Li <haoxiang_li2024@163.com>
Subject: Re: [PATCH] selinux: clean up selinuxfs resources on init failure
References: <20260622143722.1167703-1-haoxiang_li2024@163.com>
In-Reply-To: <20260622143722.1167703-1-haoxiang_li2024@163.com>

On Jun 22, 2026 Haoxiang Li <haoxiang_li2024@163.com> wrote:
> 
> init_sel_fs() creates the selinuxfs mount point and registers the
> filesystem before mounting selinuxfs internally. If kern_mount()
> or the subsequent lookup of the null file fails, the function
> returns without undoing the resources that were already registered.
> 
> Add the missing error unwinding so the internal mount, filesystem
> registration, and sysfs mount point are released as appropriate.
> 
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/selinuxfs.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

As Stephen already pointed out, the cleanup isn't critical as the system
is going to fall over any die anyway, but it shouldn't hurt.  Merged into
selinux/dev.

--
paul-moore.com
