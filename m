Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9261DAC5F
	for <selinux@vger.kernel.org>; Fri,  2 Aug 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603949; cv=none; b=aEDdDX944JRtC5uh+KLbUxdVOLOBh40rsDKH5HHf+bwcJkvfdWW1tWajt9BiZsdQ0UkckwFc1h9BjvfONbCTIljkKS/HCQUpSgxKTveAV7A02LfeACMGLZJOiHziTvqZFLxVJ4+ZtxvsAa3FmJlg/kgYKQidVWwJsSMN6Qb+J80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603949; c=relaxed/simple;
	bh=CJfbm38ZhHI8HOGmzii1vcuXCg8hzjKRld0EpplQEfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrTMzn0YRkPYZqaA6WAiMFWsPmRvA0AfNCe/djgsScOhJzq0wKHPASLcDddZ3MfyTyJf1wTkOY8grE8Shdle+ye1cjG/Rbg5R2QcKdx0nHPqdztrUKfIP6BO7uazvONgJ7wBjhKTLm1dCIeNsKNYFNhaCPvfX4FmcOB+NMOaaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJMoORCR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJMoORCR"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so5364531a12.3
        for <selinux@vger.kernel.org>; Fri, 02 Aug 2024 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722603947; x=1723208747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJfbm38ZhHI8HOGmzii1vcuXCg8hzjKRld0EpplQEfk=;
        b=bJMoORCRHvjM5UISNiFb9J4YFocuQkFw+Utt0LMHVZin8xMPGHkt8CNI/8W5bf32NU
         PQcuSiOOZ/T40KWNk+3FtdiqImjqVNaTu2arGsfJ2L79wz4GdGQFf0V8GwZA40n7ylVl
         qtyJ4usfheiacrYVUctky1SN9+8q2ygZNGTDp9b3w1PU9X4Q3H1KWw5P8E/kVggf8WvV
         pOHBA1XptwX4GS9FlpJC4jt3Leu+csWiXz1w+5GSH60uG8MFg6f1DITCUUtHU+sGocts
         aIJF+NkKSquvHZOjgaCiNmucXz8I3esSfwlsBF2j0TfKVw80lKfsxFuBZHkhJ3xLV9+K
         BQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722603947; x=1723208747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJfbm38ZhHI8HOGmzii1vcuXCg8hzjKRld0EpplQEfk=;
        b=mic2ka48AhGV714AFU0vQ0QH2XwDJJaSHI7i3DQIMt7pLjXBUN52uuHCBUbFoSKUzY
         dQb9Bq6ow7fy83wha5PhtGaldnBgqqt2eNXCzcMVAyqKfZC2tDPMtB0jeV6uIkwbI0nr
         a7HBeKbOWusHCNI5FuMGTdneF3UT9Pq78pFOj5i8l/amY9CUh6S8Y9m174pIvFkHgnNQ
         OK8JOMqUJW/ftV3pgnudDpVwnc8kt+fPIXDxCkjorHOUM0QJ44GErdVtmQrEPV/U7OIF
         2PjjDWY1c0Jktvfh9baREJ7TGDYrvTFu89lOM/Iu+dT0EaWrB7E40UbnJGZizk1JE2b8
         4TZg==
X-Gm-Message-State: AOJu0Yw08n18axU07lDbjF8FFX/eLSS+XUarORlKUng0v5xkG2zANMCG
	/2lD+3QRt+oksrs2lmwmDaWCMb2nfkvZOyc3OfysL5dkRm6NBi1Qab9sc2/dMbLBNFxCKzD6LqR
	UCmWMiuVVGaZy59Gg3Sjbl9ojphk=
X-Google-Smtp-Source: AGHT+IF6/9YbJ76A2v01CKr7gGU1JoU63IlZnW3XAON7NVKbjRvF8CGxlK3ZvR0DYHMQnJRwtD7ZSw+yZwCSvIohKlc=
X-Received: by 2002:a17:90a:8c86:b0:2c9:cbdd:acd with SMTP id
 98e67ed59e1d1-2cff9559843mr4478273a91.35.1722603946692; Fri, 02 Aug 2024
 06:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y15fe3iy.fsf@defensec.nl> <CAEjxPJ63KtgNc-FVBwkRJup5Qh022An21n=TsCsLP9L1bYyfoQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ63KtgNc-FVBwkRJup5Qh022An21n=TsCsLP9L1bYyfoQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 2 Aug 2024 09:05:35 -0400
Message-ID: <CAEjxPJ4HRoGVc62mA9yP4gPEi6vnhUEz6Ge2K8L+E_G5W9r68w@mail.gmail.com>
Subject: Re: monolithic policy on a volatile root
To: Dominick Grift <dominick.grift@defensec.nl>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 7:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Aug 2, 2024 at 4:27=E2=80=AFAM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> >
> > I think this question was already asked but I could not find the
> > discussion.
> >
> > What would be the challenges to support a monolitic policy on a volatil=
e
> > root?
> >
> > In a volatile root scenario there is only a non-volatile readonly
> > /usr. Would it be possible to teach libselinux that if there is a
> > /usr/selinux and not a /etc/selinux and/or /var/lib/selinux that it wou=
ld
> > use that instead?
> >
> > The challenge I am currently facing with systemd.volatile=3Dyes is that
> > when the policy is loaded from initramfs that systemd-tmpfiles (and
> > systemd-sysusers) cannot properly populate root from /usr/share/factory
> > (or created) because they rely on libselinux,get/setfilecon and thus on
> > /etc/selinux/contexts/files. There is a slight chicken and egg situatio=
n there.
> >
> > Often times its not a probable because one can do with automatic type
> > transitions but some of these files get created atomically (/etc/passwd
> > and /etc/shadow for example) and not to mention that these libselinux
> > linked components might get confused and noisy if selinux is enabled an=
d
> > enforcing but there is no /etc/selinux.
> >
> > Duplicating policy in initramfs and /etc, /var/lib would invite
> > inconsistencies and is not feasible but if the policy is readonly and
> > thus monolitic then this might be feasible if it is not too
> > ugly. Actually in such a scenario we would probably not need a policy i=
n
> > initramfs at all since systemd would just load it from /usr instead of =
/etc.
>
> I've seen a similar concern raised previously even for modular/managed po=
licy.
> It's all just software so I don't think it would be hard to modify
> libselinux to fall back to /usr/selinux if there is no file in
> /etc/selinux; it just requires someone to write a patch for it. May
> have policy implications (i.e. anything that currently accesses
> /etc/selinux now also may need search access to usr_t) but that's
> pretty common anyway.

To clarify, for monolithic policy, you just need to update libselinux
to fall back to searching /usr if /etc lacks the file.
For modular/managed policy we would also need to update libsemanage to
write the final policy files somewhere, although /var seems more
appropriate than /usr for that?
