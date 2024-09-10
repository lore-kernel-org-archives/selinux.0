Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369F31EB2F
	for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973071; cv=none; b=OBPP4PUcPgFph7Jg/Vdw7fcMTiWmPW+/7kWMIISKYnaA+5op7Ska8mG4D8pHYaq9KLNsAqxRPN8HCnrk4F5rLn+UtoVP30BFDOUfM1aLAhw1mUy0so5WfM84KnZCAF8TjzhpubrXJ17cuRjMsbMf8z8s232o017/KOQC1blwWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973071; c=relaxed/simple;
	bh=OfYudPJaBHOCbJN0N11rySjGG1LpOOtiJnMYptq0++0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EGbs78iQCTAsB1ovkwooIiiNwYRaL6ffFbR69Im7PpTe/Fr/PnCyK8epuCyb/y6UjZwv4Igpr/3tQ+OSXbTWttNX2t++9CwysZbUg/c2TW9br/stY3gA35rcF5m03RhAD355iYen7RZ9+5iRPVd2/VkrZCXXWVPoP/lKqpCAWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DueA0FTX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DueA0FTX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725973067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfYudPJaBHOCbJN0N11rySjGG1LpOOtiJnMYptq0++0=;
	b=DueA0FTXxkdxDPqYnq9o/bFIz2DOanbqk0f5b6qUB42nmeABcs3zrXg4Z8/0I8+d/NiHxD
	mso0FubQ0Ma1D6fikRpnd6V9uH6c+3j0CcLQ7sw7W8aM09jKY83fhA4qL9Kf/KKj8mNh+j
	AdYeq1S/98XfyOZX2GcsChDoAn2Ubg0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-z0_4TqVIO96Ok2ohTcygcw-1; Tue, 10 Sep 2024 08:57:46 -0400
X-MC-Unique: z0_4TqVIO96Ok2ohTcygcw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2d8a1a63f3dso5645798a91.2
        for <selinux@vger.kernel.org>; Tue, 10 Sep 2024 05:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725973065; x=1726577865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfYudPJaBHOCbJN0N11rySjGG1LpOOtiJnMYptq0++0=;
        b=aNLRpk02BCXpHz3h1oRNyayWd2nnwCDU/jiXwlTnp42yM+ppaz7W3gUeIoFp7KbHGf
         i/D0tgpArwr4tewM3JCTxfAk6/lyd7Z0Bt4TPOikl+UB4FYG0ffx+b/uJzgWFhNAH6Aj
         1wrQ9o9WoiBRAhMBjQbNIn/H7+9Lv/IY0LSVo22X4s03mLmwZxwbo9KUI6LPSZW7m6KX
         iJ/l1Fpc3MACiiEAyimUhvyxeEoyrgdbD7AgmOWtbbGrbOl6jTJsojxn7Rvg8eUGq17J
         kFWNfugGFBt7wLOqERdVBo91sTwoE7IOiIeTU/Joz7QkrteVZy0EX+WDnfT/YKHp3VwF
         pYYQ==
X-Gm-Message-State: AOJu0YxTbOKSjdoF54RMKpxSRRz35QLtTw21qtACDF8IzJmD29R9tyaT
	Ka1lwjuByp4WWbgfJNVZL10dtO2Dl2WBSU3gLHpHQvKF27oXPQY2um6178RVYnELrLCkdRMlO+L
	Ib98aXzJ473l6dEcekj8FiI7D4QEkxV8AMMuppjKIenxkb0Nbx/3I/e/l1oYvnAun9Gau2Dfy0C
	JWNm2sbrzSQOekuTgVFURcySkah7n8XNbxDQ6vpsrD
X-Received: by 2002:a17:90a:8ca:b0:2d8:3fe8:a195 with SMTP id 98e67ed59e1d1-2dad4efddb7mr14817853a91.4.1725973065175;
        Tue, 10 Sep 2024 05:57:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbo1frhObEINuWHbfEeKqfHAVnFBxxhkjS6mf8ljorkB1NH0W0zw/kGohV0EDC3uin5AA0EwXaVcFW9/TguuA=
X-Received: by 2002:a17:90a:8ca:b0:2d8:3fe8:a195 with SMTP id
 98e67ed59e1d1-2dad4efddb7mr14817836a91.4.1725973064838; Tue, 10 Sep 2024
 05:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829132617.1610-1-stephen.smalley.work@gmail.com> <CAEjxPJ5FCyu9bDZt+8JsRh75ppWsmTwH2wHBf0-u_6qQsKGhpg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5FCyu9bDZt+8JsRh75ppWsmTwH2wHBf0-u_6qQsKGhpg@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 10 Sep 2024 14:57:33 +0200
Message-ID: <CAFqZXNtmVpdLjidFXmr94Qozt7yvFp3ADQ4Lo7M_Nn02OUZm9w@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests/extended_socket_class: test SMC sockets
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 2:33=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 29, 2024 at 9:27=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Enable SMC sockets and their dependencies in the defconfig and
> > exercise them as part of the extended socket class tests.
> > This only verifies that socket create permission is checked
> > against the correct class. The tests only cover AF_SMC,
> > not IPPROTO_SMC.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Ping on this patch?

Whoops, sorry, the v2 has fallen through the cracks of my inbox... Now appl=
ied:
https://github.com/SELinuxProject/selinux-testsuite/commit/f71a462ee3816393=
098e0cc22728f387e2b1f846

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

