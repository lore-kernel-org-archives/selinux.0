Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F3F2236EE
	for <selinux@vger.kernel.org>; Wed, 14 May 2025 22:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260705; cv=none; b=cv/vPMGVj1mvqgnS2KWzqsDcCMbimu1UHf/YbTO59hn0oUGUs70gCsRir9p69nl/sP4evUNIMl4Ax+E064fCGlIdWVKuw17H+qtgRrRDIt8q6tVvhOm7CV8tI6M/Vh9pLTgrn2c0uzijSEYpb1bBPQtCFybAsRkBMtPPpdpyETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260705; c=relaxed/simple;
	bh=6e/VxiZY4CXwHatHr0vnQtSIXdO71A3YaOVM0eTPZTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSL+OmJPJf4Eo9dw/Bwg/HHipF0JPWBaJpkKbTSciS/XQ9VVEw04MK/aTc7svVZ4CcNc+dgcfA5IHkDrLHfYXAloLODTrFMVBqEV0Trw6qDvfmmZ4U6/nJ8TwrGoA4zQ/V2V2zX3uHCiIwIT0lVr4Wvy+OCH9XMKQNcQewVvtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gab0sOyc; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gab0sOyc"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70811611315so2385887b3.1
        for <selinux@vger.kernel.org>; Wed, 14 May 2025 15:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747260703; x=1747865503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YKR96Kmgo1xhpVoMC6j7U7xs9AIj4PsOtFt2Nur6c0=;
        b=Gab0sOyco6X1UPzgEU9R7A5w4pEB1kn5KMLHDx8b7kj6hng8LzPwbu+tg6wpUkTQHp
         FrB0btNAZzsb4IztglJxKKZlZ22ZUEknkqlw4irmU3EMi1KEclwkMl9b/h9HVKFjeRhD
         y7IpmdrBDIsG4BUIPmbAgMhZJEKx8MMQGgHJFTxG4y5147SA6mmoVxzW8WXsMRVTrAyg
         71aD70xweWcqQGNDrwB8eylM1ubWS0CWMxRaipG3BNKRPIjnckxaPUld1lJNBXOzB1xG
         qg+rxGgdX5taCNxsZ+Ff7pAT0ZyTfm6jsB3/SovGL/RyCsNmDEFNU9mLewCnDNLlxhZX
         nAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747260703; x=1747865503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YKR96Kmgo1xhpVoMC6j7U7xs9AIj4PsOtFt2Nur6c0=;
        b=nWZ+1eDMI0hRDnBtci8TukBgGLhtTj11RqeXrrB1yikmc/EnYkCZIh5ZODuuz0iit0
         ZA/fzUjkSORk4snX7tQZBhMUABmd9otF69M4d7SOb/tosl6kSMgbBvoCQTxCRsOMZaVg
         lRfTFSTaPjrUkNVrZpzd93aetVaDvdLNl4BcMZth1QwX5du0Di80HA8UACWCFrCcMgLn
         8QbVo/XyP+92ezlO5y/rK1iH0IqOp12zEbWzgRfG4A7cou2Jn32i5FJSfi795qT4mdZd
         AiUdMAVIo7BlaiQj9rWDEyrE7Gkrdrf7EPljXgCI3xFLvgBjbtBlJ2/lAmOhLYYFN3OX
         kCUA==
X-Forwarded-Encrypted: i=1; AJvYcCUMeKO0TPyCfplsVKwWQNMSp9emcoO7Qr02YelI993oz77WClzrNP2AQUER6WUsiFS/S+NHgRWD@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/kAPnijMaTakM9+id5j4/mAwAufa4XLcwDeeFrrAxVbcArD5w
	AtNqJF448Axvo9mq197T9gHac6qpCbPPVpsnrs3AYoWVypDFZZHirJ+qqUyBXdCHRnDN2qaMsri
	i/vdaqJtJJBfi//RHA11XAlLhWmT55qjJzYQr
X-Gm-Gg: ASbGncuEmieqx0xHebder7wWUogoy00+ECeJzTdD+gnt6yDYdld4BgtFcVJ1iowz8lN
	QOPCcrbT0UtdxpHpylhtHGCz+nUTq3l89T2PVAFco4tOieSKDMd47d+8VGUjex8uvnXJQEDyUlp
	jz35wVj7wVHAlw/yLYBuIn/dTkPKUVYYiH
X-Google-Smtp-Source: AGHT+IGcSJV/bl83fKd8M+a64LhJY232bTdrBugmATrbK0uVFp9bkkJgtiU0SlSh3VDsj+Cy7DtdDmtFC5OzkGsxabk=
X-Received: by 2002:a05:690c:6ac6:b0:6fd:474a:60a8 with SMTP id
 00721157ae682-70c945365dfmr3866547b3.11.1747260702713; Wed, 14 May 2025
 15:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-60-paul@paul-moore.com>
 <81106a29-90ce-4439-9b4c-60bb2962fe04@schaufler-ca.com> <CAHC9VhRUr+sXhLzDSjiG9bEVbzZd2u632dLMVpcCe6By_d_H4w@mail.gmail.com>
 <3d884912-6225-485b-a7dd-2aa4073265f2@schaufler-ca.com> <CAHC9VhR5OFDvJNJLy9jKMsB4ZVx=phm6k6iebT6VuXD96kNEEA@mail.gmail.com>
 <c5b81e66-7e73-41cb-a626-9f18f6074e53@schaufler-ca.com>
In-Reply-To: <c5b81e66-7e73-41cb-a626-9f18f6074e53@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 May 2025 18:11:31 -0400
X-Gm-Features: AX0GCFvyIWwDkuxr4t59-G_2jl9ZXU0DGWRy2p7MHBWzc3Vp5BGPNiqsSgH92ZM
Message-ID: <CAHC9VhSiGc16g36gtZvWKYdtdx-3WG7HbWWhNXvPSBRfA7uphQ@mail.gmail.com>
Subject: Re: [RFC PATCH 29/29] lsm: add support for counting lsm_prop support
 among LSMs
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 5:16=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 5/14/2025 1:57 PM, Paul Moore wrote:
> > On Wed, May 14, 2025 at 3:30=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 5/13/2025 1:23 PM, Paul Moore wrote:
> >>> On Tue, May 13, 2025 at 12:39=E2=80=AFPM Casey Schaufler <casey@schau=
fler-ca.com> wrote:
> >>>> On 4/9/2025 11:50 AM, Paul Moore wrote:

...

> >> In my coming audit patch I changed where the counts of properties are
> >> maintained from the LSM infrastructure to the audit subsystem, where t=
hey are
> >> actually used. Instead of the LSM init code counting the property user=
s, the
> >> individual LSM init functions call an audit function that keeps track.=
 BPF
> >> could call that audit function if it loads a program that uses context=
s. That
> >> could happen after init, and the audit system would handle it properly=
.
> >> Unloading the bpf program would be problematic. I honestly don't know =
whether
> >> that's permitted.
> >
> > BPF programs can definitely go away, so that is something that would
> > need to be accounted for in any solution.  My understanding is that
> > once all references to a BPF program are gone, the BPF program is
> > unloaded from the kernel.
> >
> > Perhaps the answer is that whenever the BPF LSM is enabled at boot,
> > the audit subsystem always queries for subj/obj labels from the BPF
> > LSM and instead of using the normal audit placeholder for missing
> > values, "?", we simply don't log the BPF subj/obj fields.  I dislike
> > the special case nature of the solution, but the reality is that the
> > BPF is a bit "special" and we are going to need to have some special
> > code to deal with it.
>
> If BPF never calls audit_lsm_secctx() everything is fine, and the BPF
> context(s) never result in an aux record. If BPF does call audit_lsm_secc=
tx()
> and there is another LSM that uses contexts you get the aux record, even
> if the BPF program goes away. You will get an aux record with only one co=
ntext.
> This is not ideal, but provides the correct information. This all assumes=
 that
> BPF programs can call into the audit system, and that they deal with mult=
iple
> contexts within BPF. There could be a flag to audit_lsm_secctx() to delet=
e the
> entry, but that seems potentially dangerous.

I think the answer to "can BPF programs call into the audit subsystem"
is dependent on if they have the proper BPF kfuncs for the audit API.
I don't recall seeing them post anything to the audit list about that,
but it's also possible they did it without telling anyone (ala move
fast, break things).  I don't think we would want to prevent BPF
programs from calling into the normal audit API that other subsystems
use, but we would need to look at that as it comes up.

--=20
paul-moore.com
