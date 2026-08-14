Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB4A7E792
	for <selinux@vger.kernel.org>; Fri, 14 Aug 2026 04:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681410; cv=pass; b=mz4MVhJVscoEpABRsccan5P+z7BAxc/pzCrYHviPyW2whwnT0T5l4qpaGfLv0PjTjnvljtGGNDQ09/jXDWlPXp11v27TFJEFxKiVnp11wfN4nBpIUSKjb430ObFluHXwqb+iZ6QjdqxMOiGv16ycK0Zu13BWTHjopjB+rj1+6pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681410; c=relaxed/simple;
	bh=fA/nJm6w5RsJBDTm9RqzuZlneu8KIzUMc8BDDn3bDDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BR4kWXIVWtFQ5R4rgruoQx9uZ3G5R+jdQsHq9plBQGQylkSmIWvIs9NU9G1rWz9STLydfRSGtWew+0J9e4NfnaDDJexoJAxyimFz0qw2gF1yT+56aUG5cTq7z4pW13KOfSKqmoTnPx9yKzYdQixJdP8Kcc446CsmBaSodZRGM+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OU7X1xhv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc6rKgAk; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OU7X1xhv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc6rKgAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786681408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7K5pEAR2Hbz2J/sh1Bl2GxGXBG0W9/B+cXDJu2Mfo8=;
	b=OU7X1xhv72j6iTaWzjR7S1bzS+xIyv7sNDh2TA+ioPQl1xehe8aNWoDKVyK/aplOmijGUv
	I85t53ShWfNwHaOJRISmhOvClyLxjog8GNfFXqIvk+6E3rL3j/yYSWweHXfr+4T2pm0XbY
	nizgXN3Ozlvof2plQwRaqyCQ6LNoSbE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-z4p5nJlcNaWVZUzIB8AvKw-1; Fri, 14 Aug 2026 00:23:26 -0400
X-MC-Unique: z4p5nJlcNaWVZUzIB8AvKw-1
X-Mimecast-MFC-AGG-ID: z4p5nJlcNaWVZUzIB8AvKw_1786681405
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso715344a91.0
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2026 21:23:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786681405; cv=none;
        d=google.com; s=arc-20260327;
        b=dG8ilo/9ALdYUWWYfchd5r+S5XZTDpfSITDhRpOIfqPImJpNRJ+KZ0mFRIYNvlzPXV
         QllmnRn2ZSIk8B1DvzSgZhr5PoFww/xD4nfIZ/+63HkoXOu0106wqdlvss+WONXDAUhF
         LKeoTg7C+FnB3GfH+zgSs4mTq+UKWyfYTjGP2ePPy/BtXxAlAILXmPlVQM1ezdP/Cu5K
         30tinqddf2ayDPj9cbHkNTHazMKHB2/j7e4LFA85ZwBwd6r32HF+lDPxoDGWPDNobs9t
         7STAMQxFBznN4vQlJyPImR4sKilwup83jn11O8WYXTT9HpQV3iTaD4d1+fc/RGva5cpG
         DD4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+7K5pEAR2Hbz2J/sh1Bl2GxGXBG0W9/B+cXDJu2Mfo8=;
        fh=kNXlBPu8BwQweijrLTw6/7CJlHRJ1+zBhAXh/3D3I9w=;
        b=qaLSUC36o1nODcelrnycgcokqTd3vnzkE2fuloijVEPXpHBKDYmCKrWvYKhonQ5S24
         wYRxMueBVE8u/cncRaUbV5JkcfBsBN8qQkh3HLbDJhkh5c32aN8LFfabgI49/TDTQT3l
         g0M5C3R0CheiQ2XBdsTVDLbH+YiuGLyG6FtYdhSbkUBuxtzzcCCLEojmQ9p1UWtdqVRa
         o0HNBA+s4MPPrlbaL3BmbSoy1kXc5/oplJG6UOOhUzrJYrrXx5IjL16OH2+Ud8nV5VN5
         bzWMP+WnUY+fV3Py3QPByoUF6d8YFH7MR10yRWa3UOdwZ8DlrlEzrzMf2S8BwAHePzrB
         DkbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786681405; x=1787286205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+7K5pEAR2Hbz2J/sh1Bl2GxGXBG0W9/B+cXDJu2Mfo8=;
        b=Sc6rKgAkJrxycd6JDc02wK3xVeUA2gJnpEzWyTa+35OGXnqXbjqsRwfYY/hzDkQ/yZ
         m6AquQ6rjAhC2nJIIEADn+CI93991RcYRxkC9FO0hGCjW9JP2JrPziKFpTnTF+FoLYwb
         aqnJHz6fzNeQG18t+Jtc9JX6j3+kkKmy5NQ3dwNVFHi1Ws9tFROWLk3SGzAE5C27zZm4
         PGXa9Qw4nr4RcSyoFfsT5u820+0AztltxVMcM7YdOUE1+7BbcqJBdxrkRt+YXX3N6zLr
         u/3hDgSuT2aAriTfmwDc1vcHS4ECU4RxS5TQLsIdcKSqikDEoI5kCtC6bWz/k5r+U3up
         vNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681405; x=1787286205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+7K5pEAR2Hbz2J/sh1Bl2GxGXBG0W9/B+cXDJu2Mfo8=;
        b=fVkcI87sQw0RYJxGhLQJEjOKIN7+H9Upt+Z/9Fwq9l+m2k/W62uZL7JXWbr0uClmXU
         LnFxLyjIeXXIq00B+VSYSCVQCGUImhJMOLRRORbpSMD0+guS6Tm2vrTv7puRl1zgPLw/
         mw2CFLRan/tkJNP1RCzzSKJuIzmpzw3i3wl2KTd1e2xXvAk0x8fOZJ6NuHFMAnjNMcXz
         52ynYKcJ0wDhJP7dajmbxKDNCTRcmYZ1KyFDaM+uAmA58wyzJHSt9iCPVYEknzsBLVCs
         Bw0AAQ130AyXfQEPzyE1LtrGkq/Tr1AHoP2L/s7r4lphJLYrWWYVfzl98rwAPIQvahxH
         UcAw==
X-Gm-Message-State: AOJu0YyuWq7pVUToeUZYy2wY7XFg8QRJNgxU4PpWVPHX2xtchGigxwd8
	O3crvtMa7K3Sa8fFK0dfC0QPjeD5yepOHqVT9XOJa5Qzu3zNhqlUXxio/7bEOsW8Nwoe/iORjc+
	X+5QX49zAUlnbKYzva56Dptgqi7U5fcQj756ZSasbU25d6oycLdayoi4SFoZpb7K3LztKoc9Kpy
	sTzcUHFpqTlqPhUqTphK7gt5kMCjMRe9Lom+NU0lsSnw==
X-Gm-Gg: AR+sD12GyHJYmBwv1gsGR26zg3ICWzT2EiQGi9O0fXqnoizGKc9xd0RyH1/tf9TdU7R
	D4c/T7UXk1bYQ85HzK2wy5uP+1CFTFpVKXisPctXdBB4wNZABlZ7wP24iRRRrvFJRiEypOZoTwb
	GFlWOA8ApcJ27viuKg5ktZCX7zPbeXrL8vhpoTn8YU81usu1p6L8UqhWqw
X-Received: by 2002:a17:90b:2891:b0:38f:dec8:f7e9 with SMTP id 98e67ed59e1d1-3933b8744c2mr3157617a91.12.1786681405031;
        Thu, 13 Aug 2026 21:23:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2891:b0:38f:dec8:f7e9 with SMTP id
 98e67ed59e1d1-3933b8744c2mr3157557a91.12.1786681404597; Thu, 13 Aug 2026
 21:23:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813191248.196973-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260813191248.196973-1-stephen.smalley.work@gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 14 Aug 2026 06:23:12 +0200
X-Gm-Features: AUfX_mzRwE_QXUA2IDewChj-i9uiV5eTiB-hYLwPjU4Hj5_53egi2g9OgHCFSeU
Message-ID: <CAFqZXNu4D3setEk7vgUpiPt0R=Uuy3QMrWZq4+49NF2kCcAatQ@mail.gmail.com>
Subject: Re: [PATCH] .github/workflows/tf_testsuite.yml: skip testing farm on
 pull requests
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, plautrba@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The testing farm requires a repository secret that is not exposed to
> pull request runs from a fork, causing these checks to fail on every
> pull request from a fork. Skip these checks instead in that case.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  .github/workflows/tf_testsuite.yml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/.github/workflows/tf_testsuite.yml b/.github/workflows/tf_te=
stsuite.yml
> index 7e3993d3..3d7cf081 100644
> --- a/.github/workflows/tf_testsuite.yml
> +++ b/.github/workflows/tf_testsuite.yml
> @@ -5,6 +5,9 @@ on: [push, pull_request]
>  jobs:
>    tf_testsuite:
>      runs-on: ubuntu-latest
> +    # TESTING_FARM_API_TOKEN is a repository secret, which GitHub does n=
ot
> +    # expose on pull_request runs from forks; skip those rather than fai=
l.
> +    if: github.event_name =3D=3D 'push' || github.event.pull_request.hea=
d.repo.full_name =3D=3D github.repository
>      strategy:
>        fail-fast: false
>        matrix:
> --
> 2.55.0

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

