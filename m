Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348B2741B6
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784857281; cv=pass; b=tglM01OTyKK2RbtJhWe+wfxRJ+By76AAfIhmIH44uvs4hEPZfmYkSKbAPC8YUq3sUHRv8iA4Ki+SzQs4KYjmEg7Wq5NBpvyn3Hq/kv00ETD1OkjavlCI6be1TQJjAGzAY2+IZEoek5X1MXba1m8Wog4M4qUic5C3087ggt81yw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784857281; c=relaxed/simple;
	bh=VgG1L9n4qkqv88OVPiAOkH5r2fUCEJuZKIZh2co0UY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwR8ozwx0rl6MIcGRtALN5WoDPSosm/N06gs6OjOpCgHjwPAMUGeDlIHMz2mtWnzwb9WqHdpkYy3pmDy75hratup5geAXrbqcFRlq9NgzBBnJBr1mAUFcNBCwbeJqd8BnwVyvpWqqaGoB7/CAP3IxBJ+je1d6/LgkKwnamXh/Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkSPxvej; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkSPxvej"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f0e5e36912so10891856d6.2
        for <selinux@vger.kernel.org>; Thu, 23 Jul 2026 18:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784857279; cv=none;
        d=google.com; s=arc-20260327;
        b=nPHFtUlMFGdoO1B2JqgWApiNchhR6Lcw4jZdX58DAig4XVG1lNq5ahhn8wQmS8XxBC
         PRTKLvxp/6xLNrcSoKkYRGR0A4QlhjfLBNhIn07PAlRD7x5B3j/OjRN3G5eKxwvUq0pY
         B4NldRUtOjoJyqDLb4dOzYhgotfCxCILEFWPduTDzk45GCy88jGZqV30rE3dQOVsBzTq
         xDXqlIZw9FniPL7jl666wPWqI5+w4W748611/lmWB+53Nrl28t/CYGRkS/TK/ceeiVpi
         6NUaqV1ujn854F6dqjD6IdODgg/yYpN074I0Zi65mRrw/3wl19tc4PC3/rbRu4QJTZAJ
         8EYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ejkg2QiGxw6lNSk3SatrnK8cKuk/Z/iPaAUYh7RRVpk=;
        fh=tLjubxhTCn+vH2Nz8w/TesszJdJP7OHBiZqfFnWxnWc=;
        b=YIXn5nnrySf58BYyVzi8Vk5jMVTegbcGAD6jZRE+b1TzVPoc5ky5IFlKi0B+fMdfPL
         LMVqGxF+esRHZvJpb1u5mgAOJkFpFLm44N9nHPxSONSpSePinWkbt6ga710OOVTCkE5b
         d0mJrT2/NPmPaZBUrgd6B5ci4VT5OcwuDHsyEXV7LRsPqX2p7yhseRDxp7640x85vF+L
         mDQAN80Y7LYV3vqIK27/AMCJb/xx5QNMqSaupX2ZgQUMKWQ5bpOQZUIw0w2hlyee7S4b
         LWmleTXrbFOBKYBMOmiDse0isUn+61590TVXvM+LfkkIL8mdI7LnO8dXNAmjc1knR6B/
         Mxxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784857279; x=1785462079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ejkg2QiGxw6lNSk3SatrnK8cKuk/Z/iPaAUYh7RRVpk=;
        b=TkSPxvejqbro1K/uX82Xq1lfAfEBj2NcclfYE7eKvV1W6T0XoATG91PYo2cqDjUB3F
         z04f+ulHgLIovyxQLxckGgH0lMlWPVhHWsnRyzP0tEsk//D9C4GIlrjrh32D77Ekqf2o
         AI59ZrCYFx1LeWIpT7mj61vZ4OKBqRew2DFOVzLnx0gbM+t0mJsCbpILJvFqcEUEGnwt
         0jBrUYlz6OIzH6cPETmIIKTKBEP6+c7cX0L9+aivERUcWtU9K8Xp9CngJ34qgl1q/z9j
         pRdiu6GuIRDMPkVYzWHd9C/f6XPcMGKK6MBiczQAPXYi5z3TJfSslo/4qWUyZxBPuM5V
         fU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784857279; x=1785462079;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ejkg2QiGxw6lNSk3SatrnK8cKuk/Z/iPaAUYh7RRVpk=;
        b=ChYaL+axcHUEP/c03Y9YNDS+KlFhcjiQeiUSnOM4MryEJ+bjALqXnREwkwfvACBfv1
         Dwu4UjQa5ysVk4gdkrIaNV2M0GOP/lRKHPA99e80reFsD4kgAU3G54JmepdMG2P+PAXy
         b5wMQG59gRwZxiSCSq8Kdz14Dtn4+3MgfV3leAdi6jQQKXEooKouuweDutiiOp+YVSaX
         SPXG+sxtf0+/m/2WV16mWk8awSi3xAfn1xaSwyrTST/ZZHb76ptcF7ERyqbGpkD0Vsvz
         UYJMu1Wtk1DSSqLYkLeK3aQ7NMVx5ixiLqhDFwxthxxNAs1gjIs2E/YjPelKbOCBI7sB
         a0dg==
X-Forwarded-Encrypted: i=1; AHgh+RqGOwcEcpK/EvY+X0v2LbSyQI5Wt51bbChxibNLP+bof3lfpZpgFK5KSFliuEuBsLa7csI7HBqT@vger.kernel.org
X-Gm-Message-State: AOJu0YwtUkCGdwHSnX+VA4KwRjivCnOzpe9GKPf5qxKOJboLQ+Pu5Ph4
	wfTXKVCqFzLAl0P1vkpOYzNDQvc2OwjS/WwL51MJgxbtQK3s9Lg5nW+TN9Bb+RE3iKTeEq8OBMz
	YhPR79woDP0AMvbeoLETrYVhn9HXKiKI=
X-Gm-Gg: AR+sD11ayi+N6dMUG0jMuqTDIHgPo+dGea8gHx5CCjj+GDYEvEIJnDNmU6tqcMfTZkf
	O53Dbp6Bm8imJJhD00Xy1T9EH6TEGa1z/W69ZAG+IeYkx65opYw8fw8+wW7hUeoPuMU/z6NaR4f
	VWUCdRp/efcHM13+isyc4ru75bRdS2g1lpSVDAkFyEAhkCTQ4TreiTd0SSoOfv9bc4h3DZirWPa
	w3RZJojN8+WadeHN73diLxCjdWtPr6gjYI/1Nsln3RBJiT/GIGFmgAgcfOVSkPlWwqDUW6rWf02
	jhKTYQZeWMq2gQtV
X-Received: by 2002:a05:6214:338a:b0:8e0:6b2b:1a9 with SMTP id
 6a1803df08f44-907ca5f00c5mr60830756d6.38.1784857279135; Thu, 23 Jul 2026
 18:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-2-dwindsor@gmail.com> <cb9f84292a7f1d41ff8388d8c0c8c3d0@paul-moore.com>
 <CAEXv5_i_iHmF8n6Qf1NiVOhm2cCnVLgmwXK-b8M+hvmdO3aQdA@mail.gmail.com> <CAHC9VhQFGQmJ829kAZ7U48kQOyPT-+zixb61VuK3Zn-myV6+vA@mail.gmail.com>
In-Reply-To: <CAHC9VhQFGQmJ829kAZ7U48kQOyPT-+zixb61VuK3Zn-myV6+vA@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Thu, 23 Jul 2026 21:41:07 -0400
X-Gm-Features: AUfX_mwSCaLmbKkOiyonsmMoEe-BHwDr3PK1QzzhyLZjx1CuuJvM1nFkobHbazY
Message-ID: <CAEXv5_gMkKNfuxZf1uoUJ+nFAH=oyHpc3iJAVUbP3duyA8AcvQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] security: rework inode_init_security xattr handling
To: Paul Moore <paul@paul-moore.com>
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

On Mon, Jul 20, 2026 at 4:41=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Jul 20, 2026 at 2:06=E2=80=AFPM David Windsor <dwindsor@gmail.com=
> wrote:
> > On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
>
> ...
>
> > > > +int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
> > > > +                       const char *name, const void *value,
> > > > +                       size_t value_len)
> > > > +{
> > > > +     struct xattr *xattr;
> > > > +     void *xattr_value;
> > > > +     size_t name_len;
> > > > +
> > > > +     if (!xattrs || !xattrs->xattrs || !name || !value)
> > > > +             return -EINVAL;
> > >
> > > Sashiko raised a good point about xattrs->xattrs being NULL not
> > > necessarily being a good reason for -EINVAL.  If xattrs is NULL, yes,
> > > something has gone wrong and -EINVAL seems reasonable, but the
> > > xattr->xattrs NULL case does seem like it should simply return early
> > > with a value of 0 (see SELinux's handling of this case as an example)=
.
> >
> > The problem is, SELinux has already set the sid by before calling
> > lsm_get_xattr_slot, so we do indeed get an in-core label for the inode
> > before returning early here. Returning early here from BPF would not
> > mean the same thing: there is no label anywhere, in memory or on disk.
>
> It's important to remember that you are not always guaranteed to have
> an lsm_xattrs buffer, for some filesystems that is going to be normal
> and expected.  In these instances the 'xattrs->xattrs' value is going
> to be NULL and each LSM that provides a security_inode_init_security()
> LSM callback needs to handle that condition gracefully.
>
> As you already know, the SELinux approach to this is to set the
> in-memory inode label, but refrain from setting a presistent label
> (these filesystems are typically either transient or don't have a
> mechanism to allow for persistent label storage).  Each BPF program
> will need to decide how they want to handle this in their
> security_inode_init_security() callback, but in the
> security_lsmxattr_add() code where the only purpose is to populate the
> lsm_xattrs strcut with the persistent BPF label/xattr, there is
> nothing that can be done, it should simply return early without error.
>

Makes sense. If BPF LSMs want to store an in-core label, they could
just use bpf_inode_storage_get.

> --
> paul-moore.com
