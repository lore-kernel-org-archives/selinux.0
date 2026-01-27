Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C31225775
	for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769501129; cv=pass; b=bQQ/FjKv5s9kua91vpfuC9bYM27DKUOEHosLzzJWuqCiQ/xcOEk7JvZ6Yp955FOadco6XyZSILs4+8wG7N/Owr5QOVPr7tWtn1O7+B98JyRWix1nZWjNp2rNcL3YRr/gXYEIEZEBAE8hMIuoO/7+saWeuAByATWBRf75J0IVIOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769501129; c=relaxed/simple;
	bh=G4lGxEVi8DaJdnFVFXySNwy7fmRjl5ytu108BNBK6LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmLncXaFUgLNHOq9RxY5124Px7JKP4HtMsYl7vf+nJtCWefj6Z9ZGMaBHjvO3UI5ddcTMqeYvMA4UOyBmvM1bplByVHDuZkuX4Cq8aWCTVn8Ku8JEVcpZgjYw3CeO3enpYVjTrudeYz3THi8eO2O33KPDucvqeWsesRfYogHlF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByvNsrwa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oG/K/ixw; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByvNsrwa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oG/K/ixw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769501127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyBS2urlrz3YTfQuUYzzTwivIYXn3/eEJMd3wGNCydw=;
	b=ByvNsrwaUlKbEtyz9I3S+l/iNvZmDC2b4sD3q5xzs1ZNQM1F8apTRtJV288Zvw8smJaOTT
	Mw6OWXGqU0w4qawJEAykBLYFI70CJnbBNIr19W7ci1yUZRCpQqsn9GIBJU0EAd3zOvfI6U
	EV7kdN6Rurs90graQoeKdeAwpOnjK64=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-USqU4xd8OXOO2qAzd8p_0A-1; Tue, 27 Jan 2026 03:05:19 -0500
X-MC-Unique: USqU4xd8OXOO2qAzd8p_0A-1
X-Mimecast-MFC-AGG-ID: USqU4xd8OXOO2qAzd8p_0A_1769501119
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c704d5d15so9965508a91.1
        for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 00:05:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769501119; cv=none;
        d=google.com; s=arc-20240605;
        b=h3E6p6oTSJ6iTeeEzbmOA++hx5stQ/hIGHOxxEhz1ZgvTsKhnH4+aPxlXj8kMdjBxa
         C8E8/mC1v5jT3q/IQjMu2Rr/+LUZzhCrkhw+f0+hUKrvFvmPp5MhOTN3JAdRx7USVfdw
         5yj5Fsl6AMp3+VFKD5Hw+KOFc2a6d3HJ6HbobKmIRFLXq73ETdC61HKJ9dpZVqsyMkSx
         TuERYRNEyBJKulCNWbVSMpjqKp4dtlJbVjWP3uePLRorzhQ8xaYrkpJ4s63jc4INZBaj
         UFEYWLgnJDAhKT4nPoFinAii26UJPNIoocvDXbPE/kj/VDhdz6p2mYIjF5OpUUNSV6dl
         Q0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yyBS2urlrz3YTfQuUYzzTwivIYXn3/eEJMd3wGNCydw=;
        fh=3QBHvDPMWDYu1Cm9frkKTtdyU7DwdpFb1IbQEZ5Oqvc=;
        b=A45y0/r6hYAgygLiDAsKOW5UmHxYwOiUpl2ryJnsvC+le/JJrAEQMJggEXjjS9zphK
         lWRvAlXJnee67CI4TrGWM9Kvna0r13qy9Z72eqp2ES9z1kOaijzSqnuRqlu4RP1FYaP2
         PSbpKd4WVMNvZqTeaAek3Sqn8M6F509e3iUTjUhnYSVIGraKhpEbUms9ODMuJz5Bl+Cg
         MdAsNuSlEUY/IHdhTaZJXMoNe7FUS9CX+QCfmxesOeqDN7qL9jb71V9/UwRdtpXoqwaB
         Zm5koA/fbnoxDwmTkfV0D2mOA083JcTuVLPwOS6sso5+rM6cxx8kKn+2l0+aUjj15Gyy
         nuhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769501119; x=1770105919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyBS2urlrz3YTfQuUYzzTwivIYXn3/eEJMd3wGNCydw=;
        b=oG/K/ixwDyaCN9uI8N5rDD68O97AuUAPTB3o6ErmGuLOdRdm+GcMIVwWhnOmey1aA7
         fqUecH+GL5sZ0fCL8M/v6N3SqUQoyKUbjD1VhOncxlH/2SFMWl17QEvU4RASTVVpBWUt
         N8BU2+m5XbQ6dW6eWBJqeFiAcfpYoLAsjlnAooJKF+CncF1srEAkaFeparcxsoVSgezE
         +N31/zJMIZ/NsbPzFxs4ptiPUHE3a9nrDozDpCVE8MMINtfy+Nh9jQkissXdX5MKv9yx
         bZEKXt+R8Wi6cuMhhY1BEIwfGugqYgsXGTrbMKRwKIEhZUH7aYP61g0F3D7QrIg06iVR
         c/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769501119; x=1770105919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yyBS2urlrz3YTfQuUYzzTwivIYXn3/eEJMd3wGNCydw=;
        b=WZSC/kzHCY7+xbbgWMZVBB+ZxRLcbia0CSWjFPf1vYbuFKg0kQ4kkqXG1/It9db5US
         NIPOi86cPdgBOXBHc0ZUe90e4Kes5JSbnPP/dtBMu29H3fNY1SSpFYXGZsGuTs/wtsZ2
         fatb8XJau57SPw7stcrbi12Wl30lYUZzAFK7g4Q7q28/+sfw0Y/hDVwNx6TwMCkf1hdV
         PdVH3i06RRzAK5aJjKZoZDmRqM7a9/2FuoXA58VaxwsQV4PufF/ukd8oXYyxIwTfbs2S
         NegK4T2oy+aKGY8xxRb+uf1awpK6gTyX+9v/Hd8fbDRSqf6zqYF/oa6FkcVwgpBu9I1q
         m7hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCSJYN5L/nSisb7vciJiA4XDx0f1W5Jrb4rGPurUwwy76MzeJmIbmKfB6yxNTBOjhVmFVFlxrn@vger.kernel.org
X-Gm-Message-State: AOJu0YxwrzVfEn5AnVk21UK21mN8BH0VXj4oQU7wpTp40Mh0F4a1WSb3
	eRTXrpHQk1Ibya/mZzlUjxCk8NO9IJNZ+2/8cPfLdgE0rUHah3fPUfs08jDcH3Uth0pjQ1GOntn
	yyKzZQTGrD/GgyD+Dzui+WxZCwgwGqfQZF5MUWqeMPZCFvUSi4oebE0zJAVwmBz0SwkfKe+FO4/
	RKKxvRGM2iuGhODGk4yEhgiYD07lr0AQeq/w==
X-Gm-Gg: AZuq6aLAGqV10CBZ1rf7dsqfymF8ofZlp8pmOlXlYuln01uys85ughHNtAPJes5vXye
	wL4PWTZ+L48/+90Gmr4obpOpr1DIfGlMkjkXADL4cLzI/hSZgtrmInykbzB3WnaObiKGCVr85Xz
	D9eVhqQVBEtL/jWvv3FNHIdn2H7IqHBkGsrhcypDl87ezwhhPRdjJ7L6OxJH5pg0ldOA==
X-Received: by 2002:a17:90b:528e:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-353fecdcfbemr1169742a91.6.1769501118694;
        Tue, 27 Jan 2026 00:05:18 -0800 (PST)
X-Received: by 2002:a17:90b:528e:b0:33e:2d0f:479b with SMTP id
 98e67ed59e1d1-353fecdcfbemr1169721a91.6.1769501118342; Tue, 27 Jan 2026
 00:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122140745.239428-1-omosnace@redhat.com> <CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
 <aXgZI1td0Hremulj@mail.hallyn.com>
In-Reply-To: <aXgZI1td0Hremulj@mail.hallyn.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 27 Jan 2026 09:05:06 +0100
X-Gm-Features: AZwV_QjIdWSNFQjfHOtFcjMZ9aCAgQ0MC7O6Wyqr_Wu_Rw0dFaUOh0s70eRf9-A
Message-ID: <CAFqZXNve_7oKFWydUrskOcvsfbRZVKyWRmLvHKsTzBhG+RmEmQ@mail.gmail.com>
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Paul Moore <paul@paul-moore.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 2:55=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com> =
wrote:
>
> On Mon, Jan 26, 2026 at 05:52:03PM -0500, Paul Moore wrote:
> > On Thu, Jan 22, 2026 at 9:25=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > The user.* sysctls implement the ctl_table_root::permissions hook and
> > > they override the file access mode based on the CAP_SYS_RESOURCE
> > > capability (at most rwx if capable, at most r-- if not). The capabili=
ty
> > > is being checked unconditionally, so if an LSM denies the capability,=
 an
> > > audit record may be logged even when access is in fact granted.
> > >
> > > Given the logic in the set_permissions() function in kernel/ucount.c =
and
> > > the unfortunate way the permission checking is implemented, it doesn'=
t
> > > seem viable to avoid false positive denials by deferring the capabili=
ty
> > > check. Thus, do the same as in net_ctl_permissions() (net/sysctl_net.=
c)
> > > - switch from ns_capable() to ns_capable_noaudit(), so that the check
> > > never logs an audit record.
> > >
> > > Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  kernel/ucount.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
>
> Acked-by: Serge Hallyn <serge@hallyn.com>
>
> Looks good to me.  What tree should this go through?  Network?

Andrew has already applied the two patches I posted into his
mm-nonmm-unstable branch, so I assume they are set to go through his
tree.

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/log/?h=3Dmm-non=
mm-unstable

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

