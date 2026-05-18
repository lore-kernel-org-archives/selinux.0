Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B5E338595
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 20:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779134519; cv=pass; b=hQbpqUI6Qo1DJI/P7wWJNFSNZJ/I2viQlMGkpHxiptHVys7LapTReqTlpcttNWenvxT5A4jpezV050MmWyl07DBvjoNehWFmX7fKogazqsTaLlmu9iF3H3qWFoL+tsQJFUuUyFgx0Kz9U1aXjy24DbWP33XKGlIQk++5bOBE+sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779134519; c=relaxed/simple;
	bh=7znnRt4rvXb1FWMHJckBY9tlzNUa1V+iQ/1/xQ0cBQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SO1Fv0VHwnSj05SkbJGPQX1ESTJEq6+Ap9TN6HunraWo9P3d27HV9ufHI6i1TUjI2ohQ64z5OJRDfNeDE/1U+Lci5tih2HgHS4Wyyf8m07jrz5hbivek1s9pN19cw/QgCnFa9YKQWsQ8Of+fxkThvfsevnWCYe/Ei4+842PqOEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiHHzUSO; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiHHzUSO"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-366330b6751so2215588a91.1
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 13:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134517; cv=none;
        d=google.com; s=arc-20240605;
        b=I5bCpKQTPFid5NoFtysFcDRwXO5rEoTQv64JURClkIjeewbcxTFd2lBQcSKqsdIRkX
         vihW24OFhrbdx6NtrnpSft8DrjhejDDq2o//KEIsTkQ8bIQ4tdUyznZax4gbCMl8Wjnb
         LZPdy/ReQLAb7a9VBZodhiyrO67WSMR+HDxAZiWrwy3g2Gh5XuKwWp/0KQh+NIPBMfpV
         YQhkAtBRqczsPSjUxX3/So4ZjGe/BH6n32D80g+CgXD7NqQv5dU/YNMNlgC1nF4AEt+O
         dWNPFEtGKNjvhbrohKxZVkZsOnW5Cs6L3D/YE1arlaxC2t1In0WoEM8TCmxyAUjQ1fJF
         OQNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KO75BRwhPm/QdF/eFCKW+blAejNzNM7qJaWNVTGjxMY=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=ZU5B+Ia7aBjJYHqsFNUjp6rmDanh86EXICyFSC5uQrQUwcENRtlj4SptQ4PHLOeuxT
         kwHLMQGZ77qaVrZ3Cl2lu4kDoI6gwiCzfLUw1rjJtdqEqh+UAdglRCqAXPb26HsMXL52
         QjXGPNMLBtTimVgTU91olnm2AvKGA0cNhHgrvGE3oimSGbe1j/KG+t08zefoCg5Upnym
         5mjNrvvHIGnzkqKRMA6u08GR6dtKfDVI6wdoXRqJqQYJ6twU/nK5jel3X99GwrFatT7R
         7treHA+kS4+MES0f2Xo+1Tr2K66vFvESCFNLNik7sMrqPFDZ4gr1z826ZO91UADUUV9Y
         fTpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779134517; x=1779739317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO75BRwhPm/QdF/eFCKW+blAejNzNM7qJaWNVTGjxMY=;
        b=UiHHzUSO2i9VtBO0PX6Y3oe4H5pC/S4NjAKqe2Jl9O6SAcPY3XRYpXdXdAaLX8KU7N
         wnXgG8rCf9F80YdTMSnyIzyy6bUqL0uXCOt73RVT9yqqgmzIHgVDELOdGzOCZdjUnxTD
         qPFmfoz4GdzYOLHEi2gIbvoVENysUmioLB+y7zxPqSN7GGgZD8YisOFX0GMtGMSMusLf
         FrYG++BLDRVqVb6Un/XQcIGl4nIMMhwP+crjmVmMcjlS9AHNziAxDyBpIw1/becdv2d9
         eRVhESRRsDKYF9U9I4207MtNOIa4bqtNBtvNGqHzZBhhSbYZPDnBmRjOqU4iH34XyFYj
         2V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134517; x=1779739317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KO75BRwhPm/QdF/eFCKW+blAejNzNM7qJaWNVTGjxMY=;
        b=mvMinoGHilt3xb64oV6t4Nzrs+xl3JO4KL0yc8rjA30lHpENr/goICrIeIuznxoSMG
         juBPS1BmMrWTdhN+EiDDqWICJN0aE830ZWBa2NSVVx2zDjNq06OMRKmHqNcni+HD+XMc
         NPJ8GwbJqKzau4pzrVVlcb1Klv/COww4KoOhHgDYgHk6E8xYY4/fMAty0vi9f/4IKEjh
         czzqcwPPkDhQzC7KkoAch4BVHrXJnm2NG03FTe4OGp13cfN1ps7TV4Tlek5ObLqkeFWa
         0dESR9GtIzQ6UYm72Pl1M1jByTiyLjdDlih3lRszVAxhoTr8KXc4FFsv7esiyGIaTFZ4
         Nrtg==
X-Gm-Message-State: AOJu0YyJCBWYRkXUNoRKSHpWbtCX+TwLhPXlvp1cw4J49b4Ntnjizd95
	rdpx8sDtEwu4HH7UnVDmY6vgW9GcHHMCUD5syOqPob/+YYeDnlVz4VuSo4GuZV/7HZ1l3jN0Qv6
	QFeuESdgygQ+AYAKjvvmnmwO2OL7Z3R+7Fw==
X-Gm-Gg: Acq92OEEaD3YTNOZQwb5FgP/uPjMz/RzlVJFpXBhcPNvvuaX7rLrBsvqqwwMV9zFZXY
	cZ1Dcjgmc5SHyMCZsFGtbMUZEuytS8gcbGfa9CyTS3NaQ3gyQlKBaAOBEvVVeAc0OJuL3w+70mp
	s3kwBihzTHwFo7ZDWAUBB///FaKlD9QrL+eOpB8qJOJq8A2fcXPUEzcM44Mp28QnegGQ7wK1aqy
	e6PqwhbcBAj36A4cFdfgkWkjEiwGOYgwcfuwRCceg3L5iUQrpBcVM35+dzxHzBo769k88IQGS5x
	In4705Y=
X-Received: by 2002:a17:90b:4a87:b0:369:d22:4788 with SMTP id
 98e67ed59e1d1-36951dc3ebemr16903932a91.25.1779134517355; Mon, 18 May 2026
 13:01:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514121424.10481-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260514121424.10481-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 18 May 2026 16:01:46 -0400
X-Gm-Features: AVHnY4Kvy0MyVSZE6i52bPgZou2Ln9zS9rEt_CuZbEnDfkp0InaJpnSerBIMJYc
Message-ID: <CAEjxPJ6OCXsb-8d-Zfyq+H-o1ep4PH+7d1q=V8AjM9YQRpRSgg@mail.gmail.com>
Subject: Re: [PATCH v2] sandbox/seunshare: fix killall() realloc and missing
 type comparison
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 8:15=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The killall() realloc() can produce an integer overflow.
> Check and handle this correctly.
>
> The killall() logic also only compares the MCS category set when
> deciding whether to kill the process. We should at least also compare
> the type to avoid incorrectly killing an unrelated process with
> the same category set (e.g. if multiple applications are independently
> assigning category sets on the same system). Check the type as well.
>
> killall() still seems error prone and I couldn't find any actual users
> of the -k/--kill option for seunshare. Can we just drop this?
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes the signedness of "i" to match its usage.
>
>  sandbox/seunshare.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)

Merged.
