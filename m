Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98720342523
	for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782152211; cv=pass; b=lMAg8VJlqK7wMMHNdDiAlMKGAF3T5ChdBOXyzrz/p5Imz+ZcFIGlTlg6dlUyQS5YN2eDl95DJOgYh4NoCyOt7VH0d9D4WgzhxYW8Ctk6QKbvs/w8AErcwlb0hz8Bo8KYRy4XY4+22lYGLWthK8wgEym3yWV/rdG/bjcOJ2Ao7AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782152211; c=relaxed/simple;
	bh=QeZKDgWTAl9YOWzBZnzv8ONgNeWw7AYGPPJ12r8oaZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsCbnG+QDVbmbK43RU9vRfsEhBY405x1mWyAP6bC2nppL+obq9ixBcFV1FhsdTVqnoJslMYQc3WZtS2rJlRXHa1lrriZvq1tw8rYvTnwSr00kZdrQTXn4J+k4sMBaxoKXU8A2fh+n1gG9np5niHzY9XOv0NZ/Te7q6WSvb8Z2kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2CibqDx; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2CibqDx"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8454c5a280aso95171b3a.1
        for <selinux@vger.kernel.org>; Mon, 22 Jun 2026 11:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782152210; cv=none;
        d=google.com; s=arc-20240605;
        b=K6px1U+DrXI8u/3cvTS9JAa/O0H1HF/UUPpJjTadyes2VG2+t9cvIKjlOemr7FftuO
         aAV6GebfpUfpxPxNRevhT6ghngF70d1DfpztFv4YJ724+SAWhk/SL74eZlA1VBUh3Gp2
         plPy32ZB+KHIMiotfWwZQ96AClDSh7GTQTOc7by6wHi7myUZ6q0g3F7rlYD5mFjdYXsj
         2fXoJgyYIAw02TOs8SavoDFpPeS5p5bbBaAfyUYj4GAjCA+A2tcgqwLAwMLMNojTa7VR
         yl8JjObuIlMKKPNG1QPk3wM0uxfmWR5SFFfUIuWWu5oHXTsWe107V6P11Ta9x/wLH20F
         0N7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y2C1p0VCPDkoHSVv3TUflFLqFfDODjEpQopGfPntxH8=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=PehYvCBtNzMQa4+Wvy/B3Di8vGi9i1hxCPRpP/S+cfS72f3ARZ1tdrGZBekyBRHke4
         Ck2nX8+K00WlC/BpPLyC1HljL5HSnHeXXXNOvPEdPev9wYfeV12S2VnwFfo4CcRhNIu8
         RPIZtITQipkoBPmRzbStF4GMukZTJu2idXM55pfXZtOz52I9kK+ckUQ0vb/fNOt5cUyf
         cTPBdSlkJVCt6q7jJJPQDPoe737YuoUDteje+CVBVK6pJ2TfL/cDSMwObm/+TepvNr3d
         deqRioA2w149CfquAMHGO3jhBSiVhFKneKbJsjQt4kaV6ckCY8WppG1471435XIM1j53
         eFSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782152210; x=1782757010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2C1p0VCPDkoHSVv3TUflFLqFfDODjEpQopGfPntxH8=;
        b=E2CibqDxzr0mQUhQf1mplbvKGB26qvnDGl1xZ/ez9YPEk/UucV8/KuAFBJr9f7IuPw
         5Na9Xpt2GbQ1+fIuhU9UiegA5CJuP7liAJrvwQDJcWK8/t0WAmeIvUGVxLIErWGNSAkO
         d+owhcuFE1zQgBuAWXk8WHxVbz3w/38/qgDwJl623tMC6E5s7u2BwJnXON5yg4/WJJZB
         GJ6qmrpnzlT/Zm37CBLZowwW62PMvmF6E7nJCbbCg+r/YloBtGN77pWj4gEkNAHPnOzM
         Whlmq3HIOrwuXy2ndCJEeQpWd91xmrAkQ+HW3BZsqbVK2YVQhlcjuRikgwrrubnbmEts
         nYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782152210; x=1782757010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y2C1p0VCPDkoHSVv3TUflFLqFfDODjEpQopGfPntxH8=;
        b=SPbCZelNgSgeGCFtCNyHVvt3eX3/4dQrLV7kF7krUfqH1+DHD7xtVEs4g2E7t7YqvQ
         nMP4P6rWIV5CP/AJymBvlEHBKyD9gM2NEWGNB903uykfmS7WPhFfx6RwOa5s1unyjWPm
         TP+C6ZigCO6sgAdvmDpcFu8AT0TB2mQVpcr2I2YJtr0vguTPED1wY//Kp7bbJ4rFO2Tl
         kYYV3IUq1SRxhq2he0LRSJTYoxsjTSh8CF8gI1ALzB9PRCcfakIqACsDkRqjAILZ5mCC
         hbj3t+sTAmpl5iqv6Njfm+GqTgTnPNo+XVkDQ50O8VF7j6u+fNKk5Fm5Fk+J6Z/Ezmvd
         SDEQ==
X-Gm-Message-State: AOJu0YzRiMl3yFEK3l0Yy8b5InZIb+xRzCXJbeluyMQdAuXh2v96fF3F
	JXostPxQ6ASjtfPRiRDfQeVISv3F5c6i+tWPc10loZaHH0Kf73mEB7iZNIgCmJWtzCZ29AglOex
	D87UP5Pt3rkKrP1l72txBRuLhTpzsdTm5wA==
X-Gm-Gg: AfdE7cm5Tvxy9RMJuY82V5L9Wy94RXBZk9nBjc+QRRVXbukgILbxGuABC9cViMbXFyD
	1tDpbtYKhdljOzDWrte5DpGtoKe97IWkoO34lr0Ma2Ux3hBfVbCcFUwL8RcRInT/oRxG0n2Ls2A
	rIDyYn9bN7jkQbzHb09omludMVz79QXDwpGid6MhqH4me9FKsozsrv+lvZXgBre/wK/oDZROYXu
	pTRNXyc0eMYYBeWcfzKLMKA0F/jH8LgHMhfhAHNjLLQQOiA8jObutvaFA6aw1p7eLvzZDSv
X-Received: by 2002:a05:6a00:909e:b0:842:4f2d:c4e6 with SMTP id
 d2e1a72fcca58-84591bd0489mr424857b3a.9.1782152209638; Mon, 22 Jun 2026
 11:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622174218.92190-1-kalevi@kolttonen.fi>
In-Reply-To: <20260622174218.92190-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 22 Jun 2026 14:16:37 -0400
X-Gm-Features: AVVi8CeVv1xG6qb6CKpW7Y8m86eZav1okAnKo5MOLTKZusWzLmXIDzzqqZNXg1M
Message-ID: <CAEjxPJ4=ZH4wATrwai3evZsrGeVY0ctoNRJdYpPL1G4DYYLPaw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use bool instead of int in ss/services.c
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:43=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Updated security_sid_to_context_core(),
> security_context_to_sid_core(), and their callers to
> pass boolean flags via bool rather than int. No functional
> change.
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

nit: I might have also rewritten the subject line to be a bit more specific=
, and
on second look, I should have used "Update" rather than "Updated" but I'm o=
k
with it as is - probably should wait and see if Paul has any comments befor=
e
bothering with another version.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/ss/services.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index e8e7ccbd1e44..2bc522ad88a3 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1354,8 +1354,8 @@ const char *security_get_initial_sid_context(u32 si=
d)
>  }
>
>  static int security_sid_to_context_core(u32 sid, char **scontext,
> -                                       u32 *scontext_len, int force,
> -                                       int only_invalid)
> +                                       u32 *scontext_len, bool force,
> +                                       bool only_invalid)
>  {
>         struct selinux_policy *policy;
>         struct policydb *policydb;
> @@ -1438,14 +1438,14 @@ static int security_sid_to_context_core(u32 sid, =
char **scontext,
>  int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
>  {
>         return security_sid_to_context_core(sid, scontext,
> -                                           scontext_len, 0, 0);
> +                                           scontext_len, false, false);
>  }
>
>  int security_sid_to_context_force(u32 sid,
>                                   char **scontext, u32 *scontext_len)
>  {
>         return security_sid_to_context_core(sid, scontext,
> -                                           scontext_len, 1, 0);
> +                                           scontext_len, true, false);
>  }
>
>  /**
> @@ -1465,7 +1465,7 @@ int security_sid_to_context_inval(u32 sid,
>                                   char **scontext, u32 *scontext_len)
>  {
>         return security_sid_to_context_core(sid, scontext,
> -                                           scontext_len, 1, 1);
> +                                           scontext_len, true, true);
>  }
>
>  /*
> @@ -1551,7 +1551,7 @@ static int string_to_context_struct(struct policydb=
 *pol,
>
>  static int security_context_to_sid_core(const char *scontext, u32 sconte=
xt_len,
>                                         u32 *sid, u32 def_sid, gfp_t gfp_=
flags,
> -                                       int force)
> +                                       bool force)
>  {
>         struct selinux_policy *policy;
>         struct policydb *policydb;
> @@ -1640,7 +1640,7 @@ int security_context_to_sid(const char *scontext, u=
32 scontext_len, u32 *sid,
>                             gfp_t gfp)
>  {
>         return security_context_to_sid_core(scontext, scontext_len,
> -                                           sid, SECSID_NULL, gfp, 0);
> +                                           sid, SECSID_NULL, gfp, false)=
;
>  }
>
>  int security_context_str_to_sid(const char *scontext, u32 *sid, gfp_t gf=
p)
> @@ -1672,14 +1672,14 @@ int security_context_to_sid_default(const char *s=
context, u32 scontext_len,
>                                     u32 *sid, u32 def_sid, gfp_t gfp_flag=
s)
>  {
>         return security_context_to_sid_core(scontext, scontext_len,
> -                                           sid, def_sid, gfp_flags, 1);
> +                                           sid, def_sid, gfp_flags, true=
);
>  }
>
>  int security_context_to_sid_force(const char *scontext, u32 scontext_len=
,
>                                   u32 *sid)
>  {
>         return security_context_to_sid_core(scontext, scontext_len,
> -                                           sid, SECSID_NULL, GFP_KERNEL,=
 1);
> +                                           sid, SECSID_NULL, GFP_KERNEL,=
 true);
>  }
>
>  static int compute_sid_handle_invalid_context(
> --
> 2.54.0
>
>
