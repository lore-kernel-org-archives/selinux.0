Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF83FBB5A
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407203; cv=pass; b=TqYnfj0YsRbOZ456CJIa5UnYvM4vaBMN3hai//BlOTeb/YjBpm5YJxIXYg4NtJNTRt8s3Ks/W4TW4tWEMQgwpMMpJPax1WPTmEojrl/wOwKeOy7L+ITXouV5Ejnm0wJ1OQO5HHEwbKManGenIvsxrnDwCl2RpeVAybJLRjbWv9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407203; c=relaxed/simple;
	bh=shXGVyUwDxFITgwTWL88/8Mcz8vujzumuGwX0dv8tgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EG+KN3GlgrKrrVerGOBbCJr2zQK7ggBoo90LGms2KU1KgG2Rrocqe/uLQuFGPsyJXH3+eeuzRH2cig/1sdxg6ZGE1tnJn1ZZpGQXdNkEsuIYxJt2nc5OztlQn4OSfi5jsBC+apkSv96j3B5d5QeW3BCYDAcOwqUzRvnM/t04Ibs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWGGJLW+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oNts2aNl; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWGGJLW+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oNts2aNl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785407200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPsNokbNDyDMt0Qqk4hYFiNomW2jjYe3bV5GSNGboPM=;
	b=QWGGJLW+fX8zqTStsmYoOElGrNw4zc/PsgpXagWGSKrYogfIlwxKysagj4ShwMLQyCmbhs
	eoQPfUBwX+7l0pvj5smNfW24omCV4s78pqG3dBcMSnxs6fx/LZfltiewDVQHUS/QAuuZqP
	hrgCItiImYMpedE1C/LwOkJlsDOaXho=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-zj-y6efBNniHm7M1Tg1p6Q-1; Thu, 30 Jul 2026 06:26:38 -0400
X-MC-Unique: zj-y6efBNniHm7M1Tg1p6Q-1
X-Mimecast-MFC-AGG-ID: zj-y6efBNniHm7M1Tg1p6Q_1785407197
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7621655eso3167938a91.0
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 03:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785407197; cv=none;
        d=google.com; s=arc-20260327;
        b=SgmfGRzLBKmnSSVbqTsG8Jz4eI74OGz1oHF9jBykJ2i2pnpYlTHitefZc5TFcDuJ2E
         qzWqiTyIvuQLn+z8AqU68fioolFiFB9Ns4TwUYWmGP1kIfGkxa8yR9YOVVX+a/gFw3iR
         XfCReagE7EE0PwgY3gI3qChx0OkFwnPjhh2TFECPM5qnwmj8ixQQaxxgLDTQOoRD2cY2
         OpiSBDN1UEKXTxG2NVaLaISqV8OsVs1wL2LUAeVTgfMAbB5rra9p/kEvOERoJmvvON6A
         jVXm9Fk00WnDRrBrdY9Y7pVgRglLRTHaisfJe6JOXsRlHSN+aKdhRMWpv1521xPxozCD
         4Gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZPsNokbNDyDMt0Qqk4hYFiNomW2jjYe3bV5GSNGboPM=;
        fh=nOcPTm+jzSpUJDDJhvsoEQt/GcMQFmPB1BDsWNtwPZ8=;
        b=r13OcLUQKRf5fjLRPByDtNwgEMtjOjBFxnxfTLjo0GzS2+oOSVjHbc0k0035VZYNce
         HPzggkcvJByPvzbzafn4Xk0BliBhfcrfYudAS9gzYCBXI+ESRtKMw3c/59hufxxgZ6DM
         e32bvL6OrCN6h+RE81/pdeeuOlPc5G1eut3DNCgSB9tgk4dba7Ifhs3+HispF3yH01FB
         /8NiImf3iEfHGBw72tGhX0EZlkKpA8BmDV+jBvRf4WPuD2IXeVgVqCCFCHCSPpodBJdP
         HsImfkzlbLEBwN/Cv5yCT1adEHFvJQyr0+oxubwj2jQBHFyxbZooRekxAkTgjsjBLYYS
         idAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785407197; x=1786011997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZPsNokbNDyDMt0Qqk4hYFiNomW2jjYe3bV5GSNGboPM=;
        b=oNts2aNlkQaxj8BGHgQTqznMf2wP0PS0XFS/OA/IspMxbn1tulpyPaBuefkXwt5Q0C
         YQ7nL+pqvb1TrZEItGsvXp748coIZ3G5L4G/cYbyF9+W0w8o5izvqDie0S3jSWq6rm5i
         mTGRDSZNqoUwH2x2wue8QmcKKa2XEnAqG76Bip4nfcHZzMFVPehI7bmDtVamZrNJsLA0
         yDrKOGyW7B6J70xZzXjAIg9/hg0tfq1mKwp2uAHI0GUnygkacpP7uXVt2d0W9JI8Vhl+
         NhSNkrngZ7sSXzrdrAzwfBzkrDeX4eV95drRxrnD23IlTBDL3wPAfynM0fmGaEGBu1vx
         2IKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407197; x=1786011997;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPsNokbNDyDMt0Qqk4hYFiNomW2jjYe3bV5GSNGboPM=;
        b=MZiUZYHXbU3zo7rLwsTD55JXeSV2IRUL76WDALQN7q12CBp7oVPWwWeLTpLQAr0kg3
         WracQmQPWJi/QFP/UgThBPW0Ba2NtcPIizTkoHd4fSljEWVuG51v5VTKq63UThoKjLpg
         cO/0sQg8bixroV0YojPYNDbIm8I7CY80Wet8UzdFjpVcLGyNMzZLylCATNgyCx2Uzigy
         xolRS9ZmdXvNEqy34fz+kU4r7oyYRQbreSyQXghDu2edGZBuVOr23BhlsHyBCoSnUUJh
         7AA2epWSYFCpR0zQiN3HiutUI922kYs8d/p3IloBztw3EAAoCPTtmE/P+QShKz8WK4Lu
         so5g==
X-Gm-Message-State: AOJu0YzUgQp+/KZlBgTBDzVGaUvxi2b+deCr8tYRIeGt4PsGmcm5OhZZ
	d5qbn28pyjQ/WrEvNAlv1TegNERr4YjY8RI3NPTCag9QLPPb9e3P9LkNqWIPT8YP+ClNaBGxuha
	4uigfttw9LlveGww7PdwbF//+48UqYn1+YIwYd8YbEDqJAtdLPO+ICbVylIs2scksabQAq2rXGA
	UKKClavJROf6q4z+dYzbZzfKymseXTVzzJmhPseHP9yYLO
X-Gm-Gg: AR+sD10SU5rvGZQIz9SydqDhvadiX7+6R4ye67iVFlEcdaVBae8fIYOIE3FegebnH3I
	um3fpY8nUl3FfJiWcV8rvukRr73/iN9PIkWI7tzDn4iCJ5CU1Kr3LMb+ACC+/Qt0q5242bZR/88
	dEFO1Mwx7TBuYj7tNupj1tqPCK7LTzha5t9HnqqFPuoO94Yy/AjwGoYr5q0GnKN7xL3+p9virTA
	9M0sHKHtM6miUv4
X-Received: by 2002:a17:90b:17c4:b0:38e:63de:730d with SMTP id 98e67ed59e1d1-38f9bd692d6mr1547099a91.3.1785407197272;
        Thu, 30 Jul 2026 03:26:37 -0700 (PDT)
X-Received: by 2002:a17:90b:17c4:b0:38e:63de:730d with SMTP id
 98e67ed59e1d1-38f9bd692d6mr1547083a91.3.1785407196701; Thu, 30 Jul 2026
 03:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728164552.2646227-1-akkohli@redhat.com> <20260728164552.2646227-2-akkohli@redhat.com>
 <CAEjxPJ5Ddd=-X2vKA7oHzDF-ZZ-_GZyfc_z_XEwXuxePZWb29A@mail.gmail.com>
In-Reply-To: <CAEjxPJ5Ddd=-X2vKA7oHzDF-ZZ-_GZyfc_z_XEwXuxePZWb29A@mail.gmail.com>
From: Akhil Kohli <akkohli@redhat.com>
Date: Thu, 30 Jul 2026 12:26:24 +0200
X-Gm-Features: AUfX_mytgIEe-AMr91GorAIBc7Pnkp32WycTzDbXUD5f8XfjI5FWGuIRvdekV8E
Message-ID: <CANu4e6PYkZ8--vBPskdhcFtij6T2dZvxu+MX4gb2KcNRaNxV=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] checkpolicy: extend bad-data tests for type, role,
 and user errors
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for catching that. Fixed in v4:
https://lore.kernel.org/selinux/20260730101840.3224405-1-akkohli@redhat.com=
/

On Wed, Jul 29, 2026 at 3:24=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Jul 28, 2026 at 12:47=E2=80=AFPM Akhil Kohli <akkohli@redhat.com>=
 wrote:
> >
> > Add negative .te fixtures for duplicate type/attribute declarations,
> > type/attribute name conflicts, invalid type names, and malformed role
> > and user stanzas. Run checkmodule negative tests as non-root in CI so
> > the unreadable .te case is exercised outside root-only skips.
> >
> > Signed-off-by: Akhil Kohli <akkohli@redhat.com>
> > ---
>
> > diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_te=
sts.yml
> > index 4322ddff..fd78969f 100644
> > --- a/.github/workflows/run_tests.yml
> > +++ b/.github/workflows/run_tests.yml
> > @@ -94,6 +94,17 @@ jobs:
> >            sudo userdel -r bad-data-test 2>/dev/null || true
> >            echo "::endgroup::"
> >          fi
> > +
>
> Trailing whitespace here, git should have warned you about it.
>

