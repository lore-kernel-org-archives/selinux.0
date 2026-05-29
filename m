Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6A403E8C
	for <selinux@vger.kernel.org>; Fri, 29 May 2026 18:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079099; cv=pass; b=smcu+7xWCM0GeuwjvV18bxNPk3koq/iTb0N8AlZgDVxojex1WohESRbF6lHZXyLqpvOmPUGAM2gef5i4PUhqYSDeNODFiiPOBYpgX4p+gEnA0AXBQIaOi7gZrtMLADws6cmgwD86Rs3AEBR9FyF9rewIzxpiUe6kkGLyIH9pzXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079099; c=relaxed/simple;
	bh=raC80FL97vnFyloJA70eiiXfMtUS5ezjCgjeJ5g0ugg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gd9nzx03XUwvqtj9Nac90o/S73Oy2M0dnxAWSeaH4Zb6TmixaBbdhDfNdN14VT98cbqK6F95UCMEYQEPNkiMAAjestIXqpILFJ+kX2fBdfdwqwP0CZZkr8dWlI13k7E4fAEtMDhX/hjMdix0jWv+ckCQfUpu2OecXVcPpclJ30M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XMB+1ebq; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XMB+1ebq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso1707102a91.2
        for <selinux@vger.kernel.org>; Fri, 29 May 2026 11:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780079097; cv=none;
        d=google.com; s=arc-20240605;
        b=YzlK3g2YUCVr0UsrUYTmYBvleJsuao87oMcXbuiHAhQCnLPc/XRpoyK0G5wU5NnfEc
         sSTrWaDEjBbgXfDc4IeViYpbHYAoIDZ6HrlLljk8BLQDftUlAb/TkrFB0M+pgORpxSAL
         K8LJxxCu3fGJ/6Kxg/1AUWXJEct5ElcRQIOwT1JZqL5R3GQk3G0Giq1NATXI5MeOhYVj
         r4ab2MzKkJZplWJHI/wFsBLt238OiXuKc1X6SBUpRCF0b4lgb23I6ED2HQAU0K6+IQAj
         4BNAGIHpj6ai9mXfBHH2qr8nnoowi3qdtuQa9E9ixTEPOfI54bbuKGI84hQzVR2vjO3L
         S5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=raC80FL97vnFyloJA70eiiXfMtUS5ezjCgjeJ5g0ugg=;
        fh=p5+gMGhFQutaf4de73Oxs6SjPgyzRWci4pwEl6WL6fs=;
        b=cn+/Egay0hkHeurZP/L6W+N9fSIX4vTW2SqhdeYw1S4m5PVevKCIB5jNcLLvZumRww
         T8h45Ifw1gGZqLwtc+i7QoB0oO3faCru4CV3WI9Lr84QueytyHFqtDb78wOoCamUbxKD
         gJFP7jOEzJ7/M5DHIH6GDBn35/fW04zeRwktQG6qf4YtySbjG7uaNP/C5+PSPXAaBC4q
         QwRM4NXs6BdOFV5iSRCPtBdpHnQ5ccWbiipSrkajZT0UCmHCBmTPv44VJgDss9aHvz7x
         fiZeyeR5f+BCdPCuVIy/YUHUjyanmZSZkNaShvkfewftSwLBkLajZprSbmMRxHnIhb1M
         99XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780079097; x=1780683897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raC80FL97vnFyloJA70eiiXfMtUS5ezjCgjeJ5g0ugg=;
        b=XMB+1ebqrPSsZ5HT3XYrJu4qUggh8wCkdFpbZSniu06fsbPq8JjEebHnqV2FyH6TzS
         BcMcWAzFifp47VVOASMyVVGozGfFTR8IEpXDN9BYPFVJc6sbfDyjOMTODH7xswoLEDLr
         ooh/2ZTbak7Wf3S3W4h42CAgfyW7fa5W6IYfIFlE4z9IqFdLTOJZE82pYabXDLY8jyxj
         rBt64BKsfR3mzA7QGfKAPU2vIKj3pwdGZAaZ1P5Ch+cT0Y4SIMdE93HVPrmpS2t70ptM
         qvQo97L15Kuak92hKUJYlqTMt6Lt01ZC+7PS+Fj0jMtaJc/wbvBDoW0k2B3cKZnnDIzQ
         M7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079097; x=1780683897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=raC80FL97vnFyloJA70eiiXfMtUS5ezjCgjeJ5g0ugg=;
        b=afgeFct8DA7D4cHzvsb41gZ6zeEfIXf2D4dqOffeJu8M8sk6s5r/feubJaJHCFEXsT
         czZGhC9yfnbvOlprgO10h+fyyo7N8KgaYZw9mezS2R1NwxUC/buT4vs1NCf6hLeKopbV
         DWXACLfvBpk9UkoNFI+bEoB1X28bnMNz5ojdSA0DgZ1iPNrLxnj5UffNSDHU+cw9J3oR
         Gm6WLd8Pr0gWLa1zvhYp/Kq8xTmLFPZDH+Bz20/yxshAialnJ7tiQYeB0kARZlNwz004
         4ZvpbfkguXm9Znw0HhusgsCJ2NIEugLw9o1IRQ8nIn3MXQ53BQJqx4RyUy8xb7fsRvWE
         SklQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LTnSQgdk1Wf8RMXl8hhyfqS0HSn0MqNoV8EGHHwrkY1gvnUm69HPrICw5WMdb3PPFj19Z1BmN@vger.kernel.org
X-Gm-Message-State: AOJu0YwhmUor+y9dELwWjP40EGD+r+JBAVuam8tdOr8T4upUujMCicww
	hxr89SZQVAJ00n1PGqpDRmrE8LRys90bb0QD6+9WXmlZ/1pYZCU/ZBG9qbYJZJp4pxWz9+J+Lil
	tFaO5tnzVGmC8+hKX5HmHoNqtEE2JJAF/lxqev1es
X-Gm-Gg: Acq92OG4Wf3m+zpKTbv3BPCfSXzQL3GtQ7uNH7KIiU/RSMXPY869CNo5BrI2B6iTrMZ
	7V8m3yN3BoSJ0J12mS6Gs1psN05uY78cZWWNrKMxVRRtLTsTDKSxgOpH0nkJBFJYcEQ/olawBW3
	v4nQ1ssvS/CgncufFBJxwVSeWC8ri8TmBuhsgrYyx2RPNWOnFKbiLS/Smd/dHT1drADsffxgX7F
	p/wOWQPZc79ldFgBgIaBEhK7hwomL+q9beap+rqOWPi+tei8ujvD+FG0BsySfflZr5OauzBKhiQ
	vuWs07dzt/S5aoTYrg==
X-Received: by 2002:a17:90b:5212:b0:368:b176:c5a8 with SMTP id
 98e67ed59e1d1-36c501e747emr374444a91.15.1780079097303; Fri, 29 May 2026
 11:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03e5151a-f420-46f9-ad5e-109420132021@linux.ibm.com>
 <8f0c86f7-eab4-4e82-97c1-5d190c390770@linux.ibm.com> <CAEjxPJ7Y+9AqEVTJswUsan4OOP+DVkFG3vXukQVtcJZbVaoZnA@mail.gmail.com>
 <CAEjxPJ6DqhHKdjwC3ddZfUK4HVPwOTzb1Kkuabi5WmwmF8Lu_A@mail.gmail.com>
 <CAHC9VhSEjSmdVgNxg=PvwS6RXnJzFybJtFhCJbOsKiRhXi5PJQ@mail.gmail.com> <CAEjxPJ5wS+sXvCjO3q2sfrckuMo71_Y3uSdgu+Vte7xLkW0Huw@mail.gmail.com>
In-Reply-To: <CAEjxPJ5wS+sXvCjO3q2sfrckuMo71_Y3uSdgu+Vte7xLkW0Huw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 May 2026 14:24:45 -0400
X-Gm-Features: AVHnY4JkvYYnGXgtS-r6uyAoqJa9j23y-gvS34JWyjHW-_UBDjUi9Ylaj-ADNeQ
Message-ID: <CAHC9VhQT43Dq=NeSBwKkeF=Xr9mqdG+Gi0L+xs0pCCxuMoZBZQ@mail.gmail.com>
Subject: Re: PowerPC: Random memory corruption causing kernel oops on Power11
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: rppt@kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	selinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 12:11=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, May 29, 2026 at 11:39=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Fri, May 29, 2026 at 11:19=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > Alternatively, I suppose we could just update the dentry_path_raw()
> > > call to also pass PATH_MAX, but
> > > I don't see why we want to use __getname/__putname() instead of just
> > > direct kmalloc/kfree here so
> > > the size of the buffer is immediately evident to the reader.
> >
> > It's reverted, see the posting below:
> >
> > https://lore.kernel.org/selinux/20260529153608.30853-2-paul@paul-moore.=
com
> >
> > I think there is still value in using __getname()/__putname() here as
> > opposed to a simple kmalloc()/kfree() pairing, but either way we need
> > to adjust the buffer length in selinux_genfs_get_sid() accordingly to
> > use PATH_MAX instead of PAGE_SIZE.
>
> IIUC, __getname()/__putname() were originally internal helpers for
> getname()/putname() and allocated from names_cachep for struct
> filename. commit c3a3577cdb35 ("struct filename: use names_cachep only
> for getname() and friends") switched __getname()/__putname() over to
> just generic kmalloc/kfree so that other users of those helpers would
> stop allocating from names_cachep and noted that those lingering users
> could be converted to explicit kmalloc() over time. So I don't think
> vfs folks want new users of __getname()/__putname() but I could be
> wrong.

Whoever wants to submit a patch to do the conversion again should
chase that down.

--=20
paul-moore.com
