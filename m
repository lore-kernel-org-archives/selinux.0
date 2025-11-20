Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7571434E750
	for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 20:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763672017; cv=none; b=t5btbq01tqrZuZtaN6uyTLutUYuQtBfyvoSCIBQU52Cv1il4P1yQy9cNxotv8EaxQ/rN0z/gRJ4GivKc68g1g6eRx0aO7kKCaaiBfpziYm8QITEi+Y7WvEcN23afmo8PXI+xTZMaW9WclholgyUj/OLmOkmXorJIj1th53ylseE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763672017; c=relaxed/simple;
	bh=eoVZ5/5D8egyQwhvRWQNqrqA24qZOEQN53SNm6oRsZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMsw1gXTLbfcME3+TAq7titVwbiv5ddU2SlQlGeCYbhaGf19iWL+Cj2+WaNUXUTBf6vbhhGU0sbJi7qLv+yFv2WsZAzDrfJfVmobKizVeC3paWeSqXK0GrZm8x16nIPOV/hnpfuPmrCKNKqzjTAN4jTQ9yduftBz7wrLvhLDly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aJE8xqKX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aJE8xqKX"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29586626fbeso15827535ad.0
        for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 12:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763672014; x=1764276814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2H7UalfsO+k0PMoVCTBqAiKnFNhz1vyzzLH8VS3JU4=;
        b=aJE8xqKX6RloKjjKFgfCrXKpYhWEJspDE/jOMnTjnKeK2WZmuwJjAMcksDwABoqGXJ
         0UAL5P4mxVNrYOJgmaqLjMcciK25QGD6AfY8BV2y5XSFXch5yfigfLk6dBDtWxl34Isa
         3ND8LIwYdYLr4xEH4WhL9et1G4KXEVRJf9dZMnGa4V8li9c6f4zX4B3NeSzawi3sDDN0
         jow3xGU0+cn2klae2fd7LqSBOdc7LRVumJIU4T3qf97b7bEP3P2EUszdkxIxsZEpbcYn
         wil2/Wvdss8vVC2PucW1bWp5D61fqBCH21h3SWMrJltxdwa2EB2H+NdPQbKCRFO9gCaC
         UpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763672014; x=1764276814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u2H7UalfsO+k0PMoVCTBqAiKnFNhz1vyzzLH8VS3JU4=;
        b=DhntmH25zgIqcgMAFyn4PyXVf7FIz7G1eg4ubjJT7bFc5jGgoxxqA1nL2RBvqDa67o
         pY7213rItsSJp1E7QbCJS+RqFD4/3W6J/I+a5GY5dKsNYb/lYKz8UXWId7gQNEDXO2HJ
         87fOVjBb8vE/j5xDXhLgvFKm2wKQY0PwYBK+quOHmBewcl5MeYMgfBMbCZe2kxPgjolN
         qgfDfPSbrMdSgG/A7qbsSxZ4Vmm4++NTKtHyJkZ/CpZIDiMRsL0hprDcWYytMjcmd7fq
         scFaC27U9LAhGusVE3p0/aMuq/ykb1/0vB/5jJNXxXcVYygNg1m5g7XE0Q94zC3dC6fK
         tJdg==
X-Gm-Message-State: AOJu0YxzrkEhZ4SmbmbLnidA6oHe22kyiXnTSysNsF8t4/vrIBTZtK03
	LRvRPB63v6ZiOxnEmlk4LKG2pAq3923B7UvK541ZDT6cI1Kpy1dcLWLKLb5g2Bbi0Jn6+ZHZUv7
	89pgv+YIbQqobkA83yNxoKs07OffamGIevztbMJAMOqXetKIQpDM=
X-Gm-Gg: ASbGncuT/UyuwsA7tF1l7M8EEVRCoZTcGRKy75gf9ghz2QtSO8rVk9koMkfHmjAVdQo
	MybpLHnLS0siVA7qTA1sxfZ9tFhlj/s5/t2y1D8q+EeezbrHqogtiRQhwD7F43oIUQHyI2raOq0
	xfwD/pkRHcsgMUYbwia3mO+WZZ9m/0GzUlnR+G6JV3U0SZB7gLo7HccfdYwM0dtftfJYkkSMLyl
	h1GP552odX7eANT5LQhS60Rmjt6EdvCjGKLvbPKy4LUkD1bhZ7+HMetgk8dob+c4pZhHj0=
X-Google-Smtp-Source: AGHT+IFViKg+NKApWke0n5xQlBna51o5GwdYHd1AEhrzYhRSL7pRf1rC7DNWpfE6c/c2CNApaQkn2TBmPSpLfo46Qr8=
X-Received: by 2002:a17:90b:394d:b0:340:ad5e:c9 with SMTP id
 98e67ed59e1d1-34731bedeaemr780007a91.16.1763672014450; Thu, 20 Nov 2025
 12:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119195628.184825-4-paul@paul-moore.com> <20251119195628.184825-6-paul@paul-moore.com>
 <CAEjxPJ4cy3zarsytxGV65+mNh7ikbt_Le_4M-m8YV0QqvgdRWg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4cy3zarsytxGV65+mNh7ikbt_Le_4M-m8YV0QqvgdRWg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Nov 2025 15:53:21 -0500
X-Gm-Features: AWmQ_blSTxunN_nvUo_WGyAh7BqG2Og1nBsAwvdFT-oCey-jbS94st97fIX18oQ
Message-ID: <CAHC9VhRaWn_Rdh=EtiNKsFJu3KKJuVqoNN0BEQg_4wV3yNnTcw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: rename the cred_security_struct variables
 to "crsec"
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 8:57=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Nov 19, 2025 at 2:56=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Along with the renaming from task_security_struct to cred_security_stru=
ct,
> > rename the local variables to "crsec" from "tsec".  This both fits with
> > existing conventions and helps distinguish between task and cred relate=
d
> > variables.
> >
> > No functional changes.
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Just re-affirming my Acked-by since this patch did change.

Yeah, normally that would have been enough of a change to drop the
ACK, but since the change was exactly what you had described when you
provided the ACK I felt it was reasonable to leave it intact.

> I confirmed that building security/selinux/hooks.o before and after
> this change produces the same result (after stripping the object
> file).

Thanks.

> Not sure how the stable maintainers are going to respond to the two
> renaming patches though.

Yeah, we'll have to see.  We need to fix it in Linus' tree regardless,
so the first step is simply getting the patches there.  Unless the
patches apply cleanly (which is somewhat doubtful), the stable folks
will likely drop the patch on the floor and it will be up to someone
to manually port the patch and resubmit it to the stable folks.  First
step is Linus' tree, let's get that done and see how it goes.

--=20
paul-moore.com
