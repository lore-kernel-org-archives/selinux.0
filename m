Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A572321F2D
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740687; cv=pass; b=HeOKisFvFzhqYYJt6piTc19Zkddr4sIx/cm9lboB8nlO2c2m4vQSaV2exChNLL5b1l2V7VDiV3a2narkjpfuKigwMnFFpyXSF2C7sAf/+UwrXUTlfEakH3FZWq7WzXnbKlwhAp4uVirw2BL8Id3T7ssEkwcYvPwuxOuovT9wY8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740687; c=relaxed/simple;
	bh=Vbkn9LVG37j3hmqIURWeJXp//5pwYBv0p6oFdBniy+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=coMhXo3+zKkyFqYJKbFhFWQmKthd1xfpVs+oUxfGikLmx/+1PGFhnaQhuzWJF3THejkxIXNwEuFbN+Wghvau5yA1BHQCGErZxLS6dRCiMz1GsrP7HuWXKLI8ej7LubezfpqBu77nXLXNrGpOA4CPxBWJ7wWoR8QcDPFSKeuDOjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsZagduW; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsZagduW"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6f5fc7so403044eaf.3
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 07:11:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789740685; cv=none;
        d=google.com; s=arc-20260327;
        b=K/eEopUsK8LUx4Zkr5k6tDZAZJ9QtuThI7mEaanpetwVpdG6oKoMEp+i06vEROwHaN
         ZOYuOld5jnyTpbF4Pv7rAX31Fd3AUUt51umuZLdIC9+E6vI8gwOn+Ovnzvtb6WDBS28k
         FXVt1CkgvjikKfVn13Uq6CAkFYOxTAZQPh4mioAUcHk9xPu0MkPiVgjCpgI1m2jMFgv5
         /2CebCYpS+uG5yfWVX2OQsqken5p+8LnCUzmG5usUjQBPIpScPDkYxpJnrt533r+Rdq/
         HzIkxuCBxC9+NuVb/2NYSLzqnFFgqtal2n7k++If4AUpAbv2qQQ2QWD0KdtXBoXIO3X5
         JVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NtV5CW3W27qJ0SW633JBWvihTGe+jQxyQvX5sRkCS/E=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=qZs4/tUzYed4noaIMrEpYBR42ve4as/du/tMFiqpaC/3sk8an0VuWLKh3MbYcsV1zc
         3TZ4Lw+8DBdOMAzPGIKRD/IuHWhlquyE3VmCn5f6ZHs1P4lBeR2FOnPQKH2sLSMrEfks
         AwjIuAkhmK4S1OWLcgEZ/R6ePt/R6MCjbioS+IVIaCg8cr0+93WejdWZ7SHMBD8OB/e3
         gSMUxYUUAzbxAIfdvS5Mgu2YBxPVnliS0wSfBr5O8X+PBlZBykP+fU54C07UAQ47begd
         KsAc8aFQ867QFi8VwqjQ6G82kzfOf2eH2a0FC1Nayl/7lkpFHP/p7tkEWN02p9qi+nBT
         OyGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789740685; x=1790345485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NtV5CW3W27qJ0SW633JBWvihTGe+jQxyQvX5sRkCS/E=;
        b=TsZagduW4cTBLY7SQwZTdIWTM9/t0YwCxvGcj+IDWHJAf40ZVwveajNHBgOcYQBPTX
         214coMI24h0al+ifmKTFNc56sVPTP6AvXyDy9jVP37Rfvn7gc7ENXrbs3SllJv0C78MX
         g8uWxj7Vm7Y/PtGnFu5EEhdjM0cv4yovTuCMFNrRFzHVUkSUIBoB2o03SsjUFpPbKtV3
         PRNDnj0bOdFKj26nSA/PxR7OSpaRq2TaXjI7H2Pr+tXuB9Pn2VVl8gdVhF6bvoIE6zZo
         0ECnwK+OQgGkC7ar4v+RmrdTUlldM7EisYfyzctns5BcdxUZyEcNjEiAH4rqS7HGRiEY
         gieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740685; x=1790345485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NtV5CW3W27qJ0SW633JBWvihTGe+jQxyQvX5sRkCS/E=;
        b=JI92UZd/JNdKa9T8DSIaSEo+kMyjTsr91Gtr96WhTDsLaNSPjm72Z1dYBMW+xENhhB
         vKtsyZ+nfaLzhSAxwtc+CZ2xEHWPUxgROt3RdC5Gn/4fy3latrM/RCyVUFcs9KQz4h7j
         g9Aqf2WSeRx9yp5ctMU/g8u7QzJS2o5NGJdGtPTb8Logvz7lgGd4M2KGOylkUeaSBs7q
         l9P7nGC4fyo6GJCFLTiHfVts0KxZ+Anr4CRrMnVqT8DAAGtqMTrx83uL0xVLAU8V0hqL
         qOs9BNJNrLwCHEAL/qeS7RoYA3baYcD9kD6aGXOrATxHqMWVzNOSRIAqbR/+Wdu/2a+w
         oQzA==
X-Gm-Message-State: AFuF++mORbu+z+CS76iFrOX8TgJ/BWIlAiC3367Q6v0uaNLYtPjf43iW
	6bSNb2cPuZhoe9YpSpuJWGoKmio0qaEbES7QlYm8LKHGgG6ZpuunvbbXEccK1sRKSV/AC9ZLntZ
	TBE89krsiTEFZQFX91ghE/toBtO/bO50=
X-Gm-Gg: AYBFou1WzIq26rtAaHCybnXbPowWe/g+cRdTyCvzkaVuO+zj8B2fOHzWd02QThNDJjk
	zN8+71uUlwJdWBWXrXw/rf9ffqK8iQDuU+r/uukUPWvZ9pPhYqTYvh6amqHRUf/OOJqjwpPZmch
	yEZ1aj7nqUX2UHL5ccB+ZezoLeq5IRm9k0niF+SG+z4Qsvb5ShnyEagMRDed0pxSO124pQNaGQ6
	3JlDxIKfAsAIVlAs06yvY62pmY9d+rhV6d3kpR3wdTVJc3v9cltyx+r9u2oLZ8e1R6iy9vzXa+y
	hBAfYrv71z5lhNrqM52OyPrsEJXDXUgqGN/rSirOPoLuCE7UOq/GPqA=
X-Received: by 2002:a05:6820:f07:b0:6c9:83aa:6fbb with SMTP id
 006d021491bc7-6ca9d347eebmr2714732eaf.64.1789740685403; Fri, 18 Sep 2026
 07:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917141317.54719-1-cgoettsche@seltendoof.de> <20260917141317.54719-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260917141317.54719-2-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 10:11:14 -0400
X-Gm-Features: AcwNN1U8aiADnSJiclwOhF15SbEpq4DdcaV0ihpLW4Xo_Ru8NmkjGWOVn3IfRBc
Message-ID: <CAEjxPJ7-vEBDoEFbLWfpC0wE5DWUq2UOU=TxvnEaSB3iBOTiHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: check neveraudit in avc_xperms_audit_required()
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:13=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> avc_audit_required() returns early for a neveraudit domain, while
> avc_xperms_audit_required() instead relies on security_compute_av()
> (and security_compute_av_user()) having already zeroed
> avd->auditallow and avd->auditdeny for such a domain.  That leaves
> its "else if (result)" branch as the only way left to audit a
> neveraudit domain, and makes the two helpers read differently for
> the same rule.
>
> Add the same early return to avc_xperms_audit_required(), so both
> audit gates state the neveraudit rule directly and the extended
> permission audit path no longer depends on the auditallow/auditdeny
> mask having been zeroed elsewhere.
>
> No behavior changes today: avc_has_extended_perms() only reaches the
> "result" branch once the identically computed "denied" is already
> nonzero, so that branch was already unreachable in practice.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

I didn't see patch 2/2 unless it was one of the other ones.
