Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2529405
	for <selinux@vger.kernel.org>; Wed, 10 Dec 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765388228; cv=none; b=A1g2+3I0MxOyfy3M6K+s0tz7ptD3d2QEOrs2bIInVQXZH6qM4aZBnKMQDAboQjpXUdWQEWSvta9yU/trRACMjwERlXH6Ur/hKhNP5gE+YSZ1G0xQPbPztZQ20mnBsOassXG3itQm547lhzS66OE9n4WfzxWfXgsH16g4g+PVTpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765388228; c=relaxed/simple;
	bh=m1uBgwuD37TaQSCg3goVEwyNRhBd7IUuInnx3oM3+HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ub2oug4DTaC99W2FGRggitxHgcrguMRAEhEKM+US2RklxtUYo3R91K0ymja/0p2JmN/WdfRVAAXTP/KUVtMl4sVRuZ+WBy0YZsLOZ3VQjPmsJfNZEaB1om8IKPP6ireKzaKPTQ25nCXEnq6kKI21Ov8ORZ11dw/e6dpYYxXbbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g78JjnIW; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g78JjnIW"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5957db5bdedso8674952e87.2
        for <selinux@vger.kernel.org>; Wed, 10 Dec 2025 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765388225; x=1765993025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmDoFm84w27banaXhVLJk+R3Q35oiH8xx3y9Gn1Wm18=;
        b=g78JjnIWnTtezHnHpmBW9eiFK8hfZ1BBjfzAfCTukZdTfIS7E6tTa/wanYH8sw4AP6
         pUz6FnhQMpokuAtHz4TFu0T52YSt7WZH7Zn7UAhdUDsvpywMtLPEQ13bA9cLdSEJrSnt
         USYaE84Q1lSdFucsl6KUaku4uP+DDCtGd68DdBXRbefX0K6oLzyqTPSvV+VHcNQcyTwE
         S6EKkiVdsNYDrNQ2+x2yoyhiUXZjQUvDnpzHGOXZAh5BubuaI1Nh6Q4b2n9d2MrCLOmb
         4LR8Gy4PireUbRDT4XeVYzVCySRtnXl2NQDLaZgwSOezzTA/Sv4V2HLWRUyTuby42QQ9
         I1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765388225; x=1765993025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HmDoFm84w27banaXhVLJk+R3Q35oiH8xx3y9Gn1Wm18=;
        b=sZda5nXaVX8ui6Dhde2s0mnL2bWF4PpiLDaYbsMe1nacu1Aulits15RExzB+TGOl2m
         Vu6PdgJ/g8MvydlHbphp4pW9XjnMkjtHgqZdjAh4zJalTjSAiPHgynGEDYr19XeP8Nl5
         gYLLDx8Kqp1MYiYs2D9rs1Rvzdizz7A75fhXBIbCqphY93ibm1QjIKfgC3us96UDr7fl
         9DW+G4c/vyKBK3O6msA/TZmMe0u7RrZJi80fjzWZFNUFnczSxzjBAW/jt25iETdgVGQj
         kb6SCEuq0rV3YwVcp4GXHU1uWn4tNyHEDRazHiBEBfn+UF8kBGcyceJRwHm/+alYQ3wG
         9EsQ==
X-Gm-Message-State: AOJu0YxfPeS2iy0FL5DxaLXzZpAMLtAvWmhMeVsvYTujIt93VkLZ16QF
	35hXafefazPyqfFBoX6A9QPSZx2XZ16222JJ7rHvY3SfHLx3Cq5WABF+zQ62N32fGCmFN0E0ztv
	jSRBlcZLbeZVL07ca097x/haWsxKtO44=
X-Gm-Gg: AY/fxX4CWnQVhrYmVPVAQ6VeLVqTZTVO2kh3hQpgX5nYUBX54tODzccUU1b7t/QyiwA
	peSlA4rJixs+7p3LlSbceE+uQw4TxtkEKukERQ/4OHjFh79CGh88maWkeKxYXv/V+X/7k7ZMdc8
	Iw/hTBnngfJT0lpGYjJP6HzsfVgw24QbP25AlkiipwwqMYYtypuIndO4+e4teeSF9Hmnjgr7KM1
	sxOJNkT+uYLBprvm8Zjka5QvC0yvTHveAk9JblCPPNb1MY2d/ei5De3Rvio/gWZwy7yk/E=
X-Google-Smtp-Source: AGHT+IH63KlhEnqINPUSMtBzUvx7wSprxIZW4liH6fNbPht9nYx3dT33+k65RbSLdXqtEiXPGeHpvkMvaQJORiCzjGw=
X-Received: by 2002:a05:6512:39cf:b0:595:8313:3bce with SMTP id
 2adb3069b0e04-598ee48e3dcmr1235455e87.5.1765388224268; Wed, 10 Dec 2025
 09:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205024259.704-1-ericsu@linux.microsoft.com> <caeaa280-ffa3-415f-bf39-340f66ee45fa@linux.microsoft.com>
In-Reply-To: <caeaa280-ffa3-415f-bf39-340f66ee45fa@linux.microsoft.com>
From: Daniel Durning <danieldurning.work@gmail.com>
Date: Wed, 10 Dec 2025 12:36:51 -0500
X-Gm-Features: AQt7F2rilkIlWpbQpqV4hLF5R7dxxHUyYtrQWW36SOP58qQth4yt7dt0w5jUZUo
Message-ID: <CAKrb_fG=OdXSydv0GV8XmtXv2ptfNN=U0ebht_3CTu+oe-wskA@mail.gmail.com>
Subject: Re: [PATCH v7] SELinux: Add support for BPF token access control
To: Eric Suen <ericsu@linux.microsoft.com>
Cc: selinux@vger.kernel.org, paul@paul-moore.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 10:12=E2=80=AFPM Eric Suen <ericsu@linux.microsoft.c=
om> wrote:
>
> On 12/4/2025 6:42 PM, Eric Suen wrote:
>
> I need to mention that this patch is based on v6.17. Ran into few
> Hyper-V VM/testing issues with the latest kernel (v6.18) that I have not
> yet been able to resolve. I believe the issues are related to HYPERV
> configs, but troubleshooting will take some time. In the meantime, I
> would like to get this patch reviewed early.
> > BPF token support was introduced to allow a privileged process to deleg=
ate
> > limited BPF functionality=E2=80=94such as map creation and program load=
ing=E2=80=94to
> > an unprivileged process:
> >    https://lore.kernel.org/linux-security-module/20231130185229.2688956=
-1-andrii@kernel.org/
> >
> > This patch adds SELinux support for controlling BPF token access. With
> > this change, SELinux policies can now enforce constraints on BPF token
> > usage based on both the delegating (privileged) process and the recipie=
nt
> > (unprivileged) process.
> >
> > Supported operations currently include:
> >    - map_create
> >    - prog_load
> >
> > High-level workflow:
> >    1. An unprivileged process creates a VFS context via `fsopen()` and
> >       obtains a file descriptor.
> >    2. This descriptor is passed to a privileged process, which configur=
es
> >       BPF token delegation options and mounts a BPF filesystem.
> >    3. SELinux records the `creator_sid` of the privileged process durin=
g
> >       mount setup.
> >    4. The unprivileged process then uses this BPF fs mount to create a
> >       token and attach it to subsequent BPF syscalls.
> >    5. During verification of `map_create` and `prog_load`, SELinux uses
> >       `creator_sid` and the current SID to check policy permissions via=
:
> >         avc_has_perm(creator_sid, current_sid, SECCLASS_BPF,
> >                      BPF__MAP_CREATE, NULL);
> >
> > The implementation introduces two new permissions:
> >    - map_create_as
> >    - prog_load_as
> >
> > At token creation time, SELinux verifies that the current process has t=
he
> > appropriate `*_as` permission (depending on the `allowed_cmds` value in
> > the bpf_token) to act on behalf of the `creator_sid`.
> >
> > Example SELinux policy:
> >    allow test_bpf_t self:bpf {
> >        map_create map_read map_write prog_load prog_run
> >        map_create_as prog_load_as
> >    };
> >
> > Additionally, a new policy capability bpf_token_perms is added to ensur=
e
> > backward compatibility. If disabled, previous behavior ((checks based o=
n
> > current process SID)) is preserved.
> >
> > Signed-off-by: Eric Suen <ericsu@linux.microsoft.com>

Tested-by: Daniel Durning <danieldurning.work@gmail.com>
Reviewed-by: Daniel Durning <danieldurning.work@gmail.com>
