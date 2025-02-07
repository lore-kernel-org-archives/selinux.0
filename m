Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0B1ADFE3
	for <selinux@vger.kernel.org>; Fri,  7 Feb 2025 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738966916; cv=none; b=eHwCug7m5m7p/t5lKcW5LxuZc5A8nVB5uI8mEt1kYLv+vepxMWFUkNAS4sx8vRafAyVJmEHB+bUka7JqUeIu6Czr1vmF+7jJA5/AJW0w7j/YrdZ+LThyyoSZnc11k5FXlggc3UlLTpnpLApQygcA3Wzry0ri22/A2oHx22+44I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738966916; c=relaxed/simple;
	bh=tK3rfULmuKjq5ZkQcPkvEUu0wfRoYfeMb1VFEZvdmi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/omjitHPjj+NX6ZNeBeWc1uLzyBY5V/pUcT+1CDMzlufsoeHl2m+sUc1HnrhDI+Qbs9Fa0yqA8ZFNxW3xPh8fz2o9uZfUijZI9jTFjYytNP3wmASUmi712EcazW+Eva/97FYURDKMPxVH6XErxfOuBXUbH2F440DTPYJd751cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SvhxL5Vf; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SvhxL5Vf"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5b1837d182so3084797276.0
        for <selinux@vger.kernel.org>; Fri, 07 Feb 2025 14:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738966912; x=1739571712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEPaswESS1PjI7HNTDsrPk0/PCf34GKT+5GZnVwgZXY=;
        b=SvhxL5VfunWjdcxlzGG8u4EHGFeoE7Hsd7VSpFB7mWXw538cZ6lDN4xCKYTXb/F+ny
         JbRof8Ynh2JOOl8IEVEzxfhATq8HT3CWC6o87hI1Dl3UZ3xrmnLWMIGhmVi/pE05I+rY
         wXAW8Gxfq1MDGFgixyMSTZ7C6RkY/wCTbtpQY/iUWB4Px9eYadHPzV5zmwu0p1ba1Fls
         KqkW5/VjK9BGXv1fuP1CZ9vmL9Az40NU67ezIiqr+Ds75KxDZMG7loRBZdD1GTsngRdi
         tzNxoG0aRQBGjAxlrwK8Jz8epBG8jx9S+R7TsMHL4XvmInAhe0rtltaxBlCKY3sgmmVa
         lQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738966912; x=1739571712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEPaswESS1PjI7HNTDsrPk0/PCf34GKT+5GZnVwgZXY=;
        b=YUAfpdjU4ObsFCbE0fjDmRMV/b4FvR7QAvIgjtMwMYbmbEZvqeNm/4i2VrXdJ7vKON
         kFOlDmWZabIiXhW9DpiTCf4IrPSG3lYKYgtu3JPPvSDCPRKX6Ygnt8IJHP9sCITeYRWP
         gJyDTTX1uUZRxzO8vO9rkLBUfKmZXXSWYo+7/FOR6W3c17OjQXoXeAH5YdKPvJcYIL3Z
         CJTvwgYcBO8dFd3F+/iu/C2GWksfLh9YscEIBA6ybkaZevkHh8Tbj23D765tXN4nHAm4
         aznH9x2A8wW2KQmvaWzu9lFh3F1G/UibbUzPZuDU8wiekjvjwI7t+ipVIubf76FlpUnu
         VmqA==
X-Forwarded-Encrypted: i=1; AJvYcCVqGBum9ZQ5DxDeXXUxGpQmgZMrY8me6ISZWCnfdV9aZW5Vi+wh6PMvcSON/p0YZouYffhqvegz@vger.kernel.org
X-Gm-Message-State: AOJu0YwGIN7mSWThl2pHclXg86IXKuJVqc/ViZTHjzNjGMjSjMpDOVdT
	5ss8GqGSl6QTIyTtTIrQXZ/p2Jm91+s+D1Vjy1s9K8NsMiMKbD4jSHpLyxVBoolKKqJsGjga3aU
	jCyXt2tG/hV0bRLNog/TKnS+cTsr7IXtXgB2y
X-Gm-Gg: ASbGncsVwfz1XiCTJnRBO3xsn3RGtgBT1ifx98pb5CXQGid63CRY/+6Jsls0tgiM/RW
	yMYQjyre3GYT6ws5RoiUA6DCixQ3l1hy4qsL17OQzEvv/fPUAyW5Au1iJr0J9FgDY2qKqZc8=
X-Google-Smtp-Source: AGHT+IHBRA127lA39kegDN775o8sxuc/2TfRWjm6n/rOOXgCq5OxY/YTyMkihpXgx3uBbbWMJZ1NIqaD8HwuOOVN9kc=
X-Received: by 2002:a05:690c:730a:b0:6f9:c6e2:89a8 with SMTP id
 00721157ae682-6f9c6e2c8b3mr21691667b3.6.1738966912666; Fri, 07 Feb 2025
 14:21:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127155723.67711-1-hamzamahfooz@linux.microsoft.com>
 <8743aa5049b129982f7784ad24b2ec48@paul-moore.com> <f4efd956-ebe9-4a02-8b98-b80e16db95af@kernel.dk>
In-Reply-To: <f4efd956-ebe9-4a02-8b98-b80e16db95af@kernel.dk>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 7 Feb 2025 17:21:42 -0500
X-Gm-Features: AWEUYZm96FCzr6LWRjIh3Nuf8FgTiXEW22PFLZ07c4RqLniYHD_Dg4aIbl2L02M
Message-ID: <CAHC9VhQDMSw9VNzd1pLRv1a3v8y2wz9rM4k0wa1t-Wq8KO6kFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] io_uring: refactor io_uring_allowed()
To: Jens Axboe <axboe@kernel.dk>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-security-module@vger.kernel.org, 
	io-uring@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 4:54=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
> On 2/7/25 2:42 PM, Paul Moore wrote:
> > On Jan 27, 2025 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> wrote:
> >>
> >> Have io_uring_allowed() return an error code directly instead of
> >> true/false. This is needed for follow-up work to guard io_uring_setup(=
)
> >> with LSM.
> >>
> >> Cc: Jens Axboe <axboe@kernel.dk>
> >> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> >> ---
> >>  io_uring/io_uring.c | 21 ++++++++++++++-------
> >>  1 file changed, 14 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> >> index 7bfbc7c22367..c2d8bd4c2cfc 100644
> >> --- a/io_uring/io_uring.c
> >> +++ b/io_uring/io_uring.c
> >> @@ -3789,29 +3789,36 @@ static long io_uring_setup(u32 entries, struct=
 io_uring_params __user *params)
> >>      return io_uring_create(entries, &p, params);
> >>  }
> >>
> >> -static inline bool io_uring_allowed(void)
> >> +static inline int io_uring_allowed(void)
> >>  {
> >>      int disabled =3D READ_ONCE(sysctl_io_uring_disabled);
> >>      kgid_t io_uring_group;
> >>
> >>      if (disabled =3D=3D 2)
> >> -            return false;
> >> +            return -EPERM;
> >>
> >>      if (disabled =3D=3D 0 || capable(CAP_SYS_ADMIN))
> >> -            return true;
> >> +            goto allowed_lsm;
> >
> > I'd probably just 'return 0;' here as the "allowed_lsm" goto label
> > doesn't make a lot of sense until patch 2/2, but otherwise this
> > looks okay to me.
>
> Agree, get rid of this unnecessary goto.

Done.  Converted to return in patch 1/2 and brought the goto/label
back in patch 2/2.

> > Jens, are you okay with this patch?  If yes, can we get an ACK from you=
?
>
> With that change, yep I'm fine with both of these and you can add my
> acked-by to them.

Great.  Both patches have now been merged into lsm/dev, thanks everyone!

--=20
paul-moore.com
