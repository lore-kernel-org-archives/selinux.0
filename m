Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F31C5D55
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775763; cv=none; b=aATE/H7gl68UW3TsHK/mCYABEK9S1yyzyEnkN0NOVLoXNbW6IyItLLi5XbI32bZBjTkIFFpeGaosA8hEvfINRxMOU46Gz/7tKcs7D9VMWGOV8WTVH9miUATaHrEL7RLjh2aa+HyrHk2ODMxp6SL13/ux3yJhcXSukUZsTb3RXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775763; c=relaxed/simple;
	bh=1+vKnx8123ElRI0Dwiaib8JUlOwzyCto27T1l76WOhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/NPXb+hMBNoAlZgCz2GeSsGJcKLYEFXRF47WequBPA6V8Wk4fj31hl2hFt+0UcQW2qOApTFUAV2F/1UaPZh6yVAufcQgyLyHGtmDqLrFF8jmQ35DhYoPAoki6dCcO42QFZowIZ98I0ioQCDYuYC3VOSiaNcHt0aGcwmZK1UJb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUGDaP5T; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUGDaP5T"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so5337178a91.1
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759775761; x=1760380561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/N4dAWTTln7weEeWhmmty0l1UsJFqRi2cb4WppdmYYA=;
        b=DUGDaP5TQVeo8SXfuQn60Mamg5lOevKJ1mKzDoNSxiu0eFNQphSbmsDBtVl6Cr3ovn
         r8lyEVasSHVGPOlkIEACSPQE//kaIqsZQmRNtKikVHNfJR1utOLIebLX6uMFJu+t2C51
         SNE1htwdYafVWVp/cwiBDvPrijfFkQbUehuOIMS6LXq5Oc227qhLbGQ+LrgeC0OV0a1W
         GShjN8TzREUeGQZ+SeAzn/oHxSJyaj8ERxZ+B6uP85UyKZZPbXATcSkLd7iVrUOMPg+K
         NUJrNwglphqEslE7umRBf80zJ1ka7MsVDd7UB4Y3zhnw7fXQvEfCqjyxEKTK5ebK0Ltz
         rMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759775761; x=1760380561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/N4dAWTTln7weEeWhmmty0l1UsJFqRi2cb4WppdmYYA=;
        b=BTACayKhWzJGfe6kcHT60tmxFzxS6pRF4q3x1b6soGP+YTLJnEpzw6HaL/CxbHj7JB
         LejX+No3v11oSUOb1pKw/2iPyJGR8uJX09/H8ZNVf1sxGCTCX/H5TPOQHqM5mWrm3JHq
         40JL5Ad1B7BHT8PmgwNDa0eKyZXrApJJng1pRHft5XyacVfy8TknsoufYtybmbSu7tHJ
         bvhZM06bufudLdCUKfsfwez6H6LfZNQAj8NTdc29sW6QxaN4NO/FlRx/X+diQxglbmNO
         xp7tRo1MrQZLTsGvzZsCQFl6OcGnOtasnm+whyyzCtQZOQpFTvfU+AOFJC+/SYS5X7eF
         wktQ==
X-Gm-Message-State: AOJu0Yw4S3MWA2yevWGAkhvZ4OWNhRFaAtsOfm4MvmE3gqJ3Bqk09bF3
	pAX/9zSenHXwjqKr+WQr67ssFPzmiUsUzGkUgwvfGinORniXAiJiZzvCavdVFFNsDcYjER/3Pc0
	xbS4aEW6FB2HLuNwZJkbwNMB6uQBxG3zvGQ==
X-Gm-Gg: ASbGnctNeg2F4OkYQWzIjpl5scv6Nq/SytbIYOx70151jBzJ0allehcTBu0SKw+jntL
	6w0HJ0iTi8YgkwSFwDbJpeRVy4qLqVKhmMMPe/g1ax3dpKDHdww+A80Xw2BJiq93vMzVOHjwtY6
	AEOGNU90Ya6Z+S/3wxCmB/uD4SYNbcp+xmVf4PxXth71W3m5dBYtrm1nh0jWWCORcnR0HBowiFg
	YFYAqoRc/2Ldp36lVzlB1CFfG5Pct0j++rUhGiXZw==
X-Google-Smtp-Source: AGHT+IHy3wVrFGQlzn1Mh1f8cD5E2K7aHIgTHNC9jipdxPbEyOIbPtjjSpH4zQJaZOdH6L3XF4/XrWC3x+N8yB8d8jI=
X-Received: by 2002:a17:90b:388b:b0:32e:24cf:e658 with SMTP id
 98e67ed59e1d1-339c2716d84mr15466461a91.3.1759775761031; Mon, 06 Oct 2025
 11:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901171852.2216823-1-vmojzis@redhat.com> <20251003164046.485103-1-vmojzis@redhat.com>
In-Reply-To: <20251003164046.485103-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 14:35:49 -0400
X-Gm-Features: AS18NWByebj2gLAAssb6ZNmODn6Knj15R_-6D-H6Z4XsHyMai19Agdy60AVTiyE
Message-ID: <CAEjxPJ4ZFwO3Zay0XU8g=ZrzvV2HDiDs-OTU02J_zb0fWyQ+Pg@mail.gmail.com>
Subject: Re: [PATCH v2] semanage: Reset active value when deleting boolean customizations
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 12:41=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> Currently, removal of boolean local customizations leaves their current
> (active) value untouched.
>
> After the removal is complete, semanage_bool_query will return the
> default value. But it needs to be called in a separate transaction.
> This makes the fix a bit awkward, but I have not found a way to query
> the default value before the first transation is committed.
>
> Fixes:
>   # getsebool smbd_anon_write
>   smbd_anon_write --> off
>   # semanage boolean -m1 smbd_anon_write
>   # semanage boolean -D
>   # getsebool smbd_anon_write
>   smbd_anon_write --> on
>   # manage boolean -l isemanage boolean --list | grep smbd_anon_write
>   smbd_anon_write                (on   ,  off)  Allow smbd to anon write
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>


> ---
> I only added comments explaining the code and improved the commit
> message (no code changes in v2).
>
>  python/semanage/seobject.py | 43 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 10963e81..6d6188fd 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -2886,7 +2886,15 @@ class booleanRecords(semanageRecords):
>          self.__delete(name)
>          self.commit()
>
> +        # New transaction to reset the boolean to its default value.
> +        # Calling __reset_value in the same transaction as the removal o=
f
> +        # local customizations does nothing
> +        self.begin()
> +        self.__reset_value(name)
> +        self.commit()
> +
>      def deleteall(self):
> +        deleted =3D []
>          (rc, self.blist) =3D semanage_bool_list_local(self.sh)
>          if rc < 0:
>              raise ValueError(_("Could not list booleans"))
> @@ -2895,10 +2903,45 @@ class booleanRecords(semanageRecords):
>
>          for boolean in self.blist:
>              name =3D semanage_bool_get_name(boolean)
> +            deleted.append(name)
>              self.__delete(name)
>
>          self.commit()
>
> +        # New transaction to reset all affected booleans to their defaul=
t values.
> +        # Calling __reset_value in the same transaction as the removal o=
f
> +        # local customizations does nothing
> +        self.begin()
> +
> +        for boolean in deleted:
> +            self.__reset_value(boolean)
> +
> +        self.commit()
> +
> +    # Set active value to default
> +    # Note: this needs to be called in a new transaction after removing =
local customizations
> +    # in order for semanage_bool_query to fetch the default value
> +    # (as opposed to the current one -- set by the local customizations)
> +    def __reset_value(self, name):
> +        name =3D selinux.selinux_boolean_sub(name)
> +
> +        (rc, k) =3D semanage_bool_key_create(self.sh, name)
> +        if rc < 0:
> +            raise ValueError(_("Could not create a key for %s") % name)
> +
> +        (rc, b) =3D semanage_bool_query(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not query boolean %s") % name)
> +
> +        semanage_bool_set_value(b, semanage_bool_get_value(b))
> +
> +        rc =3D semanage_bool_set_active(self.sh, k, b)
> +        if rc < 0:
> +            raise ValueError(_("Could not set active value of boolean %s=
") % name)
> +
> +        semanage_bool_key_free(k)
> +        semanage_bool_free(b)
> +
>      def get_all(self, locallist=3D0):
>          ddict =3D {}
>          if locallist:
> --
> 2.49.0
>
>
