Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1E713A876
	for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545179; cv=none; b=gRnjAQ1Uec/uawLJFxzr6r0xa7HZ6/6WIjQE9KSIDbB/VKxGgJdKtCi1akvAciwLd4jwJrwMBm7mEouns8LtOb5SjgAxSQHBAfE7KQn4AMhgGL2+qs+6tZCn6JxbKKncf+rHS87JBZdVhsYzi8H61x8gwjJk+3B/94H2C3VXwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545179; c=relaxed/simple;
	bh=7jYGQE/Sq6zQQ7I/lci/AqG3dRtS+wbk4l5Iv9S3DkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqG5cWsZblcEQtBmB19kH8JU3vNhqSj25jR43nPI0tUVk3K6pk+mLH+v0e4ifvFGp0xcZ4f7SGqjDMgih+qhYZJXVbJJHSjip92yAdkQX5SntKOS35bz4Fw9vCxiFNQ5SJQ/M3T8Bu8ofGXfhZFDILxK6KFuNpiAcqwxtZqns/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=E7MmN36g; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="E7MmN36g"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-60a5a11b59dso73397477b3.0
        for <selinux@vger.kernel.org>; Wed, 27 Mar 2024 06:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711545176; x=1712149976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cl8kc5DDzw1UCsj7H0OiwEAFqFJFC9LP/5UvI/M+Yjg=;
        b=E7MmN36gG9eHassxEruVGT5a9SJ7HIN1ZupU6gnFwxmzFwmaBaPaTSJN47uwi1p74q
         zhwmrRGdqAKH35L3Q5NtFonNWWWd/3W8F8W0TWdh0GwXB3HjWmizcCRZnKx/GsM43rGU
         hwaHSx3TACrKeum21NSKTq4BQZ3Xs05CohfN37id/mOx2UnYnRfgLFTA/WenLTvPxTwr
         Q0+zoMcUS/2MXMLCDcOqu6KNgsB6tnEAZz3hnAGDLa10wOs0GL2srUC2Gyul3h2jqESd
         AQ7CGYSQuYkkmor3grdTdgym/L9aUc2tB9PPrCtwbhxkb7bRvhrbO62AotxDq42tMldj
         Kk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545176; x=1712149976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cl8kc5DDzw1UCsj7H0OiwEAFqFJFC9LP/5UvI/M+Yjg=;
        b=Ugzu1Ri+k147x5E3KTtz1w/Ddw2cxYmohpedjdfzP3kCrjrTPtTe5UnIOWYAXZAxNx
         YT/sq9btIBZdvaj8aNyU65owGF/E2tGcE+LpQhpl9TANUUGwqEXRtH1aJvqlvys0n4Yo
         qwiR2G1MzQWjXcUgD793XPCyAz8b9QH1yVAFS07aPuoRrfHkMFwhf4cU3OfBVA+7iF4C
         VM2/tI1AgoOXCKCPiz1Qz1T7A92yQ5qmTz4q+QyTL/Rs2EAEsUgUi1Vakt9T6C7v0kVH
         Fnl0rlCzwszqQHNXmiyAckG7gGndHFFuaPhe+JTnKPMEG+HydPMr7QKDCTL8P5E+t19T
         d3/A==
X-Forwarded-Encrypted: i=1; AJvYcCXLh9RpjdZGjXZZg5ARraZPRnCsJkOT/zBpfESHjP3ULmQ5aUZbLTKq00JYn0JqaMGI3NCph6MZS30t2gF2PjGnYU2dVTolZQ==
X-Gm-Message-State: AOJu0Yyj2vYaYOQYdq1rjndZNQsfyNONROUDeWPuh+vfzunZ/YSUsTfc
	jJWXt49h/it8Lq42T7K5pLyILsgf0EivcVsp/SWqqHd/LA83evx3bhny5JXk/1CZiLz1+SRHdgL
	djmlSweMXvsjtjMUwRER2MdV/LZyer7apJKaq
X-Google-Smtp-Source: AGHT+IFnViE46hUFxNhS96CiitdKwqazrOx73uxR/QTBc21cTRvG54b6wKCZP+b0faw/yql5ruAenNvedVuUNjr8JY0=
X-Received: by 2002:a81:5c44:0:b0:60a:379d:2bb8 with SMTP id
 q65-20020a815c44000000b0060a379d2bb8mr2389589ywb.35.1711545175822; Wed, 27
 Mar 2024 06:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327131044.2c629921@canb.auug.org.au>
In-Reply-To: <20240327131044.2c629921@canb.auug.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Mar 2024 09:13:11 -0400
Message-ID: <CAHC9VhTOb_mR67WK6pQJRGWFcFOwuTaHPd7_V9kAfZYcYMS9pw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the selinux tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:10=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> After merging the selinux tree, today's linux-next build (i386 defconfig)
> failed like this:
>
> In file included from include/linux/kernel.h:31,
>                  from security/selinux/ss/ebitmap.c:16:
> security/selinux/ss/ebitmap.c: In function 'ebitmap_read':
> include/linux/kern_levels.h:5:25: error: format '%ld' expects argument of=
 type 'long int', but argument 3 has type 'u32' {aka 'unsigned int'} [-Werr=
or=3Dformat=3D]
>     5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header =
*/
>       |                         ^~~~~~
> include/linux/printk.h:429:25: note: in definition of macro 'printk_index=
_wrap'
>   429 |                 _p_func(_fmt, ##__VA_ARGS__);                    =
       \
>       |                         ^~~~
> include/linux/printk.h:500:9: note: in expansion of macro 'printk'
>   500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>       |         ^~~~~~
> include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
>    11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
>       |                         ^~~~~~~~
> include/linux/printk.h:500:16: note: in expansion of macro 'KERN_ERR'
>   500 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>       |                ^~~~~~~~
> security/selinux/ss/ebitmap.c:464:17: note: in expansion of macro 'pr_err=
'
>   464 |                 pr_err("SELinux: ebitmap: high bit %d is not equa=
l to the expected value %ld\n",
>       |                 ^~~~~~
> cc1: all warnings being treated as errors
>
> Caused by commit
>
>   0142c56682fb ("selinux: reject invalid ebitmaps")
>
> I have reverted that commit for today.

Thanks Stephen, if I don't see a fix from Christian soon I'll patch it
myself.  It should be resolved later today.

--=20
paul-moore.com
