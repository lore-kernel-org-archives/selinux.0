Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348241C71
	for <selinux@vger.kernel.org>; Wed, 15 Apr 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275170; cv=pass; b=tQOt2VVf5mWxqjAslyHQD3nu+05zJDypY529zOV3yVbevzvipCyAtJxm4Pd/6+s7zJ+SH0zEu8Br7fF+mEMuog/lGR+uAPde5bXzTXjsEM3baSj/P1Ihdh/YyWyoRseK0Gtfc4en9RNsHiQn9TbWHQDg6Ivz0cUhcbm3q0ShgAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275170; c=relaxed/simple;
	bh=fD5B4rp5IBJXFRzcskVlekSMStYW7E+RxP3DQaraeyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyENp01C+DT2LERq7SzB+1mIT4l+J0dgMFyH55xCkhE0mZi8sl/lLuj13wEpC6NkFRAZFMxNYH0VfVkgr30qq8CfUUg/WtV2WOp0yrd29ZyV+yxEUQAEztUtcnMsYEUKSfeH+5IuHZtscseICrgx0aF2siVv3d6D0onsYPND7oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoqmvhA7; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoqmvhA7"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38e936caafeso22393541fa.2
        for <selinux@vger.kernel.org>; Wed, 15 Apr 2026 10:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776275167; cv=none;
        d=google.com; s=arc-20240605;
        b=fqt8kgikPe6RpGRjlLxdXp0RtQGM7bz40w3tIFjYlGEm3NfnAKtkHCA4qeAuNda7d/
         AeXee4ZxNjpgQa4eh3qbg8AvJrSxhsS3y+aX9R+u4+YwWJS/SJ2aAQbMxI4+5mLgI1To
         mKCMfYRzFy4AHGkhQiJVljdQDQO6upfvLq+P7DTUtvAuv7KyEs297p9z3APhBspDO1pJ
         iNxzez7huY1mrYg5D3n5f/nc4dvHLfpUdBK2Va5FaU4KdiYwaYtoQ1xOVOVDMP9dIjHi
         J3uDpRb7HNOC+CI9MIOnGhnBXyoEihX5XPoRTkG4p71xUK33ja50TnBVWDp4ZkE0W6dx
         r0pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W/PTcpR2o8684dbDz/sUSXQjfT4Fj7jE8dA4SoJPggc=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=Sw1ClWlLEIZjiXeJWJliF2KfkT1MbWtOt+eBALF+wp8Urh9UfLof/gSGDOwTBQb5u6
         Tp2FH3NnyiBcKOd7BbvNsfnCuQBev6dQgoUkBthaXn9zOb10bzJB/q37sp+2JTzchgTG
         /imqnrAml7iP7Pq3TWgEWRpuVcmMBmM7bmXoz5i/+rZB32K/bCFI39VQvwEeUXhQqqOa
         C5UR6GUYYv48nVeubr8Q3uBgAXDzEtCyxHUO4+Q8UZoysPUXhGf5eJOVGooo1itieGbl
         vb+ZnpcAPwh6iOaSUzbDAM8jmYTM3v/78B548g6A/6mWufZBwtHGmVnFrd47eA6awZtp
         1JTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776275167; x=1776879967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/PTcpR2o8684dbDz/sUSXQjfT4Fj7jE8dA4SoJPggc=;
        b=MoqmvhA70oH1niHZI8ClFu5MpbjzuX3Gs630spXH7oYrXq+6KFj/5a39R7Gv36l6pt
         PDPiHWk+jP8BKB9cGPewuzUHdO/BO7K4XDSIGxeNlxVs0r1pi6CR0V/ntK/6dxfxogI1
         EIvko0X0NFHHVJR5T/qOZ+I5ED6u+CIxYEYrM/yFV4+uyA/AYCIDvqVjtz+N4eNMa/H0
         2OM4RUeUVv+xNcvwxntITIy2fUfZ/isawDCGJLjQ+vMDslv4JRqWceg1azbdu9mx6Kdi
         HmeMZuEY1ft8qSHN4fNEEPLD2IoLuqi2RIBHx22PrYJoqM5YH4YkmjaRXupCcFR12SK7
         lchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776275167; x=1776879967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W/PTcpR2o8684dbDz/sUSXQjfT4Fj7jE8dA4SoJPggc=;
        b=WgGX7768xIbtJSlbJS+jgH1Ba3HeI2cic7ZDeZRau4/efFxB+NGciqTvO3Ib0k9qXH
         1/4lgjJNwhYT4dN4MK/9E1TQa6f0zMTKXUjNkarw3LZMFphQN4w3tZXTBtBtjeYLe4cw
         5tUI0u2THxhalIV8jtpsWymrUFnJ0N3gmM4V87dd86KpSgN7g3xLW35dJT3C50iHJjjW
         VcZGiAggJZRYHFjvANYJh/Ca6kZTyZJQPhu0+JoK1d4qT5PWPICeMO+79dRLnw+71fkl
         C31WR50rz9aWNRimQtVLpjyOBRkXBj6XgFody2IA563pqvl62050CrvK7WyVH+fxKrn8
         z3Hg==
X-Gm-Message-State: AOJu0YwfP5Q7ZmRHwiW3DnNXcw/eT0Q6ChJp4qcZFmY8XyjX/gPB58JD
	cb+E4tEAk43LkxShiQ8tHdrfUcQUXoMYptXq3BMAvFqTJtLeObTWXY2GTG+nCVxO330tZVnFNmQ
	/QfcjgWRdbxWvCPW3WS9DprCFwN+Rtdw=
X-Gm-Gg: AeBDieveDAQ18i3mOQtexGi8zwfNVe9Grq5HyFAetRT3L87GNUihC6j9oLk9uAZvGtu
	JSZ9zKNpbSaCSn+SToOF3g/v1PVurRzASKcv12KKcSh+oMf0YBGUUCuXvBj9OC3jVng5JSi6xxd
	osv9U1eyDZET0vB/xy2YYSFWdFQNdjCMsWI8q0GlVOoCCJ+ROOEpbwBnHBGOYhh5KVSHzJfAHYX
	5kvLBFjO7SZen+JN4kUwSUIHjqOYcVYmRxGOVJGEgv34zyUKzZyxbVXyF2CG8Cqd86kyrjDRYVT
	4aDb
X-Received: by 2002:a2e:88c6:0:b0:38e:8a6a:ac6e with SMTP id
 38308e7fff4ca-38e8a6ab037mr23183561fa.32.1776275166920; Wed, 15 Apr 2026
 10:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216194829.3372622-1-vmojzis@redhat.com>
In-Reply-To: <20260216194829.3372622-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 15 Apr 2026 13:45:54 -0400
X-Gm-Features: AQROBzD_blWg5Cms2-IcLbS4TEug0vCA8ev7Zau22zwjPN2XB44OKgkU8PZZJJI
Message-ID: <CAP+JOzRs-+oW0jXiEGpPz4qg=mDix_9=tXBMMmkJ9P=wPyA16w@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: Fix translation for uncached entries
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 2:48=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> trans_context:
> In case the raw context is not found in cache (find_in_hashtable returns
> NULL) and the context does not contain a dash (dashp =3D=3D NULL),
> compute_trans_from_raw gets executed, but the translation (trans) gets
> freed immediately after caching, at the end of the "for" loop.
>
> untrans_context:
> Same as trans_context, if the translation is not cached and "range" does
> not contain a dash, compute_raw_from_trans is called, but the
> translation (raw) gets freed right after the reverse translation is
> computed and cached.
>
> Also, fix the README for "nato" example and add README for "pipes"
> example of setrans configuration.
>
> Fixes:
>   Pipes/NATO examples from /usr/share/mcstrans/examples
>
>   $ /usr/share/mcstrans/util/mlstrans-test pipes.test
> untrans: 'a:b:c:Restricted Handle Via Iron Pipes Only' -> 'a:b:c:Restrict=
ed Handle Via Iron Pipes Only' !=3D 'a:b:c:s2:c102,c200.c511' FAILED
> untrans: 'a:b:c:Restricted Handle Via Copper Pipes Only' -> 'a:b:c:Restri=
cted Handle Via Copper Pipes Only' !=3D 'a:b:c:s2:c103,c200.c511' FAILED
> untrans: 'a:b:c:Restricted Handle Via Plastic Pipes Only' -> 'a:b:c:Restr=
icted Handle Via Plastic Pipes Only' !=3D 'a:b:c:s2:c101,c200.c511' FAILED
> untrans: 'a:b:c:Restricted Handle Via Galvanized Pipes Only' -> 'a:b:c:Re=
stricted Handle Via Galvanized Pipes Only' !=3D 'a:b:c:s2:c104,c200.c511' F=
AILED
> untrans: 'a:b:c:Restricted Handle Via Plastic,Iron,Copper Pipes Only' -> =
'a:b:c:Restricted Handle Via Plastic,Iron,Copper Pipes Only' !=3D 'a:b:c:s2=
:c101.c103,c200.c511' FAILED
> untrans: 'a:b:c:Restricted Handle Via Iron,Plastic,Copper Pipes Only' -> =
'a:b:c:Restricted Handle Via Iron,Plastic,Copper Pipes Only' !=3D 'a:b:c:s2=
:c101.c103,c200.c511' FAILED
> mlstrans-test done with 6 errors
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>
> While working on this patch, I also noticed that s0 is treated
> differently in the mcstrans code (as also noted by [1] and [2]).
> Could anyone help shed some light on the reason for this?
>
> Thank you.
>
> [1] - https://github.com/SELinuxProject/selinux/issues/191#issuecomment-5=
66124541
> [2] - https://lore.kernel.org/selinux/0f7263c2-b16e-2979-cc55-9454a402b6a=
4@gmail.com/
>
>  mcstrans/share/examples/nato/README  |  8 +++-----
>  mcstrans/share/examples/pipes/README | 10 ++++++++++
>  mcstrans/src/mcstrans.c              |  5 ++++-
>  3 files changed, 17 insertions(+), 6 deletions(-)
>  create mode 100644 mcstrans/share/examples/pipes/README
>
> diff --git a/mcstrans/share/examples/nato/README b/mcstrans/share/example=
s/nato/README
> index b8b30bf7..7d75e0d6 100644
> --- a/mcstrans/share/examples/nato/README
> +++ b/mcstrans/share/examples/nato/README
> @@ -1,12 +1,10 @@
>  NATO example test setrans.conf
>
>  To use:
> -mkdir /etc/selinux/mls/mcstrand.d
> -cp rel.conf /etc/selinux/mls/mcstrand.d
> -cp eyes-only.conf /etc/selinux/mls/mcstrand.d
> -cp constraints.conf /etc/selinux/mls/mcstrand.d
> +rm -f /etc/selinux/mls/setrans.d/*
> +cp setrans.d/*  /etc/selinux/mls/setrans.d
>  cp setrans.conf /etc/selinux/mls/setrans.conf
> -sudo run_init /etc/init.d/mcstrans restart
> +run_init /etc/init.d/mcstrans restart
>
>  To test:
>  /usr/share/mcstrans/util/mlstrans-test nato.test
> diff --git a/mcstrans/share/examples/pipes/README b/mcstrans/share/exampl=
es/pipes/README
> new file mode 100644
> index 00000000..3963d300
> --- /dev/null
> +++ b/mcstrans/share/examples/pipes/README
> @@ -0,0 +1,10 @@
> +PIPES example test setrans.conf
> +
> +To use:
> +rm -f /etc/selinux/mls/setrans.d/*
> +cp setrans.d/*  /etc/selinux/mls/setrans.d
> +cp setrans.conf /etc/selinux/mls/setrans.conf
> +run_init /etc/init.d/mcstrans restart
> +
> +To test:
> +/usr/share/mcstrans/util/mlstrans-test pipes.test
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index f18f9da9..5ef6a0b9 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -1578,12 +1578,14 @@ trans_context(const char *incon, char **rcon) {
>                         urange =3D dashp+1;
>                 } else {
>                         trans =3D compute_trans_from_raw(range, domain);
> -                       if (trans)
> +                       if (trans) {
>                                 if (add_cache(domain, range, trans) < 0) =
{
>                                         free(trans);
>                                         free(range);
>                                         return -1;
>                                 }
> +                               break;
> +                       }
>                 }
>
>                 if (lrange && urange) {
> @@ -1728,6 +1730,7 @@ untrans_context(const char *incon, char **rcon) {
>                                         free(raw);
>                                         return -1;
>                                 }
> +                               break;
>                         } else {
>                                 log_debug("untrans_context unable to comp=
ute raw context %s\n", range);
>                         }
> --
> 2.52.0
>
>
