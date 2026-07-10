Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E793769F5
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707275; cv=pass; b=ZXAudvFNJNMhxj6Y5wmyKsURfirrSnYBm1iNOpW/ktzvbeGrZTV7feg9iQfO72bfxucccw4qCzfikBGVKgsiZEcv8I1KU981cNJjZwHHzzY6q69ar0w5CKvZ/xZUzKo0wAwYyAkXV1tRYUiWtdey7pp0e6LAdxTjenE2TEZA1tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707275; c=relaxed/simple;
	bh=reuKY/03YkEaRXdUjXVg5IY4kXienBM42hqx6fnI5z0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzZfbQEjEmSstX0hJIwi0tUYM7nb1R7CjRBArS/Qwg9IifhF2k38qWnqGjC53b36XPxcK1NU/fZCRU6aPw5QrZKTulOw17WjC4IUkX5r7DsabBBMdKSRCXlW0FUPnefv1LBl6xv+aM8no6q9anE7feFObkRYIDmSHQmrkI51768=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3u3SVel; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3u3SVel"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8484f229529so1003694b3a.2
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 11:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783707273; cv=none;
        d=google.com; s=arc-20260327;
        b=g5A3YFZVcbXSij5pX1JspawzBapN39LaAEKsZwN2g1vzB6fZT7CNLwhQIKvQKCSvY+
         GeSpwMgfuSX3Z59qwIbWtd2r8ivUAxhuhbS52z86WR45/v38YxzI9fJzH24dls8d4vHa
         pi5HfdZVRjI8AJZWwzJ2roq7ZmqaRcqSQsN76nBgrE5suiHrixMGdQ8zww9JLSO1G93J
         ExUOw1aOYIpcslgdKCmDYe/ms7HckGlawah0QQGvW4OW/Llaw80pciiBcB1jSt7VzG8M
         lJO54zQnaolVqUeU/FC2rUbA0sP9AQEWk/Nz7C2tVjzjmle/ryH4whQINmr3PI1yYyb1
         Yh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=++QP6FkHbLz1on2xyYUDI9qf+tgEipe13VKh06iEKoM=;
        fh=cWi3kW8rsHyAhg0+a/rjvnARy8e1ms2xzmZhoFZJJgk=;
        b=WrIJ1hSuW3Hftp/1KQnqDE7kitFiR5tRvemGSGcs13zAOHBHPbtUK64u8bH6NCOdLr
         rzgKSVyiU2MK6E8ndVTGvJMMbzBh2zWE3fJ6BM3gXsvqJ+Adqr6aJKuVfUYDxie1/Eq6
         xoilexhzu25NGjnXyYHE2Z7zjCv8ZDp89Bf6h9hwLGvOUzus+e2PFSEW/mGSw2Y3bQOJ
         frMkUnt1viV3Cenf0pGzjlpX3ez8B/s9mUKGqv1tzoRUC3C/YwrsHI0qR5venAYXmiDK
         OcyfBKd7ViCi5Ho1C//65ZwetUmGGEDLO+PT5hvR/3VRndyWevcEH9VjpIWDW+8GC9yt
         a57g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783707273; x=1784312073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=++QP6FkHbLz1on2xyYUDI9qf+tgEipe13VKh06iEKoM=;
        b=l3u3SVelQQRz0Fm/RlgYRQK/Lo/XpJ9cRxmzlp4GQheXT2dQnw6v6D8WQYnPGo+tn8
         ir9wzXVQ/B37n6OWz0iI4CHIgQzCGJWxTSGqlncZsYc2aRSo7IHtTFlU2SwW6+jbvufZ
         TNRc7aDydOcyISSlX2c4vA4OWcjxydaWyEtCO6iH5jhJNOnmQCquZINX/3/pSnKbMJHS
         /CJ6ykx+d0iqMxnIg57eFRVNnLr6c9HFNFzJxz/YgeZ7BZ+ovoPkLlipLb1gM/xj7j9m
         f2qf/BeyJ30diTNTTXC5D9bOpklthvz2zH94wXx8zEINS3Pxp2xU2D2OwP6YL/xq1KOW
         pokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707273; x=1784312073;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++QP6FkHbLz1on2xyYUDI9qf+tgEipe13VKh06iEKoM=;
        b=BAd7AE6VHUmx+NmkJ2qOGm3UV2Uxh37qTJ2WojPm+QWBTAxB1Q92ZMN/XoYW8kBVQT
         HSJtsLngQxYIecacob73cdKf6BERwSDIeRQce+XFPFcUAoxJyM7TY+RCVcDqAAXktZH0
         PZlTvmLQbkfNEKHQCLiYzOv3xSXDSL7hVJd0Bqsn9nNBzzOOvyjtrZyRDbuLfzy5RIMx
         fR4MwTCk5NuP8MYB4uEEky7l+sf0l1qI2EHAcynZIGsnMvUDVFPB4xkr84YGwpxj2mlD
         5Iso0fA6FDWKQG/iblKFAMc+W2HbEPYtcNKJ7vWXdhNw0KptOHWbrEwURczeOsTmMG+t
         7dJQ==
X-Gm-Message-State: AOJu0Yx5fFIi4YT1jxNR8y6QpQT3ihj1mjUNMxZ4Ia/OtIv3opzbK3LM
	6MZUqOLoWtvB83OA9PozGQGoZy0ErKrMEdYv2O1WG8iBk1+MyUpOKVHFf5dmBhSQlvBT6yp1hAQ
	GjgVvHdo2UNIbMnnmoV7fYD1PBRH4g2IVTw==
X-Gm-Gg: AfdE7cnUQdYnY0Ghjuxd4ZsEloyl7VQi2qcXfcyEIYIkuIhr1WExBvUL87MJNeqg5Xv
	5gU2pPe2UgMQnTbaC3/v7oEJbu7uX8DeyS2QLhGq1shISIsF0Wv1mDZHntpmWU22bWww+fpQTTR
	D1PPYKwPfgY9qITCL1bVkNGaKyEB/ZwHZFDsKj0uTNpx4CZOw2JxGOFB6tiCt6/DxwLVh7onhj/
	EDlpXw/5xzCF33TR8IO3SOGriVGk5SHp9VyPiblh9Ud0hgAJvWAKs4n46t5h7VXKEK+uqLt
X-Received: by 2002:a05:6a00:cd4:b0:848:732b:6b26 with SMTP id
 d2e1a72fcca58-84889841625mr100279b3a.66.1783707273557; Fri, 10 Jul 2026
 11:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+jXL7=3=+wxXqm42Q_tQaoeusdUCnwzav_6gF6niAttPZ4ijg@mail.gmail.com>
 <CAEjxPJ6oehVAWO47=dCnk7q2-GZ+wkyiKXa6j--PAziPP4135g@mail.gmail.com>
 <CA+jXL7m20TzvdCuuz0d_bgAvf+GV5dFmKJb9gFEYjf+OYUYuZQ@mail.gmail.com> <CAEjxPJ6rMJd--Tg5yzByzFRQ=irbE0f4fxik48FdaxsT=Qtfbg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6rMJd--Tg5yzByzFRQ=irbE0f4fxik48FdaxsT=Qtfbg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 10 Jul 2026 14:14:22 -0400
X-Gm-Features: AVVi8Ce7TwqHzziJ1XBCpeGww5ZlbM5U_NEsuDsD9QEQ24CoD0RvH6wRj-SglXo
Message-ID: <CAEjxPJ4_Gt4RFqX9n0_rHHsznt3bHKBhi9j_+anJK-Ddc8pcnA@mail.gmail.com>
Subject: Re: [Bug] Double free vulnerability at define_genfs_context_helper
To: COMS VLAB <coms-vlab@ucsb.edu>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 2:11=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 9, 2026 at 4:11=E2=80=AFPM COMS VLAB <coms-vlab@ucsb.edu> wro=
te:
> >
> > Hi Stephen,
> >
> > Yes, patch below. Please attribute the report to "Reported-by: UCSB VLa=
b <coms-vlab@ucsb.edu>".
> >
> > The fix clears the local `fstype` after it's handed to `newgenfs`, so t=
he `fail:` cleanup no longer frees it and the genfs list becomes its sole o=
wner (freed once by `policydb_destroy()`), mirroring the `else` branch. Ver=
ified with ASan: pre-fix double-free, post-fix clean.
>
> Thanks, unfortunately we need a Signed-off-by: line with an actual
> person's name and email address and your patch was whitespace-damaged
> by your mail client. Try using git send-email instead, see
> https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started#sub=
mitting-patches
> for some tips.
>
> If that proves unworkable, we can always just fix it on our end
> especially since the fix is so trivial.

Also, please re-base on top of the latest selinux/main branch; your
attached version of the patch also didn't apply either.

>
> > ---
> >  checkpolicy/policy_define.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index b73de45..f8c4d28 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -6050,6 +6050,8 @@ static int define_genfs_context_helper(char *fsty=
pe, int has_type)
> >   }
> >   memset(newgenfs, 0, sizeof(struct genfs));
> >   newgenfs->fstype =3D fstype;
> > + /* ownership transferred into the genfs list; do not free on error */
> > + fstype =3D NULL;
> >   newgenfs->next =3D genfs;
> >   if (genfs_p)
> >   genfs_p->next =3D newgenfs;
> > --
> >
> > I added the patch file. Let us know if you need anything more.
> >
> > Thanks,
> > UCSB VLab
> >
> > On Thu, Jul 9, 2026 at 12:05=E2=80=AFPM Stephen Smalley <stephen.smalle=
y.work@gmail.com> wrote:
> >>
> >> On Thu, Jul 9, 2026 at 2:57=E2=80=AFPM COMS VLAB <coms-vlab@ucsb.edu> =
wrote:
> >> >
> >> > Summary
> >> >
> >> > A double-free vulnerability exists in the checkpolicy source policy =
compiler's handling of genfscon statements. When parsing a new (previously =
unseen) filesystem type string, define_genfs_context_helper() transfers own=
ership of the fstype pointer into a genfs struct that is linked into the po=
licydb's live genfs list, but fails to clear the local fstype variable afte=
rward. If any subsequent parsing step in the same function fails, execution=
 jumps to a shared fail: cleanup block. This cleanup block frees fstype, wh=
ich leaves a dangling pointer in the genfs list. When the policydb is later=
 destroyed via policydb_destroy(), it frees that same pointer again, causin=
g the double-free.
> >> >
> >> >
> >> >
> >> > Version
> >> >
> >> > 06159ee35d6b4c968c1f942c9361c111644de826 - current version
> >> >
> >> >
> >> >
> >> > PoC: Please see attachment
> >> >
> >> >
> >> >
> >> > ASAN Report
> >> >
> >> > =3D=3D2502=3D=3DERROR: AddressSanitizer: attempting double-free on 0=
xfc1f82fe1330 in thread T0:
> >> >
> >> >     #0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) (BuildId: ea3=
a1d5343a0633f08393e738125b8f44be83f66)
> >> >
> >> >     #1 0xaaaac9ffd49c in policydb_destroy selinux/libsepol/src/polic=
ydb.c:1596:3
> >> >
> >> >     #2 0xaaaac9faf758 in main selinux/../repro.c:11:5
> >> >
> >> >     #3 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18=
) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >> >
> >> >     #4 0xffff83c63058 in __libc_start_main (/usr/lib/aarch64-linux-g=
nu/libc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >> >
> >> >     #5 0xaaaac9ec7c6c in _start (selinux/repro+0x47c6c) (BuildId: ea=
3a1d5343a0633f08393e738125b8f44be83f66)
> >> >
> >> > 0xfc1f82fe1330 is located 0 bytes inside of 2-byte region [0xfc1f82f=
e1330,0xfc1f82fe1332)
> >> >
> >> > freed by thread T0 here:
> >> >
> >> >     #0 0xaaaac9f6d518 in free (/selinux/repro+0xed518) (BuildId: ea3=
a1d5343a0633f08393e738125b8f44be83f66)
> >> >
> >> >     #1 0xaaaac9fc8a60 in define_genfs_context_helper /selinux/checkp=
olicy/policy_define.c:6163:2
> >> >
> >> >     #2 0xaaaac9fc8a60 in define_genfs_context /selinux/checkpolicy/p=
olicy_define.c:6171:9
> >> >
> >> >     #3 0xaaaac9fcbc1c in yyparse /selinux/checkpolicy/policy_parse.y=
:787:30
> >> >
> >> >     #4 0xaaaac9fb95b4 in read_source_policy /selinux/checkpolicy/par=
se_util.c:70:6
> >> >
> >> >     #5 0xaaaac9faf750 in main /selinux/../repro.c:10:5
> >> >
> >> >     #6 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18=
) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >> >
> >> >     #7 0xffff83c63058 in __libc_start_main (/usr/lib/aarch64-linux-g=
nu/libc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >> >
> >> >     #8 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c) (BuildId: e=
a3a1d5343a0633f08393e738125b8f44be83f66)
> >> >
> >> > previously allocated by thread T0 here:
> >> >
> >> >     #0 0xaaaac9f53a4c in strdup (/selinux/repro+0xd3a4c) (BuildId: e=
a3a1d5343a0633f08393e738125b8f44be83f66)
> >> >
> >> >     #1 0xaaaac9fb9aa0 in insert_id /selinux/checkpolicy/policy_defin=
e.c:131:10
> >> >
> >> >     #2 0xaaaac9fcc744 in yyparse /selinux/checkpolicy/policy_parse.y
> >> >
> >> >     #3 0xaaaac9fb95b4 in read_source_policy /selinux/checkpolicy/par=
se_util.c:70:6
> >> >
> >> >     #4 0xaaaac9faf750 in main /selinux/../repro.c:10:5
> >> >
> >> >     #5 0xffff83c62f18  (/usr/lib/aarch64-linux-gnu/libc.so.6+0x22f18=
) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >> >
> >> >     #6 0xffff83c63058 in __libc_start_main (/usr/lib/aarch64-linux-g=
nu/libc.so.6+0x23058) (BuildId: b50ceafbd17dc6bceee344a66671c7eaa152bef4)
> >> >
> >> >     #7 0xaaaac9ec7c6c in _start (/selinux/repro+0x47c6c) (BuildId: e=
a3a1d5343a0633f08393e738125b8f44be83f66)
> >> >
> >> > SUMMARY: AddressSanitizer: double-free (/selinux/repro+0xed518) (Bui=
ldId: ea3a1d5343a0633f08393e738125b8f44be83f66) in free
> >> >
> >> > =3D=3D2502=3D=3DABORTING
> >>
> >> Thanks for the report. Are you planning on submitting a patch for it?
> >> How did you want us to attribute the report regardless?
