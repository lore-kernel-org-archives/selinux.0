Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B533134D922
	for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734545; cv=none; b=jCexIf9xp/akZIGowtnQw6Naiz5RIfs+Eb8J/rryKpBr1lLyGIcpjou2K6C9GMlOybBCYVyaSGe2tTXCwxL4/MNPzBmyKZP6h++7b0iyeZKK7GtZm5J0e4uWzxMq+mXhIpglll5siIuXgYBVcY456PeeBfhJrvCdQy8kM78drKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734545; c=relaxed/simple;
	bh=dEEiUT13N+9pSlKMo+Wp6WV5Ae9PGV92DcsF0U6kQZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpZFQ7qCB+ewFlyzgQ7vuOgSFJNSQTlTWIUpgSYdN8H5uoZhqVFaGbIrv915pTw7HbeN2ifqobncr7rhlawx2i1U2kmSsBN7dwqvmgSt4pWgnzXnEMyQmG5o4koOr47Q+eIgCkKN2mp9J+D4v73da4Mjeh8TDLcP55MZEqx7ZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWW07dzO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWW07dzO"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34361025290so1673294a91.1
        for <selinux@vger.kernel.org>; Fri, 21 Nov 2025 06:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763734543; x=1764339343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEEiUT13N+9pSlKMo+Wp6WV5Ae9PGV92DcsF0U6kQZc=;
        b=bWW07dzOU8SCmIfRS6kNL6xH/cN6B0pfxhFD5KLI0fOd1MuNpiZu/xU/Bj7TCQJwgx
         DYxbRKkRWt3mhEOQ1+RFBiZPRRgy3mhDYi2EXlI6ab9sWruWBENaPyw3/DU5yL1Enn+h
         bT2jcXYxHUlcbBZl6LVPPxt2JydPrVDwyNcxwxwPC3zFDqKCUyJipcd9Ph/klJKdOMtH
         JDK9VePBpulXTVZCkiXAzIhv47RLKQEBAgV+2EdNnyvTfw2Otrldb/mKjYHBZtwNDYKw
         Tu7/YOsuG+dfPFVwl22IM6d3IC88QC+Bud1cR2KEqxZ3IBduRuts3TBNsqKRC961AiTd
         iD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763734543; x=1764339343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEEiUT13N+9pSlKMo+Wp6WV5Ae9PGV92DcsF0U6kQZc=;
        b=SuvgdHhb+3bT+l+KQLd8DtNBW0hMEgmzZ1YlZW+JAHeWeGVL+Eg1yM2SoT9IiFcoEu
         Z2YXJganRuAONMHPn+A4lN2Qv7upkiB+2h+BDURopzs2D6tu5WTlCy+i7IrZf7jlz+PR
         dBSbq5roxHvrmopahG0NsIvFojYFlYks87/37snWWiByAx20jNbILjZ0GBZq1LAOe55q
         s/uaEWGXNmpdv50ItiQ9BAGZXnM2LvzNQDBTw35SEGeHdAtxtFIRHyZCtT/66K377ZaH
         hlsp9U4+23Jkr444/dO3OEKjkSxHG66oXH83qGsrgDyXTOhkOQeny2zbMgtNebGI/SbX
         5phA==
X-Gm-Message-State: AOJu0YwgIOe244Hf1KoNCJuoY6cQWsbPp5O+Rdh0QfR0y1kcXBO0lhjp
	AQLf9K8+wg1K+XbbmCB6UwqOENFKvYzI201JQ6Ck5T7HGF5T5m4JE3q2ElVaZHsClkZsFP3AJlU
	sXe6XGfLJoTFf0vCSuajks4YZY718YL8=
X-Gm-Gg: ASbGncv+ivUQUMTLlNnBMfU2lqvRUH68LQygDMWY9QDh/tnRcMWfGw1OFefOf1W6+VW
	QRov2Si5HOJxDwTqbuDkOGaj6+xOL8mvWndO13n1BGJTjLtYAkh1Y52qJPOTl6lzudbMGKpPUB4
	oG0LgoYlz8QqINBoseJtA6AxVNGj0AEZK2nr7aFBYPzdOImKCWUHyT2nYoWfEI+HXHF0CdhCyoq
	f6o16fNBwhm9mrfFOlyYvTxc1nCdTsED9WvVvSx1Ns2lypAcW9E/2hnKh0anfMCiSWjYVg=
X-Google-Smtp-Source: AGHT+IHdcVtWgFK2PgJHnaOD4M6IGhGmW6VJurVbQKotswqrsb6Pjhq45gAdpWh/Q8qQjdSJiPzG/oeoaS+bn8bhnoY=
X-Received: by 2002:a17:90b:3e87:b0:321:9366:5865 with SMTP id
 98e67ed59e1d1-34733f517cdmr3065390a91.33.1763734542478; Fri, 21 Nov 2025
 06:15:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e004aaad-7885-420e-9001-af4897885daf@suse.de>
In-Reply-To: <e004aaad-7885-420e-9001-af4897885daf@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 21 Nov 2025 09:15:31 -0500
X-Gm-Features: AWmQ_bnXanquMQQzn0K4Q5Vu8KOZZ6KIoK2lLY_iQsbX9Cfqjb1pCFFxDZJuOrU
Message-ID: <CAEjxPJ4eE_gau==Fj6fytyQb=jciQo+x391iDUh4EbJUMfrGKw@mail.gmail.com>
Subject: Re: Question regarding no_new_privs for pid 1 and SELinux
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, selinux@suse.de, paul@paul-moore.com, 
	Vit Mojzis <vmojzis@redhat.com>, Zdenek Pytela <zpytela@redhat.com>, 
	Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 5:25=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> Hi all,
>
> I have some questions regarding the "nnp_transition".
> We are seeing efforts currently to disable most setuid/gid binaries by
> using no_new_privs in pid 1 [0]:
>
> https://www.thkukuk.de/blog/no_new_privs/
>
> For context, we are using the fedora policy as upstream with some
> modifications and the regular userspace toolchain.
>
> The problem that we have atm is that setting no_new_privs for pid 1
> (systemd)
> means that the subsequent domain transitions where execve is used would
> need to have nnp_transition allowed.
>
> I am currently unsure about:
>
> 1) [Question for kernel people] ... the impact that would have, as I
> don't really fully understand the exact vector that was described in the
> kernel commit [0] by Stephen and Paul:
>
> "Allowing nnp_transition between two contexts opens up the potential for
> the old context to subvert the new context by installing seccomp filters
> before the execve. Allowing nosuid_transition between two contexts opens
> up the potential for a context transition to occur on a file from an
> untrusted filesystem (e.g. removable media or remote filesystem). Use
> with care."
>
> Would it be possible to have a more in-depth explanation (and maybe
> recommendation for the policy)? Thanks :D

The general principle is that it should be safe to allow
nnp_transition when the calling/old domain is more trusted than the
called/new domain.
So for transitions from init/systemd, I wouldn't be concerned about
allowing nnp_transition permission. Ditto for transitions from any
unconfined domain.
Otherwise, I would be cautious with allowing it from any confined
domain, although again if you trust the calling domain to set up other
aspects of the state of the called domain, it may be fine. If you
already allow "noatsecure" permission between the two domains, then
you've already allowed the caller to exert substantial influence over
the callee and hence allowing nnp_transition should be (no less) safe.

> 2) [Question for fedora and userspace people] ... how this could be
> implemented in the policy, such that this would be either accepted by
> the fedora policy or we would not diverge too much.

I'll defer this one to the policy folks. Added Chris P to the cc for
the upstream refpolicy view.

>
> The problem here is, that because of 1), we likely would want to have it
> not as default and maybe behind a boolean (?)
>
> I tried adding a tunable_policy to "domain_transition_pattern" [1],
> which does not work, as the m4 generates nested if()
> when the domain transition is behind a different boolean already, which
> is not accepted by the parser. That seems to be not easily workaroundable=
.
>
> So the only idea left that I have is to create a pattern and add it to
> every domain transition manually. I am not sure if that big change would
> be acceptable or if there are any other ways/ideas to accomplish that?
>
> Thanks a lot and please let me know if I am totally on the wrong track
> here :)
>
> Kind regards,
>
> Cathy
>
> [0]
> https://www.thkukuk.de/blog/no_new_privs/
> https://github.com/thkukuk/account-utils
> https://build.opensuse.org/projects/home:kukuk:no_new_privs/packages/disa=
ble-setuid/files/10-disable-setuid.conf?expand=3D1
> [1] https://www.paul-moore.com/blog/d/2017/11/linux_v414.html
> [2]
> https://github.com/fedora-selinux/selinux-policy/blob/rawhide/policy/supp=
ort/misc_patterns.spt#L4
>
>
> --
> Cathy Hu <cahu@suse.de>
> SELinux Security Engineer
> GPG: 5873 CFD1 8C0E A6D4 9CBB F6C4 062A 1016 1505 A08A
>
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146
> 90461 N=C3=BCrnberg
>
> Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Werner Knoblich=
, (HRB
> 36809, AG N=C3=BCrnberg)
>
