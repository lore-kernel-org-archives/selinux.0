Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022B1552FD
	for <selinux@vger.kernel.org>; Tue,  3 Mar 2026 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544637; cv=pass; b=RAWvh15YqM18BaCnes9Dsd+z1yx2j2dz9ucLJqJvybRyljxy4lQb2V0rTTfWAQh4uQ1xfxIh1OI3hVno4sCCzllWBbx2th+saftmPu8MeO2UByFaWdxnn4383iLIASJRFmL25I4gEznzsP26NKiOny97NNb+vJyjiFUCdGxIOi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544637; c=relaxed/simple;
	bh=TPmZuENf+xpPALFd+K4N9NZreHNFZW4jsYUsnEcVgMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzpU85f5QbUkuRCLR5bmyRpU8RM+wSg7efP3qO7Kl4LyIETri1uaWFgmwCJo1nQObV6gmUKsZHwWvr2QkS9uqVi5Vw4/0a+WG7IPypZb09fw58IRLI36Ps+ZGVNw6fsOEWdb8rVqcd7p2ZTcZF53VMxexmBDM3TnP1bVzd8X1oI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cd7bNDFr; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cd7bNDFr"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c70f191313cso2225923a12.3
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2026 05:30:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772544636; cv=none;
        d=google.com; s=arc-20240605;
        b=OVCuy6sHyJ66VUoYFgMmO4ggwlXNukOimIGyIOErAdtb3XuvH+BbrEHwTdrz0q0WKF
         hf2x7xI8hsrmpQMHJXgWbYI3tb6xsZt8+dFY7yVzvCDJD5AdBkWkJ6hGcDhBwI2trryN
         t1tn2TrsYcvCk4ry2mTylZ0kC1Ks5lfHQrKjhC9HiuJOIGfserZgaRS4C5/A/e0igaNY
         d61F+6FpT0Kaad6NjynPFsl7CBEwTKD99iX337f8IzOsFCkjS2EWc+SbiEVPCuEVBf32
         kwIORmtUXgDfnZPXHjmIIIwDwlA8RW/DSjOFLr7NHnGqUvzLuiiDIW7+bSmcWEHs0OyR
         YDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=im8ZctEmpsXdkeky12LRTuORqacf4TX4RzgYY97Ceb0=;
        fh=KsxfYpTYcXQfr2Kycoa6gYsBNJr38IRpKkMHPIo6oCM=;
        b=YSglJaxgvvX4YVBIjgFQASdxeUC0hNYA4gpRhcYx55es3YM3W5xVHdo42eDSQ+BFCY
         BEUKf+zJehw6tx249sYDiaA/n4OtlBoQVWijksABVErMQmOqf6NwMGSGcu2ADWfFSXqK
         sMkRri6GixgKpQPAxi3gNeQ9LmcAYyCpzkZ5NE0BS0KkPuNzU5u8S6BajtkeJGno/duY
         x+r8i9rEPNaOZSfqajWLy8TuOiBWxtVx5gR3Hsi88X+G1w9CCyWcRbOUEf80Dj2/+Cdc
         K8+Q54uFxqiYRLxxT24IsAfdXGY27nyh/4PCvT+XF4dCYJ1mOle+J4qxVQkbOVbmUK22
         q4OQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772544636; x=1773149436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im8ZctEmpsXdkeky12LRTuORqacf4TX4RzgYY97Ceb0=;
        b=cd7bNDFrtZ9DOd7Hf7c9wgs0c2t3rBvGgP9FILNdX3drqHcO8BnxYbOwGtDTMn0egR
         he6kb6ov1USUpQpAp7iSZQj7ByX35/mnI2r3oeIvISrc28JFPFE6ZwNwm+r0NgsyBm0C
         c84StJFOU0+q+E9gwM0BfcGP7CqIhSvp9bczi5mcZ/uleiOCnX2xKJ+NylgF1RfeYVhO
         EH6XqwLjVIfzKqp5Gfz2oDDEPGUX4ihrMc4W1SGZiL9Q1V7bYfOfz3920rZW/QXRY2ND
         sX0CTy5sZB149obp2Pi66apFo6cJIZFa8uYSI1CH2WCOTSXaDhOa5iTS4B3/SCOeCh8m
         0eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772544636; x=1773149436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=im8ZctEmpsXdkeky12LRTuORqacf4TX4RzgYY97Ceb0=;
        b=Eb/6rkt0njs1VPtEXe3Hvqw8Xns4PEFwD1oiQIaAYAbsqkV1VN3vfMXz1cc3mvJ+sY
         Bz4fBMQLQb7ir4zL+q72Nul8c1ePy5f9JQ78GBTPLyxGJu/C5a8Qip4zHAVZE+NncX3U
         ccCg0vlpIfETF6UppJSiQAGYcTf9nX3IJScq6VRmfpRn8qrUe3JzjO9rqhShHWjfxFrt
         zZz/C5gPk17wbT9Z2kBymz9gKDR42t2R3T1NpgBP48xQaQu8470rPAZs0BgcB6Fi7dYj
         DBrE6/pYPCKQC5IFhx9ciYWEpLtyG9QBmhGEs5YRxHoMOtVqwuGKBvouFdjBUp44qamQ
         wcUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgEht3lkknYLb3gsO/bXGvtKuKYoxUCeSPcvAAKDDGVMWuuSLVv+mJOGn977gG7rwCZXRLe5PB@vger.kernel.org
X-Gm-Message-State: AOJu0YyBNzhh2kAmRhXdBPDehwOpjnvkgCN2IuvpBp3fwAMm5HXtpgQI
	TFKekhE4A6IKROWlQ18mqhr8F53FZwgfrRpPH44idWgPoB90ChW6FvXg/pYld0NxaFOUOmetEnc
	VHqeXjhIHhDq2YCDnn2fvOqrJQlis75g=
X-Gm-Gg: ATEYQzy3S/373gNUU34mKzOt1D4EYj7P/y8Lq5lOb44sKycvGP2m4EEwJ1VTcj+cWka
	dFA9T9+8rukO2y5H2a/AI6VGCbgySdnvbtrC5CnGxhE3wxFmv+tzRAdWBhgx60O0gHJJtSNUXeK
	nutusPqQBoeptcN+86gw49lsmd4Sb/CpOM9c2L02ncZHc9e9AEIQG6J0bd9Lf1YGfb1u+LIU4qv
	sz37yEPUjOQF4AYw4gEpQBoDleLdEK4U6DVPcF/UJsSykvztmab0v/oRJhmV/LvdqDo2ZXxjtbf
	dChKCqo=
X-Received: by 2002:a17:903:22ca:b0:2a9:42ba:b093 with SMTP id
 d9443c01a7336-2ae2e417b93mr176357345ad.25.1772544635624; Tue, 03 Mar 2026
 05:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 3 Mar 2026 08:30:24 -0500
X-Gm-Features: AaiRm51B24m8BS1lm-W8zAv3yrpHDogeldeLu1r_WUIc-okMyPG_92haWYA0IL8
Message-ID: <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 7:05=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> I spent a few hours this afternoon re-reading this thread and tweaking
> the original proposal to address everything discussed.  The revised
> proposal is below, with a bit more detail than before, please take a
> look and let us all know what you think ...
>
> * lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) and clone(CLONE_NEWLSM)
>
> We would define a new LSM_ATTR flag, LSM_ATTR_CLONE_NEWLSM, which
> could be used with lsm_set_self_attr() to request that an individual
> LSM create a new LSM specific namespace on the next
> clone(CLONE_NEWLSM) call.  LSMs may choose to perform various sanity
> and authorization checks at lsm_set_self_attr() time, but they must
> refrain from creating a new LSM namespace until clone() is called.
> LSMs may also want to ensure that any state associated with an
> lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) request is not carried across
> an exec() boundary, however, that decision is left to the individual
> LSMs.
>
> We would define a new clone() flag, CLONE_NEWLSM, which would trigger
> a call into the LSM framework to invoke LSM specific callbacks to
> perform namespace actions specified either by the LSM's policy or an
> explicit lsm_set_self_attr(LSM_ATTR_CLONE_NEWLSM) request.
>
> As with the existing LSM_ATTR support, this is strictly an opt-in
> mechanism and individual LSMs are left to handle this request as they
> see fit.
>
> The lsm_get_self_attr() syscall could be used to get the
> LSM_ATTR_CLONE_NEWLSM value(s) for the current process just like any
> other LSM_ATTR flag.
>
> * lsm_set_self_attr(LSM_ATTR_UNSHARE_NEWLSM) and unshare(CLONE_NEWLSM)
>
> This would behave similarly to LSM_ATTR_CLONE_NEWLSM, but the LSM
> namespace changes would take place during an unshare() call as opposed
> to a clone() call.  This is kept separate from the
> LSM_ATTR_CLONE_NEWLSM flag because the behaviors are quite different:
> one creates a process with a new LSM namespace set, while the other
> changes the LSM namespace set of a running process.
>
> LSMs are free to implement support for either LSM_ATTR flag, both, or
> none at all.

I think my only caveat here is that your proposal is quite a bit more
complex than what I implemented here:
[1] https://lore.kernel.org/selinux/20251003190959.3288-2-stephen.smalley.w=
ork@gmail.com/
[2] https://lore.kernel.org/selinux/20251003191328.3605-1-stephen.smalley.w=
ork@gmail.com/
and I'm not sure the extra complexity is worth it.

In particular:
1. Immediately unsharing the namespace upon lsm_set_self_attr() allows
the caller to immediately and unambiguously know if the operation is
supported and allowed, versus having to wait until a later
clone/unshare call and decipher whether any failure is due to the
unsharing of the LSM namespace or something else,
2. Immediately unsharing the namespace upon lsm_set_self_attr() allows
the caller to perform the operation in any desired order relative to
creating a new process or unsharing other namespaces via explicit
ordering of the call with other clone or unshare calls, providing
maximal flexibility/control,
3. We don't need to introduce a new CLONE_* flag at all or introduce
new or changed LSM hooks to clone/unshare,
4. Implementing unshare-like behavior was in fact quite simple for
SELinux namespaces and no more complex than doing so at clone time,
4. Any perceived atomicity benefits of delaying the operation until
the next clone/unshare system call and doing it at the same time as
creating a new process or unsharing another namespace are unclear -
unless we were to change unshare/clone to completely rollback all
changes if any of them fail, they won't actually be atomic and
unshare/clone could fail with an intermediate state left behind.

All that said, I'm willing to wire up the SELinux namespaces
implementation to the proposed interface if someone implements the
necessary plumbing, but I'm not sure it's better.

> * /proc/pid/ns/lsm and setns(CLONE_NEWLSM)
>
> The /proc/pid/ns/lsm file serves as a link/handle to the specific LSM
> namespace set in use for the given process.  A process wishing to move
> into the same LSM namespace set as another process can use this
> link/handle (or a pidfd) and setns(CLONE_NEWLSM) to change its own LSM
> namespace set.  It is important to note that using setns() it should
> not be possible to change the individual LSMs that are part of the LSM
> namespace set, the calling process' LSM namespace is set to the exact
> same LSM namespace set as the specified process.
>
> Affected LSMs may choose to enforce access controls on the
> setns(CLONE_NEWLSM) operation according to their own policy.
>
> * Policy considerations
>
> The mechanisms above provide for three different scenarios: a new
> process creating a new LSM namespace set (the clone case), an existing
> process creating a new LSM namespace set (the unshare case), and an
> existing process joining an existing LSM namespace set (the setns
> case).
>
> In the clone case a new LSM namespace set will be created when the
> process itself is created.  It is up to the individual LSMs to
> properly initialize their own namespaces and load any required
> policies.  Since the new LSM namespaces are created at clone() time
> and before exec(), the calling process, or another trusted process
> using a new yet-to-be-finalized API, should be able to configure the
> newly created LSM namespace before exec().
>
> The unshare case is similar to clone because a new LSM namespace set
> is created, but it is a bit more challenging because unshare()
> modifies the calling process's LSM namespace set, not a newly created
> child process'.  For simpler LSMs this might not pose a problem, but
> for more complex LSMs, developing meaningful applications that use
> unshare(CLONE_NEWLSM) and properly initialize/setup the new LSM
> namespace set may prove challenging. Developing applications that use
> clone(CLONE_NEWLSM) will likely be much easier.
>
> In the setns case the process joins a properly configured LSM
> namespace set with all necessary LSM policies loaded, there shouldn't
> be any additional LSM setup required (although the work to change the
> individual LSM namespaces on a running process may prove difficult).
>
> --
> paul-moore.com
