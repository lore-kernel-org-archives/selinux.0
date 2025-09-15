Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1330496B
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938604; cv=none; b=VYEHMEP5y220kuqFtvvW6TzP3C6eh213Hc380jLAtFmd1E4ZJt/WxXOSgfRsbyk6fqd9J8Cu4REj9NsW+A1782AgLK+ETlwf5fin+jYDGemJj0IiRypnwV3VDJu2CDcm4R5cMV6mhuhYPd0yZZ/skI5wsYI2uP/yEHQmMtBTX+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938604; c=relaxed/simple;
	bh=WsZTIPh5rj+gOm7zCWNJGCG4Ck2u/c8oR6NlpZAYyA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TscaCrWODJKozDBGmknV7j+pFFjUJHV1k9nbUrCLBEcPM1+Zpepd013i8NjzhWHdrqUwbzY4zAY3T8x9Wz2fGgsQ3IDcMPh/7L29LjRhugYlvvzw/CraXQN4bSUYLNpXqtlqKFGag3+2niuvIl2c4Yt39HjbQC6O9fvi/LxCstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG8ULQhI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG8ULQhI"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32e372c413aso812619a91.0
        for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757938602; x=1758543402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WsZTIPh5rj+gOm7zCWNJGCG4Ck2u/c8oR6NlpZAYyA0=;
        b=GG8ULQhI4lZ0/lNSrEnLg1t0zo1nx5PvBWsI6rtxloSzuGJQiLc3I8k9hAD5qEMlYv
         7TfDGjtE7JgKodLzNtLhbAUo83J8925uC8wTOwRb0MGWEQKKuQQ05MbUsoWLZmL65CZ7
         No2nFTdwHw/kgkT2+3wa3xbohBt/fUpYJb3cQBt3/BjvFwsBji/s+weuq7v+RQDaj1af
         Vw0g7yG0cyKtDu7s+ZrkGDebnqQpLJWEPmfLYwfaekBkxhyQ08Wy3X7e7LMZpFENvlL7
         pYQNDpSexHq8j05yZvCPYNNzNWjeb/3cHBt9fC/09gO+9+vO0KVZrZU6BSsU0W/Z0f0o
         Q8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938602; x=1758543402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WsZTIPh5rj+gOm7zCWNJGCG4Ck2u/c8oR6NlpZAYyA0=;
        b=oql61Y1Bu2bFqXvSP4BtXnm8cVmild3HBfd4IllghX6OgMd1D/mlRWyA/xk7KDuL4u
         /xHKnMS7Av8cbx+3/WA/GAnShfd+2QXWeX2h3gL3QWyxJvbCRM8zxWkKqWdXCZ+BzHVS
         EQfYgAsli4kk7pxoVvJEMLZIZiif9uL6w9DL1vwF8zxdkR8MlnbGxAP161FOhEILC19j
         kq2uCBQpHtcE2GKDAOLn95jFZemHiwVvgRWHZcUj3MpV+PMcm+G9fnXDouYsNQqO1ZgA
         gStoV/KOFHHDJhsR4MFRcQhrBgbObk5z2J7/6BMv70X1bHXLLEbx2lF4/NsxWnQlXDSP
         4zSA==
X-Gm-Message-State: AOJu0YznwhKUQQ3c657b2OG3/EFHn7vWJ/KX+dQItspv/2rJTleD8oRv
	xhzlgktMxWkzqodWUaZie5LMtY7aSZDxZWemWmPfti+byMd4oFphIeoY+ss/dW/LDCyDhChsglm
	bfd9SFQotBivIx4jy/7gAvQYqaoSBhq4=
X-Gm-Gg: ASbGncuCR97PGWQsD6UbjQ4Kzrrz7/C2nSvVzCovG9hsaOZ81VhessE9fv7GKRtNPzU
	pmCPYXeZaERuPdIA4SoTwwOcpti4Pai82PxZ3pRHqDOL7eCeOA/7Q7RfzLx+RyfVglMRpS9Pr7b
	VDMN82iKLM6Q6mD9IhoMspFp7H/J2OUvZfIPBsBptXrhbF4IvPoyuyJRrrcVV+55n8DcYb0AZxw
	xgYT12g5sYfm3F2ow==
X-Google-Smtp-Source: AGHT+IEJFuybhNpS2ptf5Jh2MUgYvPadiO5yYL4hnfWEROWVyFvO8x4K/47GxuZ9/pw/0CUEJrDnu4kzXxRTSzix0DU=
X-Received: by 2002:a17:90b:28d0:b0:327:c9c1:4f2a with SMTP id
 98e67ed59e1d1-32de4f97cbcmr14173918a91.27.1757938602449; Mon, 15 Sep 2025
 05:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DCS9NCJ1SZ91.12BXMI96H1ZHW@gmail.com>
In-Reply-To: <DCS9NCJ1SZ91.12BXMI96H1ZHW@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Sep 2025 08:16:30 -0400
X-Gm-Features: Ac12FXzX0Bf_qHiCrv9G63OaKFN2Qy89rbypZ4HD7GFv2bgm8mAcHdD9Ics1k_E
Message-ID: <CAEjxPJ4zChtBRmdXr0a7tY3W1DD7BeeDuHzMmE-e6J_u0ivZeQ@mail.gmail.com>
Subject: Re: Clarification on kernel threads
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 1:16=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wro=
te:
>
> Hey,
>
> SELinux has the sid kernel, which when used e.g. as following:
> (sidcontext kernel (sys.id sys.role kernel.subj sys.lowlow))
>
> But what privilege level (ring) do kernel threads run in? I can't find
> much clarification, and if a kernel thread runs in ring 0, then SELinux
> isn't of much use at all then given that the thread has complete access
> to both the processor and memory no?

Prior to the introduction of the userspace_initial_context policy
capability (and still true unless it is enabled in your policy and a
separate context is defined for the init SID), the first userspace
task inherited the kernel SID and remained in it until it loads policy
and re-exec's /sbin/init or switches to the init context. The same is
true of usermode helpers. So restricting the kernel SID could be used
to control such tasks before they exec or switch to another context.

SELinux can't protect against errant behavior by actual kernel
threads, as you note, but labeling kernel threads can be used to
protect such threads from unintended accesses, e.g. to prevent them
from exec'ing a userspace program via the usual kernel functions for
execve which apply the SELinux checks, or from reading/writing
untrusted files via the usual kernel functions for reading/writing
which apply the SELinux checks. An actively malicious kernel thread
can obviously bypass those checks altogether (or change the policy to
allow them), but protecting kernel threads from untrusted executables
and files can be useful to defend their integrity.
