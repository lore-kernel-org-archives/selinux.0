Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7E2494F0
	for <selinux@vger.kernel.org>; Wed,  8 Apr 2026 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672460; cv=pass; b=L7vintTsHYLvD7gYvt+SZHk30jcMeI/BLwxWhZ4S8n8Ow2evzQNBtnem6CZmx2XenSD+qsKZiJhgjkR1kXE3Mz981l2mGGvCmeDiMZaXBqq8a14k+9m9u7tm+J90SPdaF5Z07mn9T1VdTIHxqPFLKpe5uDGKyatAf6NIuC3wCFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672460; c=relaxed/simple;
	bh=Kw7r0no+BNgI1Vif5OjXlYkMWlh/9ou8ANwenCHkkzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmOlTbOjqe+DYU217CMits2D7KcfJ7SWtxuIPEFoY8COdKLwQk2VmeX/LmLsxPLF/2fF/KMZ0xN9smoQuQcUI57axqUkDJd4581rHMporUMlqwiTx/E7UaG2ZrjQdQ+DLMJxN1RxD/M/FGNXa2pWr1tNzkYYTy4Odro37VRnxKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8kfKoqk; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8kfKoqk"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a9296b3926so310305ad.1
        for <selinux@vger.kernel.org>; Wed, 08 Apr 2026 11:20:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775672458; cv=none;
        d=google.com; s=arc-20240605;
        b=Sdl7X0D2PG6areKX6mQ6wWvCCikAk6Te2Cre/o9uINdDItcqc5DrZaLRVd0Yt8cWUu
         q+2bQcNCzhsKk1fGHAbA9qorFXpn1cbhKe6DO9Ek073Vstb4mkhbCG91K1i0VSildSfM
         wF7StzULBs8oR1f1HvAzw4KRa1whU4YEW76uKREP80KzeEYN5dZ8cVFZapDYvT7kCwA3
         /C1cv507qYdReTvio+wjK6jVR5SX6/aG5SwQNMnmyRNLlXWxa6QLcLOgaMtN5Zd+KdZI
         DtFCp6haA7W/TnBDJ7N7nywXK6zOp0eBu358jNJVdHS3euXZWU4pLvxjRGHMZIhij4JT
         QEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w+emXKINMFidjYfaKe99oJpqLvInCaqrOikEInQ539M=;
        fh=PQ9c0cqNZEx8z6DXNbb0bdcSA3mtTzKxO1NP01n5Va0=;
        b=gykFlOAAsrO1dDNpU28+ySaMZRTyYPAO9Yil32tBmA6S1ADBLaqITQ1/rFFxbBVeDC
         JTa5NK13/3l16O6kPEtOOEjnKq1+pjQd7YfKzk4oko2fbB9DLTyT/4lk4iiG5t8MCYS6
         knha6RqISF9IYdcslXCayi7XCc3Zc/CZdkwkziIypagfnbrkUCc7Dc5gO5UNLv8zfiyj
         XUno7xi1tU4NsdYkp584O/HYhSiyD5ipcv/7KjavoBTinctzi6gHiBt0GmrYu+ladxwv
         EQMHz/gFNotNABnh5v96EuvUjmfgIXRiGc7BzDdU+sl3VuO1h+u0LGo6V+3ewKsvr7SH
         cp5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775672458; x=1776277258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+emXKINMFidjYfaKe99oJpqLvInCaqrOikEInQ539M=;
        b=T8kfKoqkPgchFhnpaNTXF217v8VwEz5S9E1rpuhDZBFznyauEq2jy3sCT1Dyf8IFyb
         gOv8Pn+q8CIN+7bqCQ/3gUeznJKw+5nSx38ml5+lIJbBCvFsmYz1zBHlW8WJv4C1R74Q
         PR/OAwpZ7sGvJTHPrrC8JcCSh0/YB1/VfNaCrp9IN1RfeDwa3/3f2iluvkB65P9/Lj5P
         ZU5WFX9zskqN9lNaHU3aU2RoaeZTyNdgLaKUJ43w5vZS4dIN+4SYy8oH/0LePg4pQmsC
         RQd7VIgviIgQSaU/15cyzncBQpr8MggP2XMlqDfR34P+qt1uu1qZ13HqpK8v8R/Qy0cp
         Un1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775672458; x=1776277258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+emXKINMFidjYfaKe99oJpqLvInCaqrOikEInQ539M=;
        b=iYFc7WtOkm+qyDpqXGJY//oBLlwSUJ0ZEUqvTZcCrUQ9C5RWxlCo3LsBtYFKHSctqM
         pjItRVE9pS2UvAur8Pw53YUo4SiFemAO7/fqQ6QIp9xYcy7Zpwilz+BDsIsf5kQOQFI3
         FJwqd5Y7c4LXCM0e4fz5sNvC5tCU76MyJgnz4PQsWwRMZ8M43kVD1sR1h99pB7Lqyvah
         xLrFkAb930OVtM34F+ozNsKHvPTbvq5U9PLM2Cu2Y7RnuNT6gkljMpMvuBugXUwGC4XA
         fpYNXQG5HWafR356fULqDwdIp7n23Ktn4iZAlkICEcxBGkrJD0j8FU2n+Duhf8gZrCqA
         r/WA==
X-Gm-Message-State: AOJu0Yxaei/Mqt4eGcqOKN9OBOaI6YvWIHST/gqJ9VU/tn8g+jU/sL0t
	EnjSEN5T0ujyX0LJrK9wbxi+PBIHxJ7N52x/+/0r5aZUW5G88Ky3pJ8AkTnKHOqyl1Cr3Uq8WIn
	9IXf/fdtLTY3eQWoatsJ5lcGPIyh1lsJWYg==
X-Gm-Gg: AeBDieuyctRQpMBAHwKPUJKPsz/8OpP4az4AhnP7c1EUPQzE/12TqmA0VdA6fKarTm0
	1AqZ5rhZjiNb3sc5Sv5/jGON0pn5Iiy7xj2AqMAn4Apa5RmZ63u6xA08tM3rIIaBuj1Swk0plHs
	Vqdfet1sS66TEfezxVtsSrZ/BOI0jqYGqNwyVRl3uKHkA9UqbAsvwC13vOqqsFwm8ZTjyrE5kNs
	pD0pYw0emqgpQ6sWDD5ZV9kGXQQ5SuYGqFZvd0pmQTZB9aLcM5sXGzgSTDnozefM/tWxIPiOpHd
	dtGVKZh1SsTq/lqUBQ==
X-Received: by 2002:a17:903:17cb:b0:2b2:497e:3f6d with SMTP id
 d9443c01a7336-2b2817d960bmr240241235ad.8.1775672458288; Wed, 08 Apr 2026
 11:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408165106.15820-1-stephen.smalley.work@gmail.com> <CAHC9VhTz7cMmK-iHFk53YiB0cstyz7Cq_kKKc=C+7mx7evFMzA@mail.gmail.com>
In-Reply-To: <CAHC9VhTz7cMmK-iHFk53YiB0cstyz7Cq_kKKc=C+7mx7evFMzA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 8 Apr 2026 14:20:46 -0400
X-Gm-Features: AQROBzD5V-bIsjMXBUUgdsxKlqw2rh3Yd6yaD9ORW_k5Zu5-ZV4K9-_V7EeQ_6s
Message-ID: <CAEjxPJ6s74LeJBMP38RWJUqaxgSO7gDzEeNDiDU6NtkkLrVzfg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix avdcache auditing
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 1:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> I obviously trust what you've written above, and I'm only quickly
> looking at this, but off the top of my head I would have expected the
> policy sequence number check to catch a change in the dontaudit rules.
> Perhaps the sequence number check is actually different than I
> remember, or I simply was thinking about wrong in the first place ...
> need to look at that again.

The last clause was probably confusing - dontaudit rules are a red
herring; I was just noting that this bug silences audit messages
_regardless_ of whether they are dontaudit'd. It's not that we don't
detect a change in dontaudit rules; it is that we are using a
previously cached "audited" result from avc_audit_required() that was
originally computed on one permission check (e.g. search) for a later,
different permission check (e.g. read or write). Since
avc_audit_required() only returns the subset of the "requested"
permissions that should be audited and uses different logic depending
on whether permission is denied or allowed, we can't cache and reuse
this "audited" result on later permission checks.

> Out of curiosity, have you re-run Linus' kernel build perf test with
> this patch?  We obviously need to fix this problem, it's a correctness
> issue, but I'm curious about the perf impact of the change.

I have not but this doesn't introduce any extra function calls to the fast =
path.

> I also wonder if there is a cleaner way to do the above?  Maybe not, I
> need to look at the exact code we have in-tree, but it seems like we
> have some not-exactly-the-same-but-very-similar calculations in both
> the hit and miss cases.

I would have reused avc_audit_required() in both code paths but that
would require saving a complete avd in the task avdcache or changing
avc_audit_required() to split out the fields as separate arguments.
Certainly doable but not the minimal fix.
