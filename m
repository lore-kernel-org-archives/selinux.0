Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77161503BEB
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794595; cv=pass; b=RF4ToyCItNDq8YOxE1xIyC9Z9tbTZGCm99HH7XF8YjBRNU0gTHIzQW++k1kjxj3+M1wQ2Yyo1FmfE4USdpLO98WDFHJiizoDDIBxP0KgtKVURpDZFN+EuCsKDePUFDcCvLcKg33RZ0rD0U/m9n+tZV0ww/4p/+SG+ZYALWzGBTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794595; c=relaxed/simple;
	bh=QVlqkZLzxjZyTnfJ0zGXjAZu/G8KYiQMdU1eevlQoAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AAmmTupwXuB8eGrnmc7jTBloGI0oLdSbbyp9GhDc5n50q6Q1BDRT2AXs8guuUwScbhC6yQ504ghhAkC3VR4Vp/Yb5KQ4FrMVxknVOOG+gpqeRahiW0Z/8Axsel/YQ9lNBFOtAz4IapZEpIcJ6LjNswPc0ZTt7nyqzlTbpjrorrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bk2hgeg2; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bk2hgeg2"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f4e1568932so3035119a34.2
        for <selinux@vger.kernel.org>; Mon, 07 Sep 2026 08:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788794592; cv=none;
        d=google.com; s=arc-20260327;
        b=rKes0sThWUqKS1fx2/NA9J8VeEiOrEAHXkkVAW18zu/WxN6A9jcCrQfFjEcXDowKN8
         63vvLbUpsZBTGGFLvZaQEzfr1/mu6s9YzULoMz3/JrpAF05fnuowgW30NfFeiO+bGNxT
         5oDvEeXPf59XjTvW6vVnVyISiI/ugMBe/j4UKfpr37EQ4vzS+SsEuAiE5iIaDcVBtBqC
         i0W9OGqO9s2vyhjSXsTNBNHPOMrZ5Vwqe/80eqJA0dOg29Z6QLRzCIOjZF9ycrIt+iFd
         8aLvxYN/k/cMYiC8hfIBHOLRArGnAdOzc2vIp0O5WnE/NewozreRNRhBNAYcbAt7pEoA
         yU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NaQu6FIxhy6HT1m4d7h/LfeSv4577cIcD4+6ywYzzIw=;
        fh=BmpZJMTl1w8gOPvGUFZ8ATIsvQyfZBE3SHPYesNog+I=;
        b=llt676tZu9ltRDybJuO8xQwqa3rlvd1xFMZsyfSE1H1NnDtmITAxRiL4LvlmNdAiLj
         yDsmD0fGXU7z3hOaS5lSov5Rezqmz2Y5h++Rc+eTmN4BmCmw9yY9UzT8oWidrDWryyIY
         TnUMGPJI2bAJTDhKdUJL6n2WD4Xs1cxkXxX24/gFfyxplgMu/ILHJI4wnxr2GZG6vuQ4
         UzZgnWFCYU8+pwen7B9XDngQh+PtRWX2lTEu27/aRDWzuqxBC0V6VXdYEGMkh6vapAoJ
         +X/N/vUYTijV80l2zzyNh0JcizgsNAY4FAEvLFS6D2R5jT3nCqmd6wNuvQtU8Eevgt0A
         oTRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788794592; x=1789399392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NaQu6FIxhy6HT1m4d7h/LfeSv4577cIcD4+6ywYzzIw=;
        b=Bk2hgeg2O9c7xHqgRZVu0eY77kHzJ+t0def2eHMakyEio6QKyQGUHnKUY1CAAz3M9G
         Q9wrcWO6fuMCKde4y8l8bdTj+VvkRZ+j++4EiPFCckKj0KSM1+7zl4ohKudbzq/FlEM8
         Yddm0r46x5Qa5NKX7yu4GdnWtCkb/ZI4hg48Op4jI+qfaN5de3E2bZZdl265tqkm2+Yw
         e+xFFr6zom7fpCNC0ezbbMC42+G3aZ7xBKUY5WwA87Fk9HtSIOvnyG/5VsmBcABwGRHb
         e5aKwMQOpES8S0gsrm455WojN+0hBlnGhxYPTF36K+f+soi4M3lIE9E6QZOdBFoGS45J
         UA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794592; x=1789399392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NaQu6FIxhy6HT1m4d7h/LfeSv4577cIcD4+6ywYzzIw=;
        b=fRwqg9q3G9zzVsG304cdnQZnr7v0jXqB2ljy2o3G94LwhQVxohwYIAVOyXD9XuO+Ru
         KyGqsdtic/1la9m/hSCghkqhgKVFfSD5YOstior6TRF4pVDvhlN9dwJ3meYJ/rsUsb4k
         H6qJhbimOi4t7TGACdkazsmUq6bNEDVtyIHQS+9hDZsk/rvLOYNukZ775FWZMsY/nqkl
         yUbg4S+SV/NnpJ+KyYX8n/S9qo1zVjSEGSXMNGleUMr/nat2py2ywWHHLfWRG66iLaqG
         3OsdssG7fUPhtxbipr70bcpDOZ8xRH3/OM7ql0VjO13+iSFLhGk74FQsRYiua/o3mzvq
         wZjA==
X-Forwarded-Encrypted: i=1; AKwUvBxZ6REoQNw1VgfPCdFYh3X4B3/DmLnN57tEgmE7lOoeM8OsNyGfSlztrGHdospbAMp1ymHYbTTm@vger.kernel.org
X-Gm-Message-State: AFuF++n25r/IFdQYfatexaxsQibfqYGXRNoRFn3xsW/imPjYSUVZsBcg
	3PjpY7JWudTjRTWLzEJpePHZWVth75W8v1YDw38J/4eIcm3/o1BU7J/vyuSoy4KBK3fC9/+aGqe
	WymO1PW1b83VeBQ00/2q4cASq4VTkEhoW8Yv6
X-Gm-Gg: AYBFou17l2qKuwibCxE8YIkpuQoETD5M+KQoqrHVGrbAA+yIAgMl5qr/OF2WjEfBRp/
	AABf1XxgiLhR2Hx0ytML/9Dh7w6ILr47Hr7msZX9b5pY6+fdAWBOpW1ztqEA6N2twet31VzFJoj
	2H6/Lt+GPZAgkFQqT87oV9o1uJGbhuZldfLD2isqihIyddlHFLizo+M19JN4THIibRRsAZ1rzdx
	4GRntIktaRns6mjGdCf66WJE9DTBHFQz0jpfTzzWCy4PWpLbPy8RkZocdh3333oyAtOA6PRXKS3
	yjIDhCu4P+zTs0aWrWXRq+HhnKR61EYh92nLCEZnuV3QA6zAC6feTX1h
X-Received: by 2002:a05:6820:2202:b0:6b1:ac4f:f708 with SMTP id
 006d021491bc7-6b6fcee3eb0mr21210160eaf.17.1788794591839; Mon, 07 Sep 2026
 08:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <L8sbFRgfQca4r8AaNEEfTw@coker.com.au> <CAEjxPJ6SQcdEDFfV3W7Bk5JKbAxRp+9tuvr2yhUdDePmeXNAKA@mail.gmail.com>
 <CAHC9VhT+k9qWsA40APOi4Q1hg8M+Ft_A7D3epdBW7P2QczPf6Q@mail.gmail.com> <RvCmRlQYQ3uewSzEeY0utQ@coker.com.au>
In-Reply-To: <RvCmRlQYQ3uewSzEeY0utQ@coker.com.au>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 7 Sep 2026 11:23:02 -0400
X-Gm-Features: AcwNN1V7BA07gihGMg42htgde0GdIvi43KYgskOWHJIB_oZokV8Gta6HLt82w3A
Message-ID: <CAEjxPJ5f1DCW5FWSE77_3HcMjt3QxMewCL5fX+PsdE_SXn-VZA@mail.gmail.com>
Subject: Re: kernel oops on recent policy with older kernel.
To: Russell Coker <russell@coker.com.au>
Cc: Paul Moore <paul@paul-moore.com>, SElinux list <selinux@vger.kernel.org>, 
	selinux-refpolicy@vger.kernel.org, Chris PeBenito <pebenito@ieee.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 9:17=E2=80=AFAM Russell Coker <russell@coker.com.au>=
 wrote:
>
> On Wednesday, 2 September 2026 01:35:44 AEST Paul Moore wrote:
> > > Date: Wed, 22 Jul 2026 21:04:27 +1000
> > > Subject: kernel oops on recent policy with older kernel.
> > > I get the above when loading the latest git policy compiled with 3.11
> > > userspace on Debian kernel 6.12.74+deb13+1 and Debian kernel
> > > 6.12.86+deb13.
> > > The same policy on a 7.x kernel such as 7.0.13+deb14 works correctly.
>
> https://www.coker.com.au/w/
>
> Below is the kernel message log output with Debian kernel 6.12.107+deb13-
> amd64_6.12.107-1.  The above URL has the Debian kernel image and the poli=
cy
> file.  The command "ar -x linux-image-6.12.107+deb13-
> amd64_6.12.107-1_amd64.deb" extracts the kernel if you want to use it on =
a
> non-Debian VM.
>
> It's hanging not crashing which is an improvement.
>
> [   10.414520] audit: type=3D1404 audit(1788699747.392:2): enforcing=3D1
> old_enforcing=3D0 auid=3D4294967295 ses=3D4294967295 enabled=3D1 old-enab=
led=3D1
> lsm=3Dselinux 1
> [   10.530653] SELinux: no sid found, defaulting to security isid for /
> booleans/aide_mmap_files
> [   10.535475] SELinux: no sid found, defaulting to security isid for /
> booleans/amavis_use_jit
> [   10.537368] SELinux: no sid found, defaulting to security isid for /
> booleans/allow_httpd_anon_write
> [   10.540012] SELinux: no sid found, defaulting to security isid for /
> booleans/allow_httpd_mod_auth_pam
> [   10.543230] SELinux: no sid found, defaulting to security isid for /
> booleans/httpd_builtin_scripting
> [   10.546402] SELinux: no sid found, defaulting to security isid for /
> booleans/httpd_can_check_spam
> [   10.549244] SELinux: no sid found, defaulting to security isid for /
> booleans/httpd_can_network_connect
> [   10.551298] SELinux: no sid found, defaulting to security isid for /
> booleans/httpd_can_network_connect_cobbler
> [   10.554654] SELinux: no sid found, defaulting to security isid for /
> booleans/httpd_can_network_connect_db
> [   10.556863] SELinux: no sid found, defaulting to security isid for /
> booleans/httpd_can_network_connect_ldap
> [   10.559776] SELinux: failed to initialize selinuxfs
> [   10.568734] systemd[1]: Failed to load SELinux policy.
> [!!!!!![   10.585074] systemd[1]: Freezing execution.
> ] Failed to load SELinux policy.

This appears to be due to enabling this policy capability in refpolicy:
https://github.com/SELinuxProject/refpolicy/blob/main/policy/policy_capabil=
ities#L154
which was done by this commit:
https://github.com/SELinuxProject/refpolicy/commit/2e810736211785675f0be23a=
26638cd44c69eaae

As noted in the comments, that policy capability requires kernel 6.16+
and the one above it that
was also enabled by the same commit requires kernel 6.15+.
