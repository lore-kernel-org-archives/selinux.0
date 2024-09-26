Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202C845C14
	for <selinux@vger.kernel.org>; Thu, 26 Sep 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727315137; cv=none; b=mdscAb+kHK3rLpx/+1fkMI2tXPeczkmVEx+D7BPY/3cOk5mt/uZK8GSIzNfKB0aeNT3zRFZDJd8tj3hLAbR9IcpGGDuWL1Yk7HVLcDZkET0CF3cTz++PUcq3b+w0o375J2yUzQoG/tlIq1ve3BldMmFXeKhtP8D5U3WhNR8eRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727315137; c=relaxed/simple;
	bh=cuQeBCVyuiywoKV97PGQo4VFskW407lWuvMlFcHCr9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUgG7/kjYeA/1o2fh4DSWuzsZMmatbENKZPyTuNeZxFJAjSN/ggGbWm9tzqZ9mkF+cbTzjyqEIkJRQZA15vJxHpOBrwSUyAwvsRfLkwQRLkrV35C/Mm9T3hMF+5oIs8kHfSv63DdcWR2N4ynpe5iEU2N3NvAkChJZ0Oizjn9jsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UHLyyNed; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UHLyyNed"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e25ccd64be9so267739276.2
        for <selinux@vger.kernel.org>; Wed, 25 Sep 2024 18:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727315135; x=1727919935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj3dbVFoIjA6OZo+c01uuZMxEebDSFAuk5/Ez4G7BQk=;
        b=UHLyyNed+iCY8LijM3KWMqzA6Y7J/bCZV7i2e1d36UuyoWDLfUyaUuyUtleq7I0qf/
         agIu4GAht/UBMHBtjZ12QJbKx/LSrXSwquO37jviEe/8trWs0Zr/pmZyAYRxh4sssZR2
         lLjcVKpzPFsFVNuS+iBhoVdyBGAHfcNs3sPAjgzhmhJmNDTNXHWtbrz3ASmLpdOH2vGM
         iy6InNS7EX5sODTWcILj8naFUEI4msgNVo0cRuRMngY9dMvMniAJ9OHBFXIAc12SeDPl
         rYj9ZhXiOB2MtzZvSzisKjQhz5faes0nztWkvtuc6SGDEaxl87P3L3Lt8oAR8dBmYfsZ
         CZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727315135; x=1727919935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj3dbVFoIjA6OZo+c01uuZMxEebDSFAuk5/Ez4G7BQk=;
        b=ikgKZO1n1oF54gPIDaoXO4Wtx0x06wrUDUqiJi0PHsx933Uc+iWbR0JxXX5p0ckixo
         EtBEhhFXUQAYvLCG69ZZvWDZQ/FwyHrDu6C+r48QXn33LSXI6NB19leH4m2xnXceo9VW
         2+kg7Pkmhxcg3leSCOoNmnJfkpnrq7aEFunBcPyAmQPButVU0d03ss3HFO53kOOByDSp
         pcsqgIynHuSUQn2mBWJGGGghyuwNY6g9afsOYRRoMw36rsvsx8cAbjaFFdtYlejQwM49
         5mT23CkkAZVTbWFwOXX4iLzRO/wsiEUwNTCRlmobN+PsMRKymAwd1ZYDB9+GK12crpdD
         JwIA==
X-Gm-Message-State: AOJu0Yw57chd5bUiEUonFANJPFTQdAjDJp7NohqkBItq4GgEaxoxjtZ0
	MxQ7w8BbJAS0IAbBAA2xetXTPNC9Nhk/C4wws6N2JrPzNOW5pz5tPitypndY/XV+0Hzs6xIpIHj
	tsSwA5kZiygOC+/H7VzjCopl+jGl4M+pnQqtVXE7G86cy63k=
X-Google-Smtp-Source: AGHT+IH8tfAsXGzUpYzw8l/uO/AsAP8jsMVmEMQgJdF1tIVuVmc7a1CD4hLA0RxCUXZz0doID33a27Bz4kRBj+pJWLc=
X-Received: by 2002:a05:6902:70f:b0:e22:6382:d1d1 with SMTP id
 3f1490d57ef6-e24d7823fa9mr4012794276.11.1727315134901; Wed, 25 Sep 2024
 18:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925201106.16134-3-paul@paul-moore.com> <CA+zpnLceV4b0ittytzn3OHw+b4h2Wpa76LSyjsjZkz-xtoHhcg@mail.gmail.com>
In-Reply-To: <CA+zpnLceV4b0ittytzn3OHw+b4h2Wpa76LSyjsjZkz-xtoHhcg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 25 Sep 2024 21:45:24 -0400
Message-ID: <CAHC9VhTSnK=E_HCFJbsWip35TpqDAMSbp6MhsFE1jNy=CfCA6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: streamline selinux_nlmsg_lookup()
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 8:48=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
> On Thu, Sep 26, 2024 at 6:11=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > Streamline the code in selinux_nlmsg_lookup() to improve the code flow,
> > readability, and remove the unnecessary local variables.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/selinux/nlmsgtab.c | 90 ++++++++++++++++---------------------
> >  1 file changed, 39 insertions(+), 51 deletions(-)
> >
> > diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c

...

> > -       /* No messaging from userspace, or class unknown/unhandled */
> > -       default:
> > -               err =3D -ENOENT;
> > +       case SECCLASS_NETLINK_AUDIT_SOCKET:
> > +               if (selinux_policycap_netlink_xperm()) {
> > +                       *perm =3D NETLINK_XFRM_SOCKET__NLMSG;
>
> Should it be NETLINK_AUDIT_SOCKET__NLMSG here?

Yes it should, thanks!

--=20
paul-moore.com
