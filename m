Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195D3AA4F7
	for <selinux@vger.kernel.org>; Wed,  3 Jun 2026 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501381; cv=none; b=rSlrT4X9nuMfhpLMOrv/F9O8XAbP38HeiK4ulK9622+qtMmWrN6cLLcb34t/dKHyRRAuGxpLTFdumFZQjDIODKY8N8+VAJ6uCGH27Udm4RUIh1bi695BekaOkeNKQkcnFvct6YIdWffeeVDDXMicXQRad71U4rZHAe6GwsXykXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501381; c=relaxed/simple;
	bh=061crZWIN4JKB/NKMoAVGl/u2RMCMW22NC/f5SkO7CU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqaLhVZcBeb2Yn/C7xbCnYiLphlZJIhVfFsb0dPSJB8CZDXw/rFDSkNO1MOvcElTL4i3laQ0VKE5taq0AtOo0dW9xOVWkBw6oS0nTjWIW5X1501xkE7eJqlSAmMbyvFHgDJF2wEtX21xLH4Ij8BGXHFALrh83mUIiT0JYZAuadI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNu3b+MO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNu3b+MO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791001F008A0
	for <selinux@vger.kernel.org>; Wed,  3 Jun 2026 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780501380;
	bh=C/uz9F7OyXwuFmXOiV8vOXW9WBcEn1NRJwfFJ+RdluE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WNu3b+MOyQDTn7OM2WU3wWMvNk0C0cnIm0Z/+5WZtkGaVQnyMqPQ2rvhIJts5kqLo
	 PJMvgXHYSc0HBp1hB2AY/z/e8K8c6akBfd9OPWK/7A1pdVMHLvpWMfEkELyOA8zqm5
	 ZEG4SUvFxef8xoa8nLq7nXvDSnPNS6PBjuSVwVM6LNqRtr0SkGGHP/dSjnbNo1PkUr
	 ZpGO7xFA93IsSDIEEgHCjSCnbPVmLqW7NtDaoJl00q14ZRVSybOpSsQGfQA4uMGK5w
	 C3CJbA2/pgcOK8BQydPI0kDsnVuFWSQ88Jgrt0zfpGyx6JmrhWRCFEXvtlNFDxTdei
	 I/aE/MupGHQEQ==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9155183b42cso108301385a.0
        for <selinux@vger.kernel.org>; Wed, 03 Jun 2026 08:43:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9g/W8OsT2zhIt8mGWtNtoMyWAX/ru8X51dPGqyJfmuUy5uQu4E0huUy6OflNj4F6mS15OV96kS@vger.kernel.org
X-Gm-Message-State: AOJu0YwVq4OswRx7MHsn1hfdJRn23dXTo+3ULhdHWd5jcktEdBrD75pB
	7FQ3U6XepGimcb9UI8FDChkwbekFWSaz79zVyp6nDHL5j7IkT/kzZx7ywwIj0GhrWj+k7NmGvBo
	QtZtxswf/Q+yGBY2qdESeQF7uH2IK5zg=
X-Received: by 2002:a05:620a:6601:b0:915:83b1:fc43 with SMTP id
 af79cd13be357-9158b62262amr449090185a.12.1780501379724; Wed, 03 Jun 2026
 08:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528182607.3150386-1-song@kernel.org> <20260528182607.3150386-8-song@kernel.org>
In-Reply-To: <20260528182607.3150386-8-song@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 3 Jun 2026 08:42:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6VJ_yuxatCUQRxxVAYZeT-5JH_AytaTh6grBHLYmDeLQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lc1ww09mSIZr5MM1D79LnYMeu-2aFD4AFO_M0ImtWHpVW8yDfo1wjCppo
Message-ID: <CAPhsuW6VJ_yuxatCUQRxxVAYZeT-5JH_AytaTh6grBHLYmDeLQ@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] vfs: Replace security_sb_mount/security_move_mount
 with granular hooks
To: brauner@kernel.org
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	viro@zeniv.linux.org.uk, jack@suse.cz, john.johansen@canonical.com, 
	stephen.smalley.work@gmail.com, omosnace@redhat.com, mic@digikod.net, 
	gnoack@google.com, takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	herton@canonical.com, kernel-team@meta.com, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Thu, May 28, 2026 at 11:26=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Replace the monolithic security_sb_mount() call in path_mount() and
> security_move_mount() in vfs_move_mount() with the new granular mount
> hooks:
>
> - do_loopback(): call security_mount_bind()
> - do_new_mount(): call security_mount_new()
> - do_remount(): call security_mount_remount()
> - do_reconfigure_mnt(): call security_mount_reconfigure()
> - do_move_mount_old(): call security_mount_move()
> - do_change_type(): call security_mount_change_type()
> - vfs_move_mount(): replace security_move_mount() with
>   security_mount_move()

Does this version look good to you?

Thanks,
Song
