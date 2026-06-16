Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B630344D88
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781637612; cv=pass; b=tif4pdRJMXWsFxYagLk7V3ekLG/Pwb5lEn2luP2YUYCkeUH4W50QZtgFmWIuQNVzbnCy9+QsDi5TEpoVRT+gRbX2NMtFENRhoyxAloOfDgtB/H9kIuk39fiS6DH2Xe0y5wGnpPvndJzdtzFuVZc2SYzovk7dbYBH7gHktGnQRLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781637612; c=relaxed/simple;
	bh=EIhxepXhx5G1O3fiUYv6dFsxMThMkoT+e1X4UrqK8hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfn+pn21HhdkFj/pck3A12oRhR1ZpNXxzKT1dH4EX3NBlip4Zbpgm1ucWuShYIxBNnVkK/gzS6F1VZVHlQZWGlsYqU1f8+5KVL8xmKnh4jKkCN7DMYIO7x06LVMdpi1lKVVXeMcH+9YKT8L3cTSqJt6jePhcRQGx5b76ApG2g2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGYvaIdw; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGYvaIdw"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36dac5d5da0so2421216a91.2
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 12:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781637610; cv=none;
        d=google.com; s=arc-20240605;
        b=jprsErve8GOcDB1DVnbiRjpgnnfXEqauab1zFFU5NWnhAnLdLtNiWw58H9p63amiNt
         jyV7NB7DZ6j7hVMtbZVjp3EoxuP4f7/RKFRFZ4okvPCHIrTbcI3PoAwk0x4HDE8gv+gk
         0VWPw93VH7lppQsq4tu2SA5g/qfOf9A2uC12KLEOKbfCmgrhJioI/MWSPcfqAL5ZnUvy
         seaXvoetcdtHF+fmdUDD5av3ZvUQ0Xr+S28gd3hNMM+KGvoWw4XqDu4GYSK+lQJY+RHk
         q5uQK/NxtggBupsu1zaraNvl/9L12hk+zr59cf5QTEymA7U7xQ5qNwPhiHy+lv3wufZg
         EG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EIhxepXhx5G1O3fiUYv6dFsxMThMkoT+e1X4UrqK8hg=;
        fh=jRyevUK2w2AHXbqDg68JL/TGkgAfqiBixLBAah9ARNM=;
        b=Ifa4ysIpHGhQfNKePj/DBQM/1I3eN1mh5bMW3oMgmy2AghL2zaN4LiNfImdLEIcXho
         U/Bl+F7iItqK1hQoEGv2lQDN5ezRYoVeppMLz29fet6s1VON67aww+Luv/NanKmuo0dA
         ldTgmwY3iTCIcqi9D5jnZP4O2vnXehsiQBVEctB+pTCgN/OD+ITgJ/Lszz8rQVaGyg+u
         S/8aTwYVRJ4lNGQlS0haB+Ko3/7zGQY7HBKsCqtyAKFPqN4JaTbpcZe+9Y6VALFZzx+h
         kPHAeE54YHZ+/93IWWZbLtPooiT5w7vIl4oQ/PDZ5cRMbXc0PVzW5q/WlYrnXmYEcM43
         ybAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781637610; x=1782242410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIhxepXhx5G1O3fiUYv6dFsxMThMkoT+e1X4UrqK8hg=;
        b=tGYvaIdwCTPYjfFp6Yo3RnmdxRE3AledUSHJeAwGRJbLv/jB/5kshdLPify6twDxH3
         zI74ooaDaM7FIp2BZCbTFC8Hb5saFTDvquS710JJxJHeQoZh0ZiWTdrvx2MNtV3fqzmN
         YX+ALmAcwiR0kc6zZf2vmQFZRvV2gzse9lYrdKaM249Xlut2LQcQ8zDJ+k9PB1g181xo
         iMeGJtUga5CwsnxivfWP1shsahr3K3PS8nBBCkKb4JlPsJAQl2OJtxjz4HBBL7hM6/jz
         E23DRbbWOCVMl7kAGtHFvxRwidzA6LdeIn7C15s4p9lc6mby8qHcOVOUpVIbADz4VkcM
         O1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781637610; x=1782242410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EIhxepXhx5G1O3fiUYv6dFsxMThMkoT+e1X4UrqK8hg=;
        b=GHmFcngW3Wm5VcAQ6Mv1yBzmgJJI9PSEIX3+MV/Zcllj2H4FWu8ycmdALlYUFmPgRU
         pysufMb3JaBU1jo2741uPuOE4Ey3uWMdcovcCRBr5myZeinfaj81ISCT7TLOClkx/M+e
         jbxO1q6BAYJzqbSNmfgVViJA8oaslu+X5P/zRvtBxAeBaRzZTchCgBnfsDCqhOV6SB5s
         7UFyTdZfMNJ2/1WGp4bkggwYz/njVxMe16JfozlPPeVN8oXFd5ouNs789Ta6stN7JY2H
         YMwz3jgBlHQSg8IeP5nY6MF0gVeJQIBTqLFVLU387XxDmz3nh5xNZ7rtIX7sLS1Iiu8J
         +0+Q==
X-Gm-Message-State: AOJu0YwRDSA5UOtKwWxOQrv1PdjGIneq9+xpPBPyXt8qz4u8hHvTLuDa
	41a7dWkc5U9pWYFpk7ZAd52KXLo3voSrY/MuT+CHoOVvvJkaw6JlCrHYlDHXlRdfTob8sBzTtoE
	QtTwVOR91Seym2GYiQL+cOqN5VnMwu0o=
X-Gm-Gg: Acq92OEJq9fuNfRpHUtl0sa93aG1X49jlY5ax7Dhj7k/O59YT9HemUkjDqOdLARveHg
	cL6O6ImMspcWEARVwMOCo//dZVvpjLlbSDsimvZ0mpS9xvpW3+c/0uOR6wIuB1Q5mc9IpxywTvi
	5lctsTTNoX8nKjFA7Ya6gXXCsDMD02SboduVquhpwgJCRhL+ZW7bAuBnw9dpSyoa8f3CeKGm7yo
	Txub1/sKKbvmThaZATqh7U1Qhi5S7NpYmVvJGpIspGG5c+vIRG+9U5uizEAI1ZZy9e/nYpIQvDS
	1WrX2ggdDmwOvXT24g==
X-Received: by 2002:a17:90b:3a05:b0:36d:649a:39f7 with SMTP id
 98e67ed59e1d1-37c936dc13bmr704934a91.22.1781637610551; Tue, 16 Jun 2026
 12:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616123816.52192-1-stephen.smalley.work@gmail.com> <CAP+JOzS-UzZvod1E1AvqqZR569MJETU1oOG=j8z83NCi-NS3rQ@mail.gmail.com>
In-Reply-To: <CAP+JOzS-UzZvod1E1AvqqZR569MJETU1oOG=j8z83NCi-NS3rQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 16 Jun 2026 15:19:58 -0400
X-Gm-Features: AVVi8CeElFbL93IbcNWdo5fEEvpAsYepOzO4OapvkZk6gnOt13qWxn1s-i8L8rE
Message-ID: <CAEjxPJ5qp=dpzonz-FpaTBt99=Gf2WJZqNG1SgAyJ6q_VBMchQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: null-terminate temporary buffer in mls_to_string
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	netliomax25-code <netliomax25@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:58=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, Jun 16, 2026 at 8:38=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > From: netliomax25-code <netliomax25@gmail.com>
> >
> > mls_to_string() allocates a temporary buffer of
> > mls_compute_context_len() + 1 bytes and fills it with
> > mls_sid_to_context(), which writes exactly mls_compute_context_len()
> > bytes and does not NUL-terminate. The buffer is then passed to
> > strcpy(), but its last byte is never set, so the copy reads past the
> > written MLS data (an uninitialized byte and then out of bounds) and
> > can write past the end of the destination buffer. Terminate the buffer
> > before the copy, matching context_to_string().
> >
> > Fixes: https://github.com/SELinuxProject/selinux/pull/527
> > Signed-off-by: Kartik Kenchi <netliomax25@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.
