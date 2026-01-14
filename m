Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A8E356A38
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424409; cv=none; b=arCYmKhdiBoYe1NcH5hpRLkMaKzFXKxnmyaUvzwYeG5PhjOuN6Un7rkT01ogNiImCfS5rctOl7KrIkLjV/tMyGhzNp5AuNYqLd+BzOcWgWPITQ4ys4TQhHSoAcCjVx2sI3Yc6Rn8xLHw/MX5pK5amFj7SIEWChnF1wGeEaVB6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424409; c=relaxed/simple;
	bh=Ccy1ACVCbaP7lQVejHR4hSAslrYqH5zGup/Zsoflmao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKdawTbvOzASVWBQduJlEfJSbSUk2sjbll3/8Jt31RKseQdZF6naHAOPbIRuwRPAtOARkfb/FP43ao2ifvQixQapbu0X0QDw58fABVn+85NzEIOO7Ad5U3efyxPAiFu3xqwOprU27eHI57FRQpKg+ndiHQDv3wgY/1oh12RaEbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UYUBBzT/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UYUBBzT/"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f39438187so120215b3a.2
        for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 13:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1768424408; x=1769029208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJg5RdcPwEpMhSyBRaiKqWwhH60M/5xS60EVlIliRPs=;
        b=UYUBBzT/S8YpV5SoE3pN+yRPXv2NO83oPY+wVIMHVZ1wXxHYl5HRyudg1HJ1ycStdf
         LAC9Dj7wR6UptcYHwucK3BaMMpHY8ETYiJ+2s/VAxfd6acWfCOV1l2dAL+SLTEQ1O4sh
         eMwMx927Mzk9LqyzwtuOAPQqb7xNDu3Rr4GS9N0/N2kZes8gVfZQMsh+yj6SGlucdqTh
         z4CU7gvSrm4SLz6fYNXbpfFyuwXf24eT+xd+iS8fy5Q/fViADkUfFyM5A6S+aBRAhjMY
         ObLYVQm2eGpH0ofTmPz7RRjImf0AyP0akynchSB42ukXsHdYHMgjclOOoEBfctlBAliQ
         43Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768424408; x=1769029208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NJg5RdcPwEpMhSyBRaiKqWwhH60M/5xS60EVlIliRPs=;
        b=hfCA08UPJf1Cz8QWodhbKRutdCoYGQ6Ql6qglAhpVW/4DiU2eo7a9ACx0CP33eTM7t
         S9ypKTUK1BIwJr1b6pn5MhBjcgWvEwG7ecuZYp4mJ2e3y4aD5SpFV+bx/p5afBvUhtkG
         GzpinQzhCzgx/wM4XX1/a0kMAd+qjTGernIidp9FEmK304wfhPNapd1LdIZXuhKTBUkk
         1AabuP6KMQ9UDEEwxkSNfCPJqcNAahsTkV1KS+s5DArWITEaAFS8/6HyqW4fh7oQB6fB
         uFwnXyH1uXpmv7G/x6awv6PLqA8Bb8M5XstV5rN0Pnpx1wZnYXJ7kCJucMxU5ANPoYej
         mNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtNBVzW9Y0fGzGCTcU4rnt6mGPWCmHXmjx72ZhBYvnxPRZFVoGzlVG0bUNR4uQCQkDPnrDSXJb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxs0c6YRqIuKrGm3Y+n9ERF2V4vLzz1Dc+JUPN3RS3YUmjz+Mn
	BWZ+974EucchvNIO4fp+UYY5XdQKWI6rRSZJw1JAsSQzOa+7O83j1DRG8pn7SH9T6AFkV2Ctzkl
	TuGD4nmdComUNxJXPof1rhCJe2zVso1/uqfUQGOFi
X-Gm-Gg: AY/fxX47a1i7bkom7o+q8jIBDKvFF4hiDufj7vgbaduSTosasYQCZb3YH0aHrc9/CbN
	y0iseKR0+rDV9CZ3tOJM0bM357JkLbrN+EkFwMArWJsT1B0AyX6cxAMwagcvQshP3lr+v7oRJIV
	HCMCCAwGcO6g1hm51VWTNZD7caA1reG34t4yd8K8eUZ5l/UIgKfzkOFmdtjy2q/cuVi9cpJ5BG9
	vzPB3ziC3VgJKEiTULQtcG4ef7Cf57+plgJmhCWM60Xhxdos0I6+ypGK7pXmsg4zo+DOzM=
X-Received: by 2002:a17:90b:3d4f:b0:340:99fd:9676 with SMTP id
 98e67ed59e1d1-3510b0a8594mr3290512a91.10.1768424407723; Wed, 14 Jan 2026
 13:00:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205024259.704-1-ericsu@linux.microsoft.com>
 <b687544287eb8850f24592a207a0b846@paul-moore.com> <CAJ2a_Dfk7R2n99790ke+b+LBUAY+Jn2Uq-kgm8yzUvX-Hx4xAg@mail.gmail.com>
In-Reply-To: <CAJ2a_Dfk7R2n99790ke+b+LBUAY+Jn2Uq-kgm8yzUvX-Hx4xAg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Jan 2026 15:59:56 -0500
X-Gm-Features: AZwV_QhK766ZOQDjjxhS7darX_HAgawMXFLq9WVdb9cDjJ7GLf_S9EW-oTn5o9w
Message-ID: <CAHC9VhQ8Z1YvpDGZK1m15nvU0qsNsyFtTvmyQAUMO+=9txaBpQ@mail.gmail.com>
Subject: Re: [PATCH v7] SELinux: Add support for BPF token access control
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Eric Suen <ericsu@linux.microsoft.com>, selinux@vger.kernel.org, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	danieldurning.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 12:56=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Tue, 13 Jan 2026 at 21:45, Paul Moore <paul@paul-moore.com> wrote:
> > On Dec  4, 2025 Eric Suen <ericsu@linux.microsoft.com> wrote:
> > >
> > > BPF token support was introduced to allow a privileged process to del=
egate
> > > limited BPF functionality=E2=80=94such as map creation and program lo=
ading=E2=80=94to
> > > an unprivileged process:

...

> > Merged into selinux/dev with some minor line length and whitespace
> > tweaks.  Thanks everyone!
>
> I think there is a typo in selinux_bpf_token_capable():
>
> switch (CAP_TO_INDEX(cap)) {
>     case 0:
>         sclass =3D initns ? SECCLASS_CAPABILITY : SECCLASS_CAP_USERNS;
>         break;
>     case 1:
>         sclass =3D initns ? SECCLASS_CAPABILITY : SECCLASS_CAP2_USERNS;
> //  <-- SECCLASS_CAPABILITY2  ??

Oooh, good catch, thanks!  I'll work up a fix right now.

>         break;
>     default:
>         pr_err("SELinux:  out of range capability %d\n", cap);
>     return -EINVAL;
> }

--=20
paul-moore.com
