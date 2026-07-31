Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E04446821
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514192; cv=pass; b=Nmr4MC3CSGJqjJGm95xSIf2K3L8SjvVYEnHbJJkzrjOQsCIx6ZJSSRyhTPJpb3BIRu59GJ7MQSGQEhLeiuMXYetoIpX/B8eNnsyHmGx3hWa92uPvUJh5eWBPmcirHn+GsqtoXX+DP8eH5cT7unzXEPPJUhxRf65+zwgK4EgzEAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514192; c=relaxed/simple;
	bh=E2RVSRIXeuAo+5wfQpBk4zmpUN/FQ1MtmGDwrYQP8YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3kaNiXQg/AQ/3u3Y2XQ88N2SMNL9dQksI7AJ7t6VZd/iwrtJC/Vdz+cSKuSYJwNODfO5CD+ed22c8wkfjeHKeSqt4liqvvXM7uCxp3sy3TGk5gcuNk7Frw12CwJdGEhDWX5dUCDCqCTS7cCsk4dGagT/GEeLhj6tXrAowstaFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cqM73njM; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cqM73njM"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38f620399a0so998086a91.2
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 09:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785514190; cv=none;
        d=google.com; s=arc-20260327;
        b=JAl62yMZnjVKJNSS/+HjDkNoa3GPmDrJIEhp+h9i14xir3QBH9ZEkipZgzNggWTmzD
         TdrwdwDRrQqyP0GejN2vOmV17hNvCV1ZUpvqoM8UmHTshRsinPBXaGIa/aOlYUKwsqwt
         +PQkUUuEBAeOJy3N46aWh0XwVzRAMnqvFyWiD9hfibnZ35FP1PD/qwqv22z7Dlo7pLfA
         bA8OrFAVlLocd4Ukrg6UP4xMyxs3BtpO5V56Q2h9kkBsPGyj0jpZkhmItjrws3waFb2m
         aSzhYlTWUq1Wdhu2auxtGHDh41SE7mtWGtevnJjIi6omrxc6Ny2zp/zeQUw5+MmPRxIh
         Pg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MLQBHce5Rf/yizV53vOxCocZN1WkAdEkQ9OKlG+s1GA=;
        fh=JWvC0lehAPg8SWVpgV7JJl3GMIFzid8KDELaceFyB1U=;
        b=c8VmGsYkqRnode7jAXVmGgCKPnEAnch/xppcZ/OjgzkrOdcDF6Rdf2sn2XSeZbuX7c
         +6UHbWIwLCfXT0x+QJP89Nw6/Svsy8KwbERZ7kfQFYk5HCkXjZ6BmN9aamUsGpX47Xa5
         ggSgZ3obgazw94yFZfb+Uj6lB0csDVgCPg1nUVEdTgIGzVt4Pq/Dxr393em8GWzCqPLF
         g5Br+7QOPpfsa9X7Yt74EKxJViiovUN6Yv+WP2sPMXD/MB313XY3loYjOmzAgEeHDW2Y
         Addsa4dTEGwS/NTRBsNgi+Lzzz91fznWM+9+TtjBbWT25uHh+33AB32jM/VAr63pK2le
         mYiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785514190; x=1786118990; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MLQBHce5Rf/yizV53vOxCocZN1WkAdEkQ9OKlG+s1GA=;
        b=cqM73njMXUadFgHefsHny48QLdlchgsJq03UlTMklOD16QGYAl29Px8XNxCgk+687Z
         I5uPB1A0WfenSXZAc02HEiRyVfr87keZ4Oa5kylnaceiSp/Fq7sKpWwBscc4c88j4Qdk
         pPsyTXxzX8O4jtPYCi6jMH9zEmTU+N0iad7WQR0o+Oatq2Fh2LALVyXENkRdLTJ9nyWz
         AgLi+nRgEtzRD15QvrrUQub3uV2OqAtJFL5e89/i5pdLpKTFiMoZqfzDqbLxid9HthTu
         tTW8ibqpUEsxWidbIJJrHuCXlKCzAwSdtj73g6yzSh8AW6YC9sEuHwtV3H3kadvkPVkH
         miEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785514190; x=1786118990;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MLQBHce5Rf/yizV53vOxCocZN1WkAdEkQ9OKlG+s1GA=;
        b=WvGAcpddmCjq6q24EGGFg1MhCkNZdw7y8vWFZlrYGppHpDwMWQqQU3BmoJ/dstNU8s
         KuVQTRVgwWE7XPvFGVfPUFPdYat7Dfkwn/y8FgbiUbHX2G71ph7g67wge3eFd6ixafPR
         glAVJMWmuVx4erocyYvkXpLQ57eeu7RABDgWxAO9BRXnn3Aq+ssFsKV4ukgvr9EBxoYm
         v/jH5KOHCRNCTR7v1tNW1+pcsBtVWxwK8ukCsHZmFYxDXa0KbB9deXVknuM8JRrgGG5m
         mMaVZflAijMg+gXUGUxUp8c7Wz7bU2ACJDO4dP0Vz2ZpdCHpsF3GsgMD6TNoojJdRpBm
         5PDg==
X-Forwarded-Encrypted: i=1; AHgh+RqNstUxPdoqF1ZE5fs61ri/0GXlbp8/ncjTS13kovZrgZstfewv+i8sla53Nm1HP3oYnr9tssu3@vger.kernel.org
X-Gm-Message-State: AOJu0YwIWelorBBctoiudFrJg23BvCYyQgO+FRsprwJCwtARulNe2BCO
	UCAmL7Bnet/PNK9OJFI1xRC1gZpQFih/Anu8kp81KtumOlobRRLlZYAnsSJExV61p20wZGNclCs
	n4ttYQZQEhGFo1geUxtVVbV7kFlpouAgVwdNw0XONnbRr3jr4U8t8bw==
X-Gm-Gg: AR+sD13pyCWN7uuBW6h0monOtn7BarKpR5rMWgUOZFn2xi+8QcDjDmsUIedhHPkbFpw
	qCdUAnrGwo7nvlu+dqCcKGG18noYvDwfWaT9CZXxuzDuk2b18h48JLiyJwTfWGdYb5onUpAoiGl
	ovco8FNrukO/8dlbq5vPgNRJsspm6VgLI+EGe9kWKV5lF/9E4bZ/neDzN74xK1PwuTOV8DIQ952
	WUa2fW/T06aB4lIhWU0Co+Zn1Pr5G5lhGNW5SyJOA6BLHzAKsVFtxbQLhVUf4FYipsjLAeGeRBx
	WFTw+Yu359/a1OT6rNJag0aRBtb4GGIjZSRQzDEldJGs
X-Received: by 2002:a17:90b:4c42:b0:37f:9cdf:f0ac with SMTP id
 98e67ed59e1d1-38fbc4cf1b2mr463861a91.27.1785514189775; Fri, 31 Jul 2026
 09:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <20260725200958.4471-1-cel@kernel.org> <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
In-Reply-To: <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 12:09:36 -0400
X-Gm-Features: AUfX_mzgQGB2mMZ1ML9jDaE9s_9fzccqwz-sP-5nGT2rz4DpCr8cGB7c5pnPRjI
Message-ID: <CAHC9VhS6B1yW+8G9Biqit5CAmcg4CwCaWbq1B+Qpo2n6a=yqnw@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Chuck Lever <cel@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Trond Myklebust <trondmy@kernel.org>, jlayton@kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 11:03=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
> On Sat, Jul 25, 2026 at 4:14=E2=80=AFPM Chuck Lever <cel@kernel.org> wrot=
e:
> >
> > On Mon, Apr 28, 2025 at 03:50:19PM -0400, Stephen Smalley wrote:
> > > Update the security_inode_listsecurity() interface to allow
> > > use of the xattr_list_one() helper and update the hook
> > > implementations.
> >
> > This commit wedges an NFSv4.2 client running fstests.
> >
> > A kdevops fstests run against nfsd-next hangs at generic/086.  The
> > client stops making progress and never recovers:
> >
> >   watchdog: BUG: soft lockup - CPU#3 stuck for 250s! [086:60396]
> >   Comm: 086 Tainted: G  D  L  7.2.0-rc4
> >     __pv_queued_spin_lock_slowpath
> >     _raw_spin_lock
> >     nfs4_xattr_set_listcache [nfsv4]
> >     nfs4_xattr_discard_cache [nfsv4]
> >     nfs4_xattr_cache_scan [nfsv4]
> >     do_shrink_slab
> >     drop_caches_sysctl_handler
> >
> > The D taint says something died earlier.  It did: by the time the
> > lockup fires, the client has already taken two dozen NULL pointer
> > dereferences, all of them in the same place:
> >
> >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >   RIP: _copy_from_pages+0x44/0xd0 [sunrpc]
> >     nfs4_xattr_cache_list [nfsv4]
> >     nfs4_listxattr [nfsv4]
> >     vfs_listxattr
> >     __x64_sys_listxattr
> >
> > The two stages are connected.  nfs4_listxattr() declares its
> > remaining-size accumulator as an unsigned size_t.  On a size query,
> > where listxattr(2) passes a NULL buffer and a length of zero,
> > xattr_list_one() decrements that accumulator for the SELinux label
> > without regard to the NULL buffer, so it wraps to a very large
> > value.  nfs4_xattr_cache_list() then sees a NULL buffer paired with
> > a buffer length large enough to pass its own bounds check, and
> > copies into it.  The fault happens while the xattr listcache
> > spinlock is held.  Task exit does not release spinlocks, so the
> > lock is orphaned, and the next shrinker pass spins on it until the
> > watchdog fires.
> >
> > The reproducer is a plain getfattr on a file on an NFSv4.2 mount
> > with SELinux enforcing, which is what fstests generic/086 arrives
> > at by way of a drop_caches write.  No fstests machinery is needed
> > to see the oops.
> >
> > An audit of the listxattr path pointed here, so I built nfsd-next
> > with this commit reverted and reran the full fstests nfs_v42
> > section on the same pair of guests.  745 tests, no soft lockup, no
> > oops, and generic/086 passes.  The two failures that remain,
> > generic/033 and generic/258, are unrelated to xattrs.
> >
> > I am not proposing the revert as the fix.  Achilles Gaikwad has
> > already posted a targeted patch for the accounting itself:
> >
> >   https://lore.kernel.org/linux-nfs/20260707152305.15324-1-achillesgaik=
wad@gmail.com/
> >
> > Whether the right answer is that patch, a change to
> > xattr_list_one() so it leaves the remaining size alone when the
> > buffer is NULL, or hardening nfs4_xattr_cache_list() against a NULL
> > buffer, is for the three of you to settle.  I am reporting the
> > severity, because the accounting bug is not confined to a short
> > size query: on a filesystem that caches xattrs behind a lock, it
> > takes the whole machine down.
> >
> > I can test whatever you settle on against the same setup.
>
> I reviewed Achilles's patch back in early July and it looked okay to
> me (see my tag in my email in that thread from July 7th).  I had
> figured that the NFS folks would have wanted to pull that via the NFS
> tree since it only touches NFS code.  If they would prefer I send it
> up to Linus via the LSM tree I can do that, but I would appreciate an
> ACK and Tested-by from someone on the NFS side.
>
> While I don't suspect it will be very interesting, I just started
> building a test kernel with Achilles's patch that I'll run through the
> normal selinux-testsuite automated testing.

Chuck, Anna, Trond, Jeff - can someone ACK Achilles's patch below or
suggest what changes might be necessary?  There is a known regression
(see the existing mails) and we need to fix this before v7.2 ships.
I'm happy to send this up to Linus if you would prefer, but I would
*really* like to see an ACK from someone on the NFS side.  If I don't
see any comments be early next week I'll send this up to Linus via the
LSM tree.

https://lore.kernel.org/linux-nfs/20260707152305.15324-1-achillesgaikwad@gm=
ail.com/

--=20
paul-moore.com
