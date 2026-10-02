Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20483318EF4
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790985569; cv=none; b=PLfrH9AjGnxEMroN970tS7FZ1UYEllboveZrNshRZopDtNqmnXPLi3YcIxReryxCZgF4xL6vyVGknJ4eG/A3PSO/PDvuzOTfAnFY42INw6L95xNFc2uk4ZfB4BnH3I7OIAUp90BOJoHNoVr2gTLMh/Nz/WJatkJtU4WkQ0ZpsPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790985569; c=relaxed/simple;
	bh=sLkGfZptRXK51umYuoSuAMNosgceJoovn/TWb9z+shg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gAQjZw5bIyLqkvcR92lVAAniGB/o+7288ndOY15IOo18QOq96037d0Hw23l489x3stBGlK/PyjGQT7bHybyLyR0GvD5lPOMY3BoLOJfQKm02Hsb/MuxNPj+64mbOYwZ3pl5MnHruCqR4CNfkLHkQFFREwQ52DAV2duJYQk15NFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEDqnTry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEDqnTry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FFD1F0089E
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 23:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790985567;
	bh=sqGFC3qmWH7lZzdVKHbKhQsEqSgB4ysviPSLiqhzyqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gEDqnTryhqiFJprKEVSK1K3Sb+gFGDOGkhezrxhlGQvG1+t0d4bTl/CuMSbXTArYR
	 s0reyUj6gm/5H7saLwcyEafNfwTkNPGufkopttlAq/z1RBzwXIz6fwhVuQMMY7P6CT
	 cKnrq+VbRhzzFh95qlhCL1VofIoA3biRtp8TQvImXKx0LRP6C84o0vYQkTROCU7W+R
	 M/FD0GYCJKWdT7iUBMJMoZY/Iv4kaalv0R0PaWzJjk/73b7CTuvXy04scUUWZWGNb+
	 pnnlvuFjEgpZmUjj5ynOfGh3pH7tNBlWgQr/jFXD2avveulb1umPpYpSOR6Z+l3rCS
	 QOZO3knSW22Xw==
Received: by mail-qv2-f41.google.com with SMTP id 6a1803df08f44-91782711448so4166456d6.2
        for <selinux@vger.kernel.org>; Fri, 02 Oct 2026 16:59:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBybdza/6iO0uNiLw2+UCw06pobN3W667jeOg4TZRyiL8jC+Qt+IkpzCKZH52/0bVWZnyqjw9pF1@vger.kernel.org
X-Gm-Message-State: AFuF++kz1Q37RNjM2cKe6rmiZsr5dVvU/5GWvPBv/L7iBS9Uhgwt/LdG
	wpX6fgTJT94jae3nFGvMAjZ8i/nzEz2bCieJwN+eErnt+lCDW/gBeapLQRxn0vMA8BkHKxiFjCT
	v1oc03YmAVbq8c6ikB7GLPwYvRTsvE6U=
X-Received: by 2002:a05:620a:31a1:b0:93c:63f5:eab with SMTP id
 af79cd13be357-93cf17173c2mr775294085a.31.1790985566849; Fri, 02 Oct 2026
 16:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706235053.4104951-1-song@kernel.org> <CAPhsuW7E-mW5CvmSXjUsc1GBjvgpy=pnaYOzTJsLXDvx8+RMJQ@mail.gmail.com>
 <20260928-hinein-lacke-nachfahren-45ac39a36146@brauner> <CAHC9VhRPd8z=67=RWM-0DqjTXysk75FtF=haY9-Vv1oGcX1PAg@mail.gmail.com>
 <CAPhsuW7iFP4Y6C1ZhTvtEgTzgKjnpF9+8YfVg4o3P4BHEnR+LA@mail.gmail.com>
 <CAHC9VhQVVfKkRaHOp90E-WVGEVy_MYFBreUYPMc9Y79rLaviRQ@mail.gmail.com>
 <CAPhsuW5jQCe89LT_22dvQWVnw2cvpceODjvKiHEiYT9Wm_Npgg@mail.gmail.com>
 <CAHC9VhRdn-jrNJY1K=1RsZQiO80QKR3nD+DHyUM5n_a3TrxLhA@mail.gmail.com>
 <CAPhsuW5r0Uqu2xUzxkLAakA4=waE-1LLORSqU4SSD5sX_NEn9A@mail.gmail.com> <CAHC9VhQvaQyx35M-DJmfrVVqXNcmS+_5uwbtDgMB9SPERaQvog@mail.gmail.com>
In-Reply-To: <CAHC9VhQvaQyx35M-DJmfrVVqXNcmS+_5uwbtDgMB9SPERaQvog@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 2 Oct 2026 16:59:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4XdDUAoL-pXAD5UAGjU=JEQUr7Hw1vDkZGX3dOAiRR1A@mail.gmail.com>
X-Gm-Features: AclHuK9C91U0PJ9_l2jaTWobWTm1-Dmq8dZhGXcoIwRv5AqNzoLVEvpCNXqEjEI
Message-ID: <CAPhsuW4XdDUAoL-pXAD5UAGjU=JEQUr7Hw1vDkZGX3dOAiRR1A@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] lsm: Replace security_sb_mount with granular mount hooks
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 10:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Wed, Sep 30, 2026 at 12:37=E2=80=AFPM Song Liu <song@kernel.org> wrote=
:
> > On Tue, Sep 29, 2026 at 8:41=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
[...]
> >
> > Thanks for the clarification! It appears we can indeed add coverage
> > for the new mount APIs without much work.
> >
> > Attached is a quick draft for this change on top of current patchset.
> > Is this heading in the right direction?
>
> Can you send out a revised patchset?  I suspect there will be a number
> of people who want to review your draft, and it's a lot easier if we
> don't all have to apply the patch separately :)

After reading the code further, I better understand why Christian thinks
there is a significant gap here. I will not able to finish a good draft bef=
ore
LPC. Hopefully, we can discuss this in a hallway track, and reach a good
version soon after LPC.

Thanks,
Song
