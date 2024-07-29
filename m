Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38EC78B50
	for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722272094; cv=none; b=Xy4nnspnHWv9KlKnQatO9kR3+uB7qQhQVrhVkQKGGkRBjW9CLI2/SPTofiCPxgkmKgxt41uIDJ9BgKMeHFtJQe2j1+JJB2U4AnHXb8NJ1J3Hx2M2r8Lo+zt7fVkAHcFT+eKq+LztaNdeArQcJ7CH4PNFq2GCdAK6wfdZpbTL/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722272094; c=relaxed/simple;
	bh=4iZ5jrdjMvy+u1F+tHcRV93HmUhfTgO39/xqzT0Vx54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2c2vwnk5yCMte3FD62m/eBmIxW+P7ij2ztp6ZVpvXjTZLO3IPh74+FUoUSDZYRnAYkHN4x47cbMn3X3MsGFDLX1peAvRhJn9DjbALXvm6LZchg1uRcrQpBJPnO32GBS3oqhAWXE80alwGmp0N3FQWU0+9XyyBiVccTFtYinr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoVdwMC5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoVdwMC5"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2cf78366187so1959327a91.3
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2024 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722272092; x=1722876892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iZ5jrdjMvy+u1F+tHcRV93HmUhfTgO39/xqzT0Vx54=;
        b=UoVdwMC5qGgsiHEYgl279nvwVc8FDxZeoEv+/pOL1+f5ZOEbOWXCNuTEeAz+Vi36Q2
         jLACvODRxiY2wNcC8JxXbQ74iOFd/i+XvAaO2siLft5qFFyrWFKYR6RotRca+LnjXMN+
         B1r3L1ZS9+3mQC3tu8EPOpn1ID1Kznf/Tb7tI1usIRgT/EjyuwQrroZ41OhhoOV4xZGl
         sq8h92CCuBGs8di8idJNOVAOvT9ziTfEYYnd2agC7YGBvk3waJfBla/5mbs7EPWMkJwk
         0qlbLvQiSOhg41xDPK8sPvVdLYh4mK8XBTcABrW+7AbivxQO9lnIrtctP+I5S7xwrlJ5
         T4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722272092; x=1722876892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iZ5jrdjMvy+u1F+tHcRV93HmUhfTgO39/xqzT0Vx54=;
        b=XQuY5dNdJ49qVBeaq9kwyq3f1siWAOnHpfydz7pFXxjY+Qdfsv4pnCN/uzqA6VJR6w
         LgDzkXc7qPrFsGkcFvWRaNcpmxiPikx95dcljbu9pDL/2cpDl7wIl2eCWP9N61FhB1bP
         HGutmQOs6Qkcd4zhiOzkotTzSlZOuPa56YVMLV4C5DJ717+jzRgLEr3SrluT58UHWpVA
         e0vRWyPLnC7LdxTnln2xtlwbiiDDo9OoJhzpwKnjmZGvdkdLvfkcCNWpJtRGZE09V6CI
         iHT+L931alonu2uTF0sPjsQMJe5gl7uDyf2QNI1MW97ETyw49yC5Jz2GqonUze8B1FMq
         QJCA==
X-Gm-Message-State: AOJu0YwPzGhjUNQgptaDjm+yDFd7LAbvWRfdBF6+M/l2YPUKMvaZBTOA
	KL7b1ziUsLgt0Wto0XovScK+ItvYFEnnWNzEHWVDWfEx/aq4tBT1HWaNC/lq7lMkdKWWKT9VoA/
	8/4VsUROuY3WMPIIu2+Zavmv1eZfPgA==
X-Google-Smtp-Source: AGHT+IHH/NCiHC7NYlnXHNsomtXaB/7v+htUx4Wl8KLHnYEP2JfNwibRTK/Qwl5fJMA4plC7/sE3UpgzW5yopikllXc=
X-Received: by 2002:a17:90a:134b:b0:2c8:3f5:37d2 with SMTP id
 98e67ed59e1d1-2cf7e2167b1mr9604031a91.20.1722272091993; Mon, 29 Jul 2024
 09:54:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEeCnGzRMiiDZKaDgnX_dqpeK5rM=aO5zBZ6frWJT4WQj5cVEQ@mail.gmail.com>
 <CAEjxPJ6VQB6XVEa9k0brDZNPVN2RRNqHd7ZQaZN2CM2K8ZrHkg@mail.gmail.com>
In-Reply-To: <CAEjxPJ6VQB6XVEa9k0brDZNPVN2RRNqHd7ZQaZN2CM2K8ZrHkg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 29 Jul 2024 12:54:39 -0400
Message-ID: <CAEjxPJ74_JUHtJxPRVkQUGOVR42n0Mn8S9AekV8BLYCS_nr3oA@mail.gmail.com>
Subject: Re: UnicodeDecodeError: utf-8 on python semanage -i import
To: Allan Oepping <allan@intellipay.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 10:51=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 1, 2024 at 1:19=E2=80=AFPM Allan Oepping <allan@intellipay.co=
m> wrote:
> >
> > Importing a .pp file with the python semanage -i option generates a "Un=
icodeDecodeError: utf-8" on an up to date Rocky 9 distribution.
> >
> > packages:
> >
> > policycoreutils-python-utils-3.6-2.1.el9.noarch
> > python-unversioned-command-3.9.18-3.el9.noarch
> >
> > The open() in SetImportFile needs the binary "b" option to open the fil=
e in binary mode, as the .pp file is not in utf-8 format:
>
> Did you mean to use semodule -i? That's how one imports a policy module.
> Also, patches should be -p1 appliable and include a Signed-off-by: line.

As far as I can tell, semanage expects a text file as input with
commands to execute, not a module file.
