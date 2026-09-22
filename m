Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330154A64C5
	for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106240; cv=pass; b=ZPjdeyv9gHavpMe7myAVl7TuZMyf37EvGqVIBYEdnpm9/44PrxVUDfiKjqQLURcjOnEv6kprlMN/tc68akjRAqLTBMnH9Q707NODkrS6XaKfF/nSW00gMXUlW88RIfJiIYqueCNJCMwAaU/EGMwrMc/tMUMQHYiwT15Ra6svujo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106240; c=relaxed/simple;
	bh=IUqcPMYUAajNUcWRZnNW7bZnFSY32BIBsPprMg+GRDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ni1Edm0f9LCTaxudfVBgRTEI5RWFUwHal1/osaUBUvUZSa2tGW8u0pVrrnhA3h6jSolK749781AncqfGSJdZjqFz7dAh9W8OU3U700Mlau3weyHVywqwFeFrz84gGyWoMqZDbSMfY9oYMf298xZcomPcA94wV/eM0B7tTgIJBdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Owt8Qg85; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Owt8Qg85"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-864cd11a932so7192897b3.0
        for <selinux@vger.kernel.org>; Tue, 22 Sep 2026 12:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790106238; cv=none;
        d=google.com; s=arc-20260327;
        b=S4cPLtLBRQm/em+SxsuP0soL96p7Z1gWDZQ4i9DJv5Pu6GcN9DFhu39q9sOOAX+PxE
         +VJfjI9wHPrr5txdjUFjzx2dZruo9M3VjOZFe+AnKY7+qr7x9rRu8OtABMa5bNqS1E/6
         fds1RkLhsUealCftnDj5yhfBMGmZqZJLjVijVEFqI/jyZHXYe1p9FjAkLwiVCmw8yP2h
         97AgLpZzZDcxFYfBQBIxoa9NNgWold1HY+ZAnFGjoy6Ldl4Tx2UA/VDtGNyTHByBS9Lm
         RuOxKR+LoVZO2JfA4+NCOu3iwNmElWL25L745L6eJYaMM0mQ1FFEFaHmZq7PMB9abXgq
         YZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IUqcPMYUAajNUcWRZnNW7bZnFSY32BIBsPprMg+GRDA=;
        fh=KcNbqYfh5/rp+3O/oy/Rn1Jlbpp64wJ640nU1xb/jaw=;
        b=qqj+BECr/E1PeTMDMjC4f3m+Skt7AkosV8ZAle8Vr/gDNKTcK7R9NaWO38k65y0/ut
         NZU7CoYKig/6P5yd5l2HwKfqLjx6/Uun+A2c2+7t8w0biGvWCp/S042Ot5GGkFu7GWZP
         bXwm5IeYVuEIQvNRtEcszSvHFjUxutynwW/ib+1g9tEGXNTjQJoCgvPmHJYdVps/XG8A
         ZT4WO9nef9nDARwKw9iGhbnynMMDfKx7W7PUJ8AMC9f1/VACSG6ZepxRomtHK5UTbJXC
         p2mYjoYA6WHCOHTF8H984qevk49hVUOCm2fBdolrKZ01VD+Ado1h7/a5XnwTx/vzh3x0
         GiIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790106238; x=1790711038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IUqcPMYUAajNUcWRZnNW7bZnFSY32BIBsPprMg+GRDA=;
        b=Owt8Qg85Xbzf41iVjIMxHsI2rEie7TP/qC/Ft0gZs+8Oc/l7qxXu65R7kvjuyKTqRc
         fHVE/OuwMDLgEsQEP1reKkLVlyKeF+QZoTFGOx8kxRwd3we3zHFN1+u90xPdSUzRdBwg
         TfS8PeeoVHyouN5uagaHJHCbotoFE8jGX7eAJ7nKYhmdgn3W2BlR6ssKZXWA0kpx4Ggz
         W8E5JGJ6GvSm6KniMukLx7ImolVGWX77n+jmkW8qGHoOuLe0+P9zgzo7y08oXhM5LuRP
         C/9huIeXDdoPTJ6VF5Fc3rbUHqeyavaBiBApxJaC9D89viNBLktyTU6KFhXFwilwEhxh
         xJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106238; x=1790711038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUqcPMYUAajNUcWRZnNW7bZnFSY32BIBsPprMg+GRDA=;
        b=SwCJ7kqMVXnT9BKkQc8ZLXnhkBVJCwek1HZ6AoZA6W0LWap98JW73873GC+q9RBtoC
         b/PkzNFedPW3+FAKKj8B2toV9jm1UKjQDKbHmd30hgzM4pjh6CEdbdIEb44x0sLzKZ1C
         lACIuQRW+cQm67gfZLUO/tpWq5DpcUEFkqWZyL+ipXflAPLxt4jPo244CIDTRhdRcGhh
         BEslMU9hRKA2hfSFQHGZtFabx2ioOxigvF9A0RzfYkLQNCVNJC40hABl542MjF4mpCwy
         NXUc7XpWpB5HkS9dNmFAXFi+oBCBwG30cQ2sMdhX0KmSgmQz97WWtbRocc4k5KfQuYaQ
         kQkg==
X-Gm-Message-State: AFuF++luv6lDxJ3fCNw1Huw+7cz43vwwN0eGE9jcXlIEiGxXCBvCI/0k
	jpGYLWsO+EV4m9qujmeDm+FsDWc7CldDC2gytkC2B7Vh96ylJp19aCl+CnuOQ1cUke5X+4bxoRk
	JZCyP6w5+pAdBJp+Lin4qV3OHN75Kt9jyQg==
X-Gm-Gg: AYBFou3BPQMTZnmA9vJP+Io1huMYkyOuN058mbhrQXEJ40KlmFyKkrLIFA16MCk1o0S
	hmmtcYEiS5+I8d6D/a/rndGQFBsTaVW8M2ugYR0CQ5/6ggsnw4bOYXvP0vkUnY7afRfmBq7J4wX
	rlXP5mKYHLctZ8tfuEcaFAjst+QnsRLZZ8RGqHQ0+ZJxxXvJ/hPA/ozylm2PaIGh33rkapXOWju
	hODUfEKD7SXWKt51aBW0HXBzWwc8zzqFSYp0ZonsFp2F4P4AFX2IV0oFDwhWZNZW3YJ3pa4mBkA
	cGi+8MQsIXk2rj8tXdUI/0uYpGcTvaWexqufvRiKMKzJ+RTPPMIRlvc=
X-Received: by 2002:a05:690e:1442:b0:66e:3f5e:d9d with SMTP id
 956f58d0204a3-672c29c4e05mr2189468d50.24.1790106238006; Tue, 22 Sep 2026
 12:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922160859.47233-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260922160859.47233-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 22 Sep 2026 15:43:46 -0400
X-Gm-Features: AcwNN1U7qb8TW6mXMbS3J6SicmKXDJaNPUbDsgZMYQJOrJhVHl469U0WOefr--o
Message-ID: <CAEjxPJ79Uh05_hBOn-_+Ny73hT5EKC0Rz4KPQtc=sEoeDV1Veg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libselinux: export selinux_policy_open()
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com, omosnacek@gmail.com, jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:09=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The configuration-root search list added by the stateless series is
> used inside libselinux via the internal selinux_policy_fopen()/
> selinux_policy_open() helpers, but external readers of policy
> configuration such as mcstransd and run_init still open the paths
> returned by selinux_translations_path()/selinux_colors_path()/
> selinux_contexts_path() directly and so do not fall back to a vendor
> root under /usr/lib/selinux.
>
> Export the fd-returning selinux_policy_open() so those callers can use
> the same search without duplicating it. The FILE * variant stays
> internal so that <selinux/selinux.h> does not need to grow a <stdio.h>
> dependency; callers that want a stream can fdopen() the result.
>
> The search remaps paths under selinux_policy_root() only. Files that
> live directly under /etc/selinux/ (semanage.conf, restorecond.conf,
> newrole_pam.conf) are per-installation rather than per-policy-type;
> the former already has its own search in libsemanage and the latter
> two are handled separately without needing this interface.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 fixes a typo in the commit message and a missing ')' in the man page.

This series is merged.
