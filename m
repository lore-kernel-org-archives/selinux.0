Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676C2580EE
	for <selinux@vger.kernel.org>; Mon, 14 Apr 2025 07:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616626; cv=none; b=XdkdRQAAI048bt9IIhY2gRYmfnOFIIE+OiVQ/WHtwJ5Puw6m+SJ/1KY53ROXlq0/ZvlHetRKnGQrzjUZSgAZDOJBqC81kJxb0khGYlzREvrmSwix8e3Rm5UKtM6irCQwMBrIWo77UeK0wbAo3ItWBLSgYybx2MqHURMjbwY+WjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616626; c=relaxed/simple;
	bh=9CHx6UsOS9ajVBbWYPiZYDMstbJmY+rCLtqnCCsWhK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Plgnh5DYj0+IyyYx0m5vHXOi1iJDHqQVw5GMtKFHPW+r+R2ATGTIdexiDvaGbsFEhZtKCYLf3Myl0gbj1fIPyX5dfsgcLFZv+vKnV2qal5TUNdaVc6NJPhzTweCCaVxW/TIJHerNRv5yUSu6Wc+BLMGEV34x8ZQthHUyLg3z7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVJWKMsz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVJWKMsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744616622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IQyE8fQdtBSGb3jPOZPRdnQu5pYgn3H0oJI1JSwTv5c=;
	b=JVJWKMszN3mlbOGY1UJglOqrkZafaOLE+hbHrpibgiX/uFOW5raLbZru4MHlFrgKgV8DhF
	l02TGV96v/CkSyyH9y68vFPy0yBbjg3I+TAC8cg1K6JN780Iyp1ccQ/3M8bSCfA6RBGzyN
	vit+R9QzahqWjohxwewtCMYHNWWoN3M=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-nvNCmwCgNK-k0KA6-iRSUg-1; Mon, 14 Apr 2025 03:43:40 -0400
X-MC-Unique: nvNCmwCgNK-k0KA6-iRSUg-1
X-Mimecast-MFC-AGG-ID: nvNCmwCgNK-k0KA6-iRSUg_1744616619
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-af8a4410816so3283694a12.1
        for <selinux@vger.kernel.org>; Mon, 14 Apr 2025 00:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744616618; x=1745221418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQyE8fQdtBSGb3jPOZPRdnQu5pYgn3H0oJI1JSwTv5c=;
        b=G3lXr+mq4ORwmpxe8QN3pzcnly9UoVxlr0j8hxCkED0U3yy2GFvhPTrXH5aID8dmOS
         HAukyAzgksLQ+4ZTfiIi+j04N757d7gLkEBPTk5A3HMtXVhgHnnhblF+vdfRhm1S4Wbe
         aq9TPfxWwI/Cur0HwRvbotBeI62hvBPcy3bggNmnn8NXFIrNVTznn5V8iD10h+imPjge
         U2juI1pTGqWEgnwqy5pYSPfAh5UJPsVB2quEhMWFvbBEfkpQdcohnWnZiqY425zRHeEl
         rQ7OR+lXEDP6zDdHW9cDpOjGShYesBQz3x7Nzm+AWhLYCdBGnjYdtwT006uNy1r7O46O
         lOkQ==
X-Gm-Message-State: AOJu0YysdKkC0LEW7MLCJYg0V1sxp6+sbkaqLtvoXEUba81jlBb/owRD
	YHjmgCsXgeGjyz+bt/jmACY9CqtqDfJSJO46+qYaeJ8M3JcMeAfeQZzG8c34S8Uj1WtfA3VjLUT
	5Hm3/j1vEnAe4l33PJC7QitOM8O2ceccJq+WVXVUiwi52kgAlTfBkCtw8i8UMRJGMOSwt6JfZeU
	ul61sbgm0lyiypKuUqOMu/3R5nypSS7L4ow/9dOkYn
X-Gm-Gg: ASbGncsnw16VyC3B8t5EW4voINqMqYUYgq/krumP8PPVadK72XFgjnKTppzABUf4NWY
	juOBO5iArLolODUb3OZPmDaaS/u8QLBVvj3c+MdSwguN9y8OE3TtmWBKBJdHu3298AsAfC3/MIu
	sMvGiqqY0EFq94ASQ7cm73DSGK8w==
X-Received: by 2002:a17:90b:2d87:b0:2fe:b8b9:5aa6 with SMTP id 98e67ed59e1d1-3082367ef21mr16329012a91.31.1744616618529;
        Mon, 14 Apr 2025 00:43:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFoLf7jHohS+GpC5rXeISTErFj/LZHzfBf9oA9roDm48C6udZprUvB+NPiTqtLSZTGo4tf2HwcGzxWqAjgYCM=
X-Received: by 2002:a17:90b:2d87:b0:2fe:b8b9:5aa6 with SMTP id
 98e67ed59e1d1-3082367ef21mr16328997a91.31.1744616618051; Mon, 14 Apr 2025
 00:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410191659.255003-1-paul@paul-moore.com>
In-Reply-To: <20250410191659.255003-1-paul@paul-moore.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 14 Apr 2025 09:43:26 +0200
X-Gm-Features: ATxdqUGm_X02Ow_AXKnud4vh0GNd7knI5PD9Ufa7ZnHTsu7WBCKnwt4My2y0Lzs
Message-ID: <CAFqZXNuY=Gr9wFPdNpY+Pf4=LFKK4v+phh_AGdRRFb=rUa=h2Q@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: don't override PATH variable when
 running tests
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 9:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> I have a test system that requires a PATH different than what is
> embedded into the test suite's Makefile.  While there is perhaps some
> risk in using the caller's PATH in the test suite, given that this is
> a test suite I expect that the caller would be aware of such risks.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  tests/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile b/tests/Makefile
> index 35bb35871b48..7a6aace180db 100644
> --- a/tests/Makefile
> +++ b/tests/Makefile
> @@ -184,7 +184,7 @@ all:
>
>  test: all
>         chcon -R -t test_file_t .
> -       @SUBDIRS=3D"$(SUBDIRS)" PATH=3D/usr/bin:/bin:/usr/sbin:/sbin ./ru=
ntests.pl
> +       @SUBDIRS=3D"$(SUBDIRS)" ./runtests.pl
>
>  clean:
>         @for subdir in $(SUBDIRS); do \
> --
> 2.49.0

Seems reasonable - applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/122484a43291edeb=
c5a7c552f455ff35d0e01d95

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

