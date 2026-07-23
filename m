Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107141379E
	for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813442; cv=pass; b=hPeJhRqSCsFHh53OJnXmHzyzeNrslQlzQWgRNW+9nmwRiKdLIotffaIN8sWTsV8ve+IyOz3qa6OLTEfsyI+2dDdmBoHuNYPUqJqtx3GaEzZGCu9Saiwm1vBJqiAJu6+pkni5rwp1CePNr2AW+rUYzA358bVmnMU4Z9EvuDibysY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813442; c=relaxed/simple;
	bh=NCvmQEUqPANjs9/6CVOdGMxpy6j/R7FQZr18wytvb20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hF5BpFN0Wwg/qIeKki+LxLu0OSj1TEsuAnSYtfv4EpQDlxIRCJUrf/l9588VQ2QsPdnjpeBMoVn7eH3HDItDiZtbUv6Vi0cmq4Oh8ei1y09rvzEKWNmiholsvEzgk3MzDem8IsBLc4DJLFzUZICPNADGegDkv3lroqFqWWkANCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jADeZSmk; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jADeZSmk"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dcbade417so633581a91.1
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 06:30:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784813439; cv=none;
        d=google.com; s=arc-20260327;
        b=dDGBZrUWQndj7RugmYx4hoCelua9XMQVml18vyI0BNUwxpYiLWGR7SSvBpIZfEw4/i
         LkqVwqenB1D0SbKNv8oSlyZJyGddg6gLELnbfNQ1dewW/NI1VEAAf40t98FYhY1iVlce
         8vEy/RoJbzdp0ER6yA+b2wYbXjn+gXg95yvtQIfXdsCrkCtKdM4DTTGs7USnhg4SlzIK
         3z5xKrimSCI+ZyAR3b3HWlArouYXQ7fjeXXLFjWjY/4NadegXyvDlEJ7Hx5Nz6cSxYfO
         lTzAGicUcqkjYtbURk+vheUE1f0jri8IqtN5SxRhYAMDZGoPm8k8uhH3oxjmlggHsqZk
         65FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pbsTCHDvGgXO6J1/GCYI4oRMCElv8HkgCnl9ZqI8bQI=;
        fh=sEXXZHHOaetdSxeivqdrIFtWFCVaxn+K18VHEkjIQmI=;
        b=ZTkvoypEDGg4z2JWfOUpMOERU95ymhYaQJaC70by+AdcOl3Qwm8M0jHfrK9iJ4JvrN
         sXJzp9vP6Eui9bOL7CWlCeMKdjwg9/BUjmlhJZuP5FmgPAL+kihFSFBdnNskmnAAwsW2
         aPuHorsj4tb8CuImfTM9amb9YNQJGyydJbNgl2LwXrO3CFKc7N2eUOjTuc/0S9LR5Lc6
         KXRUMslcZ/I8tzHzixyETT2u/mQKGIYdR/3SJN3hIvowSty0tYrHG7SZOtfbaYb1vZBQ
         UUpP14mziu8swtZhuiMe5c8rK6S1YSl6Z8aXrbuQDZlcglWvZ5QmSUel7zIW344vuWQk
         ncnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784813439; x=1785418239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pbsTCHDvGgXO6J1/GCYI4oRMCElv8HkgCnl9ZqI8bQI=;
        b=jADeZSmk2ro3PAqeEQzWLsw6sSVegvhDrDOqsD6wmcJ7BOADI6T/F5YLHZcaLpBOhN
         m2hBfnIc63xnk4gZ5e3HoEkLQMFpBKdGD6auZT8fps1i9Pv8iefjpsEAufycibnAYmt5
         10uDT71pDMOHIKP1oxt+9ebajZJrZr/zBoS81nDGOBYbypbgFa3YXVaQMgkbRUigzNGw
         7ImcilLdYBx9jabynhlPyL9pI23zN4z47PAlRqnLrwz3rcqrn+fct2H/VI/iHjHUk49v
         q3bxWOuDYfi9ccre5bYkop9tpj2MmhYKR2H6q48/aSSbxIeXGMzdC+ZmesCayYmjnL8x
         sMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784813439; x=1785418239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbsTCHDvGgXO6J1/GCYI4oRMCElv8HkgCnl9ZqI8bQI=;
        b=mu/ZY2A/X9tgCERopHWCb1fr+2awnVdyXLpMcHE9gNhfAPN306p8ftWOejokpeX8ZZ
         +2g4JYersT09HMNN74/9GbV7l0urZMj7vnzxpARd3PK/2N2rneuOgEJp6+fQ0kp0Puj8
         rAbD7mS7X+sQojaQRnS8eXWtPWAOy0IOlvz6BYmlRnHmjPMcOPsH5bzeHCOwXT0vtDOW
         pRDkus/ovydIIQbSB2py4URkpMk/cacmjMguuEKJzDx0wDIiZwesTCfzmhkDuW7PHwnM
         djGaXDZLmc3dO44yLpsA6s2SYvJ2xl5JIMMKy9gucwBkGOY5FEVU4O3XfP6f6QHN+zBT
         4qVw==
X-Gm-Message-State: AOJu0YxIY1FJsBGzgCXijRbeMcT1KiKhT5wtkwlufvgtxoNR3aaVue0X
	aReRlESXw8EbV86yprzUmDSmVxm0SuAfj7+nUe+ADfnsCGTCO5HtXnDQk/vJrWEzVJVD98tsbHc
	0+4Nc2TALRBD1uvyq/20VmZ+Ue0bPUSI=
X-Gm-Gg: AR+sD12fXhXLQKmL3B2ViZde9JE9pTak6nEQ2uxf3VAaJNhvvGnJyvapkpTwdH0lz0i
	uvazf1z5PNi3uOKVDtEXytbU+m0CiUfLxSN4jUBhahM+EmBwhA1tGCWhFRaQW5GbV8nov8O4Uhw
	1nu+hBuXlO+ryqkQmIpIrmsPWTCSSkkzajw4EDydbHHRPXnoctPKPNoE6dfoJostuhXWIRObljQ
	17whzN1w/fuknFnVCX1hf9/5yUX26v+/ej5GOMEDobJHezw9/RSVkBdqxeKIg==
X-Received: by 2002:a17:90b:2401:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-38ec7b09639mr1813101a91.0.1784813439289; Thu, 23 Jul 2026
 06:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com> <20260723062355.3096648-3-jason@perfinion.com>
In-Reply-To: <20260723062355.3096648-3-jason@perfinion.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 23 Jul 2026 09:30:28 -0400
X-Gm-Features: AUfX_mxCrjyqcsbWa27NJvHOGliYT8HeHyBtsH923zCUMPM7U0qfhJLpUAj5T64
Message-ID: <CAEjxPJ7RsJoivrD+xr9qaC2znKkG2NxZCuMqNRRHVah6h2BwJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] RFC: SECURITY.md: Rough draft of codifying the
 maintainer process
To: Jason Zaman <jason@perfinion.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:25=E2=80=AFAM Jason Zaman <jason@perfinion.com> w=
rote:
>
> Since security issues are quite rare, best to codify the processes so
> when they come along we can fall back to this and dont forget any steps.

don't or do not

>
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> ---
>  SECURITY.md | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index 49c40e97..145a2714 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -35,6 +35,9 @@ the issue as quickly as possible and shorten the disclo=
sure window.
>    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EA=
F
>  * Ondrej Mosnacek, omosnace@redhat.com
>
> +If unsure about whether an issue is in kernel or userspace, feel free to=
 send
> +to any and the maintainers will handle it internally.

I'd recommend sending to both rather than any to avoid potential loss/delay=
.
We should also mention that private vulnerability reporting is now
enabled on GitHub,
so another option is to submit via:
https://github.com/SELinuxProject/selinux/security/advisories

> +
>  ### Resolving Sensitive Security Issues
>
>  Upon disclosure of a bug, the maintainers should work together to invest=
igate
> @@ -57,3 +60,26 @@ lists.
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
> 2.54.0
>
>
