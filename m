Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ADC4B0CA6
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443560; cv=pass; b=Kmm4ukbKsP1UnzaaqfI/URfP0sdpwQWWpppcMeL8G0Ywvs4oDBV5IsIl8i4YS2jc67JNQtLQinAJjZrV9O2agmX7O7qpUKDAB0qwPN4enEIgDwFvkWQb/pwUM6XwJVnL2FygqVqsB018MBaEGW4AsaLJ17WjUURW+BLNEfSGJp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443560; c=relaxed/simple;
	bh=E7Ed52eUvI3763J5QicYfLQnDmeIugKob8USbxxNU0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1nfrqB2NW9AQuiHArbR3kqpgz1eLkAHZ0/u5L2j1jbWT0IX4P1EVPau84GGtEUrThr/2kandzXWTujWjoiRf9CggCCHpYK52CO775JbC3ctqdbNoqysLazTWaKgrjIzUEotweNbSrU3a0bQ1BiU0fyCUrGJiw2CJjnDmNUYo/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHGhwZb4; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHGhwZb4"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4583b1703d3so1070805fac.3
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 06:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788443541; cv=none;
        d=google.com; s=arc-20260327;
        b=bmpM3P3n36TW36vmrPUnJyt8iZaOFy981DMQQybiqBVoZxgNTgdMPREImpG/ctYLTZ
         bKID4X1LRnSSYRVm4+dQWKKIKbs7gIyMlNxXXTmkMBjkun3+rmNxqixC5ma1ubKFonnD
         s4hld6Rd3DxDo5w76mGgp7S3oZMEwhuRNO2ByKjeDQzLqjqZcZ6pmiADOEW8hwxKbyd7
         r0DhEUlKlbKbOavVMpU/TIbz/yGk/un0c2COKwsYyskAk9ROwz8ww4LdZlO+mXS0KK22
         aZ4nmhDw8cYZDTTja0T+TlFf+wtIvAYfZZ1XfoDSzk0ecx2EArIxOquGhljgmxLUnOFv
         NxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E7Ed52eUvI3763J5QicYfLQnDmeIugKob8USbxxNU0s=;
        fh=aUbqRQkq61ZAI0AgKTda9vTeDxp/LdA3hosIEHHauP8=;
        b=gpongo1ZN+M5Jldl6Pey/v9eSRuej+0Pn0aaN4B899/MR+Y/O2ou7HN8zZqXDkeL5F
         ys8LAXyLXkUMYq3q5A2HXiTsmr0z9RbKdH+anO6cGO1DaPj3Z6/eWWtZy6Qew58xYKbE
         XUTER1oHoYQgj8slSTgOvHXKKTTWbnjc8mPbD8XTeYvyKy7+VIJxXjievYJRM+7CRhN2
         Q26Q0JMrK9kWxmf1E2Srif0nzgMiiFoSkU6+wxSUbPiXW7gPKe5xPGBG5+kVIgIIUSq0
         FS2yLKHWJ1NyEnTN451Z5feCF+LwRdkpRxPVMZDxA2U+FVRVzuxYdaV5HeehCqRmXHtV
         Ncdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788443541; x=1789048341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E7Ed52eUvI3763J5QicYfLQnDmeIugKob8USbxxNU0s=;
        b=YHGhwZb4n9oA8bSYeon8lCpsZHabyZYJlKl8Sj75ihav80169go2ATqDj6bhQiiTtD
         4VmCtaTRLBMpaOavsSI7FBmsfY8bt/TMl712nNUJjAdvUo3v/iELO+5CrW47IyrqIY8C
         2N0iU5HTdmNF4Pb50GhLDZwqCACEaJF6xWlHdV+IeSDmoL4UhigGeI/OwmprHJG4D+Xv
         g3xqN4aZXTq3BTo9m3YCynUOViGt5M3gf6hwKys0YE6WAjByDQbYUwADoRCqZPmhb9kP
         J0fZrwUcfvslL5RU0g+0HoA95Wu3rQceTWn/WgkGK0PrqvMfHR5jv+Ciws2BIf2BcDof
         To+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443541; x=1789048341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E7Ed52eUvI3763J5QicYfLQnDmeIugKob8USbxxNU0s=;
        b=p480PXNbB+zUo1zWLdEybymudAfrdVWmgkhpgHSf1O2nhZmcu0EOojiT50Yaclyhqy
         YupxyTaiv/VOgz1BNEOdAX6Axo3CRHqLiKkCybnHg57mQh1Vumq+LwO+ZWaHMpeXAt4Y
         F85+jQ3JlMJII5LfXE1jOj7AKsdiU5g09uTSbIzxHwnliFztty36g+oLyqASmV2Xe/nF
         J1LDStqSF0cnNXw5EukoWAR3fwUGfh/XrTJj1fA0jlg7+ihdh34sLeCSmnHIFjBRMW0j
         Jc5wIgMY77G6RJIae8mBOdSBx9YQOctUAmiNP8nuSb992QBO56xZ25y5OkdPr1DXSIPH
         G+uQ==
X-Gm-Message-State: AFuF++nMyTT/G/hPRzp7eB93GwkBpRzhI5XXzQnt3JpRmmkNOGpjbhZS
	ROuVKJrnYlmwtrijYxNWNPDaUARIXwZKBKv1Rk0J5qD0CCPz3dDPmbrYMyJ5Sk5SntCnb97ELBH
	Wa1x/XtzVC6igWtxxiOBwcyaJxFO947M=
X-Gm-Gg: AYBFou2zxh6MY4nKX6Pg7Vbc4uVXzAIsTNUk5k8EvrM60hMnU0SUdvM7vezivjehFz5
	C05ZsnG56IbQLtGkiI4NFpQP0Lq1sEemP/e2qjA/OVDpA5bL/9VXk3laHEx5FELBVGnDsBp9pet
	6z1ip4lQvaxAPFAuXT6zHVzcPy+CsS3aiZeSe5RZ/QJorx8dOaOV0WjPig/wVOsrZ4HssbjmnB8
	bpfZs8OXnQw6UWgF0LCRYfpJdgun8cAgRE56pX1Tm+QAVA53RRvm0ANCiZm1+nYudZLnj4lIaZ9
	HnIbVZh+Y9nsdNKaiy/i8ON+7q/aL6rTg24+fBj7nSSV5HBXPNPyiwg=
X-Received: by 2002:a05:6870:3272:b0:46a:c0ff:feab with SMTP id
 586e51a60fabf-46f88b27fa8mr8807905fac.6.1788443540809; Thu, 03 Sep 2026
 06:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903113538.72942-1-cgoettsche@seltendoof.de> <20260903113538.72942-3-cgoettsche@seltendoof.de>
In-Reply-To: <20260903113538.72942-3-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 3 Sep 2026 09:52:10 -0400
X-Gm-Features: AcwNN1UeAtUN0v2hlUp82CJLlkorVDACdaC3LsoLmqXwhl4Uhll0l1AeZtXwzvo
Message-ID: <CAEjxPJ6NPCeiDmNXu3s=44sCBum52=Py8dUxo-fiofgU=k6dkA@mail.gmail.com>
Subject: Re: [PATCH 4/5] selinux: validate user MLS range and default level at load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:36=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> user_read() reads each user's MLS range and default level but, unlike
> range transitions and security contexts, never validates them.
> Validate usr->range and usr->dfltlevel in user_index_check() when MLS is
> enabled, once the level and category symbol tables are populated.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
