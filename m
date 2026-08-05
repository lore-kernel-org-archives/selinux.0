Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C78384CE2
	for <selinux@vger.kernel.org>; Wed,  5 Aug 2026 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942248; cv=pass; b=GG3mtp2asDXsLlno/vA5haPFCS1WZIms8549l6voN2CVvbVBzjZD3IXlhr+3I02PX7upgMbqI2Eh7Zp78QZtv6rsw9aQktd/GQZ+W99U6q5fFPozNJb0rd6PP/69G1Xfh3SY5JgdyFg1BBAE71W1fxbKtvbYZMFey4sRRKbGmwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942248; c=relaxed/simple;
	bh=f5h8eXLAMyMusNl/fHvOztLqIu9XnY1jchnYMc6k7X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKzBKBBLV6l0a0Qg31nCcSC6g6GZvJkST/Htftg89oA7zu7ccJCNZen8PMfFdpLIz3QSAGLJPuBRvWLj3R/WbHolgbRA+PXc3T1MiIjjGOsvZc22+h8l1ZKaWh0FftM6azUxH9e7QD2fVbKpc1Q9h7rNy291NZhIwr/YukDrAUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BomDTjyZ; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BomDTjyZ"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6acc2a10023so402311eaf.0
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2026 08:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785942246; cv=none;
        d=google.com; s=arc-20260327;
        b=bku8uhzMPQhn9eOhpLqlJFTE3WMkxW/wl9KyJ9oeP94zp+qdAjd9q2lkuMWaV54YGd
         WF+UxGk0vHbnntaglysVxzsObma4WoR4UoWMFsnOWyBqZC9U0nwbUjyd9ZZov+DtMmQz
         6HVk4CWxBOlQnT+TElvAYpwjU0UamoYRdlY6jmem1QxUwFmV8mtYTuVR4blFTozAbJNM
         TnDa0so/8xLUw7gkpaixR8xu41KgarWqbe2sCRKCEOeCbK1Y6fyPzfzFGR9PPL/baoHW
         U6RCX0qijG+GqPxBuhHoPEDhSoyy2tq5fW9RckWU+qu3suEjERSO+cVK1enVXd1o2Im0
         orJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3uRZIYtFjize2MjlvWBOOzDPLelCbzhpPPH9E3pbYT8=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=n1fVPN0iE3I3O90/V3to5csSBM22OhopnK3Y4H5ICa/DQ1U+z8zGkHkNRwKoe71KdU
         6myoJ62o9tDtydcSlqPIgxnciUGCeNtRZsQSKRLg6UXG/7RsXc7TL0dwAzMscNAEUuBU
         v3HHIeHA0J6nZ7WajW3iFsVb2VJgw25xoK3j7/mqS8DNgXIsUAK3nq+DhPpYya2Svm/n
         oiL8iCmocRH9FFnH2tDJCjwClNpV9Kjy+JVd0sQ2duP9EpiPpqWSgo/iBKnPnBmhccW+
         dZKtsjYLbqHuRlZ5cIdHEBYtwxLXAxq469nEq5i6ucSgB7Ck86xMUUGd9ux/WIQmefIw
         BbZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785942246; x=1786547046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3uRZIYtFjize2MjlvWBOOzDPLelCbzhpPPH9E3pbYT8=;
        b=BomDTjyZIgZDn3+4utwV0tMmHmCoener4LFmZ8VglI6xqxaRgiNe5LiVT6OKT3UH7k
         nkBdo8TbAs9MNSh7YzCUgwmgcxcBanoxglNy0LlJQUAAnMb5zonXPEI5QDgQLyGnmXPz
         LI339kiv+7u6T2Uia41m8I6QeOjnpdMKk7M5eUz6vYFnnx/OKbCtsoKHDfKY89iCPtu2
         RzNjBQ/GzsoPMyUlp6rQPRUrTu27pgltlHdLszZauBXNuv4YjCasJxThKWQ9D0N512Pr
         bUr0qJe/TuF6oxlQepP40yHZhteYgeiq2JUQurQ4JQkIHi8Gt4N2/QDgToH5diQU0MLn
         lC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785942246; x=1786547046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3uRZIYtFjize2MjlvWBOOzDPLelCbzhpPPH9E3pbYT8=;
        b=KliCFFej0no9s0uAbN+3kEmJsJyua0Tu57UEOC5UpQpOoRT6qoft/2DyoHIPKafuN8
         wqYTRQFQEV0vV5qLiwD1xtggUkkgCBEghmunURbVBwneXbC88CjOuCWDRVCfENNTdPf8
         pXV12s8edHCWlBaXMm3XLB7Hx7ekcYcUXsTtdgZ75WGbPt47EQ66Fwr/tpFMj7v7S/FB
         9mT4kNfJ+OK89tEAl+EcoLVn7NY3+8uAluYZbGSLEomyxhhNsi2874Lac+fo47c/iN5G
         1UlHoCjlwFXh8vwwMzKLfUugqrJDFQB94RxjNH1QbPoM5S521v9S85wib71YwEnQGqpb
         v6NQ==
X-Gm-Message-State: AOJu0Yxwb/BIQ28RBBQBxxqws37nZ4vXZK4WEibcBEwLFo68SZDJYwV7
	xp4kU4FmdUCjFo8nNj9pYKWmhUyjZgI6H9BJFcstwd2mGQycqL+7N8uyqHMtvmoj9mxvB2bFBH1
	iaq5oZh+TE0/QzDZYMDltSYEtxcERiXA=
X-Gm-Gg: AR+sD13BBLKqStj9qutqnVmmDQ0tWBp5ZdjJMYfVcvD+jhaATeN0vP/Tf2s+i78iDbU
	itm3oyi6beEjQZXTEOYI8rjP+2iO/rccb045U2zFQShCh0m4U+tGs4GuPm45oaJfp0bqfPosZwK
	PWIP+HS7bLxQM4w1RpGXzEASB/XPV+AjDl3O7zlDzAK8eqG75Vl60ZH9kUaPR9ScLE72sTqsCN7
	eFTZ5dvRgAfnxFm+v7I9HdirVXtnTUmK3FQmirqcNWphGUSAX9zZR0V8/y3cfXsh9Eu85+oQNgu
	CTGl2CmoH1oEeTUtu/mG4qRdv0VVvJwQmi+T/tMkkf/t
X-Received: by 2002:a05:6820:1c9a:b0:6aa:fa5f:ec48 with SMTP id
 006d021491bc7-6ae969339d4mr3830154eaf.0.1785942245582; Wed, 05 Aug 2026
 08:04:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805143609.6756-1-jwcart2@gmail.com>
In-Reply-To: <20260805143609.6756-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 5 Aug 2026 11:03:54 -0400
X-Gm-Features: AUfX_mx8qOW4lXSTdEmEMl0clXk_ZZ8C8_fHZeMlD73RfE_Uy5oHhFUSfMIJuoE
Message-ID: <CAEjxPJ7J6fiFd=xc8YVn1M8s83mLYJundcxpdYWE-QvyROV+Qw@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Validate any levels that appear in a policy
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 10:36=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Policy validation only validates levels for MLS policies, but it
> is easy to create a non-mls policy with levels (just read the
> policy in, change the "mls" field of the policydb to 0, and write
> the policy out). A maliciously crafted non-mls policy could have
> levels that cause an OOB access when processed.
>
> Because of this, validate any levels that appear in any policy,
> even if it is a non-mls policy.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Needs to be reformatted via make format but otherwise,
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
> v2: - Old subject line "libsepol: Non-mls polcies should not have any lev=
els"
>     no longer fits.
>     - Don't differentiate between mls and non-mls policies just validate =
any
>     levels that are in the policy
>
>  libsepol/src/policydb_validate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index fc66a4c7..ea53da86 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -1024,8 +1024,8 @@ static int validate_datum_array_entries(sepol_handl=
e_t *handle,
>                         &margs))
>                 goto bad;
>
> -       if (p->mls && hashtab_map(symtabs[SYM_LEVELS].table,
> -                                 validate_level_datum_wrapper, &margs))
> +       if (hashtab_map(symtabs[SYM_LEVELS].table,
> +                       validate_level_datum_wrapper, &margs))
>                 goto bad;
>
>         if (hashtab_map(symtabs[SYM_CATS].table, validate_datum,
> --
> 2.55.0
>
