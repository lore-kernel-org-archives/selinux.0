Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E4534DCD2
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634952; cv=pass; b=l+wPrhwTXgpcY/8fvZ2YLDV1smhje7gYwUoIsvRNNqlypwgeXiCUGU/A/gj+0ZOOCA/01gawW2zLP1vQaxfxdRh3ALOTM3Cfkzm4h/z0soR5Yw1Sd8hsYwnIY0KzNon7oQJrLX3yL7zvJCXxP1jH8fWuF3PMSY9+1nb64VElM7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634952; c=relaxed/simple;
	bh=F1/l6OgOeI+x0F5SY6s6nggLxA7Jgat/gfQduPeGPdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE/r4JWSHkDKWLa4bpC/WnGNMbKAhIzpAKndMqJt0lS2PXd0fd/Y5x/lf/fx2LI1WedbXReivwXnTOUmEH2MYL+U31OH/bPQqvyHTYDitxDKXWjGaTRZ8FLDau23F3NumzHGYxDeDJYgXzHcd7kfHV7V/76Nrl9cWKjWdhtrMv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NR9L4Po3; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NR9L4Po3"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86e6d007703so1602171b3a.0
        for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790634945; cv=none;
        d=google.com; s=arc-20260327;
        b=ed4P87CvcjCVS574+Uj7kodqAj6CYcFvL+iik2jE4ojIp+GxrI4hCRjdKQNRQ0ZBbB
         3ROxN9VyZKsxrGdASqa9caEsJWllJbLNYiEgNNemrR8W/UW4Z10rWFUbm9KEKConVyMq
         IvZD7TQP/17ctXFqaCwy0gswO39elWx/FnQJttew3IdqnMCLftrDNicLLBNjvm2wzVyi
         Ci4XQX4j+4pu9FwwbIHlFLHbqIdreGKRst9r2bSdb4YxyhDyqjT1cti06x1i5EfNOzNM
         2UeJKeTYmE5iqf1I1SfllN8DMElnUT4ZJj0berzmzUi9SOyVdAaZ78zzGWRx8b1bUPvv
         LYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHOaGcsZ5Q304Ai8+gbUr8rWLmvKwhOvycCzLi2TQ/o=;
        fh=E/2aPgMOUNjQVypBLOV58NgXSpUvtHu4xl47axa80bM=;
        b=iHUdup5PoBcO2d9uSfqviqQD8KI81aOMLE0OTUj1f7/yNOhclhmCAkMGlC/X0nXRv8
         JOAxoOFu5hI8M0isW5qdSMGKTkpZ/l+ny6m0+5MOzDwhi4tVypOWMdyqj09VPuuaSlUA
         VnZteWIVJ+uIxCLeR/Z2cR6gkTFrE+xtxE3mvKBx/PSv8YX0Wc7+ntArlPr7CTfF8MVK
         Z0Ave3H8WU7yHzWUkyg7pLmjp47FDPRavAayScTB00YjnJH+7bAkPIDl8mIl6oFGITle
         5pUOidAzSuuGOteA5WwPv+CVmWYCgIMOuPruwVty61zJy3pgGWCrMVT6/o6YXA+xFNvJ
         dcTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790634945; x=1791239745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHOaGcsZ5Q304Ai8+gbUr8rWLmvKwhOvycCzLi2TQ/o=;
        b=NR9L4Po3vQXP6g0r94eMldHIKgCwIYPrRdJQnQ1cNlWDGR7VxPwpZwg/o6g2GknvXJ
         hZK8JlnEZuTB92E0nt2F5JPkm6hUyb6O6R3kA1XJwP460fF6JGF3VpXTu20xE23kWKw8
         8pEk3zibP3yIt7qG4RBLnHdmOVdeSyLO19mpVhKlg/lqQ1rm9OWLKdXEMkH7s2VihsFI
         C38y+dnqic6LoBy64Az19+bUju4piUcB8Ra3+ZHKU3IKqybzKR+9sjML3KZz7RxMxqLJ
         O+WtAOk6R1bvcX5MER3qRjQjdEGsydaLcKGSE51xmCN8Kv66/i3+4ukaKVOdVrJyi1A0
         Q9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790634945; x=1791239745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHOaGcsZ5Q304Ai8+gbUr8rWLmvKwhOvycCzLi2TQ/o=;
        b=XyGw9ASVvGshcFTzH3V4GIKSZeNIzijc6MpyWSshOpc4k3TnhTkE0XId6MNJp9m/Cd
         VkF7UDliA7BPqFdM2TM6elIUVuOVxXVaR3ScqKoUxGct09L4xkevLFlxfugPYlwwYgL4
         HY4FQyxAkzEVEQ59GtmvH0FnBosvYlJ1xQ1vlX4JNAqWF78k3rUlz3jqFMZPKDYvPTtO
         hsefQfbq3kxc9+djQ/8FZv7mVXKCoxxSzTX0N2HxeSwDtm2KUTkXKrgbDNcI/QR3OK5a
         KaX1A0EW+17gG+iKP+gn85sMA+9LNcUOrGGOBnYWx7ppPcfciVR12VXUROdGfB+VFmoh
         YAVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEOa+honvRQWACxQkUX1SI/ovO3kgKK9HizCQVZGasojXygPhR1Swax2coljwRJqivCmZX3CKq@vger.kernel.org
X-Gm-Message-State: AFuF++kaZGh6GjXqsiwetYDTRImJfmhEvlQ69ZQD40yV9npdmzOJNz/K
	ghxAu/gj81puYDzjLnxYffyhjzy1rR2MicA8JXYAzHC9ZIkCrhQMjmyHty/zUTxCvER6BSzh02I
	7cSCC7d7+9RxHu5ImoLlyVJeySSHOCdiqz0zC+tQZ
X-Gm-Gg: AYBFou0ve3aiW+Aw05B6IYXiQQVjruRt/9lcl5j5YHo1ak/mwzqGBz10AayaB9JX8Xp
	BGtmGUP+1IgAPY0FZ51NSBpo1/kNBvLjlHA6DQfMwPfP/92SluxMqliUPB5bPj1l3rLsjYN3OlP
	Ic1id4//cPPyuXT4EosiNtJUzYIR25ZgQDPCHjKgMRmuZLqasbNaZMNvjhY8AC1K2KZKSv47enD
	q0B4AAq8TH/b+IQsyXvdfjVKWPOd9x5rr2gva/JEVq3A8QeyJ9dUkacdBJP0j4Nyo21VPD2edrj
	x4mbpXcebJCkw5gwzfsqLEfjZC3rl2EFmmo+duqS/38Kx4Scm8vSpX/TljfqD8yJxnUSNbRcWFz
	ue4lbADl0RTE=
X-Received: by 2002:a05:6a00:887:b0:878:3811:236 with SMTP id
 d2e1a72fcca58-87e9f82448emr11926596b3a.50.1790634944751; Mon, 28 Sep 2026
 15:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner> <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
 <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
In-Reply-To: <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Sep 2026 18:35:32 -0400
X-Gm-Features: AclHuK_FsGNbZ4FGUjZCK1Oz0frv6FIewmN7ZmvuDUc4wvtZdc4sm9Pj54ffJr8
Message-ID: <CAHC9VhQVVfKkRaHOp90E-WVGEVy_MYFBreUYPMc9Y79rLaviRQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Song Liu <song@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:00=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> Hi Christian and Paul,
>
> Thanks for your replies.
>
> On Mon, Sep 28, 2026 at 8:46=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Sep 28, 2026 at 10:13=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > On Thu, Jul 23, 2026 at 11:19:30AM -0700, Song Liu wrote:
> > > > Hi Christian and folks,
> > > >
> > > > Could you please help review this set? Does this set address
> > > > concerns from earlier versions?
> > >
> > > I just realized something while looking at this. This doesn't cover t=
he
> > > new mount api at all fsopen, fsconfig, fsmount, fspick, open_tree,
> > > open_tree_attr and mount_setattr. Without this the series is not very
> > > useful imho.
>
> Yes, I am fully aware that this does not cover the new mount APIs. I thin=
k
> those are orthogonal to the optimization here. This series is very useful
> without covering the new APIs. Users from multiple companies have
> repeatedly requested this change. ([1] and users requested this set).
>
> If we can land this set without covering the new APIs, I am more than
> happy to draft new patch set that covers the new APIs as a follow-up
> work. Therefore, could you please review this set as-is, and see whether
> we can land it without the orthogonal work covering the new mount APIs?
>
> > Thanks Christian.
> >
> > Song, I'm still open to reworking the LSM mount hooks, but any rework
> > should really take into account everything.
>
> There is another question here. These new hooks do not have any in-tree
> user at the moment. This appears to violate the "New LSM Hooks" policy
> in [2]. Could you please give more specific guidance on this?

There are LSMs which implement mount level access controls, you've
been updating those in your patchset :)  I believe that some of those
LSMs do have some (full? needs verification) coverage on the new mount
API.  I would expect that a patchset that adds, or modifies the
existing, mount hooks would also update those LSMs accordingly.  From
what I've seen, you've done a good job updating the individual LSMs
thus far, but if you have any questions or are unsure of what to do
for any one LSM, please ask and I'm sure the associated devs will be
happy to help.

--=20
paul-moore.com
