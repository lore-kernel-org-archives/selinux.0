Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D259C156
	for <selinux@vger.kernel.org>; Mon,  9 Sep 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898658; cv=none; b=Mlt7baf6kv0dk42jgOJ9Rk4L4lxjXMli//HvY+6lN6MNxn2O22IGLIPOKbbdah6cfbsJag49+54BWtoLs8L02iMDDEijRlTtVjoh1xZph2uUnvmbpGbH+F7RuVgUvLU9Za4bXBhv8r5RXGwpOfc3gzEc5LD3QygB0RSSicY2OJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898658; c=relaxed/simple;
	bh=5euZHCAPx0l5H19uj53Gz6gfAAFyKfXDrC4Wkd8rTYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3O2LAUfcE1o8SJLo2b0E97spD4RIvW1nvE7cfbbvRxUcPhC8Yyw+nnNr7s8f8HTq+ZYKquno9aiLrZsNk75ywl26xZ2hAhanjGWd+VOaGJvHhDD5oylTGB6hcMlc9d7I+Whu13ktErzLA7bx1+T5FSJVqKoP1ZAOt2Njg33YjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H76FuGnY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H76FuGnY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725898656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5euZHCAPx0l5H19uj53Gz6gfAAFyKfXDrC4Wkd8rTYc=;
	b=H76FuGnYXxMUV1PeTnf8VZ4zmEBdDRd5Zxn3XlyShOM3F061NstPjfvsTfBjI3PYCTavoy
	VTy1w+0eKsCs8Yp/HoNveg3pudYxPZ9l/FaptFY73menPSKJQE9NJGrPBk8zKSYHSv3292
	cimwQcJiL1DZElCXwm3EgdYw8Xvwpa0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-ssCwhKT6NY-LAp3pIGyncQ-1; Mon, 09 Sep 2024 12:17:34 -0400
X-MC-Unique: ssCwhKT6NY-LAp3pIGyncQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d8a4fab0d7so5593273a91.1
        for <selinux@vger.kernel.org>; Mon, 09 Sep 2024 09:17:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725898653; x=1726503453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5euZHCAPx0l5H19uj53Gz6gfAAFyKfXDrC4Wkd8rTYc=;
        b=GwlW+PwQOx6c3KIZCytW6oyInRnmG1IhJ+Al8Tzj3GXmIkv9xs+GP5NP93TQaiJEUw
         65ClQUsUliMez+8yWiP3l4iJb92S1toZJw6r+xQt8waFBg3rWoX2URkLNuUPiJZgSPam
         oE6eqCBojRC8xGJD+Q9f1HBIgpvrVB+hCmCZTIxNcBlONedW3S3k/EWIoTrVfJTqDaOb
         c6W9Vydbd1L9r6wR7eXxHRiq3WWjn29Luj/FM4GQZ4aHQ+FTJ/fUyOqNvRfNl+JhpXLv
         QaYRQ9sQ6l1JEMOCyxipkEHnu9ylznODLz2BjRqTDenFgwXTzwp+GXv0IHT16cPEGVNO
         bEBw==
X-Gm-Message-State: AOJu0Yy9CaxYJNZDJIKoALLx1BUKiGg4WZ/JT8mTp6cI/7V/JYQ0JOnk
	ZtiJnM36vi1899Va3L2uRAI4AnO+v1B9C7VCyUW/VcRnh+X3gaMLyxa6NMreWQPXD+wihTPMibe
	D9pavHfJCloqX0Em+3vw+CmTu0YyqYPGDN17pq5y4Yi/kYNUeDETQPCpoRiFXEOo0obZDYgvF/P
	AHjaCplz/9eeK1rZX9UAwH0zD51K5kpw==
X-Received: by 2002:a17:90a:120f:b0:2d3:d8b0:967b with SMTP id 98e67ed59e1d1-2dad50d1d90mr16105644a91.27.1725898653338;
        Mon, 09 Sep 2024 09:17:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq29S+9uPHH1GWXOe3zvtA/J31lyYUf44IZ+HhyVXVZmmELwJW/JNhzkyHRRKWaXtgWGBotMU+TTFajx7uaqA=
X-Received: by 2002:a17:90a:120f:b0:2d3:d8b0:967b with SMTP id
 98e67ed59e1d1-2dad50d1d90mr16105620a91.27.1725898653004; Mon, 09 Sep 2024
 09:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909090236.194250-1-omosnace@redhat.com> <CAEjxPJ7nto7+VxWm-BUwD1UNBZ03P0oB6U1rj1O=k-HAh1R7Fw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7nto7+VxWm-BUwD1UNBZ03P0oB6U1rj1O=k-HAh1R7Fw@mail.gmail.com>
From: Ondrej Mosnacek <omosnace@redhat.com>
Date: Mon, 9 Sep 2024 18:17:21 +0200
Message-ID: <CAFqZXNu=9=ccL286yF7peGXcxVBFw0JVfpNzooXUC8UDD3=UXQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy/test_filesystem.te: fix policy for NFS
 over a symlinked directory
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 4:57=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Sep 9, 2024 at 5:02=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.c=
om> wrote:
> >
> > When the curret directory is a symlink to the actual selinux-testsuite
>
> s/curret/current/
>
> > directory, running ./tools/nfs.sh would fail at nfs_filesystem/test due
> > to missing policy rules. Add the necessary rules so that it can pass
> > also in this scenario.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Otherwise,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, fixed and applied:
https://github.com/SELinuxProject/selinux-testsuite/commit/82cdcae9e3e8c506=
c37d900d497e94da70728799

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

