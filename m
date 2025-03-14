Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F9D20297B
	for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966285; cv=none; b=Ey0LjYgMmI6EgU5DneU6jc0ev4hcwth5sWFW/sHxQcFMacx4g1idKad9tdDnZiWD6691I4grnxCB3RiMuutQYGFDQvdiGQt4rq01oHtNZYlbaab2vnMVGQpXY6NoIgUFmxYWCl5h5qOEMIb5VqMHOIWvymJEjL8R/v2RhQPwJ7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966285; c=relaxed/simple;
	bh=2I32NeRxzuNB4vI6nY3fadHUJPyEZxXPQ52nKZ4EsxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lgokh5F9M/txuMS0f5JoR511prP6CGRVFJg23rl0sN/R7TTmFQuzPn1h93FDP0/N/1NqgOB5guqB1u59CO0P8e4dKkEpnZN6pFY12WjbgKoZ2XVuTlcdPtUKiHZeiBPv5Rmh44lyOsRGSRJTXoIZqZV/k4O/9SwQsNKTSA1cwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ9zdVCM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ9zdVCM"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3014ae35534so2130474a91.0
        for <selinux@vger.kernel.org>; Fri, 14 Mar 2025 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741966283; x=1742571083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I32NeRxzuNB4vI6nY3fadHUJPyEZxXPQ52nKZ4EsxQ=;
        b=DJ9zdVCMX3bPJKLaMKspdEgpOe2tGr/opnlV5c7Cx4x3Yi3NmdL2c6fejOceGqtthj
         gNArtu5niDJaX8JYmEqmgX8uUCe78YxdwdRRDzBIvsXvlEeh9MCb9AndWFSPHZTdtI9K
         K09aGF5yGRV/EvF5wmx6Gy3uCQDRUSsQ7dMAjBFpHogBs8OF0bMC/DsRUp4z7/gN0+F0
         2iudWQxHDusgWveyKajogWvLVH/y/kQbhA419DAEIHmWl2jihgFikP1SeW0sgXqMpJ7o
         RgQPVTz40kLiWCbOOeIlrob9/53LhH2qmuyP22qhSkIVXyFjSqWWGdvrepfOR2wVMCtn
         vcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741966283; x=1742571083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I32NeRxzuNB4vI6nY3fadHUJPyEZxXPQ52nKZ4EsxQ=;
        b=pT5q+V4apmptP1VaqNcvXboX7u6Wo54E+nH8aK6wjNwfCk8X+n+tVkFMDc2TB9jGR0
         GvgB39Q6uFiNf87yv/pyplut88+cPRarwymwn6DHeF5Q/WYj1FhqFUyvDKz0ioHVeOk1
         QF3ViBhILssyqAYLq18nD7PDiN9R/l4QTejbKM/ahTMvd+E2tohZeab3LR0ckfvOhzks
         wQ7ciGm6u07ZjrpimPomyuFZy92gWor50y++IKbeGsd7DbCnZRvNp/aiBRSo5PdYUMgD
         MqsgsyISLCg5JGNGK9aQdJh2b47G4dLV5VENc6kMCSUsoQgO+XEXtMKgVk/BxtL4rF2q
         rpcA==
X-Forwarded-Encrypted: i=1; AJvYcCXPIgAA05H22jmSx8TPWBwthqTvFe3oBZM2khLMF86BdxbnsjnT043T1YNp0zJDdmEYdArPfnN9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5SG03dojSW8QqLVIdvnr6Ejg1iY1ejdsO8yhWrP2TCHa4j331
	sh0ocPztMP4wtvRFbDbolE3ED0b8rgpy/OTzGlzTyxDBvEVuGpdTqKS+xymAbUSGCQKM3fb3Aj6
	zE92J9WoPI2r3ucJ4K9kbBYKKlXY=
X-Gm-Gg: ASbGncvH84dvZeyANm0Y/krtONVmusagJ6QCHqbtftd2DjMr8Zk/fmiKMZs76vXKNIc
	VpIdMLS5+7lRytAKfcaH57YmRix7+gBeQrBajMPc7gfvN1viHSZaZtZRxFHDPO9xauD2FyoXqB/
	ZSTbnMtWubGbVvfbektSy6x8MBOQ==
X-Google-Smtp-Source: AGHT+IF3BLWXrPrTpwziZlaUmJRi4BiPD8KTlywsEA25XyIMdRIwf7+eLsbJBmO17RXc/1V6X7reK3PmPFLJOX8pRWI=
X-Received: by 2002:a17:90b:2707:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-30151ca0991mr4672582a91.14.1741966283180; Fri, 14 Mar 2025
 08:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312080055.8950-1-cgoettsche@seltendoof.de>
 <CAEjxPJ4MAaN7P8ZtCcDhRvNt44LNyzL9azc-xNE54=tkW_4vjQ@mail.gmail.com>
 <CAJ2a_Dc4pNdL8bp_wydmRmQ46GXkWhcA5jTVApF3E415stcA=A@mail.gmail.com> <CAEjxPJ5VuJpcZe-j5auXjviV=79jR2HzWfo-qPFAioRcw6Fi_w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5VuJpcZe-j5auXjviV=79jR2HzWfo-qPFAioRcw6Fi_w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 14 Mar 2025 11:31:12 -0400
X-Gm-Features: AQ5f1JoHc_SoA0Fmq7uEtVddHmwDDkq8TGx_QpDdEbrEOxS6feJ0u7wvdUYAUng
Message-ID: <CAEjxPJ57HWE8FJCGR71aUaaN2JdXqsoXRMQaPq0udXEOcs9NEA@mail.gmail.com>
Subject: Re: [PATCH] selinux: get netlabel_wildcard policycap from policy
 instead of cache
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Mar 14, 2025 at 9:01=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > On Wed, 12 Mar 2025 at 14:04, Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Wed, Mar 12, 2025 at 4:01=E2=80=AFAM Christian G=C3=B6ttsche
> > > <cgoettsche@seltendoof.de> wrote:
> > > >
> > > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > >
> > > > Retrieve the netlabel_wildcard policy capability in security_netif_=
sid()
> > > > from the locked active policy instead of the cached value in
> > > > selinux_state.
> > > >
> > > > Fixes: 8af43b61c17e ("selinux: support wildcard network interface n=
ames")
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > Do we have tests for this feature? I didn't see any.
> >
> > No.
> >
> > Is there a way to retrieve the context of a network interface without
> > actually sending packets? (Then one could simply use `ip link add
> > $name_to_test type dummy`).
>
> Not as far as I know. The inet_socket tests should exercise the
> relevant permission checks that use the netif SIDs.

On a different note, I just realized that your subject line and commit
description uses "netlabel_wildcard" instead of "netif_wildcard".
