Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105A27FD54
	for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 12:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445223; cv=none; b=fB+TM009Ktfqkis7Ja7m/wKUCaG3mpBuz4/EQc0/XW7ntAWfcV1lNNPuA3zhw91js+H06hZpF53MsbuFwz1uaK4Ps7RlBIs7Rb41J2yYFO7l1lpb82LQKr2p3+FuA4eMp09GQk3Yn0lpAjlR+qwRAyEbw5th84WpbW0JDJ2EivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445223; c=relaxed/simple;
	bh=kB4P9VgZPL4nmA1pHYHadqy9g41oD380jVTFJTYSQIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ie7zmqjdRCYrf4iEnRHYYVrwLGvhex0Ni3MLkVCKKVA3V2vzcrSCT7/TJWaNon8NKfY3fZibzPZoauDySp18Z1954eXcjp8h95Awi22IZaINVmVoRFMC4tWRKUaZ3PchwZCbRvb4/HiffbwORIgf9U3dZfZDPn9Y2Ioyf+zfhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvsYuIaQ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvsYuIaQ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-33b8a8aa73bso1104387a91.0
        for <selinux@vger.kernel.org>; Tue, 14 Oct 2025 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760445221; x=1761050021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNyx//iIOau1UNUz8kDH4mIXNQ6Z8QTasDsQRHgkq0Q=;
        b=VvsYuIaQKzwiabGU5BjmezRfRl575f82bZJwlo500AazVyQfeFyVjhZ53V7tiQlVEz
         V7d54/Cj2/UQ0Vyz/gL5BNv0iwVvtdMV7bfIEG8Dr9VUWWcanIlXLEpVFR7AdD0cUmh3
         ZNUUUL4QcQJkSQfOfK2vbOIJzh6eN4rp9j83U6pZV5FJ0q63cci2rGeVewuCOD72QqM6
         ghtRaGaDuA+H6t+svvOHxOkzN8XE7HAVgy0CRYzqI8PvlE5p1Q5Or/4WF9wW4Nw67VoY
         wMG2Y198F/28lzjaGV3PENWrgIUwMcaHHU5ZE6JyWMA8jdeGHLFtTSQH8fuq4UxBNOFT
         xoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445221; x=1761050021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNyx//iIOau1UNUz8kDH4mIXNQ6Z8QTasDsQRHgkq0Q=;
        b=P+zBQ9doUbuz2GQtjs6bohfAWfd66gPexw7PT7Bf1argxlC5BSIpsd1VU4K6nAFEmH
         bkp2VIXcLl+NkBCzd1IbEH8ygwrhqWUcoUrULNnhntoZtsl7/hSHX/TM/irFJVwoLM50
         R2wnOsQ+A1hucMQR58EKqE+EMVtOStn/s0zfsNKGHYWUq7pL6z9mARcasosmu1Ny8X+l
         whKlRZqEgKi5/91YwY+aUrbLI99bACqnxp/9Mc/H7zU3A7QFO3KNHhIpS/y397lo/jjo
         ThLYrZK/fkryDjjzz+akcfm91aUrFLg1t42GXg8Uv4nqcuNROK3HgLCbaCtcjU/6gxOu
         e76w==
X-Gm-Message-State: AOJu0YwUJBtFhVI1g2+IOgJPJ6QC5Oj+iV7l4kpqHGD0yjv0t3xmg/7V
	WVZP9evwlodXxZNK8SssiJROMMu2L0SLYJFkfH/wng2SclI295z04DL/v63zwlr9BoSvs94WgzB
	MUG9zvcKQM4tplbaQqr89VZ6vMFBsMWq4f025
X-Gm-Gg: ASbGncvBqxcjxaLx7Ee70J0GGUAtmL0HmJq4mWTkQQWpRK/ppUsCYO1bDspcCuumRRP
	IKVsWhusYecQ1bWTkoEi2Wtb5eKhirdnzU4py4P1GLR9wzPVFzAWSMtsI1A4ZcGC8r3aHexvNvH
	8qs1L9lxn98EYEZdppqab+ku2vSz8z9sKok6DPaYFJh7cGgdpV8Z91oWes3+Sj5B2o2ykaoX+iX
	e2h6lkzJFpJO/ghr8WSjrt0gQ==
X-Google-Smtp-Source: AGHT+IHf+cqkivZvkFhXAzKcDbAG/6D1j33v++d97si6BPYKD7x2H7n5nRkP/ETUkY6p3W1OMkGgKsTj6PdjJtFjFDU=
X-Received: by 2002:a17:90b:28cc:b0:33b:938c:570a with SMTP id
 98e67ed59e1d1-33b938c5b90mr739480a91.33.1760445221172; Tue, 14 Oct 2025
 05:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DDHR3Y151ZWK.3DNFX6HD9BW9N@gmail.com>
In-Reply-To: <DDHR3Y151ZWK.3DNFX6HD9BW9N@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 14 Oct 2025 08:33:30 -0400
X-Gm-Features: AS18NWD6sq4ujsrT26BRzA0eTrQI5FwVO3f21AhQ0qENWvtHjBVrqJuYRmbMVsA
Message-ID: <CAEjxPJ4gtYyHCpjo_cxSxVR=FLkcUMxOSv2tEZYya+dXk4qfoQ@mail.gmail.com>
Subject: Re: confusion regarding the setcap permission
To: Rahul Sandhu <nvraxn@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 12:13=E2=80=AFAM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>
> Hi,
>
> I'm looking at the class process' permission setcap, and I'm a bit
> confused as to what it actually grants. The SELinux Notebook describes
> setcap as follows:
> > Set Linux capabilities of process.
> However I'm not really sure what's going on here:
> 1. What syscall is actually used to set capabilities of a process?

capset(2), https://man7.org/linux/man-pages/man2/capset.2.html

> 2. What processes is it allowed to set? Assuming that the process is
>    started with dac_override (granted both on its executable file and
>    the SELinux domain it runs in), would setcap allow it to only set
>    dac_override? Would it allow it to set other permissions?

The capability security module enforces a set of restrictions over
which capabilities can be set as per the man page or you can read the
code at https://elixir.bootlin.com/linux/v6.17.1/source/security/commoncap.=
c#L272.
SELinux just checks whether the current process is allowed to set
(change) the capabilities of the target process (which is now limited
to the current process; at one time it was possible to change the
capabilities of another process but this was removed). The actual
checking of individual capability permissions by SELinux is deferred
to the capable() hook which is called when the process tries to use
the capability. Hence, the SELinux check is really just a check of
whether the process can modify its own capabilities at runtime.

>
> Thanks,
> Rahul
>
