Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E52233134
	for <selinux@vger.kernel.org>; Wed, 27 May 2026 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904001; cv=pass; b=C2XlgOcdoSOJdqTt/z3464n3R8uVmESSLH324Ed1Vhf2SQL1TOcMykJXx6Ej02uA4Sn7OWlDFqcrHDnxw2H7y5tu64AJ98zp2HvqAlgQwL1w3vMfyvBldXee4YMPY7sY5kjtdEBbhLkRZhXvhveaG6JxJyL2hiDnFOIXMIOSYpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904001; c=relaxed/simple;
	bh=TYw+5C/R6eufZppdUc7dkWIxiuvZt0d4pK9l4pYNx1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bO0QE2ejyaxevXRgkZ8b1tByIzt4x74Y8GzsX02lPU7+l/2iB+7pZYyY61O0OoL8iAwIoPnxHforT1tdJyi/NOX7c4/MX1z9TJ31koPNClllN/jLM2joyGBYNUF2FoQHAMggZN77GNWSqc6VBpGS6rPzYSqRcBUlOoci2w7BUAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBQ7ce1w; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBQ7ce1w"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824c9da9928so5856086b3a.3
        for <selinux@vger.kernel.org>; Wed, 27 May 2026 10:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779903999; cv=none;
        d=google.com; s=arc-20240605;
        b=BstzprslQrcKOpKN8PJJ4cFwpNZQFGKREa6WUuRJyN1CUEKgeUddfBjlpgpZo6FA5c
         wrj3w67P0rRFNaUBkMYU/ebHQRQ/nS5ZSFe0mjiHd1fXWUUFqROvAOMDXTJlQgV4pLO+
         koCuSy+7AGNejdMAya0GPURHBTzkOyHnCLOL48RPCeeAmNF/2q0b0Iqmo9nYhSamt1Um
         N8ow1uPQqpIStsBUqq4voTQ+uaLrCfwVwwzxHpSObGWRkYXYp9dEP0/QYk/HCMqjPtpG
         mvvsr1ADiRAhXtCbbNXci6cLW0lBY/GRVpqv5hMIbp5CBPf6NCCBd7FPLmgw5j1ppMd/
         Lp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JJy+FKYO5VrBf+dgoM2UGiwmoM4euyPngZnvFcHyE3k=;
        fh=BVG+R+ZBzwo8aqszPIHno4GP27O2unLSWAmgs7erR/w=;
        b=DmZ3WLroRo5U3C1/HKNj583H1qh3T4I7sKNo4XTIOvmKHQrxaC7VBW9rCy+DuCVmWC
         PaNR+CEezZZjTJarP7esVGt0xgX1tf8i/sqsPYq2oETa3qsnp3EMc+/3bnOtiZcI8tmG
         6QYmsqEdZU4UDkd2xPU5sd8ssVJyfEBnqjeiyaUwbav0LW4VSgOqFUIdYro0XDIpzXr9
         MmjPX2EWgw4vtuQEGXaVmZ/S0s+TNXRwX12a16QoJFxvtkmWjhkTpAB6BKD3vb5XaYAE
         d3xnjJPG7SmVvW9vCmEOSLHPE/QsAFDr5I5Hj55kkpdQlaRP91FOEJ8akFPekhLZv0ee
         ELTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779903999; x=1780508799; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJy+FKYO5VrBf+dgoM2UGiwmoM4euyPngZnvFcHyE3k=;
        b=JBQ7ce1wB4Fj7V0aoc1HQogyBlXgZWQhanUJJC+gZcafWnqehQjIU3w5I9SkuElvn8
         1ddBgugavBJVJUyzag2q2h1BJbSlk+Fz5vADm6byJw5YqztgMD5886fDDy2fopy3ssyt
         TUHoTYnfBzpZhA/zDYD1MX8Gl52qtDbfTe4QUKbyYvxi1bNyMuyuWSDKjU6+2HJByOkg
         nrloxCLWitQ5xwS5JYde0DxsY3oW3MPiHZWz4UqUY9ycrVcld9QkjDaom+35dC8rTjnd
         Sj0ta5BVyCSR+9KqBDayuJrMlu6iYfGyfWC8cyEVQ6VDN402Wwtrg/yALLbXWcRfNhmB
         QeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903999; x=1780508799;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJy+FKYO5VrBf+dgoM2UGiwmoM4euyPngZnvFcHyE3k=;
        b=WSLpIVIahHmswyAXhBOAjC3a2bvWwjydufSpfU7x9p6pSzIpS6LTKjJzdwbgCRUdLN
         50CM8OQAf9C9D/9SkqM5XeCwpil3/qIawiHhPoviKHb4c+kLmEu4Z6lfrgQfcwN8EzWc
         mjN569x2xLtM+PACpLZXQOq3Uvxi7AEZa/Zv1VMSN62PCQLXJ7spXpftRNRFustSwB3N
         McKTMmMZJGcI4TeWpPug2LHrJkvx6IwTPkrGA5P3F4l70UxlwIh8poBEJjQbSyHg7XMO
         a/u8Lka5linmpUsvP/N/FTw8/EZzryRyTnkqnhH4jKScFQkSMj545JSKgDJ6qCAkRQDJ
         IDLw==
X-Gm-Message-State: AOJu0Yy7aB7pLsONPyE37sWhunIDWLGJBjvnXi174gCa8qwhNFkSo7xn
	rJqgEHiKFy9TdATshEbCpB2XAYX9/t8ctT/FGeSl8WoO9Sm4utT4goC/lw1UTnjff1BXIBXa4/K
	JJIQ2Q5OHn/AcfUPEPqgxA+mvhQ0P5HVzuA==
X-Gm-Gg: Acq92OHCZI2P9Z1QP5rl7Uuz3Wd5LmdGvC5GDb8MnfPCCFGV2vPItNadbUb7RyxS1xd
	wU9WTl0ETZ6zawlLuL6xY5C2HYXLQuqB7VKMZtKsbT3D296Kmax3XPcp7yaz2ztudNiWixEK7FD
	lIm78DPjYyL3LsuzgQgOUe7yAFnLaMRu96zVoVB/gri64FpHQPTVsN2qi9u7agu4W8NOEZV1iIy
	/qvoVAIvalsoR5UNATr32TvgPInrNHIGzRiy1dm2fL64uM1PTH59y9xzXOHB3DjqeCYiZfe7HiN
	iA6iox0=
X-Received: by 2002:a05:6a00:18a7:b0:83f:2568:d466 with SMTP id
 d2e1a72fcca58-8415f30a0demr24386175b3a.31.1779903999429; Wed, 27 May 2026
 10:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <76k2qxgeqgik3rdq6pnve7c6fqu43pjjeskxshtztal6rwllrd@ta3gvtdds4it>
In-Reply-To: <76k2qxgeqgik3rdq6pnve7c6fqu43pjjeskxshtztal6rwllrd@ta3gvtdds4it>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 27 May 2026 13:46:27 -0400
X-Gm-Features: AVHnY4IPFOvgTapO3H_6zq9Mvo68i9MbFm42bEldM8o0qL8QqhV0WQ6XljlX1YE
Message-ID: <CAEjxPJ6yTtMA4a-CvrQW0uTJ8mTEkdr6WE9mVJw67BKH5KRwyA@mail.gmail.com>
Subject: Re: Question about libselinux *_with_level functions
To: selinux@vger.kernel.org, selinux@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 2:12=E2=80=AFPM Filippo Bonazzi <fbonazzi@suse.de> =
wrote:
>
> Hi all,
>
> While looking into an openSUSE SELinux bug report[0] I ended up looking a=
t the
> *with_level functions of libselinux:
>
>      int get_ordered_context_list_with_level(const char *user, const char=
 *level, const char *fromcon, char ***list);
>      int get_default_context_with_level(const char *user, const char *lev=
el, const char *fromcon, char **newcon);
>
> The function names and the man page seem to suggest that these functions =
should
> apply the provided level parameter to the context. However, in my testing=
 with
> libselinux-3.10, this does not happen: both functions return the context =
without
> an applied level.
>
> Simple example:
>
>      char *seuser =3D "unconfined_u";
>      char *level =3D "s0-s0:c0.c1023";
>      char *newcon_with_level =3D NULL;
>      char *newcon_without_level =3D NULL;
>      get_default_context_with_level(seuser, level, NULL, &newcon_with_lev=
el);
>      get_default_context(seuser, NULL, &newcon_without_level);
>      printf("With: %s\n", newcon_with_level);
>      printf("Without: %s\n", newcon_without_level);
>
> > With:    unconfined_u:unconfined_r:unconfined_t:s0
> > Without: unconfined_u:unconfined_r:unconfined_t:s0
>
> newcon_with_level and newcon_without_level should be different, but they =
are
> identical.
>
> It looks to me like the implementation of get_ordered_context_list_with_l=
evel()
> is just not fully handling the level parameter. The parameter is only use=
d to
> get to define the newfromcon parameter, but the level information is then
> stripped anyway by the call to get_ordered_context_list().
>
> Am I misunderstanding something?

I believe this is a regression introduced by the deprecation/removal
of /sys/fs/selinux/user,
as used by security_compute_user(), which was formerly used by
get_ordered_context_list*().
Previously, the kernel would compute the reachable contexts (including
MLS ranges) and
get_ordered_context_list*() could just down-select from those. Absent
that, we need
get_ordered_context_list*() to properly substitute the level/role/etc
into the returned context(s)
and see if they are valid/reachable.

>
> Thank you,
>
> Filippo
>
> P.S. I previously reported this issue on Github [1] in a bit less detail,=
 but I
> hope to get better answers asking this directly here.
>
> [0] https://bugzilla.suse.com/show_bug.cgi?id=3D1259191
> [1] https://github.com/SELinuxProject/selinux/issues/508
>
> --
> Filippo Bonazzi
> Security Engineer                        suse.com
> 8257 4398 947A 2DBE F21D 76E6 937A 63F0 5B36 46D9
