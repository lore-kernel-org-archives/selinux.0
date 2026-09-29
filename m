Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917E3DAAD9
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696485; cv=pass; b=SrfkfbU3oH4YKaUZn0/T9fy2k715D8ZHn+lwOcLdZ3hCbDuQz1HjWQMaT7EQp1fmnO9C6rPF/fN6X5u3zxcKTIl+dYNce3O9lTF0Bef0NptCzJycGBt+awaWQMnTQF+FY6OjWw9Abj1ZdDluqA6EPChFZb2Zb73jgFuXhOWpXl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696485; c=relaxed/simple;
	bh=Ff6kC5hPrRqY3srb5EBpmjAqOlTQzd0IBH6PRPcDfLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBZXmaaQYXy5Z0Ccak3o9XVMYeosf8PHHRy0E4uWhgCtOZMte07yCHN08+ABcwDMGu08cjhFGqoXKEvqH4syi3L0uimjrPxSdRPuz75MhPZzT/E6sJXHIA6ZeKADsChK7HpJB/N7Jc27FnNXHpyjsDn6nzSwkva5kn3MIxB9/K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VdY5z8Yo; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VdY5z8Yo"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so2274034a91.3
        for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 08:41:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790696483; cv=none;
        d=google.com; s=arc-20260327;
        b=lSMa1GAymoXe0Nd4ZX5/HIhtScGvyTugNX/lqpiluAjS5GmXttFI1+j+Y5aTqFzEsp
         OCvzWXHdTrsTUWv3wg12PKE3qJ7diOBG0+/WL7PKk4dRPNr9JQGDCFaiX1v24Mf9g8CI
         h4VZKyVQiZmmaf2hElU6arc2lKXf6oLr2JN2Qg/2iMQpg60iVCAaEeRgOksiqELlWWBZ
         NZ7SjwNDG9F+ZbUaHwxdpQipThObzWAf9ts88LqoDoHrOuN2JI0sTQWI5oeQV+DkoDlA
         mgUYMkUDfIkhuWF5D6bOYyW0fD803V+oHVxdAZfWcXZ9gzNGqVjx8q73ceS7/uZw9s6c
         uuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DloQ75v9I8tL4sabQ6zmS9+wLTDkp28GIOajsDW+cZA=;
        fh=RTntaT/8M4zOHZaFsL8SWSMvL1Tz3agE559vYGXX734=;
        b=CXDYpLXONaEC0W8+GsjwWn524bi0feLkhHsktEX7dq8p9Hk6bkpgzFafTCwZeljFTa
         znlGjNP9MvkTW/HlVfE8+FpQkvy7LxxPngA+grpRj2dIxCAScFuND4V8UvNzk0Lz5tk3
         SNaCBUa1AhF7VfupULWmJP8cGdmCenSEnEe8huiHbwcKNk2ZumPN9SYTXnQU7P0MZZ4i
         V8sLtxqbKI/ycF9Z6EAmfSt3/NAnsbIIFBf51CZLsUY6cwUL9dEGABK+8YsbsrTPnS3k
         vQpv5sFkIwpmYzLxnn/phCXn4FpXKAMcaxX8SLSXNCfOCrfdoTLpT88FBc+ms7SjU3i/
         Z2Og==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790696483; x=1791301283; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DloQ75v9I8tL4sabQ6zmS9+wLTDkp28GIOajsDW+cZA=;
        b=VdY5z8YoInDCnVPmPUm5T8INxeOb6a4PvVutNsPnGQMjPCHakCxQ7YRxDTJiehtUM2
         nSN/kYHZA3i5bIxkbPnO9xP4sdyyoMERSXUeQTn+/fW7jwDDC/n6ma9RIyHsAbhpJkpE
         Migw9a1iex6kLad5GdRNo2cpwj9g9EoeWdXQ7qv9gP4J07Tfb3hFB/xBwZD4Bykok7ky
         Vb4fzSZm4jEQuF83TmfGMBsOgeZ7wV+J9INpJeVL6R+lzdOJ8tbUynrrK+jWj+ZOorrL
         x03MuKlVvaRdTxLwhGuYpgaKsiQ2IlPvoM5B3FWeKYUYj+uTNOpPS6mBvowOQwbGIEQA
         4Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790696483; x=1791301283;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DloQ75v9I8tL4sabQ6zmS9+wLTDkp28GIOajsDW+cZA=;
        b=l1HyvEwlTnJQCu/efoKK4kvHSL0Qb6rTDLcYtJlq6saHFTL3d/YeMkZO+Efd5hfRbN
         lA8t/Bg2BsT7c9fmcTgv4EVEYLFvnNu2uuy/YJMgkoAeRHBZxnd0R/J89gsCbEUn6qH/
         OnYzDymivZqTPH5RKcIdylZhcoNsoIo5tEgL7aC4Qnn3GRYelH4P7eagEwhFZ6vLrjs4
         HtsuiJgOPH+2maBDIqVQflsVeq1zzsK2NBvORQBucKKRySrP+6vQJQ3gX4NKWp1t4oVZ
         IVahdTK4K1PhECSa2ZlYA8HfMS7+YiL3xHFpjlBOK7yc9njifPnCI1u4yRT71mu2yqJf
         q9Ow==
X-Forwarded-Encrypted: i=1; AKwUvByByihV2aZv3P7Qu9MDsoIM9QJ84aQCdTr1qpmublTtbdUIQps12Hy6nZ0wb67mz0tAtsXZdofG@vger.kernel.org
X-Gm-Message-State: AFq9FYLYz9x3vijzghezb6g7WVUBbQWDjelvj+NP+4AsLEfmFkNDALVo
	AUAbGM1+Q91mplGkMd9tBkgzHbTLqsQemPAc4UYJTO4xAf3jdaYWPmKEKfBKPXNxlVeOB613/+i
	+9/li4+MeGegeiYhMKQddNF597X4QsAN03cY9Iaso
X-Gm-Gg: AYBFou0WeacQe8Y7hW4BDN4QoEUwRQpWLegEcRw1wO0fMjC2fmT963RcrDkxggvbu8D
	EYHb8EhozdNP1DZfS+ff5mRRkClr9HX//nLzG8HgB+pveiK4QlQ2jPEqLt64wQXfzAQariH/TTH
	5Df/BRq1GMnhCUpzC6xlrpYDfhKf78zft+f1AlMC22oF4GOmsZ6hYZMkSlFFgyXLNQ2sSrnDy8C
	nEYib/2/CbXZLMnnFa1KC8DzgxZWdUYu5Q/3NNRlyLwlxaBJI6B1Y8FZP66bZGuYxHzczgKMhBw
	TCs2sNG3U08hKpxkL6KviaSPx/HWFNmkcWfmkVWxx7VzOekLfIaay3Pf6uT5Qerl6B72fhdqm9i
	c/uVdCSYlan0=
X-Received: by 2002:a17:90a:ec87:b0:3a4:a2f9:f2f9 with SMTP id
 98e67ed59e1d1-3a4a2f9f6b7mr1995395a91.52.1790696482601; Tue, 29 Sep 2026
 08:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner> <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
 <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
 <CAHC9VhQVVfKkRaHOp90E-WVGEVy_MYFBreUYPMc9Y79rLaviRQ@mail.gmail.com> <CAPhsuW5jQCe89LT_22dvQWVnw2cvpceODjvKiHEiYT9Wm_Npgg@mail.gmail.com>
In-Reply-To: <CAPhsuW5jQCe89LT_22dvQWVnw2cvpceODjvKiHEiYT9Wm_Npgg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Sep 2026 11:41:10 -0400
X-Gm-Features: AclHuK-k4dcV8AsNHD2Yr0ha3qdtOhv_YrLUXKayEeb-M3C-kGGNkoHEhnTeD88
Message-ID: <CAHC9VhRdn-jrNJY1K=1RsZQiO80QKR3nD+DHyUM5n_a3TrxLhA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Song Liu <song@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 2:21=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> On Mon, Sep 28, 2026 at 3:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> [...]
> > >
> > > There is another question here. These new hooks do not have any in-tr=
ee
> > > user at the moment. This appears to violate the "New LSM Hooks" polic=
y
> > > in [2]. Could you please give more specific guidance on this?
> >
> > There are LSMs which implement mount level access controls, you've
> > been updating those in your patchset :)  I believe that some of those
> > LSMs do have some (full? needs verification) coverage on the new mount
> > API.  I would expect that a patchset that adds, or modifies the
> > existing, mount hooks would also update those LSMs accordingly.  From
> > what I've seen, you've done a good job updating the individual LSMs
> > thus far, but if you have any questions or are unsure of what to do
> > for any one LSM, please ask and I'm sure the associated devs will be
> > happy to help.
>
> I don't think the scope here, adding hooks for fsopen, fsconfig, fsmount,
> fspick, open_tree, open_tree_attr and mount_setattr and using them
> properly in all LSMs, is a reasonable ask for a single patchset. Given
> how much time this simple refactoring patchset has taken, I don't foresee
> this work landing in any reasonable timeframe.
>
> Please consider reviewing this set and landing it before asking for more
> work.

[NOTE: dropped herton@canonical due to bounces]

I suspect there is a misunderstanding regarding the new mount API and
the LSM hooks.  I believe that we have all of the necessary LSM hooks
already in place for the new mount API, but since I haven't looked at
that in several years, verifying this would be good.  Beyond ensuring
the hooks are still complete, I was suggesting that if you are going
to create per-operation LSM hooks for the legacy mount API, it would
be good if we had similar (same?) LSM hooks for the new mount API.
Alternatively, if it doesn't make sense to have per-operation hooks
with the new API, it would be good to document that in your patchset's
commit descriptions.  Either way, I think your patchset needs to
address the new mount API in some way.  I don't want to speak for
Christian, but I believe these comments are in keeping with his
previous comments in this thread.

With all that said, you did identify a potential issue with resolving
dev_path multiple times in both AppArmor and TOMOYO.  That does look
like something that we should fix regardless (I see Tetsuo has already
ACK'd your patch, but we are waiting on the AppArmor folks).  However,
what that fix will look like will likely be determined by what you
want to do with respect to both the legacy and new mount APIs.

--=20
paul-moore.com
