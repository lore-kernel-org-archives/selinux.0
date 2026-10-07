Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4A446C0B
	for <selinux@vger.kernel.org>; Wed,  7 Oct 2026 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791398512; cv=pass; b=kh6K4nOSLjG5p3F/v8Z1OXNrLJuLrmdJi/E3wQiFnB1xrUy0FV6SnButMjxVEaY8JK386lDpN3o6m99+ABuxzNsOZg/a+N4vacueA4KqAaeldZJViO8k5mN2UJlzA0+ZlMP3C7susDerNW0KpVrETwp7AlfNnK8Ste+FhdGEN8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791398512; c=relaxed/simple;
	bh=ONc3gHjLOpR57eDhDQWoXJLL746Q+TlvDaiTk7gS0HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP760ug9Xp2PWbpwhl/pSBz/B7Ij1OvVzsQAcKO+vdP4/oDCXAo0VPgDwqmw/UX2sGFsyP/IDUcwNSva5cqNNlUXaoXRxkkTo5/gfB4xG0HslDPIzLIVpYz49EpyMbJgOMQ1ynPfKEhAT+5HmW8sG9MLInndXRVn4un0Rqinr1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlQqYhmm; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlQqYhmm"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67694513f2fso2340783d50.1
        for <selinux@vger.kernel.org>; Wed, 07 Oct 2026 11:41:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791398510; cv=none;
        d=google.com; s=arc-20260327;
        b=igIYbDIjqhglEmWGHga4kJDrBzu7wQA9MP1R2hUFTKXRTLcmoS15WlCigZb35BJ8qg
         Aei16/sl17VyC23BeGuDSsyeXbAHXs8hlrv7B+LEV1aMAQ3xI7rmd0i0140hj8myDzrC
         zrq1B9Qp/wf+BlwFnh0+zcZ3prxJgTclfQxN1FxKbPv1TZTbQy6M8qU9r0Y06h9yhDQu
         a2ZjZWf2CA4u9vVv1IGCxKy0BMbe1SxFZdtmVsc161BEPxN6VpsSUGvJ7SbOaZNPbqew
         pJYnyukPywajS4CwVlLjn9d98xXhSoCKEyeXiYgQl5l+55Z0L6ZC/0wmK+RWCvYt1kFX
         H3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9UGs4EPfzkif9/8tA15zlNr2yPajZCwlS7+yPshZlHg=;
        fh=70ac3Nu/9NXKnHlYiwlzC0S2l6TozL9UGuJMqFYgbLA=;
        b=MRfMUiihV3NkJGhmTTAevE7jyJCHgBbeLF6vLXt7iElob3YVrw/7IhoiSrHZu/jzSX
         +OSpN2R7AChdXV0kUMdK5ukwErGfJ2lNfv8kT6g2JlonzQmTBgUYL6Ly1Wvv2wt4ExrJ
         pDmPafnZadCecbClGV7RYpyxW/Sqo2n1juxkirI63S+NdbuwgzP/3GfFuyzFCvAY9DQo
         qvOxmxNtAH8z/xfYgZ4JqyZP55f1f1hANR7wUUTEQ29ixff2NeS2Mgg0d4gTqiwStuGC
         Mh/flIu5KuZJu6n3OAWmknaNI/z+aQMlqm6BDyOsN6WuYxBkNYDRfrtTrgVQusuqlLtR
         UCzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791398510; x=1792003310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9UGs4EPfzkif9/8tA15zlNr2yPajZCwlS7+yPshZlHg=;
        b=DlQqYhmm8WDpzp79+mSqpf5WEW+0LmHaP7/LXyNwQ4FMRQsyRkjzeDZnM7IFx3TD1O
         P2o+qU54Nt/LrV9n/i1bOk2dTHW/q9OmxlzxhTpsKiC6wDRcFRiFaU0PDA3tbJAijr4R
         B5CPMO6KOTVtJdK2Idc3HZeyrS2Ilr6LvU5XBSpJ/MQWB0wBKisPx9s9hkWB4jlRVFy7
         G8mdGi/uEccLw8Vh7gNpIChAxpeqjAWK53upunHY/DZoShDK6piqKPIx/wO11w+8YQky
         4mGoAu3BuCJYjzoreDM7PovwW3oIJyo6D/7E4kKCuSGJPUqvcetRq9E+XV+lzStSShj/
         bSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791398510; x=1792003310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9UGs4EPfzkif9/8tA15zlNr2yPajZCwlS7+yPshZlHg=;
        b=P6HHVy+QemDl5wQoEipXu8QDgHulygCxAVCLrHbdrSG7cFTpE289JNFWkXyP3y1f3t
         XWkEJeAQMZUVWMXj4zDn5qHbomOpb6YinoHRj0XYPLMUxTTQ1zbjZ80QqLrVPGYJRVi+
         bzimudzF/G7UpjZmIGW+egJsbeYSCE1ZPO6Lf13wqW73p5GAXCW2Q6CPFznlhOwBjC4A
         1nhPhXFXHyh8w5R3mXvTDhXWF5kt+Opq8oRkmrw2TcpNV5NgohP0n1hAvs/On4Bfp4iQ
         Q5Ogievh5hwdQwGcAZ7fdRdPRNpiDLPxdlUAPPIa6a0U3wdEq8/CNAOlao0PCfust5m7
         tX2Q==
X-Gm-Message-State: AFq9FYKz4pe29uwyojla4GDWATk3Kjzod+plfKYkND7qakV7SPgIt/+Z
	GUvjrBeGKUVG707SAXkco9HCixhsxJ4cSKnlERygru/ftZkfsLC8iDZQiCSaUE1BWEeWUFsDtlh
	17j7D8hD+JvJmcxg9hb8ibTxV8Dc7JtA=
X-Gm-Gg: AYBFou29219HffkPZv91IGpOLnOqUIEMkC10VMashuEe7cE7u2/D/ARJ+ajN1Gyj72P
	4/Ic9JeUl8Q9j5FPufxmVCFxPGVYMYD7hSS/JDxFw7FCm0YDEhMnHOT8R8FUwipFSLojQn+a+Ec
	KwjsPmKQfkUcIShb5/L93kQwnXK1pDRWAvZyY8Wuit6VCxgUaDObTIb5o035Ni6ql4YBK6OgKzZ
	KA2hY7dFur8kuMwhxMDZ4xdxrgJbTjfh14NjrzqbWgOiYx7677Q/XeOpxCoyYwiVrLoInONHigC
	6REiIlHEvFROVtozhDYLx7mqgAr70EQ18RxSGJN0I8XXC5vekFHNbZE=
X-Received: by 2002:a05:690e:458a:20b0:677:d155:1332 with SMTP id
 956f58d0204a3-6790a400b82mr1171079d50.56.1791398509631; Wed, 07 Oct 2026
 11:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006130215.128405-1-jjanasek@redhat.com> <20261006130215.128405-3-jjanasek@redhat.com>
In-Reply-To: <20261006130215.128405-3-jjanasek@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 7 Oct 2026 14:41:38 -0400
X-Gm-Features: AclHuK-QvxyiP0w67RyWqPtlECp__mcQyxwjWSm-RHGGdFDpnjtG1bTRsMG2DZE
Message-ID: <CAEjxPJ69-ce3nHiVkdUABsYKj0LFi83Jd6RDm3QzVgjcsPHMLQ@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 02/17] libsepol: add MLS, category set, and
 common permission iterators
To: jan janasek <jjanasek@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 9:05=E2=80=AFAM jan janasek <jjanasek@redhat.com> wr=
ote:
>
> Add sepol_cat_set_iter for iterating an ebitmap-backed category set
> without exposing struct ebitmap. Add sepol_sens_iter/sepol_cat_iter
> plus sepol_sens_value_to_name()/sepol_cat_value_to_name() for MLS
> sensitivities and categories. Add sepol_common_iter and
> sepol_common_value_to_name() for common permission sets shared across
> classes.
>
> Assisted-by: LLM Cursor
> Signed-off-by: Jan Janasek <jjanasek@redhat.com>
> ---

> diff --git a/libsepol/src/common_perm.c b/libsepol/src/common_perm.c
> new file mode 100644
> index 00000000..edac7eac
> --- /dev/null
> +++ b/libsepol/src/common_perm.c
<snip>
> +int sepol_common_perm_iter_next(sepol_handle_t *handle __attribute__((un=
used)),
> +                               sepol_common_perm_iter_t *iter,
> +                               const char **perm_name)

Adding a value out-parameter would let a caller line it up against bit
positions without a second lookup.
