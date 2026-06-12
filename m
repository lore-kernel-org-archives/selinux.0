Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5392C2E63C
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781272654; cv=pass; b=uVRpsdUsg6V/Dwkxj4GUFql3g/2n3UoTmWIRuL+r6Ebc5cMDUYCIrc0IQVRbK3HfBZrCaLaWcaECFJf8s0w53xxK9ntjbZua6GmLeMNYHLW/4/oeEO/rtJ6MXX/Lgdu3aKjcS7iR9nSo60hZ6qufGOE30+EYNqtWesYZ8zwbb1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781272654; c=relaxed/simple;
	bh=isRqkuFy20Va2JWUPOeAKuOX/PhSBTbwQpp7wQOrTRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmeWHjnjjnJPREmxqyN+uKP9dZ5olky+iie68kuP8VH8hMyVThWheWpdAgYeBxgWVaM48QYCqg8+2FxJsWUsx9L/3+5DT6JcwvnqHDzYMcZcsARzyhMKkTBBfshrgDV/a9zl344mCojYC1s7SfJyWfiEc4p+GHnpn9Ws1Xv0WtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHk8l2yh; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHk8l2yh"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-842319576d5so623651b3a.1
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 06:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781272653; cv=none;
        d=google.com; s=arc-20240605;
        b=g4qm3TOWZsqnrLZ58jDC3xeJlD48PZ0jDp4FLETUgOF2uhO0c2M44RKcY2PEYj3+nv
         UFE30qnOcxioBPVgRnqa8qREY5cVuSRBL9H62+CQJCoYx7me2yMF17ZjkVGfCRXx2PBV
         dXiY9BUtOFfbx7LUTgx4JuvwBrO9h18TiIIInFlMGI7cEXR5vcLXaaRSmAiuZPxaWhRE
         E8vwzqrJpax0u8nkmnkF3h2cS+V4ef7ktP8O0m0iHVr4YBwQsKXeuH19S8nC3X+XWsJz
         sgLSt0uQ9uV2VA43z9BYVrtc9H6Lsr3i7XKFqaCNjtLyqnbvrsyQF+xacQ7abU5kd2jj
         LDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=isRqkuFy20Va2JWUPOeAKuOX/PhSBTbwQpp7wQOrTRU=;
        fh=Br7Q3QYCCAjnvhHaund9vV2LCS9SOjHrWaBcZeLdftU=;
        b=OIrpPeXGYVmrPrewi4276mtSUTDCrGZ4acFskwnwMK8yZLqbyFjTdzc139dRJiK0jr
         jRW7kdTApJxyAKXVDonItrOMHkmet2QZEpb4KmzTj/1NOZWI45F2pFZp675zPhknn/Aq
         zAeXmxEg71mYPUB3mNMPiFJw4aYNVXkLLICTRAsXXzITh2ySi5FvqSmEdFwH+2tAhT3q
         PWXItEnPHFacQ6o+D4AIetXfgxTaeuaqFTIkghXisO+KdI83AaNbZ5CzJUdf8qqpggqZ
         Uhi5ZTE3rZ6UG9Yvo4XyjmSehFAWwYEKt8K/Wg48Qr53hTeCuuel8ZGAxPGEeViu3Aa7
         EDXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781272653; x=1781877453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isRqkuFy20Va2JWUPOeAKuOX/PhSBTbwQpp7wQOrTRU=;
        b=JHk8l2yhdpyYZcapSvcckTIdRcNcWrojO0SiVAHAxWi3LgY1LARd4WVN/R5AS5hYIx
         8uGlA+DTUntHMpwRLioP5zn1dn2pMNVxAQ7EHnRkCuiySBt92OrSW2WgwxpZKqdA5NQq
         /g5F5bJ+dXxVnx/fcYT+wJYnT1+lY6qvydlCc3blh6N4zRkoEIkwWF+MUrMQH7W5BCBi
         V/SqaaJiid58Q0p0JZxb6DBZu6dRvTJW4uvtJvS/6z1CEg7M20LIBHoFloe2MQsTt+Qb
         t9caxMy1h5b9coJT75WmMY+iG4aRRHHMU8ELYxgOHoOOXQznWa2LPb0DTDq2TG+CEYEP
         gjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781272653; x=1781877453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=isRqkuFy20Va2JWUPOeAKuOX/PhSBTbwQpp7wQOrTRU=;
        b=hqb4uKuRhdXUz7u9CtbzA7AqUb/kcg0eGY/TmC26yj/s6gVTzW1nZwn6/lm/nm2Rnp
         UkaMkS/G0K+Tr+1EezolvNeAt6MyfsyTFsZ7n7qs4h+t5lpxILv7NN4j/L8DAD3jMZMy
         2yAeYdsj0WTPGBV1BBQESmlgOk5Fr6TYFUEO0je7uDERgZ7iIFwC3i+1ieQKK6k2RDj4
         6ztu+nW0ZWzqWelfPxsydamzvC8g9q6l/8YaZCuAoeCZ4SGxj6aGwocuG1U7HO4Ew1Kt
         hnighm07P4WjjbIH70xMrPzGyNQsWvp+Kw67zNYV/klqaaYxXpzVP/tYZFs4IUFCUdfR
         Kgcg==
X-Gm-Message-State: AOJu0Yxtem3ui1tS875wQGr+luIbkXVPr7nbB13N0eduAWOUMzZWQbye
	PtyDpY0TRugxCnBVWJXPEHm7+S8lm9jRs3kRRCOw1u2INxwBkS3rKu/ZBEQHim8RPXRhpjfyjJS
	V5ANKLYP++6hwR0EEBO3nRh4bryd8rJVb5g==
X-Gm-Gg: Acq92OEjmjIGkl82+dco+hnYkqauMZtheY01Nypnl2S22ZAfOIgp8Aj3CQBhW/iw5o4
	bpyeiYIrZPTE1sLnh0WwjnqFgEdCBRGrPbsmmYFy7bYP2GsK2dek2X9+4rzAElH6D5UQaYHJtIq
	UKZSbEJOznvAFpjm+N7UAEBwHAYJPeBiL3g6mv3oZwin9y5voC9L9fVCDF0tF+D94D4Dix4pNmX
	e2o7XoTkS+ibAk7ZJpqhnxMZyNK4h8Zqq2m9ETGJKrVTjIeOryprPb0ZmfLr2j1RRvKLZJ2OvQl
	irnUxpY=
X-Received: by 2002:a05:6a00:9aa:b0:82c:d6d3:3190 with SMTP id
 d2e1a72fcca58-8434d0cef5bmr3370799b3a.38.1781272652654; Fri, 12 Jun 2026
 06:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610203137.411393-1-chpebeni@linux.microsoft.com>
 <20260610203137.411393-2-chpebeni@linux.microsoft.com> <CAEjxPJ5J4zaWskh3NO7Vm1KLHUudEB_Jsg-DSTM5RU0_-RVHFA@mail.gmail.com>
In-Reply-To: <CAEjxPJ5J4zaWskh3NO7Vm1KLHUudEB_Jsg-DSTM5RU0_-RVHFA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 12 Jun 2026 09:57:21 -0400
X-Gm-Features: AVVi8CdXgcGSlyNaspjOuj_QoNy8c5kja1xqlUcGu7I5P3cNPCEo_x9qDe7nYQ0
Message-ID: <CAEjxPJ5BHL5zxs7x2prdoe5yaN0N452V71KGxG_g+dsie3S8tw@mail.gmail.com>
Subject: Re: [PATCH 2/2] CI: Add explicit output variable for build-userspace action.
To: Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 9:23=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jun 10, 2026 at 4:31=E2=80=AFPM Chris PeBenito
> <chpebeni@linux.microsoft.com> wrote:
> >
> > Downstream users won't have to rely on DESTDIR being set in the environ=
ment.
> >
> > Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

These are both merged.
