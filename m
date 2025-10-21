Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC672494FF
	for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054450; cv=none; b=pNFItpq2GPU4IRWALf1PmPjEBAUcUV+qaz93sEgM6TqI4AoHnWHAyRFatMV7tn2ycIB7RJFFcDpyhUIZzEsAQvPdB7krLqnI5iY1MAKybLmFIezVJO6BulmGOFiDEgEdDskiNF49UZITLNTfMaN0SZnHKDgcUAFvd/2REe8wSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054450; c=relaxed/simple;
	bh=Rn5LgQcSTy5eOyDCilmrvVM7qGkyeUMf0AHntJpMYlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAA+PZjcSfpYqaZYuffohnJs2l/tcvu1egl8SVq0RrxFrvIjII/Hj2eVS9Qs+l4gWyAhs4FMsWZsd8V1P5oxRat577o2DK3STZy7vYqyyvpyTdJK+yi0W/imWbt6EhjPeHGHfa7si6EL87FUJzfXDoATLvnVhOpLasHUohruR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1EaO4nK; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1EaO4nK"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33d896debe5so3403745a91.0
        for <selinux@vger.kernel.org>; Tue, 21 Oct 2025 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761054448; x=1761659248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rn5LgQcSTy5eOyDCilmrvVM7qGkyeUMf0AHntJpMYlY=;
        b=U1EaO4nKbP7jHraLoJEVU5grlWxl1ffKdWsU9SFMdNTbCuS7kvpCU9Y9QnmXOAWu4E
         KgjVGzAHQwIx6NAOhlr95w6JaOXNlKn3BIIcYrNh2Sn2LGS+RiCuv4a4Z+VKFG/MB16d
         10okzY9OnchXQ4cdw0CX2u3MYFJFGBzAn2Unp0MhmGdzzirutYluBpIlJAlvXYL71vht
         QGkfXUPkPPPfQpnYzUn9ryiX9VBAgupGq4OO/kzVABCncvkcDWCpY7ssuyHSlRvfM189
         rmW9EJRGwlbACdqeuQA5Y1kMiuzKBrtA0NozMAj4CyJL7G7o+G1YHRVc7J6BYOfer2dE
         PC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054448; x=1761659248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rn5LgQcSTy5eOyDCilmrvVM7qGkyeUMf0AHntJpMYlY=;
        b=Dj2bb+p+o8eDlnnvo6tpqXPh8IS2NQBKjNG+cEiCyTukkC7vpdTxcUfaXILBPTQfIt
         YzVH0lUX7cHqtEzdLf/3KgfIVEdvbRpSF3EQWa1GursG9ri1HrolPE5npIVqPJtxBLde
         DP0/iXVylkOV4KKP+5RkVpqCDQzbEd1EW4FJDRmrBwMD29zfGEUqrn+M49FKw2PTLVO3
         mXOj+d9CWT0AB7JVtloVUTEJX6dZNkcGFN1hLwhtbdLAHOsiwmy+EDd3wCPBUssrgJYa
         sWN3rbgHOeHs+FH55m6svWKdLz2wULeEEmCyDnClDO8U9fDdm9iqwYnmsmFBOwFdRTCO
         oTwA==
X-Gm-Message-State: AOJu0Yy3pfFanlEfvZQNvxBXmR8xbK1IOgigbLgiVbgdt2vZeK+x9l3e
	p9eQasZ8JChizwuIQKMgZt5S+q7g+hYFuatUeeeoWe/JsDpJsYiEkLTzlkurVngAM0RTD1WtaQb
	X4KT5LnHYtJiwTfmPxwR+DOSDJtCfY7cG1A==
X-Gm-Gg: ASbGnct/Z6JgQhmzac5XCPYI8MzktSmSE0N2ITf3/trJeZ7Y9TJs97X1N27fNKLbM1Z
	IlXvP4boKwhk/1U2eHhavcXzT3ZVbdojpQch3opGkgEOHHXwedrluLBetCzpLExr5V1GHx7Y/8w
	6cKZ8BerWLpQkh78MnmYfgHsyGO33tI5hfqpbXh4dy+44lfomZT9LLZo8kMwOQLquu0iSJcg8K4
	ODAZkYhMP/b9d/4i2Hr2Uk9dWFuPM2z6MkG7zZ1V/qNWXL7B05tqqZSMWu8
X-Google-Smtp-Source: AGHT+IGQqZNST5/Ab1FJwSg9Jwz4urg3cdpHy5rOm8Pt10VBpGISjT5iMxsk1UEQp7p9njPJSTRhezeXdLih2uxshvI=
X-Received: by 2002:a17:90b:28c4:b0:32e:38b0:15f4 with SMTP id
 98e67ed59e1d1-33bcf86bf50mr23019097a91.7.1761054448127; Tue, 21 Oct 2025
 06:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018062741.57106-1-nvraxn@gmail.com> <CAEjxPJ7AgnNUL4gZ2=tOM60nXsZAgWAo3Yhu=34xvLX1DWt8EA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7AgnNUL4gZ2=tOM60nXsZAgWAo3Yhu=34xvLX1DWt8EA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Oct 2025 09:47:17 -0400
X-Gm-Features: AS18NWAKLWUTxkPn84SxO6DaxUNeFK1K2vsLwUDalHk9HMR00WyT_ugB7JwvAGE
Message-ID: <CAEjxPJ5hzaNkxHf5cD00Ap7SMiBDjxR2S8FhhnVGLpwsvWVtFQ@mail.gmail.com>
Subject: Re: [PATCH] add an editorconfig file
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 10:01=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Sat, Oct 18, 2025 at 2:29=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> w=
rote:
> >
> > editorconfig is a standardised way to configure editors for a project.
> > Based off the Linux kernel .editorconfig file.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
