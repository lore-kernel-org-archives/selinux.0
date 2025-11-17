Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91134402A
	for <selinux@vger.kernel.org>; Mon, 17 Nov 2025 21:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415840; cv=none; b=s4MOSZ8Tj7cSCOenccnDC+KLyFBJXozfmSusylSBgEN3an4aOR7QUZtdlgO5DILTw7LZcVujQUjV1pgj9QWFNGyvElx6DH2qcU73C4KMwt4HZhu1hEAKtEkLaV8Rx1kZ80mpzhgSg7+3qH0sQ4qi236CS6RNH8ABhwq6z2cSQ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415840; c=relaxed/simple;
	bh=lAZIQ94BjMZD2gDLGJOfdR8qzXamumkd3eJ/lqK6h3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ag3RuVQbGeCPd7nyfHbHyy71mLcfCfh0SV1bZCi28rB1gLc57qvocTruiyE0GUlM5kfphuLHClJLw2+XNp+YX0RVueSLIjjpoxoeyrBIUG5BHbvekWQBU16mXzeri0gpEfnqKKsrY+hJum261rlriYTTrXhINSqV7cUVZpTtQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aexJUtit; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aexJUtit"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3434700be69so6424159a91.1
        for <selinux@vger.kernel.org>; Mon, 17 Nov 2025 13:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763415838; x=1764020638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvGJT3fgU02zcYhgIl9py0bOx3gf9HUPn3FIOHMdnUc=;
        b=aexJUtitnUwaSLFJVZeMukAGK1QwudWmW25NLB2BpSUJx3n2+cTCixt1pHPZ56WCiB
         RxE+QPlvPmeSx1zrqGEulA4UxRBGasFQR2u9t23BqjcyP5sEsMIloWmlOCYWX6xXNJs7
         0Xde8BNEnQj7J/FTdLMxnPJI/X52kOIxgHNS/rfA6bYLgls6v/mkDxVWrbTEtqElX1ds
         d/jPxDBOoNNunXU3yLxFiS2nNXBLDgW8x3RwGftnkfusTEDlzzDGvi02yTZtypKqKDW1
         mkDFWS/bRWWTlp8CvJXpGUF7EO9aU3YsRxEabrGh1jTUsvH5r61zh6zNW/snWZJ40TcY
         GBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763415838; x=1764020638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cvGJT3fgU02zcYhgIl9py0bOx3gf9HUPn3FIOHMdnUc=;
        b=bXUsQSKq3UERD9P1DCZst1jzgqbifN7I4IaX+OLYxdNQQ4BircObRYlnL8V3KXndfm
         Tb+u4ErS8tdlAkWIpaeYkj/Oz0VmSzFYa40vg9sXrP8EY1ETc38rG9ex4Twz+QYfvXQQ
         /1wLJa+2EZzm3YDgZ4ru3Rakz920t9gex8jrqqZnFLnLNHDTrszbrYUVdiCXetpG1Ivg
         CzuegOSDzU/ieeA/GwROKFKlIOr7bKiW8P7Ria3TFa+T3g34Z2X1tmcnZtQF6U0a41iz
         hyfAQA/sDgs1iCHX2VPTJ/4DNXEQX8+vR/NOW2HaPu03CA0MJRrsYNRzpzEbQBkXVeC1
         PZxA==
X-Gm-Message-State: AOJu0YwaAvyq1rxSuahK16rrivm/7ccloQOW/ySicBc7hnWy6ghmvFvk
	VnGCiAd7mjZUPaiwm6vK+0kYFMktkqweU15C7h6e3fjfE1zK7KW9A/U3KcCwWq2x/qUCpWCudwc
	Ujv9KFe/Sr0P47CCCMytylOMMGh0iuZz7Vc0bXmNE
X-Gm-Gg: ASbGncuJX1X68QuAjzTfVKRHvDGrObNugdrwsM5oGzwKQljuT3Z89HUT/QBBBRDhJA5
	3qjbPm8fZR7bJ8ZqrZBBb374RH0jSrvHpNqdwN+WP0hb6FSj3g0mT9PuVamnkE58lNeHMvp5R+z
	jktduVzClT0jpnCNa9wO0g1wr97hFqBmr/7YdsqfKL0v5lBGhguM3eA3G+Gv6d7rA8ukt5a8+9i
	a+vEU1H9etwX/lHjElxCBUtSAlsG42kOUPFIQbtTtrAHPPCcy3ibyhXQZ7jxaPFcpIsCu7Sje6+
	MaxT/w==
X-Google-Smtp-Source: AGHT+IFl6DQXNuV01Ck5zjDAIpEHY/NHhPl9bd797333MgjcnZK4ma5OAXsnhZii+1UBk3dHRk2VzWtsXirCDZZb0Ts=
X-Received: by 2002:a17:90b:388d:b0:33f:ebc2:645 with SMTP id
 98e67ed59e1d1-343fa52ab2bmr16200582a91.20.1763415838054; Mon, 17 Nov 2025
 13:43:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114174514.14695-1-stephen.smalley.work@gmail.com>
 <CAHC9VhTponNBYJ=YEE447XKSLrHc8kKwVBxMuiQPNrzjKZ=GXA@mail.gmail.com> <CAEjxPJ5=GJ5aTxk2xTAiLCiJc41RMo2Wtfp4VJ1XBAdzzEGW6Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ5=GJ5aTxk2xTAiLCiJc41RMo2Wtfp4VJ1XBAdzzEGW6Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Nov 2025 16:43:46 -0500
X-Gm-Features: AWmQ_bneQhnaChltYrxyqP6sa-HQnPWfhC7l8AX5LiOMozTuYNR1B7VqQSa3GUk
Message-ID: <CAHC9VhRtgQkvpY=Sa+4VNtg6PRnVVEBNLk+Q3FoWoSApqWjHYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: move avdcache to per-task security blob
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:26=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Nov 17, 2025 at 2:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Fri, Nov 14, 2025 at 12:45=E2=80=AFPM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > The SELinux task_security_struct was originally per-task but later
> > > migrated to per-cred when creds were first introduced to Linux. The
> > > avdcache was meant to be per-task rather than per-cred; move it to a
> > > new task_selinux_struct that is allocated per-task.
> > >
> > > Fixes: 5d7ddc59b3d89b724a5aa8f30d0db94ff8d2d93f ("selinux: reduce pat=
h walk overhead")
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > >  security/selinux/hooks.c          | 35 +++++++++++++++++++----------=
--
> > >  security/selinux/include/objsec.h | 13 ++++++++++--
> > >  2 files changed, 33 insertions(+), 15 deletions(-)
> >
> > Apologies for the delay, I was away the past few days.
> >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index a22b1920242f..0eea43e4a90c 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -212,11 +212,15 @@ static int selinux_lsm_notifier_avc_callback(u3=
2 event)
> > >  static void cred_init_security(void)
> > >  {
> > >         struct task_security_struct *tsec;
> > > +       struct task_selinux_struct *tsel;
> >
> > I know we had a brief discussion about this off-list before you posted
> > the patchset and I asked you to move the task/cred renaming patch
> > after this one, but looking at the results in cred_init_security() I'm
> > regretting that comment; the naming is just too ugly otherwise.
>
> I'm not 100% sure that setting avdcache.sid in cred_init_security() is
> even necessary since it should be set whenever the avdcache is first
> populated and there is nothing else being initialized in the avdcache.
> So if that's the only ugly part we could just drop it. I only included
> it since it was being done previously. It wasn't in my original
> patches.
>
> > As this patch shuffling is my fault, I'll go ahead and re-arrange them
> > and follow up with a reply when they are in the stable-6.18 tree so
> > you can verify everything is still okay with you.
>
> In that case I'd be inclined to revert to the original patches since
> they are already ordered correctly and they don't introduce the extra
> task_selinux_struct name since it isn't needed.

I'd want to go back and look at those patches again, but I don't
recall anything jumping out at me during the quick review.  I did just
check and they do have your sign-off, do you have a problem if I merge
those (adding the fixes tag, etc.)?  I'll resend them to the list
simply so we have a record of that beyond just the git repo.  Or did
you want to change anything in there first?

--=20
paul-moore.com
