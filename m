Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1C93EFFB8
	for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702688; cv=pass; b=j6Q3TmOcDtRmCryM0I9JxtvyBtbsC4dJj/96TGC4iyhecSkGccRXsZHKFQfdH8ZRkgDNsufPRCVDeUOmvEil8KdTrNU/qhq37BjbQxMqocjrmw8IPwf2eAaUQJxg6R6KvqxKGsMBKeK4tmzW2JtOb6sOTVvODDavQyTMhwQAh40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702688; c=relaxed/simple;
	bh=unwyhP+0FjY2T5NPJmZpVVhJIscuZYYZn7Rxp9RVQMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hh/tvowdmESfLIbnjMO+du8l7cG1oxblAkn9f8aogvNLD77O/ZHtLiGNNx59bVv1Y5em0tp7El5oRMb9FelXh4eFu7cffIaAiOyK4cA1lGBEzPiAizNAkvcuCcQ6Q5nGC4KMgE8G2ObtK9C2AQyHAc+kjpUypWY+Wkq9yktL9zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnBC6JXY; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnBC6JXY"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c8897045525so158299a12.0
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2026 06:24:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781702687; cv=none;
        d=google.com; s=arc-20240605;
        b=PKPbwQQ8zP5YUJIInvweKkEsWgHXKNJyPwnxTk9gn5VGqlJ+hQMmPsmG1Uxwys+a+B
         nohe0AN6FxMINNLVqpsi9gX4tmyrqvc57vVBr8YNW9usEW4tXUiwk4r3Q6xQrMkkgoGI
         pQ82OEkFylcx0tCgPNBE/LuDnpUpqGBz8INz2zWFJmaGat3yUFF/LfYXqxhd2AAagS76
         x9vCFBH0ypsI1ddtnlXQYQrDmcgBqQRZYxi78Qerfe7EQhLLqaA7VRuYxcR6tt8TdZSo
         l14KtLs2ek7uGgVNCYP0OKouYXrOs7Lh/hZiFNMAbpb48EXkGtRQs+2dITdj4AV+8bhR
         EPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=unwyhP+0FjY2T5NPJmZpVVhJIscuZYYZn7Rxp9RVQMc=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=eEBoTBQnNJ7H+WmGj+zAry5/c0bww8nb9YMU5mbdcjaaxMnRJqm24OeeOG67qM/xbm
         mFUByAKvw2L2fOANth5hqGOD+imG6PClQJNE4K3bJKcAHrzOVENIp9MCljUOFcptTkep
         68G2UeS3dIyca1lliqZxrjMU/wwABhkKK4l7J+VHkYu4c49ODKUBWY3zrRqaE8Y0I6DR
         9UusEcSgK3PBYy42pUr78uprVo36xM5InRXc79Bs8WW/nFWHO830eJyyNqD8rhYeuHfF
         4WcKjI1CLnRyot4oiEORrIn7gL3deOWsvraVlmbcjgE01s6SJNbXrXAi4b3BFMCd4jj1
         wWVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781702687; x=1782307487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unwyhP+0FjY2T5NPJmZpVVhJIscuZYYZn7Rxp9RVQMc=;
        b=FnBC6JXYapXrYZPPK9zPt/a/p/w3UNby3l+ffwk5Th5wZZ4GJUU1+/oegPbr72funW
         5GV1Y7vN0iDddMzN0cfji5FQjnZgiDbMd507e9e+gU9UDLqthR+c1+txHPe2O2iQEkRE
         l5M3xUBVDxO5q5c5rP5YGpBx7rFPDrm3mWW4SbgEIGS6IdtYZy12KfS2USE5yU5ZejRB
         NP+AlALVcwZwEji5wh6yuT0Dj8PE+BM5HPrCf4ghtX0ZFPse5+Nfj0NUoD/A9aJ6SNag
         FxHph/b6D+2ppxlY337ggjavMBXeVS7oXXL/SySZJ3IRDvtrnTZ8xPjhx2dbRQ7lgO5x
         RxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781702687; x=1782307487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=unwyhP+0FjY2T5NPJmZpVVhJIscuZYYZn7Rxp9RVQMc=;
        b=JPH4tnvHzLamoHSkbyn9Ei6/O9Ujx0QgY55Ea/U2fXnG0gJEqSar5UWBpNlto8r5BP
         9t/7gvhfMFUKiK3GGAVDLqOJmmv8r4LNv21wrLqUK9Iif5LIzqiTTDbHLV/JqxzW4MAJ
         ROsOf5EPC5KEh+NWyBYhRvCaNzafrijmVGX7mrx94Cojxfxwxqk5v7BpJstGBppH2QfQ
         9UIpW+OJJ0wQQtp403ZcsEQFRC0/moJ10WIb/Ir0mRbAbP5KuBDKRfUDeXhfI49Qj9Xq
         /d0FCNijdHAZuf93+CEva4p/Ou1HLjgRnwXV513yrddIK7FY5zX9aCpFtz4gQPYIlLWu
         MEVA==
X-Gm-Message-State: AOJu0YxJpiQNpNbz7tRmgVX49ezO9YmA67yokMVfIigm+8BA9F7FWdnh
	iXuaH/HZTmyMVarHyZF8TTdFKyAkKUJnA7hwZoggCQEh3YenqvD9r7PM/xrzFYEa2GoLc/4pitX
	8PE4OQY3jkvl785lc4JmoYW9mFjdyNZh3SvOX
X-Gm-Gg: Acq92OFooITurQCDOiHNBEnGQB3Re6O7w4kQ14JL7j/YyWly44OghL4Gsx3YaFCvd9y
	lQbYGvpuIiHH4A4Xtorqen11kBXVQXake5Z6tT9KJ6taLxZl+A5bcmX1zozocb/W5lEzAM2Moif
	t/PXQ+HH+Lb+Ug4q8f2d/MxrjGcX8D91FA9crB5gJSMtUyZ62K4VzXFnYOC64AkUXR5d+HYHoXJ
	2k+DgpoUkNDY62QxfDBLZ1KqIae7p+CkyaZi+9roA4O1Y4bjk4eiDpNu09qmQm+7wT7hM/t
X-Received: by 2002:a05:6a21:1192:b0:39c:4e62:b838 with SMTP id
 adf61e73a8af0-3b8bcea62d7mr4851265637.17.1781702686659; Wed, 17 Jun 2026
 06:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajH77uobc9rUlhae@AA-94-54-42-0F-E2>
In-Reply-To: <ajH77uobc9rUlhae@AA-94-54-42-0F-E2>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 17 Jun 2026 09:24:35 -0400
X-Gm-Features: AVVi8Cepsj5xHNUPYyZOiHAt8cSdzRyEOlgMD5X9dspp8R2KDzVt13gkYTyDSsI
Message-ID: <CAEjxPJ4yYA4iWrjMA0rxoQt9oqm+ggxCZOSve=uP3c+Koyu=Qw@mail.gmail.com>
Subject: Re: SELinux kernel code and clang-format
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 9:44=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Hello!
>
> I just sent a trivial patch to selinux/ss/services.c.
>
> While at it, I ran clang-format to make sure my changes
> were in harmony with the coding standard. To my surprise,
> clang-format-17 made many changes and I had to git restore
> the file.
>
> SELinux userspace code just went through a major overhaul
> with clang-format reformatting. Should we do the same to
> the kernel code too?

You can use the git verification scripts described on
https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started
to make sure any changes you make don't introduce new formatting
problems but doing a mass reformatting
is generally not encouraged for the kernel.
