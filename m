Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75637332629
	for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145326; cv=pass; b=uNiVwDMYLvEF/RjeJcO6rBI+yt9xWc19O+Rl3UDeIPPnOmL7HpLXAN7sdDtHKo4ZCrWoyo9ynnQ3PWmUUT1jkPzjs4mSnGYTfSTvoYWFZ8bvHUjoRE3bG4kJJN/2Js13BN/8v9mMWzgVsw5NTapVlbCZi2pHHfX288ez6hjMs0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145326; c=relaxed/simple;
	bh=chEv920SAIUSWmpUEHydiPva72wWhy/vsGaxeO5dC18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRRGCz/JSV+eyYIlPZWo9JPe9XclOlZeaB8U5NK2ARg7ofKeDE/X878UB+675eQL/VwNL3igj9mBLOdBtKlVdeEjbPQNS6iE0BgKe3EDMXiYvAp1hMbOXTybvXPcA4xsxFR02YwHqode34LAd8iFyAA6hyHD45jtlmeJcpLLVcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJ0bR36P; arc=pass smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJ0bR36P"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b057877851so780445eaf.0
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2026 06:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787145323; cv=none;
        d=google.com; s=arc-20260327;
        b=V/GYwdUWuLNWCefPdKJOkY4ycHtKWg+BIuYynlfz+MFxHu0ItNNZt1s6R7w7t50vA7
         zoVFfJzJGza8t1ashcHQEiq+jA7iLbPAVlL1pks4oYWEc+tHzHdpq/3iE+BF+IcYHPAi
         mWUjIqxi1GLnj1Y55OjEBamQt+t5FuJJAtq5idTZeOemaywtl0ui/BaW0GHovUwGFkF8
         U8gqEdwlV4+grlGcwaK3SXJ+uW8QUG0WskihwtzYIXUpNbn9LB+WveIdSEEZqlCvnSX/
         z5ptyU9kl2TcPOtE5/QkjONScLq0dflOLJUhxnbhi2hS+demTcOhIEWsQFAMRJyqHHbR
         VwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=chEv920SAIUSWmpUEHydiPva72wWhy/vsGaxeO5dC18=;
        fh=KolfM19aEBLsLdlv7CvfZRTH7eSK0t/BZQIdPfHABmU=;
        b=iBarQk5b2QJuuzTC7cBZhK6Z8pmwm937J2+jbl/TQzXMPceRrtbzt0sNqYL5sw2HDG
         sCRkr5wbdt2Da5Z1z/GlBG4wZymfFpmUKo/LQfXCkhXBbHf0UbtaqEMFHojTvvpFyWYC
         Ypzy0XkD3V/3wTCu9jlgXBEC0PuYt2mbEW+JZK+TPUJDQRUJuaHcsOdwO6QUdUlWUOS7
         AcG1qzaD1GWvBPPNFyaLzEK6jFQGj/nc1EF96yWad3gSKGVEKoSXcLLoKBnbqRgy0wXA
         YbKV4rDYM3mTwu8W9hwrmRPAsLgyX2SPzylahcnaad6iVp9nLAVN/qQ67WECS0x68euR
         2DgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787145323; x=1787750123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=chEv920SAIUSWmpUEHydiPva72wWhy/vsGaxeO5dC18=;
        b=rJ0bR36PqlYeATOdQ+oSlj4Zq1ckaFQkehu+exeSeKwBXyoSyVF48vY1AWvGu1y1K8
         mtzpTumJ18xPNHvMIkdCLFnHn1u7FFciPC0qizKWHxD8R0IAsySzMDl7u3pf+7uZ9h6J
         8REFezE6kytdpYrwI93DX9g/NVTAU9t+xiKClqsJri2Ha4cIYoZ3PmjEX8npi68ARalA
         WLQSSIkgruTlVwMBZTYXXKPyP3uDGLZj5sSLLsVALkfvZ8IqerryVmuLFV+sWcSHgYjo
         4sHR14j7enLA7MhjWFiLV9U8cJWupd9gzsEnxFRxR7nfsief3cXc0N3XudxQira2b1+E
         hrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145323; x=1787750123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=chEv920SAIUSWmpUEHydiPva72wWhy/vsGaxeO5dC18=;
        b=XypDYB2dbYWZc9V9A9frMTmwojixHDOr9e2SgefjUXqbcA5dEfsKtaoqlj9Vp79to4
         NxMarxEM5IIl9qxmpxk1EXvHJ8f74C7EP0QYVGNh3rx1dJzXa+gpVYoJobyBzi4yJeY3
         muSbCB5vz336Xqurg0FpTZ+XVSFL1Mnl2f0xsa+c59VAK32lwWE4rhUb3Vgtdg/j1cBK
         BH+8aGP/4j+h3cBPHaey87fxv7fZIOX4EJQvkDk8fL6fe51ntHwlm40eIA64IZUVNhwI
         kEpnTK8FQH+zDmEpAFjW6b6SKK34FHnxncbOADsy64+e+aVswLMIRV7JcgA0rzfwIDty
         eGbA==
X-Gm-Message-State: AOJu0YxudPXgQ3QZGGQ0/BwUFli3se224N0ZJ/FyjunlnDbvrV6aPSHM
	s/34W24TE3x6Kxsl+YlUIWAHiO1cUCg6rtEXIq4OIG4rmHnGwtPs/TK1YQY9hI1cGujyjLkHdx9
	Zn1Fb3aCD4olvcd2kXaB8RsAMFl+rUMF/9Q==
X-Gm-Gg: AR+sD123jV4hFmj5SqVH6Q/cwkxvBGx3k/fQaJwTkwpAS/NWpLmENOdI6sPnvAhRJNF
	6FVVLIN78Yw8/ZDEAV0FYOf7Mtq5W0/Wb+Ycq1OgG44z/nMRlcN5Du33fDyJ+bHhRgraNtmBNYL
	6AwEW8Jlmhupjunln55bgMJ0duuEAqClKwZlP52asefpn4yFEQ7/Y1teGlkSupDxg+5fTc7z3LO
	ODhITBqOAa0hQqpNCNqlCiKC+PpY9u9+huipQeDWCUaS9qgEuMj18DK1YluemSCUUynQTGliLxG
	vkw/KU03aSUVxu3WykK/n5RzFCfShPQOaPh+NF3nvqKQ
X-Received: by 2002:a05:6820:a290:10b0:6a1:363d:bc42 with SMTP id
 006d021491bc7-6b13c3900e1mr3306414eaf.15.1787145322670; Wed, 19 Aug 2026
 06:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG94myvwFz_f2K8SLsfFv1xKDkdm_t6z0s75BLcE5Dn7OV2LBw@mail.gmail.com>
 <CAEjxPJ4DjSrYfDG5V2U8SYk+t_hQXLuytuwP04X-jLd0DMd4og@mail.gmail.com> <CAG94myvBHohDtG4kNdMNYzYOBYAZ9-tcKPpiJb_T7bb1fuE0_Q@mail.gmail.com>
In-Reply-To: <CAG94myvBHohDtG4kNdMNYzYOBYAZ9-tcKPpiJb_T7bb1fuE0_Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Aug 2026 09:15:11 -0400
X-Gm-Features: AcwNN1Vkv9f4yIhQCr8OkI3mrKWnYK2bHoK51Y7b4Ln1brXZnuycHTfvjNxonnM
Message-ID: <CAEjxPJ5bCF=PgwBsaiv96M5=5GnoMZc7s3u=kU9xsXY+MEN6eQ@mail.gmail.com>
Subject: Re: [RFC/Discussion] eBPF-based runtime permission auditing tool for
 SELinux policies
To: rushikesh ghatpande <rushikesh.ghatpande@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:52=E2=80=AFPM rushikesh ghatpande
<rushikesh.ghatpande@gmail.com> wrote:
>
> Hi Stephen,
>
> Thank you for taking a look, and for the context on the
> auditallow/Android precedent. It is a helpful confirmation that the
> runtime-observation angle is worth pursuing via a different mechanism.
>
> It would be an honor to have this considered for the SELinuxProject
> GitHub. I'd also like to be an active contributor to the SELinux space
> more broadly, not just with this one tool. I see this as a starting
> point.
>
> On coupling: the eBPF side hooks avc_has_perm(), plus a few more
> targeted LSM hooks (selinux_file_open, selinux_mmap_file,
> selinux_inode_getattr). This is done via BCC. There's no dependency on
> libselinux, libsepol, or policycoreutils here.
>
> On the policy side, it currently shells out to sesearch (setools) to
> extract allow rules for a given context. So there is a dependency on
> setools, but not on the core userspace tree itself.
>
> Given that, I'd lean toward a standalone repo for now. It sits next to
> the existing tree, not inside it. I'm open to your view on where the
> right boundary is.
>
> I'm happy to keep improving it based on feedback. If there's anything
> specific you'd like me to change or look at, let me know.

Just for future reference - for public mailing lists the convention is
to post your reply after the
message to which you are responding (interleaving your responses with snipp=
ets
to which you replying and pruning any part of the previous message
that isn't relevant to
your reply). Not a big deal for this thread so far but helps ensure
that people can read comments
in context and avoid wasting space for the complete previous email
since it is already in the
archive.

Sounds like keeping it as a separate repo is the right move and we can
see whether other
developers and users find it to be helpful for their workflows. If so,
happy to consider it for
SELinuxProject in the future. Thanks again for sharing it.
