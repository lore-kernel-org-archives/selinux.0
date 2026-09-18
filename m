Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4FA50B42B
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.226.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746403; cv=pass; b=I/dTMXSxX+ZcNqf5YmjdKxo7xSH4S8toqTxtqKSbFTQzKNnheJB9AOdfhH1Vy+6eeMLOLFR4glvwvjUbxR+uNaFmyZP8O5dLm3CN70odVykCJ8SfkfLsTU8AGEQe30uHOXsLCtDClQEQpsLU8icTlGs2Qfqwu0lLIrDPH9W/kXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746403; c=relaxed/simple;
	bh=kg7m9VV/b1ERk+xG+fM4c0s/TijCxGE3YxwleZCwZ4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/eGhnLpCjPIvfFR6IXc2bik0M8YAAm+HqHYHM8RM9Obuwwpsz2yXj5Qw8mULjavOot34LYOQAKLLLcFBKX/wsSGQMYBpgy77QyQuO0saE/wZvdZiRq5W5BwEoVQUaW4IKtJJGCoXWn7VEyBH+t/wrDPK08jIruCph1PPWrOwUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjL2uGo0; arc=pass smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjL2uGo0"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c62dde2so228473241.2
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 08:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789746400; cv=none;
        d=google.com; s=arc-20260327;
        b=bMnI5dE9TiSiMBCVozdlVm9OMBw9j12ZqX8AfCIMYlzX9Y8JwIXv6uVposYXqkpZTd
         +IbFhJ6Bq3Zn/cYqGNARiabpvxdv5BQ7ENXsbKpOXtSMdmUzSsIhkGmNoXZ/vTwJfnvc
         axBwgUf4KWWIMZJUKjtOfB4vjE27IkdcSN7/MrD4X5O8picwzvx3TCpLAqlI82bMrjAH
         euXbP6/EW2gEakGnZ971xzn5rYJFlznB5SJlI8vX1y4CNDuyv93xmeKWJw3LCYsCFDUj
         TbWD+eA5itMQx+rEO0SmHZgxOthV/Lga9foOo5qExOW7nHzq9dpGCOiwQxv975s2KOVD
         Iwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IV3WRWf05XlULSlr+CBpdtvH1Ur6AjfIUkCTwtgGPKo=;
        fh=ljUYtV4DzuF0ps1+6FWelP9jOHsXGOCfPvwEijZReO0=;
        b=NPuvXz+C1nr6DGJBBefBg623PXdAIe6Q7XfyCsEZhabkWTIVaUP4J85PrUj2qCWJD4
         LG6NOhtDytJ8wDnyMocYwhOIDfjtf/dRHOxEbaMGB6xZ/OeLZQ8k6llQfVQBcf6BLVhV
         jQzynD6r5IS0wW0nsOcHdbHKC/AgKCKnWAQISvuTS5irV7bhV1ybpni6FAwYho/e+cSq
         mwQVQPEuTG/uJSMeHieG5sSC0pTi5JwmL5kugKLrHih0ghyKc//rK2zho3qu8fYd9ha2
         jtknG4f8OhDEm5L3dKfTL25bNDrNt1AVGRwe9i2eTUJCopRIVgtY4h6a2UYSERDTTK6j
         4Ybw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789746400; x=1790351200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IV3WRWf05XlULSlr+CBpdtvH1Ur6AjfIUkCTwtgGPKo=;
        b=AjL2uGo0wY54OJDiaO1mKssCRvpHnx30dyydOokHp+LJodQMN9IuDISJdNnDDG5viL
         gEJgJ+kLq/zyR4DF9ihv9qmq5Cd5vsK46BHFgDL+m4juMJdORnrc+xwd4ViGuLkib/df
         AuwQPnAp9EjCI2CRhUfGG3RblM18QymrcLPGMVd6ImGbbDM0CYKNns6ChNbZyugRD4Ld
         W+foD0KTesoWQiCdFL4EcRpkrYja4/HNqccw2Kt2zyLYU/Erv7Q3J8raqaeDLBMwdPIV
         oF7OqD2BfJdPvfcecZzpngs8g4V+MA+Yhv+9H0eMlHK/FvPDd/IGkkDdD4vflRRadznk
         nZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789746400; x=1790351200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IV3WRWf05XlULSlr+CBpdtvH1Ur6AjfIUkCTwtgGPKo=;
        b=lVw/cTXECdNmaXoYSvGWRZOw06RMhWu8RtNVwYnkDxjsyis1DzkY3V+3a/y8ZMzXy3
         DrcQxIU5IdrzNg3QBPP0Ci8utXlaJljDxs/dWmKAywHHbD6YzhWCIyXDc1aQKSnXGMFc
         nIztqD/P5zL1z2RVVgqhX5RQu5OVsnmS8HIDF79cekxoaJtNuSioEO6VPAGj4YizAO0o
         tnzQ1l40Nl2OIu7RXAfzfxJpGFTqarHDRp/GJve2DsPRiyArxWz0hSjwos89i6qpZu39
         rKaxhe6XV6G6CmM3tVcQjdH2J8Pyqn9vSiWsfl45A23208ST90kctINDvehzuIB8mcYh
         lm9Q==
X-Gm-Message-State: AFuF++ke8tcbzJyjwMHwPxJ/CAQ2HJTKLGb7lWP1zzW9bVtcqG3J4+u8
	Z8KcOCKMbZxrtvbeWD1cLERIo0P2WV51IASFj0fGO4ZXu2fRl6gWRZ2PLxYWISc6YYzBNYYwha6
	VQWY+IU+7PQoQG88XMQVRF1tGhhtYg4Q=
X-Gm-Gg: AYBFou1ogqTCNroyda9PvGp0NRDvN3creLXdsasANswVIGxYppOrGvEyx1oG+VUYmr2
	NRaLXyFbeU4w+EIM47775ls6UIMvkZphkLXu1fokXVYYzOT+0Z5xhJ07NAL/IHhGt76LPQTBC29
	J4x9MGrKWWbeo9NIgebkFBuGuWOZIaNtigxXAC1Imyn1Vs6UXY6BO2wBAmzpQZ6otQoxvf8nLCB
	gXe22GoFOT/5aVQ5gWAVQD78QqD8PKP9d4OrY3TnGgYXvkRoKZPMuThT46UuVAjY9W7XSe6OXan
	ED5XgAuB21QkykeNNMMz2jGDXvC3ZzuGK28usKCC97vTKshYAW6Ge6dmW2e99dx3dw==
X-Received: by 2002:a05:6102:54a4:b0:797:fcf6:822 with SMTP id
 ada2fe7eead31-7a55d28725emr1310530137.13.1789746399971; Fri, 18 Sep 2026
 08:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ab19069-a348-42d0-89c3-3387b5d38c30@debian.org>
In-Reply-To: <6ab19069-a348-42d0-89c3-3387b5d38c30@debian.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 18 Sep 2026 11:46:28 -0400
X-Gm-Features: AcwNN1X951HGzAEln1xGhjMPw8ueox8rJr3YRqPogg_YzcoJtI93eZMJ-2BaLYk
Message-ID: <CAEjxPJ7_=ky-iy-6UHPS-Mh7GKc=BA-zyA4p96uKM3HEFEc=sg@mail.gmail.com>
Subject: Re: selinux_kernfs_init_security() ignores genfscon-resolved parent
 label, breaks type_transition on cgroup2/sysfs
To: Laurent Bigonville <bigon@debian.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: SElinux list <selinux@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 6:44=E2=80=AFAM Laurent Bigonville <bigon@debian.or=
g> wrote:
>
> Hello,
>
> The other day I tried to troubleshoot (assisted with AI) why
> "memory.pressure" files in the cgroup2 hierarchy were never getting
> labeled memory_pressure_t, despite refpolicy defining:
>
>    type_transition init_t cgroup_t:file memory_pressure_t "memory.pressur=
e";
>
> My understanding: selinux_kernfs_init_security() decides whether to
> compute a transition for a new child by checking kernfs_xattr_get() on
> the parent =E2=80=94 kernfs's own private, per-node xattr store =E2=80=94=
 and bails out
> immediately if that returns -ENODATA. But /sys/fs/cgroup (and everything
> under it) is still labeled cgroup_t for every other SELinux purpose,
> including plain getxattr()/getfilecon() =E2=80=94 that value comes from a
> genfscon rule, resolved live, with no real stored xattr ever involved.
> So the parent "has a label" as far as policy and every other check is
> concerned, but not as far as this one specific kernel check is
> concerned, and the type_transition never fires as a result.
>
> A simple way to confirm: force a real xattr to get persisted (e.g. chcon
> system_u:object_r:cgroup_t:s0 /sys/fs/cgroup/system.slice/) and then
> restart a service =E2=80=94 its memory.pressure then correctly shows up a=
s
> memory_pressure_t.
>
> Tested on kernel 7.1.13 (Debian), refpolicy main branch,
> cgroup_seclabel/genfs_seclabel_wildcard policy caps active.
>
> Has anyone got a view on whether this is intentional, and whether it'd
> make sense for that check to fall back to a genfscon-resolved SID when
> there's no stored xattr on the parent?

Added Ondrej to the cc as the originator of this hook, first
introduced by commit ec882da5cda9 "selinux: implement the
kernfs_init_security hook", which says "The hook applies the same
logic as selinux_determine_inode_label(), with the exception of the
super_block handling, which will be enforced on the actual inodes
later by other hooks."

I think this mixed model of some files labeled by genfscon, others
explicit, directory hasn't been explicitly set wasn't possible or
considered at the time. If we were to change it, we'd need to check
for regressions not only on cgroup but all kernfs-based filesystems.
