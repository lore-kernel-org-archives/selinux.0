Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572473C109A
	for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580109; cv=pass; b=St+WP+xEx7H8Lb+Cw+nD1sCHTImHeZRlZSiCQupRiKfjMCAah5mXHDKNmIY5cG9CZbzOu3QhDLXddR7L2DQysCZMDU/dqBdkGoxuo9Cpb4mtZDIFG+8NaCDFZOc8R/YZo3AJGYGccm0nt/7OdmBdqCEjJnc31YW167DsUqbYXxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580109; c=relaxed/simple;
	bh=+FnGzrkieywgVg11x7JlrzQVOV+0MSbS/7UrH/f2buE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NddAmrL9ce64SR/QnFEnZdzueArtVyYXrDfDftULwyeMEIqbjdVKhNdokURH3YN/lZuaEQKwQaCPdKDj9oldP9suzSWyUADZtvUQUKQRVj1D/BJ/KQN/PYhTuxwfRhBALnMmXP+dFxlbeEIIWA7ZekS3M5f6R02NK81w4XzD1xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=acU5kcyz; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="acU5kcyz"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38175907a56so3202634a91.0
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2026 13:41:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784580107; cv=none;
        d=google.com; s=arc-20260327;
        b=nfjzeuqHrfXMGtub074FuPd7jdjkotr0R3CXrpoBiW2zgOSiJCYahz1bA79v/uf2sd
         KIAj+01i0EulRFOYONGAwpnXW1L/gjoZb/rjR0RSzbVg4S1ZgAvtJbdNx5gmIOvZBgKD
         UEv4lIc2ckjxzguHCMF0NewGWOjMwCyRUVxq2rNX8l237gEq6HIqIuMYrYMj2Xc1dZr5
         F5qphR9WFtVJ6cT1Y9gfAsIN5TqZYVleIDooIaw53gpF8xo6gF6K7CYOB7oDnzZImngL
         LX2vZeEUVACSsLahuom7GuAJaCSGZxlRD/4QVhkiEsu2mm+c/jqcQJrGyXMCceQKrGEm
         fvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A9BFAH7wtR+2i0gcTzfUj/Ayf/0UVSPIiKXXXL362qU=;
        fh=pgOf/Mc/nU9Ja2k5Y3WPkMBRevIDPLsb66iT54OqH80=;
        b=pkdhLOI3C1mwFlj2ug9+fQJJXtrQReHwxD87lPM7c8GbPL2rP288awpxlhVNkl/1Hj
         tXh9D3P5/9Q43k0ceb17odtTFvfUYj0qTW/ZAoX8QULowq9psed+Ml/NWw28/CWB2XlW
         JwFhAFvUR/0bP85UXm7euxm5YHVdIcgBo9Cu1Mm+ppkT56VqWiwD/5oVGcYy8tlMduzM
         HdrsrUK7pzykSOfT9lu7knr4Ct5qvKbmh0FtG+0IFqBE7KkS+1LMfd3UetZN+/gcE+gy
         cESoeScK54L/7Dd9HrSp4hqcCTuZMj89TUgns0K/HZtSwb4WBsZ3GF/ELjy4MNyE4fb1
         Ok1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784580107; x=1785184907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A9BFAH7wtR+2i0gcTzfUj/Ayf/0UVSPIiKXXXL362qU=;
        b=acU5kcyz461RfGj31K+aMa61941kdHnQBbJ6e+23LJp4LwniIds9WYheH6RX4YeoNR
         7M52t4Ca736IkAbT2nYVebEA/eSSOwjaJECJ35omKzxXNoN0ZOQnqhKGz6LCYloqdDGH
         fGAodT8jcRTm6eVGA3+33QYCO47NNbbUaOtT/NrH2dRm0GLTh12p0sDRP28QvWm/B7ui
         U7ItQAxCvfMVlZ2CKXqWBQ1guXfAn9gKhFhgkrLpkTCLOcAsuRsCsaYkrB2uRhOtiSU+
         NXyQdOQhNBCOCVmzMfHof6ypHtgwwI6D64fu46mfBjdqG8hg7AixokpvzVQvF3qzwXNY
         ebYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784580107; x=1785184907;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A9BFAH7wtR+2i0gcTzfUj/Ayf/0UVSPIiKXXXL362qU=;
        b=rgkTbJ1DDJwFjwdVOfFDtc1p3C3CiLzMF3/5Dkheg1xi7PAR3mVyZmLtLPFBbss/kL
         ypOe1Gzjf2fmpP7WX3jpbhFHxyOhPO8kE0CHytHPXTpGDfL1lLLw8kPNZId4tI4KFsfN
         xEPryxR47vMcY2H37V0xHNdw4PcNPlciUG2cGHlsleE0X5fwP5k7qFXPFOAfs1JYV0XR
         Ox2hpJ6797pCzAk0lSFAgTjK2t8f4GhXv/gKSlUOOBRPDeB7uqiNqIDEsY2GlRIvgCM3
         vqakjcIhbA7DPU8qGZbida27yPwAH6ykPTASzlIVIpqEFaNh2LON8e68s6IC3BOv2j7g
         Wwng==
X-Forwarded-Encrypted: i=1; AHgh+Rr9q/jr2tJCHu+JtPvJ2zcvONdIevGqIZmvSNmPrWQ09CHqZiY61eOZIUCT3rJp3P+03xSTh1dv@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7cOTbTEtBLcjE02Xm3C3S4HCiPx7fBqlzLSGqhcdA3fwdZCj
	isjwYYpvDbfVIY1w+u8hMqa1QVCZG3WsldvD9o8UzwdckQQl2wDqbM0rAd9FtP914ivU98pdhdj
	BvhFJo6oUmcOKSvuUAKa5X7y53db9uG2UPYqdCQ6S
X-Gm-Gg: AfdE7cl4H11o9VjbpBGZE3XQSP8FGsRo5fzJEo+BXss8st8bL3ALbEQvvDQ+8DFdiDn
	D3tZn1HcqpC4hilc6bZtAGA9gsZbOel60YJDoPimCgwgBoiOCHWg0zL+j2dm3hegzpq1fXeVt5y
	Tj09Err7NDdAil9nx6hj78nw7gnnx0YFOxCQ2Dw9fcRegy0DMOaeOwFl1bQg5zlV2fXua4wiCeh
	8P5H+Ht9BIQXIcbispIACFQ75dPyCtiJR1tTVihC2bCbpe1dFhcdjSYzvPwqQ==
X-Received: by 2002:a05:6a20:9183:b0:3c0:9acb:3fc with SMTP id
 adf61e73a8af0-3c3ad121d58mr15942725637.33.1784580106787; Mon, 20 Jul 2026
 13:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-2-dwindsor@gmail.com> <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
 <CAEXv5_i_iHmF8n6Qf1NiVOhm2cCnVLgmwXK-b8M+hvmdO3aQdA@mail.gmail.com>
In-Reply-To: <CAEXv5_i_iHmF8n6Qf1NiVOhm2cCnVLgmwXK-b8M+hvmdO3aQdA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Jul 2026 16:41:35 -0400
X-Gm-Features: AUfX_mxGGJZotoA_L59yykgtbAa9gAB3rgxUm27TjBp9LjxVqLCLOtt3LkUBu9U
Message-ID: <CAHC9VhQFGQmJ829kAZ7U48kQOyPT-+zixb61VuK3Zn-myV6+vA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] security: rework inode_init_security xattr handling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 2:06=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >

...

> > > +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> > > +                       const char *name, const void *value,
> > > +                       size_t value_len)
> > > +{
> > > +     struct xattr *xattr;
> > > +     void *xattr_value;
> > > +     size_t name_len;
> > > +
> > > +     if (!xattrs || !xattrs->xattrs || !name || !value)
> > > +             return -EINVAL;
> >
> > Sashiko raised a good point about xattrs->xattrs being NULL not
> > necessarily being a good reason for -EINVAL.  If xattrs is NULL, yes,
> > something has gone wrong and -EINVAL seems reasonable, but the
> > xattr->xattrs NULL case does seem like it should simply return early
> > with a value of 0 (see SELinux's handling of this case as an example).
>
> The problem is, SELinux has already set the sid by before calling
> lsm_get_xattr_slot, so we do indeed get an in-core label for the inode
> before returning early here. Returning early here from BPF would not
> mean the same thing: there is no label anywhere, in memory or on disk.

It's important to remember that you are not always guaranteed to have
an lsm_xattrs buffer, for some filesystems that is going to be normal
and expected.  In these instances the 'xattrs->xattrs' value is going
to be NULL and each LSM that provides a security_inode_init_security()
LSM callback needs to handle that condition gracefully.

As you already know, the SELinux approach to this is to set the
in-memory inode label, but refrain from setting a presistent label
(these filesystems are typically either transient or don't have a
mechanism to allow for persistent label storage).  Each BPF program
will need to decide how they want to handle this in their
security_inode_init_security() callback, but in the
security_lsmxattr_add() code where the only purpose is to populate the
lsm_xattrs strcut with the persistent BPF label/xattr, there is
nothing that can be done, it should simply return early without error.

--=20
paul-moore.com
