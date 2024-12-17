Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF781F76A9
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 17:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456570; cv=none; b=E4VCDZbObQl2bDluzy6NnLhdvII2KW2vs48WY3aZPoePV5uXeipXCFrfNMHhVNNjerxEGsAsvl247KuaSc8hvfkEge2ZDjJBmmfzsPd26L8O+XHAjbEO/9t70Y4HvcjLrbMJ+Xah7jKVDqQDq+y7xIvfZkRRZmXz37iP/JACqcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456570; c=relaxed/simple;
	bh=QDRINsj4Oi4eeN2rLTI2X8CG4sHT6bY8Ofhoz/bQzOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4NgQoCwV6Lv19Euprj9lr5GQ145iqnKBcYjfiqUsZPcmR8Q4xa7TWsfIG98AN9e0qxI8pivMr3D1hakVB7dslf+lL0Q9y10o4U94J4xUKEqcYAeKV/C/ZKO19C7pb9+fcQVqAVWcLhL/PNzTq06zjc33gwiec6lHN3mmJsbdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PV5HhdNQ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PV5HhdNQ"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e3984b1db09so4099555276.3
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 09:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734456568; x=1735061368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GRNamvn2x2vHFrh9XHjocSb9SAMLmLxoJunl8gAK+SI=;
        b=PV5HhdNQGFowNqQ8BMTCdFs4jgTBaE5QWTOhIsZx4krE40xlSre2NdtNR59c8FiTOO
         8tC6yIlTdMfNZ3WaneF0MPeRyjAyB7uYtLr0Y9EMARIqI4hhCS0Q6qBOZKtlEYYOkRsL
         z7N4oEgfasXabZNOhcjEFmjDE2fZMOlK7jExj+RmVk8ahJri9o/dChiQUHa8AqpQ2/VX
         7b/Be+A1KkAaB9vTfJc3Z0UeDWPePfKnEj6N8GiYTQgcO52WgUp4xllAQ8+1KMzK6TbA
         eYua1DGlVuc3lq46EHk6F69tm6pGGLEO2ElxFRsQFwI1QovebFVZbaTJfSVeD0lWSsW/
         t7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456568; x=1735061368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRNamvn2x2vHFrh9XHjocSb9SAMLmLxoJunl8gAK+SI=;
        b=Cbp37lI6w6EIZBwzrrZL5WU9SFehouSPyOsiY2iUo47G/7kjuNu66tYjbiDAR1C+VD
         cLG81Y2X21fwIl/jBJmsTgfpajYyMzpklpcxDOKa2PPlxiwhHaZ/pqWngERTa7UzUS+K
         eUtHVsMAe9C/+NKT026hqLOsTb79z0ULUtcC1eS9Ig+53mC/7I38G/rMuN6CfM92UehF
         YPI5tb17ta0yDxHadizOddP0J4mTOIT8ZXkwz6quKGScBfirp1kWjJWPa02lxLPiek6W
         ZcS8KUdqDtBh2l62D5DdXYNn0Ewmj5pjdklubQC8yUWy9VIHkKg4jPYtRauNhZyYESGP
         3R2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWUtH0lnHu+mWnlxdLakEN6gmaGLZRAuMXX8d3Z8uKNmlrfwuVjp2Wy96telzmvUhxj/srtDg5@vger.kernel.org
X-Gm-Message-State: AOJu0YxHaa3+mmb0a+sVIBgy5y2YLh2PPQBilKxCLgRgNrxR+aSCnqxO
	ZuCFINMXKAuoFuUz5pWq1RuOVVbb5xODpTh5CZpUDiVTz97hUuUx56JUzZUCEywTfjmSoGPI+hx
	0IWMOrYwIKnFIxP0SLPv3n+znwrmP8dk/h7tlRt8glljNCwQ=
X-Gm-Gg: ASbGnctkh0VSAtAnHetKRlUvdoHKQdnqC/49DQcMyc84uqzTagTYNkDGsAfOWj7FFGB
	X7p28NpJcyaIcXtNA8lqW11dC6ZVbZreoclng
X-Google-Smtp-Source: AGHT+IGYZRqQ6x4LEuOGXkJzV4h+fN3mNC6kKuOEWPn8yGpB29ClZX7Gq7Q+sYbfOqqpC6IHUep5PSw2fe6iZCfZATk=
X-Received: by 2002:a05:6902:18ce:b0:e39:7269:372e with SMTP id
 3f1490d57ef6-e434b88269amr13917461276.26.1734456567809; Tue, 17 Dec 2024
 09:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNuVK=Pt6Vx8xiUF7WFhCD3VrqjW=dvox4wHWZfHBCEDTQ@mail.gmail.com>
 <CAHC9VhTqe9roT1dySDXDMQzbOSZyA0f34H0a1xinDSLd-TyQTw@mail.gmail.com>
In-Reply-To: <CAHC9VhTqe9roT1dySDXDMQzbOSZyA0f34H0a1xinDSLd-TyQTw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Dec 2024 12:29:17 -0500
Message-ID: <CAHC9VhTTGA5LADsn4OxJAUkd4V0auS4LrPQs87JqmRVV4nraxg@mail.gmail.com>
Subject: Re: kernel-secnext aarch64 builds missing?
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: kernel-secnext@googlegroups.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 11:28=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Tue, Dec 17, 2024 at 4:17=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> > Hi Paul,
> >
> > It seems that aarch64 builds of the secnext kernel stopped appearing
> > in [1] some time ago (and kernel-secnext testing results for aarch64
> > stopped appearing as well). Were they intentionally stopped or is
> > there a problem that prevents them from being produced?
> >
> > The new Testing-Farm-based selinux-testsuite CI matrix includes
> > aarch64 + secnext kernel, so it is somewhat affected (until [2] it has
> > been quietly installing rawhide kernels instead and passing; now it
> > will fail when no secnext kernel is available). Any chance the aarch64
> > builds could be reinstated?
>
> [NOTE: adding the selinux list since it is somewhat related]
>
> Hi Ondrej,
>
> Yes, sadly for some reason Fedora Rawhide, which I use to build the
> kernel-secnext kernels, started panicking my aarch64 system *hard*
> after an update some time ago and I was forced to disable the
> kernel-secnext builds.  Unfortunately the issue appeared to be due to
> some userspace, or compiler change, that affected the entire system
> and once my build chroot was updated using dnf the entire chroot was
> bricked.  I saw similar problems on my aarch64 dev/test VMs.  I dug
> around on the RH bugzilla and didn't see any reports, nor anything
> obvious via google searches.  I was hoping to go back and try to debug
> and/or restore the chroot and VM but I haven't had the time.
>
> As a reference point, Fedora 41, Alama v9.5, and Ubuntu 24.04 are all
> working fine on my aarch64 system so I doubt there is some hardware
> issue.
>
> Are you aware of any nasty aarch64 problems in Rawhide, either now or
> starting back in October?

I'm still interested in hearing if anyone has any info on a
aarch64/Rawhide breakage in October as it may help me recover my VMs,
but I just now tried creating a minimal aarch64/Rawhide chroot (only
installed bash) and it seems to be working now (!).  I'm going to try
to rebuild a new Rawhide chroot that can build kernels and see how it
goes ... more info later.

--=20
paul-moore.com
