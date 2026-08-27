Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD71483BFF
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847833; cv=pass; b=U4iitYAo70HkIYh/SDmow+7jPZn5ru8UE0ZJuhFYQ5+etaMx8Ennm8WhVKz3sP8ln85lyG/fqw0YAoANp/qWxmVrQU+C6APfFQ0z5uHuVj2HPITo3czBPTsUH7g0S1BNsCFsKJuW0qnTlW7cu+CN2rCkOYTszQeLJ4+fZ3gd+ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847833; c=relaxed/simple;
	bh=q+6Zrb2f2addHllpAkt//Jtm0JkwUKGKpzgn+imJ49U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHTJpGXu6H4xXacM5+cj+Fw0zTX3OId+sEbLCNB56O0m2MHymPpdGIIqnIfOxxWTF1ZufXD+2XeODUOphN5EO15f3T5nSzqtnIpphKv73381hyTw8iF/S5XyLztTYBZ0A5k9qpcUUamswCqR5/3SdXBovNDEx7RPaaXcNGtVeXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brxgwnA5; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brxgwnA5"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-446f87b6de1so172797fac.3
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 09:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787847830; cv=none;
        d=google.com; s=arc-20260327;
        b=LaaodDkdeKRY/2cVAKc89vVsqkJJpJd7J+8cJD64sE28Z+oMc3oBbmTwHghkjidpP0
         TgqvFe/aErD49Zmvi8+MS/T0EeJmOXNllldCBjyhK++SGAATpr0XySDl2VvXsZp19HFf
         HjMhifLDeIW8G9zTx1d5TPvu5Hhh7aPHR7jPscTJ7hvPScP0KukZV+Lpq30s2tIRQcTj
         XhrjzSYYgBgh5q6ZlTksvFsRZnPqPD5DoRFqlcTJ7eBrWLGu1xOXmIoSFnanxr+qWr9B
         yA/z4ndK5NvcqUQo67eFKTKVM4re+ehywA3fVGkEYgyfmYmLcuU2vGDwvBqgw+cONkWy
         FrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XUTzc87IBLTMDFxARgNYsdnrB7KY33hFLL9kymhPfAU=;
        fh=PvVq3dmv8yvnCRJYSTWWanBfOaJzW2R+gufroGOSnBQ=;
        b=WGk++AEsWXbjhYkf9oGkEbkqpBWUV94ze3TqUYnzIELeUKHv5EhVHsJEhOuVZK2g+L
         V87RYwyyVCBGKTlsY0uW+oPJlz3DEojmePFd/ei7OZM7kw/UAbofNy9yfoey+8ZgXU7B
         k9C898y5x1KH+F+tDP22Jsbn0f+MHnZG/UZr278gkpQ+oc++zCCkebiZ80MSdZnvTkRr
         pbelD0pic4hnuayEidx4vAxS+3dAXbDIa26+rAqLtbb1APuTZOfdpwszrATG9ghPMNMC
         Sr5mxXTIIoCVIz+gkxhPuJef6nyqVw2xPUdKJW5DpeLlUgNqEMSysViBa9fNShjI93+8
         +kiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787847830; x=1788452630; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XUTzc87IBLTMDFxARgNYsdnrB7KY33hFLL9kymhPfAU=;
        b=brxgwnA5DRWDojC5Dcs5B00pyA9K26ErJc0IGjcDgQqoR3qSyKJhlFvqNeNXsSdmyH
         2R37YhSHKROnZOFfUZLo775eqxFtXvUB8ogdJhllhaPYzz3ip7bikJb6IIIsqR4FQXsY
         WsZacHQmnTD56AOQQcyRBjR52LqCebWmjuQTBfzmXq+sB7XUIIVheh/08Ai/S2Cgb/Qb
         bKIEdluM6Y+0cgS3WBpD08RtqwXIA1LjgQ/6+DnJxA29hXrKEViZgoAylr9ODry+HRYk
         viUUXd/tmdv+dFJPUS3SSgDD1pVTy0HAirGQdwtF39sgAmS01OcYsu+IFqgemN7pU4ge
         wM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847830; x=1788452630;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUTzc87IBLTMDFxARgNYsdnrB7KY33hFLL9kymhPfAU=;
        b=pJUz02mTkuzLG13JhkOrKdExn8kaFjiwEiz2mIqgaojBLnSNifIx1Sh28aTTjzMVJb
         9mDQzdSrL/xCgB/SrZA82Ze+GuHMhLpMuALpbO7Ptf9JhTLmvVDIPUj1XY9KNYtICmOh
         0juJmB8OL7SZO4gaiE/zA4msT+J71dOGm8E4t9yDzopnQe/+xS8+dsv7ALEAEfcrVJcX
         tlZNo+hBEi4WmOlxVtp7C83ihG3FGB3K05vdNi9oJxjUnYpBYBR8nWYDOvgVzCIm1Oop
         8A7yfvJpwSTBwp9baGNMVY5y2/UNfrYQ37j38JVrlUSXpzCBb28bb7HB3j8tR5Tam0gy
         shvA==
X-Gm-Message-State: AFuF++lH3TR9K9I49WOZNaa6K337o9ivsSDmi6zNxNCbgKcjy+zno3YC
	J1oHC1SK0DzybCDaU+dXQHNa44p+qAEdDdG+h7XZNVrEWaRbw4k4vQAKEfDx7C7HiGjCSqQln9Z
	NNXV04pBZrbeGSw5NffPrfUJGkE8RgtUacw==
X-Gm-Gg: AR+sD11WE7ONX79avQ9ZMfSLvtwDG+lIUrcnKOZeuZcPZ0D6YZ22lpqw4FolEg/efCs
	t8RhY9SoZmK590YW+uKubRnvtYmyN+jEbBlpCqwzyGbfln4+2iURfa8SnWudn0Ln8d1Wnx1a3S8
	hYmDS+GvJ3QECq5hhdgf8lLy2uKMhJOqAglzgq4YF3M1FxpXOLAnUw/Idh1jIeZ3cu7OahZW7Rv
	e6mrSWrJjmvDmOmqJSZajNJ88uP7XyiAK9On4nVeIG7ZO44bwXUDPXzO3jMY/ALIMV7XfmPYo8/
	UrAvAwd7KNJ1U5wAN8rDkSz+0JsBe02DIQiSZf67viKD
X-Received: by 2002:a05:6870:e394:b0:456:62f6:7265 with SMTP id
 586e51a60fabf-46837237e0fmr108706fac.12.1787847830186; Thu, 27 Aug 2026
 09:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827151126.107545-2-paul@paul-moore.com>
In-Reply-To: <20260827151126.107545-2-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 27 Aug 2026 12:23:38 -0400
X-Gm-Features: AcwNN1VW8C-fYR4s1CEB_flmpbRsMbzsl2_MoxJD6HVX16oJbDrjf-hXz8bKRD4
Message-ID: <CAEjxPJ5HeZ1P1XLs=EoG_F427hWhUphebVthr+MhnKPR5aWNTQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix BPF token permission checks
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 11:13=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Avoid multiple lookups of the bpffs creator SID using the token's file
> descriptor when the same information can be found via the resolved
> path/dentry (in selinux_bpf_token_create()) or the token itself (in
> selinux_bpf_map_create() and selinux_bpf_prog_load()).  Not only does
> this simplify the code, it avoids potential TOCTOU issues if the user
> changes the token file descriptor passed into the kernel.
>
> Cc: stable@vger.kernel.org
> Fixes: 5473a722f782 ("selinux: add support for BPF token access control")
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
