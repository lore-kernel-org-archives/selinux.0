Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1D2EAD10
	for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741252; cv=none; b=hGlDC0sLR4rRcnjNsxzByVUWjGR9DicunHN36mx3+fUt2h91P3bUcqD1P+mP7OoCCYUHz4/qN4DGPIMx44ip9kTfRFDajPmLqCNPDyLJXMLEx7Q+/KFO0UN9vyyTtxv32QLHk6jbas0zQdcNImmKXr1UmQl3c6G1V0cW5SlyzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741252; c=relaxed/simple;
	bh=l+a3UVxbVzC8QVymBudyiodZr85MX0z96VARh44qLH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ+das3F4LVdaKn/LnX+ay2J49xgKj+zc2+Grua7u+jfYaOXElepE60pdnHZj/gGU9SUOe3L3752ifY2apQnhBShVMcZy6IHoN2wksamDiEOit84bzbAiuk7tXB5y7CZzBhHWo/Ods/LQZXEkpnsTv7D6kTYbzLxti3gzOCs9YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwImUwOW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcmiChgj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwImUwOW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcmiChgj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763741249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+a3UVxbVzC8QVymBudyiodZr85MX0z96VARh44qLH8=;
	b=GwImUwOW3Wjzl/3avYsSLOVGHk/RzRPgL5Nhd+zIHvBZPXKD14ihFn6AwbxVA7iyLpU9Wn
	YVSEWjoQthpLmtSE2p2aLTVSNQwaftsm1931KW9S45wz4GLYqsvaloN1vtI9fDzaSPt4MZ
	GjZ81eqjsAu3LaGCSaBVG5rIjEkSQk0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-5bHdj4NqPcm5W2tI6E_A3w-1; Fri, 21 Nov 2025 11:07:27 -0500
X-MC-Unique: 5bHdj4NqPcm5W2tI6E_A3w-1
X-Mimecast-MFC-AGG-ID: 5bHdj4NqPcm5W2tI6E_A3w_1763741246
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-345b4f2a8e8so4342898a91.1
        for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763741246; x=1764346046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+a3UVxbVzC8QVymBudyiodZr85MX0z96VARh44qLH8=;
        b=LcmiChgjoxEKP7P41Jk71Gv/zaibGZkMuKQM+1n97QImjvlQtdWU1MHf2MU7CyxPoe
         FR9r2B/EbXnoYcPsc43eWEnoueKLMjEvJI0aLkN8gSOn2UY3humqrYUOIC74SC3Su3kR
         QBi0Z1lSzKHbxsKQRy0RGwMgXbJJS6RcKMpzsbJATiMRdn+BK1jSfZcX+r5/dstEobc9
         bHGvj8OeZkc5V/UehnFwnpk2L6YYL//zazfEKoeQAmknBgMTwS+TdZgxhq39RLNAlyHW
         mSAmTgsQ5ZpER4BZc0it3SFhxAhFQOdDgn38HroyVLJNgcbpErKBRrcD3TnbxSXAI20A
         10Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741246; x=1764346046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l+a3UVxbVzC8QVymBudyiodZr85MX0z96VARh44qLH8=;
        b=IMC8xUp2WZVl+3zoU7VG1l6ETVt+S9aAAuLQbJgqftgUuOV9H95J33+lVIRnf+P2sr
         VmJDNoExfmeR9x4wHHeAUfAgLHYbnKBnnAKhISEVmXj1qilwbOIqo6knkjilwJ1r/ZzA
         UHZ/ISkgNbY0kT4hTzWtxDqEb4Bh2io2qLbeq9hZSRM3ird0fvlu9PWIKjp9DLs3tTib
         pzAitAU/9CQ8CQ5XDSWQUkBfaCHl0t3+pgPMPEwM3a5TlhxO+VcG8m0rvQtANlq2Nrlb
         dGmLUDvp/vbgus70vdCI81M3GTggrXIgWGCBbRDgldYZN5Hfs2Bfeurhoz9LHdj8508v
         MZdQ==
X-Gm-Message-State: AOJu0YxOU9oAIeCd3CaFbzH247ozvPPnCNxe2CNW5+uwRRQ8FtkZmOT1
	SQ6jZTPpWZhEhqEYa4v7M13G035RKL1pooOvCwaOT8B/MyuX+e34RkdnbJpfPaoUaeMKObaZeR0
	vi9TyTJh5k+pM9HfdZSAdNw59Vag2BKJR1Atq72wdBTTq8rJyAIBryZF0RjBwLsck8iwImDqA36
	uqbTaYulI84myBpKoXGE983DqtMhy9xj10TlMkDaNpPx0p
X-Gm-Gg: ASbGncsHDbE8eC9P8gfovKgkJj2N5jKFMzL7QGSYqhOf0BHpmVfRL/wSU1M9c5tnd9L
	KlXfejIgOAN3zuIo3Mc6YdmSs2ANIz8yAk5x6WCLMc7wlsh4J+hpdcqNpHuKMDgvwcIXDFVdJuX
	DCApwknPjgdozrOvaZpZ2WWQDQYwmRQXdP8AAeMsEZheYiEpM+UjFY0bUSwd3iBbCghP3TIyraj
	dDOa/3/eDUKYX+L8vvnYdc/C9E=
X-Received: by 2002:a17:90a:d40e:b0:32e:3c57:8a9e with SMTP id 98e67ed59e1d1-34733f5b784mr3410303a91.35.1763741245725;
        Fri, 21 Nov 2025 08:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDmgWjTkummvtHXSOwPCjXKuUivvKg+V6IeTlgPwYDKkOsdNYAfOhRzBDqprn1rjWRdXrSvHRUAnFQzS1thqM=
X-Received: by 2002:a17:90a:d40e:b0:32e:3c57:8a9e with SMTP id
 98e67ed59e1d1-34733f5b784mr3410279a91.35.1763741245343; Fri, 21 Nov 2025
 08:07:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121082038.735276-1-omosnace@redhat.com> <CAEjxPJ7BkZ39UfpLhQjx5L16Chzu6V+0tjYR_1Vhnir2fK4mvA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7BkZ39UfpLhQjx5L16Chzu6V+0tjYR_1Vhnir2fK4mvA@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 21 Nov 2025 17:07:12 +0100
X-Gm-Features: AWmQ_bmZjtfJ4CczCgxTTirpKbuR6Qx_NZpl27DiXoX7lPbfq90W_AJYBfcMsac
Message-ID: <CAFqZXNtkMU56VU0=-RQ-Bymoq1aXe56hskaf+LYgA8YwaFKFFQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: allow testsuite caller domain to ptrace
 testsuite processes
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 2:46=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Nov 21, 2025 at 3:24=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > While this is not required for the testsuite execution itself, it is
> > useful when debugging by prepending commands with 'strace ...'.
> > Testsuite domains outside domain_type() aren't allowed to be ptraced by
> > other domains, so the permission needs to be allowed explicitly in the
> > testsuite policy.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/02f55421df28861a=
1f8292123e530303757329d0

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

