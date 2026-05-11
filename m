Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EC441037
	for <selinux@vger.kernel.org>; Mon, 11 May 2026 17:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520881; cv=pass; b=PAiAZ0lbRQpRkXLuKPBGncuOqjBVy/82/DqSYz89wyAZDV0zO1rMRsLT+UMXXWTVevdpQgASvh7Udp9FXL1TCtIvhIxlYUQb3YBPSmBWHxuYno8uocYDCuT93RxYS+dY5M0cHXaI2P+tfHdIXKB+9x53qBmcAEcCDqJ4VJgvMDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520881; c=relaxed/simple;
	bh=f+h1qH+MV4OXIaSJfoveUxAcdSp1iGmgkRsnQol/sio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eo22CawygCvi9LIgQXBaQBzwMQggdy3a4o3kMzXxOty5aWUyNKvE7c+LeANgejBb/2mReNXHBJPG868+0RBdCFt4g9hXmmSGr/9CRl31dEgw3fI62nDBr/c+t3r/sV9hH0Ph8PW8YlXG4rlybPvMr3YlHQICLVITwHIVAqiaaKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFIW1GOE; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFIW1GOE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba17c8cfacso47400575ad.2
        for <selinux@vger.kernel.org>; Mon, 11 May 2026 10:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778520879; cv=none;
        d=google.com; s=arc-20240605;
        b=Kc1uaA3B1/8RCa9NtTFRZS00otU+tiolo4CPo8jvHRLD4NQzGrZZzcZ/EXrIgp8nhR
         IHZNlQveCRYd7gH0HCX6nPOmqL7P4NVAwZC0MhN0SXGx6fzsd6EF4DULvYWMm0vt3LeP
         gK079cAK0yLiVLJFqbCSI8lmjIFZcpsTabbnGOpCfB55ahAee+aktGeLUQdWPtMOBqcB
         XzJhLEMWf52cnizogHskZVOJt4QpWaJ2a/n+KKyk3apc8HzrF/U1WExsznd4kRGRxsqC
         VnhuU6hz08Hd0olpXW0+ACspy5Xg/ijCpmtO3nl3cAphbb0Yo/0j1hdNVAM29awUcF45
         MzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cS+p8qwM85YES2usQyitNMhM4oF15lCKHM72161PXoQ=;
        fh=5PmA0VN68TeM8KUKgIvMjrYEu0mBYbIu3rwsths/CuA=;
        b=AF++lHv+D32/WZobkQ7n7WHQyLwsadsq3v8EllgUB8fhUT6L8dDHNtt8HGVTb2BBHM
         VEfazTYHK18gRQF054mZYUyc2dZHMiNVWyiKbmxXskfq58/Za5XNRZYTsjKiEQwQBH44
         rRuqb4ywm2Sc+b/jVIMMCGtkVjVgNEDZoScqmFa5mi9V6038Z0kiZFza/0UfulyMQ/NS
         MexupzaUri5CEMdQCNxLXoKtvbfhQAoFXg4JbOpx610LkvRTB0bnvK6s7kgkimQArTEv
         sdyRE9Z7tCIkFBANGPyjbMQuQinmKGA/cqyZvguvvYKrsvFa3DPvzyZPopcJvRXDSLTq
         yz1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778520879; x=1779125679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS+p8qwM85YES2usQyitNMhM4oF15lCKHM72161PXoQ=;
        b=FFIW1GOEHdmNk1NCDkWVbqtKW4hqAIrJBzQrxNz0INtcYxmCqKsrePpzIJ+f7NCX6j
         aw1CKDGElo07sd1xt4GZXORMmhRsZ4bH5v37iMU0OxJBdlqI66/22rMVts2xg8wlwIWw
         LjgYHtVzVd7bNh1fpYzQ1W6lMCGJS2BbmrpnLr0gM6lwzD+Kj5JTvXkyLmPby4wwof9d
         8fwhWlzso4C0+gGFmN8YEkaQ/VzbgiIVknAWfVcR1GmadFovJYl1Mgp+7/a5tuTisBQu
         V7qOUQtj0TiY+vsRVD/OxvU2XvYwdToOOlqV0AFTudR8JGzztgLXk3XEvzBvBSG9p0pp
         cXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778520879; x=1779125679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cS+p8qwM85YES2usQyitNMhM4oF15lCKHM72161PXoQ=;
        b=hr0qlBF1xwbBBnmfLmWUMBjrZa376IAN9BTRBmjegQn7mYGRTvYemvwWzq6jI2r7x8
         gZRa/mldekSJ8HJaXpZ2XyaL9oEJvIcg4sy+ww3FRnOQCnxHEgMMq84ZmGBlhigLvQOg
         jBuFJZg/UtxjaX2KCBCOFM4VdeFh30u9nm9Cam4gDQOZBAoN5GYWQCcbTAf1QWo9lBVH
         x5CRbmvO1MZ28knJuSgdWhtCV8/K8vHVgPG9rvR+JrLdi3kaoGQyCJDABKnNbGrAqHtn
         3NFmwczCH88ZNRVg8y303xrwMMC4CyGeGCztnslx7309OcT01zd9CoDGwoKM0rmF5VKd
         4kHQ==
X-Gm-Message-State: AOJu0YwYAw5ReLbjG/Fs73xM8XnMjBZydOYPXAaR22o7CtdleMXk5F1c
	7lBV58OZ3M1hSX+e2T8R0Jee9ft4LAw/uliotJ5t/8nWzVXXRDflnS1Js3+riby/C8jjH13D2wl
	ZaPS98ryGNH0iC5C/47Oz/U16UTh6uW4=
X-Gm-Gg: Acq92OHo0sP9srMG3kZoJuj69H+zFp0WYNPvvV2woCKwhk9KO+Y1F/L76XifBFQMxDT
	55wE0PEQO0vyDdp6WaAg5djgXMmB41Y80yvikKzAnwJYKMdi3SDD6f6EAMedeOyan6UFQJKgO+n
	951L4NRDsKoZBhfdUIesQQ4rW1u50oansTEOz4N9Gum3W0Q55z2j+u8sByProo6+SL5Efyk8JiW
	h4Ub02z0K0CIY77fIJQXXDNbwS+H5frhFWL1YcOAOrDBViDPVn5MEkX/iBrRgtjZuGhqHZ210+z
	7S5SYksqWFJWA+I2Xw==
X-Received: by 2002:a17:903:2d0:b0:2bc:7aff:7486 with SMTP id
 d9443c01a7336-2bc7aff75b4mr115789745ad.32.1778520879163; Mon, 11 May 2026
 10:34:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320172446.96634-1-cgoettsche@seltendoof.de> <CAEjxPJ6QRisP9s2QBXvt73+s1KFAYcmtoLWMnOz=VPwDhT=Qug@mail.gmail.com>
In-Reply-To: <CAEjxPJ6QRisP9s2QBXvt73+s1KFAYcmtoLWMnOz=VPwDhT=Qug@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 11 May 2026 13:34:27 -0400
X-Gm-Features: AVHnY4Lwatl45dGxfb0mUN5dUY-aa6UHkInq1uucQG1fduRi6eC508q7TKCjkSY
Message-ID: <CAEjxPJ79UwFyiDj=iZ+u4EEVJ8LjDhuV70wd72HWwU5iKmGvvw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: correctly find partial matches
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 9:49=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Mar 20, 2026 at 1:29=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > The current lookup for file labels first searches for the deepest node
> > matching the lookup-key.  Then all definitions of that node and its
> > parents are considered.
> > For partial lookups also consider child nodes matching the lookup-key
> > portion that did not match any node-stem.
> >
> > Example:
> > The lookup-key "/sys/de" will result in the deepest node being "sys" (a
> > child of the root node).  Non-partial lookups don't care about the "sys=
"
> > child nodes "dev" and "devices" but partial lookup does.
> >
> > Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
> > Reported-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2:
> >  - fix documentation of find_all parameter
> >  - fix linked-list handling: always add at the end
> >  - pass child to the root call of all_node_specs() not node
> >  - continue on <<none>> context definitions in partial mode
> >  - add Signed-off-by
>
> Thiebaud - can you please confirm that this v2 patch fixes the issue
> you reported?

I've gone ahead and merged this but would welcome testing by the
Android team and ideally a corresponding test added to
selinux-testsuite to prevent future regressions.
