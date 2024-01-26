Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1FE125D8
	for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706279572; cv=none; b=S9P6Ef4A5P+GuNfUDn6b/HLqO7f/g18nYNRszyjkfYhG4ZEyMSjKjM0RnKRLBFXYyGKUaeO2Vo7W9bFYBIyvHmcfYI+OQcEc6QtiHeD2sY1Et18Y9wTh0aaho8r194JQu5w8VuQJMnV1UUx+aEnktMQz5An4WSvC5Cw5JYx1PS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706279572; c=relaxed/simple;
	bh=6PPRZrNsmHDjZrpEUeko1khDonxHnwNEvcTO2stQCJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqnSpg4NJNxic/2c3JEdWvhTpLzeP43MIBTMW/PzDiEccKvOGgp/vhyy9perADoMbdza5bnUBzPZXIQvrtxPva+JqY/8h/gsHVeY7QcjXDsdGCsh6vWez12kEYRjk/9SH+O54KYB5qj5Mb4jiVKjjKh5dsMo1I7jxfm3dhpZACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+jN9LCk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+jN9LCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706279570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNabKwrVREWMEeA3kDjfDhpYf/5K6ftzVIbV9xAafXU=;
	b=T+jN9LCk7D1VHG+fvEkT2P2gvqgupjc+DNc5Ah2zIrNIDgh4GPPSPSW3OEG5AqTWcgK8c4
	In84hffvp64ubZosYPCsbI7Tx/smChGihtqCtMqeEXzvMmyFuhQJXBx5gCzllhPQrGHkS/
	+Cc5kqTCzyaCA13kfzsY7PtYBY8R9Wo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-JtZcMHD8MVmVm2tAYAtNDA-1; Fri, 26 Jan 2024 09:32:48 -0500
X-MC-Unique: JtZcMHD8MVmVm2tAYAtNDA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so278507a12.1
        for <selinux@vger.kernel.org>; Fri, 26 Jan 2024 06:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706279567; x=1706884367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNabKwrVREWMEeA3kDjfDhpYf/5K6ftzVIbV9xAafXU=;
        b=bi0PHJnLZnwR1fWXZqNFoB081vPOkp/qvfmqKSiVxMVfZIv2OeRhKR4fni4bPjMQsy
         WWLc9+h58EKIS93nlqMVOeVGtlf+1y6bL94bm2Q79CuZpDLutA8A2Ol3JV9c6mRH8EB1
         hrvhLv0i/yT9n17eLdGL4hT0I6PLZAuPPQp30Np7ZVDjQ/PPcOwgKoj+eTSJf1/jvgrs
         s96tGjUnagE4GtcK8QKcY0Zmf65gknD3aw9upDR+UokYtO1Dds3RCJyYJeYp8E1IgBu1
         EtiWB5KTdkfVDWTq2PgMnaF6c+swf2mfoA2YsP+SiuC2r9rIOPQziGUogyQfS1k55nOi
         ht6A==
X-Gm-Message-State: AOJu0YwE0oCiqZPBw/iuxaqkc/ozmbOWZvsr6/GNHrCXvusKijVqzMdL
	CP65He8hactTcmiAkfNt+syaOuyusyEb8zz2sMZOUNW1JLYxDE268oQ9gsvv1nNCD473gF0zt4J
	knobXTbX5roPKAvNZwkniag7lyhXcZeY6YGBptN4JT36slqeuELgUZ0L1C0qJYNTstxTyWm1NUL
	o03ABEDfzN9qqKLEoeAbAGoV1vpLq3X2NoY/PWr/zf
X-Received: by 2002:a17:903:41ce:b0:1d7:443a:477 with SMTP id u14-20020a17090341ce00b001d7443a0477mr1214934ple.110.1706279567032;
        Fri, 26 Jan 2024 06:32:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7f4Ddg+xn8XLYOyK7hDipS3kgJ/vif8kdaOufGf3LfaAtLCgK7hIa5S+lsNU0lxppHuMQSJhQE5DupGukguE=
X-Received: by 2002:a17:903:41ce:b0:1d7:443a:477 with SMTP id
 u14-20020a17090341ce00b001d7443a0477mr1214925ple.110.1706279566705; Fri, 26
 Jan 2024 06:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126104403.1040692-1-omosnace@redhat.com>
In-Reply-To: <20240126104403.1040692-1-omosnace@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 26 Jan 2024 15:32:35 +0100
Message-ID: <CAFqZXNuK4m+CQFejWx6nWkoMFmDDzhDw7FZhFMbKZUQVQ3JeZA@mail.gmail.com>
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:44=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> The inode_getsecctx LSM hook has previously been corrected to have
> -EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
> behavior. However, the call_int_hook()-generated loop in
> security_inode_getsecctx() was left treating 0 as the neutral value, so
> after an LSM returns 0, the loop continues to try other LSMs, and if one
> of them returns a non-zero value, the function immediately returns with
> said value. So in a situation where SELinux and the BPF LSMs registered
> this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
> returned 0.
>
> Fix this by open-coding the call_int_hook() loop and making it use the
> correct LSM_RET_DEFAULT() value as the neutral one, similar to what
> other hooks do.
>
> Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90j=
YPwRQRAqXxmOKD4Q@mail.gmail.com/

Actually, I should have also added:

Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2257983

Hopefully it can be added when applying if there isn't going to be a respin=
.

> Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecctx")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> I ran 'tools/nfs.sh' on the patch and even though it fixes the most
> serious issue that Stephen reported, some of the tests are still
> failing under NFS (but I will presume that these are pre-existing issues
> not caused by the patch).
>
> I can also see an opportunity to clean up the hook implementations in
> security/security.c - I plan to have a go at it and send it as a
> separate patch later.
>
>  security/security.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/security/security.c b/security/security.c
> index 0144a98d3712..6196ccaba433 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4255,7 +4255,19 @@ EXPORT_SYMBOL(security_inode_setsecctx);
>   */
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxle=
n)
>  {
> -       return call_int_hook(inode_getsecctx, -EOPNOTSUPP, inode, ctx, ct=
xlen);
> +       struct security_hook_list *hp;
> +       int rc;
> +
> +       /*
> +        * Only one module will provide a security context.
> +        */
> +       hlist_for_each_entry(hp, &security_hook_heads.inode_getsecctx, li=
st) {
> +               rc =3D hp->hook.inode_getsecctx(inode, ctx, ctxlen);
> +               if (rc !=3D LSM_RET_DEFAULT(inode_getsecctx))
> +                       return rc;
> +       }
> +
> +       return LSM_RET_DEFAULT(inode_getsecctx);
>  }
>  EXPORT_SYMBOL(security_inode_getsecctx);
>
> --
> 2.43.0
>


--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

