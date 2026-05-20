Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2ED2E5B02
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282333; cv=pass; b=c//JDci1ErAl0BaeY4lu+UonVcLsWzWSjc6N031STs4qZJtYM9/yBM1SWEVMFzVxrVxNT0C9UiETC8Z3kSvV3hsJ4615DySJnsVVjxJb8EzEhGtljbX3S85CImZafULjZt/0VYOMeMa5C8qjs1vwXIXJCsya04F6GGt0JCrbPfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282333; c=relaxed/simple;
	bh=q92XgOjnUIujhZEVcjETw1jInJxm2b+OIk7t3pjWHXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F277GIOIyEoMg2zO6xp+XR4/I8wieteGRHx5ynAqzCunYwWhqYWnCwwq5vr+jkyLcRECqjSxBhVIEh0vC6yL3gWub1/EhFDZtScrM0+U4p6IyYxxedm7Xw4At9xk6sATO6mLmIloxOeCpsJJGchKMAYJOccifhpkEh4cIpt1tC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kV7Mvc5f; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kV7Mvc5f"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36a35e4eefeso166395a91.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 06:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779282332; cv=none;
        d=google.com; s=arc-20240605;
        b=RwshBuMftn3GpoivwOBghzA8edXFzME17gRg7qBcl9t7QcjkKr5AD7/8Nbvclpe937
         h2HJDjzKWxWpesG8ihwSUPjtQcQsWZC2xypyOM8LytajF/bZCJWy4zIIhXtopen61T5J
         tAp9eILdr1IPWFXkcltU7PA4STMd0b/8+Gl69hMbwzp8JRERYZkuIWpE0zR2KQ5uJwGD
         7fz8mkG9hYJud3vXW0R52RoIP1u4dtBq8ElkvMi+BNrllMoWpeE74blzcQ2QlIcOMf+6
         MSdIztZcoRjs6zbWzpNZyclrttJbwzJqVrYewgTVPmzZVZlcdGbNg8IH6xWQP7G/6/4Q
         Czow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+YAsmouvg+aVamRPvZvx+NKlkuz3J9OPSLpX67tQo4A=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=EdMhDTfh2DIJZZLxe5QJkV2XJxYOtDkV4ygRWqC0GtKYma8s5qsxsKYrcB5mRWoy/X
         5bzDEGy2JmGijw/RhynP7s/EiDKKgnEtydf1Do2lgDNiKswKgD+9IgzXJpipXlEOxk7Y
         Xc/TGJzxxVC/tYSJdKf5sYkPCtUA6gW0GUysXqR+tQven9yOARCiJdBdAnHyuCyA+pn0
         1m4nnFfC+3OZNi/aXhV47Nnd5uxQ0SJFldPInU/3zPnMR5nXxWczKJwbqCXeEwBcua3W
         lsa9ZvfkJz7DgGrgPsbobocCpkjITLETG9w8LzkQ5JFuDihE2WNuY6mTM0QyRdb6z2G8
         D+OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779282332; x=1779887132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YAsmouvg+aVamRPvZvx+NKlkuz3J9OPSLpX67tQo4A=;
        b=kV7Mvc5ftBiD5zPCDe0U0RrPKS0/pjdIHthwG3qUxYsMXhV9bBg2zp0yRlEsjf6ncm
         cYcmGyrzdqIuJUfoXnOpF4uUzD+J1oqOf9NwLWCGw0V8wDSdBiwLvGp5v0zdgJokdab8
         FFepIaYSdt/hVSx+L6ZNFPHcx1ZUTWsQvQ8/CP7JfGpuGf1A/3VJnIqiAiMBwDshXrXW
         OTNmT1la7cStGYF2Ag2RReNb0noReTNZGm5fIRTjl08+1PUsKGlzKxXTAikHqrQ+bjaF
         0WyDhW4gyAfPTNdB66J/wXzy8qhJ2x/xIKB8KAObHRc/XHOQDDnZXfKDbgZDPgskWN+Q
         if4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779282332; x=1779887132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+YAsmouvg+aVamRPvZvx+NKlkuz3J9OPSLpX67tQo4A=;
        b=eKT2a4wtsDHlv4nlY1yoQ/Vcf86mRaLtQpfAg0tHV1RyNreSmfHMC4IyfCFR5ripYY
         Crtdw0vfwsQL+bO5DfVDkAX3BSOESgfHu2XAyVGS4p4nibnnubHveOlSskJryuFuIMeS
         n+YDQjUGK3x2lulXP7IwInWkcjHp6uoUltVYw3b21KD3yqGU/YBpXBr5OZwxlGHBDs9M
         4JPCUUK92Ocvf+yfl4kN/e2ehhv0KYYO6ge13syjhr0VV5uNsesdHax50Zwf5KvGn0NW
         XO47Sq9AzRmWoZPOhwKr+Ik+uJshC2HTT/cvxcQ+FQLAQM/nanx4oerkVi+DvXfJ1izt
         QhWg==
X-Gm-Message-State: AOJu0YwUq+jll8EJruunrD8XF0SkiXxgqAcjiHLO/bxAObwwg4ShW7u1
	F8eM+8rq2QxrqTYb1AoPMt1/kD1yrMN2hOlRlOKxdH9HNbtKHYLTCM+zyTEe5o/8IaDa4Nxl68b
	dkEwRTj9VcWhBGKkOnF5jKBy0NAFqUAwfnw==
X-Gm-Gg: Acq92OHFHX/JxoPQA1N3Y12ld2Le+8cwwO4xt/aNKjA0BNbfjEYxNeXyxWOtGEIu2RB
	q1crkKYl6JjWVm3/EgE/06MzsvN5E1Zs2VfQRsw4+/3aVaFIp3mCKdqqEWoZ20x8wFlwzy8nuCI
	dXOj8vsLKWktJvvfmJ/QuZxbjpu2KhJx8cG492+XgKh4kvtafBUL8rkVJp3lMoh2HVrpQnlx4eu
	GZc+1H4kWurnrxUGlNdDtEKPmfPfQ3JwLrXPWDCZWPgve4djJ2Cn5C0NDpxJ2qMsR6Ghd8zCLve
	caKbekI=
X-Received: by 2002:a17:90b:1d83:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-36951889fe9mr20934785a91.1.1779282331776; Wed, 20 May 2026
 06:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519161440.420035-1-cgoettsche@seltendoof.de> <CAEjxPJ4nUFNd90pxw9jxD8yCNKQ-uG2AwPWHgq=V4akcTtiDKA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4nUFNd90pxw9jxD8yCNKQ-uG2AwPWHgq=V4akcTtiDKA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 09:05:20 -0400
X-Gm-Features: AVHnY4KktftTp9kKR-Qi1rQ51D-Sb-69ss6kPsrhjXf_9qY3zujHcrVPHVqbrWU
Message-ID: <CAEjxPJ4h0FLn6WkJV8sMbLUcwDD-AXQQyg5Qvrps455owPaWsw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: avoid heap allocation in partial_match() leak path
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:22=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, May 19, 2026 at 12:16=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > partial_match() hands a stack lookup_result to lookup_common() and
> > discards the return value with a `!!`.  For the non-partial paths
> > that always works -- lookup_check_node() either fills the caller's
> > buffer or returns NULL -- but in partial mode, when the key matches
> > a child stem prefix, lookup_all() falls into its children loop and
> > calls all_node_specs(), which unconditionally malloc()s the
> > returned lookup_result.  With partial_match() ignoring the pointer
> > and find_all=3Dfalse ensuring at most one entry comes back, that
> > single malloc'd entry leaks every time.
> >
> > Fixes: 33930961 ("libselinux: correctly find partial matches")
> > Assisted-by: Claude:claude-4.7-opus
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
