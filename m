Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325112AD0C
	for <selinux@vger.kernel.org>; Thu,  5 Jun 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127568; cv=none; b=B21cH9huISn3Db4mMouhYY9OU9MBeQ6Clt2m3J8cps39aHp6U8SqEjUJiC+XTnJ7YVqkVl4VlPD+SceSWHNje0mEMuDjxYNvoVNKWL8RqFqFv2lNA5kQ1ih72BmuPhah8GipD+nw/6552SRg0mT/2Bfvlmf3eZW/ZgpEJNInlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127568; c=relaxed/simple;
	bh=3naUmURdAhGtJTCFCksdJU1C7vp0CYOOR/ZlLunETME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN9IfKbxTbQZWfr/cgSuwMMNXyf8pnH/pHI1txJB4b0FrWgpRN0S4DTkPBQK2WWyxF6sscDhR2zkIJA9R8eHBoOdXj+lDMEk57So6+s2cSWWuCrSdlb21XRrTDM+PtNlBucNgaNfuCGs5dX9RtY49i/drmhFTGt5wIKOEdEOp9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GJo657DM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJo657DM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749127566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dL3tEa4NUL/2XAjFqfNtlWaq+37EHnochldxIJyV3dY=;
	b=GJo657DMvEwEoEDzLXVKrqFoT7dBFRMoZwagWUcnCkh9N9VJw3ypvgBZooa2cfkgMm5ZWR
	akPx6sXENshrZ7YNyneW/QzH5RWoaMuzvNCWxmIsd4wrtuE0iS6ZcT0sS0k8jSpcaRZ4+7
	kkAZ+JMqLbeBh2tyxYcScxJlTdep++M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-YkS7IKlqMgCkE_1ZPmpl0w-1; Thu, 05 Jun 2025 08:46:05 -0400
X-MC-Unique: YkS7IKlqMgCkE_1ZPmpl0w-1
X-Mimecast-MFC-AGG-ID: YkS7IKlqMgCkE_1ZPmpl0w_1749127564
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311e7337f26so823531a91.3
        for <selinux@vger.kernel.org>; Thu, 05 Jun 2025 05:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749127563; x=1749732363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL3tEa4NUL/2XAjFqfNtlWaq+37EHnochldxIJyV3dY=;
        b=OLhtgyonaA971evR42l2WOjYa1H5RKgPjIt8ay7G9trvqkqCeGUQcfSLCDnzxtnNic
         n/uA5Pa5cfo+Hd6okuUsdNVbiBeNSr5tH0aX/3k0PjfH8VBJJHbvOnsh+CgBlomZDOhe
         3JHn3Dj+yfhbVnlptxZHGUBCnjfR7XI2t/3RS3cwA8Doy6HlQcqybWKWX6uN/NHXQNI5
         N996sqeHlQMs6HhgISCTVfOaexL+fFhpj6Ykv6hVJXkD5MGC016pVGnDOBpMc4IwcAlM
         oA9R7xzddIsrZQ4tM4XxUB8dkXrc1phYEWlvpVN1MmTHGjkIyLkUdteQvRmW6aZdVV1E
         M/vA==
X-Gm-Message-State: AOJu0Yy0LoMVtetR9l0+SMT6Ijw/JFz8VBaC2lVlw2oeNsMD5tIE7hfR
	mFzEOI+c7EWtVLcwSZTACIIgphmxATgKUjGeY9ktg4MRH14XSGKdVZPtBOq35ocAfpYvuTOoa0J
	362utVgsJYpi2rQDw6AmYYlwvFjWo2Myl2xLPE9nGUbUsYSJ9lZ9OWx4fmTrJ2pLEq0NqCkW4v6
	Ias9MgGKSuKNpM12rUzVZzcfOTSKj6qKe0jG/zVDxSt/ff
X-Gm-Gg: ASbGncsOt+WIq3SczOgrfoy9vZZfv7CED/xH4J5s02AvZDdzIHjkJEA4PBl1Y9/0yyM
	JwQ8UL9JWj2Cu7cSj0d5ZrUYoN/G4PQs2f8o8OKpPhbv6a2/TyJ8JwnzeIRaZ3wl/QbY21JURFg
	SXG1/ksPaTHf17hfS77HGpy4YvFw==
X-Received: by 2002:a17:90b:4ccf:b0:311:b0d3:865 with SMTP id 98e67ed59e1d1-3130ce9b496mr8820833a91.32.1749127563377;
        Thu, 05 Jun 2025 05:46:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtuKUoDrFByc2fqGNyrrjf9UpLoNGAU5wx9A0ZKiifjUfx26ADwmg09QgzyG9ADuWx9AKRs5rSkLBDk4z2AqE=
X-Received: by 2002:a17:90b:4ccf:b0:311:b0d3:865 with SMTP id
 98e67ed59e1d1-3130ce9b496mr8820796a91.32.1749127562911; Thu, 05 Jun 2025
 05:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1748100564.11369.2.camel@trentalancia.com>
In-Reply-To: <1748100564.11369.2.camel@trentalancia.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 5 Jun 2025 14:45:51 +0200
X-Gm-Features: AX0GCFu_Q9YFQ3GIJ4jbQRvX2h-gY6CK38Z4Gp8lbyGISkZQ6wLRppp0GOjNgAY
Message-ID: <CAFqZXNufHFEA8304qvTi8znWUmrznqyywWMDJYgBASN+VbvLSA@mail.gmail.com>
Subject: Re: [PATCH] Only set the initial SID for early-boot userspace tasks
 if the policy supports the new capability
To: Guido Trentalancia <guido@trentalancia.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 5:32=E2=80=AFPM Guido Trentalancia
<guido@trentalancia.com> wrote:
>
> Before the policy is loaded, only set the initial SID
> for early-boot userspace tasks if the policy supports
> such capability.
>
> Check for POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
> otherwise preserve the old behavior of using the
> SECINITSID_KERNEL label for early-boot userspace
> processes.
>
> Fixes: ae254858ce07 ("selinux: introduce an initial SID for early boot pr=
ocesses")
> Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
> ---
>  security/selinux/hooks.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/security/selinux/hooks.c  2025-05-24 14:37:45.499997561 +0200
> +++ b/security/selinux/hooks.c  2025-05-24 14:36:58.453997848 +0200
> @@ -2319,7 +2319,7 @@ static int selinux_bprm_creds_for_exec(s
>          * early boot end up with a label different from SECINITSID_KERNE=
L
>          * (if the policy chooses to set SECINITSID_INIT !=3D SECINITSID_=
KERNEL).
>          */
> -       if (!selinux_initialized()) {
> +       if (!selinux_initialized() && selinux_policycap_userspace_initial=
_context()) {
>                 new_tsec->sid =3D SECINITSID_INIT;
>                 /* also clear the exec_sid just in case */
>                 new_tsec->exec_sid =3D 0;
>

This doesn't make sense - obviously you can't check what capabilities
the policy supports when it's not loaded yet... Does the current
behavior break something for you?

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

