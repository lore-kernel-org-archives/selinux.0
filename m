Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178B199238
	for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738074062; cv=none; b=K8FXtyt2/Bs9hZqGVq1LqcewD/qD3hy4Ui1TqXbh19qB618TChziBwCxqQOua0hpC7UxWh/GScTni945kCUzW6Lu60D35TzpVaIjEUTl4Ns/qmO+XLoJNCTVpRz71J+ifWFBCJCFdR6IYaQhRpaBG1qij7m0RLtajap3m5I6NS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738074062; c=relaxed/simple;
	bh=D9oaxmNhn8bPdVAIadKxuci7iQwJYkfAW+dvYSZC5Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THMzxQaRUcCZSpIXqEPxcrj/QbTUkAxl3RSAWgTNcFMphdWP5m9ojAbbOSM3P7XAuq129VlCeFYr1efQqIobKoz3v6EHA+oJj7y4XOX2HBA/eukz6XPn1epPMzUw6MfkvJF9F7Vn/r95rQAHSF19TdQcwU/FfZtqJCslqDV5VHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z++VAZR1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z++VAZR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738074059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDtwGzyLUhFclHuJegL5qQB4wHn79dxySq4hBsimLtM=;
	b=Z++VAZR1sJUmVLUYJ4UEmWQdSxgtCUa7EiKesGUn4d1F4kjUC87Bm/ck7oADNZz5NlJPwD
	s1UCE0BSR6LpgWz8tMnVtuSW44hou4LXeHEWWw15eTpFv3PWX6K433HSGBOXa7fCNpkqt+
	wrwMakIG/6R3Xe7/Xp2dgpjpAwaOCbA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-tneogSSMPI-c-Ox9AKKuuA-1; Tue, 28 Jan 2025 09:20:58 -0500
X-MC-Unique: tneogSSMPI-c-Ox9AKKuuA-1
X-Mimecast-MFC-AGG-ID: tneogSSMPI-c-Ox9AKKuuA
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef91d5c863so11650327a91.2
        for <selinux@vger.kernel.org>; Tue, 28 Jan 2025 06:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738074057; x=1738678857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDtwGzyLUhFclHuJegL5qQB4wHn79dxySq4hBsimLtM=;
        b=m57iEuhjmpNtpilfRaywOS5yZg5IPNBLqgOl+uIX3XN3THIpcL1Ktnl+zKlMtRd5cT
         HnmJBmr6uMQAfVx/rssl75Bp/rY8wQ4kwE1yH2qwkjUIBA2Gcoh0Cz2r+b6h7i9lAuOr
         azzWVbZj9GwKrT7QZ8JGm2TYragLEVVM7KFcpDpvniTlLln6xCq6R4lUJ9KxrTuk0+0X
         Rih5aaWlitVbMA4aKcGoa45QEoSpuMSfJ9l+kVfAJhwwF/2yzFcydy0Neer1AO4+Mb4F
         N79lZVY10+8aaa1Bf3BLlwJExE3tR+SYNwGyRXroE3XqUjBgDf6+Vptd4wZIM9CtsHnJ
         Gjig==
X-Forwarded-Encrypted: i=1; AJvYcCWbEwi1AUvRtRgaNcEASaHiuM4+8W2S9cx0iH4z3upX4UX1tSFUwUf54NBSWEXs2IWPYLFox2Ik@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qRGsElASkCJ3+MaS8Yxp5GdoORl1gt/mRVJ9Fql4B5k1WPCu
	xbJGxwmyHadFDr8Sf+8U2FIaezOQMukp/mGkJfAqT6BkZTuWVtKqojGHekoVznMZnQnMqTe/8+Z
	4pb4dvGtkrj4X9Ooe1xShcZvikl1rbXQ9sVRP5WtE1MDj7ao4rOzXO2/igfhMY9zaYxzNvBfwrj
	yI3bz94CF1oDFu7IMAODqzqjkxkYjxfQ==
X-Gm-Gg: ASbGncuVh6id1Vc8TpsHAia7AeNva3rKex+zpQma3uDa/lFHFm9fRF3sv3+5dbloXVZ
	3Ocg45JpozhnhMDi/py+2ygLS8+7Pv8gpUO93pfsXiWltxFjbzT9ORNtXCe5srQ==
X-Received: by 2002:a17:90a:c888:b0:2ea:37b4:5373 with SMTP id 98e67ed59e1d1-2f782c6ff50mr68022153a91.10.1738074056984;
        Tue, 28 Jan 2025 06:20:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLkoSVP9en9QzpKcY6Xy4YZ+5p8cA8G7GD7Vv+4m4AfNhzz2DAH+n7ciNQzuMlQSBYd+zt6z1HhcoTe2jxAzY=
X-Received: by 2002:a17:90a:c888:b0:2ea:37b4:5373 with SMTP id
 98e67ed59e1d1-2f782c6ff50mr68022124a91.10.1738074056671; Tue, 28 Jan 2025
 06:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com>
 <e8b6c6f9-9647-4ab6-8bbb-ccc94b04ade4@yandex.ru> <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
In-Reply-To: <67979d24d21bc_3f1a29434@willemb.c.googlers.com.notmuch>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 28 Jan 2025 15:20:45 +0100
X-Gm-Features: AWEUYZnKMKSPkvMHSDBYDNT5dz12aid0Wz74BtrYevaWtBSeLiLEN3niiqklU-U
Message-ID: <CAFqZXNscJnX2VF-TyZaEC5nBtUUXdWPM2ejXTWBL8=5UyakssA@mail.gmail.com>
Subject: Re: Possible mistake in commit 3ca459eaba1b ("tun: fix group
 permission check")
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: stsp <stsp2@yandex.ru>, Willem de Bruijn <willemb@google.com>, 
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	network dev <netdev@vger.kernel.org>, 
	Linux Security Module list <linux-security-module@vger.kernel.org>, 
	SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:50=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> stsp wrote:
> > 27.01.2025 12:10, Ondrej Mosnacek =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > Hello,
> > >
> > > It looks like the commit in $SUBJ may have introduced an unintended
> > > change in behavior. According to the commit message, the intent was t=
o
> > > require just one of {user, group} to match instead of both, which
> > > sounds reasonable, but the commit also changes the behavior for when
> > > neither of tun->owner and tun->group is set. Before the commit the
> > > access was always allowed, while after the commit CAP_NET_ADMIN is
> > > required in this case.
> > >
> > > I'm asking because the tun_tap subtest of selinux-testuite [1] starte=
d
> > > to fail after this commit (it assumed CAP_NET_ADMIN was not needed),
> > > so I'm trying to figure out if we need to change the test or if it
> > > needs to be fixed in the kernel.
> > >
> > > Thanks,
> > >
> > > [1] https://github.com/SELinuxProject/selinux-testsuite/
> > >
> > Hi, IMHO having the persistent
> > TAP device inaccessible by anyone
> > but the CAP_NET_ADMIN is rather
> > useless, so the compatibility should
> > be restored on the kernel side.
> > I'd raise the questions about adding
> > the CAP_NET_ADMIN checks into
> > TUNSETOWNER and/or TUNSETPERSIST,
> > but this particular change to TUNSETIFF,
> > at least on my side, was unintentional.
> >
> > Sorry about that. :(
>
> Thanks for the report Ondrej.
>
> Agreed that we need to reinstate this. I suggest this explicit
> extra branch after the more likely cases:
>
>         @@ -585,6 +585,9 @@ static inline bool tun_capable(struct tun_str=
uct *tun)
>                         return 1;
>                 if (gid_valid(tun->group) && in_egroup_p(tun->group))
>                         return 1;
>         +       if (!uid_valid(tun->owner) && !gid_valid(tun->group))
>         +               return 1;
>         +
>                 return 0;
>          }

That could work, but the semantics become a bit weird, actually: When
you set both uid and gid, one of them needs to match. If you unset
uid/gid, you get a stricter condition (gid/uid must match). And if you
then also unset the other one, you suddenly get a less strict
condition than the first two - nothing has to match. Might be
acceptable, but it may confuse people unless well documented.

Also there is another smaller issue in the new code that I forgot to
mention - with LSMs (such as SELinux) the ns_capable() call will
produce an audit record when the capability is denied by an LSM. These
audit records are meant to indicate that the permission was needed but
denied and that the policy was either breached or needs to be
adjusted. Therefore, the ns_capable() call should ideally only happen
after the user/group checks so that only accesses that actually
wouldn't succeed without the capability yield an audit record.

So I would suggest this version:

static inline bool tun_capable(struct tun_struct *tun)
{
    const struct cred *cred =3D current_cred();
    struct net *net =3D dev_net(tun->dev);

    if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
        return 1;
    if (gid_valid(tun->group) && in_egroup_p(tun->group))
        return 1;
    if (!uid_valid(tun->owner) && !gid_valid(tun->group))
        return 1;
    return ns_capable(net->user_ns, CAP_NET_ADMIN);
}

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

