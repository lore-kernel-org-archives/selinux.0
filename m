Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83575235C43;
	Thu, 12 Dec 2024 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020407; cv=none; b=Z6xpe8L8afBQFwFm5g9lPKja3DPjQs9UFOESbKF/VpWz/F9IGvOLin3/kDm4ig3n6SFFoNy3D8vWU/l+lZ0sZUPh43OyrAa/N4Bcy+LFKy0hbt2YmOtEKfTrRtOBbeWoDWde464NHNRJZSL+9CL+0qj5Fj8IBWo5iNHSVWwlgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020407; c=relaxed/simple;
	bh=JVmUS2CdSzhYO/+5qWBJ5rYAQ73X7glpW//CiwpZyAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/gV0rFIEHjcbKI3qUq1bDVxpIZ8TGajILsWsZlMp7jy/e5/Cm1yEQPpsroBPO3h4scTs2Pn13+58tOviWtSV/RKwOr/ZQcSMj6zQg8sjFQgATYVyXVT4Dv6+9F9y0MSpLcF2uZre5IEN3ijBVUjRJU5aQWogTlW+azTyNxm5tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYAg5mDF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYAg5mDF"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd51285746so538120a12.3;
        Thu, 12 Dec 2024 08:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734020406; x=1734625206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsI9kcZ6aK58idBLMhnOiSNJT/pu3FO3Awdo4l6Covs=;
        b=iYAg5mDFNYC4ddptea7VtDFSwcLOAH1FF1yzkbWo6CJ8i2P67dztKs3eAtyGtoVpV5
         64U1F9RoYaQ7SQTr+94Fxz4G6WCchQS+u6UTkEN2HgT7Ihj6u51euUz2HRAr8rbzlUMQ
         abyZtt8tV2MkZIRL4oJbyGe3ybz/azll0gojBf4Kfz43g/jhut8EKmntYz8q0dIFerhY
         /aScUvPutz4KGHmfsrCv6jGZsy/Psr7SACrXEMcKndiSz3DADIyx2CbV38/oOwJbwQdX
         ceVu5wEl5NasKAfOr1Hqc88u/FiRwdHBj0LDVMOJTBoeV3CGlmIq9dF01Z2VYJ5H9dXu
         60SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020406; x=1734625206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsI9kcZ6aK58idBLMhnOiSNJT/pu3FO3Awdo4l6Covs=;
        b=WVmdTILzxFzMhsGE7wAP7p7w/T6hvJ6qXw3AIiWKadKjiKhtBljk+1OpCn4WGWQL6A
         vR3PJgATNIxeGYxws8o4wRg3JjzwHx3Np3RN9DSj11pTYRO9U9fe3zwwNe4DLARhLFwv
         +aaBgowGWe/koQCzGNe6PHU6tFJKG89rwKRrU9mcZ6kjnrKerTs0d7NPLYxRgSW4Se0d
         /CVRftYebxmOsO1ZLbtoINrmyM+LTEKJIVohV6io47h1+4bYbTS6sRtF5gfI6Z2mrahK
         pO4GoKG6UMS3Q+jvzgnAVtyl7Otpbi9QJa/PzrP52HMuAoayLP/B7LjOSigij6530Cyp
         NMug==
X-Forwarded-Encrypted: i=1; AJvYcCUx2JTGvvbJYuDXj/GL1nsAA5GkuInfkfiDW3aMTPZTLaqMqMwwNhVMB0ITzimDt7S6WsV5hADOopMBaXRU4MTKJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6MknOl7TmiolHfcIxfR3F9/srgfx/JdiO8okrnKobKhCvcFV
	wUN5whHjrPdUPNFabE8VLotcywIr4WD6GiR8DuSYI1fnx4dZ8u+bjNvwUnNRJAqAraAulOsuHQX
	u9E3vtBTaE459igxxfg60WDESBEFN2g==
X-Gm-Gg: ASbGnctrbn06BadPrLDYxeAiLSs5LRQrl1snY190x8mMl0uaissY+CVSISwUVOf6rIP
	cTPyrRFeeqV/WRiG93+54CVvy8nqULXNDqRlUXQ==
X-Google-Smtp-Source: AGHT+IGe0NefEu98axtAq0KAS0RBGAUMlYLHjPLhuzLgpuN0Q2oKF3BYZ49zzLZjc/6xQda8j7zccFNkny9LNE3MCmo=
X-Received: by 2002:a17:90b:1809:b0:2ea:8fee:508d with SMTP id
 98e67ed59e1d1-2f13930c1ecmr6635911a91.30.1734020405748; Thu, 12 Dec 2024
 08:20:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhTUX1L=WDtVaEMWDgCreyphrOLDtjL4Fg3gvQk8ihs0Dg@mail.gmail.com>
In-Reply-To: <CAHC9VhTUX1L=WDtVaEMWDgCreyphrOLDtjL4Fg3gvQk8ihs0Dg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 12 Dec 2024 11:19:54 -0500
Message-ID: <CAEjxPJ5DXJRRYB+RHfeWm7TYKF=LJKFNFq5X6S8H6JrQwhf4iw@mail.gmail.com>
Subject: Re: The curious case of pidfs and pidfds
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 10:49=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Late last year Chris sent an email[0] about the increasing use of
> pidfds on modern systems and the difficulty in distinguishing between
> pidfds and other file descriptors when passing or inheriting fds
> across a process boundary.  A few months later there was a similar and
> very brief discussion on a related GitHub PR[1] to add some basic
> enablement in refpol.  Unfortunately both discussions faded without
> much in the way of resolution and I'm concerned that we don't have a
> (good) plan for handling pidfds.
>
> As we are starting to see pidfds become more common (which I view as
> an overall positive), the lack of a good way to handle pidfds is
> becoming more of an issue.  Having just started to look at some of the
> kernel code a couple of hours ago (see fs/pidfs.c) I'm worried that
> many of the access controls we have for /proc/PID may be missing or
> bypassed with pidfds and their associated inodes.  I haven't spent a
> lot of time on this just yet, and with the upcoming holidays it isn't
> clear how far I'll get before the end of the year, but I wanted to
> send out another email on this topic to see if anyone else has spent
> any time looking at pidfds and pidfs.
>
> Anyone?
>
> [0] https://lore.kernel.org/selinux/da1d9efd-fdc1-4651-8a7a-30ae4a399926@=
linux.microsoft.com
> [1] https://github.com/SELinuxProject/refpolicy/pull/762

I could be wrong, but I think pidfds are controlled via ptrace hooks
and those check the task label rather than whatever random inode is in
the pidfd.
