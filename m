Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C76387378
	for <selinux@vger.kernel.org>; Mon,  3 Aug 2026 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788429; cv=pass; b=KZQ3uuCPHf0UHtR2YqUvfGjhonQHzk7hhBQ9x0RA0QBk3VeHW+xIZIx0utRWsdikjttU+yvun0zan13mrSXNp6QF7Qh4sH2/+uOG9yTBRbD4bwk1d87OwBB/dgEU6Pm4ukxkQs3ZUUOA5Gmh0aNbig6Q29cnD1frnza4LrSTxcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788429; c=relaxed/simple;
	bh=zzhLyBm1f8zFoltgC+05YytWSG/NApl72oJRNlnkR18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCQj6znYS5vQlqM6oIeLpdu92I5WLo0997EBhhqDayjPD1dRitDoh1dybprH83S8YLku4opr9h4EFT+dp8AdVtUk7A/FPIvYvj8o+8Jb3sTXSuwiuGrv0KDtpEfpYbu1sDeT6sK5foPuerp4Ij8hl0jpk4YqQ0KCpHpKgepRj3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLHK/3Ga; arc=pass smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLHK/3Ga"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6ae542c486eso905611eaf.0
        for <selinux@vger.kernel.org>; Mon, 03 Aug 2026 13:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785788424; cv=none;
        d=google.com; s=arc-20260327;
        b=E891WL2FHXY2fEPBLJQfHUO6S2uTG0MA7EXXyJ+4NHn9+hGrN0e0JMlriTgrgxuEUF
         YhR8RB2Iodn+bEOTOvoZtg5n+eP/8tN761Xq8UnHR9jxOkWjaEfac/JapqJ6pfp6yp4I
         ZxD/v4qSOYRZhgYvhbbNe+XT9PmaAf769AxAi9sw7YQK0u18TdMaFk2nwsRE7jOayl7P
         awx4tboxF5WoJ3eLmqf9KUFe2iK6RI9arB22bD5McyrDivAZCVgDUfgEeFfUkBPtQIS6
         mirMci0xbdsGRulcVebf2ILQ8fX6bVX5Mt/jtjkTY/xRtW0enLpUeWfpZGI6U1Vz0flv
         HxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zzhLyBm1f8zFoltgC+05YytWSG/NApl72oJRNlnkR18=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=RymNlPYQK7tWyO3ZERiyijcP9iGOxuX9efKPTrRAtdqNylqeMTWzYVGMd5pkUnHf7R
         ltcvGQF5AmNnPNZs9cHmnTf3AQivVKsRFJ5FAT1skvJfH1SZkYigfrkS41+AukFFsLqR
         tsNKDAgWkutsBZYMLMVRcCtQU1DmzPrzTPiTdirNpVfqO7/M+vQfBTRfX5o67W7ccnUa
         LCdMU1aT91oGuh+UOz51rtemJpa0H714EobYu/jZwo4rL7aJUk6TFyeHMC1Ss+f/Zpn/
         KeQBsP4zVhq8Gbg/b0pdBFVILuJQfq3Xm4SyydJ/rJf1FkSD3tFiq+/eQ15d59PwNyco
         J0Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785788424; x=1786393224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zzhLyBm1f8zFoltgC+05YytWSG/NApl72oJRNlnkR18=;
        b=dLHK/3Ga/xYzHDkZIRVG2pGy7AoGbAprr6U44ckxyHTy47VPH13de5nsjM+GFiKju2
         HRJ6Y+ozibXIG1+saGybj1HgWKn/r65rNuChkSvNHMLLTvu7+DLlDXDe1a6INhsZFLGu
         e83LcjYnXXwq5XU/TjEnW4+ArWePsANRCgjd5fn9QtefNCTqAwVIK48ZO1JZvKmAQlvJ
         bw8P/Y6qfwLzjKb7AjhY7+5mMwMxP0btopsikHsHRuBROMcA49x3kxTOyDKFkv95/fY1
         IaB2qECw/G4kSCPezoXDY5wBB4gR6Yz2X3Chvxmya+smCfSVyvRf06j8uKm9zOKyvNyL
         R+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785788424; x=1786393224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zzhLyBm1f8zFoltgC+05YytWSG/NApl72oJRNlnkR18=;
        b=IFc1STJhg2+7m5UEciDyd1GBcgu+NLjVlriGBWT6SD7311m1HvuL9qwjNyr5IsE3U+
         lbBFfxCSUBpff1NyiFhyjcm0URNgDRJxML+HKVgK4Wo9w0ZWHc6wujQP9q0ftZVXPoQ1
         VtBXWfsJs/O2tfy4t9TxvWg5aTfZ+ejrdDbFmxl1NZiYXkxZhPMZ1BU4LfEg7bhXS7PZ
         Fs0/BU4xIKPSbIyckYXcCUpESQAr7mxtsyloENLyHLZUAIH1RIZCrsU8yhPvq11BYDAd
         /4Q/TzAIRN32s2JzJre5PyKwAHNx59SMxXOm1WV/vChOZ+5YmjFVIsw0NQQIXA4Gok6K
         zH+g==
X-Gm-Message-State: AOJu0YwqjGrUPChRDfe28o6hG3fk7reQFwPU3vF3LGxHkOHHsGI2TcUs
	M54zQ5rvAWlQ0C5zO+7y+O1DAHW4abHaCXv9v801beRPl/01mq23jFllUSol7NQigP3jbDuRZJ9
	fqZUJMxPLtA8yxRVOBblVzpQkpvGbPL4=
X-Gm-Gg: AR+sD102Is+1doyv32ZpnYPRvmXdJe499FBjyDakbIjDf1VimXR9V63GGzbpuOfkinz
	BMaADifDvKPtdP7KoQS0ReTQjN+7b/OZyXDtLt/X/BtU9C6pBJe7n2FSHa27R6Xa5p9EUM0RvaM
	QNdpINkG8yhI4aN6c1zdfssysaNkjHw3OSCVFB9jNBp8IAVeJTRM5ChTxujKym2zb8TH1o+HGjt
	CsNOQhDv7kOHtIfYlKQZ1ZRKoXwu3A/VY9gYZ+BH0tuSdnRCAFG1CZPEYl3gyX1dPuS5ZAwedOj
	y8vCMtYu4Xw44jToaEcWVA0m249bpo7Kae6TLKbmsTgF
X-Received: by 2002:a05:6820:629:b0:6a1:7181:6da1 with SMTP id
 006d021491bc7-6ae432bcf78mr13482985eaf.18.1785788424402; Mon, 03 Aug 2026
 13:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803142359.44099-1-stephen.smalley.work@gmail.com> <CAP+JOzQ5n-5S4BpMfZD7d7jWQZw6fw4iON6oV+dboc==+mibCg@mail.gmail.com>
In-Reply-To: <CAP+JOzQ5n-5S4BpMfZD7d7jWQZw6fw4iON6oV+dboc==+mibCg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 3 Aug 2026 16:20:13 -0400
X-Gm-Features: AUfX_mzNsq5dUGC7gtBEPYzwrbJTrhKSpdTe9jgb4hi9G163oHj8QHanCIkIqKc
Message-ID: <CAEjxPJ6p4emrduECq2fK6Dp1GV3xpEKnJh-7L8f8E2P0zh=QjQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Cap max depth and processed nodes for cil_tree_walk()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 11:12=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Aug 3, 2026 at 10:24=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Cap the max tree depth and number of processed nodes for
> > cil_tree_walk() to avoid stack overflows and OOM conditions.
> >
> > Reported-by: oss-fuzz (issue 471608794)
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
