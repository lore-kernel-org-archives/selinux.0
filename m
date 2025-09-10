Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299F322A0B
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 15:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519846; cv=none; b=eJ1qcwb4jIuCTHBQrQj7Tn/tMQ5QgdSoJWj9hxNqWoKkarP7L8bn6fOMawiPKZVfqgBqSN5QtwxNjwCOSFa2IpgVgmwVyEPTRw4L49ik8JMHsmC3Az/xrhTLP8CdMFO+/R7RZDgkWd2tFDuxXvzTQ5rz9RZ7MqPcdPk0q9OYMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519846; c=relaxed/simple;
	bh=UhtpK+fR4vzmMUT8w4HBdU0LdwzJsBusDlItj/1Iimk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmDw+I9IQH1q7PHxXgcM/+21v/Wi+K/zyx2i5cmgMi//jPe5LY4ozDRtjYKCpnsHUwQUzqthh3ewmxYMnSyAvuRe9N4wQilesxw0yXRGk2dwnTdZTeMptGpYgpUq+oBglWhx7rm+ueBf/8eZ5hM0GLrMjiNva0gsD8gsvQlpUCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NwypYQEG; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NwypYQEG"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4c9a6d3fc7so4258372a12.3
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 08:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757519844; x=1758124644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti/bisax/mYPcwWlxiqbRKmvsjZLOMuiKy61zi+P8NQ=;
        b=NwypYQEG5zsG06yBazZRn9sVgmwwnYmVmrv8eQc05Frf5GKQ+SnuJxcXloIsLTpXjL
         Ur8D1uqaiDy+M0tWy+31oFjhlvK8LjCl4d6uBlUF/s47O94KED8DeoU4u71u8asbZtyU
         YExdx3IaMOhGU00ZIG5ukZ8qYDpGtDC1WFXBZlBQHiTsnyogcb18WaSu0C8xwcJaGcOb
         7i/C6sllPw0g6bWOJx1L8W+QjHUScxdzHwKgEv0xt0p9lzHb2fT65+BjfmpaCyYEFVbD
         UCkrP8R9m/NiJSYdlntXAXBwEITywBCwsBTCpczApib87Qkuf2SP+pYO328qzaV/8oR+
         T+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519844; x=1758124644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti/bisax/mYPcwWlxiqbRKmvsjZLOMuiKy61zi+P8NQ=;
        b=jHtxseDQoStorAfUuZyBiPctIGWPl6SL3j/6HCa9eacS1kDmBGL3/w/1eQf/GcWTxs
         Ep30kuRTIvpc20zFGPu2QJdv93T3P6OJm99v7hEvEVBIDZ85JyBay7TCuuJagR2WRxn/
         AraHI+DIV2JXw/0sXv5FWQc0xc+AAENRsdS0HQMueV+iBUO9RIa1V6EqG1M1+hkc65Hp
         f/SYYnUwwZsst22fh0lOjEBXzENPZhy4O9pCu4XkzvJoEz5Minfv+BXS5U23cxfvo4lC
         ReA3nh2d29m6dskNfFygBiY5M9KbCLDbZMd3RmF2uk0C8VjmPPjOaUKhVFocKhAMVF8q
         hXvg==
X-Gm-Message-State: AOJu0Yzo97k16yTOoTeAkCBX7fbmokoJMB6p+8upKOGVfTh8s1jAqNtt
	I/3boCr9rJ2A73HS30PqxY6Np5C0u2hDHaw7RftZ1RxC5rjKIubARmPt0zlEK6vz1HpXeMFREDH
	kloeVDcJ4+bLOmbZOhtGxwO92/nl25/3mnhfMrqJP
X-Gm-Gg: ASbGnct+0C6g4tlJqo4fWq1O3HQK9n8nqgHsKA1bB4hxwachtUSRZXfcf1n6iV4XnCp
	KmFCnB3odeSfUk02PjELLfu5DSnuYjnCAoilTv5yM6/uN9krI238dn720uwBCnbBEuvHIfa4X8f
	AgsJ5DNnJKid3hKnUYdhKzRqhybp78xd+SRmel5B9hZISG9F5bFGxOLHla8GUNhEDy08DxJqKgO
	gx1B6Y=
X-Google-Smtp-Source: AGHT+IH6OvaHzfrQOdhLw7b/yEgVG5bZS7+bKYM/6ixh5x3Of1CnpWSWQAcmg3DUKfslQVrqpwBUW/4TyUQ97y18JwI=
X-Received: by 2002:a17:90b:48c9:b0:329:d09b:a3f1 with SMTP id
 98e67ed59e1d1-32d43f1774cmr20431852a91.7.1757519844428; Wed, 10 Sep 2025
 08:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Sep 2025 11:57:11 -0400
X-Gm-Features: Ac12FXxitsCDwLDYZQOR2iJWpvWSMvIlyP5vmTyitysBTTzS7blua6z-iy9F6hE
Message-ID: <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 10:05=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> >
> > A prior commit, see the 'Fixes:' tag below, added support for a new
> > object class, memfd_file.  As part of that change, support for the
> > new object class was added to selinux_bprm_creds_for_exec() to
> > facilitate execution of memfd_file objects using fexecvc(2), or
> > similar.  This patch adjusts some of the sanity checking added in that
> > commit to avoid a "silent denial" in the case of a kernel bug as well
> > as return -EACCES instead of -EPERM so that we can more easily
> > distinguish between a permission denial and a fault in the code.
>
> Technically, this doesn't make it easier to distinguish because we
> usually return -EACCES from avc_has_perm() and friends, but return
> -EPERM for capability denials and in certain other cases (not always
> clear why, arguably a bug unless we were just replicating the error
> number for some existing check that also returned -EPERM).

It's awfully fuzzy from my perspective.

> My
> suggestion to use -EACCES was because that is more consistent with how
> we report denials outside of capability checks.
> To actually test this, would need an updated libsepol patch that deals
> with the fact that the policy capability number changed on merge, or
> re-basing the original patch on top. Otherwise,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

To be honest, this isn't the sort of discussion I like to see for
patches that are merged in the -rc5 time frame, if we're merging stuff
at this point in the dev cycle we should be past uncertainty like
this.  I'm obviously not going to merge this patch and I'm going to
drop Thi=C3=A9baud's patch from selinux/dev too so we can sort this out.

Thi=C3=A9baud, go ahead and take the WARN_ON() change for your next
revision of the patch, and let's continue the discussion on the proper
return code.

--=20
paul-moore.com
