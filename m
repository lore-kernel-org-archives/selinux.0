Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD13876BB
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508429; cv=pass; b=bJ+SJqSRQOWc1ATllPLmdp1z8yQztoJind0bfBAe5sXEjzAH3ZuGpWPSIUA+DS1TtMVLfrNI3a0YyCF5PlbmCPqGlWgLa1v+70DnA3TXVd3tAJYfyCqPinxabFBL8E/7+CwrcQQGkr9SoKWAz+dnJP2EHB7ze87viAeO9WEk6Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508429; c=relaxed/simple;
	bh=B4rm2n9bkZJZbYTVAiewnOQ5BwSCBdnF2JacTEh3hM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fkKhe5MJ+/V/6mR46YQ4nhalTVP7DMDsXGEA/omhE8J2yKxAzIVFzisZTGwHmefj6cH41ZQRqXCpzuMzRaLxXxv3wHdIEWgm0+Q4ZvmMDW4tARVoaAWlfI3mXP0nwNKYQor44fJ3JnjHGbA95yjtpyjmCV6LgYGkGTjg9tAVOkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Qf5rLs7Y; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qf5rLs7Y"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so3135125ad.3
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 14:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789508427; cv=none;
        d=google.com; s=arc-20260327;
        b=a8pXPd9m9pf8dyhryp17NmxkJ9hqtmJjMmcMNTHAdBSUZ/2L53WvQWAilmhAWoeR5A
         ZvGhE9a7VhyU5TzTa8q9W3GszMJ83OiPP+B/GqsboAnv5LglH/dJzh1yAj7vETY+YgW7
         /k8UIJEXsDQLASlifhLZCUAMK1q0cgX0vrWc2WzDMr80WCJ6q3FzQ9Nb41hWzRjVwpmA
         8v6SUSnxCbw9aKhfNmP3ITntuNxmcvFKTaiRuuO7bZoK5YAAACPwc1cE0WTv3LOSPatC
         C5TqIFfzNrCmuiIEgHElw17cNjQvxHa6d/oHwwRqfUtdU3H3fdUJCgJlWnxdFq7IYebn
         ZX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tf2DDHiSLUuWU4s6Fj0OpIRO1A/JoEg2bToB3dREFOs=;
        fh=IkKXHB58cVM2UxWr1Ec2stsbddXAXJscCpVjlv1TnJk=;
        b=JwWZLwQACQha3oxONNtcJ15GmaMXlEyC0CIYuPT08CoVO9dmlQ6huZpH0+jpoza90+
         utr8NA6t71C+UDXy+mU6lqe14QoD5TdM3U+v+2LhGV1aIyh+r168l+yNdg4rF+JOrRzG
         RaaycldBWjoIDVKFH+o/2QcZDa1gIaLyBDeonxkAaMOSEWst+9n7VwyhOJr8b/yeZno4
         nWSbWfoHD/hQTGXbMNA8Tr8U5+OCbi2c7NCShGJohdXIJdsRkS0EKPsLqJPsby8aHvid
         LD8IhgsekfD61/oQZeu3NohrchKyZf1O70IM/saJ9ZK4Ps0ImKUkhyPkVWA5svgeH4z7
         VoSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789508427; x=1790113227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tf2DDHiSLUuWU4s6Fj0OpIRO1A/JoEg2bToB3dREFOs=;
        b=Qf5rLs7YgypFzjotuw1km2vr38WPeBwCSdKt9JpkY8JwPbBrf4B+fSWQllPhY8rqhl
         q1Lt+sJCRiehPT5ToA1MW/13hInq02t+HpUbvXNVAI72ComrivyepYsKAZYuctw60M2r
         FeoDSwsj0+SfWdlk1203ERYxXYbukUUM6TTIC7x9H0GzGcKTnQc0QEmQC6lAaPaptP80
         BPRZDH621h+nGRMTOlbmMKoSCYIxXFywKqv9vXoshu60Ype9eLAdMo/tqG9l6eqkEGCS
         HBl2ws018B8ndrWt9OvpM15cS8X0BbAi+YUuAPj+mL/0OYtuLrp1Yv9Bra9u1n/36mSj
         ObsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508427; x=1790113227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tf2DDHiSLUuWU4s6Fj0OpIRO1A/JoEg2bToB3dREFOs=;
        b=DfU8uxtIuNafgS8N05+H1wSufHrtt23xpvtrU/UYz+liGs8PeJAij7uG4jMzzCj7n2
         ZjtudptNSXhxidifmLnxfqbgpgmYxZvrZ3CCltNHA9Y4YyIFp+DpkRZ5QziqS40lxH3S
         fnYQpaK0WTkeDg1/LiHJn4HJT/CQSnAq2K7S8BA6O5LzNUy2X/4Wv5VrjpExpv+IpPWA
         EIlTOUyUgumdl5ZI6V0ydOJL6JcxkE0VHvIUPgNjfW4juw7lGC9qQRswFXNLSUQhv0vl
         mX94SPJNDC66JWhPWlYvyi18YF44qnLQ65UDH3CW5Dlr0KXmgJeP0dUinIMAaxgd6Apd
         oa7g==
X-Forwarded-Encrypted: i=1; AKwUvBxOnMfSaTnja+VU8PN+gs/RKzAVfleb6g29aB0QqhJdhaAx2qXVZs6Mp57Hk6E9oV5Y+6Pz/XKn@vger.kernel.org
X-Gm-Message-State: AFuF++laTqOsM+cr0Vyk/3WxV7PG9adCPS4hlZCdE4t5QDPCPAU/DtXa
	NxzxUu/2epFaQgBnxnaHFEvI6Et+D9Uv58+cROVbssLt1+9AbTiuku5NZJ6wCg7370iQnUD52Y4
	urGNtFqbnpNBtkkg+UJKtak+09nQsSLBfw0kkMdAq
X-Gm-Gg: AYBFou0plSllbQG+qf0FSCl2PyRcc/dMPazPlSHdIb7hPXinpSCoNc1OhFgdnYw9JF2
	tyWaTGcNy0AnVnYsGVwlQp+ikJ70YkPkOHzj9n+b7F0k1KuacNfIxYeSKPPt/gHlA0j+sQe7xqa
	pkRs7yBYlo0dEkGYByGSSZtInGqNG/yma7RIIgU8xXSWesGoLPTB+UbieJopIvPX97vNn0p2naR
	rNwnytLFbw1YXSf1tICmC6LqnANDg9j7iArlgF5Ry/RO6tEr0F+i777T7uQPFP92Tb4wZMUVFYq
	UBoeWIopLT0IsfyXZ20m3Xgqpkfu2eRyaon+WMb/vHOWO5FghzWJzhSqtGxYRpz+22Y6RBhnscF
	pD07ZynRg8TI=
X-Received: by 2002:a17:903:1983:b0:2d9:4871:393d with SMTP id
 d9443c01a7336-2dd8e77e51fmr2057485ad.21.1789508426906; Tue, 15 Sep 2026
 14:40:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915195728.3519469-1-arnd@kernel.org> <CAHC9VhQwkwrEgnuyP-u_NJxmjgy3Zp9XN4cAqCMqH3ugV+jrsA@mail.gmail.com>
 <5a285431-9b60-4d87-87c4-a5b52021ea65@app.fastmail.com>
In-Reply-To: <5a285431-9b60-4d87-87c4-a5b52021ea65@app.fastmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 15 Sep 2026 17:40:15 -0400
X-Gm-Features: AcwNN1XFRHlUUDTBceDCE7_aMUsMY6ed2e061kcuq0vG9XSfwVJaXL4EmZTGKQY
Message-ID: <CAHC9VhQH16yo-w1kGDTyQw5S4a9+04NwsC6Mmp1LP_X_kti6Aw@mail.gmail.com>
Subject: Re: [PATCH] selinux: use explicit 64-bit division
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 4:43=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Tue, Sep 15, 2026, at 22:36, Paul Moore wrote:
> > On Tue, Sep 15, 2026 at 3:57=E2=80=AFPM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >>
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> On 32-bit targets, the division of a 64-bit integer by 33 causes a
> >> function call:
> >>
> >> arm-linux-gnueabi-ld: security/selinux/selinuxfs.o: in function `sel_r=
ead_class':
> >> selinuxfs.c:(.text+0xdcc): undefined reference to `__aeabi_uldivmod'
> >> arm-linux-gnueabi-ld: security/selinux/selinuxfs.o: in function `sel_r=
ead_perm':
> >> selinuxfs.c:(.text+0xed0): undefined reference to `__aeabi_uldivmod'
> >>
> >> Replace this with an explicit call to div_u64() and div_u64_rem() to
> >> annotate that these are potentially very slow.
> >>
> >> Fixes: fc68b6a45f16 ("selinux: convert selinuxfs inode numbers from un=
signed long to u64")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  security/selinux/selinuxfs.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > Thanks Arnd.
> >
> > As sashiko pointed out[1], since we don't really use the full 64-bit
> > inode space, what do you think about the following fix instead?
>
> Ah right, I hadn't checked the actual value of SEL_INO_MASK, and the
> description of your patch made it sound like the 64-bit space
> was actually required.

No worries, selinuxfs is a bit odd sometimes.

> Your patch is better then, you can treat my mail as Reported-by.

Done, patch link below.  Thanks again!

https://lore.kernel.org/selinux/20260915213807.481355-2-paul@paul-moore.com

--=20
paul-moore.com
