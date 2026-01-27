Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B2299949
	for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551794; cv=pass; b=DsKXdIfssXrZMSjxTRn98FTZvGFi0xx4Q0eDZWIYU6unVGyQIohdSwmDv9VFM09gGXH8cdb66KtqAKNbjRMSmF6sc/ozSxbry8RkjECY9qRjMWYG2epcFxhFVobb2grxmA7zZMNVojjYe4LeRI6nK5dVgnmgwScxl7rz19dRHDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551794; c=relaxed/simple;
	bh=OG1FMv7wv4zKYSMHqfAUvVUusenZX7NCSUBskUeV0AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RogYEMqtPDAGsoSHkvPiKaLoCDBtCpPRR1DfPDxrvdsK/Gd3vB5lLQzvjPQF5C6aoPxJasHjimy65Bx007tKKZ6o8XIkWCbCS9CIzbhDS7OZ5d88yqszfaDuzwoXlm/iQjU2ymlzZ5tEuSYZkuEajvX7IfCJgPQlriDBVr//rkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=K+NW2PUz; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="K+NW2PUz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a7a94c6d4fso29357155ad.0
        for <selinux@vger.kernel.org>; Tue, 27 Jan 2026 14:09:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769551792; cv=none;
        d=google.com; s=arc-20240605;
        b=e/IwDzbaoDRY5qEsjTqu7GhTtReq9WPViitszykeaNQjyEsiKQOmpDU3PglkwIPdPU
         GgXt+v8vMhitH3w7F6RU5umD2JlUsQQDCeutd2dcGtlO7AB78CBNjxZtOnlpcmELk7pJ
         KhJCa3IRuQx6qX4RO6Lu0K7tzRykkkeIcUw02h85hvfI6XGhbWh+uFsnonDtYlxh6HGa
         qLR6rT+jcvDuGEhF+h4tvbVGsyfCfAxK/NrwwBd6kGyMcxBObQ8WvWUJWUZc9xwa01m5
         j0KJhg2A57XS/YgAWLe4WRRcZHVTVcHQWzX10fjlUMR8q5jp57j/pJXpr1thV+O0BmOf
         xdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/pGzPiXnxjkHtE3/gMOoiHqHPM0exsif4iCDkj4dB0I=;
        fh=Ifyw3YIrgn/52xFstjkFlNUyNWp+ytsXJfAhvWg8KdQ=;
        b=ZgaSbqJrpmoFzz7NP5T2PiqEs+uaJu9VemkkiiMRO3E0ecnMG4S53x+FeqnSZKKB19
         B66vioj3cI2gIpJgWRyhKM9NccNKw3HnaCMVc6NNoNt9NwXcicx+lH3xzDl6LKjTB4hZ
         ho4hrGtr7KzrCeKJ+Rr839CZtTVxQC24ltP9dwLYO/DGA2WRnA3L4Rrm7WCizgHSuzxH
         UGI9rsajy/d9dy+KWyozt7RZrNsWjIonpPDRvMkem2nvhNnFvYCtO4S+wX62j6KSo5dO
         cDJc/vvsZnS9LmPJYlY3L1pi2lf89Vf+cv73TFERoAfaPNhiGPJVYDjQ0nPvnMnSztsG
         8acQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769551792; x=1770156592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pGzPiXnxjkHtE3/gMOoiHqHPM0exsif4iCDkj4dB0I=;
        b=K+NW2PUzOkp3OBjZuNn5mEk/eIDu+inVJGXEf3b+z3wgN9RpC5JSCz2QpafmyFpvjd
         PptkDgdBv0EmEWmQXnOFX6nONaIZ9ITfVwNm1v9FQ39GLg2CzqSSmIYhBgXw5g5C+0GJ
         YJmPBC7wK/ZBqZGLGcroXtoVL3SOJC2ZPos0+344Wv+MvCKigIbxSVQ2i42RWFHanEA5
         /Y8ZI4jZwmWw8mOSfBaDvLVCnkbHXvIpw6qZX2oDijU3YbRqmIwi5vg2VkZEEZim2s2Q
         MiDUoXAgodLwadbMWwNwc8S/eLHHMYaMbvu3B1hglGAl0ZBh4Ijw++Oi49qHImZ+wLQp
         nbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769551792; x=1770156592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/pGzPiXnxjkHtE3/gMOoiHqHPM0exsif4iCDkj4dB0I=;
        b=jqG8UhhXh7i958FY38rMwCCDQqYTG1mtfR5eGeMw+iuvbtQqr7ysKH+6SoUccac5j2
         I07kf/XOU7eI6/2YBhz3g9IKlB4MpIr/raYCl5SAiQz96x0kJEQ/vbs5Yj8FuedlD2eJ
         Ld1lRDnBJWecmSZHViZNn6l24fuHLbxQ+zSDN86vZZm4by7bryoQVGUExX/cwjcDwYTl
         946Xl+IdEJWfnEx6AslFxBYN6e4xbwfmCczM8XZHZOTFkHnEl+iXbv3ysf9unM8DXxRG
         9YnSqu7QEhFqDozdcsGDgX1pu/rSBalYqpyfCNkqY5RFAnXuS6fF17Oexks5O6YD1iPe
         BhQw==
X-Forwarded-Encrypted: i=1; AJvYcCU6T1+x2VT/QWjZ+qirhGHvvxHAAI+9U/YQC+7UQwZ3EgRNXq9Ux33/PLX3QXzXl0XhvfdgUiNL@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLkjgIF6E576lZPPkMCP09Oly9LoVoITOtVBoNX4VSj7IQ1ma
	7fQ86h2KqhcD+HpcxAUeWZ1Oya7nb6Uni+XUUiksX2MJRd6SPqC2ebiGvGSHMvNINKxE6I8EQ8D
	GzmzwFCvXNlOjyrcSDqrWX17tH8G/bIF7B5t3HAnanVya7S1X1OsPWQ==
X-Gm-Gg: AZuq6aLvkp5UQj4Y8/U8m8aVsg6wQ//LmvJx6AUrhNK2fUZ+iH/sDWYOdXOE/4D0arz
	IcS4ymdcPcLBdG6wuu4tv0H6awEubRS+dxVRkThrA46kv5/Hn1EZkhL2FXLbwwCZ95gHcWPSU80
	eW+sjyUYhG76m6iw2Ng03rk7rq8AluOLOq1evtJdCaRA86z5ot6iwiNByxXCO7ouHx6a49P4fbS
	INymAmA4gP0nnPLE6pN61wLm2VApqlNlprOKe6ZG8MuqFC8I9KpekZn4/rR87h8JPQucpM=
X-Received: by 2002:a17:902:d4cf:b0:2a8:7827:bb32 with SMTP id
 d9443c01a7336-2a87827bd1amr24618345ad.15.1769551791950; Tue, 27 Jan 2026
 14:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122140745.239428-1-omosnace@redhat.com> <CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
 <aXgZI1td0Hremulj@mail.hallyn.com> <CAFqZXNve_7oKFWydUrskOcvsfbRZVKyWRmLvHKsTzBhG+RmEmQ@mail.gmail.com>
In-Reply-To: <CAFqZXNve_7oKFWydUrskOcvsfbRZVKyWRmLvHKsTzBhG+RmEmQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Jan 2026 17:09:40 -0500
X-Gm-Features: AZwV_QhApYhBIK3eOvHFa1J083mRfHMvnNKXNenkPREHmuM8NGRVHHw_H7kBAek
Message-ID: <CAHC9VhQOW4BQR+UCvrcXa_yiSqADN0HC2Xp0pMKs3FtnjcVaOQ@mail.gmail.com>
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 3:05=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> On Tue, Jan 27, 2026 at 2:55=E2=80=AFAM Serge E. Hallyn <serge@hallyn.com=
> wrote:
> >
> > On Mon, Jan 26, 2026 at 05:52:03PM -0500, Paul Moore wrote:
> > > On Thu, Jan 22, 2026 at 9:25=E2=80=AFAM Ondrej Mosnacek <omosnace@red=
hat.com> wrote:
> > > >
> > > > The user.* sysctls implement the ctl_table_root::permissions hook a=
nd
> > > > they override the file access mode based on the CAP_SYS_RESOURCE
> > > > capability (at most rwx if capable, at most r-- if not). The capabi=
lity
> > > > is being checked unconditionally, so if an LSM denies the capabilit=
y, an
> > > > audit record may be logged even when access is in fact granted.
> > > >
> > > > Given the logic in the set_permissions() function in kernel/ucount.=
c and
> > > > the unfortunate way the permission checking is implemented, it does=
n't
> > > > seem viable to avoid false positive denials by deferring the capabi=
lity
> > > > check. Thus, do the same as in net_ctl_permissions() (net/sysctl_ne=
t.c)
> > > > - switch from ns_capable() to ns_capable_noaudit(), so that the che=
ck
> > > > never logs an audit record.
> > > >
> > > > Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  kernel/ucount.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > Acked-by: Serge Hallyn <serge@hallyn.com>
> >
> > Looks good to me.  What tree should this go through?  Network?
>
> Andrew has already applied the two patches I posted into his
> mm-nonmm-unstable branch, so I assume they are set to go through his
> tree.

Andrew, any chance we can get a reply to these threads when you merge
a patch into your tree?

--=20
paul-moore.com
