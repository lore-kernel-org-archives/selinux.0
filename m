Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED14277CAB
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520411; cv=none; b=KXQUn48sLDpDB+CsDvMVKE38bzvZWBS9hoPrIdw3EZl71plmlD6kcbERhFcM3/ybSp+sSKUIZcU/9V/y2pNdiRCkfzhZ0VHYysQn7bmIzwkzSqSWO/CreysSOdwqSiW4lg02lXr9qLZCNLSpQBNtUgmvJZT0PXBaXWdT41z0DcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520411; c=relaxed/simple;
	bh=/HnMQQvnr87rDfX4RlarcsD9BYkZB7GQwP19ZbRd50I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cr61K6/PHkLdzPP2jIZOzd4u2kQT5bKdyEKlV1IZdeVcjtuHr+FDXcq9Miv4wu/LcxgAIhDviKsX2RPIDqDgoQXhC/c6FRP64rtJ5o1DVVfwKkyKJv40JVMw15sAGmYnrDjokEDWUv4/dXYAbaC/vMl4ghvyh7kQvvH6xLUR4sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDipaF5k; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDipaF5k"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-327f87275d4so7030913a91.1
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757520409; x=1758125209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhaePsxzP3F+qKVZNp1O8c3YMUntoY+HBrUDbFzbWcY=;
        b=mDipaF5kgz+7E40ENXLk35l6Yy3CG5y43xRyofE4rV6ff7ilEcEo7FDhNX3axvV7Su
         irnRpLZzIuhRa26y4axtSJzHR7a3BY2U8QKYFjTU9b1k9nQ5H1aqCsylcGk1dVr5Oz3x
         5ZAyk1u2lcKu70v+i097C7NOQxDgPe6ER9xObNqkpjM3AOXv61mgWP7DJUHysabNrgM6
         ZM6ySyyN366tW4LrdF0xUubOYQzm5BHW3R17MsMMSCuHaYQZ+WGBFIVcbzE4eAAplIaY
         9DlGJon3/UHEwo3cspXP6cKSyHyHl3lDLZgyxbu8TeeVS1Hcw+LeoZhKBzM2vQlid98q
         m1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520409; x=1758125209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhaePsxzP3F+qKVZNp1O8c3YMUntoY+HBrUDbFzbWcY=;
        b=Eyj+kdfzjIebS9J/OMzI+4YinXVN8N54r7T4WCJ0Szm42Hbwv+OeoLG4CQ81Q8eqa1
         h2LTAOTLOZUgkJrgh51bwu/0NATMo0tIj6QvPmd5wG0PM5iKioEpU1WLPwtNr8fEPoSA
         +OEhU19G6OURD4Qx9EiO8/9HgKHnkv5XXrKU8giJRQYnnxuZk40sPwp/j1IBeTrmjuBm
         4q7uhZ7sTdbM7NhhSiZnQs8H35jH7tEF2mqVtShvKBfXO61ErGMmlaIEfoTJsLVBUGOd
         T6VFxLBU5GL3UTiCMdcnUvR5/4PTmwkwJ49os57wYpwM1Gl2r/fpIRks8OnJzoUo8jQk
         8wDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFdXHIU68+W/RPVGSElGOv6Bjy/+tsp3E3VB83iQTCaDJZOlyLmxo7hK21l6verQeuhYhGr4UE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc049k4Aq+Xsn8c5rKc3trOZideK/LvsmWCauBZ/xna3VDSUH8
	yQ/W/pIHgc7bZhbqEqg4Vgeb02KzyS+abtc+GmmH3t7vLsnusQ7I0k08PpIRJrn5x11JNvqQoC1
	6gPLi7lbq5cnWFgHxOalZo38eS59Gtjkpdg==
X-Gm-Gg: ASbGncvaRWIZXcKb3PCdOQQwRjBx+bNATe7O05PkvRX+X8/yWlMLsB89RCbmsuGPbQl
	tKuYZklV1jaLikP02ruAf19KzlJBvCOqNyLUKI9iX7kUz7BWwu8WK2VUtYn2azx+3hZbFftwLRO
	obHdoHLecVyGiFWppOyU0/N5sSRZ5s1ctpf3Q/O8gNSxp/qblT/QJ4NV3mxe9dWANaxxujdgDEo
	yKDpPI=
X-Google-Smtp-Source: AGHT+IH/wY2yOgn/v1x9C/y2ygN2G52hcDEflsP6wNTD4Il2SFk7iwQ9Yr3tvojZ2qlRSXHDX3vQcTfCk+pOVyGaDyQ=
X-Received: by 2002:a17:90b:4f:b0:32d:3713:5a4f with SMTP id
 98e67ed59e1d1-32d43ef6e16mr22367908a91.3.1757520409330; Wed, 10 Sep 2025
 09:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
 <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com> <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 12:06:37 -0400
X-Gm-Features: Ac12FXzuDsV2NrR2fqMbjxR4mGl1lnzKPnhq_X6mQH7eBOfHygx7QzGSAAvuEOU
Message-ID: <CAEjxPJ72F9PsdWo_XBL5XDABYwZFJh5-TSt1bp3toLwgoLchkQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:03=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 10, 2025 at 11:57=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Wed, Sep 10, 2025 at 10:05=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > >
> > > > A prior commit, see the 'Fixes:' tag below, added support for a new
> > > > object class, memfd_file.  As part of that change, support for the
> > > > new object class was added to selinux_bprm_creds_for_exec() to
> > > > facilitate execution of memfd_file objects using fexecvc(2), or
> > > > similar.  This patch adjusts some of the sanity checking added in t=
hat
> > > > commit to avoid a "silent denial" in the case of a kernel bug as we=
ll
> > > > as return -EACCES instead of -EPERM so that we can more easily
> > > > distinguish between a permission denial and a fault in the code.
> > >
> > > Technically, this doesn't make it easier to distinguish because we
> > > usually return -EACCES from avc_has_perm() and friends, but return
> > > -EPERM for capability denials and in certain other cases (not always
> > > clear why, arguably a bug unless we were just replicating the error
> > > number for some existing check that also returned -EPERM).
> >
> > It's awfully fuzzy from my perspective.
> >
> > > My
> > > suggestion to use -EACCES was because that is more consistent with ho=
w
> > > we report denials outside of capability checks.
> > > To actually test this, would need an updated libsepol patch that deal=
s
> > > with the fact that the policy capability number changed on merge, or
> > > re-basing the original patch on top. Otherwise,
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > To be honest, this isn't the sort of discussion I like to see for
> > patches that are merged in the -rc5 time frame, if we're merging stuff
> > at this point in the dev cycle we should be past uncertainty like
> > this.  I'm obviously not going to merge this patch and I'm going to
> > drop Thi=C3=A9baud's patch from selinux/dev too so we can sort this out=
.
>
> Not sure it warrants reverting Thiebaud's patch. I was fine ack'ing
> that as is. I just thought we might want to follow up with something
> to improve the error handling here, which can be done anytime IMHO.

And if we revert his kernel patch, I'll have to likewise revert the
libsepol patch, and the policy capability number might change yet
again before it lands.
