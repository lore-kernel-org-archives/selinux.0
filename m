Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9484778E
	for <selinux@vger.kernel.org>; Fri,  2 Aug 2024 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599150; cv=none; b=dQ/LhN50cImayRVXqEjjd1s4DyYzhWg+gcn63eaSGaNCJRtECdgxc/u66ljQPGtqRw1H6IjyqRhGIVOkBfqW6oy1wZgOp1ZAv3h7JSZdd7wolTvsTuAm0N9oRC00tmoP0+B2Ysg37+DuboUjs2Qfe7TG8PUf5Ubv+cuK8MeAbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599150; c=relaxed/simple;
	bh=FN8jttvuHakMSW/7rnWy6v2WGtyFe73LqW9gV4UHCMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KurPZV1zsW3/Tes9P/riMUJdaNlDn60TsyYbfHlD+4BtXiX1LULhxb2XJsLK7j9R9Htm9RDcYgdjec1VUApjZnSzENyn9tphuJu61lgZxjVuDj5PK4+7jnYw0/2A+aGm+Y+9qq/gvD8FKzsvELX+MjsFNtkvCTTU8gWYnxaV4NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvjnR0aG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvjnR0aG"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4567176a12.3
        for <selinux@vger.kernel.org>; Fri, 02 Aug 2024 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722599149; x=1723203949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN8jttvuHakMSW/7rnWy6v2WGtyFe73LqW9gV4UHCMc=;
        b=VvjnR0aGDKTgzN1r2nt/SkiF3Uu5uH3rXBeL1vcDjL5eJMNAs+rlYpKUPBvDcHK9zA
         +J6tJPJ8zgqTQzd+SVrphovKjUGnRzubx+O6T+x10yzTbgeRPoNPmPChFhBk4vlB/cmt
         tD6BxaP0emw+ljlmf5msmDxvaKJNOIcXW4//DzpU1vNyH3cWNZcS7aZOALEO6TAN5U+y
         2G6uEdwaTmHyonx5eTlwQB1q6dIVpDW3EjacX9lWV68y/0W75BoHO4od2YoHhqO5/t+4
         zFKf8VtUk98NtniyhPw0F06QxKYWjufij/kqlbH4Tibn1miY2CbmIgBcFQy9Oc5c5LsS
         EZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722599149; x=1723203949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN8jttvuHakMSW/7rnWy6v2WGtyFe73LqW9gV4UHCMc=;
        b=QMTQXngct1CMO6gnFMaxcD33rflxDA+XDKMYEKnu3YIxHFEaNCEReGDI26E/SyrV2a
         VuKgyjku5PtZUmK0oujGhjk0U2UkC8NjYQ0PgVjR2+6BDefHS/7EcCOdbGfer32o2LvN
         JNS1bw2A4sjDZ1MtF72wiKX/G6CzJ3n3LfifgvroNOdnlBb38XUxUiSbSElpnTZGOtqm
         x2+cIuQ9XfQqYyRoMCkRql+7kPANLU8LoD+Fg6uOPS0mSkF9pdY6ExUyteKE74ZIqQs4
         A+xDdzxOUFrKtjSqP3fuLjy0Zbw6JHQhyhRfuQhX4nsEsihF6DLpBzQIvqYvV2Mo3PFb
         +AWg==
X-Gm-Message-State: AOJu0YxMvX2MldeoetWt+VvcuvvdyUji0JgwSLNiypImBOYQfmC/V9ZL
	J+AWJ7yxVQ8Q/yiSpmIjr52x9ArV7/X2PpuLpezIX77THmOvgoxdg79sxNNVmvBScGN7CDVNOn9
	RGfVwmOmDXOQZCEM+hss1o7u5SRq3nw==
X-Google-Smtp-Source: AGHT+IGZsHX8Ku2F3Ufzh55Gc332R8x4iEgaSe/b5rlzmUQ83x0sQ9cduFl2Y/DwHJGEMxvtf5KJwJSYZhLSgRNyrIg=
X-Received: by 2002:a17:90b:3711:b0:2c9:80cd:86b4 with SMTP id
 98e67ed59e1d1-2cff9421160mr3660300a91.11.1722599148568; Fri, 02 Aug 2024
 04:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y15fe3iy.fsf@defensec.nl>
In-Reply-To: <87y15fe3iy.fsf@defensec.nl>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Aug 2024 07:45:37 -0400
Message-ID: <CAEjxPJ63KtgNc-FVBwkRJup5Qh022An21n=TsCsLP9L1bYyfoQ@mail.gmail.com>
Subject: Re: monolithic policy on a volatile root
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 4:27=E2=80=AFAM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
> I think this question was already asked but I could not find the
> discussion.
>
> What would be the challenges to support a monolitic policy on a volatile
> root?
>
> In a volatile root scenario there is only a non-volatile readonly
> /usr. Would it be possible to teach libselinux that if there is a
> /usr/selinux and not a /etc/selinux and/or /var/lib/selinux that it would
> use that instead?
>
> The challenge I am currently facing with systemd.volatile=3Dyes is that
> when the policy is loaded from initramfs that systemd-tmpfiles (and
> systemd-sysusers) cannot properly populate root from /usr/share/factory
> (or created) because they rely on libselinux,get/setfilecon and thus on
> /etc/selinux/contexts/files. There is a slight chicken and egg situation =
there.
>
> Often times its not a probable because one can do with automatic type
> transitions but some of these files get created atomically (/etc/passwd
> and /etc/shadow for example) and not to mention that these libselinux
> linked components might get confused and noisy if selinux is enabled and
> enforcing but there is no /etc/selinux.
>
> Duplicating policy in initramfs and /etc, /var/lib would invite
> inconsistencies and is not feasible but if the policy is readonly and
> thus monolitic then this might be feasible if it is not too
> ugly. Actually in such a scenario we would probably not need a policy in
> initramfs at all since systemd would just load it from /usr instead of /e=
tc.

I've seen a similar concern raised previously even for modular/managed poli=
cy.
It's all just software so I don't think it would be hard to modify
libselinux to fall back to /usr/selinux if there is no file in
/etc/selinux; it just requires someone to write a patch for it. May
have policy implications (i.e. anything that currently accesses
/etc/selinux now also may need search access to usr_t) but that's
pretty common anyway.
