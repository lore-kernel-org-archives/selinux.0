Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5E2443C17
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363375; cv=pass; b=ebQo27pYrcJ3C0W8DJSyyrNevx3Ifef29mZmh60YHW92RWHHatPab6pfNOd6EnsmuqapbNQZMOaXYUmQFq4SsKSrJx3nxNiUDt5NDa9CXwX/6kGnWu1Z/P0xC2BxsHgG7dtWqB0l+3DCqNhkBOpy0TwAzvf7IBWjguwnSm+orLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363375; c=relaxed/simple;
	bh=aVpf1rZZckvRhXRHvHxb/bjv3QSgorFsJUTW/to2zns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxhFkUpUqWcEViEkECNPHADnFS3o+L9dbfFOtD0cPqDBRNP2pidfHZwRcJ7KKZam/hdVI/fyy2hqu0VKgxcsjbD0lJ88xnKYwQptdNFnxUSQF0FrmWBq8fBbklAX0yxIVpicH0t8hjPiYZfHr3xib3naGkJ5oqTSidsFJJVip8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iahFDzzl; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iahFDzzl"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8a45b788a71so10097687b3.0
        for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 12:09:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790363372; cv=none;
        d=google.com; s=arc-20260327;
        b=SEsLWwFgt3i/DW9baX9L7GqVSUDO04AWSYHUmFODWs/1/B32NVVoIQxUnC0dHxpTZz
         QtVAI8LlJGB9GLVgnBt6t4fJaP8aINMCPeFJIA+sxfwri8/PQkCGuBxx9z397FDcDJwE
         eYH2ZdtbSgVSyWcvqJM9ne+dyY3LnMudzpFySmBE9JFZOlzqs0Qh8N8So+kNnyD/Z3wP
         E5TMr1PycjWDjFb7mIhZIPcwZJzZCWYPRasZrcEeK3eJudpyWd/SyQcs7na1/ip0I8OE
         EaEweS40Q1DoAN8q+CgW6c/uD472YpQ12DqYJPEN5oXX73XGZIFBZd5PRWXZiVZu+3wt
         tsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aVpf1rZZckvRhXRHvHxb/bjv3QSgorFsJUTW/to2zns=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=jnGDqjGEdgArMfHXeuNcM1pAwuUXOh2XucohWmsytul2PHyzVzRBMEqa7vjm3EdVdA
         gg2O/EYmnNIrIqg/MS3Q37VVxip5vJy/8QRc6wX/JmH1E5ZgRJrt8bxRU3H8ME5WWXVl
         7IUCZBY6l/jBiLVGuZaG9s+RcZ0geLBh4JeblSIF9A47dbYn0unpWrWYsKf2ArVHEkJg
         C4kbFBFULYuAXO/uURPDY1/K2oUSnbEorFiZinAL80YSWfaE10kb0M0eG0t8GuLORECo
         vQEMfOWQAdu4Dm0JGCf0OptwwrsZA1GgkQZI8nR7XywbugCKkPzKYHnee2PmP8Keyct9
         4UsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363372; x=1790968172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aVpf1rZZckvRhXRHvHxb/bjv3QSgorFsJUTW/to2zns=;
        b=iahFDzzlnMSqk7S7d8TvqlVeZSf4d1IdwW9zw3lshTunUgLpYx6gk9C0RtSjIGq9Xb
         WJZ/YDuCXwnNv0t8/cd7Bz6Q2ozZn9J+BVgfkcjB2qOmUQ212wAyuVPSyPBCEFNWmLfM
         GnQu+RNHoyRNF+NCdC+abdEW5uBNa53w2725sdjYmugIrymdehBMnq6s53Yan9AoexuG
         R9KiBWFaV21gb/FFh+usHBaqksR/FngFwerB0qJqjO3juWfXaucLbXSTz6XAEv2lam2a
         wwPj0jt2SaeginuGixTJDDpKrt0bcdVDs7gDrlJ+4SB5LocAISJlpY3/hyvlVSMCkT3x
         RuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363372; x=1790968172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aVpf1rZZckvRhXRHvHxb/bjv3QSgorFsJUTW/to2zns=;
        b=0gn0fc4VqW2QWyBnraigdOVKp5Y7gyWv6WeyU2MaQDLSDbM+SWaaRlAEXCTFOe0QTc
         bluBSC3/UzIORtRnhGuEpusMDpMbYr281wWp6f7UmuS0yrUafh/nkabaWp3MC6HM/QdS
         +pcnclFd7dOlw4vGohmiFzrd51UOgp+n5On+WRiXR/hyMk3LTB6Bo3aBVIKutctnrUiA
         FMfPRHwBHkitQTkHbZ48J+nsMvmP7hVjUWSlVRGpO9qVq1+yb7Dtuhory59RNVIuwj5b
         eGKRrBbzqImz3TVZvMQwZUyNhkBr7kfVsY5pji3qiLHghKs+lfwe5C38DPcNjjLosG+/
         sCcg==
X-Gm-Message-State: AFuF++lUDTc3ZZ4gSqOxXUEc+rtMA577T5E8miRafdjfrt9yqXWikOnY
	ZMmHyhf/C4TdgtTYM1+PJwDb1g3zSIn8/Q12O6MoNuWp89i69WOtARxJ7APXL51DD+0sKnPiuUG
	b7js1yTxV4gwUCctO6fXCAzAD+CaqsZPUpMCF
X-Gm-Gg: AYBFou0q7Rlw24GAyPUz/9k0HuIRVj7mm53qIoQhpSqQ9tz3Y/wFHqI0IPzWGcZ2u3b
	YRosrCAlE7g2Wwok0Rb8wkOmGVd5b3Sko89gkNjUuoV1bBRiKh54ROjr+sp60zRhvPIdnWuxymU
	gGNWAGRI2PH+V4YmqWRGxfxK269X/fU5GtAietmEuqkpHefwry/sk694OMqsryHpW2N4nLawLM6
	1bfRMJoUGKSv9W5b1NrbMJsriuRpjodhRWNTjHp4WU0YzKpyjO1e0gOIIMB/fpl3MtZaz9xHbfd
	ZWOr1kifm7WRblYQrY6eN/8GtdPSEX8EwEncbBPcp/jIoOYP3fqBoDhJGnLNUYYkow==
X-Received: by 2002:a05:690e:1905:b0:673:4a02:c483 with SMTP id
 956f58d0204a3-6734a02c4e0mr2894521d50.65.1790363372597; Fri, 25 Sep 2026
 12:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de> <20260925171755.2029271-10-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-10-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Sep 2026 15:09:21 -0400
X-Gm-Features: AclHuK8c8miJdtVu6EgGB3x1qApXFLKKyj8yymZJQ_CoJDd970V6SJBFcuvq1h8
Message-ID: <CAEjxPJ6BFCa8g1zj5+NM39ZrXRyzB-vWvqEoQkNWbr==hfr57Q@mail.gmail.com>
Subject: Re: [PATCH 11/21] tests: enable strictness for perl scripts
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 1:21=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Maybe someday our testsuite harness won't be written in such an
inscrutable language, but until then:
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
