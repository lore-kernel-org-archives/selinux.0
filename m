Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659E73C7692
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105755; cv=pass; b=NNjS5pVzTUeNIKfMtrtX0YxTIgQ344iloSFpwj1c5cRTTLtJojzRqEkUk6ctbS8DA6GoXMej3fWQANyYpiANEdez802JFEb1clXZqaq4p8S5nkeaRHRdWv8XzptvkoD5LNFMipxzwViV5Vbbo+9uqZoGU9WwgQtcrZ+oW2AR6dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105755; c=relaxed/simple;
	bh=7JJrzSz6wNYZtOgx2pC6+xRbYTcUrJd6WxqZLEd2h+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GydngLSL7aeRHIZe1ocReddeqVak53zgvMLl7mWkjq3Gjc9M1849q8OiBahjrzFG7SOBl5p0FT1MPtMf5aj9vphthLBpJzGI1puCK0BuHHOwC74HWsmTXebMnbaBwccTuXFpvNoLosDdBGcMPLWy52c9kC3AI3IUETqnFTTvR44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/eGZpHc; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/eGZpHc"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb34c17b96so2292435a34.2
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2026 05:28:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786105726; cv=none;
        d=google.com; s=arc-20260327;
        b=bbJgOq63+j9Nnp2gQOrlujGamaRDhJ8tUF+ZmwTWTFo95E6Z+GldqqbrcsPISmtUSe
         cxushTh3m8tMR9IW0ho0gpAU8jwTpML/wU8+L0ikzTD+7p0ijfsaDgV17ePZyus3q69Y
         g4uv8f2P7UYZ1thH1GDQqQMv27xw9JM5IwjdNWN5cuOwqDdCCwujlNN6LCmSJISXhlgi
         BaubHFTnx2hKbzgxgGKo1a3s+2QRwTCOPqkfP2bCTEIeooABnmktesCkeIVgvXC6Uggz
         9f4e906IZlFMIRSc82HY7n6lpKmBt0CHIZOz58D79hGsI9a6wg9jdj4meKbmd+IE9AH7
         RSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EfD90nfKiBEgj1/347EvU9i/rU6RD6dBVaG/pg+Xxa8=;
        fh=6jJsRDLm2/TGyAy9cm8X/cBiLSfpaOXBhfAk79bUzFc=;
        b=VXsYg37YrMu4mNMdzMZmF0PX6BFA14v4it98XTtGFyw7Z3LWm8Uu7hHML7XuixbFH/
         GnRI/bNJ/veNXN0/ziu3LxheeWH/4cNkuu08UeJQBXxDWQ15gq8fCggantPBpKvhbGeN
         AuYTb2/1Eir6nLL12VopSQjd64pqfEjey9sCCcqzSrhuShpHA2v7xsNKuYdCPmLAE24L
         sa+23Cc0ZQRoeEPDqNsYfmBlmel6OVwz6Y3VdEaBgg0BmSs6PPm+fVU1NwbdxRwceodG
         WuYwDRuJGRJ6dTH+59xjAn76uWMnbQtPPekAuQ2uckCTIsr3cJeMgjWIJdYfJHHHj4FX
         4Ivw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786105726; x=1786710526; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EfD90nfKiBEgj1/347EvU9i/rU6RD6dBVaG/pg+Xxa8=;
        b=E/eGZpHc+FXZvVh8z8OxGY5Xt993AW5Vd3RAYC6IWfKoM/eI8OEFNEHfw6k6hUxiFW
         sZ+xTysoQeq8V3b7MLLGwbvydG65wryKlRFkeAXTOGLk/o17BRa438yCxVzGtt2KPX7z
         IAquJvg7N3VWwLawl49qhS+DDUBCG2TDvcWKlOkrkSWt6aWGjF38s93YF3mr+o3kCp3a
         CtVJrSZUbFsAw/YWX5N1pdBsN67ZNJkQbKiNXZ5Bn/6il1XjI9MK9NWjHrMBIRHhPDqN
         gqfS6TYvnVYhiJZ10DLVTHEa/7iY5FdxFtUUWVUa5dxw2LUbK/E5fIDDSzU8FJBMvWGV
         yl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786105726; x=1786710526;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EfD90nfKiBEgj1/347EvU9i/rU6RD6dBVaG/pg+Xxa8=;
        b=ERk9sajLulZDCgfbSdjHm0aj6ZO6/wO6ZyhjJh5TCX6ZLvFqrf2EmvbbjLtxkV5/1Q
         uFnIQj9R2MnL/QckpEdWJUloHwLuiMjn0053N4fY6/26EK2BP40Q6iFzia1IC7/aKnrZ
         0dTrPk3pI/EIRkdnA3LrpFzniiVVjfJAbyrKLpFhf2cGBXFJNdGdB8LgXH5tkflP+yCk
         5GtxEvW6uF5cZlNTMHyosD7uWM9U3idAX73UXtnI38Jb9z2XXnFvzFFuwTXQ2Vgw4BJq
         T/bf8cZI+F858ZpCVrTGY7Is0RN1JnOqU2m+2vluJ2YDNtPz4OVdrzohI4xn7HLe9e/E
         FSgg==
X-Gm-Message-State: AOJu0YxM6O2ucO9slsQcMAuTw3PdD9M+qLYoF+QWx//cPaQCfoJnd4jv
	XVqOnN7zQrmYDYY6L48NR4A+wEmfZO9G04gwXNLzBip528MXFEPik3H1Cv1kwfisUe+43imOIMN
	yV+i+BgBYZoDsiznYjhOOFwlwcP8do0uUFw==
X-Gm-Gg: AR+sD107ue3bfdn7RtWVpQHV3CqtN9NUcVE5EGU3h0r4jHB/RovF7rzfwAqZhwMGowA
	/RtfDJiejvopOsIWZZfbjJ3i41ux7xAj+PbJL6CiXO3vXcCZBCtw4HH/ju+SIAIbNW7J1r6rPsA
	fu17w4Ncs8ZuOxQkgagC1xTGbDHisMYFK76fegc/5+D0ltVeqgMwKRv8MBbqaCJtJitohWHk1lH
	OlWObKhnfe3aoe4EAta3Pcz/qlmgln/F0/hZNQtNHP9I9GaWrRvWW1j5sDe8creYlxAaWM0Sbtr
	tqvH6X2Y6FpG5tAM/OLzoDcxAzr5NmA05Kpc7bhZOPJs
X-Received: by 2002:a05:6820:4cc9:b0:6ae:90c3:32b6 with SMTP id
 006d021491bc7-6ae96c10140mr12290513eaf.1.1786105725769; Fri, 07 Aug 2026
 05:28:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803173951.46352-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260803173951.46352-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Aug 2026 08:28:34 -0400
X-Gm-Features: AUfX_myzZ8O0YVqdKJlQsSR53oWEnVvoeyXSbzq3orY_i7J6tuLDQXjvUpahiM0
Message-ID: <CAEjxPJ6a6d3+SDgq+9BV3Z7in0odjWxdZ7_c757yRY_EU4HMbQ@mail.gmail.com>
Subject: Re: [PATCH v2] SECURITY.md: Codify the maintainer process
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com, paul@paul-moore.com, jgsegitz@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 1:40=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> From: Jason Zaman <jason@perfinion.com>
>
> Since security issues are quite rare, best to codify the processes so
> when they come along we can fall back to this and don't forget any
> steps.
>
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Sorry to nag but would like at least one other selinux maintainer to
ack this before merging.

> ---
> v2 makes the changes suggested by reviewers and drops the RFC/draft
> language.
>
>  SECURITY.md | 44 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index 49c40e97..52ab863c 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -13,16 +13,23 @@ involved.
>
>  ### Reporting Problems
>
> +Note that issues that depend on attacker-controlled policy can be
> +reported as regular bugs to the public selinux@vger.kernel.org mailing
> +list and do not need to follow this process.
> +
>  For serious problems or security vulnerabilities in the SELinux kernel c=
ode
>  please refer to the SELinux Kernel Subsystem Security Policy in the link=
 below:
>
>  * https://github.com/SELinuxProject/selinux-kernel/blob/main/SECURITY.md
>
> -Problems with the SELinux userspace that are not suitable for immediate =
public
> -disclosure should be emailed to the current SELinux userspace maintainer=
s, the
> -list is below. We typically request at most a 90 day time period to addr=
ess
> -the issue before it is made public, but we will make every effort to add=
ress
> -the issue as quickly as possible and shorten the disclosure window.
> +Problems with the SELinux userspace that are not suitable for
> +immediate public disclosure should be reported using
> +[GitHub private vulnerability reporting](https://github.com/SELinuxProje=
ct/selinux/security)
> +or emailed to the current SELinux userspace maintainers - the list is
> +below. We typically request at most a 90 day time period to address
> +the issue before it is made public, but we will make every effort to
> +address the issue as quickly as possible and shorten the disclosure
> +window.
>
>  * Petr Lautrbach, plautrba@redhat.com
>  * James Carter, jwcart2@gmail.com
> @@ -35,6 +42,10 @@ the issue as quickly as possible and shorten the discl=
osure window.
>    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EA=
F
>  * Ondrej Mosnacek, omosnace@redhat.com
>
> +If unsure about whether an issue is in kernel or userspace, feel free
> +to send it to both the kernel and userspace maintainers and the
> +maintainers will handle it internally.
> +
>  ### Resolving Sensitive Security Issues
>
>  Upon disclosure of a bug, the maintainers should work together to invest=
igate
> @@ -57,3 +68,26 @@ lists.
>
>  * https://oss-security.openwall.org/wiki/mailing-lists/distros
>  * https://oss-security.openwall.org/wiki/mailing-lists/oss-security
> +
> +### Maintainer Process
> +
> +This is the process maintainers will follow upon receiving a security no=
tification.
> +
> +1. Make sure all appropriate SELinux maintainers are notified. Regardles=
s of
> +   which maintainer was initially contacted, others should be looped in.=
 This
> +   may also include the kernel maintainers if relevant to the issue.
> +2. After an initial review of the issue, maintainers will agree on one p=
erson
> +   to be main point of contact. The response to the initial mail may com=
e from a
> +   different maintainer. If the initial mail was PGP signed/encrypted, t=
he
> +   replies will also be PGP signed/encrypted with one of the above keys.
> +3. Maintainers will work together in private to verify and fix the issue=
. For
> +   larger fixes, this might involve a github private fork within a draft=
 github
> +   security advisory.
> +4. Maintainers will prepare the fix as soon as reasonable. Maintainers m=
ay
> +   invite the reporter to the draft security advisory or private fork to=
 help
> +   verifying the fix.
> +5. We will aim to release the fix publicly quickly, but may request an e=
mbargo
> +   period up to 90 days if the complexity of the issue requires it or if
> +   severity of the issue requires coordinated rollout amongst distros.
> +6. Public disclosure will involve pushing the fix to the public repo and
> +   publishing the security advisory on Github and to the mailing list.
> --
> 2.55.0
>
