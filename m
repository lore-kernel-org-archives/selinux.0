Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0817D2
	for <selinux@vger.kernel.org>; Sat, 12 Apr 2025 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744426068; cv=none; b=Hf9iuVs1NnS/gPynk1W/buXpp0O+vFQ4wN6okggGha6VxJFlmxD/Z0uTJ1e1x94EiF+7N6QpW9nCewOAwWY6gAswzRKKavPkZoG5qhUbXfhTRjVx3KgYadmWc3VrLEAtgy4i1dCPwvdWdM3C6KeFwnri5sV9zT9o04cKgtXfLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744426068; c=relaxed/simple;
	bh=+qav9dJoYO271gfVTj7Pu5RFA5X4BZrs+BzdJa0w3oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPUrduZehKdDaz7edQ3W7Sn1bHR2sSx1hGx2i1sPlYK7yj1AtAmOr/KSuWUlu4YiFHAeQUUOJI6tNSUyn3VYojfERSVVyqJ0NuZw52kAEFiH6RfHXCpSlfyw0QMkoW6GCJHf9323X0793Z52s1+f2vI6soeETv3mQR+RYi0fmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQtaPH4j; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQtaPH4j"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3734527b3a.2
        for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 19:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744426067; x=1745030867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qav9dJoYO271gfVTj7Pu5RFA5X4BZrs+BzdJa0w3oY=;
        b=RQtaPH4jYAGUaIa0ZVsiZZdpsw4XxkWfR90g3matHXpE3ZzXgZxgRc1rS4Wv+JWdsm
         sn80t+XCbjV1UoY3YIoGasUUmq4p5Z30x9h/tNP2+xj1cRDIC70xarW8hmoGmxPh74nW
         N+PFwspP0Mz/va6s/QcQal+hbv2e0YWU8Clv7HYdFGZxlCf3/ZJHvHGqjuOS8v2AXxs0
         XSGLdf2rl3CvBb6vlSf1+AV4L3/z5R38TeWO9JpsIYmX6f00vPWrqHfijTyBVOLC0LdR
         3OagQ3HWMb197NxJaRTTB7s8JjKhOAcTYAVXFnjMIHw6S4T/xl4RJiJSE8gBSVTherxd
         l45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744426067; x=1745030867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qav9dJoYO271gfVTj7Pu5RFA5X4BZrs+BzdJa0w3oY=;
        b=Smd/uOcsU9JdxCpQxDQ51RJEiqlSdHOW9LcpT8pJKk/sIdrAgvl+Sd/AQ7D4txBq/V
         6YDca9TYPDG1lcQiWw43rb+MeUeEXge55I7Evh4aVH/oHvZAYNgoS/vwnGlOKMSDdmvG
         /x2ToTF/H18QPMDVpMct/oMXHiLSZDkDSNrFVsCcen/1pk3lS/VBidal77cFhj+ft9I4
         rv1xBLTPIy/alUmJ7LinMZ3vUjg949oUByeMY6wbfKMyH6u/TdSExoEz+RLIDu830DdO
         85Yc5YufiibQwKGGCGiZ+RKmcZoRTRJRBvMUYGQOmYk0kf7MCcUlg/yLozXsK9rprFYj
         7ZUg==
X-Gm-Message-State: AOJu0Ywe+KpReI4N4Dk15nH2sAqVlzRZiNIZAawXe441G02hPSQ5y9RS
	imGq9ofunwrET7C27mCu6oilWvBcy7lR6+17DbLfv8T97qYD/zNiPFpD4ZQ4b1Z5VYo0pLUdmbO
	luygIWCc9SjVBa89awBODAcy1gbpJ04d1NtYlZw==
X-Gm-Gg: ASbGnctwqWYjrd+vgMeqoAGbfPTpVhxXBKj5DjU1Zpg7YeOx6Ek9+kWTktb1aEWpppz
	6pJrr2mCBFgeUzm652I+ofOiqlazTQ4/UbQFpCKqU5Cd83NyqfUqvUUVYznJ1NaOYhIrgvnYXW3
	Ln/HuuEi95Xb/+PBpMajtY
X-Google-Smtp-Source: AGHT+IHk67Reqs3x1siH2lV0fFsPSKl9D0VmDPVK569Irzk1s6J9o8yDItkkCqSo9JHpPOGhyZpDlw/RM1is0WRVjWk=
X-Received: by 2002:a05:6a00:1147:b0:736:a638:7f9e with SMTP id
 d2e1a72fcca58-73bd11dc3bamr8338879b3a.8.1744426066586; Fri, 11 Apr 2025
 19:47:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGraAqv-rRTqtosNDu_T+eZ-YDVB_V3FR=t63S9BzfRU2OHmSg@mail.gmail.com>
 <CAHC9VhRpwZvf+5UWjszR67fYgw53Zf=kkPd08auzjJ+2LG+a_w@mail.gmail.com>
In-Reply-To: <CAHC9VhRpwZvf+5UWjszR67fYgw53Zf=kkPd08auzjJ+2LG+a_w@mail.gmail.com>
From: geng sun <sun.gengeration.sun@gmail.com>
Date: Sat, 12 Apr 2025 10:47:35 +0800
X-Gm-Features: ATxdqUFFgL9Vda6pr_Ca1uErD7LzCJksYB9IyW82YQk72ubmVGqGPOBemO_mxnM
Message-ID: <CAGraAqtBfaBeZXih-Y2-8j3XwJg42LcxzEecHEt61Z2u3piH2A@mail.gmail.com>
Subject: Re: context label has been changed problem
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for your reply. I also submitted one issue to Google at the same =
time.

On Fri, Apr 11, 2025 at 11:32=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Apr 9, 2025 at 9:00=E2=80=AFAM geng sun <sun.gengeration.sun@gmai=
l.com> wrote:
> >
> > Dear SELinux developers,
> >
> > There is a problem in Android ...
>
> You may need to get in touch with the Android developers as I don't
> believe many of us here have an Android development environment to
> help troubleshoot the problem.
>
> --
> paul-moore.com
