Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EA72951CA;
	Tue, 15 Apr 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727319; cv=none; b=pOfdWVUCS+mFGIwXNGnBj1vRw9Yey/TyFPfrQ6+urou92ARstJemsA+vmAWEXPYe/Sz6WQj/ErdxIkpoeqN2RY1q4NP7d1JmKSADbkNkuvRV4PyLq4LO4Blt9Cmxmr9PivK9kH9BhYEdpkweUeEO9nbielD8o9WnGZBM0P2Hzw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727319; c=relaxed/simple;
	bh=Nkbz8I6W9s0fe4POcz9WeNADwri4Cubq6W3JoYlcRdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE5ib8L0co+wUKFq0Js7w7dus/A9YzCwoTrq8tuI5rimjfHTd1aiXIm/lBziTuB/CWSMxNoOCeOlOM6CHg2p2riy6NzyA9J3Nx/LG2MzUeYxOPblsMT98/ZBfWyvGRE/JKIU4CbpCp4WMeUgmAP9fRLMJDsG6+OGDhCVhtbeABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=buhJcz4R; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="buhJcz4R"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ff0c9d1761so51388477b3.1;
        Tue, 15 Apr 2025 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1744727317; x=1745332117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3GaTQevx58U9DGgsfKcqKULSlMrRRxS1oTxlpS773o=;
        b=buhJcz4RGHpoUGBlVBIxP7WWJXVzHkW4JDYhVjwM4x1ccA6lrAtXb9xAoMEnXHk8oQ
         4jTYhxDs17yG+C0U2EAZsOqiUBocZ99frcFHmvmwn84ygzZPLidDuIXYmwl8sS2mIO4x
         zbczvMnygjaSJ78hO8uI/ybHbOss1naFcktP9i1ihlExILAyDHDfcJz8Ia3c70aQoPzU
         JGGWHhibs9P7adqt0saCEe+gWW6nS4WrFRWAyu3MbcDrVA9C81g5wdc5B5gPBcn/X1nD
         ae3I5HvB5IfGUSTDHkPOPaHOl2MTd/dPKMkXCL8HCgUIc7XPO0rLd64joFZmTG8g/MsX
         MDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744727317; x=1745332117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3GaTQevx58U9DGgsfKcqKULSlMrRRxS1oTxlpS773o=;
        b=o+R+nZdpsqpBQnjO7KT8cLX5TbdSJjWBL5bxjw6DYcmyQfAHHblOu01MjTriL5Kyy9
         iJYNVMu/3hcSMj1SJjqUGQPtH/jjCrwXPYu9AMezVJ6vGhXzmEYr/BnN8XrzCncVtGNc
         T/Dg0Z5DcdKdSVca4w7s5uVFU1O/teydhsU5wXpO3icAd4oBKjqJNJa4Jf6AnkuiJ9Kq
         hYfoQ8qpauLJkSmVlxuCBxGYokzC95g6Ku1LG3dJucDjgnfnaDn6KhpPH9cMuBawrKoa
         zhy3FxCvvtZYWbNKmiAgccS7P4hiHZhAOuxS0I2MdnWa6tOz+ExiR7Q2k379W/2Q5lWQ
         S/Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV6+3oNu7QwovGg2jczWSCuIdf8+1E8puAF/umZdSB+GAqn26T3Lh6iE2gDO6neu81KCATa6a5/9jhqers=@vger.kernel.org, AJvYcCVfn7KcXngjT/ils/KJvT+/YCLJzwQTopuCef7opQQHObaM+9S1NPPSwvA48OQatrUgPNnD2eSUHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUBeSWFX+fZdwDWjXSIRDy2X6cVQIaTI91pb78UDMVU+RaT45
	EpjZUwWGjHI9WpmN1SWRgzSyq/94LXviv/hv/QZkvuzQJQU7G2zWi64zdMTbHS3yyRb8sP7L/iC
	I6ABVkjeuRyu3J0uP4NCNsvhkxzLlP6CGlTYTDw==
X-Gm-Gg: ASbGncsyzAPBP1uIw/niK7pUSlsgH2RNul/TtkKhdNffaBoz8F9gPZ13u3xGkRBugFT
	P38uaTAWktkRida63BCXr1VFQZ99NgnevwQ4nkrEX/100xsEuOmGGP6FFyzBleFw3DN1KFqoOPA
	uH5ceYh8WqwcqtlsvusTxRTrA=
X-Google-Smtp-Source: AGHT+IEdJ4GIuqGp01q/uHvN80UDXN4gJ5THFbaGoh9a14Z9DISddODyuSHABLYyH9avhVDwnguLexU6O3TXZy2WSEY=
X-Received: by 2002:a05:690c:b82:b0:705:a92d:cb7c with SMTP id
 00721157ae682-705a92dcca1mr26682587b3.24.1744727316663; Tue, 15 Apr 2025
 07:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318083422.21489-3-cgoettsche@seltendoof.de> <7ed70f417b10ae1510dbbea501da892c@paul-moore.com>
In-Reply-To: <7ed70f417b10ae1510dbbea501da892c@paul-moore.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 15 Apr 2025 16:28:25 +0200
X-Gm-Features: ATxdqUH0R5szJN1xaJgrhonl519hXYeU63q8D04b7XegQ4pUvT8F0v7rrWs1uW0
Message-ID: <CAJ2a_DfvxT=49fDsXw1Rt3TMmQ6uzeDdRaqQj3zaJc+vpPPFWA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/6] selinux: improve network lookup failure warnings
To: Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, GUO Zihua <guozihua@huawei.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Apr 2025 at 22:29, Paul Moore <paul@paul-moore.com> wrote:
>
> On Mar 18, 2025 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgoettsc=
he@seltendoof.de> wrote:
> >
> > Rate limit the warnings and include additional available information.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/netif.c   | 8 ++++----
> >  security/selinux/netnode.c | 4 ++--
> >  security/selinux/netport.c | 4 ++--
> >  3 files changed, 8 insertions(+), 8 deletions(-)
>
> How many of these messages were you seeing that rate limiting was a
> concern?  Also, what were you doing that was causing this?

I did not actually encounter any of these warnings, it just seemed
likely if they would ever get hit they would so repeatedly and clutter
the logs.

> > diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> > index 43a0d3594b72..38fdba1e64bf 100644
> > --- a/security/selinux/netif.c
> > +++ b/security/selinux/netif.c
> > @@ -141,8 +141,8 @@ static int sel_netif_sid_slow(struct net *ns, int i=
findex, u32 *sid)
> >
> >       dev =3D dev_get_by_index(ns, ifindex);
> >       if (unlikely(dev =3D=3D NULL)) {
> > -             pr_warn("SELinux: failure in %s(), invalid network interf=
ace (%d)\n",
> > -                     __func__, ifindex);
> > +             pr_warn_ratelimited("SELinux: failure in %s(), invalid ne=
twork interface (%d)\n",
> > +                                 __func__, ifindex);
> >               return -ENOENT;
> >       }
> >
> > @@ -169,8 +169,8 @@ static int sel_netif_sid_slow(struct net *ns, int i=
findex, u32 *sid)
> >       spin_unlock_bh(&sel_netif_lock);
> >       dev_put(dev);
> >       if (unlikely(ret))
> > -             pr_warn("SELinux: failure in %s(), unable to determine ne=
twork interface label (%d)\n",
> > -                     __func__, ifindex);
> > +             pr_warn_ratelimited("SELinux: failure in %s(), unable to =
determine network interface label (%d):  %d\n",
> > +                                 __func__, ifindex, ret);
> >       return ret;
> >  }
> >
> > diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> > index 8bb456d80dd5..76cf531af110 100644
> > --- a/security/selinux/netnode.c
> > +++ b/security/selinux/netnode.c
> > @@ -228,8 +228,8 @@ static int sel_netnode_sid_slow(const void *addr, u=
16 family, u32 *sid)
> >
> >       spin_unlock_bh(&sel_netnode_lock);
> >       if (unlikely(ret))
> > -             pr_warn("SELinux: failure in %s(), unable to determine ne=
twork node label\n",
> > -                     __func__);
> > +             pr_warn_ratelimited("SELinux: failure in %s(), unable to =
determine network node label (%d):  %d\n",
> > +                                 __func__, family, ret);
> >       return ret;
> >  }
> >
> > diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> > index 7d2207384d40..dadf14984fb4 100644
> > --- a/security/selinux/netport.c
> > +++ b/security/selinux/netport.c
> > @@ -162,8 +162,8 @@ static int sel_netport_sid_slow(u8 protocol, u16 pn=
um, u32 *sid)
> >  out:
> >       spin_unlock_bh(&sel_netport_lock);
> >       if (unlikely(ret))
> > -             pr_warn("SELinux: failure in %s(), unable to determine ne=
twork port label\n",
> > -                     __func__);
> > +             pr_warn_ratelimited("SELinux: failure in %s(), unable to =
determine network port label (%d:%d):  %d\n",
> > +                                 __func__, protocol, pnum, ret);
> >       return ret;
> >  }
> >
> > --
> > 2.49.0
>
> --
> paul-moore.com
