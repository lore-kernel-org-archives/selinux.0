Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4E402450
	for <selinux@vger.kernel.org>; Fri, 27 Mar 2026 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774635801; cv=none; b=LS/u3+7DiILNcE7sCIBQdf4K5uSfVab8MukO8Law6JaSvN2K5XYV8TH4jA4hvjI/Bxi5jCMrZq3aQqy8d+ovDDs0JVeVBqR+xJr3aEjkoVZua2y7EBaEo/jr6UXZwbTfdMj3ld0SHecWitfhWIBQumHAjn6d9YtAdw2ZE7B9I/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774635801; c=relaxed/simple;
	bh=feRd78SnzzN9peQBD3ZQ+Yp9wwvOiZ6LtOzLWt3aD0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ReMxk6B0RfSbjmIWOgYWj9Oz5hqbWdoZ8qk8+tYRksQfj8vC1f7GqlU5rPgGExr20R6KO01XllvwyaXtDGwie3zfEey5lAfHgr/jB4mfEDGFNNjS8hhLmg+U2+WmutT0mFoK5lrOGYnWfQEgVTNkj2q+vWOuI6rmOmvrId06s0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhN8oGf+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhN8oGf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CB8C19423
	for <selinux@vger.kernel.org>; Fri, 27 Mar 2026 18:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774635800;
	bh=feRd78SnzzN9peQBD3ZQ+Yp9wwvOiZ6LtOzLWt3aD0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uhN8oGf+58RkHh5b53jcaOqkvMhbnfcWMzBbECYkX5vAr/0z628Z7XbUBFd8q6v46
	 puVRjtCobd+Q5hguG8AEK5iaKPIc1/rRifCjfUesMoLqU7tSHMypbjbJjvPqT5g9K+
	 cQ903leR0+nvqfaLgDIl+/wZADmsn+8587W41zUf7ah1L8Wm6g3lXPGWeLn2fe2N2b
	 lGk8vDTJ4eoF6jhUbW2rMSLLgCrb4Ccu2cbPxkfUlWntwWQXtDPhRMpA8MufwMuLhn
	 sftBTL1uDeifotOY9M6vRlTwlZMSSdhLugDM54pv+q8PNqwnTZUkedMhOgcuiLm0v2
	 og4X2jWg9EqdA==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cd90401034so254992285a.0
        for <selinux@vger.kernel.org>; Fri, 27 Mar 2026 11:23:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDmJm9CLDqLwedtWNrDgTCXWzUuydlNRZoPACMoUJXHazAnU86egmYMsCfvuM5Z0ne+myl2jF0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw3OYWhpX8zXoQUpNvM9n1ymu0AKfPPSNZfYvZ83Ij5ucQgXDD
	38sJo+8oVvhtW6IxqRNwU9v1J+RLe2bDwoAcuUkkIyxrb8NDSK9FePe/4DgmAYrYeTI66GmuhIi
	AePBXbRKCi6whDSTQPQbdV1kKN3QcX6M=
X-Received: by 2002:a05:622a:a10:b0:50b:4d01:fae7 with SMTP id
 d75a77b69052e-50ba37ef2f2mr47635231cf.4.1774635799631; Fri, 27 Mar 2026
 11:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <CAPhsuW5h=-BVp6g2UtHTUO8PQtbiSmqDrn0BT3rbdN4BkhQpeA@mail.gmail.com>
 <CAHC9VhQUU9L9OTtyo+2mdi0P5jCk1RXnJBxT1+YUyywMSfLuPg@mail.gmail.com>
In-Reply-To: <CAHC9VhQUU9L9OTtyo+2mdi0P5jCk1RXnJBxT1+YUyywMSfLuPg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Fri, 27 Mar 2026 11:23:08 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5VjD60MZ0vRxQwT8+HHy+vmz_HxTvRNOB+3M4FRb3K_w@mail.gmail.com>
X-Gm-Features: AQROBzD7NbhK9Rel07l4LVbNdklRhRELnwIDJSfWFmGCvrH1Z0u1ClJ2IRPv1HY
Message-ID: <CAPhsuW5VjD60MZ0vRxQwT8+HHy+vmz_HxTvRNOB+3M4FRb3K_w@mail.gmail.com>
Subject: Re: [PATCH 0/7] lsm: Replace security_sb_mount with granular mount hooks
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com, 
	john.johansen@canonical.com, mic@digikod.net, jmorris@namei.org, 
	serge@hallyn.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, gnoack@google.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 26, 2026 at 8:31=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > Hi folks, especially SELinux, AppArmor, and LandLock maintainers,
> >
> > Could you please share your comments on this set?
>
> I think we are all aware of this patchset, but most of us are fairly
> busy at the moment.  This patchset is in my queue to review, but it
> isn't something I'm going to be able to review this week.
>
> > If there are no issues with these changes, can we land the set in 7.1
> > kernels?
>
> Given that we are near the end of -rc5, that is highly unlikely.
>
> https://github.com/LinuxSecurityModule/kernel?tab=3Dreadme-ov-file#kernel=
-development-process

Thanks for sharing this information! Looking forward to more detailed
review/feedback.

Song
