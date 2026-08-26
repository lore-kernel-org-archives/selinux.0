Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38663A5E84
	for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775363; cv=pass; b=S5U0GTY/VADQEfmOhn7Xk+H0k7MCm2QP2/joRrkrGwUQKiTdCJUlzsd4FQBDxH9AyHxWs8YCtlrlclKCbcamdGUceqEVCDNxn884J481UTNwrQoio9OpIK7i48U/UYgUg5G+0xHImfvLJnIUZjBwK+m0EG0j40XYmoPeh1nM0d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775363; c=relaxed/simple;
	bh=H8KrDhJk/L9IJAQRZ62sgflo2S/WK8UvepqlYDIsrLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnLz94fdDkl8HEEhJNxiQ+et+T3zhc3zdUC/YiswvXaRcqcAVr9u1BilzYfHcpD9FZcDyVP8HsT7ZOBK7/Z7Je3lgduExZSjw0yJ+yhcxlSjvte241R+AGx+DdnxgvTBe9omlJPQXCnxdS6ZbMVvTZcoA6/VEecTnheB2jMmhbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rawdnPSq; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rawdnPSq"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-45eddb6fdccso934168fac.2
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2026 13:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787775360; cv=none;
        d=google.com; s=arc-20260327;
        b=CJh/9MG/gCEoZyok+Pc2kABOJeskpYUlEiE+xeDHszD+0mSaQcCyvHyaFZPJ3HQQ1Z
         AlMndIXlzP5lTVYtRjWNnvo16EuMEI4hvxXHWIhCXs+ZB6yX0Iy/oSsyu571c3qPznmv
         oWWdEQxE4eTcsLRdLXPXWU4lU3/Fhrw59MTI1p2W4ALjwQwevtu0WvYuNt4C0cd4LpFq
         5NH4cVL5YOHOFBYZc+cs0KQJqxTGlxdw9zqz5sRlHRKIKqnzXSqxcZ0tMHA2cfUa/0EN
         9vmBIRkHZ08OdRiFCAzKBAtGN9J2Iyl/VrdouVWx6pdc6dYiXQOZr3Y/cX68nhZZC5dK
         XYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H8KrDhJk/L9IJAQRZ62sgflo2S/WK8UvepqlYDIsrLo=;
        fh=7+QOJrX0reqoTSCiDyCe+ResJzkpTNgCkbawPxCyrOc=;
        b=NV1iq615puNQlYobXKtKF96Rhhc+ueFi+fhdSH72zHucsqE9iCcu25OnuJOb4pgV9z
         j8+B2L+/qXD8qWtqHWKLRU42UY9bsul7I+3IndDCdTbDOdeya91ci3OVwZHq7HpfDq3L
         umDxgNVVubMWYOdjpe8cgn6CVlu68Bo3H4d2KpkMP1rQCyT+DG28bq+eCirocshGH4Sv
         MSRTLNP4YPp3auPmhDL61jt5Fs+OsxBuPTA5iDmhUvO85dlx7uxZmYL33soWkeHKmwjk
         X8m/aeMg4615jGw70bIYr5SayVClHkDyTQbj83twvKiZqhh3fLqf45FaP8frY0QrEbAE
         er9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787775360; x=1788380160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H8KrDhJk/L9IJAQRZ62sgflo2S/WK8UvepqlYDIsrLo=;
        b=rawdnPSqk3hnWACw1bSh9HgIUfB3fgo8VXmYHw2WGfXObtcougi39Lhz+wbXDlJnBw
         79HWfDypttinDTtUL/PpetW5MlvtrXsQSfqr/LE8Z0yuOdCPG9Iro7cPVgOdpli/Ln/m
         k/cMrOzwbCUgf+LJ6+ouvgXrvjn9eVI5i73f0/xhD6y5fkR+Chrt/HmMzK0VSl8kYWAH
         epAMSzvAAPZKRB14ZJ4Np2bOhLnYte6zn+N94Q5PG2YvejFZG2rXeKWAryd34dPIsYrU
         ekCJokCUQQ9IDkHdpXtsoMwmGyQVDa2eWjPLfJ2bT4izMbZa5XkdkVJU2IXZ542AOeQk
         x0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787775360; x=1788380160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H8KrDhJk/L9IJAQRZ62sgflo2S/WK8UvepqlYDIsrLo=;
        b=czy9NcuJijBpZhlSXQ4IDBcQRa6Edde649OHh4unHsYb0HUtmBmiqP1ax2hjBJmBNC
         tvtcxqsKiqqaWymb4oASbcjBOeSvl17QJ0Nf6mNSKXIzH2jDmMDa9bJoGzhulS7tiKlg
         0ney2J0T5A1oJoOssQRzN5ybHrugiFB8/FMTiHb+F3pHlJ2rECgXHxdJrvEo5OVhZXuj
         SGyJ+2MYUFypLCsTMSfLBTbBJnH3JtrZoX0M297F4KfnlMUa8MppfWtUGq9QpRviMSf3
         fWuxMxMsgmlPsmxhf7egfV40H2xRSsJsfalW4Uxwib3Mqq+hgQ1tiFq88VLBYuRG5+SE
         3rLw==
X-Gm-Message-State: AFuF++m9NTDA2cWRskD5UMXdruCvW9qqkb0f3OmvG4P+PJf5yREjjzYT
	DPCBNWKrahX0X+ZP4AhwirhvoBjfU7CvngGRXcpg6LNovMioJhedTvK3EqpJ0xwaiUTSz67M3Qo
	GVWs90V1vt5KwCMmtkmcNbV7LS0AktS4=
X-Gm-Gg: AR+sD10lAPsIL1JAEugA7FO6vvGfnlKOQnPSCC9CRV55qjYquB3/WTVQ+3JPumiphQc
	QaufL+2j/SMgK8gTDgXOLMJZHocOuWOPFIipBJ6WWNwrTPeVSi9O0oOafHx8fuQLflhHimifEMY
	/8vMU6HsA4ezzYR0nGWun+fDNDNFJ9m7TJKl17G6CJXJyXvS5F6kPVoAD0OQvWHayKfNqXbWdrg
	YYv0W9n6MvVV56tTRK6sKmDzXRL+eF71QVM7t76PJzfGstEncIt2a7CW2iYS80n2jmDWkfI8zEB
	kWSiqwte79Y0VRJ5ujMzrVC5b6UtfwZeFKsHwyZqQGGjs1Gt1yG4Z5M=
X-Received: by 2002:a05:6871:2b10:b0:456:4c3f:7e03 with SMTP id
 586e51a60fabf-4659ba164a3mr9280374fac.18.1787775360545; Wed, 26 Aug 2026
 13:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826142323.2504-1-stephen.smalley.work@gmail.com> <CAP+JOzSyeas82szxmCs5uh+Zg6vfAyRCdhvzCtJCPbUMyUYbrw@mail.gmail.com>
In-Reply-To: <CAP+JOzSyeas82szxmCs5uh+Zg6vfAyRCdhvzCtJCPbUMyUYbrw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 26 Aug 2026 16:15:49 -0400
X-Gm-Features: AcwNN1VH_ZKQ0aCliAf4QfeRYfVwRdOLUVgtP2R09N2U6jzQE02VC6ZlaMmDMgQ
Message-ID: <CAEjxPJ4E6u_Zj_f8RgoV-oprV0q7D0MxpN33PaDm2MR7e+UUaQ@mail.gmail.com>
Subject: Re: [PATCH] python/sepolicy: escape literal paths written to
 generated .fc files
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	jason@perfinion.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 3:35=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Wed, Aug 26, 2026 at 10:23=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > sepolicy generate generates .fc files with user-supplied literal paths
> > substituted directly into the path spec field. Path specs are regexes
> > so a user-supplied path containing any regex characters would be
> > incorrectly matched. Escape any regex characters before substitution.
> > Use str.replace() instead of re.sub() so that any escape backslashes
> > are not re-interpreted.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.
