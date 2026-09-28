Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47A384CE5
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619671; cv=pass; b=dDgFsDuEvIKNYzjwiPJ09zIu9bUy7sLDky8lDNwbX0HOp/tFnBrvragbYdsJA/818gyDQmZFJg0zULskXTKE8zYvAVaHjYhtitSivzEja0h4A0VsifMW1iVl3tWTiI74OvXTE5YsnvuLo6d1wEXrjiWadzROvPw/UOYspmSXRvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619671; c=relaxed/simple;
	bh=a+KhPY522kXSb5a8MRC4XWYK6cLoKSM7YgIt/ixbJ6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiesIdnefeBkjFUd8IF6nxMYGX7qT86KG78dwtl9mSe+mywF02qIdeYm7alus7Gy74cZa6HUY2DNCnQ12H7Fn1WbtTeeOmXLi/DjGFvPeaIt+xav7kgELhXm90ysbpDxbyQy+oU90Cs8KTtUZkVkmlkxt8CF7yqjZM243cUWHdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISr7sndj; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISr7sndj"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895353e9051so30301607b3.0
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 11:21:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790619669; cv=none;
        d=google.com; s=arc-20260327;
        b=IZl9gkcg9808JvukeFZ9vfqAn2+pRKtpjOGJBA9yU+/ly23rPeaVXsAmhM8P6QKYAo
         PMCnu+hc0P2olAs+1VHYEUxEZOwD0MBJLz92n8TDNZ9Uy1GxTg90KRV8ZnyHkbclYOl/
         yXrcAa22zBbZ8S5Z/GV0xRDFuPDS9P2v3dnTRuArkHMkD5Vc253bqlAoKeUFk71mm6ZI
         pNYhqty0So5pYjhHtcYQBKfXOg3aMFCGwBG1efxnLfiSJjM7rIqB2Lc2A3ad4Q8CbUIn
         3RLO0WzFgl6LuwafPn6WxfAsgpv7r18doQ+xlheOVx86U/5ySQLWBRG+S77otO3YCtiM
         4gZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a+KhPY522kXSb5a8MRC4XWYK6cLoKSM7YgIt/ixbJ6A=;
        fh=ynz/8+FwD6qg4pGsVrM1o3ZMcJz6Z9Ld9eMncvonVNU=;
        b=jS4Wgpp3xRxh0NaGvTlVsDQMMCtrjOpUu4Eb2i3iMQbOOHQF6Yw6AN+OXEUcEpFfZe
         QoFb/TMoliNOuMPM0psDoAsIsz79LnyPqLZaHrjDV+PuU9zb1QNHy9w/9/1+lFl5BX+F
         U63gF8K+SCaZ7GJ/nC9rFXN1bjEtF3ZQ7Kxtx/u4DRxnkbfSrKQrq24Fuqk/4WlRjnwu
         7IqvRSUsilmKjYnSjuxFr8frAj/0gQLq9SVwRAyuHkNDqg5E8aX4/vCLHYlySo+AbatN
         nkGS1eUkW8fV+Z2UfFJsuFFhnqPw2xdpv5E5lytVZMmeJdOIIoe5z6AzyePhlOE/79iu
         38fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619669; x=1791224469; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a+KhPY522kXSb5a8MRC4XWYK6cLoKSM7YgIt/ixbJ6A=;
        b=ISr7sndjyFoqYwFJe68KrPm1AnWOkFl622QWvL6J2QS+/oulutQmvf3rdsVfd7RAUd
         f7iaY9klREyXoL+O95CkOVS9QqfD33gdLDOhC04Eu844e9EYX9uleK1qWTVLylyHbI5P
         9rNS7sk2VseFgje5oBOoixC4VFwgizAqMaqv97ANm53kNmNWpgHGpKYvDgYneZm+ppN6
         u7/2OBtEp0uptbojDmuVWeRmIkx+krX2AjSX2lLjmD40p95bGTeTkvEwMRW+gMpvAo9K
         lcvn16VLZsDbKJ4ayJzfM71q/5Ky6zH98kAy+dixptdMeoePR9UnWBYgUu2oni6DBM80
         wnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619669; x=1791224469;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a+KhPY522kXSb5a8MRC4XWYK6cLoKSM7YgIt/ixbJ6A=;
        b=M/3S0UlYb3Zgba4981c32y03FOtq7fppGe3fggeeJnkQaHctY5b2zYRTp4o2qqVIZ1
         Rd8HXS+lmLRU88xDTAKUx5WRW38bBQpPdpkQrshRwJN4qfI8msWk/cD69oGrcSJuLJKO
         kjtQq3E+Ft1C/kuMba64G/ZHma/WFBA16vS2p3BIIvRp/Q7oFyQhbOtkdnjJUQ8qCKw6
         9dFKbXLTxeU/tsbwM6EYv3gNMzyQENltQAwauaKaj8QC4rXOytWtN5zX/eAqyYL7LZpP
         nP2EO/QPOQopTFTwdavpvR4sewpFX4fjpsdMq8/hoi/tC0Gvnu9rtyQAU9zboMtS/xA9
         jtDg==
X-Gm-Message-State: AFq9FYIFIgDjq99irHpjJK8ymq5aNO+4EdIQjiSGrU+UMUCFF66aYyMq
	kPlTWrDL7EyBk8VWMkheA3fgQhQrwLervE0Xr6bw+dUaz2BCYGEYNnvTlxQ5OtQLVQtWAeeQZYR
	Z6pCMfxCp1QZmrtMzS3wzsNWNQO/my3I=
X-Gm-Gg: AYBFou3YdIQ3Gr33hOC//dLvlXpjUx8iyUdERqQaaNjBQ3P6VO6rLAX8rnqO0GwvKET
	deOzocmYdp9kSheGq4O/yYnID2suiEyUFX7GVGQ8AdajGSZJfgX+qpik2Hk16L8TA3idPVDQPnR
	mQKcFF+8ViJ3SDIYsqKvwuhBB5Ldb+Rd+E3j9A9g+uQrw48oBx/pPVAivwt80XnXK4dpR3lI011
	wexYFIMJmBY8O1HMDmXMWiIMQzUugeRuoGXNFzClDVBNm/uZaKECYafnfO1Zowtcxj5Ar31hlba
	lbMphcigE+Vf2GrOfrmdpdORWZJxaL1a1+81eKsfszKBT7lbqtxn11s=
X-Received: by 2002:a05:690c:f13:b0:8a8:c71e:d83c with SMTP id
 00721157ae682-8a8c71eefcfmr38075237b3.14.1790619669147; Mon, 28 Sep 2026
 11:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928165253.2388012-1-cgoettsche@seltendoof.de>
 <20260928165253.2388012-3-cgoettsche@seltendoof.de> <CAEjxPJ7HzmQz5tfwCgru+qWNLpC4mHMKzQsOXKhuGJFUCgorRw@mail.gmail.com>
 <CAEjxPJ6aWQYLrVdxLcEO6SNw1DbR6LQ3URXszzMsjoR715gxdg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6aWQYLrVdxLcEO6SNw1DbR6LQ3URXszzMsjoR715gxdg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 28 Sep 2026 14:20:58 -0400
X-Gm-Features: AclHuK8w0eUYozwPsedRJIOChCTkNxbPomtpzmHmY332LswI9En6-bOFkcUz1Z0
Message-ID: <CAEjxPJ4m-gVVHnydYS34DiaMWb-BJsnUV7WEXqaEPp5h-Kac6w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: bounds-check role and user membership
 bitmaps at load
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnacek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 28, 2026 at 1:49=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Sep 28, 2026 at 12:53=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > role->dominates, role->types and user->roles are read as ebitmaps but
> > > their set bits are never checked against the role and type symbol
> > > tables. A bit naming an undefined value is silently accepted, and an
> > > out-of-range one is used to index those tables later; in particular
> > > role_bounds_sanity_check() passes such a bit straight to sym_name(),
> > > reading p->sym_val_to_name[] out of bounds on a crafted bounded role.
> > >
> > > Validate the three bitmaps in policydb_index() once every symbol tabl=
e
> > > is populated (roles are read before types, so this cannot be done in
> > > role_read()).
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> I don't appear to have received patches 2/3 or 3/3 as of yet although
> I did get sashiko responses to both.
> Not sure why. Regardless, you or Paul can feel free to add my Acked-by
> to the ones I see on patchwork and lore.

I do notice that the From: address differs on these emails from your
usual, not sure if that is causing them to go to the bitbucket in the
sky for me. Maybe you should directly cc me on any you want me to
review to be safe - still waiting for the RFC series to show up
likewise for me.
