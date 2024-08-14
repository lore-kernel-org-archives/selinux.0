Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B04AD49
	for <selinux@vger.kernel.org>; Wed, 14 Aug 2024 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723597325; cv=none; b=Pv3HpoWkrsl/G59rXyZUSlpENKWUdLbToL1jv3QLIzeSORkqJpKRJlpVxjB6MEAfpV2OTxkX8PbMmcg+GONLXKXkhLWeA6k/EmRZjWplWKt2FSWHBb7i9VT0wsnHV9GosokxMRtW0SvxnoaSo6ZFKMAoOKIFsj8S9KaDkNKzMNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723597325; c=relaxed/simple;
	bh=lNRxL/uzscaqpOEdHPs/dQDvuUdtdomeKUbjq4Pj6VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1UNnyxvdoRcYTTAGpuK9wCsBlbmVQsiy4Dn+jqcxvZyeiK8XcmJ406LOto2q0mL0ec+xWzu82Wr+YmR5oMKlx/MFZdc4+d6CglyuYETupxVUBTJfKiCoqveqzTHmwQcuP4kwsojCqrgosnYDmUGERgcO5jNU+jQfr3ZSPLXC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bFftGnAJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bFftGnAJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-699ac6dbf24so58944247b3.3
        for <selinux@vger.kernel.org>; Tue, 13 Aug 2024 18:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723597323; x=1724202123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMO45PFz+zKR5A/hZBuCvHlwTmOw9PKBPqZWHlK+R5E=;
        b=bFftGnAJcln7G8VQGpIif6XusPWpIi+otMJ9lv+7s4+ytZgEgS9k8OR4KftsF04U1Q
         xER80lUzqNPti3TYSX/neF+2IJnqE3y9tMxlQSavOZ8RfzukK8onHLdCebntLWqaoRj9
         oKnKGnSFFJse8RB0OEHqnkYFYlAWg1AqSmlKLNUQshRXYyInjeYe9cVELxmpf5OYvlMU
         3Xm/uEV3PMsVl22KaZPayPv/lZrFSi+lVEI50CyEEhUdesHC6wm96fHfSGAWZ/eRU/6L
         pDyc/Oe7Z89Jd2VogZn4YxzlHrp360w+I+7MFx3/fPHGal/l9CHVeyWkgu3o+lpc6bVd
         CTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723597323; x=1724202123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMO45PFz+zKR5A/hZBuCvHlwTmOw9PKBPqZWHlK+R5E=;
        b=kMl+FzoAVrknrAV3q8SwOkj5rAcR0wOEBhbAxwiVK4Tu5CTxPp5Vbv85Fmc/UZnF1p
         jRe0hv90TqrZPP87tCN10FX1NW6m/kohZXrRfS6Xu1mUGLCZemir6hhB06TE8y7bAZ/c
         SMi24fPpO5TQuR+wYVvf9HOs+cus6GhOP6xoPPqfn8ks6WaoStGyd3Jcp0dJbPjrkIvD
         w6tKM3MXUD3bQWF3SK3bA6Ytu8rIqLUCGoiOWRObCGS++2BP7t/epXYgrOvowuQ7wmGx
         1VsRiA5htuU4NUz7fPQBfe+2MkwIOlYE2tCkPmm67Ky3I8rgheKtEkcPtA76HKSfxOb5
         V96g==
X-Forwarded-Encrypted: i=1; AJvYcCVGsyrcAu7LYXE+33XC7ndYXHsADCCF4ehn4uywUibeH35lQpMRL8eycuHCDrgmL8N6PefVRm9YQWByIbN7ktSmykLycZD3pg==
X-Gm-Message-State: AOJu0YzVfGIIWM4Ko/11zPbRneoAhmuPgiAUzQn5N5dldvcDCqsQUFTb
	yhNZbeFr4b5Rr6X4zWRzgbWRZ2vNLHKupYd8JEDHzKa6b+A0k0zLq/uGfh1jlf6eS8t5j5VbF8a
	//Y5aVEmLJIjX8AXbDd3xwcSwF31WUZZeXxbf
X-Google-Smtp-Source: AGHT+IHwM3sGLTDNVAEpZM10Lcl1VDzGf6oeNTNi+l7oJTUY/2mllk+L1mRoVZ/ncBfWsiJsl2dH/zhp1SMBtDZk5NM=
X-Received: by 2002:a05:690c:3148:b0:64a:5443:7cba with SMTP id
 00721157ae682-6ac9ae13b53mr11172297b3.31.1723597322894; Tue, 13 Aug 2024
 18:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813230140.3575291-1-samasth.norway.ananda@oracle.com>
In-Reply-To: <20240813230140.3575291-1-samasth.norway.ananda@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Aug 2024 21:01:52 -0400
Message-ID: <CAHC9VhT6KgL8AVJgLP02gYUGNaj=oK3vbowwTYXnrpBer0pxLw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix Null pointer deference at sidtab_convert_hashtable()
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:01=E2=80=AFPM Samasth Norway Ananda
<samasth.norway.ananda@oracle.com> wrote:
>
> Handle the case where SID (Security Identifier) being looked up was
> not found in the SID-to-Domain mapping table.
>
> Fixes: 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
> This error was found through static analysis tool and has only been
> compile tested.
> ---
>  security/selinux/ss/sidtab.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index c8848cbba81f..b1fbdeaa8817 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -367,6 +367,8 @@ static void sidtab_convert_hashtable(struct sidtab *s=
, u32 count)
>
>         for (i =3D 0; i < count; i++) {
>                 entry =3D sidtab_do_lookup(s, i, 0);
> +               if (!entry)
> +                       continue;
>                 entry->sid =3D index_to_sid(i);
>                 entry->hash =3D context_compute_hash(&entry->context);

The number of entries in a sidtab should never decrease, only increase
as new labels/contexts are put to use in the system.  With that in
mind, and looking at the only caller to sidtab_convert_hashtable(),
sidtab_convert(), we see that sidtab_convert_hashtable() will always
be called with a @count parameter that never larger than the size of
the hashtable (although it could be smaller).

--=20
paul-moore.com
