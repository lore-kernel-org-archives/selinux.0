Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD90412C0D
	for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284984; cv=pass; b=HcSeF16V7rDt+UBckACM0haWQcUN2KHAgFyjIXFCItDBw8e6+YQd42JSNe3fEHl6GW/TDM/gSCdd5uVkuN70JIC77+PnWO/ybwSlpCIEuY3Ta4tzW4DDkxQLal4TBFhOiVwucJUcvWwWRT1JszLFhhgXZsG9yfz92tIZ73vpyfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284984; c=relaxed/simple;
	bh=RCRr5mgxoA/eG7YtxTgp+na3XhxSCTQQm6d68wfZoH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxlPdWwhGA94smahq4a9bGmGmnDWvvf5iuemD5Z2W/+iO9eUy4j29ROZ6OjGzS64afqYgi575gXUHZg4yn3L3NY+H0D+VLjovkt6/Qu/kHFcqcVDC5e2dFsEogsGqGIY2ixTiqA3hh8nUhXPlQivM8S0lz+B2HfmYD1/KiaT5Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XiodgE3S; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XiodgE3S"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8748f34b1f2so169466b3a.0
        for <selinux@vger.kernel.org>; Thu, 24 Sep 2026 14:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790284982; cv=none;
        d=google.com; s=arc-20260327;
        b=V5I5WR+5r8285+epEbVsBKLrFJpWwkuf7HrDxwiFkyC1A19sQDL4/Kjp0jck9NNJJo
         pZv68MwJ8t6K+8UmHzhmLskz6KtXtUQoWMp2iBbO1K+usOmHl5KatsalH3fJqmqDKLa5
         +NVYHMJmCUVbqplc+0YXveE79YRCHo7CXBOGSegOsBEG58BCXBIwAwRNujiRlkWO7E2A
         XDdOD1tjmHLwEkvOL5IyiJdiaVwlLJ6bc6PHVgbzNeFolrF7XiKmtrM/ObOb436qwvQk
         ge0jnISlRMLdJq92aZke+eMmJytirgTZuY55X1OLT9KYoxs8RMsiWzW+2uz1LiMpUmPp
         HwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OvaqbV68mu/RVuN00ofm1HCnnXMIjUc1cUavvHr0lwQ=;
        fh=ysp4wzCgbzGxf6KU3KKH8huB3L4oAkM21jd/o5wju08=;
        b=G4WBSrGXwvrzNQ8yb8fjTJQpd2wYFCsxymXjh69K4RPFwwBCbDCYB5bobnLpRFBnQF
         jADtAfr2qUeTNEkq/vF857Wtca07CbhVKDQ+5CCu4T9CgBzl8eqTjyQ63Et75ePvn+Y7
         /jSLPsWklaXWZDCMe35QjtCXr7IlmO+xvs0nHa8Q8fg0NFgiXFJQIXUQuc7Vcivko97U
         xwD8rLfnqurvfETJI9dHh0iN0OrpSCB359VCP+ArK26jHyl7uv3FAAXVBd2lbfhTNCHp
         LV4Ba11lCRZV11kKmDWHfCs5DgqdkTNsUO/yY515ppk20/nl5F+JGyF5NYy0IqJIr/CA
         i6hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790284982; x=1790889782; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OvaqbV68mu/RVuN00ofm1HCnnXMIjUc1cUavvHr0lwQ=;
        b=XiodgE3SvbeVZD6Z5fV9fBwmYxGZlu5UpUYLUyUQJEiyt4iAgk68W548jgiH5Ni/MR
         iCFZ1hJBy24eua8VJfhopaQn5AGADGdbJdRMDt0+oxCjSqLbmN+cq4RXVxIg22PtvEEu
         nni5y6cxv0FhKZL/a17jN2sskYQyUBMPuHKWzy4vnS/mt3vOHOJJi7sFAM0OWUHh0b7k
         itcdqZSFKqmrrmilpZV0xypGNmF+ay1dM4g0n1WzM1xV264XIn5K1/oKY5OlrEksuF2i
         XpvD+Lc0lfFGaju1W5AWy1NTTtt8zkNorRWXbT3zQb0gfLACNiebQfsIo88vRbHGm8Jd
         /mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284982; x=1790889782;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OvaqbV68mu/RVuN00ofm1HCnnXMIjUc1cUavvHr0lwQ=;
        b=Zr94GiokPdL2bVfus9mGpgAIlCFpH26C3l7Y3alCZ17Q5WEPCreCJ6LuCX2lutNtfP
         4vBAkF52udTVsT8cGTEqQADOJA0iGxEYauTvdLF32acDCNkkIkAQyupOY9A03pkrUdXd
         XCBRYIYAPFXRD3yBmjVMZL1agaK2yOfY849qZw6ooDsGJmu0Uy95KzL5s3kGHJTO0EN3
         fAq3JwqFnPd1OsbLmd/I9pWoN+z0JgzcCJJ0PI+q9l10+zNPgzdABobTb4eXEa4Skg11
         J7BLZPSTWqB1Y4be+43r+WEchnFpkSPWQNjs1PVKi5iig0fgtawHCChVzswoy8t0JRt4
         eqrw==
X-Forwarded-Encrypted: i=1; AKwUvByA6OUGeYSrLDGSRAyeisRdAx4Ji0P8/suUMKn7DDlpB3S7FyqezznnAxdMh+TCvaqSgjQVoGDz@vger.kernel.org
X-Gm-Message-State: AFuF++kJ68XMwrYZ2yzOfynapgK4uhbIv+VQ712UtUJMGd7vS8ITxCzK
	w/W4UqRF31sXKbF8mQgXXSXPrwo79jaoXxbiescumZV8OcqlSQzMP9USs397CgaAWvXlxFpMwKn
	IB2z2i47uXug9Rxu2ahgvFYicYsW4GeA+G7LbUjN0
X-Gm-Gg: AYBFou1bWCPGZlNsC489UHIG+HkwrfU6YIfJ/WwWHt5my6S2V+SQhc2ZukqMKJw0ibM
	Sba7copJ9xtRLwkEoszPaW1j2D2bsDwlolI4D7QmiaRD04f9lW6GUT7DB0zF4HXS0G1E7UniLrA
	T2Lri4S4GueFE5sft8epHOsflXP8+Xkqqxv5BXuN5nwlwZPwbznqrs81AfVFNbY8ZmZfq/1pnU6
	ZTi3ktsEbAAt2ZVBd/tIDHL22RLMenfRIUMvBCmDbzNXhYxpXbH63vsXavNklVkAnJixZAf/G4J
	a9ZciqZnFsojpcgSHgXB58D466HfUDmVVIsAvVN9zDANbHlgY4rk38PNG5NuIK7mtJ5wsdQEH3P
	XyiZZD6nTTsc=
X-Received: by 2002:a05:6a21:4ea6:b0:3dd:a197:cf34 with SMTP id
 adf61e73a8af0-3de0e96cfdcmr3766980637.88.1790284981998; Thu, 24 Sep 2026
 14:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903113538.72942-1-cgoettsche@seltendoof.de>
 <20260903113538.72942-2-cgoettsche@seltendoof.de> <CAEjxPJ4WX8SszS_SXgBP52csfokZLNFVkWmE3rDBJuDk5etU-A@mail.gmail.com>
In-Reply-To: <CAEjxPJ4WX8SszS_SXgBP52csfokZLNFVkWmE3rDBJuDk5etU-A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Sep 2026 17:22:50 -0400
X-Gm-Features: AclHuK8oe7R7XDa7w1BR83Y4pWhApV3w5BGLdp2ZAHv0zRoYPWd7A8FBsEfsx6A
Message-ID: <CAHC9VhR-sJRTLY5hKWbTQ5vEO8yWjLiVhrmRXPJJwN4_hy4gLA@mail.gmail.com>
Subject: Re: [PATCH 3/5] selinux: bounds-check role and user membership
 bitmaps at load
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 9:50=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Sep 3, 2026 at 7:36=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > role->dominates, role->types and user->roles are read as ebitmaps but
> > their set bits are never checked against the role and type symbol table=
s.
> > An out-of-range bit is used to index those tables later; in particular
> > role_bounds_sanity_check() passes such a bit straight to sym_name(),
> > reading p->sym_val_to_name[] out of bounds on a crafted bounded role.
> >
> > Validate the three bitmaps in policydb_index() once every symbol table =
is
> > populated (roles are read before types, so this cannot be done in
> > role_read()).
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The check is against nprim rather than defined so an unclaimed value
> under nprim can still hit sym_name() =3D=3D NULL and pr_err() prints
> "(null)". Not blocking.

While this is a good patch to have, I don't think it is an immediate
need, we might as well fix the above problem.  Christian, are you okay
fixing this up?

> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

--=20
paul-moore.com
