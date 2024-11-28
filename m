Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1F13D8B4;
	Thu, 28 Nov 2024 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798191; cv=none; b=dWlkDAb47Sz7zL772zT84qxHkZ9ecdNUX+/M1PZdGfEEUJvTI79OdQSkC6u+7EQ+T0QPQU3Z7NAmYCo39oXnfiAOyRqwYHqsrsByDAONbwi4u9qzs8tTV2JF1GUaV6seQoibH3m1JJo41zTZiODLOZ0Ew/wOIEjCMYtVubVibj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798191; c=relaxed/simple;
	bh=BqSvddOO7uzl+51J37esKBdrOTlw1w5GUalne+Zm4xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbGQLUkvlNhIRJsU8AsCQ+oixoYOT5O7EOl+eSZQ58DI5buN+AP5B+Ml/Hx/2LnzNcBMmFtevYObbwDNtItbZ3wXvDQQhvh253qmykzcGUXlht33mbUdQUy0qi1P7MF4h+0F9Z5oidPZ8d8WT/GMKqvDuPhFRvNwus2EcLj5o9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=mAV0GvUq; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mAV0GvUq"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e387afcb162so782123276.1;
        Thu, 28 Nov 2024 04:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1732798188; x=1733402988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8enuKRoYuGx+UMyN4wbQkK8SaUw8qYySH+tZSLJzqc=;
        b=mAV0GvUqFLP7VhvKQw+5PvB+lVdLvdQzkij7fwbAvK+FVOjN5NwhD8zevhHqvPhkgg
         vy1NYv4THwvmUCxUnMY2fMnNbGh0WUCi//oqZI5JJdWk7iSYcn3D/4hBV67jhyUZHOlU
         zL+/k6CFQ/MPCAHABB3v7x9B6pyHpBd/2sBXkeFvQWxVl8DXkhQ1oyVBSbyugvpksnMG
         OTBEfpFFev+gtNfe8vYi50/5VVoluR49I24Mnfu50ce44wozHOVvAMRF50WLmv9Lbwm5
         6PxVpV+ZDqDffO1ghkfRaiE4lER5ZWrqDnQuhF2e18ogbG1QxDA55qKvu88MDWDNYa4Y
         bcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798188; x=1733402988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8enuKRoYuGx+UMyN4wbQkK8SaUw8qYySH+tZSLJzqc=;
        b=ZKmR5WFjAuGpNzz4KoRGmUNh1J4/1O8jWI5gU4JIFxeFfDJkI2lz7akXouHSSnc8Js
         fGKr0vHhcQ2LiPK66zcv4AqV/9djEHGsZuTAAm3pEcZURz0EJV1sV+NpZdahS9I3KCc/
         D8flFK/gAR9HUZ8hkIH6rYzkoOMcCETgCtQ9kg56s0hRZNw7FC+i2y5Gub4GWvClNZIc
         lbZ59M3cAVWEaZL75zVAT7y9/sgmr8rjBKbcMnwTGuBnTOfprRAtga0g7n47nvbU6z5a
         /aYQQni3U9yfiZlqJPMgCiGtuA8+Hn3FwD/9lPN5hq3nUW3Pa0WXKsn/STGYCm19JWn9
         5KGg==
X-Forwarded-Encrypted: i=1; AJvYcCX2ofQh3MHZTNPy2A2XeNXT0ftiZiuAFrl8IhTyjg0Bw46j30oSlYACwaBC6AIkfbCVyX2ODn0vFgRZljE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLeTlVhqGaH8r7YzabzwexoH7S28Ez9ImQhpgvdWNByrM2cHo
	L6UFwQDDFIvg4K9daOzXXkZ4T/FIBzAKp3veEyqlhvhD1tqe7bEfHazzJgXg+eXXDizpsfKImel
	fTnE8R2puOEzEZSD5HLx7uGWGyhM=
X-Gm-Gg: ASbGncu/oxC3U7b1SdfdOl53r2HjsJkEf/mWm+UHbSWI5lp24FefvmlSkwV6QxGYfO6
	CRr/bGZKqlPeZGTZQsIK2oqqDSHCQ
X-Google-Smtp-Source: AGHT+IHBo3KFH8jkIO5SbMSbUey4I9GnEZpMOVORzkoe2iFn3uMqC81/CgEeGD1vVAPrpQqe1U+NlyQKRj5OYiNbdZ0=
X-Received: by 2002:a05:6902:2784:b0:e38:b3e0:5006 with SMTP id
 3f1490d57ef6-e395b89c79fmr6453581276.15.1732798188333; Thu, 28 Nov 2024
 04:49:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405161042.260113-1-cgoettsche@seltendoof.de>
 <20241023152719.24118-1-cgoettsche@seltendoof.de> <CAHC9VhQ+SmaYB-1zz2q9j1XJeAFaY+emn_KoNiXxqJDt6wjT0w@mail.gmail.com>
In-Reply-To: <CAHC9VhQ+SmaYB-1zz2q9j1XJeAFaY+emn_KoNiXxqJDt6wjT0w@mail.gmail.com>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Thu, 28 Nov 2024 13:49:37 +0100
Message-ID: <CAJ2a_DcHZMkGuwPm69xD1VGnJe2Qjjucn8qRNJ65aqNS1VBAYw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add support for xperms in conditional policies
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jacob Satterfield <jsatterfield.linux@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Oct 2024 at 23:20, Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Oct 23, 2024 at 11:27=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Add support for extended permission rules in conditional policies.
> > Currently the kernel accepts such rules already, but evaluating a
> > security decision will hit a BUG() in
> > services_compute_xperms_decision().  Thus reject extended permission
> > rules in conditional policies for current policy versions.
> >
> > Add a new policy version for this feature.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > v2:
> >   rebased onto the netlink xperm patch
> > ---
> >  security/selinux/include/security.h |  3 ++-
> >  security/selinux/ss/avtab.c         | 11 +++++++++--
> >  security/selinux/ss/avtab.h         |  2 +-
> >  security/selinux/ss/conditional.c   |  2 +-
> >  security/selinux/ss/policydb.c      |  5 +++++
> >  security/selinux/ss/services.c      | 12 ++++++++----
> >  6 files changed, 26 insertions(+), 9 deletions(-)
>
> This looks fine to me, but I believe there are some outstanding
> userspace issues that need to be resolved?

Hi,

I know it's very late in the development cycle, but I wanted to ask if
there is a chance this could be merged for 6.13?
The userspace patches are merged and currently part of 3.8-rc1, and
these kernel changes are quite simple, since most of the needed
functionality was already in place.
I created a testsuite patch over at
https://github.com/SELinuxProject/selinux-testsuite/pull/98.

>
> --
> paul-moore.com
