Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898A1741D2;
	Fri, 16 Aug 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812806; cv=none; b=eix70uUYuxeNoUECfeMKHaKxrFKC0gwKbRXBNJrpbOv//AOzG6bO159WarWcf4ssripNuTZe972NM7W3APSJkMXbTYdHsE1A62J5SgAjGrirmb30KpY6u30JM4WnsURHbCfOPHNoClH79BBi5J6jKYLfaatIRJfld0HuMSP0wOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812806; c=relaxed/simple;
	bh=KvPISS19necwS5apJOOzv3MYk1sBeLC6RtlRpJugNyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wxrj5iO7HsCff92gicj3tzX72CpedLcF4Zcp9CiWpKDZM80RDGCn2t5z/HDgGqTuHHTB0k5CWJRydQ66Yne5Tg4XOpXcOXBb0I/RNTjEc3eTgweq/NOjRtWTfxH/qh1WNFMXmkVU2+CohkrwwSegsz7HgzD51ETGFWOmIIo9oJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbHL8MSo; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbHL8MSo"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d3eda6603cso384474a91.3;
        Fri, 16 Aug 2024 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723812805; x=1724417605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7f7c9gCLpeAm9IK9HiBlES+dcX5qvMqcqJoh8BiSCI=;
        b=MbHL8MSovu2sdS33qvHHJ9W4iedJ0RGd5759WDKYkWZnP2tHI7V8zAUJbg+NrF0Stq
         vJ7JcOQyWvoayRxK2q5ZGIUFOlUJssQOb1O9TcSeypvX39UCpDT2mDjPvySyUmSX6N25
         Vd6lsUaM7xP2lD1710OM5rSugK0iuhS3Vb+5tqwkk+IxWi/N//OlHiBPazhy6+X2BBm6
         Htp/mXZk7riLQV1s87AwKVZEtHUdi9ZtDOYFqYryQmEFtwGZlZ+UZgEln0lt/P4XJiHm
         NGAf75IEvyXJVAfxSpMw7+eDHCSouIjaAW2Ueoi7gXChskKBiMcRRf5Cl3TAlqxlD/5o
         EPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723812805; x=1724417605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7f7c9gCLpeAm9IK9HiBlES+dcX5qvMqcqJoh8BiSCI=;
        b=TO8/rj3Avc2qp7ZvljRFWTgCNn2Z/ycLGAcCCs7TBuLJjnfHso0kMTSwSndPIVuOoI
         fS5PkxTGmQk4ertf8YVcjjuLQiVAk5GFT62CwUpLnkdUuUXRgV6N9pOQeM1yrtXeY4Xx
         mwCMgrVxYILo5muh3eMUt2NNx8PxFR+kgblIrHfts4DIK4K4g1uyqSR+Q2C7YgI/ofYp
         YeqIPM0njq7LJgFryeoPeGy/e8RJ3hqxSnIBp3tDdd71K4Kr1wufOpWmZoJMsxlw85cH
         fbKI/+y+bJL/BnlTjLRBKdoFgb2Wdd1gfUnTQu3ln4dytT8ZHnUWt4fCfkqXm31CzsYa
         DVyA==
X-Forwarded-Encrypted: i=1; AJvYcCWHD9TFHSAaE/UzCttL26shKusmyVVS3pGLKj9IvmJY2nimqP59myIWkwBlrTHHYOXtj2YOw/qqZKxqZZRZpvm4oD8j6QQs4kmLdtWwgYW+kQCGn5Bo63EZbI9iQOEunbwk4CAV7w==
X-Gm-Message-State: AOJu0YwdpoqJ89qlT6qh6W7RoAiUX0oF281HyZ7wRSnWRbq4g1UkvI6l
	HQwHefEgpuM6+EoWQ6O26U+CJmZDhULLgUDt8hQxNw5xgxgQzMfFpQlFFRnOuDDLHJI5MQ9zYBQ
	l/ITEf+2DvKxxY5pB2rCpB5fd3fo=
X-Google-Smtp-Source: AGHT+IENuSY/G7txvr3NALCz0aSrRBsuY917yFsddOtno94JvTi5i6jJ9cgafZw250TStNqic0+Ww9h3jro05k7+UC8=
X-Received: by 2002:a17:90a:c38e:b0:2d2:453:12cb with SMTP id
 98e67ed59e1d1-2d3dfc1f571mr2994649a91.2.1723812804692; Fri, 16 Aug 2024
 05:53:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSrPS27KSG1_On8_WqUfR7tokbrmVwfW3+L_-XJiA=WZw@mail.gmail.com>
 <20240816035751.62058-1-aha310510@gmail.com> <CAEjxPJ6gznARkD_jTZUhXJmQ5zvdrwxJOiSC0YQoZekNe76Nug@mail.gmail.com>
 <CAEjxPJ6nZY-RV2V0b5mqnUA4fKa09RhKp2SX7io9oO6XhZsacA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6nZY-RV2V0b5mqnUA4fKa09RhKp2SX7io9oO6XhZsacA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 16 Aug 2024 08:53:13 -0400
Message-ID: <CAEjxPJ4ARrOkNQczhndBo3p5PHvGPpCQxwSAMGi=1ygKPYDfdw@mail.gmail.com>
Subject: Re: selinux: support IPPROTO_SMC in socket_type_to_security_class()
To: Jeongjun Park <aha310510@gmail.com>
Cc: paul@paul-moore.com, linux-kernel@vger.kernel.org, omosnace@redhat.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:42=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 16, 2024 at 7:21=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Aug 15, 2024 at 11:57=E2=80=AFPM Jeongjun Park <aha310510@gmail=
.com> wrote:
> > >
> > > Paul Moore wrote:
> > > >
> > > > On Thu, Aug 15, 2024 at 4:32=E2=80=AFAM Jeongjun Park <aha310510@gm=
ail.com> wrote:
> > > > >
> > > > > IPPROTO_SMC feature has been added to net/smc. It is now possible=
 to
> > > > > create smc sockets in the following way:
> > > > >
> > > > >   /* create v4 smc sock */
> > > > >   v4 =3D socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> > > > >
> > > > >   /* create v6 smc sock */
> > > > >   v6 =3D socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> > > > >
> > > > > Therefore, we need to add code to support IPPROTO_SMC in
> > > > > socket_type_to_security_class().
> > > > >
> > > > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > > > ---
> > > > >  security/selinux/hooks.c | 2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > >
> > > > I'm a little concerned that the small patch below might not be all
> > > > that is needed to properly support SMC in SELinux.  Can you explain
> > > > what testing you've done with SMC on a SELinux system?
> > >
> > > I don't have much knowledge about smc, so I can't tested everything, =
but
> > > I created a socket, performed setsockopt, and tested two sockets
> > > communicating with each other. When I tested it, performing smc-relat=
ed
> > > functions worked well without any major problems.
> > >
> > > And after analyzing it myself, I didn't see any additional patches ne=
eded
> > > to support IPPROTO_SMC in selinux other than this patch. So you don't
> > > have to worry.
> >
> > Note that Jeongjun is not introducing SELinux support for SMC sockets
> > for the first time here; he is just updating the already existing
> > support to correctly map the new IPPROTO_SMC to the already existing
> > SECCLASS_SMC_SOCKET. We were already handling such sockets created via
> > socket(AF_SMC, ...); what changed was that they added support for
> > creating them via socket(AF_INET, SOCK_STREAM, IPPROTO_SMC) too.
>
> Also, the extent of the support is limited to just the socket layer
> checks, but this is not a change and is no different than many of the
> other AF_* families besides the small number that have been more
> specifically instrumented for SELinux.

Normally, this would be exercised by
selinux-testsuite/tests/extended_socket_class but we didn't include
SMC testing there originally because SMC sockets depend on INFINIBAND.
However, looking at the kconfig options, it appears that perhaps we
could test it locally via CONFIG_SMC_LO=3Dy if we enable that along with
CONFIG_SMC and CONFIG_INFINIBAND in the selinux-testsuite/defconfig.
