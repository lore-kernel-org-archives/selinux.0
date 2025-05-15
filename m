Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55799282E1
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332847; cv=none; b=KtCOJ35K8aQhMkqqH/SAyUoJZBKWAs6Y7KOU7OYrWND/vFhkPFX6Bnbo0vl30/hMPMiP6r7gbhnmFXwBrtNa5CjV1lcFGXpIjPppdO3vYWrhR/vQs5iB9ul5j7Jfkr/4F2PjPCzgYYj6T/TziCfAwClEsExWX3h51TJ8rw8t0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332847; c=relaxed/simple;
	bh=clcjMFwjzq1K/HoDraAXYcNw0jxFnXWgfH8D6iM8jDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ab53EH6zaY7bTNdJhelvOileOXnpjjRsIKJAgwV9loSjvvghjCioDxaXdF1ar8Pf1uZnsqck9Fe3PlyjYskQneL870sEvKOj6tV6452yarCmDSU3I/mB5NVa4UN8ORxLBTuPd7VwcPkIPw74v1zwokZWKN7lLkd18WiB8kViUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ACl7Wdk0; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ACl7Wdk0"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7b3410e122so1292819276.2
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747332844; x=1747937644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmhE0ZyXFIMq1ejroEpNwIAE09HwUrQ/oEQO4pBE8KQ=;
        b=ACl7Wdk0W5e2KTIuqHvYvU0CYvoNsGWGS2YMhVzQnqtcIQeoRpf8+reVgvdeYZokai
         qMuTFFQSocgOpVo1pQVQMr6/fBJqDEW2XnSHnMwJpqsH+LaDclsPSBUFYRmZWzI/SfeZ
         c8z5HxNGuIWNx3nfxTSX7b32HqTEvB/4/B4fpICUd4Tj77jAehuX48RMGhCE7LT0+n2S
         W6Z8PRhAruZ+fFgfOsPWU5iXKa0zmrsk+OwbpWww5G8DyHmxpx10J2cqzQc1Iqu/aZx9
         qqWReAqNItf2TlbU1hUn1aYwFK0VNEM8NFBQwXnODIWj2yaRNG79MnwuB9RJ1OnB4nXR
         eVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332844; x=1747937644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmhE0ZyXFIMq1ejroEpNwIAE09HwUrQ/oEQO4pBE8KQ=;
        b=GEsqJ9MhBiwtYBrqDTEzuvIkRPfG/STJmFhMZYgE+oTeEIQGPfIHUa3wMkjZhLPfjT
         +8ljXzBgcPYC0CZLO/0HS0yBg4bDkCh8LvHbipsrLEKdF64L5/ly/XsDwIwdEOiMRHgL
         cgd6nX+iaKR//4RajO+oSV7wPwEGrdea/T+LarM280ZhVZFLgy9i8ovM9Soaa+xb2CiV
         Q+q9vOcidkL2cpf6ALiU1vT+FUMYmx0kJVS6XQe1i5ihNBWIjGKbT1ujIc+lxu7ZxZPo
         UwZJosUZEROnfE2ekmsGIl5aVxgn1wJ8YOJuft/T58ORi2FonPFLSWJWf0uPNvLAoaO4
         PUsw==
X-Forwarded-Encrypted: i=1; AJvYcCXbylhrPDjw+JfwiVuSVfrCR97S3HW3gPWfCOviYJEtihRC2P28BvzK2wjQYLngiITI5KbUZx9c@vger.kernel.org
X-Gm-Message-State: AOJu0YyA17PBPIVYPZcvvLD3+ryKqzLPKaaXFJk/TYii7zOyyxNgX7to
	IBDO9ra1Kt+/02R8u97OlF6s28tiSJ02hMqW6PpGgzNc6FlOMBp7Qg4NOO3G08eiaS0SQVfhMsk
	K7D6xWjVf/feMzAssCfGLBlJlIpAbYiCBpNhhEB86
X-Gm-Gg: ASbGncskVafQNqw0Du2nQXeiY9kvOp1tNIQVN1BPRuQH43VtYNTgqb1XrD5dWN+wUVP
	YRwzCVjceKp04d3L2W4yjv8bEwgYypudKSOQv4nzhK4xboSEqdM9H2huRvHisAiuLublKDfbz+s
	eHfJ0was3u6wkT9DBDP/jbj7B1e8E7j6SUmqH2WK56/LY=
X-Google-Smtp-Source: AGHT+IFy670LlAegjCytZhdLu7KK8GCvgi4jANvaDLaVu1jBwnv38qWvqDWmYrWEdt4vIjmJKbKAIG64bXyYibiNH+M=
X-Received: by 2002:a05:6902:e0a:b0:e7b:6499:c9a9 with SMTP id
 3f1490d57ef6-e7b6a0a9ccbmr843090276.26.1747332844169; Thu, 15 May 2025
 11:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409185019.238841-31-paul@paul-moore.com> <20250409185019.238841-60-paul@paul-moore.com>
 <81106a29-90ce-4439-9b4c-60bb2962fe04@schaufler-ca.com> <CAHC9VhRUr+sXhLzDSjiG9bEVbzZd2u632dLMVpcCe6By_d_H4w@mail.gmail.com>
 <3d884912-6225-485b-a7dd-2aa4073265f2@schaufler-ca.com> <CAHC9VhR5OFDvJNJLy9jKMsB4ZVx=phm6k6iebT6VuXD96kNEEA@mail.gmail.com>
 <c5b81e66-7e73-41cb-a626-9f18f6074e53@schaufler-ca.com> <CAHC9VhSiGc16g36gtZvWKYdtdx-3WG7HbWWhNXvPSBRfA7uphQ@mail.gmail.com>
 <5df7b895-888e-4aa0-a21f-0a8264158bfa@schaufler-ca.com>
In-Reply-To: <5df7b895-888e-4aa0-a21f-0a8264158bfa@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 May 2025 14:13:53 -0400
X-Gm-Features: AX0GCFv1XixYnJIYpriKgewGWoFqrzG1K0YAkWW4-n7gSHnWYpH7UfxE82NSNaE
Message-ID: <CAHC9VhScu-AsvOAJ+4VoQB_QTmhuFGwVXmQF2PpgH+D-qLi7=w@mail.gmail.com>
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

On Thu, May 15, 2025 at 10:12=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 5/14/2025 3:11 PM, Paul Moore wrote:
> > On Wed, May 14, 2025 at 5:16=E2=80=AFPM Casey Schaufler <casey@schaufle=
r-ca.com> wrote:
> >> On 5/14/2025 1:57 PM, Paul Moore wrote:
> >>> On Wed, May 14, 2025 at 3:30=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:
> >>>> On 5/13/2025 1:23 PM, Paul Moore wrote:
> >>>>> On Tue, May 13, 2025 at 12:39=E2=80=AFPM Casey Schaufler <casey@sch=
aufler-ca.com> wrote:
> >>>>>> On 4/9/2025 11:50 AM, Paul Moore wrote:
> > ..
> >
> >>>> In my coming audit patch I changed where the counts of properties ar=
e
> >>>> maintained from the LSM infrastructure to the audit subsystem, where=
 they are
> >>>> actually used. Instead of the LSM init code counting the property us=
ers, the
> >>>> individual LSM init functions call an audit function that keeps trac=
k. BPF
> >>>> could call that audit function if it loads a program that uses conte=
xts. That
> >>>> could happen after init, and the audit system would handle it proper=
ly.
> >>>> Unloading the bpf program would be problematic. I honestly don't kno=
w whether
> >>>> that's permitted.
> >>> BPF programs can definitely go away, so that is something that would
> >>> need to be accounted for in any solution.  My understanding is that
> >>> once all references to a BPF program are gone, the BPF program is
> >>> unloaded from the kernel.
> >>>
> >>> Perhaps the answer is that whenever the BPF LSM is enabled at boot,
> >>> the audit subsystem always queries for subj/obj labels from the BPF
> >>> LSM and instead of using the normal audit placeholder for missing
> >>> values, "?", we simply don't log the BPF subj/obj fields.  I dislike
> >>> the special case nature of the solution, but the reality is that the
> >>> BPF is a bit "special" and we are going to need to have some special
> >>> code to deal with it.
> >> If BPF never calls audit_lsm_secctx() everything is fine, and the BPF
> >> context(s) never result in an aux record. If BPF does call audit_lsm_s=
ecctx()
> >> and there is another LSM that uses contexts you get the aux record, ev=
en
> >> if the BPF program goes away. You will get an aux record with only one=
 context.
> >> This is not ideal, but provides the correct information. This all assu=
mes that
> >> BPF programs can call into the audit system, and that they deal with m=
ultiple
> >> contexts within BPF. There could be a flag to audit_lsm_secctx() to de=
lete the
> >> entry, but that seems potentially dangerous.
> > I think the answer to "can BPF programs call into the audit subsystem"
> > is dependent on if they have the proper BPF kfuncs for the audit API.
> > I don't recall seeing them post anything to the audit list about that,
> > but it's also possible they did it without telling anyone (ala move
> > fast, break things).  I don't think we would want to prevent BPF
> > programs from calling into the normal audit API that other subsystems
> > use, but we would need to look at that as it comes up.
>
> I suggest that until the "BPF auditing doesn't work!!!" crisis hits
> there's not a lot of point in going to heroic efforts to ensure all
> the bases are covered. I'll move forward assuming that an LSM could
> dynamically decide to call audit_lsm_secctx(), and that once it does
> it will always show up in the aux record, even if that means subj_bpf=3D?
> shows up every time.

My only concern is that I suspect most/all of the major distro enable
the BPF LSM by default which means that suddenly a lot of users/admins
are going to start seeing the multi-subj/obj labeling scheme only to
have an empty field logged.

--=20
paul-moore.com
