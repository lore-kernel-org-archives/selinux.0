Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560D4F390A
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614815; cv=none; b=HNPUe7ec3X0X7KjzwGoky907fL0bQRV4Xtr0NxxDfLx0Wuv8JtAiaeEE1Z8VvEql/PEDUrtRl/WYf3qBea/39V1QQSF6fJ8R6sKtcMXUWl2+ffmcTRje+YvpYekH1aQqwqjdD2rJ4uw65oRXWHEklMB9CSB0HmwrS6YAqprc2c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614815; c=relaxed/simple;
	bh=aNjWnh0AOl3s0eUeng1gZliNevLqt7fbAwztduu9NnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlyCPkoJVQzsLx17Yy7uwJUw7pNT1ih0Z4sR1dA68iuN1ju0y3X6fpQhJEoHMNW1wrC262ywp136FSVs6vdFy9yxgp2Aq21rrg4JWnQRAp6pcU9E3VwG3z9In+GGR63+5h049Mr5e2M0iZM1XoeUlFZuTCJ5rXMU29sZZoI6HCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FATkbUle; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FATkbUle"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCB31F00899
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614814;
	bh=aNjWnh0AOl3s0eUeng1gZliNevLqt7fbAwztduu9NnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FATkbUleVm8J6SK8B6WrYRtkZiBUSfQcPdIiz+umpBT8tc5HlMUIfbm0E7WUBg8Mn
	 uUg5sekK9oDpiYfiN54M1dXDmnF9FOpXK0o7C3w2EHcRSTYNpf+C6yf8VDfuEBo8np
	 Xb1vs+fbmhE2LYrcTbKnYcX63IpAv3FL3CK01bh+7oJottb2ZNDibTPwDRfz6DX/ZK
	 KNUvREaPPfsKkKV8LGvg2Fwl5sjtzCjomy52prJMm7Fymz5hL3Hduve2JR7XP7gKEi
	 QEF3Gcug0aRNDEF2GMVw4SAcFw/NyX9cueTx813LSZ+C5LHUL2emFYZhBNsaFLYfin
	 8XlAN6M7hmHLw==
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93bfa7b2093so374380285a.1
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 10:00:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzE1IjYtE4GhRc1CIhHk8BrwNbn+A6V/mIJoqt9QyPbwsSpIe59qi6m4v3WdZ3bDqHmz/Ckt9PV@vger.kernel.org
X-Gm-Message-State: AFuF++mW/242zAP6RbX0iz3gzOwDdBjMF5mIREMRuJm1Vy8tYQ1m+Fwj
	njzT5GET9FQUOuYj//6oNVSZB/fbFXaSzE34surW9oFfNQFxZ6+SUvxmWgu0qsdA3Xt1NX880HT
	O1U3mhPLTgxBpgiWQpf8LODTcP/glYbQ=
X-Received: by 2002:a05:620a:4050:b0:937:5ab5:53f7 with SMTP id
 af79cd13be357-93c43dc8b4fmr2164543285a.43.1790614813372; Mon, 28 Sep 2026
 10:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner> <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
In-Reply-To: <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 28 Sep 2026 10:00:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
X-Gm-Features: AclHuK_nonVI-hneqRocC_bdGS7S6tjPJjqMlAvwButNtrovBaChNzu1f_vNOHQ
Message-ID: <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian and Paul,

Thanks for your replies.

On Mon, Sep 28, 2026 at 8:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Sep 28, 2026 at 10:13=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > On Thu, Jul 23, 2026 at 11:19:30AM -0700, Song Liu wrote:
> > > Hi Christian and folks,
> > >
> > > Could you please help review this set? Does this set address
> > > concerns from earlier versions?
> >
> > I just realized something while looking at this. This doesn't cover the
> > new mount api at all fsopen, fsconfig, fsmount, fspick, open_tree,
> > open_tree_attr and mount_setattr. Without this the series is not very
> > useful imho.

Yes, I am fully aware that this does not cover the new mount APIs. I think
those are orthogonal to the optimization here. This series is very useful
without covering the new APIs. Users from multiple companies have
repeatedly requested this change. ([1] and users requested this set).

If we can land this set without covering the new APIs, I am more than
happy to draft new patch set that covers the new APIs as a follow-up
work. Therefore, could you please review this set as-is, and see whether
we can land it without the orthogonal work covering the new mount APIs?

> Thanks Christian.
>
> Song, I'm still open to reworking the LSM mount hooks, but any rework
> should really take into account everything.

There is another question here. These new hooks do not have any in-tree
user at the moment. This appears to violate the "New LSM Hooks" policy
in [2]. Could you please give more specific guidance on this?

Do we need at least one in-tree user hook that uses the new mount APIs?
Or will we make an exception for these new hooks?
Or will we revise the "New LSM hooks" policy to allow reasonable hooks
without an in-tree user?

Thanks,
Song

[1] https://lore.kernel.org/all/20241231014632.589049-1-enlightened@chromiu=
m.org/
[2] https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#new-l=
sm-hooks
