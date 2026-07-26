Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371E62D3A93
	for <selinux@vger.kernel.org>; Sun, 26 Jul 2026 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785078236; cv=pass; b=AMJoJy0hFmSG+VbJNSeIPfBp8G1NGmhwnvCnVpDxfH8RvghrvRXVGgW9hp8QHV2xnJ8xnZRq5xb7SjCrxHiObslSlvDzwOpaPleo8gFaTUE407tCTSwFPjFezTgH1R1Z+QlLnGYrCqHXwKBDiToY810j60+xqLYJrH4L6HD2VnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785078236; c=relaxed/simple;
	bh=liVqCRED6A0BSTJ8Z+3vALEAqve/O95RkgsCR7qCf1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KuUptKqEUkdxqq0ibauHxqzKTxBl1QP9EkpVrhBgs3NI8SPJ/jYm108IZmEcuaDK0jTU1DQVFGdh/K5RJa0IchLdOXyWmpttd7ZFi7J867OaESDUFSLPiINkEo4W3CE+T1T5OVOV5Q3bP6XZ0WCl/vQm59X02Q2I4vfW2BXai54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Yz6Zdn7T; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yz6Zdn7T"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cad8076b01so21864955ad.2
        for <selinux@vger.kernel.org>; Sun, 26 Jul 2026 08:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785078233; cv=none;
        d=google.com; s=arc-20260327;
        b=oiNIq+7QqHNLuKRYOtbyo6zPSeu976nbM7hvaYV6ezCo4HD8IVI6dlvUv1F7cmzNLC
         hkBt5s+xie09ETPjbjP6cF+J2zENtuTG3D9JEi6nugWsBXLraS1HmGd7IZ8TqTUxVjsl
         /MkCjUL8OaToqOMXMwJdD7dBmVoqCOC/MTN/V9Fnfc7IiXEzWBDoD1Hl1TN8d908w8Wl
         YRs86+34n6ux3mZyNLKcB4+0aqcRyEs98E+pqDrhg9Op/FcsxQsVbAgd5oz9D8T8bKxb
         xGi711P07Fzx7MQcIkYghH3cePKxb1n/xCDQ66ZTzY878LXIGkX5LdXVb2DDua2gQQil
         cCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AVVFhj9Tg/lZH22og1Dqg9nlkd6DUn5RYOOV5kPf53Y=;
        fh=jLYNKNam0j642H0WOYgbswpjHaZhWAqSKZmodEFMDFw=;
        b=AfxtbswoSIyEppzJzN4V1hQO5Qjhu2rYbj9+ZOzPqEj1k98i0Na1VaMmJZyWGe4SkY
         zGwpZCb3WTiarWCvPa11ZVltBNdQvpaQPD87oRRcK9/4LhuS5tKGJOz6fglY416g6HaG
         ZQyu6Q7XdBMtfk8Y8IYEH2Y4YGa3pPou/w6YEtV8mDsz5ZxzVAL7jJQX9f86k4DnFZ7u
         VIVydKKbSR7CGnGSuyb85iqH00GeeEcJeLYVH44gacd4KkdtT3UTLpEdNcSC0HpN2y+T
         UrET50O/QEuWj7HuyJTgB3ZbgZ7zp55zqbLN0v+5hMWQG8iSb46iBBIaUsh1pXwxXXan
         nksA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785078233; x=1785683033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AVVFhj9Tg/lZH22og1Dqg9nlkd6DUn5RYOOV5kPf53Y=;
        b=Yz6Zdn7T20F8lM71MtP2/eb4IqGfaMqCihPxuXsRQstQiOYca0aIsQgU2rxZI8muTs
         hOVjiCEHANpHw/MV21TE+BDEfVECa8ZwOQmfdGNhqkJG3yoiR9JRHBlazpZy663yGpk4
         ucJa8Nk5tiiNl2QGD2VUPhdeD+uObANl378OMTVqMrOmaQTHqO1VpSyAfiw0eY72/M+t
         extIU06kmTztKJWB7IE/jGwlmJjFUP8YrwzE3fMpQLZPOQubTB99EP8U1nurbio1iQb4
         +x99cKeJCLpgkn6CGAQrsETiiATW+AMK2RFYg1UpGGgnCR6ViZqqrdnHp/IIk47BdSfr
         0u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785078233; x=1785683033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVVFhj9Tg/lZH22og1Dqg9nlkd6DUn5RYOOV5kPf53Y=;
        b=cX0FLLpksGbh7s1m4kJkgy3Dv+4i5gPjafmZWwYqKanklNkGNxgp8f2tKtRw9yvNpV
         yS7ZeKXTLOKfh21XXUSiGbrAQ6Fj9r1ITpMEjiketBRTk96VLbmbqfJ4MlOsRTINj/Jz
         sDyk99LUwicA1txbWa6St9BMDIAUsUvoaHFahL8u14MCpxv7/s1YtkEGY6evREMmQBeD
         YjqMbkP8yLyjwOh9YXRZ4V/quo/J4vt2aC7dCI1ShVW6Nz/4bmWiHa8N+TFyn5sYv7tj
         PQeivPjceOzWngXbkJqOUP3/MNcT7mEO1Eom7Ry8aaapWlU4os3/VOiWdAc9h+yKsqYV
         RNoA==
X-Forwarded-Encrypted: i=1; AHgh+Ro6bkPRM40MoholZDF8JC+A27ltxbCiIvKvxlNvv55p85l57Dm3ASs8TZHjr+WYbK8j+BUYAJW/@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhLRq/G7SyrjQ2CAvPrl2xrBEbp+gcRUdFREz0f0ZR3MYhscq
	Bta2muSnz0iaoI4AlfXLDE6ba3Oo3/FrTj1Y/HDsHw5FRpShOir2i4ipCzOQkAzcasVtwRvpRA9
	bAxrvtK44KnvDbNo2m8CgCTqVgo3AfaUIa9uj6XxB
X-Gm-Gg: AR+sD12ALPNbfoeM5QqYREBtJ+cTkzZV5S5HufJPTyjApJHg1bSG0GbvBn9mYGOoRhU
	LsUn9r7QsCABaG6AsMw50l/MxtoFD8iMI3mIETvLDuhRHF/aN8p4rsslKGP5z8jg8iB5Jcx14dY
	eqFOPxLxg2lc1R/Cpo7ZS/UpzqBF65zr4av7+BCCTPWo11cGoV2EVjHE8GvojKzerbDTpKs+4j1
	1qmOBUq5f9G1mT8+DQ3gD/hoy7vfbrmcCvx6iUSjkNfiZqbDTqw4YY5Nv6KzA==
X-Received: by 2002:a17:903:32c4:b0:2bf:9760:b94d with SMTP id
 d9443c01a7336-2cfde7ac5bfmr54965065ad.15.1785078233465; Sun, 26 Jul 2026
 08:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <20260725200958.4471-1-cel@kernel.org>
In-Reply-To: <20260725200958.4471-1-cel@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 26 Jul 2026 11:03:40 -0400
X-Gm-Features: AUfX_mwCAvSQk4-T9fyvhCQsQ9yZrf7lX28MCwcHk6mPXjDrRJUIBZdmEFtEkeY
Message-ID: <CAHC9VhSGn6UQ1__HtqjKWD1KgyMOhHYYKny5HnVuPAuvqZR9aw@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Chuck Lever <cel@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Anna Schumaker <anna@kernel.org>, 
	Achilles Gaikwad <achillesgaikwad@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Brauner <brauner@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 4:14=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> On Mon, Apr 28, 2025 at 03:50:19PM -0400, Stephen Smalley wrote:
> > Update the security_inode_listsecurity() interface to allow
> > use of the xattr_list_one() helper and update the hook
> > implementations.
>
> This commit wedges an NFSv4.2 client running fstests.
>
> A kdevops fstests run against nfsd-next hangs at generic/086.  The
> client stops making progress and never recovers:
>
>   watchdog: BUG: soft lockup - CPU#3 stuck for 250s! [086:60396]
>   Comm: 086 Tainted: G  D  L  7.2.0-rc4
>     __pv_queued_spin_lock_slowpath
>     _raw_spin_lock
>     nfs4_xattr_set_listcache [nfsv4]
>     nfs4_xattr_discard_cache [nfsv4]
>     nfs4_xattr_cache_scan [nfsv4]
>     do_shrink_slab
>     drop_caches_sysctl_handler
>
> The D taint says something died earlier.  It did: by the time the
> lockup fires, the client has already taken two dozen NULL pointer
> dereferences, all of them in the same place:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: _copy_from_pages+0x44/0xd0 [sunrpc]
>     nfs4_xattr_cache_list [nfsv4]
>     nfs4_listxattr [nfsv4]
>     vfs_listxattr
>     __x64_sys_listxattr
>
> The two stages are connected.  nfs4_listxattr() declares its
> remaining-size accumulator as an unsigned size_t.  On a size query,
> where listxattr(2) passes a NULL buffer and a length of zero,
> xattr_list_one() decrements that accumulator for the SELinux label
> without regard to the NULL buffer, so it wraps to a very large
> value.  nfs4_xattr_cache_list() then sees a NULL buffer paired with
> a buffer length large enough to pass its own bounds check, and
> copies into it.  The fault happens while the xattr listcache
> spinlock is held.  Task exit does not release spinlocks, so the
> lock is orphaned, and the next shrinker pass spins on it until the
> watchdog fires.
>
> The reproducer is a plain getfattr on a file on an NFSv4.2 mount
> with SELinux enforcing, which is what fstests generic/086 arrives
> at by way of a drop_caches write.  No fstests machinery is needed
> to see the oops.
>
> An audit of the listxattr path pointed here, so I built nfsd-next
> with this commit reverted and reran the full fstests nfs_v42
> section on the same pair of guests.  745 tests, no soft lockup, no
> oops, and generic/086 passes.  The two failures that remain,
> generic/033 and generic/258, are unrelated to xattrs.
>
> I am not proposing the revert as the fix.  Achilles Gaikwad has
> already posted a targeted patch for the accounting itself:
>
>   https://lore.kernel.org/linux-nfs/20260707152305.15324-1-achillesgaikwa=
d@gmail.com/
>
> Whether the right answer is that patch, a change to
> xattr_list_one() so it leaves the remaining size alone when the
> buffer is NULL, or hardening nfs4_xattr_cache_list() against a NULL
> buffer, is for the three of you to settle.  I am reporting the
> severity, because the accounting bug is not confined to a short
> size query: on a filesystem that caches xattrs behind a lock, it
> takes the whole machine down.
>
> I can test whatever you settle on against the same setup.

I reviewed Achilles's patch back in early July and it looked okay to
me (see my tag in my email in that thread from July 7th).  I had
figured that the NFS folks would have wanted to pull that via the NFS
tree since it only touches NFS code.  If they would prefer I send it
up to Linus via the LSM tree I can do that, but I would appreciate an
ACK and Tested-by from someone on the NFS side.

While I don't suspect it will be very interesting, I just started
building a test kernel with Achilles's patch that I'll run through the
normal selinux-testsuite automated testing.

--=20
paul-moore.com
