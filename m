Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7532145B3F
	for <selinux@vger.kernel.org>; Fri,  3 Jan 2025 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735912138; cv=none; b=sukUiZPL6q4EU3Mc21NDRK9059aTEg3RqBfwfiixPoETg9rCBtS8xN+AbHPutAhztRc2HTFKNGTPkzqJ44SMSh6X8E2vXYtc51lkEOn5ejZdWbXefpBPAMsH4qzTZt9e7wCNNDBSA37Pjd1AINNZYJkIaWqUjWT0oc481Rzquoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735912138; c=relaxed/simple;
	bh=6P2g9+q9oXCLxahM9ZXLc5hLUnZ5AfL2SjPS7oCEi64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQsXlp2MnDbOUo3lhJRofle6zot/7j8iEm83/x2r/X03wYf44BJAqLcCkafZWfqSzyTTrGXEG+frN9MSx2qJrG61MVEO4A6AOcXhbuACtlWQh3fQifCncHD/V3wIlOAT8+99vML7BOoES8WsJ6oMuWqvtiXo+kasl3vQ6SDzCx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VR3w/bgi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VR3w/bgi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735912135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNS8JPBlvzugnq1eBI/R3Yt26celG3Pqx+rpgckWBg0=;
	b=VR3w/bgiAgvXYdemds6Xg9i4ASp3uHyVVxwFVxbXiBBWYQFYkGz5D4OY9vQPxYDnw6DgQb
	8hLpvPNV3EZyVQ3QgbXxBdSNZi+BGxX6AqQLPI//0IBIjLdkUVf4PBoaVSBvWrqXGr5otJ
	zI/rj69xvjJHAZI2wDpXyfujWR4I5Lg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-RDR8JxCCN_2GcHt1NegfBw-1; Fri, 03 Jan 2025 08:48:54 -0500
X-MC-Unique: RDR8JxCCN_2GcHt1NegfBw-1
X-Mimecast-MFC-AGG-ID: RDR8JxCCN_2GcHt1NegfBw
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2eedd15c29eso16435068a91.3
        for <selinux@vger.kernel.org>; Fri, 03 Jan 2025 05:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735912133; x=1736516933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNS8JPBlvzugnq1eBI/R3Yt26celG3Pqx+rpgckWBg0=;
        b=j8/krlRIhSZ//RTSEcC2/kPDUAT0HyaNmwZ5hROIRRW3efPnC1Gf0o0do1SYToGLef
         1hF3WN+kXeugUaRB+/pqDprF6xWIQsGZyPcVhi9k6F+2LvFHe9ktfqpKn+Qt+xWJdDQZ
         5QSsn5K1KSCDOmtoD35Z3yEfWUQnLk7Vr21ynfn0s+g/rzAeJJF0Exl0vs2V9pd2htcT
         dAwUou2THVMMRDVbvEnUTn3Hn2gPp7eBBeZolYl46LyiimRDWfHrQHtpgagSTaAcdcJj
         2zC+4paQXTNS8BPuf1D4RbADn249GxHyuXso19k95ngoxgbEA2qWJrS6YnbAYl+B5wAx
         cu3A==
X-Forwarded-Encrypted: i=1; AJvYcCUsycHekYcDVTNQDmFQxpST6Oh1P5nqzS7nwYggvZ9N8W58UzI5zU28PUd00opXx5uQML+vs4PQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uD3n2IXeBaHc3It6jufPta6rE0bJWV0zE/hKtSJ6TxSj3VRT
	NKxGGAQQrU9ldkuM2W/gJVNfRGb61EXAPD6pYCtjPIxUOZvRvsm43ZDWgx5dSUYD8W2K+WuxwnQ
	O6T0KJoW/By+P3SLD2Nb0PqMYqrVD73U1Vmq7IyW426kjdlq6tSqyvZRzGcvofG1GYAwPke/38z
	/g94mybfs11tYa2kB/DMWvrDHHtN7Zkw==
X-Gm-Gg: ASbGnctwfzoqHDtD+LGZ/msLhJ5BD0HlXPBJ6C7x8ka40XkS8iA4S3iHjoP+zo3DtiH
	1hX0463CXC0TjAIot+aGZYwC66YNbnaHL7nO+1w/fC/jQboQB9u/TIPZD6Z8RydviHVlEibk=
X-Received: by 2002:a17:90b:54cb:b0:2ee:ba84:5cac with SMTP id 98e67ed59e1d1-2f452dfd2eamr74835516a91.7.1735912133438;
        Fri, 03 Jan 2025 05:48:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuAUl1MdsnYIT62lFRWpN7zrmY6yJACwwPMaIEuwbnHr2Vbs/lCiM5Jg9yy2htVqyZq78bDMCKBpkGbEPZSbM=
X-Received: by 2002:a17:90b:54cb:b0:2ee:ba84:5cac with SMTP id
 98e67ed59e1d1-2f452dfd2eamr74835499a91.7.1735912133177; Fri, 03 Jan 2025
 05:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFqZXNuVK=Pt6Vx8xiUF7WFhCD3VrqjW=dvox4wHWZfHBCEDTQ@mail.gmail.com>
 <CAHC9VhTqe9roT1dySDXDMQzbOSZyA0f34H0a1xinDSLd-TyQTw@mail.gmail.com>
 <CAHC9VhTTGA5LADsn4OxJAUkd4V0auS4LrPQs87JqmRVV4nraxg@mail.gmail.com>
 <CAHC9VhTSeC3NAbAA192ZHQsRZe2aYELHM9inYOPRsR31wSyh2Q@mail.gmail.com>
 <CAFqZXNvJAQNLWZ795cj64FVG5zVzYtiTTuFzxOS5AwcfD7kV-w@mail.gmail.com> <CAHC9VhRFOm9DBXMF2SbwBxZqtPrr5ghbDRqcwjX6TP_79xDT_g@mail.gmail.com>
In-Reply-To: <CAHC9VhRFOm9DBXMF2SbwBxZqtPrr5ghbDRqcwjX6TP_79xDT_g@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Fri, 3 Jan 2025 14:48:42 +0100
Message-ID: <CAFqZXNt0KozfAybTnoL39DtOx+kx4QLgGVrA7z4c0aOqj4v2BQ@mail.gmail.com>
Subject: Re: kernel-secnext aarch64 builds missing?
To: Paul Moore <paul@paul-moore.com>
Cc: kernel-secnext@googlegroups.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 3:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Dec 19, 2024 at 9:17=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > Thanks for making it work again! The aarch64 secnext CI runs are
> > passing now. I'm not aware of any bug that could have caused the
> > issue, but it's Rawhide where unfortunately even nasty bugs might
> > sometimes appear.
>
> No problem, my apologies for taking so long to get back to it.  I
> should also mention, in the interest of being fair to Rawhide, in the
> several years that I've been doing the kernel-secnext builds for
> Rawhide, I think this is only the second (third?) time that Rawhide
> broke so badly that the systems wouldn't boot after an update.

There seems to be another issue with the aarch64 builds now: the
latest -rc3 RPMs are not present in the repo, even though they are
referenced in the repo metadata - see:
https://artifacts.dev.testing-farm.io/d7a202c8-8acb-4153-bf01-553f22be2741/=
work-run-ci5ze4l6ha/tmt/plans/run-ci/execute/data/guest/default-0/tmt/tests=
/prepare-system-1/output.txt

Yesterday the same set of rpms installed successfully:
https://artifacts.dev.testing-farm.io/6c7a539c-7616-46c4-a93b-d2a32cd109b4/=
work-run-cioxa3jpn4/tmt/plans/run-ci/execute/data/guest/default-0/tmt/tests=
/prepare-system-1/output.txt

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

