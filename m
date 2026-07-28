Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88F19E839
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268170; cv=pass; b=tcqiE809ECFNBwOhKZL/4NRaTT30dtxiT+x+xKSTSbSzk37YsWvlYOXbVUlXNbRzBMBahj6wbxlf8zK4lDdzqgCY40N7rYG0GiwK39GidpMh/jq60FHgRDxEc2b9m2/D++C+9j+8HcDLQ2p2ZzOczzz0qf2/VOMOPKtQAziDYLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268170; c=relaxed/simple;
	bh=R13E+yFh64i8zzj5MSlzfAhTTWIFDNzOTYnO84eES3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+bZy12d/A4so4VmKuJasNziFQRC3MGogrrc401fNFhz/7qmDbszevZPjAmBqsoO6VjfuoapcDE67J10vl8Y+EkU7t/h/oBgOWhJewuAr6P4D5zSL3wq0NSPOc91cQXf9sngXrM468w0iSWmMmMdgC+TN6DwInaHWgYhS39Cpd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZlrYIii; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZlrYIii"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-456395f4e7bso93352fac.0
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 12:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785268167; cv=none;
        d=google.com; s=arc-20260327;
        b=aFH3LHlCx/L+vU1f0WHKSodptsd5hkIi145zGtQzwYIDI215Ch9M5nm9sCFoEBQDfO
         w92DjHFt3wTSGAn3Kqx8L+FAXJHUncMP9QHsIBlzAMtrrgOpfpKEhGtmkX0N9oaSJmo7
         5Aim9cR8P74U2JrJSPx14TihfyHZfDvAUynMBQd//BulrFZ3oTdwrZ1cqJvkAhBrjSNH
         nleBf2PTodhq0fRonow7i/b6mSh/yf1e9P9NapPsMaSmzm7aF+3IL+/zEU3yCUSE+gJW
         IoRy0s+Oos9jphpYhXTLHQk3o/gZqIvC0JRfR2r6L3znbe5htAs9DsgkAbja50qwKZxk
         4rHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R13E+yFh64i8zzj5MSlzfAhTTWIFDNzOTYnO84eES3s=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=O28OkUbl5ddfZkbGqaPJTUhmM4IE0hie8i0msyJjbTbOELZCJ49Wugm+2MBnqqUM29
         EolID3I97KDxhbccyjY0fwjoBDYxeaQSW0bn201q17PQA6kptUSa0ri81pu5IMR0z9Wz
         ICDGNEqFvIGc1hcKElac4VJUU6ec9+TMc9y+Xi96GwqwqJmLi/B0dmhkZJCSI8uKiDW6
         iPevOoR2ziClpgwdRxhPYufu+p/H+bGhQ/WJBRnEpn82nj/+3FgczcGuW7SSDuteXMSD
         5x6945ntNF0aTHpS2YU/+cLATWv0kIOZeZwtunrPoJfGTvsG78CmUQ+l9J05Q/+TIGHx
         BEww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785268167; x=1785872967; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R13E+yFh64i8zzj5MSlzfAhTTWIFDNzOTYnO84eES3s=;
        b=NZlrYIii0OejUlqSo4EVbHRO9UGOZvjBSNY3/o/omf2LuXDz9+R6kY/1bqfzn5BP4O
         Wer/aczw+KkSplPPJdvIO1T/k7V1Bds0mY9F8TqtoZCvWBqsRLd4wO7byjk/L4JD+zqU
         S/IqLmqARheG14CipX7GFcAymOanuUjGcWybVFkd0952IX58+nuN1I6Qr8M/BwUvNvTu
         p7tFAv7PRjLXcYE9o2tpMrFMmuS1+LYD+7+pxxtPblpYBBREAeW9guFl1+a0xSHh38kO
         hcZLz9JXKGsRD4LIXMJ2pviEJYwhXM3A/YnRGNbdzrefLQKq0R0/VVdYd8jACZHL40v+
         C9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268167; x=1785872967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R13E+yFh64i8zzj5MSlzfAhTTWIFDNzOTYnO84eES3s=;
        b=ds86YKLPzSGPa4w0GN0nL8ASVSGnFDv34XcAbluwsWV5rbM9WXOm7cOmQSLAYnXTIP
         1Qb9yYkI1XasLNYAwIqiv31gJtmVSv4/sZiZkQbktY9jnuro0EX1OQuCEIaeJO5+NonQ
         W0gqq9TOebUmn9NbzZEVXe2naZdlByCQkGsPNdJEXGEXYTrJ7Fsg7M6RbrKSgEkUNxqy
         kY2aiVNXUz9TVHmax4YsUKDwincD1zpjeJlKusYoHvMlzLRTtQMF4RFNF+TDy/YikX0j
         fXnT7L4Io5dAy58pOygPxhQW8ZfQQvXC0GOnPLb2RFO045tAGKgNxGCOcaDtuZ3nXzIr
         Nv+g==
X-Gm-Message-State: AOJu0YzBhKS6t/bYDyqOVTPS0AOyC4oJsqVfS3V91r+4mAhuVW9fqL22
	iHC/TvSoZiCVEwaAJcIgpbk2aOx6uq1UyCoKrY6n+nbMoQbalCObRMwxGiFHkfz2DotwLGBOiVc
	ZVQ0b4vked9Ibko4wIoegGysb9nggVLhD/w==
X-Gm-Gg: AR+sD12RnFB27/5plVt/G0ApKhzZLRAGY3yT5vyEc22GCaVHxuYJXgDz/WTKtHUaGrS
	3Icv1h6ElLhUeSldpOc6fjCHZQv8tly62aUAH0CcX/hl4WOstTFeVxtwBeIUQUmPJdNEEN3TNk8
	mkFHYMm0bzIo4ABHksOtlHKsiIrRXRUhmX9LNUsROSC7a+uBCBqngqOmSqLsf/qomYp/BTeIJZ7
	x0lEOseBIsmSfnwY0Et/HntVWQL8XMqocOs8xHBwB20iIk5SRVySkw597uvQg==
X-Received: by 2002:a05:6870:ac28:b0:456:5873:3b56 with SMTP id
 586e51a60fabf-4586c9ea3e1mr2372229fac.27.1785268167551; Tue, 28 Jul 2026
 12:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727073852.283623-1-omosnace@redhat.com> <CAEjxPJ6JJWbRtw=fQvydOy5QqGLh5ZGZKCnJB4rXaxqzEddJ-Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ6JJWbRtw=fQvydOy5QqGLh5ZGZKCnJB4rXaxqzEddJ-Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jul 2026 15:49:15 -0400
X-Gm-Features: AUfX_mxz-vFsotuEFqVeH0lG5q2ED4_-qRY0bUyRlFh4VFcFWLPGs6XGBkJlQDg
Message-ID: <CAEjxPJ5n=bYtrNc3GO=AJ9yodcjeGKQzRAtRD+rzKdiQs1sGrA@mail.gmail.com>
Subject: Re: [PATCH testsuite] tmt: allow nlmsg also to the ssh_server attribute
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 9:32=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 27, 2026 at 3:42=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > Without this SSH doesn't work under the latest Rawhide policy and the
> > test run fails to complete successfully.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
