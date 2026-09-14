Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A4633936F
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789420674; cv=pass; b=pdyUGCzwRLIOOTSCenexOXjsnQMwMAlwc9S04C2Ye20yqX/B9eHPjFmHawpRNv+slaYbLCbiVff+aRGbywgN6Mf9moM+yS6Q6hCpoZeAdE8bEuF3mtEb1/s0kFILjSAAawGF0Uy075S2cKEWqo0c7PURhdmL7U0ccD4rxOUyVnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789420674; c=relaxed/simple;
	bh=+FCHW/GBcwXs5DdDpurcPXompfdIhdbkQIV9mZ6twmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIOyiS7RrmdRpken4vOtETsT17LZi9wpDmr9cLPBmGLRb+TIRHVb52CUMVaSVyCnFSd1MohtnEx+i6XGQakfoQkv3ce1XGk3DErLoi3Cxsj1wcU6YhcDZxaQ5YATmpBcxVBnvawsfLaLFuJvy1WAIN16fNXjsE+2+hZQIEBdz4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F+NnC8DC; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F+NnC8DC"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db18fe459dso12760395ad.3
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 14:17:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789420672; cv=none;
        d=google.com; s=arc-20260327;
        b=byXy5b3ZWmJ1b72CwpgjGJREWKXg7Bl7pNAoy1OCeh8tLkZSCWYXWzNRWNCD8UC2Hy
         QoC4SR/UbapBdm0mqf0vGlDoi6opYEBOzZkcOwalmMtF2Do6PQut7Fsu9JaMBysELSRr
         ucC7iFwWuRxqwd7OZte8UUCNdsv0PVFnsfNEoPKhX/BoCeS0ReNYTistw4AbDuOQSQJa
         znXFFqbU22Wg6wgEF9oqpYsvNIlxZuhUSboHT72CsXkoCVZn4nP9VtmdP40gjjeQtxUU
         YEc208Ghy1YPBThQ4k/wVTFizgJApIHdxoj5sGZ7i2rZtarLJ+D/emT5RwxKgivUSoRj
         acEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=buWBOJymswd9WOrNmDO/TIK6tbSPth7vWhXrMk4QpPI=;
        fh=muAA4xKdA59SzN9mnfVhhvZ2aFRvTwzkN0pLxtmQvzU=;
        b=Nvv7m29plouizzcyQuiKQnrR37AO31gmCHva3/UtC59DM/9ZzGxEvHzOhvLOfpGpDA
         RxsE1dbrabn6JVCAMGu/FnJRRL+AGqOzjbkotJ+tiyes5i4lwHbMfKwKq/ZJqMbPlZtO
         6i6+lD9veF7AERdjt3Dkc+BsovNa3WAWGFWLflNhJrBYkSvEDT8jD0f1XV2pCCVfYTms
         HiMlzQjW8ET/cqyIb0B6OB0UwF2gFZogo1uIo/3lbgLsgD7J477We7iYU7rFxIONPLbk
         EZT7Az+H8q7hn3Fr6sOifXwhZb9H0LTRVxTKETBLnHP87yWlDIvRPWigZ2OLqsFchBTl
         hUTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789420672; x=1790025472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=buWBOJymswd9WOrNmDO/TIK6tbSPth7vWhXrMk4QpPI=;
        b=F+NnC8DCSv/bCZ2yumuwBjSQVIB4j9Npn72sZa/2svnkisAAGOdYb75ZF/3qzoyYCC
         XHmhsXKPfP9M45+04NXDZPqvTlak8c8hpnHNb3ASkM3SHSZua2WhkT7G+OzlgESN7o2B
         1cfj1VEtnVzpWvLG271v7Bu7eP4TpOSRWuI9kQaYbBobr9QAeiMB3k+UP++3iBix1Fkh
         ee9g/+zhkG3azQUDAKcMN3yB7ijb1XiN/zCrvqLRWgaTZm6uFvYpqikCrdfJ+3qT0179
         4xu64wYqid22rH5HVKaGVJu25y41iPzMLnGu0XsBJbbxFsaElfFhBIYzs2IoBnnLe8Lh
         msww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789420672; x=1790025472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=buWBOJymswd9WOrNmDO/TIK6tbSPth7vWhXrMk4QpPI=;
        b=cCH8/l9Tt/HlGfI0J/AIaQ/aX0ZNkAGhu1jXCZKZd1tH1BoUP6j1CwW41/cmTN2RKc
         DXxnBjRZxxsoAeQgwNX+QnBN0dQTP/qpEe8lOKIcJGgxcEGwJ+wmjLXCGxsVI3K8dhVM
         igcAXDrNtLHjFLtr3vik3XksEpZne4ZWqS9h2++dmBCff9SBvZsxhHFARREB1smC1O/X
         c9Rub0q/ZqHtTUBchNzicjWGKBNzPk9vMupkMp7GDhZWIz3d7XhKTyh0HuCtS57hDUcf
         WcDe3UpVe8oa0norNWWamdpRi3ljf3dhtnl8AS/nFjG0allSukodRZwKlBodbh+0u2oC
         vGvg==
X-Gm-Message-State: AFuF++lmcn2SCjE9+Fsfm1dK6jcU1T+kGALXRQZseuYxZDrBCFJAYxkG
	OtrQztQUxy3gPz/pEc0J+csGiXHnvTZAh70B3xhBI9gYHZeixrfHzJRsJ3YNnUmvvVIQkp0T3yb
	tx/Fsze/SGpeV3nkR5M4m1el6T5xSbPTUCMOfqYNkkwV8QfXWJ0UHnh0k
X-Gm-Gg: AYBFou3h+yXhUSAaWYMcVehgSfChPpm/YN50Z1q/aNRHArrO6NlXrXSXiIZ3uQ1xBl2
	LSyw/L9es9Mq7viphInYivCq+s986OKnts15IvrQVZp1EZMzG3+s08DL2pdETNuVZanPio27T2F
	TK9OM9RvzQvCG4nt5fCXSGS6pFc9aES041dTfV8+gNKS7Z3cZbq/kYs/RZw/SWsZvk5uRs9PK8p
	1T2+Rkp4EZMGX3T6SK6gxZn8zFBmAfaFl5jFxTtmxC3/sm9eXlQGMeTDQuxV/GPVpQqLbj4e3o+
	HGnjIh3wSTFgqHzYN6lSFue5MOSSqO1w44v3x/EfofsknDJzajVKwihK9LkVG50nRoIKbu4O0/x
	cftv3A7aul8Jy5XL/pdK35Q==
X-Received: by 2002:a17:903:19e8:b0:2d9:32ee:7b83 with SMTP id
 d9443c01a7336-2dd6c5f4ed7mr86854005ad.8.1789420671750; Mon, 14 Sep 2026
 14:17:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911163734.22981-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260911163734.22981-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Sep 2026 17:17:39 -0400
X-Gm-Features: AcwNN1W1UJxR8ESm2eaui4XRUxITVbbNIYFNbevb2tR4Y3-WbmqS95-vW0-JrJI
Message-ID: <CAHC9VhS-TiBkOZWR7xgCrPnpxozjzM+y5vpgbPU9=R_C3Ta2WQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: mark status and policy inodes as immutable,
 drop status mmap write checks
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnacek@gmail.com, ljs@kernel.org, 
	jannh@google.com, jack@suse.cz, cgzones@googlemail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 12:38=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The selinuxfs "status" and "policy" files are read-only interfaces
> that are also mmap'd by userspace. They are created 0444 by
> simple_fill_super() but a CAP_DAC_OVERRIDE caller can still open them
> O_WRONLY/O_RDWR, open(O_RDONLY|O_TRUNC) them, or truncate(2) them.
>
> Mark both inodes S_IMMUTABLE at fill_super time. inode_permission()
> tests IS_IMMUTABLE before the DAC / capability checks, so all of the
> above are rejected at the VFS layer without ever reaching the file
> operations. Since a writable file can no longer exist, do_mmap() clear
> VM_MAYWRITE for MAP_SHARED mappings on its own, and the
> sel_mmap_handle_status() write/mprotect guards are dead; drop them.
> MAP_PRIVATE writable mappings become permitted (they were previously
> -EPERM) and CoW harmlessly to a private page, matching how
> sel_mmap_policy() has always treated the private case.
>
> The sel_mmap_policy() VM_SHARED guard becomes redundant for the same
> reason; leave dropping it to the pending "selinux: reject writable
> opens of policy file, drop mmap shared/write check" patch so that the
> patches do not conflict.
>
> Link: https://lore.kernel.org/selinux/aqPUqU3eZeFrykj3@gremlin/
> cc: ljs@kernel.org
> cc: jannh@google.com
> cc: jack@suse.cz
> cc: cgzones@googlemail.com
> cc: brauner@kernel.org
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v3 implements Jan's suggestion to mark the inodes immutable rather than
> implementing open-time checks.
>
>  security/selinux/selinuxfs.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

I'm mildly concerned about marking these files as immutable when
neither of them is actually immutable.  Yes, userspace shouldn't be
able to write to either, but the contents of these files *do* change.
While it doesn't look S_IMMUTABLE should currently pose any real
problems, I do worry about the future and an innocent looking VFS
change causing problems with one of these files because it was assumed
the contents of a S_IMMUTABLE file wouldn't change.

Unless someone can promise me that would never happen, I think I would
prefer the !FMODE_WRITE approach taken in v2.

--=20
paul-moore.com
