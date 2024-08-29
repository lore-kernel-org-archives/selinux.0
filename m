Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138A1AB525;
	Thu, 29 Aug 2024 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937181; cv=none; b=MrARni1DepMroT+iCLK58HuChIHFHkVVMvEzsOQdA1zy4irx/wSggRs123QqsWwpbJNgrmUkc7s3hd9jaVrKNPDjweJWW/BPlfZyq5gxTLndaPyGnYXKSKrk37Ej2GddGl11u9v1g6Auw8zK0MvEet1hH5Crq52lQ4Vo2frixcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937181; c=relaxed/simple;
	bh=jPAkoGRjZcHo/1fgEKoJcccMGLG/ZQgB0RESggia6JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/YTvBNTWJqNbPpq5B/EYhdE0Un10PexY1ryQxhsmqovEvgfWg2Y22z/WQqpkk5KAQsAVYVz46/iFAs4ODGQl+peak5ipCJW93YhNMAQjAwh/aC6VUVOIAkZAzwrF4cbGQkPmWw0//5L9WdE3CFq2jhlbaO/30jCHYJ5HN7lrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcXpPVZN; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcXpPVZN"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso386645a12.1;
        Thu, 29 Aug 2024 06:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724937179; x=1725541979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nw/PlB3iBUUCd08RIiUBBIwFxd5QJyFx8v9oHUtn4cw=;
        b=lcXpPVZNNJ1pV+AtEHYJ5OJCKejzgZufnQDdZ3gPsC1eSpmGvj/UgxC6b5sLncCdnI
         37K+dqyol5VAaL8WTE3vL7Rw4dUK57kMgGsNqBV2ESKklNPpO0E6gDUx60EPwbDhaAhz
         8MslUPL5lqPxVVi1gKEV6Hk5yS5VzwWaBzISlUXFdCl4CKQJBrrbUybM9aRCHT34mIkv
         pt/Z0jYUp8V6hnrX8N9trUCU+a3epezu/wf9T/L09CzaRFZc2IDtb/Pn9AA1t2k+M7wA
         PNntmlkJ9evxVuBKDWJ5RXcu8D24Kx/gp62bZTkv2RBObPvT4SCFsMRrlNGFbnf41xc4
         1BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937179; x=1725541979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nw/PlB3iBUUCd08RIiUBBIwFxd5QJyFx8v9oHUtn4cw=;
        b=TMDXyP7SIQzBArxvL4Fizh036pZyXD8MzcAaWMdqJ9SgHdjpV7i4eJVRKhhR+6VXjj
         gR6Q6gpSb3/vdIKI1Povnkyd7qROa/B3PR63c99HkihCx6fI1PRxcW6UwESn+PuDDAeQ
         Z/nUGafuDfKih5eJwxM0Ek18t8Rjk0EXzY8mIUFq1somT5mEbLbIAW8lZsQ7BP0/dOWM
         SbvmV4Gk6uLa7OG8MLZTQVpCoEJura/kNUDrKwCFGO0ZOcjVJ2TH8y2cIlyfTNRbwjLx
         mP/kYM3CwLmFih6UmZ1d2j0Z1t9lCNMN5ZVtS2yZaupqOYFKKGdQG4YJ5HI3omhphSIw
         P8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUIkkuvYINxqnFP7sUSc/5N4Pbj98BJo2O/W9k1aKs5g+QMJxKpIt6f+uAZlRISs/ch1A5eBURWV4ZwVBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tQGnBmdKqGSCHOjjBcg2FVWpxMbZUxmM35tSPb9FnIjCTKaN
	eI+PeADAqzVZfTBNsKI0jHUesBHNR+PBTcS/50V69zmZo10OFrdrLevI2gc7qdK09oNIy+p65RT
	kMxo+e4CV98cIK0JYzyEVUFRJgX0=
X-Google-Smtp-Source: AGHT+IHTwk1Q6RFjtjxlxC1Sr9ZCVcOaKk7/xV9wDO/2hI+fyRyAlRI0tMIvaGm2cazBIf5PnUSXM60o1dAmm7jSXGw=
X-Received: by 2002:a05:6a20:e617:b0:1cc:d2d9:b407 with SMTP id
 adf61e73a8af0-1cce0fece54mr3095163637.4.1724937179113; Thu, 29 Aug 2024
 06:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405161042.260113-1-cgoettsche@seltendoof.de>
 <20240821130755.25031-1-cgoettsche@seltendoof.de> <CAEjxPJ5C+e3WKeQumo0KO8+Ge4iFR8gKUyfnJPxX84_EKGjh9w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5C+e3WKeQumo0KO8+Ge4iFR8gKUyfnJPxX84_EKGjh9w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 29 Aug 2024 09:12:48 -0400
Message-ID: <CAEjxPJ7aCaUnORtePpZdFLq7swg4W5+y1hr3mQHcU1_BB4CQ4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] selinux: add support for xperms in conditional policies
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: selinux@vger.kernel.org, cgzones@googlemail.com, 
	jsatterfield.linux@gmail.com, linux-kernel@vger.kernel.org, 
	omosnace@redhat.com, paul@paul-moore.com, xiujianfeng@huaweicloud.com, 
	tweek@google.com, brambonne@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 10:57=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 21, 2024 at 9:08=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > >
> > > Add support for extended permission rules in conditional policies.
> > > Currently the kernel accepts such rules already, but evaluating a
> > > security decision will hit a BUG() in
> > > services_compute_xperms_decision().  Thus reject extended permission
> > > rules in conditional policies for current policy versions.
> > >
> > > Add a new policy version for this feature.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > > Userspace patches are available at:
> > > https://github.com/SELinuxProject/selinux/pull/432
> > >
> > > Maybe the policy version 34 can be reused for the prefix/suffix filet=
rans
> > > feature to avoid two new versions?
> >
> > Kindly ping.
> >
> > Any comments?
> >
> > This affects (improves?) also the netlink xperm proposal.
>
> Do you know of anyone who plans to use this feature? Android does not
> use conditional policies and it is the primary user of the current
> extended permissions feature. I haven't seen any usage in refpolicy to
> date.

Not opposed to adding this support but absent an immediate user and
with the requirement to introduce a new policy version for it, I would
defer merging this until after the netlink_xperm proposal. I would
encourage you to re-base on that once it lands and also to post the
selinux userspace patches to the list if possible (breaking them up if
necessary). Agree it would be nice if we could combine with the
prefix/suffix support to avoid two policy version bumps but unclear
that one is going to move forward any time soon.
