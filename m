Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241385;
	b=YSYTY11xda4RHeOG2hW2ky+gKqoED9ul8hYWZp4S/ZfeUz455+3YWfaXFt8vxfIGEReJ
	 cev6KQBZjYu0w+6YdF6sbM1axueXlED6bQDrfPtUW2WVDIJ/F/A66ND1lo9ReRgKhtm6p
	 Fc+7IdZxmNfO+13CBB9oNjtVfnqiHpLpsGkZM/74oCEKkUdSn+9UYw+XcI3JH5Tm9c3dx
	 IYM51DDPdc5tEeWWhpVaHX9klTPBbxy/MowaeZVqckPnCLQNdpQI3NwlmXaeDjHPRF0Yv
	 HxyTCZYtHGvUQiH7jEx+MR5S1ujdF03oAdkiUugX6Wnm+WrDUDAtR28qONnbfdvQGyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=29Om+SZxSf7CUAJuJWoZmBHis+AiQb7fsDQ1amzGs3Q=;
	b=LBqtxr48wtQgW91Cnb4j4nYz7UtEbZhXKNn4MuJkCSzKu1yI04YNNLaj1OI3CMHu08P1
	 H4vBRbxVOA99w3rJHv3MFpAOW1Top3WF8ldRbljEC8N+mzhTajtAdao8UzNbiLhSCG/zQ
	 /3b1B5hpR40PJVa2fhJWZ3QN+eB+NjMOvc0HkSf1NNT35pl+gn8h4tlsTxmunN4V6YEem
	 b1TAqcG7R31XXeDn5u2WJcvQbk91sMFdYOS6mNIgD6iNTXTrRxyPH3rL1NrOXevICJvPy
	 n5N4+Z9/0HImrQWXM/g/rq6OCYXxRrjcFsz01QIKYuG2r8GEVw6uKmVYEhVGdIs1fig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cp+aOHbP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5681606A31C
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5681606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Cp+aOHbP
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67be1e468a8so649059d50.0
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 08:23:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241384; cv=none;
        d=google.com; s=arc-20260327;
        b=gkvQykgJMP+cUnt9tm+PowaVZWMyomWM5eYEaywqJdzzfMW9YpSgXYWOzQxtoWngV0
         DzENlCt3xDnOrkSqDp4EfVtAU6cy1p1IVGlbt3mdokj8ml38mAfquX3C/HK/tgoz5185
         UqUR0NPF1w5e4hOPwq5J9Htx4YW3DFfnYiqznTdTORDxXzBdOZKd6Uv1HmCt5bsGDzpW
         +6WKxNxS7PehMECjE9N1ZO1fBDPikR+bOWVx/UTM9WMXoj4uyiHIzNot7iwDkF9MpCnP
         B6AO36OQMQdNfofPUC5I5cGI4wJjJaiPT8b6cZuXHSrt9dEgffya8sK7VjxkUeugrvbc
         TUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=29Om+SZxSf7CUAJuJWoZmBHis+AiQb7fsDQ1amzGs3Q=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=riBGUYjnYCftkMgCRoS6SuZGVjPJ4ZRPFtSAPNuwKAFwGEiCR7LvOYmsVlGrrLtdW/
         n+3T023tujULB4i8hUB02OZe8RYHtF3KbtdkUiRwq0fZxPS5pq4rGtT2dU4fQGOjzEV9
         IwIlavmes4bWQaWBE5lXdIgFbmJePN5ZFE4G9yumA7jnnk3BPwAbjZH21eyeMWwbgTsj
         UcTHE1FvAtgAb2Yp1iIGoBQRNZIUhnajfTv4jBFxdDLvxaohAJ0JyIct78YoiBWqQd41
         u8m4zj+60CL5SVQwDSWLARu2dP4oy0NtOH8jPnxzxomVOTDJhczZSbIbLjaNH6T4uOqo
         Zn/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241384; x=1794846184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=29Om+SZxSf7CUAJuJWoZmBHis+AiQb7fsDQ1amzGs3Q=;
        b=Cp+aOHbPrR1LrqaQqk11IpxhA1fYuIbMuJqHt/rP612HayknAuY68ViFnzieY1yVJG
         iOMKuMKU2uuCNeHzppRPfbZvBJTMmbo7kvtmN8LzIH3WNdpFs3BIYzS4mXs2wCE2hHqK
         fsS3p3jhrn/vd1ifSfYb7zbOewY0i9db5clVLEtso40L23Y+Y8Ldx5xRl+DAVowx1IQ6
         qf/Pe6t+m0iq0GTW44TcrIFWREVAEfGokTJy7CCs2t/Eb6m2QoWB6ApKXo4+uGgkEyiz
         kQp9k+SetEs5E4wfe/WfBrjbtHJdhH16mgN4hw34BzplpM6NlMGHpIBLG1bKoDXOdolE
         IK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241384; x=1794846184;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=29Om+SZxSf7CUAJuJWoZmBHis+AiQb7fsDQ1amzGs3Q=;
        b=pDC3K4/O4y3ushp29Ob3BLuICVBGodWnpaqbuKyQO14qgh5hXXtT1B5+DwRfHe6Wci
         XFwFPYOT7+yx1RVxlE4KeFNVDei5qb8TlWpdheUhyx0FWue08KAme4UZM1VkpnXbNNak
         OE+ce/CH8+3fcG1OsYzzpBKKpH8ZrDeq1UVZ6T0N119p4MMx18lC0FkxmAPnkRY7VNeA
         WkaYjPv5dWFdOHohad5bPSH7add6CYgOUZ6RUTGqwwkolvUOR0B4bd5xHQUJztd4AsMA
         /PpfE221Mx97kNbBuVgpQT77SI6evIEkCaa9SRtrgg49zQf098qoEhyqf9z5KCch01on
         /ZHw==
X-Gm-Message-State: APuU4Z9siCU6BmJnLgmG3tbdgf32yS5oWkwFIGpBdErw9GFAajXf1D5P
	coT4pTMSJQiLihObnq5/zND0+Uajq9YcAJpgIRym0cJEHVD1lbiUW/R+7Z+FmoslcRxu7/sO7if
	hxo1Rza2Ct/yCd0jHXM37z/kZnuLbUrgYmXd5
X-Gm-Gg: AYBFou1v21YKHA7yA7FipFnF9d1ycBvNETD9h39xyREfhzLPUQaSCz/1JmoxD7Hmdjg
	AtelXpF6/35/lTBxOpmeBnblnV7gDEFwfTIIuxu2QHUIE0UNBy8K/qMNgiig5fNK0xJN9lkf1Sm
	GfQGtZ8ubGfh6XEUv/40FI5Ww2ieBxj9o1al7VyXMI4RB+8XDNVELrlUy55m0geTHb7E9842OYB
	eRxPQEfUCrwyx+HPtbU3cYlTP7C/qnhij0R5ECSa7RACOmjHJLzwKysJG56eOb7aIaeZQgvTEpk
	MNjHRJe9xDO9W5f/MazzD5EQhKM4lWvTf7YIOOb9VcqpeBaP6T77Cei5zsG1s+EEJ9jvjpyqXZB
	p7wdxvMp3B0q9+Kosola3TaSUluZXV5g/q8ckYbu0Fnnx2Ew2GkXndYho4BNiORpighjBkn+yUe
	vD+alZXFy7J69NNBR4AwUXeldKKfZtE5kYEPPYcaBewt4pVlLsnSBG2u41jg==
X-Received: by 2002:a05:690e:4887:20b0:677:cff5:52ba with SMTP id
 956f58d0204a3-67c567d35f6mr42775d50.21.1794241383657; Mon, 09 Nov 2026
 08:23:03 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106131652.267648-1-cgoettsche@seltendoof.de>
 <20261106131652.267648-2-cgoettsche@seltendoof.de> <CAEjxPJ4ZFQODYcHX2yauU1AKjWd8qqomOt7-Bat1OC7e3wO4aw@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ZFQODYcHX2yauU1AKjWd8qqomOt7-Bat1OC7e3wO4aw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 11:22:52 -0500
X-Gm-Features: AclHuK--SD1froXjwic6l2Pvs7Wtq4GLnoFRGMQbAOn5ZHw1phGcKw97NHJ9rjY
Message-ID: <CAEjxPJ7Vv-cQJ3MgUbU1PDmNke4iRv4Fs0TauC78S0HVyvOXUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] python/semanage: fix permissive add with bytes module bindings
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 3:09=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Nov 6, 2026 at 8:17=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Commit 82c7c876 ("libsemanage: treat module data as bytes in the Python
> > bindings") changed the Python signature of semanage_module_install() to
> > take the module data as a single bytes-like object, but
> > permissiveRecords.add() still passes a str plus an explicit length.
> > Every `semanage permissive -a TYPE` therefore fails with:
> >
> >     TypeError: semanage_module_install() takes 4 arguments but 5 were g=
iven
> >
> > Pass the CIL text encoded as UTF-8 and drop the length argument.
> >
> > Add a test that drives permissiveRecords.add()/delete() against a
> > private, throw-away policy store, so the call is checked against the
> > real bindings without needing root or an SELinux enabled system.
> >
> > Assisted-by: Claude:claude-5.5-opus
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged along with several fixes needed to
successfully run these tests both locally and in the CI
infrastructure.
