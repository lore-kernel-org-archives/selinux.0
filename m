Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823153B14D9
	for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183495; cv=pass; b=PZp1WpYkAGuB6AzVaMv1ShhuiDLkF4HyP18OiWCCxpYrRdEvYULw97sB2PAb+4gOxKZdVQBAxQTygXGhe/StkIEr+TIjSocWVl8CaAc7rkNEnMoZkHS7BbMvE8jXVM1FxuLtbEDAmXeIcFLhNAZI5PSGAU2TqBLIipw2zDCscdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183495; c=relaxed/simple;
	bh=bRP2Aa28X1rjuCIcGnanywIJtD32i4e71iO8e0ha4mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsenLHCRo02fTbdmr1EM262rkJCs/vlPljLKpDID/6mr+Pe7rfGPUhdEkYjGn3/nCyTmgsmdqedH6CFUgP8/hVk7xalzX69TI68MVhcK0zEs5224XTqouzDP9OPmXSAvytLn3nCcVsjSQoG8OyWeKKz4Vb56+1YikyzfpKEKBS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjRTjzG7; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjRTjzG7"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44aeefa1c00so263978fac.0
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 13:18:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785183493; cv=none;
        d=google.com; s=arc-20260327;
        b=LiRsAo8VyGJxNtbDcZ2iI09NKyK9ch/Y911N1dWDDRAKnlp4y2cP9Ecoy92o23jXKI
         j9zhQ3Ia2hkfC8rWw6tTL9IU9aqDH8J1/zXgQ354CCe+nYw6rWpkHnbrarMuUezCrRtr
         3LBhNxUiBI2g205MWpiUvJFZk5s18BEPg/96cR/86uRRDvZfw5IzcX4YR2GoHmsMEoBB
         hR35zkKOfmBZFYD6orUrDm7eZHGs65Iu+SVQkL1IuZoT8S1rQ73jvGxV1vOEEDTDAV/O
         hbsbPNUWwFmf5NwdKziwyLU6ukkIQRDGjHS/q0VCLaGz31s9P0rxRnrPr8/7ijsQTifo
         2G/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bRP2Aa28X1rjuCIcGnanywIJtD32i4e71iO8e0ha4mQ=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=cDyIkYv5976MP78RFHxdikGzX+ii8s5sxxEVRLlNmCv0cMNUhdW2NJ9WZqMIv6WizG
         W3stFB32aQ9vwEuHAHR7B40ra5Vpi/IAidbxWmJOGMFecI62qviBRLesrmhcRlHvRejy
         +2LQPBulkYE/XZMpsPCZanGsNRJT0DqDh/ZzDoNBqseTmgNvOnJYn75eQ7a98UrSpcWk
         6z5wyafQ67oryXWxj50yNkz3AMbeolS6oP0CLamNwJ70hFwfguY9D/eV52UY71WH26hf
         ++psHsrTOhP84A3ecd1ZRsDeLZ2RKfgFgJ3bFXP1eHQOGe9V0b/iEXr9RHSgY0nAf73E
         jPEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785183493; x=1785788293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bRP2Aa28X1rjuCIcGnanywIJtD32i4e71iO8e0ha4mQ=;
        b=mjRTjzG7YQK1QM0aSkvVhkEYy9o/M9UzTUL+cjxCaOUL9dfd2CFkygdmLZI8hLJlMe
         hH0eqe+yjraifCcBD7bSubVKKy7FOtIsJxvXqkHJ4bKTjvZ984mLCPXD/anGzkjZKCZK
         tv0yMzpUO8Wc4YYkjcP7e3vrijverVLCmnmvskRwbKmQA+UxD/gKcWvDicZCmt2F/6Eq
         nLtB9WVxsxNVQYCgL3yzd/MhYEID3ovfLq0GP6DVjT0gqqm/N5T4AVLwgAS4mfVkjUkf
         LkdbjP5/7nNHPW2vxMnR1AUmX2miQ9YtObdRYZBZDL6v2QIZASWaviFcArdd//Mphcdq
         PszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785183493; x=1785788293;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bRP2Aa28X1rjuCIcGnanywIJtD32i4e71iO8e0ha4mQ=;
        b=octPepfzKWcJQ+iZJKaU956x9kcSojVXh1KP7SpMgxjlECRFmafHHZ/BwiEDiGysGe
         dOpSG2V6/B1AvwXF4DiFICgIc9pKWx5/MuAmy/6swisAGA5QZu1BgxQnNXXaITRQMPQP
         RiKRdq0DMdpa7UF4h8H9qS8UecYAUOLe5CceJFO7rPjqJUDwOTu1qgqk4brUYxd3FI9Z
         tq/T91fD8Zy+tJZ3Yfy5N83rNcHa4JOZPI0VAMVBukjgiR1SVx0Pn/GfaaeaBGy5fVYW
         jit52sGCxbfD+nwYvhOfFGL2n9puC8KuxrcYjskjAAQ7OPtUQPKR/Sioa62T8GZbh0BU
         IHzA==
X-Gm-Message-State: AOJu0YzDdwLQ0/zCBG3WcXcC549OJPDkt72sXCF13ZlJ3WGEeSJZZ7S/
	ioOUFvCY4sFzujzzwywHOtQf4eKsE+vdYvc8Jt8SjE98dacGOOJ099AKAocsXOrQioVPCnKmLYx
	Jwpa3D+A9AzrnhWO9MwoBen6xiMhhlTk=
X-Gm-Gg: AR+sD13Ysj421PLC+kECpjXYyVfyDlfl+oSsGrqdbf7oVJWTL03COfbR6K58w4t/yyh
	EtEIDkvLuRjnMXWo6s5AW+gU+Fkm9rFoDkK4UCqk5kfQKnr69YkK+UHlBrXSrdz99y22zWFPt42
	0IiV+Y+pTqjkyTosiFv1BiUFugyAziwtx/zcFh7uvdWHoBJRwhE/ixK5iTGgn9RjjRLzseVHTl6
	y2AOxLw3asCNjZVs7XRobuB/Hdv3zqh0/Lr6TyGgdMtlVv0ll9ZO1fIBGKRSCYeHVxuTj6r
X-Received: by 2002:a05:6871:c950:b0:433:cb0d:7702 with SMTP id
 586e51a60fabf-45863f9fe89mr167267fac.13.1785183493333; Mon, 27 Jul 2026
 13:18:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727173854.10810-1-jwcart2@gmail.com> <CAEjxPJ4AxjisR+VCNhS7mLCFmBOZhiWV4opHTtVmu1OD0ZLYug@mail.gmail.com>
In-Reply-To: <CAEjxPJ4AxjisR+VCNhS7mLCFmBOZhiWV4opHTtVmu1OD0ZLYug@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Jul 2026 16:18:02 -0400
X-Gm-Features: AUfX_mwwweK-5Jvq7EMpvhSGyTPatdtCEJqbLi16ox2xqhpndihoGjLKE-9Zb48
Message-ID: <CAEjxPJ5=09dE-kTkugWdh50gpVNA1YrgBaeYp-===h5devBEhg@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Return SEPOL_ERR on failure to set bit
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 1:56=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 27, 2026 at 1:39=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > The functions cil_typepermissive_to_policydb() and
> > cil_typeneveraudit_to_policydb() return rc when ebitmap_set_bit()
> > fails, but the rc value at the point is SEPOL_OK.
> >
> > Return SEPOL_ERR instead of rc when ebitmap_set_bit() fails.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
