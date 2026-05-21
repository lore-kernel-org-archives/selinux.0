Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260F3750D6
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383546; cv=pass; b=cn2qeDrxBV9Lo5l76vWwXwgQ/WDFByvkrtJdK6dFgQOrB2+QE2VBW/1/sS/dQxnFmSbb08aiXcsuxXEvRMhhE79pZsy34whPljg940elban5j9hTAeqAPB9lOk2GCW+7LsE+JV0swHJrZNtw73NK8mqy4f6lIYT3u05VApZsF8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383546; c=relaxed/simple;
	bh=E1nbj9HbG6kp0lWIQKTU1Sso9OkBuzHmjar0jg6QU48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFte3TjWDvtcg90j/EC8vlkoHxlLaK03UwOk2p/A0ATu5Ask1OSQkQ8UThKnBc6zTvrL0xigbjqXeVMsF1JfYUJrICmBqmvJuUe7d7KSbVYrQ8EY1hxmcnY6bvv2Mih2vnL4H0DrhaOxyqra31/fBCdjtmyT9whGtNjKF2D0BE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/uVJWDN; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/uVJWDN"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-393a49d2e5eso57675001fa.2
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 10:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779383543; cv=none;
        d=google.com; s=arc-20240605;
        b=C5u7YDeqZWKTiBUjNBumMuFenlVYPVcEwU3b99imsAKSq74lKw7wwfsYjPb6ULxkGh
         bcap1gkMx2C491cMZSMHxhULfCFpAzvANJhdi4NdsWyujTIe2GZESbPkaCKKYyWHOeD7
         cUNtNggiM9CU0MOPRSoIN7B8cY+e+9cLjSubCAOxsQDBSKvRqyqDnBeHIqn7EUJSyYVl
         tF0r+i9f2PN/TFM7qioQawwMsuw93iWjyZmqVMm8lHxgqff/FF28aIYDByvS3D/Gh+l0
         KfGhheb6iUUtMeZ5Hp79fDAzGQ7i1olmVGbmcPcuh2bmyvbECKrJZWDNcwXepjhBQxMu
         hQKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rziRJ/JpriPu+0JDQvmt+fE0X8EAkMfiVwGvWjBM7E0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=RR5axJlHyl/8mvFzj74PXATh+vb0gRZX6uE33Zf2se7zUUbfrSG1WYxFkgs6qtc8S4
         8PfX90UqJllNUWO6vX8yuGCucbfNRSEMxa6Ns7rjTiCL6MwTdq7hj2apYI7Fzi8csfBc
         P/K3AR8Z5mNCkp7T57WBGiBT1ovx1JRIkztMWNKJNeeHI2bY9jZW2S3PgAxfNbZ/pJ3Y
         eRmPTUrJYB3BDi+cGzpT2qZj5d/hn8Ur+GsjBY5J8RvwhfOkZbHjqLPhGEfAiqL2V0tc
         gPyAxphprlkRonl6qWRzIAR9QOTjA4Msf9iccqUvH02+2TO3lUvxk41/PKcE7Ruov6YD
         uxXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779383543; x=1779988343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rziRJ/JpriPu+0JDQvmt+fE0X8EAkMfiVwGvWjBM7E0=;
        b=Y/uVJWDNyVLNeavJDZ/m7kI9ZXCAENW5P7Of9b6OvOFs0wPm9jpcO8Z+7pSeIsq7Zl
         c5Dotjexfp9cGOoryiK+Sb397dkEP2ydfvuJsdOMnk7AhKvcnTDaquEr2kG6AS1mdId2
         avAmVXV8Cx2+pjkaIBoS+Y8ea3EWk1sS676S723oXIoohafUlkw/ICCtzjaKkyj2j0XA
         S/jk9VnhHFvYb7irrWTmwlBG8WHlb2ohVQearDLgr7MHqE4EdQR+PmepmZpSlih1JiTQ
         a6sv7/s1JNmLurIR5p6Q6HIykEZTfdUa7oY8juUzFwNruq34jptT5Zz6H6zZvFGui8UF
         X0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779383543; x=1779988343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rziRJ/JpriPu+0JDQvmt+fE0X8EAkMfiVwGvWjBM7E0=;
        b=bkMWqtGp22ODTI6ue+hNxkS6gCECgPj+BXwpZ7Mu8uacu9CIeiKglQse6ceuwwoKdV
         TDCZsD0AVvf5CNXR6X+HnxqDJmTEq8aO4vwfkLuNI5amIYGmGeE3R5rAOErc90hs26y4
         8QeqWp4gv43twdPBzB9TSPL5zmd1R/RRzl+mtHkRQfxmLWMWjUp/WIGmdSVmTAO4aOMt
         gG/PzvbHpy8Qk4Zoxk6S85kwT8XXpgde8H0I7IsTFIGkCe53iELB3W/U4Er3/xUd4KkI
         w+Vo+KjQufMscGSv2Fu835II2O4tmblohZCmwjskFOqkYyvnNAiCCmGVJQV6hPjme7Xt
         bq7A==
X-Gm-Message-State: AOJu0Yzr377b18/UqoZgIcl/QdhDv/wb3iFH5EWkruQ+HbHnFBM2PTr/
	uraOd8xTWpR3l+crNOfWYiYt7JFhux6/Oen0MmVq2eYG8sPfXiaaJ7MHs4x1tE52QAKpBs0lWiI
	J15dKYd/zMxxlAKJoiABKDujDtoOdnFY=
X-Gm-Gg: Acq92OGMGRK+vWTsMAJ51OmVwTGLiB2eOzau5/xMOOpo0N9B0LQXIWzkMEewMFLyM0h
	Q7i7IRxwHQ1WYLYtWjeQTjW7K1ovu7D4YsATw0fXhOvOsbpEUrouLpXwTewx52kpUk7MfBbFF0H
	3yo6NQ6JJcnGDpHLS1s9Zpqoae6qbYaYMfO/QpFsiVUWzp/XVgEADwiI8Tysm4Q4NnJKN2nyu8/
	98DVmlaWlLpAgGFVrgslgv0CVHZvvgqjzpTNaEWwJBhGqPSHErsqShu+tvHESvCuoql4g3dOQo8
	DghZCH0il5zeOwoApZsjofe/Cw==
X-Received: by 2002:a2e:be06:0:b0:38c:63df:82a6 with SMTP id
 38308e7fff4ca-395ca6df5a6mr15630411fa.29.1779383542348; Thu, 21 May 2026
 10:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519122401.156311-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260519122401.156311-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 21 May 2026 13:12:11 -0400
X-Gm-Features: AVHnY4JXiEn6KNwst3ZQaJQPe3ojQ56Bi8xJxU_Uy0mruUyESY7Lv4mxVShAoIc
Message-ID: <CAP+JOzQ0LYoYStegKak=oS2egG=QQLNYOezhXgXtLPantZM16Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: link xperm rule permissions correctly
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:39=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> In copy_avrule_list() the class_perm_node_t::data field is interpreted
> either as a permission bitmap (for AV rules) or as a destination type
> index (for type_transition/_change/_member rules), and is remapped
> accordingly when linking a module into the base.  Extended-permission
> rules (allowxperm/auditallowxperm/dontauditxperm/neverallowxperm) carry
> a permission bitmap in this field just like AV rules -- checkpolicy
> sets it via `data |=3D 1 << (perdatum->s.value - 1)` in
> define_te_avtab_xperms_helper() -- but the conditional only checks
> AVRULE_AV and so xperm rules fall into the else branch.  That branch
> dereferences module->map[SYM_TYPES][data - 1], where `data` is a perm
> bitmap rather than a type index.  When the underlying ioctl/nlmsg
> permission lives at a high bit position the resulting out-of-bounds
> read segfaults semodule_link; when the bit is low the read silently
> succeeds and the linked policy's xperm class_perm_node->data is
> overwritten with an unrelated type id.
>
> expand.c::expand_rule_helper() already discriminates with
> `specified & (AVRULE_AV | AVRULE_XPERMS)`; apply the same condition
> here so the perm-bitmap branch handles extended-permission rules too.
>
> Reproduced with a modular refpolicy build that emits allowxperm rules
> into non-base modules (XPERM_RULES=3Dy, MONOLITHIC=3Dn); `make validate`
> crashes inside copy_avrule_list at link.c:1298 and succeeds with this
> change.
>
> Fixes: 58962eb3d847 ("libsepol,checkpolicy: add binary module support for=
 xperms")
> Assisted-by: Claude:claude-4.7-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/link.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index 188b4020..de964c92 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -1280,7 +1280,7 @@ static int copy_avrule_list(avrule_t * list, avrule=
_t ** dst,
>                             module->map[SYM_CLASSES][cur_perm->tclass - 1=
];
>                         assert(new_perm->tclass);
>
> -                       if (new_rule->specified & AVRULE_AV) {
> +                       if (new_rule->specified & (AVRULE_AV | AVRULE_XPE=
RMS)) {
>                                 for (i =3D 0;
>                                      i <
>                                      module->perm_map_len[cur_perm->tclas=
s - 1];
> --
> 2.53.0
>
>
