Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C1F359705
	for <selinux@vger.kernel.org>; Sun, 22 Feb 2026 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771793082; cv=pass; b=YfEmGAsxfBTRdGJKx/6ZtEpKE+ZBUuTAX+2Q/0mzBUiK4Z6+26Vb5iRtLOx8sS32X0sHCExoZMkP5ELwNmUizut3XSpmFsY4YvTAORq505Aytl4nIpeVe1Fj+0g1HhciE1rPvwWrHj4xN9oZWRX2jX7RWP8ooYhszoZwR/BiiMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771793082; c=relaxed/simple;
	bh=hp7f/xcQLM4YKqC46AX9x0C8T1QSRpBd0PokasCrG+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF2I3xrpxgEau8CZ9nh4kHx8BaN2QvWhgCUFQk1qLuglAZBp3khdqSL6x9hD/K9RX/uEVe9wZIP19OawInykI6GSRvTfm3yrm+d/aOpfcpKQ7cURUJUUAYr9RxJEaBFY/7vn2xYZOgl5gkYkXSuhUqs14t0JOsFB3cV9dCAuAo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y460imou; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y460imou"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad617d5b80so21809775ad.1
        for <selinux@vger.kernel.org>; Sun, 22 Feb 2026 12:44:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771793079; cv=none;
        d=google.com; s=arc-20240605;
        b=fF2wquEY30CCyNSlOJMQRIh2+zajUfa3j68CYoPaH04nUyNEJ+ey0fj4zceu/VC0EH
         SLikHsjyKlDZYXOqrgCx3CP4syWOCTbf+o2+Sopos9wdxvc1OsBbwm5vfHWjVfUEgo5n
         C52Tuc5s3KLvu7CsVLGyirTeYNB+TmOkiEluzbF3wwBhfXBZ0AsULOg7ziFUO6FLYSqi
         3t6d1vTZFdli2AWlthKVjCXtfzubcOlaTxVhtSHN3W13ymXPkKzyvReSwO/WY+P09RcQ
         7Ao9vuzbMK7xbE3sXeU8ig3TlmnEGqLtKAFpZ//ALs5NTI9aRnLIHzV0CnIVwDz4yHCK
         VSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SZS3ht6qpZxvXlxvBozprXgo1676sf/FcqaXKyi4R0M=;
        fh=LDaLhg2osnCBQwY7XCvvmAvWYvF+t2wkN4zG8asxRy4=;
        b=AvCK23yEikY0l1RANxI5Y2YyUSnvjYgipdTzDbQQKtgc3TRPvLXg3mL/aPA2j5tUjY
         D1jwDtr2QI3jcMaMAj38mHbpxH3XcAXgLDx62mV+5+EKj6Amdt+RifpoJuVkWr34OSG0
         C/ye9xu099Ao1lGvwARPE5X0nrC+5WpsGVBhb0fuCLRsyiNYvpmxOJdTGhR6OVtatMC2
         /DDs/naRTSyXa6rutQw9XZQme4g/hfM5xNkJ6Zbos8JpN8YGDsZAFzrsp6xd9f1b0+fc
         jrSqvmYETUKIZGWcyc8ujqXhnMCn37ygohjwjuc/8HsIPl+r34okJ7emgbdxDGzHrs1y
         yrhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771793079; x=1772397879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZS3ht6qpZxvXlxvBozprXgo1676sf/FcqaXKyi4R0M=;
        b=Y460imouQRWnRkg4aeW4mXXIInl8JrXhI2L2st6sInuLFIlBhiFosX1OMGoUAhEkVe
         uVomRuUsqjEgFbzjIxciRZO0hCyQTBGc+DpjtPuEe20QDxm+rbTqp2pa5M52/5aygnQK
         xr6sWLF2oCuXSM65vtMHnNRjRScbIS1WTFTLwSuzSz3BPQTapLczRsotfjmOdttMFWmg
         WTi/U/rMTGHIWfzj1EPlarXetNAyEY58rADg1Xol5uydmjcmeZSlBgs8hZ4Egg+PnTgf
         XyPd/aUstU3bVSXxkCFkc9r1IJdxw5jElEmmXcR/z8uMO5LrgEVtsWL71WeslrJIMrdz
         GjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771793079; x=1772397879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SZS3ht6qpZxvXlxvBozprXgo1676sf/FcqaXKyi4R0M=;
        b=bj72VWRYRJ5QKPx4W/5rATvsLN55ZPQNsplwk/h1iuEYa1bB1yVHmAwHZWUDdn5M9G
         p64oCLC9uFJe0BwJ5anAF63+pvEmrTvjr8/uZI16P0mIFHPqPrysxd6n05UvvAByfBaZ
         zQul7OdtXXKkaWXyC/V488O8mKsXt9Elp12c6oMyWSdCmBU0W2URbluQ7lCDAxDdQhny
         SoyXU80JCOjIqlr9JDgKP4a/aEvXCR0rHoV03J/fg1GwrcWi8llFyC6R5FwPVeRCfvWG
         nyaxlf+l1+SPrHMlzbcJidAIxusGAoVbyWJPp7uukUun48oeEdq84g8KJivmuOeT15TQ
         LPWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6roVGrhMNst/xguwWC0HZvEC0zIpFDv87gfXT1X4m2aDgeFnCvyTo9sVoJN0ZMeNUnHosUJ89@vger.kernel.org
X-Gm-Message-State: AOJu0YwWKn9dBRXbOTQdfn2BjtbUp/jd8qcALU/4WWDo5s4tGXuRb1IJ
	O0qlwLRuSZHPIvQ5ssVtRLkbiu3kd8/QQT43US6oFVs+ybEv9aU4e0QrvG0m5nEk6sRmFG9r4os
	jFje2rfd/SM18ggt/9E5+4/B4lkxQ/+HMvTnpRVDZ
X-Gm-Gg: AZuq6aKyeAlZeML7R5mnG4jY+MJfZCAai8CwHYSEmD6GMqPwYBezXon5FjfgNn4BHcq
	dhJz1jWDOdyuq8R4efTvh5Mi1/RKmLXmQq6j6Cav5mFkfq1htUdrCzjtPR4MluxM1B20QqHYjeJ
	NUs78ZCUw8FTcuuNOlDgrbXMLRjy/wMop2hThmuea6IuQqM4twPs9922gyYUYLUT/sQrZawY13h
	ktZd801Um55VXCDigbks9iXvoqatInTPft0ng+DvzBbgxjmAwwO1X1DO2FmvIAlKPBAMhgEiJT2
	S+t/rwA=
X-Received: by 2002:a17:902:ea0f:b0:298:485d:556e with SMTP id
 d9443c01a7336-2ad74419faemr67616305ad.11.1771793079051; Sun, 22 Feb 2026
 12:44:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122140745.239428-1-omosnace@redhat.com> <CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
 <aXgZI1td0Hremulj@mail.hallyn.com> <CAFqZXNve_7oKFWydUrskOcvsfbRZVKyWRmLvHKsTzBhG+RmEmQ@mail.gmail.com>
 <CAHC9VhQOW4BQR+UCvrcXa_yiSqADN0HC2Xp0pMKs3FtnjcVaOQ@mail.gmail.com> <20260222115824.37ae0de1eb183997a23669ae@linux-foundation.org>
In-Reply-To: <20260222115824.37ae0de1eb183997a23669ae@linux-foundation.org>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 22 Feb 2026 15:44:27 -0500
X-Gm-Features: AaiRm529BwI7MTcZeMtMwIdjiMFYT8r8qV_tonLYGDsJ05o-JBxp1asG2tQIdao
Message-ID: <CAHC9VhQzjCrLv7c5hsumkEzM5jfDVn93dF4tGkKqGzeJnNuCXw@mail.gmail.com>
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 2:58=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 27 Jan 2026 17:09:40 -0500 Paul Moore <paul@paul-moore.com> wrote=
:
>
> > > > > > Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> > > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > > ---
> > > > > >  kernel/ucount.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > > >
> > > > Looks good to me.  What tree should this go through?  Network?
> > >
> > > Andrew has already applied the two patches I posted into his
> > > mm-nonmm-unstable branch, so I assume they are set to go through his
> > > tree.
> >
> > Andrew, any chance we can get a reply to these threads when you merge
> > a patch into your tree?
>
> I already spray out soooo much email.
>
> A better approach would be for me to become more chatty.  Reply
> "thanks, applied <reasons> <caveats> <etc>".  Shall do this.

Appreciated, thank you.

--=20
paul-moore.com
