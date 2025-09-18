Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D9155C88
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155870; cv=none; b=ofBdgd3UtS7tCoD9HpHx5OUyzIE6oj4+qrQRjnxv77SnKzORcf3S0WxSRAnU8/K2gjo3ROpFkQw5CsI6DRN99uSC2ucACSXDCVKvlpQr0Xr1HAyuapwYk276SUqFFJksgZilxZuCtHN3YflFNZJV5oHxbNIIJK10u+xxgSQVZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155870; c=relaxed/simple;
	bh=qqH4F11fWTgv6h4vGvrnN4oAXaGbo1p7srz7D/Oxq04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uV/DixSrAF35HCUyTR0K6YY0Vs+x7YQv1NE1o6rQsjZVVV7yVDlHh7Cp3vOVv9DLhB9Jvretqt0QOhTPQUdgzxuZSp3yukmONfXe2GgqVOFvglDWASacrJT7AcIuW7PAaGLUEUsVFLgZYPYdF9HD5v/YIUKD6HomsCn1JzDJZJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GlCNbvhk; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GlCNbvhk"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32e60fa6928so326971a91.1
        for <selinux@vger.kernel.org>; Wed, 17 Sep 2025 17:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758155868; x=1758760668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92otCWcjYZAoi7NV7b7M55aBo6hZq0XJG1/O6h3L3e4=;
        b=GlCNbvhk9dOOOFarIWk2bCU/EwFZAdL4VPYzM1ywn8O3xZ584z1vVCbupuJcRi7CeW
         TaBUYHz7fK30plaW1zv7AfsqGFh+7siGj1/iS0A23WOZiIb4ku/tvvq7bxbaFCJqCoGg
         Ni+kNvsQkMPYdlHGySuX+XK3uzR6hgqhMS4cGJMcJvUuin4vdy+rJjA2nHZR1AobMeMn
         3jNobbSa0vGtN6dvTL32aJAKkOvBNfnkuEgIUnbc4gQg7+JJCK1YX87ZDU/r3M7poe0P
         ZC2ix5Zf20AoyCp6RSTYiW8x2CPzxXJpsRJtCovRce90m1t2NcAHDUKV2l8ff0o2daR8
         NIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758155868; x=1758760668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92otCWcjYZAoi7NV7b7M55aBo6hZq0XJG1/O6h3L3e4=;
        b=ZDcZiKCCDtbmGkkw71mq3gp6WkvqQOy4gs/A93bpScI66t2xwpkRcICBKPL2XxGTA2
         cTT5kliwkTQdKTnVdGrGn53eXPKL6OVr9PGXRr5W/zFAX/3fnL9XhdClFYL/WgoRQ0C9
         aSo4t9X9icNytVIxGiMZO+HZTZOrqZzBORMwEJdJ5Pn9UTCDiP7M4Q7QjaNQasqG6fkp
         jnA+/yg5zu8pU7YHvpBNzKtwvPeIN1J4yxF7cuklLuiULUcOjpW+pSMzKNDYaY0LGK64
         hHB9ydvQYQeOvATx2mGmWDkxKN+4k0FuO+X2KkmKWqFsHYvA5LEE8HlU85FmWK4geVvC
         4NUg==
X-Forwarded-Encrypted: i=1; AJvYcCWcQ+0m1pi9DMFkIbTDHkrsjKmMpXrIaJ//0VpnAbkAYUcOFxnkBwzJ7R9eELpxKc/N0AOPJaH3@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr2zZjbMt8u7RVlr5iwl5mAKexhMovM+/hvl3PFpakSi5y4Goy
	6+m6f75prp8C+HycqeVKFpAW0xL7xngBXgtVS+PFYgZPI1taETkDcbxM3XYWsnrPIbTj/9NL2h9
	7BCJQYcxaZqniV/KpBu5tin3OfsBS14k1THN7blCj
X-Gm-Gg: ASbGncsvv2zdXa6hCH+lOnD2AsvdnRRwr9OgJkWBpj2UpC5u2oltiQr3EvsG/81JzKY
	eHBYL7K94DkDWoMMYTI0HYayciXqPOjMzvNgzSDO57IHqRhA8EEof1mGb3mHsKqxR74vrFfXBwF
	TXpsTYO9oohnd2xXiLxIVD8K6NM7A4ReMIDOwUQO4szbNsfUh+i9rZ1Uirvwn8OSyaO+Q7WJJ9y
	4jA7xgH5vfnw51IZLGT+RgM4w==
X-Google-Smtp-Source: AGHT+IH6r1J6WfOe8fhhKpPGbRIbI55hokIzulY3oS0P7cz5NzfOPGEtlbw4Ji1QdoDg4DnD/cfi0P8nH2cKJgTUTEM=
X-Received: by 2002:a17:90b:4c4c:b0:32e:7270:94b5 with SMTP id
 98e67ed59e1d1-32ee3f141e1mr4338843a91.23.1758155867668; Wed, 17 Sep 2025
 17:37:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
 <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com>
 <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com>
 <CAEjxPJ72F9PsdWo_XBL5XDABYwZFJh5-TSt1bp3toLwgoLchkQ@mail.gmail.com>
 <CAHC9VhTXR42Ogr-aS6OLHTZfW2vwBLtAcSqW7hJ4-0FMZfC2Kg@mail.gmail.com>
 <CAEjxPJ4387JPN+JOQ7g=Z6CCXYR-mk+6tr_VeyprxNJtCy1TWw@mail.gmail.com>
 <CAHC9VhSdKTUvY3Tg+dVCWHLfwULV-Vgzr-d942eh_yHa16HyjA@mail.gmail.com>
 <CA+zpnLca1_fRqcBq6AK0-hGbSb44R73xq2jw6qiYTv32GhKDfQ@mail.gmail.com>
 <CAEjxPJ7SDeMCq=0XFERiFozQmzRiJN9X2NB8v=_X8KOKYCrBLA@mail.gmail.com>
 <CAHC9VhRQJ+wZd-bi3Svg+RWEg+sC+YodvRfqEg3StoMAy5Rwow@mail.gmail.com> <CA+zpnLdJZ2yxWqTCBGXRJR0XmrCPpX3N4F3n=ZkSLc00WVyn9g@mail.gmail.com>
In-Reply-To: <CA+zpnLdJZ2yxWqTCBGXRJR0XmrCPpX3N4F3n=ZkSLc00WVyn9g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 Sep 2025 20:37:36 -0400
X-Gm-Features: AS18NWDuO83iMYfoZMNMSRUSoy4YrIogsZ48WVruV4OJyOzM6BPUx2_dHZRMst0
Message-ID: <CAHC9VhQ1anfefJ=PiDmR8iD2HD+=g8BFHX=wrYnfgE5mQw6W0g@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 8:22=E2=80=AFPM Thi=C3=A9baud Weksteen <tweek@googl=
e.com> wrote:
>  On Thu, Sep 18, 2025 at 9:54=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Thu, Sep 11, 2025 at 8:13=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > At the end of the day, I don't strongly care and only Paul's opinion
> > > matters for final merge. Some arguments for each of the different
> > > options:
> > > 1. -EACCES: Consistent with the majority of the SELinux code,
> > > particularly all avc_has_perm() calls. WRT POSIX.1, it seems to be
> > > primarily for file access checks but broadly can be viewed as "access
> > > denied to an object", which is the majority of the SELinux checks. In
> > > the case of this particular LSM hook and system call, we are dealing
> > > with a file object, and hence -EACCES could be viewed as appropriate
> > > to this check.
> >
> > Let's go with -EACCES, as Stephen has already mentioned, it's
> > consistent with the vast majority of SELinux return codes where access
> > has been denied, and while we can debate the merits of EACCES over
> > EPERM as it relates to the presence of a clearly defined object, or
> > the EPERM usage elsewhere in selinux_bprm_creds_for_exec(), at the end
> > of it all I don't think there is going to be a clear choice here so
> > let's go with the most common SELinux error code.
>
> Great, thanks for helping by making a call here Paul. Respinning a patch =
now.

Thanks for your patience and persistence with this.

--=20
paul-moore.com
