Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30631EEE6
	for <selinux@vger.kernel.org>; Mon, 25 May 2026 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779676143; cv=pass; b=H3m3/06ohen66FkS8A97v8FRlKeLg8HKhkAZb2/FsIYiK9tIuxR75TfiE5GePd6RwJZ/MZISCk2hWuUduB6FKxrylePcWVonW7hkCmiZW7hAU5LuRgqWJHZw40U6Q27WXQRt0u4eBxLn0LGiYDSc8hXgFfuf+kHZi3J7XBC1I2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779676143; c=relaxed/simple;
	bh=m+zuNbLfHxQfoSCgetCkgysN8KqfGoPlk/SB4xEnFac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H61wyEv8h/IUMaN/X9+wxhdS+1Ac1JtRQrWyPsTW5xPupbuymO+V3hC+nFjexX6IrMVWxXEmDRP3/YyjHfWFbnoGtjPtlzTuYCLsLFAhQLeSCjf8d2iMMBqLpTskQRN9KKdbMze08mpaKz40dzqrg4cfPGTd/qm5+W0VYUNLUac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYL1GZj7; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYL1GZj7"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-516d1ddcdf4so2461cf.0
        for <selinux@vger.kernel.org>; Sun, 24 May 2026 19:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779676140; cv=none;
        d=google.com; s=arc-20240605;
        b=Wzz35XgZZb9Xt6XX5zo5o9/kN1TIewLmKlwLW/WqO9TWz9IN2zGCEV8W3l3kTSD4nV
         qa1Ka2TdVJcvZwDfpK/jPHWawTeof0o7VPIXjg5tQ3fiIfRzQTB3+uB/o4bEdEFRLHIr
         Hw8miDQ4b/AZ6w84ysE4cESAdvsTuB3DiGRLuj+yTaEUkJ2BBUWKHrrAGEblkQIurppC
         9dUb5yIiTUGnkgPd6v7Kh3TX1GtnsSqoMN4sWaSm8ONO+KzzrrmMWRO6gA5lOVLrs1QD
         doI5XnY3vpZRs1q628yXOmFzV6IIY+MjSde9+rYG5XPzfe3FDLuYD/RMBjC1rw4sDJZB
         MrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OREPAh8IwIMgJsmZKDOj1MDV0zI3WTPokWMmXxSJ1Vk=;
        fh=5aqL2tXcD9ENLdTJkyQbLg6w2TOYgLm7OUxmb9gMGec=;
        b=K8L8lp3gLcz4PCYo/2KLbNa4ya7yifQmX/YOouwUag52zoddze4iSAbuJMXhcrrNW7
         wit+JDMOBkTRVyinIxNJRXuvTId1ncvKmlajQg0XdTHEZuszG6PIHSwoFvl2r/iDaq9Y
         t5SV0G0sBMPNBADkbEZ04r4SvxPR/xCvsw51VlR4RhR6syFem15TPXlRjzIGFmcgC1zK
         +MwVJsN/pE/rOBFohgJW/CFoJwX8xFqIkkD8UPrmF09+dVAOHwd1wVpC21kWrtd1R1+e
         S2i4X21sITtcmQ3LKsKSIf366T6drzeU2+VxDfpakuDcIdxH871hBOtKLSJBR/4LVmM8
         egbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779676140; x=1780280940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OREPAh8IwIMgJsmZKDOj1MDV0zI3WTPokWMmXxSJ1Vk=;
        b=BYL1GZj7loQt4p1Y6PJ82wIAHsjC6iu7ljcmAddJaLe6fum+9nvdrZKjqApfDHiZdD
         E95iMi3XO9Q16SQGDkrP4jhzCIDutuuqb7M/XTVYSbnt2atW85UkeoI69uFVnEBrwyOD
         o9NX/hwH0CrT9sCH11xnTpfRcCHfjgecEKrOeM2sRtItwbbziUUoMGGR6gKjynTfy4Rh
         Kkn2pzsehDd/PQMr6bRyyC0ei0taAhVThLex4xGm69/0Xjb2Qnt3zK7Z7KRn1zpeUcxk
         nTkBrIU6NDPiaWey6ogRVI2ouXunujbbo8Nild+AIsz1Di6eR5/6T9++xoC+qHGGKmDz
         dBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779676140; x=1780280940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OREPAh8IwIMgJsmZKDOj1MDV0zI3WTPokWMmXxSJ1Vk=;
        b=ApuWIymSRIeCjSEHqkflEd3kizS+fpJW2htkuiZi5UixDHZ1oM9c8+onZdsiRzDBu4
         cIuhoPWlSWb4hAPI3wmn6RpGdHgRu7gxNxHI/6OAso7YWigmMRBtk2d/beEqd4LpbMPM
         6TdYa4U5mwB9dYTHtbYY+PwHIVQwjl1LCsck+h1fmbE2SL1u7MF3oGoVyVV9tS6kVvUv
         egjoHio2zMOiWfJTwfvV6AJ0JUNu3fgli7cp3zmb322IX57FANvejAH0w6CJ6sD6pndt
         DqbdleoQT2CcrZULS8jIxIExsnjTliB27R8F6S5IbH0pc4FDCTKOW7k3eiQ3IBvlSng+
         k2PQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3RnUX2oeZkmk+NaNmMzhiBppZ63o8BlgN/yut3YBIGy8PI5ZcvTK3blQ5mZJhiVo3SeKUOlK4@vger.kernel.org
X-Gm-Message-State: AOJu0YywSKwhbaHZy52whQPmSdj/UR1+xQQgKmD9QhBNTHOgQwdjPTvg
	Z1XCzlHAMT/lghf+//M5MuJMdYop3ptlb5J3sSAdZy6vrBFhxnMSSDRh/XLvHYoQNI4fxGUXBbx
	6Q9jd1lHpnCEd4cUj80H/9ckef6pZQpW6Ag3cAm63
X-Gm-Gg: Acq92OGC3WPDK3f8kVBA1LoUQlGLKGUxONz9e5imztHjXYP3Y+INAPu6pfzsMSs0eSb
	XFvV6rotCCvB598PY6HMRG37hFLSlI2Oz1eGQpia+fD9uSxQ25381WboJ2IFSdNGZes13r2eCzV
	JISb8fdsNlqq5cOgcgOQLUYCdXENCvr+bS7PTsysHLxyB6A0d3ADnd9WIuB0mCFViVbPgmMYJeE
	T2pLpzC96gfjRaApejwnmDWc6TvfKqA45dRcLkcEhAPpnCeWZy//wSRgY6w44s59mDUmthuYd/m
	XzBS7jguSTopJCcXV+gtGDNuKxhOogprpn2O73XLuKAT1Gui61Gkc1E2s7aWtDY9ApJ+9fMJEHB
	3ooSqcEDoXvGO
X-Received: by 2002:a05:622a:1e08:b0:516:4f62:85e6 with SMTP id
 d75a77b69052e-516e1ec958amr15669241cf.17.1779676140163; Sun, 24 May 2026
 19:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320172446.96634-1-cgoettsche@seltendoof.de>
 <CAEjxPJ6QRisP9s2QBXvt73+s1KFAYcmtoLWMnOz=VPwDhT=Qug@mail.gmail.com> <CAEjxPJ79UwFyiDj=iZ+u4EEVJ8LjDhuV70wd72HWwU5iKmGvvw@mail.gmail.com>
In-Reply-To: <CAEjxPJ79UwFyiDj=iZ+u4EEVJ8LjDhuV70wd72HWwU5iKmGvvw@mail.gmail.com>
From: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date: Mon, 25 May 2026 12:28:42 +1000
X-Gm-Features: AVHnY4Kk11tvWkVnnPKMe_AK2UJE8ogZDS9u8pd2VWvueS7smf64atTGkCkykSo
Message-ID: <CA+zpnLd7-b+OMeFGeYObNjo=xLWuEN3wcT_KMJSetpXXmhXJgw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: correctly find partial matches
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:34=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 7, 2026 at 9:49=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Fri, Mar 20, 2026 at 1:29=E2=80=AFPM Christian G=C3=B6ttsche
> > <cgoettsche@seltendoof.de> wrote:
> > >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > The current lookup for file labels first searches for the deepest nod=
e
> > > matching the lookup-key.  Then all definitions of that node and its
> > > parents are considered.
> > > For partial lookups also consider child nodes matching the lookup-key
> > > portion that did not match any node-stem.
> > >
> > > Example:
> > > The lookup-key "/sys/de" will result in the deepest node being "sys" =
(a
> > > child of the root node).  Non-partial lookups don't care about the "s=
ys"
> > > child nodes "dev" and "devices" but partial lookup does.
> > >
> > > Fixes: 92306daf521 ("libselinux: rework selabel_file(5) database")
> > > Reported-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > > v2:
> > >  - fix documentation of find_all parameter
> > >  - fix linked-list handling: always add at the end
> > >  - pass child to the root call of all_node_specs() not node
> > >  - continue on <<none>> context definitions in partial mode
> > >  - add Signed-off-by
> >
> > Thiebaud - can you please confirm that this v2 patch fixes the issue
> > you reported?

Apologies for the delay, I was OOO. I can confirm that this commit
fixes our issue. Thanks for the patch and the review!
