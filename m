Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0154652
	for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757618932; cv=none; b=QDxJ7m5TNbEbGrGHZE53PQQOmAIKFMek6JU8tbmTbLtKI+RQizYXTXKJtPxzP0HyGWZIIpd+bMG9xAPxvz+00wGD45qVwIknu3Mo0MW851az6e8C/awDurgbOd7bOyftpvjmHMtkkMLBDlumFo15f7UX0UllGw7+ZuPPf3Ef8eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757618932; c=relaxed/simple;
	bh=EuBglmzcVrGKHKQwAGiuu+KaJ0CkW73sl6pj5pUooGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R+slRuvt67cAS/QkFeYELrEySm2Fi3Tpw+OrTjTfucGD6JXvWdi91FFA0nvjHITLkwGn2/79IHGlrHT41GovlK9diDDXEn5K+pcQtKCF6fzVD37ocH92mD9qrdazDBTKx/g1u1Ldq2wS71sqQT+9+H+pvisZ4Eg6EZfVPmiG/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dsf/O82H; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dsf/O82H"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32de2189729so488943a91.3
        for <selinux@vger.kernel.org>; Thu, 11 Sep 2025 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757618930; x=1758223730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tpb92Dxtb01+mF8flKvGjawwDpz0cA78peqnq6Jg1oo=;
        b=Dsf/O82HqZRAumo++hmpuBP3JXFHs2KlV5z8Nq5sh+boBsBvJBivF940Baw3utTY7g
         PqlK5YGp7+5kbDpV4vrd1Ls7dkZse70+DYfVkX2uQQX0dJSXppYnr8xiVPt+oc8416gE
         L9xx1I7wlRPER3VwvNXeBBO6+GBkGpjV3cAgjyO/fEAR3NTYv/FiNDiYXEubHwuBNnL+
         0BqvPGcTqaWvkh8EW3ZuaSBnfA9KocYFtXzGVsuEzcoa/GI78l44JF8Mm+tgIDIME7DD
         Pdhe7usFyIrRVKLP06DD/AvrWmnuJ5WbdIA0eOOQZP3665X1I5ykLbesCHoDe18o0u2G
         FQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757618930; x=1758223730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tpb92Dxtb01+mF8flKvGjawwDpz0cA78peqnq6Jg1oo=;
        b=FAw8Bj53sOHhC2XHTqfZV18u8y8D2P1ZOY/veP687A4Q3oNbmg1rUYTmYFg5dZIEFk
         mubHGBi9Aj+ELWHYz0T5FZnOS13poevpHG6NzgHLCntMjfkJ9vGcT0KeijF+/VYbMis6
         WiW7H/bE9WQtIef4skKV8DmsZAqbbWU5ZsYBIaj9cws/Ta+M7QYz8dgqvbDFYk/LHM/a
         8BctNV1dj/8IAZ2l5PQQUXdZV1bcv6BOr24r/2ym2I6uu/LNOTKiNeA1fGCXprrDUMnr
         8nxlEf4G6yEnkTLM0mzXEB89Z30ghWlKVwM0byLd9fbgTxqVzUKI8k5ZwOzJxLsE2r84
         F6ng==
X-Gm-Message-State: AOJu0Ywq4ddPZmjnnNsm8TlkVtEvHBBRswsQshHJLL1I8PQvJI4xDrXx
	d/Vt++TIxNUjax+Iq7qa56cVsm76GtC3tZ0/LpqCaSVoeeWdsAWyM2HxMfg1EzXaShVMX0EnJ0s
	f9alpas4oQb4aEQYnIEg5bbc2YdX408w=
X-Gm-Gg: ASbGncuX8d2TfA2v+kprq+S5e3ykvE8FAgCZJUJGoKIH2FxSSK7gbqFdg7G09uCOYEp
	XPnmKsbrgk+WcqYRAUHDYWFS9GdZzGYNjK+gQgKFe8aJnrh4cL8eWPoS221CZ9I1PFAzFPJxdAc
	8g2cPk0mGKGts7zppCOEiyCVZBieuUX3mOCj7w2tY1PRAr6r+YFVtxix3eGQkHAvhc9d6oEmgsg
	JTGpQNjZsPqlnJyEw==
X-Google-Smtp-Source: AGHT+IHcsjU8dVyoKOwYG4hOPwTsW7VcIaddH22T1d4bYtkDxBUi+xATpeUADeSJcD1GgLvsMNaHGgjWCy6aWv9gvKU=
X-Received: by 2002:a17:90b:590b:b0:329:cb75:fef2 with SMTP id
 98e67ed59e1d1-32de4f789e4mr308910a91.3.1757618930027; Thu, 11 Sep 2025
 12:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910104322.328299-1-rjones@redhat.com> <20250910104322.328299-2-rjones@redhat.com>
 <CAEjxPJ5wEHLwbn7Rf=whqzFBgh=AVsy2YTY1L4wOr6JcB5yE5Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ5wEHLwbn7Rf=whqzFBgh=AVsy2YTY1L4wOr6JcB5yE5Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Sep 2025 15:28:38 -0400
X-Gm-Features: Ac12FXzIKQ-_yoQ7IWD4sa7UJkpPF-BNlTD-IBOl6hS6DlbpSTyF1dB8I-JdNZI
Message-ID: <CAEjxPJ7FM0a59yYYmxES36YYUsfKx0XvRapiYuoybQH7X77krQ@mail.gmail.com>
Subject: Re: [PATCH v3] setfiles: Add -A option to disable SELINUX_RESTORECON_ADD_ASSOC
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: selinux@vger.kernel.org, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:14=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 10, 2025 at 6:43=E2=80=AFAM Richard W.M. Jones <rjones@redhat=
.com> wrote:
> >
> > SELINUX_RESTORECON_ADD_ASSOC tracks conflicts between inodes with
> > multiple hard links or bind mounts that have differing contexts.
> > However doing this involves building a large internal hashtable that
> > stores the full path of every file examined by setfiles.  For
> > filesystems that have very large numbers of files or long pathnames,
> > this uses a lot of memory, which makes SELinux relabelling in
> > constrained memory environments infeasible.
> >
> > This adds a new setfiles -A option that disables this tracking.
> >
> > For example, using setfiles to relabel a filesystem with 15 million
> > files took 3.7GB of RAM.  Using this option, the same filesystem can
> > be relabelled in 121MB (albeit with no warnings or errors possible for
> > conflicting labels, but for our use case we don't care about that.)
> >
> > Fixes: https://issues.redhat.com/browse/RHEL-111505
> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, applied.
