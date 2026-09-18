Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396E830B53E
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735071; cv=pass; b=bjZ1NaArutnGRFWOXp9v3TnnwHqYfYx0ZMft29g8DBqGOtsffuZzu2NKg68l/QpvdVVhtP4xKvR04c6flxje7QfQ3QJj0z8GHeyB13TtZZ+GfRsDN60tJJRmAwLsBxevdQ2GpBZoGo7RU5/ygTzkzo0mPUsmTtYyTwbEVV6xSBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735071; c=relaxed/simple;
	bh=MvBE9yZRuJVfjtjuzWbVJX4E5mFlmwdUJBfoQq94hqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqJBCILFctWRghQcg+EbiASggasiJbLD61DqXuNyt9B98bcb8MGQokWnzc6teFYeHuuQbKsuRIK0wQ4LYU3lwA9jtrFq2AJXIvPnYuacJd5/dIGRmywAfhx8vmyeWLxUzFRGE5oE0VJpkkGIlISN99lfqC1xOt3soZvreKzGsi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6fi2SvX; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6fi2SvX"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-46ad7304688so1524717fac.0
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 05:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789735069; cv=none;
        d=google.com; s=arc-20260327;
        b=SLlw8QNTqJRLi2TdvnvkSTYKToq8ZEZqw7Lfe2sw/Dx0sMiE5+tcw8S03jEKBJz3vL
         SPWjAhGO58eW+dOfDegClDeAR4byBZo3YWEIF/sZo6H2m5xEofb9YUOxTawJ6cevDD42
         /Kf6B+uA/zmf5Vw0CggV3AF/g/5RrZYtz3bwnA85tt2Ge9FU/aVqKY4MjXWR7ZXc1+Ao
         Q5XB3+XmvOihAYhqa2lnOl5RenN7BFK5ELwH8d36hcvN6P0Nf9/9OsyObdyvteerIthE
         /69SObXIUYRgM2SPWhZwAp8gj1cfsDmu0okxtoEE/WxlX1qNZ1AmXKuJXT+UVc8VzYo+
         pjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MvBE9yZRuJVfjtjuzWbVJX4E5mFlmwdUJBfoQq94hqk=;
        fh=N+TNwIyB4OftVo6xWZyGDxf9PNoaOqAOuhaF+GgJBDs=;
        b=bbse3V4mfEy5gjwWy9beKqrMRmxL9fVV+/SxI5/H/ubHToZneZBTudp+9UXA5sE9uM
         lUQlwlPlEHILSenWnEdhL6FR4XLpiLsHR2I3I+TgoVpjfDBQ2grBq/7UBp+UCU2A6xL4
         ul3TabRuqcFnD8HaIFwkA0akxxgE/ttXiDfC95fzJ9AM4/UBd4PUSR+xQSp5hRWOVvMq
         xaKB0WSKJHJ3sJ7gLgv3eBVIK1hLqONyNSnPMD+P5bk9AV67kN1S8PkXVC3viNK4aQZj
         sgWdm8ywxuBk7uV8jgqqxSkwlfAXfNfRoOxJ0aP8KXQpuaFWPOsNwIEkhG3tT72rov2R
         eiiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789735069; x=1790339869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MvBE9yZRuJVfjtjuzWbVJX4E5mFlmwdUJBfoQq94hqk=;
        b=F6fi2SvXLGrY26QUlVX3cAkMOsRI22YeXjPRppbR3iks41BDzHNvl/2WsZ41ZZR0hF
         2tW27QO81mnB1wxQLfmpM8pZkae8P0SnxSNAgsiR/cEDmiCZufhINKY4GhyR7HBg9dqe
         qbtoFu5+yckRWoMvr+/L5X89SBzJRmAOOXrjIS1ejJ+8P7nnnYgURu+YvnHnDjhH6OaY
         VuWKLGoFTMy9iPjrtL+UHW9mPGcwPhna8ko6r23FukY8YxklmocI3VtF5wkbfgk907i+
         KWl151ryjVb4oscXvPfI+PozuX6PqYohgZee6a9nC2OR4A4MQPBWR9RjeDK4Qr7aMmBQ
         KqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789735069; x=1790339869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MvBE9yZRuJVfjtjuzWbVJX4E5mFlmwdUJBfoQq94hqk=;
        b=d8EaHU4nI8fpZ6XEtQh4Qu/73UGWs1MA8k/WYYl5iqWab2g+5e4z41gLgmL40mLx4n
         8b4GVVCTfUwZUcA9l5S8ZoA6jtuVFMX6G8ATffIYt5n2hot3TbW+HalhIAsqfqVaZLMl
         JY3xBlYVFq0g6ICIx6JrSGuV+mzlNt/g3GDqghjYq9gbpd2CK7eEcO0+ZSIkT1uJZvmW
         4xUWabRUjwlFPeGcdzpSkB7TdIV/d7xXgwI+5zVK8ULgDiV49vk7EiPwlT0Qo6cD2Esd
         XKTwhZnk8zzYTTpG8qAXxpoLbHHdVe27tdIK3DfKxwqm6bo4W8e3QO35k8EQ0UfZDYIS
         yt/A==
X-Gm-Message-State: AFuF++lp/KF/2/bYxQqiJb7CkTFf3PmlsPvncKVD1fOMLNl933gSQcKI
	pC26xgyvlsfKW1KEhdeJrQzqpAKw0xmJA1nfPm7RZQ1OUKpwgLBsipZ0cxVA8UypG621zvzzglO
	hTosEFn3H313AfQxQRUEoPsG8UXCKjeVRbg==
X-Gm-Gg: AYBFou1QyCDnTe28/JmCLlOHS/P0f5oE24Q9xVIx6PUlb0KkCF4Kw7KN5sJMf8QbSTm
	oed7HuklVTap8DN5HJlL6YSzJ39uaH8I54I9Y5YoVNf0Lmeyybf3B4Tdph6HMA/RhZrEn/OEtZI
	VnxQ3CkIHfQITzCqKUV7ck5LVFnn3uFCETCcXF6VyTqJSno4PBtmL2DgcJAPMvb2I0AJO4p3z3+
	m2O2VNtYMy9nqolWbwVc3bF5APow2NAlfltJ31RKENPIBrXO35Q7YFsES7yXjOkM1CfesabIFIZ
	BKKL9hj+/OqANv4LSp92G3FtE5gjOSW1NQc180Bl7BZUcYYbL41pRlE=
X-Received: by 2002:a05:6870:35cb:b0:470:e97e:8f85 with SMTP id
 586e51a60fabf-4856ece701bmr5294917fac.21.1789735069085; Fri, 18 Sep 2026
 05:37:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916180539.75114-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260916180539.75114-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 08:37:37 -0400
X-Gm-Features: AcwNN1VuKPfMuaVW8a9VuzmHbSYrzIYmtYKUJ86d4AriaDtEs_zSw3WohmhCZAQ
Message-ID: <CAEjxPJ7Ybz-en4moHPGHZZyNmFHd01nYWtGa_1jJPoUc2ncO7w@mail.gmail.com>
Subject: Re: [PATCH v7] libselinux: fix incorrect regexp anchoring
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnacek@gmail.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 2:06=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> As identified in #544, libselinux anchors the pathname regexes by
> prepending a ^ and appending a $, which will produce the wrong result
> for a regexp like /foo|/bar. #544 also notes that we should be using
> PCRE2_DOLLAR_ENDONLY/PCRE_DOLLAR_ENDONLY when compiling the regexp to
> avoid matching a pathname with a trailing newline.
>
> Move the anchoring into the regex backend. For PCRE2, set
> PCRE2_EXTRA_MATCH_LINE (as used by pcre2grep -x and GNU grep -Px):
> pcre2 wraps the pattern in ^(?:...)$ after parsing it, so a top-level
> | is grouped without shifting user backreference numbers, an unmatched
> parenthesis is still rejected with an offset that points into the
> input, and mode changes like (?x)#... or an unterminated \Q inside the
> input cannot swallow the appended anchor. Set PCRE2_DOLLAR_ENDONLY so
> the injected $ matches only at the end of the
> subject. PCRE2_EXTRA_MATCH_LINE composes with PCRE2_PARTIAL_SOFT and
> with JIT compilation, so selabel_partial_match() is unaffected.
>
> For the legacy PCRE1 back end, anchor as \A(?:...\E)\z so a top-level
> | stays inside the anchors, a trailing newline in the subject is not
> matched, and a pattern ending inside \Q does not swallow the closing
> group and anchor. PCRE1 has no equivalent of PCRE2_EXTRA_MATCH_LINE,
> so an (?x)#... comment at the end of the pattern will still consume
> the suffix; that case is left unhandled on this legacy path.
>
> compile_regex() no longer needs to build an anchored copy of the
> string.
>
> Reported-by: Stephane Chazelas (@stephane-chazelas)
> Suggested-by: Stephane Chazelas (@stephane-chazelas)
> Fixes: https://github.com/SELinuxProject/selinux/issues/544
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v7 fixes a typo in the man page.

This patch has been merged.
