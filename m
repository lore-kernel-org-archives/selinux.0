Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89607313547
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790360558; cv=pass; b=X+2MD+RR7ZgnT0fjBBo/tLycsMXfQD4CZ7eoT5D7ycU3V3JQqiV+h80s/P85kb6hMcPxGAz+Pew1DSdsal9YRnijNDNEqYlOzs6AHZDADEQaIRe4OL23ohPklhq/goKUojjAY6BnGvpNqpk3zQtFgKJXLjymti/eHYv33mbmG3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790360558; c=relaxed/simple;
	bh=fuHljySJETyJHsz+HUnRnWOmykRwByCgNmIu1hOceM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9wLpfRIB9ZG+qqGqpMNuYF80BPnGQJ6Tc0F9sW8oFYEfxWpeiE5LsKI7/uudCC1Z5HYGvDNCP8qn2XtslAQvuk9Bl4VDCjzuyipV21VofbiRj4B0ZNt/mIYtlipex0oKAvmQhps0wujAZN/f2wUYlW2gKcwQ0OiVET1WU3xE7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hb7L0LLu; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hb7L0LLu"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8a886df36faso9425507b3.1
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 11:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790360556; cv=none;
        d=google.com; s=arc-20260327;
        b=n5IafOz98GoGnw7MnEugaCefOyH3tHeu83DJzYUsYQEuepI56bTTJxZRfn2BSx/M2a
         kUIZNAoK0SVBYexOpKlTp49CAN31Fghy2XQDgflo/DNJaEysrvv60o+4sMKaCLKRrNop
         DgyBcYJ14EiHC/Q+PTIvB+718Ux1RYWZikC2D4JVZYnJnPV+kE0VKUx67puPaIY0jDyL
         0S6OFn+JmckRIbuceqqRpk4Tg67f07rs8vHcKf2LsBZHp2cZCx0kcpPi//hQCdLkR6kq
         ojPuoXk6yXX04B0qKgt2mwUAYNSMsIBETBu3EUdPyv5yztjugT25hQBwbHwJAplKwzNt
         LBTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O0riM8+QNv7XdSzxDZoRYH4mVDSH8U4+UjVe8M/MEVk=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=Bfv6mpSDM41pSF8FjFu3qQYUbvFr2e6lTXAGU6RkXp0aNc/NskCY0lBvktJD3Py7Lf
         HynIqM4dTkS5nhTl/CYXNRbpCslZMAdPZD0JCGKaC3hDDs1GXEqNBNbWB5pZsdHHPZEe
         On37eX0VxBPRyu8EL6OwxRbRLiVQM9YCfRV7thVi/IrL0vvDa/aCwCzLbsxkqBCBv74v
         wUCwMz/OAKVXHhv0dU+WCCg/xO5VFzOl2XbJvR7TWuigxwuD2l1+2kzepLHgdBOuaywI
         rHwnRHR1KfWR7bMVIPn6g3n/urIooG/th0qQo6S4Yl2xVxjBKi1WEw51jPyP/hHLGRFo
         8DGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790360556; x=1790965356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O0riM8+QNv7XdSzxDZoRYH4mVDSH8U4+UjVe8M/MEVk=;
        b=hb7L0LLuEq4mEZGLquywblogpm8B0VbuSU11xhMeAJbTFv6aqd9Uor5B/g8t7r7U09
         +bA+O34iraWJQYiTDAQ55bayrn4sLH9Rk30oPsK7kAl75UvtzYYEnz8rTPI5TroXpf7X
         ktAHcF349ohxj/t6p+/l6/eKHITpNc71x1nTOhqrCdtZeyJFD5m69jpYn66v2g6+1yw7
         G5rGS2XpmgU4Ts/Vt5cAHmY5uxEWiENTGXpwxZYDGU1NTBvptuc8sj0cEYTqBc5P3jWR
         P+WQn7HsxZNldn6l15wQtOKmzwrxZ6cahJahwcKp8S67cKWcFgGZGYCcduggF3ehWYQr
         xuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790360556; x=1790965356;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0riM8+QNv7XdSzxDZoRYH4mVDSH8U4+UjVe8M/MEVk=;
        b=qcoRt01BYGSFzlSQoLgud96ZFmfPL+aw+CnaPv5/AXgorRhwL7xz7WXds6KflBdD9e
         8WyVshGYCweiqSSoIMlFhjWhw3MnleDKySX/UnMssfusEgkLvX5xyDJWkwwd4ga3eWJk
         Nqr6OzTeEMZg/7E2iGllWSlLafxrrSDP0U0ZKtmG1kWOv9+76CDCAEYWcP16j8ZmF9Nl
         XW2ykgFHIbPC1WL5ecWyelXQgoCp29mjALaocD1jdwFkdjMuqrocXAxl0By7QdcEJ/mS
         2N3B8YeIr+nRH2Z7uTkycI3rc72hLcKBC8I4seLJgPaxwLZd19r4RT22N5nnVFAX1yBT
         +UqQ==
X-Gm-Message-State: AFuF++kg+pzWKRcBhLj/VIDih1vxycMnHmTwn0TQZlaI880opX+jIdFT
	jegshmxvAQVQ8CHpKUIdwK6KnD761X2P41bvCexO3b8pavF+RRHhpXjHfn/0BmZp1nUq50OoBTy
	nYtRBOjAdJRZtcfZLnW5cAVyGPskkFQSYfg==
X-Gm-Gg: AYBFou1JW1ZyljPJVL2b+cdU/8/X0hAkxusd594JX5n48S/EtAqBGPVRsR6kKVjYXWm
	h3tGqXfyi35jbEyucTCsv9v5WMABaHzLzLc63Q3Azl3EVJE2YqGYrMClYpCBIEvTQYp/eEjPzrK
	QQKLL7c7IsNHdWkwUFA37J3epdz+xSFDeM27XBOmUQEF+V3arHobLSHXqMMkF3YhB3X099xBIF2
	wpDpNqJTLnfgvRic2e36yTzUOJFaMCN29qtCrzCqJrbr1SUwCgkpuVV5fnGb1d3Rhu7W1VH2mev
	TyIQ77CS/a1KtR4KtJTB84Xs0T47wR7rr09ngzTyvDhH4xzgmtsEzBk934kgCEl4aw==
X-Received: by 2002:a05:690c:e3c6:b0:887:f4fc:ed49 with SMTP id
 00721157ae682-8a64bb2475dmr37173707b3.50.1790360556513; Fri, 25 Sep 2026
 11:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-6-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-6-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 14:22:25 -0400
X-Gm-Features: AclHuK-cmmQ9-4lJEPiE4lu8HjX3uKYIoXj4D1ZjfIzeZ7fU-MvYhtJ-keS-4-M
Message-ID: <CAEjxPJ7FHTEdcMb2g1i_jcsKr9-zs7KocOJvWBgD9SzqdgfsFQ@mail.gmail.com>
Subject: Re: [PATCH 07/21] Fix typos
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:19=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Found by codespell(1).
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---

> diff --git a/policy/test_mqueue.te b/policy/test_mqueue.te
> index b938a6b..0d6df7a 100644
> --- a/policy/test_mqueue.te
> +++ b/policy/test_mqueue.te
> @@ -18,7 +18,7 @@ testsuite_domain_type(test_mqreadop_t)
>  domain_obj_id_change_exemption(test_mqreadop_t)
>  typeattribute test_mqreadop_t mqopdomain;
>
> -# Domain for process that is allowed to wirte to write posix mqueues
> +# Domain for process that is allowed to write the write posix mqueues

Technically this should be "to write to posix mqueues".
