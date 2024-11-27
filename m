Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19F1BC20
	for <selinux@vger.kernel.org>; Wed, 27 Nov 2024 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676616; cv=none; b=qcO9zGhq9MOgx/MrcFp2NnyI5XuY39sxbkKgjLZFziSOaejqG3nUokNK9txgTtNivHikFGvGVdWnq0Qenr9hXgT0FNNQdZ1xbDeDwUj4goFq9JimF80aOvbrCKdJqHYiWEw1v1Yi716fWjm9oslsPl7W1dVfEb2h33DNen5Qquo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676616; c=relaxed/simple;
	bh=+shIRotlLAxBhb/kWNEDqQz9k/HkJOaZ+jYxCJt1trI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4MP1av/5j7c9Dz6Xa+3YsPcqQVbJvn4uWXP04TZxx5qYmN0ZYi2rY+URPsBByCx/7S+8AjIdLUTbMqd2VXLoe29Cbh0KEgh/H4V13v/SbcC6VxR20VGfiaootoWm9VAAT2E++KB2eh5rSoguIZRFQ6iS2vNc1Fw/n32vfk1h+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bpvBzsHT; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bpvBzsHT"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e388503c0d7so5166508276.0
        for <selinux@vger.kernel.org>; Tue, 26 Nov 2024 19:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1732676614; x=1733281414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXn3mKYeHB2wV4Z+XMWCTzhvsAX64sj/9Q/LfZcNFho=;
        b=bpvBzsHT2+ajSiyB0QqnXtkEH3huo7rkyp1fXR439eXP27dmsIYoLlZbc5+v0x7TcX
         /lu8kgqqSsC0t154oybbWR48nJA97+mTCndH6ndi0MYc62hqh3O+sGAGQ1CXp7EA++QH
         l4NsWENCnb9k6e6f09nPV4i6cW5InZZckL96xD1LumMsW4WhqVYqR3xceZfndABUPBZW
         vF+lpUr1sybvt7UIIUxIsQfdGGl9eQRKMAOfELUJ8EyMmA9nmGCQuienr91BP58uEvXZ
         v9c2q3ztZImqkwVdgI0pgYvwhlKGSNyu8YXSKPBB59fn35QIwwLfJkoVleJEoeduLHib
         7DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676614; x=1733281414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXn3mKYeHB2wV4Z+XMWCTzhvsAX64sj/9Q/LfZcNFho=;
        b=halE+iylZ/vYDT1KIKB87UAYgvMDatGhIyRLujFFhi5yJKD7cc0sNWmmAPo6FFqq+0
         2SiHLPf0WguM8FSfvJf8XJIDOq0n9dNSocFmb0TK4VXmc84X+xOXWRSwiINKTOObQjSR
         KAR6VL1/j4t91cLmEIrRcuCf8s5WqrfATyneM/YIpdxinYKFs1LH7o3bsp1PaPGnRKyU
         yj+Z+Es8UkKxtBwBANyVZsaJJ4VVGkcxW1fq1eVm7BG+D/kY6EqWS+Qz1sjEFt6yMgvw
         70+cEq2od4B8YDgYGaj4zPqg6vU4AbAJ+mIwCJ8BOvlA9wSu1vYGNd13qnBS4pIpbP29
         KIsg==
X-Forwarded-Encrypted: i=1; AJvYcCX9E5HY7ZPf+FY8CTTuvwh53Jn8ajoiV3m8HqBBcnsYsy9/Gx6VtW8oiIHSgUmZKVmscLs+kJON@vger.kernel.org
X-Gm-Message-State: AOJu0Yyagf/kQKYwHCyVO69onLNIUjV/pSWyuq2gw5ZClZly3/RX9JIT
	nJDUvZg8Ef6L18BdDVnoGPskbqJoe3VB7A6s9T1G5vShxKNYWZo0OVNwe+DEPHvWCybEzBcpRxw
	UaVW0KroDX0bqEiEKTTYxmjb+YbhDtapRF5gc
X-Gm-Gg: ASbGnctdu2I6V0y9Qj09ULHD17cwXKd1AG8y0halIrxJBKfzhiqcrwVX/AsYIgxYKbj
	7ix5xCbMhkAGBWwhBkEF/1JSn2CUZ9Q==
X-Google-Smtp-Source: AGHT+IGZf9Ufu6lmucRt7TvdwRiCx/ju0CzwFj78lPAtpsAY0w7E1bc6weJToxADHqbrEl7qCsf7MHUtHtVvpxME59M=
X-Received: by 2002:a05:6902:2487:b0:e38:a34f:ff7b with SMTP id
 3f1490d57ef6-e395b8eb4d2mr1434280276.30.1732676613779; Tue, 26 Nov 2024
 19:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-selinux-clean-v1-1-68704e007f7a@linutronix.de> <CAK7LNATUnCPt03BRFSKh1EH=+Sy0Q48wE4ER0BZdJqOb_44L8w@mail.gmail.com>
In-Reply-To: <CAK7LNATUnCPt03BRFSKh1EH=+Sy0Q48wE4ER0BZdJqOb_44L8w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 26 Nov 2024 22:03:23 -0500
Message-ID: <CAHC9VhQ16jkY8qx9=2OJ-A-=9W=Sk_MThg2aqMWqDYrOj7Zzfw@mail.gmail.com>
Subject: Re: [PATCH] selinux: explicitly clean generated av_permissions.h
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 6:55=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> On Wed, Nov 20, 2024 at 6:15=E2=80=AFPM Thomas Wei=C3=9Fschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > av_permissions.h is not declared as a target and therefore won't be
> > added to clean-files automatically by kbuild.
> > For details why it is not a target see the Makefile itself.
> >
> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  security/selinux/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> > index 86f0575f670da66a9dc57e13a236d6a5551af38e..58129a7c8cfa08f9caf5444=
f7df776f41056b77a 100644
> > --- a/security/selinux/Makefile
> > +++ b/security/selinux/Makefile
> > @@ -41,5 +41,8 @@ targets +=3D flask.h
> >  $(obj)/flask.h: $(obj)/genheaders FORCE
> >         $(call if_changed,genhdrs)
> >
> > +# see the note above, remove this line
> > +clean-files +=3D av_permissions.h
> > +
> >  hostprogs :=3D genheaders
> >  HOST_EXTRACFLAGS +=3D -I$(srctree)/security/selinux/include
>
> Presumably, the attached fixup.diff (comment in 'targets' assignment)
> would align with the intention of the maintainer of this Makefile
> because you can do
>
>   targets +=3D $(genhdrs)
>
> without the need of the grouped target feature.
> 'make clean' removes files listed in 'targets'.

[SIDE NOTE: thank you for the comments/patch, but please don't post
patches as attachments, it adds extra steps to review/reply which I
find annoying]

This approach looks a bit cleaner to me.  I thought there was a reason
why we only included flask.h in $targets, but I can't remember it well
enough to know what it was or even if my memory is correct on this :)

> BTW, the NOTE in this Makefile is not true.
>   https://github.com/torvalds/linux/blob/v6.12/security/selinux/Makefile#=
L7
>
> Even if you use GNU Make 4.3, the grouped target does not work with
> the if_changed macro.
>
> With GNU Make 4.4, it will work as a side-effect of commit
> fabb03eac412b5ea19f1a97be31dc8c6fa7fc047

Patches correcting the Makefile comments are welcome, especially if
what the comments are suggesting for future revisions is incorrect :)

> IMHO, I do not see much benefits for using the group target in this case
> because you can still generate flask.h and av_permissions.h
> separately.

True, although a change in the classmap.h file is going to result in
both being generated; generating only one file is going to be very
rare and not something a normal developer would see.

--=20
paul-moore.com
