Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BC7376BEA
	for <selinux@vger.kernel.org>; Thu,  6 Aug 2026 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004433; cv=pass; b=qUoY43g8TKPx8v8URRcPC3YhtujVtLlvFW8A/pXLmJXcrVKEwxMgnaxKizkCO/yU2sVAoQs0NXiTyWK6lXT0hJjSJt4WX7IXP9L1ygvAbVyLHjakepYU5qwOcIE+05DR7q1xNEe6CvGL8aP9lz/FWN1Nz5+N15N//4ijeWCml7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004433; c=relaxed/simple;
	bh=2h+52EqjriyVRuKGS9NsAjI6Yy4GaKz/x0wYzKYlNbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acTXl8uJKpiJ7oP3G8bZ2gs42CViIyBWsrodJXDpqvcGiD/z6iaLAnv0IgdCM/RiLg1uiiepojglRNGmWBW+r4i9eaktyLuf7NhJVFZqI3Ei5vlotVg1gSQji+UyxR8BHlUqLSpq4yF7ao9/jgfoNictO2zfox3u90lGl0E5Z+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaNlAshW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7pVzMA5; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaNlAshW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7pVzMA5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786004430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PrVIe1fCmVqoWDW4ikS6g6ChSm0UZhYmIktnXQmrA0=;
	b=SaNlAshWTUnI3EoaEVCbTnUoN0K0hTab9OYE11KVPQ7qudrrWWR9Pjw4DuJdN34MGYiJKs
	CvRJn8LMJ/4vBy4Zeu0QkMrFb60K4D0o3eGueFbm6AEuTC/4Uo4M3G1zW6JZYaIBPtDUzd
	klnm8jyRb+fUN9V/WQ67NF5hE8A3q7w=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-yGpJjg_lOf6uhDP52kTPjw-1; Thu, 06 Aug 2026 04:20:29 -0400
X-MC-Unique: yGpJjg_lOf6uhDP52kTPjw-1
X-Mimecast-MFC-AGG-ID: yGpJjg_lOf6uhDP52kTPjw_1786004428
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81ec0eb032aso48050057b3.1
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2026 01:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786004428; cv=none;
        d=google.com; s=arc-20260327;
        b=d/3YG4jqMSegm0Ue2yRQOz6ig6nvdQ4oMlry5r+gVSo284/WC3FhmPo1vO7WbVx55u
         yt8reRmW6SCVAPsWtuvvhUTtSP02FVEioGYWvdQdrJhRyv29MnfWUgqlywPyVzHgN4Rn
         aTDBPgjypoX0NgRHRqqpzsuHY2+2LP1YpO2cUhgmYekmyKHM2uLcM9tmXv2sipSLNoaf
         qQK4D7E1Fd9b/ZVrYGf9m9eS6HspM4fZS9M4W2MryL3ESWW66YsJLl9/68bEpMRQIvxc
         iZQ/mPzIb3JSb+SxeMeCsnlUoHdSAuSj2Z93X1dexG0qPqlcSQVPzDRrlT2NOWpl7ncw
         iTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+PrVIe1fCmVqoWDW4ikS6g6ChSm0UZhYmIktnXQmrA0=;
        fh=1X7xVEwd2jlk71dnV0lkSZWpt2kiE9VWaBOwOa5zHMY=;
        b=sFrBdHxY8yiFOSOfCsfXUkGT7iqAtclaeVjZ3P1cp5mg4yBOxCGzQbeNn0zIEjBhEk
         QBqSysnMGXrLHIBf9hgeuRBdnErcIeCQS05n+kimlErHAM6g45KZOQyqwYHxSO1KrWpv
         vxeF+AAk5oqBumSORnUYB618jc1hqaBluPnqaPCfHRNgI4uuPks8WJuBcZjJobwI8FA0
         79T6zdflzeipVp3LU9eK4YCQK4hJ89lC5h/7zQoevCDKsBFARQWU3hu/BwnMQSet7gXg
         8ggQ4BGShKfQr0cG4AhLi45sC13CXT1bjcS14N8p1qaXp45j7SRvtIPEeFxQZF8Unydt
         7TkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786004428; x=1786609228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+PrVIe1fCmVqoWDW4ikS6g6ChSm0UZhYmIktnXQmrA0=;
        b=N7pVzMA5cOEeQCp75syeeaaRfh+exzQUg7KaUjVRFJKOCzvr02oAI2bngTgh3/fGf0
         Hzx6nBZObBHiSKqcZPLbPdbGR55mrXMQSLdbXpTmaBmS7w5eTcaoZ9U6xgdijoX3fIRe
         6clX6/JYQyxLgwt68zzdfPEodF3XfnGQs6SGeA3SSQrdouRo2r2GOjU/yGf19EZLaDF+
         uYXDEnz6bUleDzwxhf1deDCTqobMdgLEXeraotchXg9GyEFmJ7QHj9PmO7oqykJOimQ5
         NnJ+dJ3oMCLpqlpe8IHbSIulyHrJtQn9B2Mf1e8rWFHKM7I9zCrL4PE6sFeZQBjT3r3M
         LeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786004428; x=1786609228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+PrVIe1fCmVqoWDW4ikS6g6ChSm0UZhYmIktnXQmrA0=;
        b=iyXO68QPZEXpBK/LNVTzWN6cFw3FPjTgtln+RvYXjEo+CSEz4p3KCt1y04nuwlAui9
         LfoAR4ePW1v/u7lBtV5myTfweD03XudNWhi9VEky5WYtP5T6uSI6DvBOjzdX6T5S0hFD
         CbO10ayQaQ68Kfn/He2RiU7XvuZaggyaL/398Xpx4rODqx18/T/FvrKLRnDCzxvGEBef
         lZBq59MeG5j/trQ4z7tx9hURqjUIHt7yFIqHH9FMsP6viJ+vA5cu6P9Tsx2Yev0NVy3i
         kOzyGsFfTFmGXZJUr+GXlNznwx4K3GquOHLe/AOcWsvxzAkYx1NAOg2P4VSz2fCO8Wls
         /VJg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9qRV0c4yfHDhuJ4soVw0eugZ9InTLj9HhBOJtPtZaBgcHnKqSh84TatGOV8mEHaBo2/HhwXFn@vger.kernel.org
X-Gm-Message-State: AOJu0YyokVs+KlEUBplv5X2CKzczISACCjxe2swIR8nG36oG2DctcbHL
	xyDdTbw763F3i4wOYkKAbLkyd9SjO1nGqULzXR9jZq5+t0S0CGBb3xkRQOHRIVxo1YR0/wzJShn
	mld3TT0md1ax0kJW+8mf0pKsPOLMuba4v2yW+tvqdgRmNVgrQ1Ky9EGcWCszaHMuA2huGACJPUB
	uIKrTT83ivlxqYUES0bblaUmBg6PrJ/MUL8E+fmZYTSw==
X-Gm-Gg: AR+sD10aLxokr0pMIwc3uhh2DYabJ7TbyFL5Vogf6AoIBQnK4qz446FUMWoL/3xNJ9e
	ZRWiZ2c3RyMbzTzKxBc5GYRdJ2zKnAkoe0Zc6hYg35vAWgPcfM0rAzBYOHxd0wgegIBQIyIgFeC
	RmGgdBIU62tP1bEzGVI4Rf0T118BKUtZjQkEd628X5mny/0q1G+IYJGpOVEPuddwH9OsNHQFEPb
	6rcygokZb94pSjF
X-Received: by 2002:a05:690c:d0b:b0:81e:ac09:c89d with SMTP id 00721157ae682-8201f0c1769mr79350447b3.4.1786004428511;
        Thu, 06 Aug 2026 01:20:28 -0700 (PDT)
X-Received: by 2002:a05:690c:d0b:b0:81e:ac09:c89d with SMTP id
 00721157ae682-8201f0c1769mr79350207b3.4.1786004428075; Thu, 06 Aug 2026
 01:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804135700.3713-1-stephen.smalley.work@gmail.com>
 <8335d7b97813e178446e4e8b37e8e961@paul-moore.com> <CAMgFczBaRgj=aH4A-Bd9Zw12Kmt2ymtMQwpaUW7rOk3FpDJenQ@mail.gmail.com>
 <CAHC9VhQmEkeN+ZwApXnbak_w-TUJA53o1EEhtCSf56dDi8OvpQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQmEkeN+ZwApXnbak_w-TUJA53o1EEhtCSf56dDi8OvpQ@mail.gmail.com>
From: Jiri Vozar <jvozar@redhat.com>
Date: Thu, 6 Aug 2026 10:20:03 +0200
X-Gm-Features: AUfX_mx3od-RYmFz_Z22AHyGvIOTS3y4shKfg4xvFOyimusbLNtrgjOKFkIkyCY
Message-ID: <CAMgFczB05ig+Fpe1bpaWQQguOVycTa+Y+Zt=oiag3Ot8i2f3QA@mail.gmail.com>
Subject: Re: [PATCH] selinux: check level category sets once at load time
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	omosnace@redhat.com, jhladky@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, you can.

st 5. 8. 2026 v 17:31 odes=C3=ADlatel Paul Moore <paul@paul-moore.com> naps=
al:
>
> On Wed, Aug 5, 2026 at 10:56=E2=80=AFAM Jiri Vozar <jvozar@redhat.com> wr=
ote:
> >
> > Hi,
> > thank you for the quick patching. I tried the patch and the
> > performance fully recovered.
>
> Thanks for the verification.  Can I add your 'Tested-by:' tag to the comm=
it?
>
> > =C3=BAt 4. 8. 2026 v 16:57 odes=C3=ADlatel Paul Moore <paul@paul-moore.=
com> napsal:
> > > On Aug  4, 2026 Stephen Smalley <stephen.smalley.work@gmail.com> wrot=
e:
> > > >
> > > > As reported by Jiri Vozar, commit 7edea6e8c8e8 ("selinux: beef up
> > > > isvalid checks") introduces a new loop in mls_level_isvalid() that
> > > > causes ~89-94% throughput regression in System V IPC message queue
> > > > operations (msgsnd/msgrcv).
> > > >
> > > > Move the expensive part of the ebitmap checking to policy load time
> > > > instead as the reporter suggested.
> > > >
> > > > Reported-by: Jiri Vozar <jvozar@redhat.com>
> > > > Link: https://lore.kernel.org/selinux/CAMgFczCi2Z011dNf84Amc0Q-qnTt=
0+VUjWY+Y7zPyXdaH35Jvw@mail.gmail.com/
> > > > Fixes: 7edea6e8c8e8 ("selinux: beef up isvalid checks")
> > > > Suggested-by: Jiri Vozar <jvozar@redhat.com>
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > > >  security/selinux/ss/mls.c      | 24 +++++++-----------------
> > > >  security/selinux/ss/policydb.c | 23 +++++++++++++++++++++++
> > > >  2 files changed, 30 insertions(+), 17 deletions(-)
> > >
> > > Merged into selinux/stable-7.2, thanks everyone!
>
> --
> paul-moore.com
>

