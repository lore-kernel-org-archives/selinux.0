Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8D32C937
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 06:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662886; cv=none; b=gQPiqGmoNqWRoktJ2HsJQcYE+EY6QQozuROxBpgwqk2EVGhluHwleWLzxp3HQKpjV6qcMI4neAoVMRPW9CKTJy8oK+YrBVLJp1nImB2M0wjli0mYIY2SeD4+pP+aNwYM3Wd0qKxDGt7Rh+uBNpN4muUkdR8McXUgbRDW6gDzeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662886; c=relaxed/simple;
	bh=IsXEP/d/2pA2babj2pZZQMHHOf3036cos9HcMQkednU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1oGm71n5MbI0fl/ATIOaxcigbvcnfRNndl8+yeK87UmF1j/7cRtdVVnGZungGjlS1sR4bc1Ij/LiUVzBXz1nGy0Xtl+6LH+KPE4TqUNbY2zeh4LR4LDgw2QSgwjTRilu7Ek6EMfN+kJueAyMZg1so1p5ouhmUKgG8tm7Fs2BUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IftGd0wF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IftGd0wF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E39A1F0089F
	for <selinux@vger.kernel.org>; Tue, 29 Sep 2026 06:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790662885;
	bh=TCb5F6pVFcLzpGgoOVyjtPcXWhK4BpG0X0ULeKDemwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IftGd0wF4n28DwwQgZGyjpIPqaozc0XiCTyjiT7HuwBpIawuuiNpSM1a2CeZLvCTq
	 c+wdPmDNRUToos9/fmi/511dxAYY2zjofCYgDKhkKaJ6kBUDERYArVE3FwKjXhxAQc
	 RseAOKDTDdzVbZC6aBvYHOUqSYOhs5PUTqfLQQAHn4AfL43JcVrC5cq6Bd38RD3vLH
	 lCeeMpjpPKZb1Np+dXkU4EM7Xlq7uxmZn8bYWSz43YhpkydL9/vQL9oQPqXUVacfth
	 RhslLA5wvxg2eFvMHg2ZMxj6+lJPrILJljFkamw5qNrgqCSahf+gNmiwqu48IvPz0q
	 BfUVXNUnQI9AQ==
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910ad20d4so462498685a.3
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 23:21:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz2JywGFokSq8AeJcOfMm5SN4ZcrQkSCGjujFbbTF9fRKqnwmnNBnZ9NRGoTNGA+fgXkH/6h+dW@vger.kernel.org
X-Gm-Message-State: AFuF++nOAuAI91OBGlftloQmo9y8iv23qXb4afunuETxkH4jQtFUSgW6
	RBGAcV53VYwqbp+vajvxSsc8IGzpOny9vYelI88n0nm5srCRp7C5VPGMhlvWTE3Fpwqi+qnOLsc
	aEXLM2/5GJxZUEmLpNXPbVxxRApjoKms=
X-Received: by 2002:a05:620a:1b92:b0:93c:3d7e:6e90 with SMTP id
 af79cd13be357-93c4749a6c1mr2259266085a.32.1790662884039; Mon, 28 Sep 2026
 23:21:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner> <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
 <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com> <CAHC9VhQVVfKkRaHOp90E-WVGEVy_MYFBreUYPMc9Y79rLaviRQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQVVfKkRaHOp90E-WVGEVy_MYFBreUYPMc9Y79rLaviRQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 28 Sep 2026 23:21:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5jQCe89LT_22dvQWVnw2cvpceODjvKiHEiYT9Wm_Npgg@mail.gmail.com>
X-Gm-Features: AclHuK8OEJxYJWi3BrbNbV3RDX7RWScOTzHknH4jcYOLuT7EbqRyduXneh3vTXE
Message-ID: <CAPhsuW5jQCe89LT_22dvQWVnw2cvpceODjvKiHEiYT9Wm_Npgg@mail.gmail.com>
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

On Mon, Sep 28, 2026 at 3:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
[...]
> >
> > There is another question here. These new hooks do not have any in-tree
> > user at the moment. This appears to violate the "New LSM Hooks" policy
> > in [2]. Could you please give more specific guidance on this?
>
> There are LSMs which implement mount level access controls, you've
> been updating those in your patchset :)  I believe that some of those
> LSMs do have some (full? needs verification) coverage on the new mount
> API.  I would expect that a patchset that adds, or modifies the
> existing, mount hooks would also update those LSMs accordingly.  From
> what I've seen, you've done a good job updating the individual LSMs
> thus far, but if you have any questions or are unsure of what to do
> for any one LSM, please ask and I'm sure the associated devs will be
> happy to help.

I don't think the scope here, adding hooks for fsopen, fsconfig, fsmount,
fspick, open_tree, open_tree_attr and mount_setattr and using them
properly in all LSMs, is a reasonable ask for a single patchset. Given
how much time this simple refactoring patchset has taken, I don't foresee
this work landing in any reasonable timeframe.

Please consider reviewing this set and landing it before asking for more
work.

Thanks,
Song
