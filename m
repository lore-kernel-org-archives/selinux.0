Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com [74.125.227.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A84CC61B
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.146
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790610364; cv=pass; b=V/4PPo5yslhr6SWcMfNN+bWOm5NCbXajMtLtzZzCpr3uafk3+b8PZqXu2FUXNinZM7ZyaJfIvRr9FqwNYMplpURwI5hSKuJ09cU2a6Z7b/Jr5Fzc7meMjLbuLckXdixr6yr0n9volH9n1EBUJsLnUtpmFktL4+74DDn0Mcbed2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790610364; c=relaxed/simple;
	bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udpXG0daI/3GjOckdtKAeZCl+kSWNECqEf7ZXTCgmD0ZSkAN7H7MQgbghun5O9JE7EUrUfz1VdZ+OnKO+DC6jQJb48SO3gWmMu3u+woYlc79Os3cPcQfcSE66rCNlnzscARf7zR3ISYQGqnp+B0KxO0XKsA2/SO0Zp7fBxpr424=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PZkE7mns; arc=pass smtp.client-ip=74.125.227.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PZkE7mns"
Received: by mail-pj2-f18.google.com with SMTP id d9443c01a7336-2db22383fe8so12364505ad.2
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 08:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790610362; cv=none;
        d=google.com; s=arc-20260327;
        b=AcSDfc37YQQ76TXJxC06savf1GMNMoTSBkcLCpPuCpZUTnCd28uowRwgxoeUbXRKYz
         Ajlv00vt34/3KH/af3ptveurmpgnHRfXYJ+mlFBGcI8jTEnWyqWWH7ZY+RG3jttIaijt
         kmWrUIkX5V0GHTPWP+sCMu+XixfPphVmm6z9t36F4WMFYa9El8KfEMLd/6gIen0ItTHD
         zP520vE2XegQQNdsf3lA14KaTLzhLBxXLuP5Lfdm/WGU/PfozvrR6fORM1t03Jb/HKA5
         4cGt8uhH4B41ImtPvxhmPNjyMjl6B2aS9MyPnQsyBo6rmpPDM48bmm/j4FdYng4wNdnf
         qXkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
        fh=ENjOjL+3iF3cxmAv/q61Fvp9cX9CnfUTMXZJxOXQEx4=;
        b=OSOPtazNZyJhLLIPnIVspV65yAE6SIzWxaq5XAOT3v8CVBlCR0Hly6GKGt//tXuQxY
         +SWFpiaQjZGo91A33emhseAl3AE+Ke2J0p3JOWnDYTO5AsLhnyJAZG1THCqnDsQys4o3
         4eHqAJvAuaUpI3MiO/3eI1OwhbWcNuvjfJVz0PrHC4axkol0rkvaxKPrRy7cBUmCejw0
         QiQf2ULXgRSe3LknGb+JGNZHFLwBXu/CT2CWc5b3JkyBWvKudIdMGAVQ8pQeEdfIEnzX
         kjmdijJq0XtkPqizT54nL8PB6Um45gux6ggvyawd7lCeU13ZWJsB9t0rwXqiBl+MH7Gc
         FVRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790610362; x=1791215162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
        b=PZkE7mns5GW5YSJdiM4sHP9wLqDG0wjNCBVaNv/f1H42LCU3ckEHzDyt/hcRXIqX3u
         qnzHzpnevWwjBlMmObz/QnJvewjGZYIIXR5Bm8oOZ1JN5WLJEcWtxRSZO1CtdedFaes8
         SyZ59NGg9ElcTSlPYXrzILNXLHNg5TXNsTu14CdpmWp8VURrkPhacfnjRs6oMhQ6jDcL
         Q/A6FZxxToCesbOik6ViquOo6hPx61QdZ7+wjggVTcn7lXRR+ul+eiewXPH/r/9rQScZ
         yUsaY/PH7mo5L+tHOmStLz2qkw5soDulM86CKagVmIEEaUd17aQe3/lMjzaxVJ1VqlvX
         nXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790610362; x=1791215162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDMUEL38Cd1gitG5dTj4yQtOKktJ5rHCDEbPh4VwvjY=;
        b=h+rPTGsqegWphORg5eoQEZ5Ckn/B9aYtW572XW32vqwmqpzh1lw07/j8O20duGZJx6
         UXhcL7bi/jU8sPxuc//PaX06Sm1ghUYA408eo/DoHdt9Fm88t8+9qECXnpqI5GyXhg+4
         DoLV11SMvHBWi4vkAk9FrMTnJkyOGmsag/VwXIkDf4eb3ObvMV/rRL9wQZCPj42Q02Qz
         9r5XkQkBabjAwvLYOIJyixvlDQ1qtpr0OEiyF39Dqd1i+6yavlP0d9yyHI3AhvuoSjP7
         M99OgKImXNdXSf7F15Zyv1bxLuRFiJKZgkDBFJepBfR8hFBd0dxrp2m/ZEsL5GZHpX0x
         CCUQ==
X-Forwarded-Encrypted: i=1; AKwUvByWzNwMMX4rBVZX5GPLFwmf4NI36UwQQJee+mY0RVYAskFsuEGDTxgDSgGC/mxNOXfvAjApnp5v@vger.kernel.org
X-Gm-Message-State: AFq9FYJ87gB0nOsuKivT5vz5IaE0rO8l0dC3Cxv3kpWGlA5kn6Me8l55
	3NKt9VTtdpzIXJWzK0XpN8YwmR9KwQNMiDpkn+o30B2f11VGoDovPmC+o5Ur95zqvY5rmpFu5Wu
	gph4oTD741+zCP12wtUi3jj0jme4ari05evDdeckV
X-Gm-Gg: AYBFou26L/7W9BMU+qHpnfBtqJQH171Izzn76lxgmztwVkq6UHlf13DSGNREpQs/VE7
	JgnCFkcMNkWGGfCXp9GDIXvb7pKMCGYuQkTMbVSt6fohlV6XIvK5zd/+KYAeO+Tc9x3ifb32d8V
	fpOff8Tg7WiI6m+vfiZn1lrk/i358M/CyYrjeSXVNxze51KeRew/SC0jZdKdjKsTR6HvPUlLL51
	YBy1+aCVY25QotiJujKbtx5zJMP0FotmROtNhg6uRWRFQ80b0nz2KRjEXzeeDx+r6ATHGvWMe0o
	8A1+u2UlbqEoFzE/+rVgUi8kQSxNwws5qFOL35QXii48suK9qPWGJyr4D/9hB+H9xMqlgP1gI3M
	rk2Puw2P9A+Y=
X-Received: by 2002:a17:902:f70c:b0:2e0:8864:7f01 with SMTP id
 d9443c01a7336-2e088648100mr40903655ad.50.1790610361828; Mon, 28 Sep 2026
 08:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner>
In-Reply-To: <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Sep 2026 11:45:49 -0400
X-Gm-Features: AclHuK_fG4Ph2lyDB8B4vPRkrpFhgb007Hmd0WjDmDmNdvNtINrqpBqaiW-f0N4
Message-ID: <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Christian Brauner <brauner@kernel.org>
Cc: Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 10:13=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Thu, Jul 23, 2026 at 11:19:30AM -0700, Song Liu wrote:
> > Hi Christian and folks,
> >
> > Could you please help review this set? Does this set address
> > concerns from earlier versions?
>
> I just realized something while looking at this. This doesn't cover the
> new mount api at all fsopen, fsconfig, fsmount, fspick, open_tree,
> open_tree_attr and mount_setattr. Without this the series is not very
> useful imho.

Thanks Christian.

Song, I'm still open to reworking the LSM mount hooks, but any rework
should really take into account everything.

--=20
paul-moore.com
