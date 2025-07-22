Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5768190477
	for <selinux@vger.kernel.org>; Tue, 22 Jul 2025 05:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753162969; cv=none; b=b3yOJyN1yueYHHmfsoFblFJPnByq82W3okyg9aoV+PsLhfLyyn0L3AFghkTUGvj/JNXawElTNc4jA7MgPGW0kGhwwlYf/HpL49PtvgN1XNo3Ww7Y0+XAxdQEBtWNF2kD2R9/gKRFpS0GkFAhDAHraxfhaI+Wr4kerXGFHU9IEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753162969; c=relaxed/simple;
	bh=K4xhP8JalRNn/NTfpZCgPja2QbEEtAvWmQVQb7U2jSs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 In-Reply-To; b=KejgF7cryeUn/ON/wL4uHA7TXe2ZzAhdXbu8TGVqbARPbjoEo40S1AxLj8CUKiUIqraTzOPl2lkQECjMGUu6hwVDXOcVKKIt12PnISJUMuAr02aSSf3N3Aya8e9Vfk5xMsEpTV75vM5vIkVpsVRVAOkIs1TQQa75SJ0MmDhvN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCX7SeQE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCX7SeQE"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a575a988f9so2990840f8f.0
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753162966; x=1753767766; darn=vger.kernel.org;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcTEN3kb7T3wFEbnDebi7CnZx0TM17vzKebKUMomQqA=;
        b=OCX7SeQELBLWBIxQpkT+FajQtmzOPX8QBJw6nujBd1tqICBlt0b7bBV1uZeO4E+nh4
         CW+G2oCg8YwiOVS+kWa/q5dm5gs4PQrrSTpK3r4QxNI9kbH82UmkWQ9R6R8GD04jkvzf
         MERi9XZX4Bu6S9R6xNvZIaNZDMqTfn7RJCYcpOm5DGMnNmKLKcgindLghphPfYzqD8tZ
         MqxBqFSd5i1uRgzhUPsat64a97ir75oCEtvlvKgVXLsG2TI3hCh9CXTGpC9qE3QBEtPA
         UMXRExS41/DeBxw4j1/fOXYPmbViQU8mM1L5vyNnctoOirdRGiOQiGPlcCj696nRIGX5
         HVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753162966; x=1753767766;
        h=in-reply-to:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QcTEN3kb7T3wFEbnDebi7CnZx0TM17vzKebKUMomQqA=;
        b=UZbMWCDRgfRVx/KNTXD1K3n1cmbT02UIvH/Xyg9s2G9Y9QfOxT9NoLTDWc9OMtA2Gl
         Sh5h/+dLlir6SQLken3HaZfhKYV/CMjvjPTe8d49IYwVnsTs1vffbzD/lhlUuWVMABZr
         HWdZSagZhe4I0VYpyN+OGWGxSkTAWsZEdMKuuu6MVvge+Y12t9kpuJROqBXY2tT/0yy0
         BIAWHpN8TA+6ZeKSuJyIN9vPEqqIXQROg6LhALsnPGj7cjvCLdPSPp0NzVeb8Ooelt4N
         jLXsPBKAwJrmM7myH++yH1GbA62qVKO3WRJhPns0ucoWQX9Vm75UcEMuYpyhbd+AXTpB
         7i3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXs5x9S12H8R/VXFk6x3WBGohdcOas8bGtLr5lUlueodzNQkC5BOZIg4XXsqb65MHttEUikoygi@vger.kernel.org
X-Gm-Message-State: AOJu0YyMPq6YqPE5su/q8hH49zORINyT841hQUaS551KyQbLt3n5tyfA
	lcuWe598hrMCw6RO1hXxFTEcAsSoMNKYnv9Npk3R39OFJzsdnrxE/Jpu
X-Gm-Gg: ASbGncte6nsNAKuOrqkhLeQEKBAMTCYDf+WgH7FejLccU4JB+c7iBZzxGRhh1fzHzpR
	cWBvezrzkNbG/6QVSZNg0CpeasHTJhduQToE29maFes3WoP1IBlP5HggMUjEYq899cCMUBWJDSW
	Vrg9pNKfmq26fXANsce3Yd1MAPXaXr7X70nOhh4lP5LpjQnoFpBI0VGYvJB+qRAlDiRDxjcIEEb
	rJBQdBIfn2heB9BBTJznZi+AEeKZxe5I0HnmzvmroudX1t6e925foOo2+NFY2YGuOAPPFJtt/ds
	COoiyb+ZTFWX+zno8oMN4w/JJoXredl0iDk5Vd/kY03GdV13XVBuVEGlNSdhmY9UpuFn/F4i2fo
	MnAQiSoRYRfHlTprZ
X-Google-Smtp-Source: AGHT+IG4gc+6SJk1rvUzh96laewBjw1ohJdVBJjXRjz6AtSf5AROGH+vhAlMJGSaGtAzSWDg3CShKw==
X-Received: by 2002:a5d:64cd:0:b0:3a4:f7e6:284b with SMTP id ffacd0b85a97d-3b61b0ec05bmr12527858f8f.10.1753162965837;
        Mon, 21 Jul 2025 22:42:45 -0700 (PDT)
Received: from localhost ([2a0a:ef40:8c6:a500:5855:6003:61ac:b38b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca253f9sm12558713f8f.6.2025.07.21.22.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 22:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Jul 2025 06:42:40 +0100
Message-Id: <DBICEHLQ2KYS.2WJEMIZAPCJCG@gmail.com>
Cc: <nvraxn@gmail.com>, <omosnace@redhat.com>, <paul@paul-moore.com>,
 <selinux@vger.kernel.org>
Subject: Re: [PATCH] libselinux: fix parsing of the enforcing kernel cmdline
 parameter
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: <stephen.smalley.work@gmail.com>
X-Mailer: aerc 0.20.1
In-Reply-To: <CAEjxPJ5M76PFEMghyCWPsJW27rNA6A4yxhFydGoWWDW0Eybqfw@mail.gmail.com>

Hi Stephen,

> We should make it match the kernel's logic for parsing and handling
> enforcing=3D on the cmdline. For reference, the kernel does this:
>
> static int __init enforcing_setup(char *str)
> {
>        unsigned long enforcing;
>        if (!kstrtoul(str, 0, &enforcing))
>                selinux_enforcing_boot =3D enforcing ? 1 : 0;
>        return 1;
> }
> __setup("enforcing=3D", enforcing_setup);

Okay, seems reasonable, I'll send a v2 to follow that logic shortly.

> And the kernel's parser ignores anything after a "--", passing
> anything after that to the init process.

Just to clarify, unless I'm missing anything I don't see any need for
us to worry about that as:

1. Based on the logic above it would seem 'enforcing=3D' is recognised by
   the kernel?
2. We're reading /proc/cmdline anyway, so I don't see a reason for that
   to be a concern - we're going to see all arguments as far as I can
   tell.

Although, I'm a bit confused about CONFIG_SECURITY_SELINUX_DEVELOP, how
are we handling that in libselinux? I don't think that stops userspace
from loading in permissive mode, and even with:

#define selinux_enforcing_boot 1

I don't see how that would stop libselinux from loading in permissive.

Regards,
Rahul
