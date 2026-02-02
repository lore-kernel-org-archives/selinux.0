Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679EF1FC110
	for <selinux@vger.kernel.org>; Mon,  2 Feb 2026 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770000032; cv=none; b=OqCYdR2OFck6tB+1WWSSnc5wvBm/p8UPJ+oIWVJ253wq3wXLsQoy2W5f7S/ToA9dwpbYEgNEQyWy/XDHEUQ/uyU8pKpHj63bdA5hfs+7bMdxfGquwh4TWTbgB91dEbyeMqegcFgTcHi5gcWhr/gf9lM0I34wVH1Eg6RIGJtovws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770000032; c=relaxed/simple;
	bh=WI9XaiffVEyIp94CbMZOvzo+SJKN3gBnZw+mxQA4LEU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=YNOsm7mEl3s9k2Bbhd8SKskZtbfSNY+ufy1G9R1QUP3cSilAin4Hi6RiMsTfH/PyHH0vJG2T8jysBJwmmsCFOlMMyCM4juZuSQQOjY5zaAayxnjGe9bcXbbvnB2JA4q6owVCIqUSG1bUoFuPc6dY6gelENEmdcY5TWqRVMKEtgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa5Mbyrt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa5Mbyrt"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso40059965e9.2
        for <selinux@vger.kernel.org>; Sun, 01 Feb 2026 18:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770000030; x=1770604830; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI9XaiffVEyIp94CbMZOvzo+SJKN3gBnZw+mxQA4LEU=;
        b=Sa5MbyrtU3fS/2M31lx0ffpIWVVm0oxuLPSAhOO+JQMKDvKbNasr6Z5g4Mv1Lt6VaZ
         1idcyQTWuG34lKReSdIl517q0LgMMwjVwQlvzEBX/FlO25FC8yQW1duLjp19WQ+au2i7
         J3K+wiYEpLy5lSo5Sp5migqNqjbPCfybVawEg6oiiGFArfRDsw53fwGFuKDQHL8d8Y+Z
         K0fYCpQT22HtJoCq1Bc7C8wAJKbh5g1wTxGmvt16rTuCgaqaTvhB6+yhS2nLqeVmMHCI
         ah7T/bLkUsmtJbDZV1qLd8scj3JOnbggU/3kbVVKRMn3TZUyrxZjmdZkoVOtndAghveH
         3vTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770000030; x=1770604830;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WI9XaiffVEyIp94CbMZOvzo+SJKN3gBnZw+mxQA4LEU=;
        b=a2mms9DKm2Vwm6MHGrBRITgbwwdz6nC0ICFnSmOX+Sb0lrNfJ2/w++t1hK6HdzCb4e
         0nNNJadb4SageaPgz5lh9FzfCnh2L1fvybipT+bx+vJ02lj6vKdvtjw9AJDdNrv03bYC
         IrOPuWmHaRGGxXByXUuvloOgorKwHLDTFpMO/ehDA6+8NOgSSCliB+JZOqEwz4RpgE4k
         ClaQRl2TWQzdND9Lc6s5Y1GWHiBlL68S1HUcXjelCyYXHhV4cMbIUyZSIbEXYtBJrB9d
         JV2Nyer56vG0EJSd6jUCptZ4f0ny5tlvZXGcK7nYeJdzVRvuvbLvL/jBqd9WY6B/S6r4
         Vmqw==
X-Forwarded-Encrypted: i=1; AJvYcCUSuQtYis6KdsPDIt23eQ8xfus5zukI9wX6YCfwpPhiPsydBbQ9UDxIu1qut7zUiJIi9YpZaVVR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KLnsPF4MXHJ84Yl9XCujClS+KYZ80I3IjoLHj+QSmlR7a6Xl
	Z1blKDyH+SlKqu8NCfN1ch7+XwRHmiB2A6qKse7xunqtE/oEbQf35+9+eVEmcA==
X-Gm-Gg: AZuq6aLz2sPZabr6Fu9wwLhSlewSY+Uewrr8jJafayKi8e0xEPAMnGalmLmzqnv4Q11
	vU3nCxrQlLrUSURHat8CyzW/CC4ZtKWGI8iEGVfLlKYBSCMUGpcZVQxcMIcNORqtn2MOZoJAs4A
	gAdhzTPMQqBaIjTsIZHD7UNsccnCcmrY3rl6Z2sHchai9lSMcVC8WU+ydjjryIKAnkYgzrJdg7K
	d3UgmHG4JmYPA6kB7l2F+K5WnqyWpC2erwpKDkPnCkmKLfkxDpFvuBgBDHApc+j7bM5Dbq6HlOf
	nmLjV6FbhDWLAS45kxqvTNpD1JOjku8PK8+pqSBixeIz4OCTpzEbKRJsOQvYpubQ8d+GoohgdpG
	u8qFzakC95Z5lzXPwDbUaK/Zv76Jk6eEyNzuZC5L4IZa5btMXfZBzszwJnSgrXClztMauXibo
X-Received: by 2002:a05:600c:c4a3:b0:47e:e9c9:23bc with SMTP id 5b1f17b1804b1-482db49d765mr146041475e9.30.1770000029542;
        Sun, 01 Feb 2026 18:40:29 -0800 (PST)
Received: from localhost ([2a0a:ef40:90a:9600:de8b:28ff:fe7c:941c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd78d3sm373912705e9.1.2026.02.01.18.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 18:40:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 02:40:28 +0000
Message-Id: <DG44N7XQP94D.2E7L9CFJ7PTXR@gmail.com>
Subject: Re: SELinux userspace release 3.10
From: "Rahul Sandhu" <nvraxn@gmail.com>
To: "Jason Zaman" <jason@perfinion.com>, <selinux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <aXbPKpbIXh7_fpTM@anduin.perfinion.com>
 <aYAKEjlKxwVWGgrw@anduin.perfinion.com>
In-Reply-To: <aYAKEjlKxwVWGgrw@anduin.perfinion.com>

Earlier on the ML, I think we concluded that once 3.10 was released,
we would format all the code in the repo with clang-format[1]. Should
we do this now? After, we should be able to merge the formatting CI
patch[2].

[1] https://lore.kernel.org/selinux/CAEjxPJ7T-xTyPhbNnC5GgC4d9wMtMD+pkPF0Jg=
RmOdMvM6opUg@mail.gmail.com/
[2] https://lore.kernel.org/selinux/CAEjxPJ4jsZ_bWrLF=3D1si18f09p2Q_TEPWf1r=
d_a9=3D_kCb6iTEw@mail.gmail.com/

Best Regards,
Rahul

On Mon Feb 2, 2026 at 2:21 AM GMT, Jason Zaman wrote:
> Hi All,
>
> The SELinux userspace 3.10 release is now on github:
> https://github.com/SELinuxProject/selinux/releases/tag/3.10
>
> Thanks to everyone that contributed to this release!
>
> With Kind Regards,
> Jason Zaman
>
> RELEASE 3.10
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> User-visible changes since 3.9
> ------------------------------
>
> * libsepol: fix TARGET and LIBSO on Darwin
>
> * secilc: use correct long option name for -X
>
> * Fix problem with bounds statements in optional blocks
>
> * libsepol: Fix processing of levels for user rule in an optional block
>
> * libsepol: Fix problem with handling type attributes in role-types rule
>
> * libsepol: Fix expand_role_attributes_in_attributes()
>
> * Allow type attributes to be associated with other type attributes
>
> * libsepol: Support functionfs_seclabel policycap
>
> * improve semanage man pages: Add examples for -r RANGE flag usage
>
> * libselinux: fix parsing of the enforcing kernel cmdline parameter
>
> * seunshare: always use translations when printing
>
> * treewide: add .clang-format configuration file
>
> * setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
>
> * libsepol: add memfd_class capability
>
> * semanage: Reset active value when deleting boolean customizations
>
> * python/sepolicy: Add support for DNF5
>
> * sandbox/seunshare: Replace system() with execv() to prevent shell injec=
tion
>
> * libsepol: Tighten checks on MLS range and level when validating
>
> * libsepol: Fix potential NULL dereference in policydb_read()
>
> * libsepol: Fix potential use of an uninitialized value in link.c
>
> * libsepol: add bpf_token_perms polcap
>
> * libsepol: Fix possible use-after-free when expanding attributes
>
> * libselinux/src/Makefile: build python module without isolation
>
> * restorecon: Add option to count relabeled files
>
> * Bug fixes

