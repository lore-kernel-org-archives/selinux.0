Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7D22126C
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745582818; cv=none; b=Z3iAc5stg14QsLIFP87aW0mMnRS+ELAwzex86u2zUraTM/kk/cFPjCOJHwvjROChrTv7CzbjsJjtMT0WuY1yBCD+AeRACaFpgdl608p2BDFAxs6upJFKPnQcYrNQfMNFEaW6iwZKbA9oxYOcmLdpV5mCVI9jRQdXZtasnrJ/Uyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745582818; c=relaxed/simple;
	bh=LHmlYFmNkLZcD3z9pV5dhNtDDVNTcAW/Me2O5/1REmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqurDfY+QNkmZyrimu/FCbPwhMflAYBWDrF1AgVL4wD8QZNfxz+IAVA9TBedHEPhshQicjrA+27IOcYt9suoAm8cqJFqvQ1d0DIdeLFAbxS0JYUascNjTESZKRTcyaqaB6jp5KVE18FeuAAzetnuDpFAEi0hm6fSBZ8bk8+HTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdZfxNQr; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdZfxNQr"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3012a0c8496so1682378a91.2
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745582817; x=1746187617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGUzVIPU8sV3d6F+eqEg2iFm0gjEelDN5sKoe0HBGdk=;
        b=BdZfxNQrdN5uCwENY39NRCHxKW4T/zzVkGkWXSvist/7KGzuXKweKbJ8IGyl9uoXw+
         Fu3lczI7n938XGVx45c2NBKNLLHRBXJQ8R66Mp6yDap0nyLGb6gn0JBu6JGg5yMEGwPu
         p/R4hdNnhQgg5Z/wW5EgIAWb5LGZTxlKT4EmZ+ghEa1TcB1WoKQlaPGj2BhUxScPU+xy
         doAPko+tSMVcmyATG8JgfcRaUuKnJPubbulZRSziT3iZ2v3jHB5Cfy0/QNevMHg91QdU
         C+xwwokNYnUujJO9PqCFCGo7BWxfCjBA4Gp0wieYMy52nb15eLTXLTizCCxocYzLYM4y
         vnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745582817; x=1746187617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGUzVIPU8sV3d6F+eqEg2iFm0gjEelDN5sKoe0HBGdk=;
        b=aRaTBBm7ynql8ZmRlYoen/zwarT10Fe+rQMzBkrSCsc50Fd2BkCjNKsY2QE/9MLqOu
         hvD4rs+A7Jw2vmP+BHN8J3VEedJRBXiRbP5UkTZ9vZihFvRW/UNhPAVAXiDsmL9mTo60
         3QNkbgr5pv3s6Mxl+B96arjH3JuJVstmV05TEAxqP79m4/tvObcnEuJSjeEamjBBcmMY
         7c3HArRoANmGhipOIAgERIrZTIgg0Lo9a9I+G8tkhGE2oByfg9tEdpGbA9FyDo9bcISN
         6N/zW6Fc5jhz75dl0NJsHrr1cLjYOEDfD55dQZIp1b9UqC3gxJ9uYDwDsc+FTYsy9WD8
         PJlA==
X-Gm-Message-State: AOJu0YxtTSUCOQhZX8f7EXZhp9215eUscl/UcZVNfRWbrqLS1JDkKNcX
	BGfTTRRhmdrZgNyd1JSsOXPSLOoQVTclFll8fgbJWGWKi4RQk9MuIcIuFhneISXGw3/UTind0rU
	SkjXmCwkpUkPhoLbpI3bKREiAgZ3eeYiB
X-Gm-Gg: ASbGnctFBPYSBYCV7j4pVLxCVNEKkYt/mtHx/c39k+g0hnRprb3dWpGahac+VrT6p6+
	cMocT1FJwVjjP8hhkPAEiP1AfJI2kSqUpzy+pY4eN8DBcI1Vq0xahkRvidzrGVQDJlxm2PRuJW7
	BceoOa0GtvQgmFiDap5V6jmAWeWb1Rpy7s
X-Google-Smtp-Source: AGHT+IFuTskApuh+WKw00C7V4ZzgNzl3Z5H2D8NWTeNtvkIzj+2VS1PmhErRTActxzk5qcD5WGU7fJAI6TY24ZKl8zI=
X-Received: by 2002:a17:90b:1b48:b0:308:539d:7577 with SMTP id
 98e67ed59e1d1-309f7c70113mr4538220a91.0.1745582816529; Fri, 25 Apr 2025
 05:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424200310.2409-2-stephen.smalley.work@gmail.com>
 <CAHC9VhRk-0jFcap7xeELQBykx4EOa35EdkyRB+V86nGXnXf-qA@mail.gmail.com> <CAHC9VhQvCo--R4zGc7UOjfkW+DiyHYxA+Qmu=rMmX4C07uyNGw@mail.gmail.com>
In-Reply-To: <CAHC9VhQvCo--R4zGc7UOjfkW+DiyHYxA+Qmu=rMmX4C07uyNGw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 25 Apr 2025 08:06:44 -0400
X-Gm-Features: ATxdqUHrv1vKi5Lcq2bDWOC30aoMg9vQ-UGrPS-WzVBNDSfdlGvNUTYVaZQKHtk
Message-ID: <CAEjxPJ7wvgAncLPYRSmnkzYcTo2S65xV_WBdu6JiHDX+pvgnpw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: introduce unconfined as a first class concept
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 4:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Apr 24, 2025 at 4:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > ... Admittedly, that likely wouldn't present
> > quite as many possibilities for future kernel optimizations as the
> > _UNCONFINED flag.
>
> Now that I'm thinking a bit more about it, maybe it would allow for
> the same types of optimizations?  One could simply treat
> AVD_FLAGS_PERMISSIVE|AVD_FLAGS_DONTAUDIT the same as we would an
> _UNCONFINED flag ... I think.

I'm not sure that's quite correct. dontaudit suppresses auditing of
permission denials, but otherwise still requires computing the full
allowed+auditallow vectors during security_compute_av() and wouldn't
normally be checked until avc_audit_required() in the AVC, long after
we've already paid the cost of the avc_lookup() and/or
security_compute_av(). If we made it a new "neveraudit" or similar
construct that also disables auditallow, then we could possibly treat
the combination of permissive|neveraudit as the same as unconfined
types in this patch, although it seems less intuitive for users and
means we have to check two different ebitmaps in
security_compute_av(), or precompute an unconfined ebitmap at policy
load time when a type is set in both ebitmaps. Is there an actual use
case for such a neveraudit type _without_ also making it permissive?
If not, then it's just wasted effort.
