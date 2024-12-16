Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C11E24B34
	for <selinux@vger.kernel.org>; Mon, 16 Dec 2024 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734317946; cv=none; b=QtAkNVvYZERsgYHQ08cojyWglJkGMiJMYASVnecg2JLJVi/2mCseEYwUO95ZlyFezjlHLNx/JtGpIJYmzc/+yrmvHaixsC5IpAYCDz7fZWRwTMNASnrXEKJT257LAGT4FcYQ6roI9dpn15EGXkpq7KWUc3rbDzT9jqHtyl24aKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734317946; c=relaxed/simple;
	bh=oRg/J94eTfjNlSpqnBL8YlCcwuUSaH5Y2FVfIOF8K+s=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=d94c8w8F33WHnOgxKNI64xwG4xbmVNUb8JH9XWGEbiV/upQK+RydieBybm0L/yHinX1MnjBRcvp7qsbINxc6CyX0sOtgdneMl+3/Nceg2pLlN2V0RDYa34m3LheFyZW1+LxlYGlZhbrs/iEuyWDrTGuhTGUO0NZgerEh8H4KwfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Jx4KE4WK; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Jx4KE4WK"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6ff72ba5aso188425685a.1
        for <selinux@vger.kernel.org>; Sun, 15 Dec 2024 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734317943; x=1734922743; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKP6nHWluS7O1xJzbUle6DGcaM+38kjCKwlkf+H4O+g=;
        b=Jx4KE4WKznFV9Xryab0wqMwgD3rzvYLUzvEa8vVhFA4gf435HLrwwZupPkFBiTGJKp
         zRh3/WwoJQTvpd18K0i23jSTESR0XTFC2TZOBQMhdgLV6ukuxsZCFc5/q0xfAhdCNuXC
         h+7BoRtjyt+0jQ8oqIuRBgGUpDBgKV+WRW4u7809PBo8NlAXNQGIMe+Aho1NETkU4RZu
         Lsvo6VH4mihpnrAFntAngGERh5uUimZa29wKtiZXRpxmxVhmOHicWRZdAkNgDo0Mw/Ut
         H5P9W2p684YnFbyxdLrYcmobm2o9gkLHW/PtCnIq0QZLkHWC8K2NzMYRTZBd0U1Kc4Ka
         ChTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734317943; x=1734922743;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vKP6nHWluS7O1xJzbUle6DGcaM+38kjCKwlkf+H4O+g=;
        b=TaLIaBsQ+nknIJJyGNSbpZaL2O+GGwi1/o48a869cEYWlMcZouFlfB+pASeoFOuWkk
         6VYSxLfVrGK+iHybPllN/lzRjfnF/PHYGl9rUK5WIX7O5mBEFX0acR/nY43o0FX7V37e
         lriblK23CJnm9Sr+cU9hKmvfKma1QYuboXan+nzZzHZ2rjXFLTqPUF+SW+UZAqWv/8Xp
         xOCNZt0u6IgXjB1EUK3wDXZvzk3YhJmnrrBw06+rqy51y2I4cu/khw2TOPcmF+78pJxl
         7QF8U/U4245Kd1XYIU5N3xAR7mrlbvtni1UmLi4f8Lz7zc0YuNJrHtlYL8FdzWXI1tyx
         IvMg==
X-Forwarded-Encrypted: i=1; AJvYcCUimLlwRKdVMynKXZ3ybBQPj6NKdMu7ygCCXR296UEp5MeZygH2PX3ntqdOPPQUweaGZL+ugxO3@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBnJK0E+buYKG7mSVQmj8+4l7cF07gr+SsE/jzVFAipB7emGi
	p+UzkOFYg8D4441G6JyzApt0h8ja/xr5z6Ax3Mp/i+KRrSpLJdyhEpnr25craw==
X-Gm-Gg: ASbGncs6Sg3DjTueSAVAlUvRoKSe+3qbza8PXnRFlV6P7aZvgE9rtd4PE+p8uOU8yic
	QFvvqSLbo1deK/a7q3ZQsTltibUOxZhG2qxrdGLcVhPf6a1Jpgx34punkUJxg9iCrxQalHa9FBH
	sMFexw7txLI35ai5bM53GUfte5cOJmA4+1vPaMDGYD5ps3gTM3KiX6/qYb5EkQltOWeKPhsT3Kv
	N0cEFleGjrSxykxSuB5Yo/Q1BzRLKXB6BYThtdEaD7FRl1YUqU=
X-Google-Smtp-Source: AGHT+IGMGxkReijwR9eozlTmclt00/3usEeA5lUTtxSR8bPChvJHxwj8qzgZmIUFluwOwB/Zg+ElLA==
X-Received: by 2002:a05:620a:2716:b0:7b6:d327:cc47 with SMTP id af79cd13be357-7b6fbec77a7mr1554405585a.8.1734317943256;
        Sun, 15 Dec 2024 18:59:03 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047cd0b0sm184484485a.29.2024.12.15.18.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 18:59:02 -0800 (PST)
Date: Sun, 15 Dec 2024 21:59:02 -0500
Message-ID: <b1ef65626191549de8d6508f82902863@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241215_1918/pstg-lib:20241215_1918/pstg-pwork:20241215_1918
From: Paul Moore <paul@paul-moore.com>
To: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, "=?UTF-8?q?Bram=20Bonn=C3=A9?=" <brambonne@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] selinux: ignore unknown extended permissions
References: <20241205010919.1419288-1-tweek@google.com>
In-Reply-To: <20241205010919.1419288-1-tweek@google.com>

On Dec  4, 2024 "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com> wrote:
> 
> When evaluating extended permissions, ignore unknown permissions instead
> of calling BUG(). This commit ensures that future permissions can be
> added without interfering with older kernels.
> 
> Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> ---
> v2: Add pr_warn_once, remove other BUG() call for key.specified
> 
>  security/selinux/ss/services.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Merged into selinux/stable-6.13, thanks!

--
paul-moore.com
