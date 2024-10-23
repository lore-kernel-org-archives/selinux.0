Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27817ADE9
	for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674849; cv=none; b=WwTGxQSLJtTNsNVZmpNwLWQP7e8WKLso2PyL4wNlotUmvA6TTR5P6ySlJeJFNGdwSr3/M9I8aDl18M2PeVhmmj0CbxDVHk9Z38CuSc3lUnzbbJZbNTJ+tAZbHGhL2I+9zRfgtzU+2+eKtlYOWejdWyrMP7XlpdDaRr1l9YKhNsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674849; c=relaxed/simple;
	bh=VKqPG9ff0h3kVUJkwBz1nHTQF3Ux61BO416918CAlec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZP7Ca33EyHJtoeLCuHgWUi/OXwzJeufo22Qb9dxgJkLurnQmPtaWIMqmvf4+Nqsww3LWFhK9P2AU4yHv+x5QL+FrpCE8nsGg6SsD+C8N7mDrINnA49mrTtxg1qTOOAlIbDzGT17+7cYvasSgQ6HTxOSHJSlnVNj9SA8QutMy4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6txyLSt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6txyLSt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729674846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UKQVi9ZRHbgYRMmFed8trQlSU0A4QxgRadvpuo9XoI=;
	b=K6txyLStH5ItfdrSmYmlqBmOijlYmnARl8r+q9+VMj3vxHWF1Vs/KBKfV9IBW0SpC5gLFk
	vRv9umsasmMpsXfew3XF+zfo+cxtc4cN/r9vStjBxl8jFArsqu608XAmFjcMvGfihTbiHt
	B3kOQ3j5wWX7yG1A1ZOkMFSYgUFKxn8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-MGW-VnLbOzmZ_V-jBagWOg-1; Wed, 23 Oct 2024 05:14:04 -0400
X-MC-Unique: MGW-VnLbOzmZ_V-jBagWOg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7e6e98892e1so7389859a12.0
        for <selinux@vger.kernel.org>; Wed, 23 Oct 2024 02:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729674843; x=1730279643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UKQVi9ZRHbgYRMmFed8trQlSU0A4QxgRadvpuo9XoI=;
        b=pdf0eFCDCAWTvzYtOt1o+vF6/ei2WO6OiSAnJt0NIAMPEA3VPJ6kCcyW32AWk+Bh8X
         xjsc87hnxBM3xibYZs5WjIrLnoQzbQe4ITLGhVIHn1Xx5p64qL7pPYlLZY3tDR77wz6S
         hqWgKLwFnupAFJSuq/TJFgRVXrUlZSGI8QxuGqaZgj8eEzQ2KTgPW5iG/2fIcFM8jb64
         Dd8rw0vf0MJlvHE9UxQnN5vX5gn9jJm7vSugXPCF60oRvZileFRe3fUzcfNdlbZ6arxW
         CWZrpJHSiupCyf61I9KyC9RLefSTwOz/TRXyHNH+dSrvclP0WwpbJvh0+rBXnvE4t+Dl
         MaCw==
X-Forwarded-Encrypted: i=1; AJvYcCU4jWJ24LSF5DdO7Bu0fUesFXSJ9DReTCmsP5a65iXW4Z3oOxWGtim/l5Wg1V5Zo9IndtuAvT4z@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBAO54vP8CtsbfIgpyYAYZ1gLwYkBNU10OnRKY2TqsOmXgXml
	qdM79M1DvS/OFzFpRi2ai57XOFBfHKBZ7WybDjTB9hOiEPkx5woee+Mnys4yZTuWeU0sb1jZiwR
	OZ/qPYGeOItHuYiyWKw6inGmDnowParIJNZwmci4pGsgRxJPBpIGqT8HAgnfpvGLDfBcIJa7B5N
	2R+rsEOdy4AOJJjQ1wHY20p2pSZk7FB0FE2cXkMDkW
X-Received: by 2002:a05:6a20:e188:b0:1d9:1cea:2e3d with SMTP id adf61e73a8af0-1d978b97e5dmr2130289637.40.1729674843588;
        Wed, 23 Oct 2024 02:14:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaNaagqg1QQDEla2lskHrj5ZEEIJmtNbu/FuIH/cc9dbSqRSWd5zHSSuksUd+gQNkoS2SMhokovo33UBxoN6c=
X-Received: by 2002:a05:6a20:e188:b0:1d9:1cea:2e3d with SMTP id
 adf61e73a8af0-1d978b97e5dmr2130278637.40.1729674843275; Wed, 23 Oct 2024
 02:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7JTbEk-=r=Lnjm8MFC1VRn49wWjLUKsfSk=eAryt6S6A@mail.gmail.com>
 <CAHC9VhTUWcZFr8HZg3gHnqgZ2PAUazpRX71Jpue1b0QUCEJKsw@mail.gmail.com>
In-Reply-To: <CAHC9VhTUWcZFr8HZg3gHnqgZ2PAUazpRX71Jpue1b0QUCEJKsw@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 23 Oct 2024 11:13:51 +0200
Message-ID: <CAFqZXNtSvw3GgAPfyKb8f_mAvGjjCarTnsB_j0efDNq+XoA5fQ@mail.gmail.com>
Subject: Re: testsuite astyle options no longer supported
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:14=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Oct 22, 2024 at 3:14=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > tools/check-syntax in the testsuite is calling astyle with options
> > that seemingly don't exist anymore on my shiny new F41. The end result
> > is that it will generate a diff deleting any C file from the
> > testsuite.
>
> I ran into something similar last year with the audit-testsuite and
> astyle v3.2.x (may have been an issue with earlier versions, not
> sure).  I should have sent a heads-up to Ondrej and the list, but it
> looks like I forgot or was distracted.
>
> > Invalid Artistic Style options:
> > indent-preprocessor
>
> I dropped this in the audit-testsuite and it didn't seem to have a
> significant impact.
>
> > max-instatement-indent=3D80
>
> I replaced this with '--max-continuation-indent=3D80' to get a reasonable=
 result.
>
> The current astyle (v3.6.2) call in the audit-testsuite looks like this:
>
>   astyle --options=3Dnone --lineend=3Dlinux --mode=3Dc \
>     --style=3Dlinux \
>     --indent=3Dforce-tab=3D8 \
>     --indent-col1-comments \
>     --min-conditional-indent=3D0 \
>     --max-continuation-indent=3D80 \
>     --pad-oper \
>     --align-pointer=3Dname \
>     --align-reference=3Dname \
>     --max-code-length=3D80 \
>     --break-after-logical

Thanks, that works, but the 3.5.2 version currently in F41 has a bug
[1], which produces an ugly diff [2]. And when I try Rawhide with the
latest 3.6.3 version that is supposed to have it fixed, the formatting
of some continuation lines breaks terribly...

I'm giving up for now. If someone wants to chase it down with
upstream, feel free to.

[1] https://gitlab.com/saalen/astyle/-/issues/57
[2] https://gist.github.com/WOnder93/6fc510582f3632014cadf8036a3dc36e

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

