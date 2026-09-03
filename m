Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A15468C0E
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435001; cv=pass; b=uy0wFROSwPTLePDIz3olN3u1UVx/S9ysXocLmrZ3ZIsTZSdAvr410DDHBCR15QcmeWqDA9JODNT3RxXgNQVFw9Eqs5Xe68gU+4jVfLsTW2IMW/G0sZnByAA5YcM7iuP0WC7LJ5z8ey65B9lETjcBwRz6Ag+y9F4fMgzmKDRHm3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435001; c=relaxed/simple;
	bh=zVxEUER+vovhITHpwOAeij4FL/yULLzNoKNM7GtRucg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KfKSy/xFYGQHEIu5PBmGELdv0QXURhcXX6cF/6LM+jAX3rWgPiZgYDH60nC5pvu+oPVSr3md6wJfIpePYOuqUgM4LSfDQa2s3OFmTokwZf0DKVZd6NrU5988XnNXk0DIgmwhjMGbF49RT2O0IbLt4NT6BLMpKzzTwOCHr6gwSN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsTtA8Y+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzNLwE0p; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsTtA8Y+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzNLwE0p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788434989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XooQYKR9Puxgt0G9f+A4PYpT9G+l/snRHdODOQmPlVM=;
	b=NsTtA8Y+iZ16l1mCXQY2hoUVWqV7b+0sDAEaIf3yA+b0CecOiEaJVQJ7flPsv0MDj9MkgJ
	J8Md/G+MvyjcX94334bqqQqrjsqc9tsDaADOWSQRIJ13aFrFMWBZS/hYL6RGLvLKMwevTh
	HJOr12jYY7DI1KHBCRZox/YIY2xM91g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-CwsbLzg8MjGrKVdVitEC1w-1; Thu, 03 Sep 2026 07:29:47 -0400
X-MC-Unique: CwsbLzg8MjGrKVdVitEC1w-1
X-Mimecast-MFC-AGG-ID: CwsbLzg8MjGrKVdVitEC1w_1788434987
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so3833597a91.1
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2026 04:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788434987; cv=none;
        d=google.com; s=arc-20260327;
        b=VZ0FE48GloU9PJui5nNFlDtPd7ytYX1eY8mTLLqSfc1GDKP+qelcZZ0dyRH9KRNs7x
         dUVKI66GNtoy1tjWOi6bZnTZFlV2p7sfna5FRAABFnlmbRGxRhY1JUWUDKuKovYxz8Gh
         UKWhgXKW8uVCzLKSlhtmYPERywZmlOsxuUR8RaG773Yo5uIR+V05FH0LeTFerIIOE/Z5
         W6fCWo1uXQd0uvPweHaZYcs4zR6J6eyE9Ay1fViu1SxUFYBCI1qUOWLWKFT0FHr2oy4d
         7DyPL8L5bjj3KWPMiFoAW8T/wc63NnZTb6z8F9zCAVtOxx5CXf9lLIvXXdq8O7McPMY5
         612A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=XooQYKR9Puxgt0G9f+A4PYpT9G+l/snRHdODOQmPlVM=;
        fh=CK3yZ3XgEg9GX8bsZM6ooLtgoyPFwFMOgUHJlvA8oHw=;
        b=ciPAmCrejQ7xEIRPxk2Q5zmdvhfardAV8Sazk1zKiUR/cHNbLw57MXl4ltHv10dRpn
         FxLJXIBpKkawbU2MDwTCIM3hte6Q3sglVPbJCNfuJoF8JiiAZTFXs94UkTGunEixLfXk
         2IePowNOIlQIXtTy2yKduZU19Na0UQVcMYwFKL2VVqu4tVSLLfDej0AuWqVlw/IyQ5/k
         6y3eJviaqtCrSMzVIr4WjK8YW0CABjJQ9U2mbNF5n13Dw4G9Rda7Df7gYJ5RcDZZu/mi
         gGwWsRb5AMBi6BEQoAJxYQzTb6+n5GMppYwkS2EdLlBdRCQj0Nf4BNBfs1Kldg33bBLt
         Wx/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788434987; x=1789039787; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XooQYKR9Puxgt0G9f+A4PYpT9G+l/snRHdODOQmPlVM=;
        b=hzNLwE0phY1SmJggT0ehhnelzeIyBxjsAp9ZHdbPEm7bVSayrU3vpFHmlclaqK6PXH
         uECal8ggTtXofakmes+XWIYHF8XfycE8o5WpjWDp+MwHQCAYwuEQkDqBDGEnhhtNLEVc
         WhBwQAfHkyr3ElimXJsuj8TQEkbKgesL5hbKEPiWN7ulxkSFwA9eI9MSV4xZo+fKnzaE
         uL5GJRK1bdzqwoSeQgSQStSbGPS4gf+zNLow4jTxoEtvLeNl31vQswFYkkUZ1xy8YjnE
         W0Gbapu+lFhex52OpEOE8SxpE79wDKnVG8jBuYh6zmWziNlQ7xIQnGSq3LmFqfJ8QfRi
         jeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788434987; x=1789039787;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XooQYKR9Puxgt0G9f+A4PYpT9G+l/snRHdODOQmPlVM=;
        b=Z0BNGJyoC+9bnxWjBkyLeCUp04OLZBddxt5OQKNoGVgFzAm62w1P3v7I7ogODRkG1o
         WqaZJc1kzGSaAq64f1fm03gODAOczczzVfl4W2eWBUP/nz8Fi4GZmf/JIZp1lZ095iIi
         UH6UmiyGDB+FVnTVhi9dcn/ygHJMtoZ8MCXjjJdTJURmzsojUkVk26+aTFZtsG8hAtGl
         khL+4mAHyw5StRsH66SdfjBW0+kW1B6ZXFD3KmWk20G/fW/JSskmaehVlMZvZueA8jx/
         cqp8ME2Rq5Qq0X86leEVx4bLP7NY/i+q2hvSDsa16G7aSwSGYZZp7j/XGwswu2rxHOpd
         REag==
X-Gm-Message-State: AFuF++kVAvtGkA402a8dEXFtspWTPHJfpMtYWf3Ly6IuzWAI3xFPk5vy
	j6atlbYTol/1fFf03lguD+w49Z5K1PtBaVMb+W/hCQWrTeHBjriU56rO7TEu/3RIGZtCapjqEAi
	2l0oeEn3soHmzFnj9lAhmsalTtecrJ3+G/X2nNT5752kjoOEKZJO9xrFPEON9+d2/2phO1C/a9+
	EZgU56O7ubfSvyK46vUSjoDrucloC5WD2LgCXqpoPBzjGw
X-Gm-Gg: AYBFou2FFZPoqb1whXysBK+VjiKA3JlYacXeQb9lKyx8X/G6DreRdD8YiRTGyDZW8Ip
	2J5Pd3RypF7c4sI4PrCNIbbvTdnOYFzwiqC1c/0iAxGWkNYA1Rf/ejr/+nawc0U5AFfBEEjgo8y
	7WJ4kygIoxsFtlGt7Q9hIlLZaMlmCjPBi7S7sdZF3ygSYVh77zRdj+uH7A
X-Received: by 2002:a17:90a:114f:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39b13247f46mr3961969a91.7.1788434986640;
        Thu, 03 Sep 2026 04:29:46 -0700 (PDT)
X-Received: by 2002:a17:90a:114f:b0:399:1b08:28de with SMTP id
 98e67ed59e1d1-39b13247f46mr3961904a91.7.1788434986124; Thu, 03 Sep 2026
 04:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Thu, 3 Sep 2026 13:29:34 +0200
X-Gm-Features: AcwNN1XauK1UHYRFaqFGM29UmCm7nNRZqtPbHkS3EwnXkUnjWmV2sSB-gTg8_vI
Message-ID: <CAFqZXNvOGbzy8-ZnJtKi94jfu2H173Tz7VYpK8KuseMQS-9tNA@mail.gmail.com>
Subject: Heads up: Moving to a different email address for my Linux
 kernel/SELinux contributions
To: SElinux list <selinux@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Due to certain upcoming changes to my employer's work laptop usage
policy, I'm being forced to more strictly separate my work-internal
vs. upstream/personal environments/identities and in relation to that
I'd like to transition to using my personal email
(omosnacek@gmail.com) for my future kernel/SELinux (or other upstream
community) contributions.

My work email address remains tied to me for the foreseeable future
and nothing really changes in terms of its abuse potential or
whatever, so nothing bad will happen if someone accidentally sends
anything upstream-related to this address (or continues an existing
thread), I'd just prefer to use the personal one as the default from
now on.

I'll soon send patches to update .mailmap and MAINTAINERS in the
kernel tree and SECURITY.md in the SELinux userspace repo accordingly.
My future git commits (e.g. on SELinux GitHub repos) will also start
to show my personal email address in the metadata + Signed-off-by.

Hopefully I didn't miss any important detail and the transition will be smooth.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

