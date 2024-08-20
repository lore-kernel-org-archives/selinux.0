Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8621C4621
	for <selinux@vger.kernel.org>; Tue, 20 Aug 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188447; cv=none; b=qzWLQ89uz190wLaUM4NOEsroeTzmrRYF+1E/BfK4w6zM09NU+U3f1GJ9dBFASrhZq7WA4i80kGeMlhOD5AeBw0QnuStZpQ6/N5vqngpfFxtJOZEDVqSR0K+1nrVxdV1q72Ty54cccGMeN4StqKn4+QqDtrdEV2hzXJ/2xx6tERQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188447; c=relaxed/simple;
	bh=olYtCfbzh3hv750pGFKPi13E6GbGZJpSuC+NYU7iwdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkmS5hIFWOHy0iDr7UHNF4DGgXrOrEBXaxeFIYtwAJ+3CpaH02dtrC7qbB2Ij2lguW4lY1+78vMBmf9rvD4AzcCYtShfQ2KELq3RnB5CFIALlw8Epc86dnB3aSfvPUyQSWPFlYRaOpIVv8KHwK2jju9kXOtbXbWAdtjJA39bR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QutJMLds; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QutJMLds"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e16582cb9f9so120323276.0
        for <selinux@vger.kernel.org>; Tue, 20 Aug 2024 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724188444; x=1724793244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEmGCsZsZEV26NAlcnucdsj3tMtCsPhft6xiYK8SnDk=;
        b=QutJMLdsNqVmYYE0rDowgs1wWFfGUIxJyxhRAeIqETNwRNQ3dX+pJI0/6HEnEECyQy
         /F98Q8RSgEchrTOgi49Xon0NXxhsXQuivqOGIXMMrNkadliKeJXxl+KAr4yL9X3TcfOm
         kx1dmDp2jdXBlLIDh4sq6m0OQjOL4PT1MG7b5V9HckNraAqVDKEb0Tst+rqds8BvJ3pR
         3mh5C/3PCx77bUZAvRiUASepG0a5qJ/1LaVDMNLjOdGUWdba45fZSSqRgRXJm6maMFve
         JtqYo3aIbEzQRTSfrlx09k2B6ncIMoQecgGOtoSBnMGDy2iOKDGr7MP7fIFJspg+e9Qo
         jbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724188444; x=1724793244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEmGCsZsZEV26NAlcnucdsj3tMtCsPhft6xiYK8SnDk=;
        b=q/T6vor8pMS+sk7CV48RKYi0lSiJbHGcJxxiT4sEz7q8KATJoeEOAZxyYsEd9UHrxf
         f2I8RoE+16LzESjdFFNvfdh649CH8KwHObtCJIF1lLoSZkprO0XS7C7cWKAQ/f1GheJq
         7mZSH/IID6utlGsn3Sddcx1ehCum/t4fSDL4BykAqwTQs8vdMxJWz4lT9fMSobmKCoBH
         mDkm0LdYgkhqoK02336n3PAM4/aWkuJaLfl16QQwNfpV6/2J5yNsPlnCtvTFHHhKb9IX
         mhqesOgRkHStaxscHo1JiS9gjXkzsuW8o9IGELt9JIijLQa+qujuFJ4bMJphU1AcBQyi
         vIGg==
X-Gm-Message-State: AOJu0Yzrtjp4QrlBnw8dOn0b/n3C+ZJNDT5AR0zDVHWBf4tgojxa8Oqs
	tfOjh8+YJykfnPvEdBhN8iMj+MdgIvOPgthcVX5aPV5+o7uBza0dWEdUU7aEkdk3ACNnMCiBc7m
	lMtllaAz2riLdjt8OivCLs4200Wij8uKPHr4P
X-Google-Smtp-Source: AGHT+IE/+tufKaGosDRh7OdFHrUGALDTa3Vv4IR4D6qT+/3SCN3bsthS0ZfGxWz/3cAO4ZuNV4DIE1Vrjg2qu1VB3WQ=
X-Received: by 2002:a25:ad61:0:b0:e11:79c5:2aa1 with SMTP id
 3f1490d57ef6-e166712f7bbmr178359276.25.1724188444677; Tue, 20 Aug 2024
 14:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816144519.25600-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20240816144519.25600-1-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Aug 2024 17:13:54 -0400
Message-ID: <CAHC9VhTT5A9Rtb0q-0fPPk+GpeMcmfJBOkjBU640V=k195pc7w@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/extended_socket_class: test SMC sockets
To: Stephen Smalley <stephen.smalley.work@gmail.com>, omosnace@redhat.com
Cc: selinux@vger.kernel.org, aha310510@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 10:46=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Enable SMC sockets and their dependencies in the defconfig and
> exercise them as part of the extended socket class tests.
> This only verifies that socket create permission is checked
> against the correct class. The tests cover both usage of AF_SMC
> and AF_INET using the recently introduced IPPROTO_SMC.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  defconfig                                |  5 ++++
>  policy/test_extended_socket_class.te     |  3 +++
>  tests/extended_socket_class/sockcreate.c |  5 ++++
>  tests/extended_socket_class/test         | 34 ++++++++++++++++++++++++
>  4 files changed, 47 insertions(+)

While I think the AF_INET/IPPROTO_SMC case is still an open question
and therefore probably best not included in the test suite, I do think
it would be great to include a test for the existing AF_SMC case.

--=20
paul-moore.com
