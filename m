Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20163B9
	for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540608; cv=none; b=b4jR5NKTIP0/MGBAAkJenrNDYFCrwdXZQIzlr73TrDhw8hm8pPiKBvjocCtdnrqirVSVHY/coeh/j+4iFraaF60o5R/F2ulfhZdO1OyFoNTb6gVpviEuSgVmn6YqXUTUNiWeW7qRNwPFIQ8h48q7CuNeCo1hSU7UPr0nnEISw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540608; c=relaxed/simple;
	bh=Rr/7q1BnQMWlqFiVjKMr2/ypSnDjlhWM11/TTeMoox4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLiFYZ7/bAEU+s6KVuCG3ur6Ap7cJefdSKjD5yGLJ3mO55iNIyMXvPSrrnL2NKLXlE1vBtF6bETN0BZ2fT7mDzsEaRzKny1tCdX5yd5SBhTuhMp1/TQmnygZ0NMgADIRJVpM9l/90vQKdxfs+oJeTonW+7c1IEGSd2nedPWur5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRXYWgP6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRXYWgP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749540604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr/7q1BnQMWlqFiVjKMr2/ypSnDjlhWM11/TTeMoox4=;
	b=IRXYWgP62bIloODGLFopyhGsveW3PUX3pZIMXx6sYby28I93onuSw6zLaeWN8WFfbtWfAu
	h92PMgoxHS3Ega7rMB6r2LkGZJSQewzTDVb5Fl0YZJHiHcJN+SEl6Z6i2wd4Tf9wK5lgXt
	90Mmd9UDEXEMYQ3JKS8rY6UhAEu8sWc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-yf2EkenHNXuU1TQdjmAP1g-1; Tue, 10 Jun 2025 03:30:03 -0400
X-MC-Unique: yf2EkenHNXuU1TQdjmAP1g-1
X-Mimecast-MFC-AGG-ID: yf2EkenHNXuU1TQdjmAP1g_1749540602
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31332dc2b59so4670602a91.0
        for <selinux@vger.kernel.org>; Tue, 10 Jun 2025 00:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749540602; x=1750145402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rr/7q1BnQMWlqFiVjKMr2/ypSnDjlhWM11/TTeMoox4=;
        b=XCphc5prhwLsMX5/VHLkVrVCS4QP6d7alvPB8OMwjYOXtv8DD8Jgijs0mAd5UwMAnu
         89/JyZ5UEb8wHoORp1sPf2DKjyfzrlppRsAjz5HdSD+g+zNkMYb0vsw8B4LEmkafgVxU
         itznd6/VHAhasVJRiu+CpMb4shEFVlNAFx+6EeQIp1cq7IG1FNj3WHdzLGVRdYGZZy1b
         HlL8HLrjm96dZb/0SwTib+s5quuqRR+8g3YD+QF80UMWR+Nddm0Ae62aDaeWfLnAAj2Q
         9nn2CD74GHJg2vPe2rNRZxQ4K2MfKDmuW9Dqe2EV4XzEupseyJ+C8iCYXOFoLxN2W3cO
         tjZg==
X-Forwarded-Encrypted: i=1; AJvYcCWTkP3MR2Zo/ZtyRHWoZLExcctZ86hWcYT3fcRe2OVEDFWuLl1qhMUJRLi1d20sYcwkxf6Ljn6T@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9iXRs+X0pLCuxhcQdZ2VrGwNG/KpqN8FCRAGZ30EjxWkT3rH6
	beskRlGd8jX76Tux1SX+QNrBvvki0BnVdPRERE1O9rS4e6MdM5FmyBtYPZg9j9V7I21dErra7NW
	T4m2+nuJKIWxfZd6vMWGVdUsQtiIBj7WEN6zDBSHEoW5jTYzsd6sjymmakkedEKxdqTUrTlNmSJ
	sTJo14PFOXTsQVRvzJfSJnFa4EqBksXRPBfXFVkvdDSCiY
X-Gm-Gg: ASbGncudrvTom7NseoZijWTX0SiSUwOxTswPaF0TNeyN1arWnwBy6WPjEatE/AhK592
	hxKhmbONVWsHxv3QR0JCfCFissburfF5opKQUy0O8G2s5D5VHRaq4wwOiLiRN8CwhqP8nENWyV6
	8guA==
X-Received: by 2002:a17:90b:28cc:b0:311:fde5:e225 with SMTP id 98e67ed59e1d1-313a157cf8bmr2499335a91.14.1749540601770;
        Tue, 10 Jun 2025 00:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlY6bK7jq9/vCPiagg3W/MG4nsQcMihcu6PFMOjgUqJbzUpRzxwz+vyQaIVovgwoGA36KxHfA8PkzI3bUWQPQ=
X-Received: by 2002:a17:90b:28cc:b0:311:fde5:e225 with SMTP id
 98e67ed59e1d1-313a157cf8bmr2499305a91.14.1749540601223; Tue, 10 Jun 2025
 00:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609065841.1164578-1-omosnace@redhat.com> <CAEjxPJ4YiUQpFNwxhAix3CZnXF9Vkbn5Vbs8_Kp7zDxCoevouQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4YiUQpFNwxhAix3CZnXF9Vkbn5Vbs8_Kp7zDxCoevouQ@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 10 Jun 2025 09:29:49 +0200
X-Gm-Features: AX0GCFuRHz5e2qH22hzrbkyGb5hIrmCxpUOuQopF46rUSrnCR2QqIZFlnME1x_g
Message-ID: <CAFqZXNsHdK68Cv2peBUk+iP0=b99VduMOpwNSxXoYmft3PoSDQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix security context comparison on execve(2)
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org, 
	Guido Trentalancia <guido@trentalancia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 2:45=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 9, 2025 at 2:58=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > selinux_bprm_creds_for_exec() needs to compare the old and new SIDs to
> > determine if the execve(2) operation is transitioning into a new contex=
t
> > (where process { transition } and file { entrypoint } permissions would
> > be checked) or not (file { execute_no_trans } would be checked). It doe=
s
> > so by just comparing their numeric values.
> >
> > However, after ae254858ce07 ("selinux: introduce an initial SID for
> > early boot processes"), we can now easily get into a situation where th=
e
> > SID numbers differ, but the context is the same for both. Specifically
> > when the policy assigns the same context for SECINITSID_KERNEL and
> > SECINITSID_INIT - in this case when a process labeled with
> > SECINITSID_INIT does execve(2) without a transition,
> > security_transition_sid() will translate the unchanged context to the
> > first matching SID number, which is SECINITSID_KERNEL, not
> > SECINITSID_INIT. Thus the kernel thinks that a transition has happened
> > and unexpectedly tests for the file { entrypoint } permission.
> >
> > Fix this by checking the SID equality more carefully, trying
> > context_equal() on the underlying contexts when it is necessary - in th=
e
> > rare case that the SIDs differ, but both are "initial" SIDs.
>
> We check for SID equality elsewhere as well, e.g. file_has_perm() and
> selinux_binder_transfer_file(), ioctl_has_perm(), and
> selinux_kernel_load_from_file() to decide whether to check fd use
> permission,

BTW, this case already has quite a tricky behavior, because if e.g.
only the MLS part of the context differs, you suddenly need to have
the something_t self:fd { use } permission allowed for the fd to get
passed, even though policies don't seem to have that commonly allowed
(at least Fedora's one doesn't, based on a quick sesearch). OTOH, we
can't simplify it to just comparing the types, because the other
fields can affect the decision as well...

And actually with the entrypoint permission it's even trickier,
because you are forced to allow entrypoint to any type pair that can
wind up in an MLS-only transition and then it becomes possible to
enter the domain through that executable type even from other domains.

> selinux_file_permission() to decide whether we need to
> revalidate permissions, selinux_binder_transaction() to decide whether
> to check binder impersonate permission, task_avdcache_search() to
> decide whether we can use the avdcache.

AFAICT, except for selinux_binder_transaction(), here the implication
is just that a slower path might be taken unnecessarily, so not a big
deal. selinux_binder_transaction() is then a similar case as the fd
use permission.

> I'm wondering if we wouldn't
> be better off just ensuring that security_transition_sid() returns
> SECINITSID_INIT when called with SECINITSID_INIT and there is no
> transition defined.

Not sure if that can be (easily) done, since security_compute_sid()
has tons of logic to recompute all the different fields (user, role,
type, mls) independently. We would need to carefully track if anything
actually changed and that could be prone to errors.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

