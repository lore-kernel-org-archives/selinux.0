Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794241032;
	b=sqgxs4Dy8MtWlig5JgDSTYQDcBp+WNTl852VN/6Io+tZJw85CIVpJEnAKoIv5wKQViZd
	 daE8Cb65cUfuY6okQZy5I2Bkcfo8eDK6O7BtWd6adJqn2GbxqW02fP53sFrwK+PczH3JQ
	 Spa0CEsmwpxy7E2zW+AlAH9v4e80CQOgE3SS1Zqy3MOL5jJ7SVRYMeJWCQP4neMdvSHfW
	 6VPO8N0Kqy4Ji69v3JfipDZuBhm2pq1QuKY2FTm9IEyVF3WDY7yLdRs0lplaqx01VzDRn
	 cksC9VZnrGoW9vC7R4RlPM/knI/AL0KWxvvgvcQQQK6ylUmqtKlqPr+fIx4nPqBIjdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=lKkksaEQ2WKMPH8UcQDrIXPA5IBmaeoJOm8yk0Cbuw0=;
	b=GkZCh+2Js4aZIuCus4uL6sguux1QMMoENk5V4eUJIVerCGPkdruB0giB6ErdL4PS8CyO
	 8zVfGICsRzNhrBTuUYfd26nEEaHnPOt6pmX88x6qu//r0XovEYgs/N0NvKX0uuC1JUdrF
	 CCXlZiF71iOYCsIeQdqgQZxnr3muP0a7fIgdINU2jcGWGVHO0pOmk/CXo79a4jIsc1dI4
	 FrdGI/faRa5aTVxtNarF+hCd6ZaCGB4Dh71uVxdOCHihz7r2mmfIrCUTf1tgrF4CXq9fn
	 v6YJ1ISA9QDRXJgQEYf8zstVFDMRR/G2DzC/8hyscSI3xeIehMbvvhzovrnH2SqYaUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MQr0/SaZ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B81606A31C
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 16:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74B81606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQr0/SaZ
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67bfea06a82so414700d50.3
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 08:17:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794241031; cv=none;
        d=google.com; s=arc-20260327;
        b=Xkh6y37d8v41BWqJ6G3rt2wfZBW0h3/6wJ++tp94iuiCx3SQDcAjdxKr6oqTVjq+42
         uxlrlf1OsbplADEg4EZZprRZydoXprTKKwcHXpCyJoFE3U83ZE3BHb1FbscraImnvlH9
         Qg78mz463DgBRq1jHYCfBPth9shSZxuBuzmj2UhNJ7I6Im1G2o0LyIiKCPJDJ/ysoYLN
         Hm6LIzS6fXOvSJYX9CYIjQRQawdFhMYa6VUIAR0rZaqMg9es6Z82SzFJ0Pq3kjZjy4WX
         U4tUNBilKv3A6wqT6xU0CwSeUFEsBct7ubqiSRuQbcL88RuMyaMlamV3ZiTCD1e6pJl2
         DeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lKkksaEQ2WKMPH8UcQDrIXPA5IBmaeoJOm8yk0Cbuw0=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=j9mKrav0Hl3Dt2idiUEtsSDqDoSj+eqN9TSeIeu7G8kdRxyN/2nTyfC1asYiXjlMkE
         sADVSkN7lHEQwVBzyJUeKSzMAzar3Go3XKu0sCgn1fCNwcZLH8gkpDiT8iWD4Fu+/doi
         agUugnA0Bc7Cbvej8Aj8iua1AYDkRjid763mDtRgNxFzqoJCx+NDcRK0gNZ7wxHyJJP8
         dqS7T6jLfKtGr3hk4fq3Jt/hNOfex0bFzIUOGf4zkCcsD/WfwhhJhRNZwZt0uoVB1PRV
         6oVJzmTMrSU20aaoJKvm37+QOcFF+G+pAb3sFur2GBI4DQgHS/PJXxsAZOhVV/sdQdEy
         hP0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794241031; x=1794845831; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lKkksaEQ2WKMPH8UcQDrIXPA5IBmaeoJOm8yk0Cbuw0=;
        b=MQr0/SaZmpTE60JCnyZpynoK+FHrgwZFWvKotX1Sw0S++1DDflqqdc8FZeP7Y80ewa
         jYqKwKJ/zhlNYxfsTq+PN8Xib7XnAoEzoUI5wJCu1EzHgLNmyCxMyQr6zXxzCxUg4dYZ
         AJ8edHbKWc8X/R4068jD73GSAPWO48jhpgklXe0LhtyywpTq+x0WUECeQSNJcCb5F7vK
         y15tF/l0bt/D/QCqGh/S6YpP9SHEcIlMPztmJLXGZHG9T/P3qHHbrVwxEmUcXEntQ5rK
         mjG2RU0r6EFQUloCH4khztpgvVAhmDIg56cGz8njvKKH1GqIPFOzEXVblj+gw3MTE82H
         DNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794241031; x=1794845831;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lKkksaEQ2WKMPH8UcQDrIXPA5IBmaeoJOm8yk0Cbuw0=;
        b=OsK5Y5uecHnxfZGHgo/C3orfKglF7Bnd6glUOkOJMiqnrCO7mc7DjV2bTjsbZ+f+6W
         yGZXjBk/4v7WagAUjgQ9tjcpQrJVvYD5sTyYC56j1CDbJ7chYflyEbGvCWttfrNafCMY
         wFEJ0OIIdze9i6qfYOCh4MTbwKdRDHYgAR5wxaJyQHrOG4749jlP3DKKiCiyaWJt97TC
         zlfxHnZ7SOYNdfzRQisNtqgYLzv2BbOrdEH/nofw9g+9BCXtLJ4oXlKlKyzYegWUv1Ti
         9oGXZ+9SFZh8JjSd0Ddr9fgFqzzbr8g+4748FiiQN6MNggDG2JgOMQcBBNQt9xUHMUpj
         XXcg==
X-Gm-Message-State: APuU4Z9c+zantvarIEf6f7N4tn6hLzcSz3A8tgq3tZcNRb3lkK53PKDD
	vFbyTkjSdzKb4S3RlopsLdM3A9qFBIpJ4qfXcwXDMXWbbpLBhtmhlx8Qu2U5PJ2KTfjbAdx88Xv
	HceqCp71nrcLqbn0a+fpt3ReE73lEELo=
X-Gm-Gg: AYBFou1mqmI1ZdF0dnQm4pcdhRoqveY2G/D+LSK/93vE9rvEe16aoeOX8Y4CnaAm7S1
	f0ELyR3qQVWpl75CRZhVBhs1tmCMUILQIF9/f9uFyNFerMHptXFZPDfwKrA1mG2qB+aTHBd0rHi
	snR2eMPSuvNrnH9qiDv5XaTOsK9WmFop7hbJmN06ncvxwOJBDydSDU4BXvmNfEpa0EIy86XfIJR
	/TADnTrVvcvKHiNWwTmzwOsWE1fZbd/chJFApY1c5j/MHo9cRb5lqJDATJk7ik2yRvS0zBfId4g
	eXn1dad+DaHUGP8GOCrqnhL4r7Jb4RukGsjztKg+moL7Dr+BSMA9aG1HrxSo8BJM5fxla6RZlCH
	9g/erZC44m8/K76ku1y4ItC3p5Ox73NY6AKsR58Oph+YH+3nsxPx7FUkIojAhwhyokPK/P7xqJv
	rjiYeGQu87rqXYsr8KQRJxEBeQLK0G25+TBW4mdouKLf1wzBCWD84kxHHGQw==
X-Received: by 2002:a05:690e:4507:10b0:679:f895:4056 with SMTP id
 956f58d0204a3-67c56761b15mr29747d50.37.1794241031554; Mon, 09 Nov 2026
 08:17:11 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106121725.48778-1-cgoettsche@seltendoof.de>
 <20261106121725.48778-5-cgoettsche@seltendoof.de> <CAEjxPJ6BeXzOfAz2Uk_EdT80op3o_8r6Cdx5JTtqOhQ-bCdbmg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6BeXzOfAz2Uk_EdT80op3o_8r6Cdx5JTtqOhQ-bCdbmg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 9 Nov 2026 11:17:00 -0500
X-Gm-Features: AclHuK8CnVa4WpNiOiYIiQ0gfWfCsS64t-oXwzjWSQ_OmTkEEYL1UznGVizhujE
Message-ID: <CAEjxPJ4u1t-4d8HFod0pADtyP5cYn5uAeJdchkHO5kSw_OJU+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] libselinux/audit2why: free boolean names returned
 by check_booleans()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 2:23=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Nov 6, 2026 at 7:23=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > check_booleans() strdup()s each boolean name into the array it returns,=
 but
> > the BOOLEAN branch of analyze() only freed the array itself after copyi=
ng the
> > names into the Python list, leaking every name on each call.  Add a hel=
per
> > that frees the names and the array.
> >
> > Assisted-by: Claude:claude-4.8-opus
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> NB Linus has declared Assisted-by tags as unwelcome in the kernel
> going forward and I am inclined to do the same for selinux userspace
> but won't be strict about it.
>
> My series will conflict with yours and mine covers adjacent error
> paths yours doesn't touch but I'm fine with taking yours and re-doing
> mine.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.
