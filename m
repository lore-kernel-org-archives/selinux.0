Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862048BD35
	for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848810; cv=pass; b=q+EsUBwhhiQDG4zOqSqeR1+TRmnoWJQT/wU6YdKd74wVKxEsazpleAQrNhbfL/UxZ5sek+ySdqbKvSRUAyWEB8I76U7OO/h4kvS2NgSMWpZQYaqdF4TIUOHfiie27cpCz/obFw7ubl+lB0K3lIIT7mMwF5UudLLMLUPBiAYdCAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848810; c=relaxed/simple;
	bh=Rw9fESoqmoVQsvkR28kl3H7jBGsry+qBSL8mVBm38Bc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aoa7alYcamRfMWT2CMMLxqE1O1TegVcmHaJgMicqTVIUWtd4dcxSq8U1PiXl+INP5D7XeOmOLdFwCpFRWPAVCR4GZNFyeP0LSEpbX68KdwxAJZCl/eUPVTqC1rbW7NsCestT/hCSOcuWcbWnUbR4L5rCjWihbRwjTnUxQdifCnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmVqHzwA; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmVqHzwA"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90cd572323cso1327856d6.0
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2026 09:40:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787848804; cv=none;
        d=google.com; s=arc-20260327;
        b=ll6Hkl9cq87k7EcY348toUYvG/phln7KlsahhnQTc9hpnbUZLF/qZBJyrTqdBobw0b
         bcvxa6MtCM5LQ7IsLKy3gDHEZpMkrERFnlvYAz3Gp1MdOhj01F7Ngjiulv3cT0TmIRq1
         H1GlrhxqsxRCV3BsRGfbZJ7sybnvVCCD1MNhzy1h9RndleDKaSYrK4pagR4GfL/G6+Aq
         erfqkg1wxOy+faIUdLbLJ6+4Q9eSkeVt0MIzkpguFfjlyuT4MD8N8N1LqGBD7cWk9hEJ
         jQCowzghT1hEELj47CUP9npqE8v/Isy+6z6KcgTrxwAuocQS3REGw3nVXs4lVxSJIPcL
         uCjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZW+b3r7Z1RR14HMq6eLueR3tzIrUVH1Zdww2QvrXAZ8=;
        fh=PvVq3dmv8yvnCRJYSTWWanBfOaJzW2R+gufroGOSnBQ=;
        b=SY94caowruUI+AcnVikQxsPp9hy/e3snRkMnUpUulMdtbbdCEDGJXM9FSryrmSkvvC
         i/dmQEkHEpbTNM8U9AIZYuha68gbgQTkyDpfBm0eh2SPKzxZ6usEFG817wkcnoKKEowO
         3nMBYu3l0hAg/rxDf3d4CKNts5fzULdLFuw6+DuyXp33uNStLCvvIVGsm0FC5ZKM9y+i
         b5R276UnSgC0bphfhihusIcJXbB7s8ZdmvPNp6bGZB7sSafp8WITws0+jYpkp3dF14Hu
         fEPf6LVPId/8uE3F35Qp8TJbIOIIoWk0XRC2fV5gt7h1QywDipD5QrdiuppKngKxrUCG
         eFvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787848804; x=1788453604; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZW+b3r7Z1RR14HMq6eLueR3tzIrUVH1Zdww2QvrXAZ8=;
        b=QmVqHzwAV/pUrxCOGr9gyaIlm+Lz9fv90PJhCzTyF5ZQZ2iNQxY/3pyQrkRCHwXYii
         Rfwos0KmRMXNHwfUcOA4IphU1TH0QwDeO5gRPyLw0faH1FqGiAW/DoSV3q7PAoSvWEUW
         qvhALQxB6+lOi/hxYeiQa+nsrBMRYy5iWm+M5/N/mJ2mmFcds15x1RIgKlfZltR8DEAM
         1s5IZY32MupQfNPHLabLXii1SBHX2k4VyIfMMDT5u0zOj5QUIJ5LQ/3TKCBX4JvKtJ2f
         8+g+auUqVwowWTaGaVn2mk++yyjZi1HJsf28xaaaunhDnHmW6Gi8P4lU3eIe6gpZI5If
         TWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848804; x=1788453604;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZW+b3r7Z1RR14HMq6eLueR3tzIrUVH1Zdww2QvrXAZ8=;
        b=P9uzarN6mJiwtoNCYml+qNzD+tc+19VHz9YqY9iXkqc0GAvxwv29JEytbMUt+W/ZNA
         sbQvhDReAqcKKjd9X4GTgfC0lEuNXm3YU1dI27uIh3t5t6LCyn5EeMhHUlz3UgcgoR0J
         t4+Ixqg+c5YZpd8YBU5/zU7vNaDMZ936BgqAPUrmr6gC/TCvm2Tq/wcIGdsLCDhK5qFH
         Ylhxkag01G0JOktfW2ccSea22pIElcVtz223xal9P9irOxqbf/juoyLzD7WtK5U5o9by
         bJisl9NeCS1TiOjjePpJm4AjqGgdGAzO1Oyx8N4MxlvhGzZtULwJeHTT73UeXE4Hg05O
         tkkA==
X-Gm-Message-State: AFuF++kEU/MHDsh5nyIBu0zeiot8K0VPIr874sFh28lSYYvks+H3inx8
	hbrLYxJgo8SSlTr7sTXchl88nfXbmzpSqTl7j5Tsn+SSYWF1AbeTIqF4BjnkvlaOO0e5ZONa5FX
	QKy+2+k2jlvKAMkd7vy54bYaSo4DhsrY=
X-Gm-Gg: AR+sD12KzFa40QM2ZvScCR8u4bEMuOD0dzjV7+aqaVvaPrwoiUDEMNrnSo8nF/kRwSf
	+R+Cn0cM61qqQH9TXbBOdqmzySirevOAf/PFRMEb6ByjyIIKB4+zjSEaDcIsUdvYVlujgVLO5Br
	4D6BDuFnQ0y0r5MPLWS6EM4I/p+Cv//TFBtMN6wnqeBaMn+HwVyW/FUyDdKanqrQRsL874097wX
	HjgiYIdRACZ7gHIAa8AaI0tG0d8fiVxLIy2m3FV5ptURlCzv+Y3CcdxYkKzsH3+3MNQI3Af3BGh
	tiBHUk/NTftM229Y0nnxSX/UzQx8RobbDacPJC6zpMdc
X-Received: by 2002:a05:6214:21e6:b0:90c:4d1f:f88e with SMTP id
 6a1803df08f44-90ce0ed1626mr6649896d6.16.1787848799995; Thu, 27 Aug 2026
 09:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827151203.108111-2-paul@paul-moore.com>
In-Reply-To: <20260827151203.108111-2-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 27 Aug 2026 12:39:48 -0400
X-Gm-Features: AcwNN1VfpkzegwdYhowPWnlYXuAYppbCDdnezW27CcLMPyOS-zwfc_TCLQnx-qg
Message-ID: <CAEjxPJ68+3+OJnm3Kwh06CN1dqO-9mWM6HDc5ufrN3gK3sG6jg@mail.gmail.com>
Subject: Re: [PATCH] selinux: convert selinuxfs inode numbers from unsigned
 long to u64
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 11:15=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Starting with commit 0b2600f81cef ("treewide: change inode->i_ino from
> unsigned long to u64") inode numbers were changed from an 'unsigned long'
> type to a 'u64' but somehow selinuxfs was lost in the conversion.  This
> patch corrects this oversight and converts selinuxfs to 'u64' inode
> numbers.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
