Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E39447A0A1
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713730; cv=pass; b=rq/c6J23e0s24d4iq2f5Eef6W5CzulzcP2lLCVHpf+OnV2MzJGIobXzIM8yqxFZcOaVd60YP2z+dkma6y4fXkntaCGBrfOapVmrs8mFFwbniZ67cTN6DzcRM9Tvfp4KFBvltNr+xiwMchd5X1XOh3FmFPctTtziLZcFOA53w42M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713730; c=relaxed/simple;
	bh=qlmPQHFvAjaTQ661HjB8OsVgd5U3Dmt/CSROVmmijRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESVkTJWR+CJUABxh6gtMLKFP3Es9E6Q82DsyR968uXAdaVHeuIAC/ayE2nS9j6iX57yZ+s8XeHIQnM+5e+d6WSDJPalvNppOOZuHphR3SU/BV2A0Heyj5MyESQIzPIsKd1ZGGkrphciaUCkeUlcPOJ1edCBFIVJJVifJQ1btk1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrOZcVJn; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrOZcVJn"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b9033d230so762129a91.1
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 09:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781713724; cv=none;
        d=google.com; s=arc-20240605;
        b=dSzh8zdtpa9ROUYqJbTH53lMFPL53kd99c4xpviHA+bw4p/cVN0A12mLBlsw6vE0Ly
         VTB8vC9JffJqq2bjQJ3j6b/3cQ04CqVwvfi1lukubomjrUQ+XgYug+P54HeBElP19zB+
         b1k+rQzzoQyOZqxWEAmzxDBPKpirJYbJOnWiPhG9SLZDHh1GPLnjLAph4aelcb2q+040
         kw25sMQYLNgeFIAmaRKCoWaiQw3MRiAollB/ixN1quEq+uKXvZE5GuPWBZW+vxIp7pVr
         yzZr2x8DT5VhD/cQN2YoK0aUASln2m5CygUXQucYPQV1hv5CDCQk6yYPMHeaUPO0SuNZ
         onuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CtlTHXjNnx+SLBITpVARdMgKLJLTRuW3CBbIaDDctio=;
        fh=+ymDRLpvH5V4NxzbU6EHTgZVOx8LXRvHxwaIgjsFoxU=;
        b=U7iCygtydx1Op4zCiiAS/u/YBSteuglZ/4iSUrmd4hY2T9vRGJv8UvNSiR+paVIEv1
         CyksuK7fz+xD5kWaOu9Fkr4pUH6EcySai8vztcttV9k+hTUT13+c0Ff1xTfJ+MUIJFNy
         XB4klJqc9RGs4LkUSBmXFjRrDRE0ZaWkyPnb4+P/wf9n3eU77FwmVIfW3IyGhgESRjeT
         tdFVXLWanbpzczgKcTG7w+vr0kSQLxU3cFlMdQqlOm9F/KtawBa+jsp/vx/EWW2BSCMq
         U6oadMceOmdESaMwt9AdwguFVLUSrjXuHNeAcMkuJYJIjob3Gr4tYKZHOpQZcuuaLTtE
         NlLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781713724; x=1782318524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtlTHXjNnx+SLBITpVARdMgKLJLTRuW3CBbIaDDctio=;
        b=SrOZcVJnzg9oIAC0fgEnyf/WLKKgu5iwgAqv6jOsQMV7m5MM10I0LiyuDGKRHA2RSp
         smVD8MfUPvUPDd781xOoL6SD5PrAU1D/EqS89EpOZjjY/uLOqyMTS5v5Jz6wuxypL5Yi
         Iw0vVBeFvnbs6yu0irasDjqKn0wjzmC45pKXBVNQHngR1jw8PNl01XLSpsLTvRZNLkTa
         /E2l6t7Ts+sCwi5bn9J/atSP/qkEmDCwDgRDEsRUYp9ULIQXnBVRESFYDTVGeJcy/N+s
         YcbAiEUhidMYftjUl8RwTykB4jdLKVvnyuTVl0jqkgDaj+VEY4LCN53a1Dffz4GuRXMQ
         g0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781713724; x=1782318524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CtlTHXjNnx+SLBITpVARdMgKLJLTRuW3CBbIaDDctio=;
        b=k39X9ob9/iSC7MhnkKJsZT8qrHLZZjk13i6mW59idvb9yX5JOfpQadgKVjhMOKuAsd
         5hU1+KE6yUD1YoZvcumhcnhiOHIlmWndHKKJJgfCI2ecemuM8VvB6wpi2b3eHShlS95d
         x5WkVR6wTfXMQbkbvPa2T1CXaeoDNN3am3peF9xA+jes0jfRwVn6mN3L2GGiJltn2TZS
         BdnpUCLw6uQIzt/fZfngYQsxUqpDaC9B8cQH10L7+3071WgjCyZYGsPk8cxvKw9PCaoU
         BpX8xHK6vdJp1uSlZMsvkiByXCN23c7sTX7jmrv9TAl1d4xBZT+wwhp/sC3f6nnr3RcT
         /btg==
X-Gm-Message-State: AOJu0Yx/6hxO5vIc+ILbLLVWH1f3X9L2Q+j9xlD8GHMGKsF44gstojK0
	wcliKfoum0CGr510m7wkxMqpEygYGACXQg6pLDADQ7opYevjOXmIHgmeghWW+v6/dH1XjdE+Awi
	aM2AGL/yVyHptmVf+nQoBzDKcGojv/xzlfQ==
X-Gm-Gg: AfdE7cmqOFHpeJVbQH/Dur0Nlre0TsEo+3aOC0Vn5NGK2Xft+6ZZTZzFaMGct0v1LN3
	kOvJMXWfTUG9Z1kCKGb+LcBVXpS+EOy6yE5Hb3RAdKSy3aY5H6ZIO7wuptJk9Xeqbd/PvgHidjC
	Cj8aaeYN2jMDm0bZD6IBRM+aTZfnPJMInl9beaq1btTqfI675Vrkirb7aEIYJuYAj0YZwdIhye9
	FNUd3WnIpXM4Xu/R8XW57YGZ4E75vdMBuRBe8HDKxTx39u6yL+OkuwD174jQ2i7AFw74aXT
X-Received: by 2002:a17:90b:1fc6:b0:368:864:62ad with SMTP id
 98e67ed59e1d1-37cdbc88e57mr172428a91.3.1781713724364; Wed, 17 Jun 2026
 09:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617154214.67285-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260617154214.67285-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 12:28:32 -0400
X-Gm-Features: AVVi8CdCqmMhSSDlFQ11bQexlr3LPOVBh1XVxN7pSXomf3G6E5J-JFfvBfF9oSM
Message-ID: <CAEjxPJ6fjdMyOmENtA+bEiw=JoMr259LUkwBErezbV0Ht_0BkQ@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: guard end of path in semanage_fc_find_meta
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 11:42=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: netliomax25-code <netliomax25@gmail.com>
>
> semanage_fc_find_meta() skips the character after a backslash with c++
> but does not check whether that lands on the terminating NUL. A
> file_contexts regex token ending in a single backslash advances past the
> NUL on the next loop iteration and reads one byte past the strndup
> buffer. Return when the skip reaches the end of the string, matching the
> guard already used in cil_post.c.
>
> Fixes: https://github.com/SELinuxProject/selinux/pull/529
> Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsemanage/src/semanage_store.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_=
store.c
> index 0134aaa3..f14ebe97 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -2530,6 +2530,8 @@ static void semanage_fc_find_meta(semanage_file_con=
text_node_t *fc_node)
>                         /* If an escape character is found,
>                          *  skip the next character. */
>                         c++;
> +                       if (fc_node->path[c] =3D=3D '\0')
> +                               return;
>                         escape_chars++;
>                         break;
>                 }
> --
> 2.54.0
>
