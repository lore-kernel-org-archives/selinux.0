Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A854A2FBE15
	for <selinux@vger.kernel.org>; Mon, 17 Nov 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763414762; cv=none; b=dT17KoKUc6HGEeGwfdsL1vdQtgURkg+igRxHJMsuFVRl2VxkYryPyWn6RitA1QmDZm0L/PhRgESFZn0iwtGU/qFeyjbz6FMbP7VJ3M/n7ydoBQZcljOZo14xaDiMCU2+5ulVZEGUMtiRd3AAXJsDuVKVtip6T20IGnRxSDaCD8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763414762; c=relaxed/simple;
	bh=19HbeFFsnx8+dvyiPcZjL9sMR1GAVHT6NM21Zed+J7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6LM2C3UNQvnxe2QJ3eM9K7B5YcBIxCkVMXIaHp8ml78cnUlyjEIneUP1kKCIw7D4k6Eiiog6eDsf9exFFIxR0drlgINVFPBd889N1rICccU7GyYR6Gfwq+V/r9cgCSFXd08LFNERODlru8uRcbSnRQj92bUbe9PILGLsnWZqFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilw1aS1q; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilw1aS1q"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343dd5aa6e7so5343487a91.0
        for <selinux@vger.kernel.org>; Mon, 17 Nov 2025 13:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763414760; x=1764019560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhiq4hgP4oBM5J58Qt6TlQ9Yf7IrVfnkA3dKPG9cDEU=;
        b=ilw1aS1qvwDAdmmL0657aAG6Ii81fXGHUD1tG/Q7v2x2KxLfYY+cF43LgoQeB8/xic
         VtXwfyVSThuMEOc0gmVcEmpBbnDvZEHcDXuyraL7W+xK74huO6l91OMZzHsacv61h/+h
         uEtj9q0KJ7GgrMr9WsjmHZBP4ZlTED0/tPJOOJ5PtdQDDOn6NFS1d31eBYPXftifYSeL
         OjfZzkmR8aMv6Ob8SZbZz3S0FfTSrpuUak0KOgYWMAuz87EnZ5gNQ00GFZtG5vansoF3
         kdfTiSsR/9bRlOE3fVWYfkTPqpihWLqz6AULzQ6Ilq1xfrMTofhkeD31zVXlSuF3RO/K
         HcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763414760; x=1764019560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rhiq4hgP4oBM5J58Qt6TlQ9Yf7IrVfnkA3dKPG9cDEU=;
        b=GnDvu6GVEj0qXXFflHuwz7J9UxoRArGg6/6ZATNgyNaMYdf/g6aLGHUAiWuL66fuQ6
         Hxk0WcVDftdUXV6e1Z5ErqRJVLB34iNcJxBr4VT5tnAs5BOzs8X6skEJwCkX0ocYqsXc
         QJEl59R1pqTfQ/TAkpuQ4O0rZZzzOAogDBmhdFKMHHuxNMXUi/VfmoGqgn/lokoZm0Ed
         ZWPrZHo54ptIyV55QRnwLB5rlSeGGd4kpVsWp6eCHPe2/eRZF4C46IzTG1evh6u4b1El
         m8XiYRu3LSxzPK1OxtRGh/cdtJaB/EH8YbP4CGgUabP7aw+5gAKNxv/aC7701Rxir3TL
         8Ydg==
X-Gm-Message-State: AOJu0YzU5wOsT5QuFomqx0jKH18HlN0eSk08C1iXYI6mun3eyScpQ2wq
	aOV9eHWZZHnHZAyazzUOK3A9rd/vEMJLpL40KiTE1mJpNytAzSX10NUNGpNY27aMI9JcY1TmCPb
	s6a02AIb/fDjrMu423N/AH+gvQ3pdw4U=
X-Gm-Gg: ASbGncvmQJ33rPZJ0CKSZekKsBliS5u6CXbuQzqrEx378iIuTwUZsrZREdJ6xMpUXAe
	ex53v+JNJ6tpVdfRshOaj4dXDURtQntqGG5gBcLu0vJuuTQEe6CQ0d+85NyA0CJADKcnc+/tu/L
	MBWQeYOFi6KjkKz1gx4hHv05QwMCczsUFRq5tdPQ/DmbQdgFmCqWCRUyDmkW/B9Qlj2Me38B2BW
	7kUPWzcPSXV0A/islx5u4eo7GEDf66+rNiMwOpRDRp3ay+BG4SD7x0xF9x9jUS5BzhdF4c=
X-Google-Smtp-Source: AGHT+IHNodBfk75XLpFld2vBDkLLLiKUilgy7/FwEXg2nGBCYuhISK2w/fTmyXehgCov7wQ0m0KmnLqVViUgohsXvjQ=
X-Received: by 2002:a17:90b:2dc6:b0:341:8ae5:fde5 with SMTP id
 98e67ed59e1d1-343fa73b98emr15654788a91.18.1763414759857; Mon, 17 Nov 2025
 13:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114174514.14695-1-stephen.smalley.work@gmail.com> <CAHC9VhTponNBYJ=YEE447XKSLrHc8kKwVBxMuiQPNrzjKZ=GXA@mail.gmail.com>
In-Reply-To: <CAHC9VhTponNBYJ=YEE447XKSLrHc8kKwVBxMuiQPNrzjKZ=GXA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 17 Nov 2025 16:25:48 -0500
X-Gm-Features: AWmQ_bnSQjfeKrLAyGSK8EMynDB6BAvcWyUPnJsr_Fp71eD5OVhnFSUxreG_4o8
Message-ID: <CAEjxPJ5=GJ5aTxk2xTAiLCiJc41RMo2Wtfp4VJ1XBAdzzEGW6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: move avdcache to per-task security blob
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 2:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Nov 14, 2025 at 12:45=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > The SELinux task_security_struct was originally per-task but later
> > migrated to per-cred when creds were first introduced to Linux. The
> > avdcache was meant to be per-task rather than per-cred; move it to a
> > new task_selinux_struct that is allocated per-task.
> >
> > Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce path =
walk overhead")
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/hooks.c          | 35 +++++++++++++++++++------------
> >  security/selinux/include/objsec.h | 13 ++++++++++--
> >  2 files changed, 33 insertions(+), 15 deletions(-)
>
> Apologies for the delay, I was away the past few days.
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index a22b1920242f..0eea43e4a90c 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -212,11 +212,15 @@ static int selinux_lsm_notifier_avc_callback(u32 =
event)
> >  static void cred_init_security(void)
> >  {
> >         struct task_security_struct *tsec;
> > +       struct task_selinux_struct *tsel;
>
> I know we had a brief discussion about this off-list before you posted
> the patchset and I asked you to move the task/cred renaming patch
> after this one, but looking at the results in cred_init_security() I'm
> regretting that comment; the naming is just too ugly otherwise.

I'm not 100% sure that setting avdcache.sid in cred_init_security() is
even necessary since it should be set whenever the avdcache is first
populated and there is nothing else being initialized in the avdcache.
So if that's the only ugly part we could just drop it. I only included
it since it was being done previously. It wasn't in my original
patches.

> As this patch shuffling is my fault, I'll go ahead and re-arrange them
> and follow up with a reply when they are in the stable-6.18 tree so
> you can verify everything is still okay with you.

In that case I'd be inclined to revert to the original patches since
they are already ordered correctly and they don't introduce the extra
task_selinux_struct name since it isn't needed.

>
> >         /* NOTE: the lsm framework zeros out the buffer on allocation *=
/
> >
> >         tsec =3D selinux_cred(unrcu_pointer(current->real_cred));
> > -       tsec->osid =3D tsec->sid =3D tsec->avdcache.sid =3D SECINITSID_=
KERNEL;
> > +       tsec->osid =3D tsec->sid =3D SECINITSID_KERNEL;
> > +
> > +       tsel =3D selinux_task(current);
> > +       tsel->avdcache.sid =3D SECINITSID_KERNEL;
> >  }
>
> --
> paul-moore.com
