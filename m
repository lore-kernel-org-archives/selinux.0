Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5A3191CF
	for <selinux@vger.kernel.org>; Wed, 18 Feb 2026 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418197; cv=pass; b=CuEm8WTQiVYgdliLZDXIJf0Pvj6rUoc5KLJd5s17YL6OEtv9Zg25RLs6qD2jXCyf4kG3Xag92x15QDTF9WBnYRUO3UGloj3Re5VXUk+Td0zdy+7CLl7lY9Ic6LxbFXoGMHGULMF7fT6MfU4pDXDdoNGA0hv7uGNLZXtiscGEgL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418197; c=relaxed/simple;
	bh=0fG8sI+zWvMFlOr7IghYSSJ1KnweFDqAywl+kGXxNz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNglF6XFYe/EIC3q0XjgNFHMWGJqhJwuVB9CLRhMrOMUjUPc8FFC0WRh+tUbmEGZVvaT8n8UFRppH4xFE8QGe4CxXc1nnRgXEdK3/G4yGXa+m5wlEWpQbHgfCkOzdVQc/818VBYg//MBthlrOHpAKTpwrN4Po0arBUXt2BXxHLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CfF9nROM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOPvrSFF; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CfF9nROM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOPvrSFF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771418195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lUydylowWncnRbTO/OJoTPHGFixcaTcELf8O4xesYA=;
	b=CfF9nROMhuopjBBssjZcKFYAaRdQXuToNQzmtAUnKcprTRbhRVe1ZnfO/Z4BzCb1FgOzqK
	WEl8vDRUe45ZkArUSlaGMrwGDn0TOHLy16t8ELG/O9x0c/7GTWl3TkN93636tvv21mZ72b
	XSvzMEle6d6ndT/4nlMvCiLb9QoLNX8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-NzUEU9t-PWWvHphmn3r4PA-1; Wed, 18 Feb 2026 07:36:32 -0500
X-MC-Unique: NzUEU9t-PWWvHphmn3r4PA-1
X-Mimecast-MFC-AGG-ID: NzUEU9t-PWWvHphmn3r4PA_1771418191
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a76f2d7744so57981905ad.3
        for <selinux@vger.kernel.org>; Wed, 18 Feb 2026 04:36:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771418191; cv=none;
        d=google.com; s=arc-20240605;
        b=Ro5/hd8i2alpt7OhjG+qnBjgtpyGjO0HohfI6vmqlQF9p7pOcwNEPGhKlLY0Qusuwj
         epLSCNM7fJ9IRg8QhZZ+BdxIQBz12EuhzurcIgh6wd17X60iWLU9c0c/mLZfWKCFMd+h
         9Kyc4fr2CEht7hRRFzenuoCyhYtWjwYFs3riWG5d0IhsEIVojEehut3O1IsbXgHLwtQL
         n7TdR+LEAJwqGmRxazYEU7REfGILP5DMMImIjaDelT84+OBbL27M+127g/BQjPXN6gQK
         6wBisbhnOSjIhLXhGZYImmjfhbaOW6pfxyeSR3zRfNTXvvzFJJ97c/20bKxXOaNkCCgp
         Qj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/lUydylowWncnRbTO/OJoTPHGFixcaTcELf8O4xesYA=;
        fh=sL0qrILDRdj7tZB2HROVegoVj8ciL7CFIwuAvWctTuc=;
        b=QsIQgHORQJMYFQzTEqXM4y0125CZbbVPd7Qdo6dPku7q/A/fWrWcK/VRXIqtaGMvHA
         TPDUEhVHc70eAGgesfSEGKwJ6mqzC7ifBJ8YFC8dWR2ttqTgeL0I5T7p3J0Air7ZI7vO
         /b+aOts+b01rRlZLIJm/zlez+VdQs/jWKDfn5W/xJBukCGtCQbRUzuoBh6DBi1F975L2
         CebISAX7yXmhpp/9BncgynHCVXb4ziLAGH+6PsZzYfcslH55TzWt4eg0AOyMn2fV7J/u
         bgym6FEdIiPJyfBgaJy46gRNUh+Ca8EFhAtmDDuUKiPhpHVRSf5rHGxWK9mmf9NckyFH
         duUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771418191; x=1772022991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lUydylowWncnRbTO/OJoTPHGFixcaTcELf8O4xesYA=;
        b=FOPvrSFF8bzz1Ja+OiZEv+rXfuVir/toA3cAmiieNqo1OgDIlCdscjGZKV9DnluXtT
         KkRkT8Weg1vgmFhTagcYY17mLgRXBP9mSyHuycCDkasVyh19FUeqnLhylWRGjtPF0tGA
         ypszko3iyjVMYLOBQQ4Mz6ivTUatho5zNWtgIV6tt8KtsXvnSzs+J4mZ339oqLLrGxr+
         4fwW3AO+5aAy/9uVXbMtxXpW4eHuyg3YVlmOGPY/vM/tiiQWfGhLQnLiGKwjhIPYI/+R
         YWS6P4d8e+TUc1LT/enVZuHOFv7JnOZHXoz4zlpj6ygw82Q9Iy7wUqoR0j244cUxr7cE
         Nvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771418191; x=1772022991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lUydylowWncnRbTO/OJoTPHGFixcaTcELf8O4xesYA=;
        b=p6nYB+PyrSuowrg1sGF6KLdGRqUKRDw1OzmJy4GVrpZDf1YeeZiBUWiUwByGmKIiQR
         7HXmZZP8a4Z+I7WEKTuyRkcn69tPjyAcwMI65GNIK+uUQgG3b++9z6R8Bi6YAvVqRp4X
         s5ACavFwGCDdI97Wccuk2FTd5S+K87xZj7hYnkmjVoAPJhuevQQC7oNMvxph6yvjvbey
         v9tkEd4RFxrrFHNRjpXTc+rXTHA+cmNQ9BNSx9ScBVcyEIwzdTzVJNW5z+fyLx2jWLKU
         eMeV+Nr3w/SQ5N7WkHzvAqSXRYk9VpYkTG2isLben9om3ce270Oj77XGq8JpM4+4xDem
         52EA==
X-Forwarded-Encrypted: i=1; AJvYcCXUmPjia4Sz3J2E/dmBDeMgEeb9YW1Czc0rBKZPFqQmR8UXhBSTrPA9ryQvYvUNsVZdIpvsIJNK@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoWJsCDKdFXhdtruy59HD327Tge6KLN3PmgbRURnlwtctHMyM
	tY3AYI1wfx1Qyeoqfzpc8zujNw08Xc/JmmM54F33udfwGzAmR+CJEzgVdJIn46hQljSZ7BqByYE
	maoGsLZFW11mSX2HtyjCdrNBpjiM6ineMuu39EYhZVFs5fv/vGND8yUd0FfHQGotsmsXQPhwQtE
	9sFP1UATZnbi/i94Bi3as/m30bsxaPUNjIlQ==
X-Gm-Gg: AZuq6aIxLBLl4SOlWCde+7+VYjzI0NhN9jkECJY1mKf56H3/6Kwsv+zXuD80s28ZM1a
	B/H8Sax9GMBkNEyfmHN9z5A4JY1xY/6gGszucudPGzz8YZ3wwSJgzmt/lDHwEeCgCMy3i8lgyCG
	3g+JPV6inAtKLaQ7NogF6y3d2V92rFResakPtLpEPrYwpzjrtsL7dlRcU4B8RTaGIwlyMyMJWmo
	i/V
X-Received: by 2002:a17:903:1a10:b0:29d:a26c:34b6 with SMTP id d9443c01a7336-2ad50fbc316mr16329885ad.50.1771418191212;
        Wed, 18 Feb 2026 04:36:31 -0800 (PST)
X-Received: by 2002:a17:903:1a10:b0:29d:a26c:34b6 with SMTP id
 d9443c01a7336-2ad50fbc316mr16329765ad.50.1771418190809; Wed, 18 Feb 2026
 04:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
In-Reply-To: <yk2qcux2ee7afr24xw6p7wp4t3islu64ttfsrheac2zwr6odnw@kmagnqbldb3f>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Wed, 18 Feb 2026 13:36:18 +0100
X-Gm-Features: AaiRm51HYWR6w0-EcsphJc410XncNKnjGKv9rOIgL6E3XvZhdcve7uAr9h1HcsM
Message-ID: <CAFqZXNswp_bKq_78PgVpToK1Zm36ZL4atqiid2Lstaqa0sKnBA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fanotify: avid some premature LSM checks
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 12:09=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 16-02-26 16:06:23, Ondrej Mosnacek wrote:
> > Restructure some of the validity and security checks in
> > fs/notify/fanotify/fanotify_user.c to avoid generating LSM access
> > denials in the audit log where hey shouldn't be.
> >
> > Ondrej Mosnacek (2):
> >   fanotify: avoid/silence premature LSM capability checks
> >   fanotify: call fanotify_events_supported() before path_permission()
> >     and security_path_notify()
> >
> >  fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 27 deletions(-)
>
> The series looks good to me as well. Thanks! I'll commit the series to my
> tree once the merge window closes and fixup the comment formatting on
> commit. No need to resend.

Great, thanks!

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

