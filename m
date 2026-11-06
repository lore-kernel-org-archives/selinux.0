Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993610;
	b=RCFjKuTX9x5lAhwG/ehVcYSHSbvDdi/oXQtHYNaZQTE3JOidjO9nWtjb9vNOgJMKX3MK
	 Q6C4YWcXxmT1sgSL3l1Vq5FjsMzFyTmUaOs2/68ieb6vuJYH/3zLXB3i17FKHYcLSj/FK
	 +Anz10DrawbE0feeW1KfV6siLyx4yFWCMuEXys9j7trILk9zLRC56GkUWpmnsa0tFnKUw
	 YOmXHCSxO7DLqZos7JNb3HTnHxxMEcY0NWBETrN61SKaF6kixVQ/meiOjVMsNrK0ITtVf
	 UauChujVcDDPpE1gieZ9uGhPEvt33tB7n5XGDjsdK8gs6yYA/JA4YpOXgK70gYFh7ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ik/IqQHc5Tkp8K+4oLC62Nd0bvCCzuKiw0WugIDKiOU=;
	b=o3831hxnTRHDu/DnIgrxtBZjNLNr46wxq5A2aRjuLxaOl64ApNUHMyyVO+U1Jj8wOhKZ
	 4NViKEMP9rmG6W5j4WzR/vl8htW9DklH3UJKrpWMoNgrqYmCP67r8mFgCUzGBjZl1Wyc+
	 h+E2E+29YEqZOoHJx47Oi+yfRwdlKx9vCMMYIygu52OR+sKvM3lNmf0OxTFao1hu1MYsq
	 c81rb5yZORpyzfzoSYhoGWysGBAv8LwnO87GTv3c0XueZaKlqUjD2mGKyj9AVdr8TAQam
	 SLXMjOhiA6GjPRZWkhCuziYrQWsRiFd9CtGLrH8dkPikURnVPVxLkOB2qbYNUSFyK6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uuFaq05R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360F606A329
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 19:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3360F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uuFaq05R
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b312be5de8so9843927b3.2
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 11:33:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793993609; cv=none;
        d=google.com; s=arc-20260327;
        b=QGLsgzqUw6Mhz3mTYTrSTJcz2uBwHPvTHG3GFKvnIMcHouPogZWCcI7Sd1MvCJM7OH
         kaj4sO+YxfJnFgglTx1QGANBIzTxAj+T+/oX6U4idqp74w34l0z57iVppfJOuXAB125L
         HjJuEwOMf6U/SHX/NAjLsZXSsrut3EWceF2di/26nJUrF8wh1PDmnlYqtTpkkD47uWzM
         Ev46ulZjTekpC405iN7UdtSpaZ/l5VcL6W66snE9jNuTwqEEswhIWMjbygcFjBRpF7nf
         odyZJzsadYuOfkFlBs0dBfiv+zjiMBYz3C59OSLYrsbg6ALTrprqks7g+IRHEkrCzvc6
         DZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ik/IqQHc5Tkp8K+4oLC62Nd0bvCCzuKiw0WugIDKiOU=;
        fh=6ukFSrvF76AQcoFTaTVTCq+q3hg10Iykt9cHjSUbAks=;
        b=RPzhqA/bJ7DnDo3HIRlIMZ1yhafU4Xge8M2Jaw5s9Mfv48360zFSUBU6dnhzg0KR1j
         UfSZWKD0OoqMASXB4/bUDdGG6ffASLWOnYRIsfnfR3ZcZqTQWrl5PDUOtGd14v2G2FNr
         R49LtvKSBAo8WypvZZVxfO5ZOIqcI6//qFZYO3XTeQM+WSrnq//XlO8kVsF2if+FzpdU
         me7fKThAknuq7BFJD/anCWMtJNmj0ZtexSm22XWfsuAoFrVfbI+TJhqXJHjIly7AUuHs
         upFz1WnJystgOCqZiEuZIbB5gUol44vWCdJU+vdMqTXiGStCISBpCms1fRNMicEa5i0y
         RG5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793993609; x=1794598409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ik/IqQHc5Tkp8K+4oLC62Nd0bvCCzuKiw0WugIDKiOU=;
        b=uuFaq05R7u2epUDQM9WboaYMhC9I7Vx9MAZXFa1HW0Q6ZwfyapQaZ1Arf0xUWuXxRI
         sXx8GFRlf8AW6uAyjGoW1s7Lx4UkvRuN1YVJl3V4zoc87q5VoqU8yyHyFv+KFDKc+90Z
         JJHAxhxQIO+9haXXxsO3+OK5LT9x6yojBOL36LMpmSmqSuBwsOQu3lVxASebHyX1mPyj
         glrHqi4ikw755Fxo6DIUEj4mk0Y+lI0nqyw5D1xo8ZDATivCaCK1kwGsTfExFA38JC7G
         9NS7M3WXSzPcInunpwP+MeydNtAcFy8FLLrzBwRIbXqN5zDM4fpFI2fQNb01nIqTp8KK
         CW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993609; x=1794598409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ik/IqQHc5Tkp8K+4oLC62Nd0bvCCzuKiw0WugIDKiOU=;
        b=R+J5ZgPk/BKVg4K+x4HMGdMGlF4nkJC2tv+WPV0ubNug0JY6HeHh8ADRDtJAlMG3Jc
         9uQWbRoXRa0KvhjB3bOfsrNzi+WNcHzsb1C0wml6m+5QdOMo3dkvEGKknycBuNTQ3klZ
         ugQbEjDRXBf3W/PpcuEI7+U2KZmTvdeTFMxhm/voKoPh5UlzFAXVqQFjRjJuTapo9DTC
         2rPgW0fUfpmL0EfeEz6oqJOlH9Hm6/iY5DzGez7KL1tCKiEghV0lo2yXT7ILowW9Lv8q
         U0vjOS6WQvNqwxqwIPRWU1mezuxaUSHJWz25kJzvBlPj92YiAVIffeRVkpKJH2L8NrFJ
         4BRg==
X-Gm-Message-State: APuU4Z9ck9apd79aoLQru7omXaP/mMDHijnxKpIIXHzU5GdjLLOkl80h
	tUvVMcnyFck4a4tekng80Piiqf8m0tTK/+Npp9iUMuxbd1YtYqoaI1DKDdD8ydTykVXdx/uwPsI
	DO3M6UtkF2XM2yRdOfVrUfY/G3HJwHws=
X-Gm-Gg: AYBFou1VG37Fz1NHeT8Yd8sIM0l9blTYFDqYJNhNj+vmkfGzEHV9fz6QKvNYwxpITxe
	CeoihyvyDvAgk1zLsXIDTUvvhs03YLzhYkTe5O0uigWIpWkhUCChboJbIY/L6lHoVlhKVLg6FZv
	awcBvtnPvhPe5L79LOq7zTu4pQE3F3Y8GKfI/UkSn1B93ivNvyJCjk59B9AXfTEbZQ7+4hKK31y
	fsjwYjXssSGz3ZAkZYpHR+zS4gDJKF9tdHq4qVD6dZZh0Xj0AqlWiiW2wtCL4JOHqQSviJZADTl
	oGQU3HhOrt27MIRnJCACaxmdH0ZvLDx/N1IofbPzaJh8LmUUDHdHYje9+rMkNLBBTlMLmbRkNdc
	RwzcXowVNtArdxDkRsNQTh3q3nraUnkTJnS04tIKxh3hYDQ21swivQq3cXtI1WboBC86vmBM0Jl
	NuUyGrHabIlzRIRVF7+m1vwV7YZtenCNZCg6p3SVTWqoIbeleUwtLij/uf7w==
X-Received: by 2002:a05:690c:3481:b0:8b3:46b4:8f74 with SMTP id
 00721157ae682-8b346b48ffbmr12817987b3.102.1793993609242; Fri, 06 Nov 2026
 11:33:29 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106123510.76727-1-cgoettsche@seltendoof.de> <20261106123510.76727-16-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-16-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 6 Nov 2026 14:33:18 -0500
X-Gm-Features: AclHuK8J30CfVES2gvoYMke1G2nBHWko_S8ddor9FyB1PQ4VF8QHYFDLG5lprrE
Message-ID: <CAEjxPJ66DMfY2VqHT5hFG7Eq6XCPaOfxVMO+-CejNM++qCx+aA@mail.gmail.com>
Subject: Re: [PATCH 01/16] libselinux: correct realpath_not_final() buffer
 size documentation
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:35=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> realpath_not_final() checks the combined length of the resolved parent,
> final component, separator and terminating NUL against PATH_MAX. A buffer
> of PATH_MAX bytes is therefore sufficient, as for realpath().
>
> Correct the public header's PATH_MAX + 1 requirement and fix the grammar
> of the surrounding comment.
>
> Reported-by: Petr Lautrbach <plautrba@redhat.com>
> Link: https://lore.kernel.org/selinux/87czpkacxf.fsf@redhat.com/
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
