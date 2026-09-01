Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79583803E8
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272306; cv=pass; b=tK/THR7CBSM1wRbHu1BVHnJGxQsfLlGx+b+O9L6cSdr0ob0WBi1/84ytCu9f1YdoZVlf4yW2MP4dDe6pbfO3fBW+pKB9W5zmchQ7gWFFMnl7SdBAxeC1Sq8kGkJZQtGYf78HVVyKFZd5L4NbqqbxquNhk7xV9bv7CS79s2jROKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272306; c=relaxed/simple;
	bh=gPPmAMxmqBlTm+w1eKl1BQ4f0f7x9tBFTBUSx3oimHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTzUKEH8CMSzsayS9n6QDLVq8cSkETH7iX1HXtRmOZcFxTivNfYPjN0XjpYxQ3TJvnPuy9jL6CG6SAAMnHv6PiXgLAuxgwhT0/0yfOdXljpI037MF+s8ZrCiGXzbzrH8sljqYJatiAhh1wVhWyasF6O3kwjrNCF0+oHMSvI6NTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikRySx53; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikRySx53"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-451a49abd8aso796369fac.3
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 07:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788272304; cv=none;
        d=google.com; s=arc-20260327;
        b=nF/zccUmFU4uaZ0dGOKh54VXn62FZRrwSM7ZCsidTP7+WsHVMcITbU6M3m65uU++qS
         dQcggPVakvDCAQnZ/iN0nWQ5aR30140YZv7f0ochFUo1nZigq9JmEOgEOufUz0HRXysd
         AFJMqcHzjAEeNy9CkQF0Q6BhYdgtyjyw+l7vAagVq514zVRGXOqrOpFE7vVAVZE9k1lC
         TXfvY/87SK+hCEjyh0xhyt+xJKM9WGTDu5BLt8FqGZ0dUFm/CDj4mOsOJ/5eIbhSkRvm
         s7yb08L8flmvnWjt0M15ofzGs92LIrItIwFaG/0S6od4BHQq9TH6fyKFcd6yLJURjF16
         j9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gPPmAMxmqBlTm+w1eKl1BQ4f0f7x9tBFTBUSx3oimHg=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=Ma9iKLkDVVZRlzpYeGiA7CQO1XgARZj0gSIFdmWb1GGTiw/idnYtaL45oAp3fryQV7
         mgmeC0dGO3VJkCP6WRHP3vwWjZMgVmJVmgYByVCv6o0SU2aPEprTtjl0XiVX+i2yL3iH
         vCx1fBCgzdNFQ6P3ij8MX1bnjHjgOwYtuCIhT119Uh8h5yoVAZFQglslprw0v0Vo1hXB
         zzouzI1nFeM9MvAkCjZKcNObkfYNGKMWs7FtrUw5c5YSESG4+6nDkrz1GHSSC9ZB/h/t
         O3kD5Aptw3O8AXJyieExBwwLO9U/1i9/AQ1qHxU0YF/AksiX1PTA8U0lesTNn25frk5y
         6KbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788272304; x=1788877104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gPPmAMxmqBlTm+w1eKl1BQ4f0f7x9tBFTBUSx3oimHg=;
        b=ikRySx533ZiZsRODjVurhv4f3slM8QoC+/HlVsOf2CvqtHguttn2Y/9IJzKDF5EQL2
         hhrjo6V42GC3hbDdS38MnL1TE46qBuYEwg7HvSnlv1qqZSbJp9R/rwRuqJBfig9gQlV/
         fOCLqTOigcCGEgiyVDTJS1OXvK+5B0ISPbnt/tMA1Af9TAOoF39jOre5LwEgqrdhtEWx
         r+BMFBRxCpK5cndedymqWQ0qxXs7ckFat2SSmoIbhXkMDne15dz9fA4u4KkerwfrIUMn
         EdujY6iplKy2PquHrjBD13Z80D+onMBncBe5Ag7AXog7AGepA5mu/uGhLfq9ob4dORMm
         O/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272304; x=1788877104;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPPmAMxmqBlTm+w1eKl1BQ4f0f7x9tBFTBUSx3oimHg=;
        b=iPxiFr8Tm/mebzoC9ukjl51wyDJriMfNUP4QUEEV79ka7KppmL5LPIlttSFndutu7w
         OjKGjUxpSrvRrXwcwdhND17VOqVdjzoOS+1WqLVN0UbKc56CYboRYCB5Gct3dq5xF1bl
         HdyD9I14SywBVUBYAVmn3Sy5B/GQuqJbceilYqLkMBmFaX1jWg8b684QZ4txfgku3Hjq
         /XOeJbNpghh/E/vpFBZAfALBqwjwH9sWsb/OIn78791Pq+oX47qmwZZNMCUz6YMwZ+QF
         t56yf1T8zMdVaQ+0+guT4XjqFdaRa/wkJQ7oZawN/k35ddxxgRMhGHw//YChIM06f8el
         mMjw==
X-Gm-Message-State: AFuF++mrMp3ZvXkroswvM5dFKjhdgRfAU8r/2NJLLzzusS3/XNgNzb2G
	S/EtRCXHZGepCybKT2im7nWhMA8PItMNS+Bj+uQ5bctBXxh5pmB6IN+zz3un+Rn7J9QJfre1l0y
	RALl/aO0OBa/6Fu/V3fmMT2kGLjJDjgs=
X-Gm-Gg: AYBFou3hkLvY12N+OuByRCnWcV7oxljdC5dW5BKY0iqlvpExRr5tzPL195GPqpz+BYt
	+7WSRrx2FsWCRzAhgX+h7YCqzJ6bzw/UQIGLRTXhXW9MKWAV53SLaFsTkubzBx4NxDqUaID/RtU
	tCvUnVALcPt8HIPnlyWwLyaCWZKUAGCC1Ja7UIB1jcnhorb6Chn8T0oaNhQOS+QGdJ4Qqlg79NL
	h4qjpeU86uljZkEls7waZm30Zuwy/jJWaP8H1GozFpPN+pEsXDm/ypAEOdQ9Ny8lOj9jZOC8NPz
	HWbbQIwCwD2KHeGDqaw5MYv00yIBuWcBqeGv3guPVCkF
X-Received: by 2002:a05:6870:4193:b0:45e:5f81:a135 with SMTP id
 586e51a60fabf-46837e0e9femr34075680fac.19.1788272303662; Tue, 01 Sep 2026
 07:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831185851.80078-1-jwcart2@gmail.com> <20260831185851.80078-2-jwcart2@gmail.com>
 <CAEjxPJ56CmGPWJyZRgPa=eEwiugUcx-q2LUs6=fcR8ssgSeYFw@mail.gmail.com>
In-Reply-To: <CAEjxPJ56CmGPWJyZRgPa=eEwiugUcx-q2LUs6=fcR8ssgSeYFw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 1 Sep 2026 10:18:12 -0400
X-Gm-Features: AcwNN1WNeGNH_nhk0StS8_MChxsJLOoHbrSWyogyK7m7k-FSCGJFL5Rx6JlWaXA
Message-ID: <CAEjxPJ5RnReLBPi9dsv7EK3seJThiwFZtPbb0DgO173333=Vbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: Check for mls components in non-mls policy
 during validation
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 8:26=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Aug 31, 2026 at 2:59=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > For non-mls policies:
> > - Check that the level and category global symbol tables are empty.
> > - Check that the level and category avrule block symbol tables are
> > empty.
> > - Check that the level and category scope bitmaps are empty.
> > - Check that users range and default level (both semantic and
> > expanded) are not set.
> > - Check that constraints and validatetrans rules have no MLS
> > expressions.
> > - Check that there are no range transitions
> >
> > Fail validation if any of these checks fail.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
