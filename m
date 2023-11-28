Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKRw34UY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC02D4E
	for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 01:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701163350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNgPumlfEtVgGw1gVcCtr/F4lDGa9VIk+GTqFa0pmOI=;
	b=gKRw34UYRhJCx5Rf9kKiLkhMG5arYNmHtUQdjKIzIeITfchiGYHVNLke8j3ayUFcCWf8Ru
	x10F7DVwFLBsHkdfJdPstAe/nKCb8xuEqYOUPIfLFFznAnK3vtIe2cwZMr+cvGpwn68M3G
	uOO7NSz9wIKNQc28qB8jXatb7Fk/8FI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-kfQPeZPZO_qJ4Oq9JpcwyQ-1; Tue, 28 Nov 2023 04:22:29 -0500
X-MC-Unique: kfQPeZPZO_qJ4Oq9JpcwyQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2859d0d09a3so4710002a91.0
        for <selinux@vger.kernel.org>; Tue, 28 Nov 2023 01:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701163348; x=1701768148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNgPumlfEtVgGw1gVcCtr/F4lDGa9VIk+GTqFa0pmOI=;
        b=ocf7BiIacexzMOsrlIbHR+OFKgC3BWqqH0Jja/kLLqS4pX2FTgS93bhmlbXleWC1CL
         DOA4MMzeQLqQ2CRGpJL6QuFtGPdWZeQe2tH7R48PlZhsU5uSJk+dV0mMWUBJ+DZ8DWe4
         vd3TGG2fstU0h9sYjo3vfD5xQkxzl/OxVpcF+zcpqOmeZf+jVuhobUJOGUgPM4AXpph5
         dj6SQb+kOExnFWHsGwi3s92tfCnPRlBZN97cYhGcsfT//w+VFy2bODBd7C3EItix2Psg
         qRW+Pylzlj1oa0IkmKZUnd1pZe7pEevemzBfyu7NFf4+4YgQw1Ej/QDgLo0GFUcno/uo
         oaYA==
X-Gm-Message-State: AOJu0YzJAYkFc6IfUE2ZNT5PMsKorN/4O+Dk0qJSd7tG8QuRWxb2F4qB
	ZU3T2C/QDCUwrDlX//fSy/dF7i78TL9ukrO+0c4MYfAvm3xcc20RO2VM+z80HlixTN+7+KG4F04
	x1Pnm+EHMGKfW5jry41dtA3IIeFI/2z9PHQ==
X-Received: by 2002:a17:90b:4a09:b0:27f:f61c:327d with SMTP id kk9-20020a17090b4a0900b0027ff61c327dmr14129335pjb.0.1701163347974;
        Tue, 28 Nov 2023 01:22:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDCd5qkERJarIe2VecWwm2YCzZEBKGVUJ0fTC8q8oXvkrEQxUFrHzJvReo9S4y5wz58KpInzRhOuYY/EpxP4Q=
X-Received: by 2002:a17:90b:4a09:b0:27f:f61c:327d with SMTP id
 kk9-20020a17090b4a0900b0027ff61c327dmr14129327pjb.0.1701163347750; Tue, 28
 Nov 2023 01:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127173534.1080-2-alanwandke.linux@gmail.com> <CAEjxPJ7yi4vs16bKaxErYNd4tDRE1O3Utn73tApNsFdy1pa17Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ7yi4vs16bKaxErYNd4tDRE1O3Utn73tApNsFdy1pa17Q@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Tue, 28 Nov 2023 10:22:16 +0100
Message-ID: <CAFqZXNtGB=Qzc_p1E-HEoUhP25-O8Cqu6P_zGdyCu1ti2hNHng@mail.gmail.com>
Subject: Re: [PATCH testsuite] defconfig: add NF_TABLES dependency for
 netlink_socket tests to pass
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Alan Wandke <alanwandke.linux@gmail.com>, selinux@vger.kernel.org, 
	paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 9:51=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Nov 27, 2023 at 12:36=E2=80=AFPM Alan Wandke <alanwandke.linux@gm=
ail.com> wrote:
> >
> > In order to support the NETFILTER_NETLINK protocol, either NF_TABLES or=
 IP_SET must be enabled.
> > Neither are strict dependencies in Kconfig. Fix this by enabling NF_TAB=
LES in the defconfig.
> >
> > Before:
> >   ./netlinkcreate: socket(AF_NETLINK, SOCK_DGRAM, netfilter/12): Protoc=
ol not supported
> >   not ok 3
> >   # Test 3 got: "256" (./test at line 25)
> >   #   Expected: "0"
> >   #  ./test line 25 is: ok( $result, 0 );
> >
> > After:
> >   ok 3
> >
> > Signed-off-by: Alan Wandke <alanwandke.linux@gmail.com>
>
> Looks like we could enable it via a number of different config options
> but we need NF_TABLES regardless for the secmark tests in inet_socket
> and sctp to run, so adding that to the defconfig makes the most sense.
>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Seems reasonable, thanks! The patch is now applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/fa65d2f59c4d974e=
f736bc1cd3bfab75b78ac5f0

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

