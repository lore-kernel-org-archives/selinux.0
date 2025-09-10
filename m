Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D98E33086;
	Wed, 10 Sep 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513838; cv=none; b=LoQ7rapwUNFTlYDoeivhP3mBAYJb+MoMlDnp11pwuAHfzfKVPH36uYcQyNAq2SMdaPsEq9IUHsOYVVoeKOPDO8fye5ehpTiN/pn3Rv5aP2giThWdjscql+pyPFC6dX/dKPZSXs7AzfjVzjoo/7y4sd6ygr2IRIoTdgrAHKBDmEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513838; c=relaxed/simple;
	bh=xztsztFYqK41zm/tzNj7sQ/y1oiN88a65xcQ1X3Lks4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvlmeiL6WL/JuXkEix9Hj2DWCRLO3jxlr5gZ3N9ASMcEAjz/a5dSX8v90BefN22yxBWcTOFuMjMHbvwbV8fjeejN01VKm18Zf/CCGHc0a1jhyUEXBDtAxkBi+xS2HNzCj9ewz7t+0+/O9JC/g1Z4Ed/DQUoao+9vOX9QIkP+oZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bfu/1xHy; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfu/1xHy"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-31d7119322dso2624387fac.0;
        Wed, 10 Sep 2025 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757513836; x=1758118636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggprKhgHF23H4eRioWTSQbB7da3keHfQf7vFsuye1ZM=;
        b=Bfu/1xHy30I033jIrIj070lnzMoTrKJBRAxRCjXvcO4soyva6juUiC5O/gpuZrfiIN
         HXQbsYVCfIoAVIQLq6PxYRlUjn8k3kKUrJQ3K2pqfq/mXBNZYG/V4EkqKfZMHk6lb9Fz
         90WwKI8tQtcfhh7yJJ8KvfV/R51XkMAnN+cWDfQlq0WctjQWytOa5Lqr2LYTYhPone+I
         etewl4Rg9E123UJn7H4kfVTU2iaya9KK9Ree6n2+IVKZld1lv/ASz/MKKR8IElzyqgXg
         9mIQHt+2/W5xKwHdf2Ll0xDU9txJyJ7FWDwU1E9TufKk6eNshONW+VrLq16C423qtLXo
         fk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513836; x=1758118636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggprKhgHF23H4eRioWTSQbB7da3keHfQf7vFsuye1ZM=;
        b=ATWpGkXhUr6ABvPCYwMr3Ts+tITIPqDSt9hhlzDmHqb43/pWDvHsV4eG4hV/n6OfKw
         O7lBfucGr1LG/prt6yEcZoLqTQ66JqkIzDlvM4oyX+6y9Z2IC/b8dmGGNiRevlLIXFi/
         Jx4D76irRcQTJY4fMODw7toSYmB8tWRKUtYFYTiUhEC5nFtegpjxtGvT31wq2b0+VBHQ
         NQsG3fTRCEKivuUlJ4eeNjVhy5n+4OAZ4Z30T3hhd0vHxp//uOnQ/6B8yNKf4Qscyz0J
         Rz9D0bdLvj92jrkYyP61qSjl8+vl+IPJt1vexwC9ZDtmgQ2AYHkntoJz9c/fwHJXXD/y
         jnHA==
X-Forwarded-Encrypted: i=1; AJvYcCXQmR1ueaFKLjWV6QZ3ppznXcIDIWkTtUlgHCe/1ww0s5r2xGCdYtx6WDUhvef7f2OGvdldnT+21A==@vger.kernel.org, AJvYcCXrRSAMzMJjyX21QeCuwqwSQyDZm52audyITgIPXWspkAadLE1kth450UiE3hHDeiPn91BSwHklHcmypqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3HJvTTsIotMO+6vQfrdCEv9RBdBNjfohOgHpppR6ALHUDTE3
	A50xnjrQFMJrrbTHqwuQxAiRKJqE85BXRmQOUJVnvW+ymKWCWtFgnvl/M0iSS09OI8WvddJoTEx
	rViHY4T4QwnJtz72QaWseec7ynSFcDV0pog==
X-Gm-Gg: ASbGnctZ+YrQ8vCK8qVsmQUUq770XzvyYUiMZSCqMg1g+uyBeVuFidbiiO4Eo/B9Qfb
	rN5RUg8nNTaXjfL2NeiwrcABkvs60NHjbPplnEgvtpiJPqE8ulJ8+0sxyn1m4f4tb/uBW3t+XXB
	0YgZeMczpiVOybaKVDSn89X347T0ockXCBCtRKpIp0alN/RccTmw0iGniV9HOsKfYiZwvqY74se
	13SUgA=
X-Google-Smtp-Source: AGHT+IEVH2aa2k8d+y8FDH0qE9cfaRBWdaFm5QifN4Mp5LBu9Ry04G7bOFRDx34DtJ8cAjE8+O+QtxUANJXV6JiRsI0=
X-Received: by 2002:a05:6870:5cc8:b0:31d:8b8b:27d7 with SMTP id
 586e51a60fabf-322632a25f5mr7263339fac.20.1757513836235; Wed, 10 Sep 2025
 07:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828170503.2323187-1-nkapron@google.com> <CAEjxPJ7e6GVBzi2O7xv_A0+iJTWePRmMeN+jH0Z2Wo5qh6Om2w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7e6GVBzi2O7xv_A0+iJTWePRmMeN+jH0Z2Wo5qh6Om2w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 10 Sep 2025 10:17:04 -0400
X-Gm-Features: Ac12FXw5Lwe3EW_LeoIMbGLC8iRb6cPl8U-te0oX1fmQN77aB_k8J0w6cefjPB4
Message-ID: <CAEjxPJ5i4SPvtfz6wh4xnkr7Et0jBrtcCYe_rX-ZiexVwuCeow@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: Support functionfs_seclabel policycap
To: Neill Kapron <nkapron@google.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:11=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 28, 2025 at 1:05=E2=80=AFPM Neill Kapron <nkapron@google.com>=
 wrote:
> >
> > This adds the necessary userspace pieces to support the
> > functionfs_seclabel policycap which enables per-file labels in
> > functionfs and the ability for userspace to apply the labels.
> >
> > With the policycap disabled, legacy behaviors are maintained and
> > per-file labeling is disallowed.
> >
> > Signed-off-by: Neill Kapron <nkapron@google.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
>
> >
> > Changes since v2:
> > - Sending as separate patches
> > ---
> >  libsepol/include/sepol/policydb/polcaps.h | 1 +
> >  libsepol/src/polcaps.c                    | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/inclu=
de/sepol/policydb/polcaps.h
> > index 0835ea21..bbaebf1a 100644
> > --- a/libsepol/include/sepol/policydb/polcaps.h
> > +++ b/libsepol/include/sepol/policydb/polcaps.h
> > @@ -19,6 +19,7 @@ enum {
> >         POLICYDB_CAP_NETLINK_XPERM,
> >         POLICYDB_CAP_NETIF_WILDCARD,
> >         POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
> > +       POLICYDB_CAP_FUNCTIONFS_SECLABEL,
> >         __POLICYDB_CAP_MAX
> >  };
> >  #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
> > diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
> > index 7ac0ae7c..83eb6143 100644
> > --- a/libsepol/src/polcaps.c
> > +++ b/libsepol/src/polcaps.c
> > @@ -18,6 +18,7 @@ static const char * const polcap_names[POLICYDB_CAP_M=
AX + 1] =3D {
> >         [POLICYDB_CAP_NETLINK_XPERM]                    =3D "netlink_xp=
erm",
> >         [POLICYDB_CAP_NETIF_WILDCARD]                   =3D "netif_wild=
card",
> >         [POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]          =3D "genfs_secl=
abel_wildcard",
> > +       [POLICYDB_CAP_FUNCTIONFS_SECLABEL]              =3D "functionfs=
_seclabel",
> >  };
> >
> >  int sepol_polcap_getnum(const char *name)
> > --
> > 2.51.0.318.gd7df087d1a-goog
> >
