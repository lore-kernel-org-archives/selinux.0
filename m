Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF8535A4
	for <selinux@vger.kernel.org>; Mon, 19 Feb 2024 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375804; cv=none; b=PBicVSqueoEnY/5jmlXW1TdaOFmTK9WfalVPboM2MI/oFYTOaPN8u/9wANQSNiHsoqTaQfvF6J3wjpVnw+VG8WLjICmG1w9yT2dcyXu1usUftackN0e3HlPZKjLBiu7JeCnpbb6yGqlkqMMaxpgkTjdmw6CtHqI/O/TsaarYNNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375804; c=relaxed/simple;
	bh=WFYCoTdJPUnFju1Lxe30v15ENf96YYeSjcsvNHksvpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uPJngx1KATBKJkX2H03peDSPKkgEnmA/0Ywud+17gETAX4/X3ySr8C6Vs5NV0+zvO1mv9JCACxT0lzaTOR3dR+OLOWuQdddWlCtpfX6dxU8qlTsuuLwlR7t5vsy++X3++17vUth51+rHAa9XZ4WmD6974uy+eeplyXdo8/tUJs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9bFNtGl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9bFNtGl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708375802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E0aBg+sGexpBE8ChQUq5c9Stwm1j5vPv6LXfRkF4F6k=;
	b=J9bFNtGlovCNqYrLiJKQFe/93lRxclyzn3iTp8SWFSbrTH7B+5BRYcuPylcNTy3gOYXi3i
	dB1dCo/h/K9XCzR3TC1S/BDsH2L1K8CiXmfAnfOHH+P6gRRBa3G9YelYjXBg8aqIVbNaYg
	Sz++vLlQtcOZ5W8oDRIhlnoVDvy/ads=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-iJGMhlgqMAmk-Gg7rcAs6A-1; Mon, 19 Feb 2024 15:50:00 -0500
X-MC-Unique: iJGMhlgqMAmk-Gg7rcAs6A-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d1bffa322eso5386780a12.1
        for <selinux@vger.kernel.org>; Mon, 19 Feb 2024 12:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708375799; x=1708980599;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0aBg+sGexpBE8ChQUq5c9Stwm1j5vPv6LXfRkF4F6k=;
        b=FxPqLZDdOwc306qazBoJp4JgwZRIsYLwvxr52ACytLpILhKsLtmlsvZp8/Xgo5gTba
         dhYBPdpa4Wsn45vWRS49oXU3P2JZaIOgrsrlng9zEu/XXFja2TfogihzkjgFJd4xBzVM
         ZxlEF2VV/gC4CggvpwEYQAz18mK4hZ20W5nUQOSkIvZug/KrUPJfwTBfnfuXRgpXLQ2V
         UBLMcYDAJhahp04gV9357lv3w//R9VI7rWbOjmGsM08PY6b6BFVl3T//WQm/8wMmDCxn
         TZLSuuDECwPO8VwHiOk0WfG2aw5kHXU3aRA8IOb6zXcx6mNssZYCru6UcG5GMgleOiKq
         xY7w==
X-Gm-Message-State: AOJu0YyQiYN5b/zWWHvD7YmMCE6mjC+yRfNAS1IFPP9mwODrP2bxhi3Q
	YO+1WG9+Ib7A/1pMQyZcPOsA3wMl1xYaPsXTohTwH+9grsw8lL1P3jtJN/bnyiRKieNB8gnm749
	yf8fa1nYrVH51LVoWJNmZlBSuOvMNYAMrRQTygjmiKjwDuNvfQnMq3sGX2cRWk7ci+OUGidKRd9
	Zq48APz+FmI2Q7m34nxxyTYJt32IUTQhxXThIc+0BY
X-Received: by 2002:a17:90b:46cf:b0:299:4d25:3e07 with SMTP id jx15-20020a17090b46cf00b002994d253e07mr6497932pjb.11.1708375798793;
        Mon, 19 Feb 2024 12:49:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgAQYH4ibMkKcHpSCc5oAxPbpjGugK7tUSdUlVnFPfPc7rhJEGxzhspYgOVdDE2+osGwsti7JzrDq9l8wRTC4=
X-Received: by 2002:a17:90b:46cf:b0:299:4d25:3e07 with SMTP id
 jx15-20020a17090b46cf00b002994d253e07mr6497928pjb.11.1708375798565; Mon, 19
 Feb 2024 12:49:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212102942.71393-1-omosnace@redhat.com>
In-Reply-To: <20240212102942.71393-1-omosnace@redhat.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 19 Feb 2024 21:49:47 +0100
Message-ID: <CAFqZXNspWQQ0CxBab1Lj9Y4qJnd3xHuTTci7LWnC9fH=8QTanQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: test CALIPSO also with
 datagram protocols
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 11:29=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
>
> We can't compare the labels because of the lack of SCM_SECURITY support
> in IPv6, but otherwise this case can be at least basically tested.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/inet_socket/test | 61 ++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 23 deletions(-)

Applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/6212c8f9d46d5a85=
f4adc777b5a37a781559a014

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

