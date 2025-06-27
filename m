Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB22EA17A
	for <selinux@vger.kernel.org>; Fri, 27 Jun 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041823; cv=none; b=n82Ts/su6b+IkmdbwJ6aHYe1R6g/WFaOJD0CXARIBs/5CSmYQTC+sVy3J3N9zap1I9jaFgU5ACr6iypqM1/dT00FiTLSTuzXV6FwQXxV3M96cUjVA3f514RLAmg90dZTVoLtwE7AIuMXaD0kzeCKNvDuwvO4Dh3Z2ApxPtD4MeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041823; c=relaxed/simple;
	bh=zZ2ocUfploeBdnT0B6Ztkruhb6oXav9WsXFPkTvn4Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rAFIAqDTaDSLRHVKU0Pr5Wos6KbbuuFpb89O6oYHSL7T0/aY06p2lwvwS36kSwDi3EafytLQmA8hL7ELm7BSjV4coikTjoJgT1JAkPiGN332vb28RlxTbNHZJPtw/LApGvhiVNXDUxtpmt6Ii9L4Y/sq1VyB0NpUTScgcv37PFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=H9S+TjHr; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="H9S+TjHr"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71173646662so442747b3.2
        for <selinux@vger.kernel.org>; Fri, 27 Jun 2025 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1751041821; x=1751646621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1PCb69vAIiy0/zs5HYXzkT97zTgqrGSfem3r+DCJ+g=;
        b=H9S+TjHrSv8ZCo0WRFVGDMt89hgbbxXHGQmBc0XEpDKxuWhEHosCdoWQY7kKMQG7IL
         JzTDRUnXCI4V/KV0cDrrhKeq1rPHoxaY/gVb46y7zU4HEHl7E9CjUU49aWdSKxF0qMzT
         aaNecSrg4cSf0e7xtxIJiMPvDnczcCjJxYBV00QqsN6jIMSzEYdKRhsijtbSfjyBGDFP
         MNTNdvR5PfeYcieYoBUDFUEwL/ejMKuK/ceKpCgCk7WDE4+PPHQOpSKX1mkJZLBfhlBu
         ga5OS5bVTXv7k9cxnzTHbo4RPLiZtD5xR55zou+uh4hgOffd5BM/JtCr7flt2EBqFh72
         pQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041821; x=1751646621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1PCb69vAIiy0/zs5HYXzkT97zTgqrGSfem3r+DCJ+g=;
        b=iUt64TKqjyqIU7nAcUOuEkU7qhaYrzg5W4p7aahVecQXayNWwEfT1qh6Ynklx0uQyx
         K++MjLh6PfVamKwTovylZ7qafmgtBBS7XBsNVO/5H+LmSBCItdndAYXjob2DQBtLcwCU
         6Ld2/KiChIeGRjyiPlKDFfuUgCihpez41uFuxc9dSbxisHnuIPZW9bZrcYzelcy9znug
         NISjDKX82/8bW7ZTIdnxG9aVjJBk4ovFwiNNSUAwk6XHhPhqSJ2iomAOaIOSuw8zbGh+
         fNER4yC5D1Ivh059G8pOYUWXx0jKMGKTnQ/BIFQPIyyCtYUSciur52Q10gs4jK/gLJix
         xrew==
X-Gm-Message-State: AOJu0YybYlW9bREy5g3CRgtP+j95gRcRxwzFRvmpb+AKEFoP5m5+uEea
	Ts6gDH7s8cq5GfAuWLtIfAnZ6UsLFD0uTHp5nu0Mswbyveuiuse/PqzDwrZJPp9B/BpqRC4koxu
	01iYRGBoKz4o5Pv1hGWw/SZBqle2eDao7RepDkQ2PzBf7pYJWsNs=
X-Gm-Gg: ASbGnctsOJVT37aKKotQU49zU2H3+vKGesOb0QmSlVQk9443FIjHxpvsUYpwT3MMREs
	vOV6fs43sG/C5DWbQpgiejPhc8p2K0qKYj/BQ4JOwLV133Na1AlYRA3Jt4YxVHXNA+rbyoYaCgq
	4gPPQMKK+66nclJtsvr5f7oTW5+XM44I+Q/XHpPR8yREs4NFZVIoiTpA==
X-Google-Smtp-Source: AGHT+IFJnNtbEWP7bf6kiwRqrYiOzSAv1aMS9koRXyxcOfLBtORr1sAFW0d7ogDY2L2aFIeeZqm+olGZ92NC3g0WeGU=
X-Received: by 2002:a05:690c:7343:b0:712:c325:2965 with SMTP id
 00721157ae682-71517196203mr61434297b3.20.1751041820717; Fri, 27 Jun 2025
 09:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626155755.21075-2-stephen.smalley.work@gmail.com>
 <CAHC9VhSMC1Kvj4RtNXUB-Yc87Vdifb-G1009LDhmy55hkW9Udw@mail.gmail.com> <CAEjxPJ7V+HtHCX0dot7ZNKD+tC0a86OXuCezk6yMo4PvNRccSA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7V+HtHCX0dot7ZNKD+tC0a86OXuCezk6yMo4PvNRccSA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 27 Jun 2025 12:30:09 -0400
X-Gm-Features: Ac12FXyQE74Ox5WASz-MroAuOkQoIOg_UKvg0H4BgeZYLv_Itx4k_hB2AogBKSM
Message-ID: <CAHC9VhSXFDE+QvbKKPCm8ibPfsRELvuSHvt1jG1CXp0v-+qd3w@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add my email address and GPG key fingerprint
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, jwcart2@gmail.com, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 8:13=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Jun 26, 2025 at 4:34=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Jun 26, 2025 at 11:58=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > ---
> > > No hurry on this so feel free to wait until after final release if yo=
u like.
> > >
> > >  SECURITY.md | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/SECURITY.md b/SECURITY.md
> > > index 4f624f5d..2fee4927 100644
> > > --- a/SECURITY.md
> > > +++ b/SECURITY.md
> > > @@ -33,6 +33,8 @@ the issue as quickly as possible and shorten the di=
sclosure window.
> > >    *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA=
 62AE
> > >  * Paul Moore, paul@paul-moore.com
> > >    *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA=
 7C8A
> > > +* Stephen Smalley, stephen.smalley.work@gmail.com
> > > +  *  (GPG fingerprint) 5073 3D29 EB3D 5CF7 17AB  32FE 100E 57E3 3B8B=
 54F2
> >
> > I'm not in front of my system with my full GPG setup so I can't verify
> > this, but we should verify this key to ensure that it has been signed
> > by others that are trusted by the SELinux project.  We want to make
> > sure that Stephen's shenanigans are actually his and not some other
> > Stephen ;)
>
> Happy to confirm this in some out-of-band way, maybe at our next
> project meeting. Unfortunately couldn't do it in person at LSS-NA this
> year ;(

In the past we've handled this for other SELinux devs through a key
signing "party", we can follow up off-list.

--=20
paul-moore.com
