Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621F1FF5FF
	for <selinux@vger.kernel.org>; Mon, 21 Oct 2024 23:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553994; cv=none; b=JTuD58yYo1xZFYCoKAAQ98+KNSzFEzM0ZDh8tYdqJZEdl03eeqNuUULbX02WFSrskPAfd5WW9IP6WdO7F3CamfDHVbtccXRg9tqlpXKv2KWBJzI0C8JvVr+vHb/AscrMhKbwz4uoJ+l4fkKjjNekgIJWL6NlZ5EvN4VgSJDZlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553994; c=relaxed/simple;
	bh=q1QmvXn6GwPcneGjGwPv0xmS4RRUjRFacDa92Vsp7Kw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=uhG0M72FFK2TAIl+Ig8q4EZkUjBFA2GlEXAz2i05FvYKZ6vR8LFwdcsHeIHjqp1dIXJr1s7lZI/4BZD4iQp43iylXu3VCUqoDoNTrWctju4PMgrSK0LiPktIu1wVrSNDQtJq+DrMiJOCjBmO8im8t2GZrZiELcfHpkcK3Bq2StU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Kzfj3jpq; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Kzfj3jpq"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b155cca097so329455185a.1
        for <selinux@vger.kernel.org>; Mon, 21 Oct 2024 16:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729553990; x=1730158790; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7tHUckLE/MLiHUlkx0kAjj3yltxCb3kfPASiHLjhco=;
        b=Kzfj3jpq5Gs6Iyof3iA7rovfU2wLkd9Tl9jotb42aKAxDv1hEyEWdJFW3Yl2oB9wi4
         x+UYwFcHG5FTNw3OiuzdHqfFrDDlTTo9vkfe+S8/KQv2aAYcRkn9Ac+IULwekeeQhaYu
         VJQaLNUNKeDcAKFZFoIcHiHNd4ur112PjTRwcDC/+g+UXtBx5MK0x6IOtsmfONfbBxei
         4oqqOZ2g71XbJCpB1IH8cuBNPO+RGSMvCw8z0/V5b90L3YJ3/htlYjsS0P0+BNx+PjKU
         y+Rfo7VyX4lNQkeCqX0TcvolcjJWOtv7yrDRIdyHXCtek63tYyZPcPWkitTkHo2S/nUu
         zAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553990; x=1730158790;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X7tHUckLE/MLiHUlkx0kAjj3yltxCb3kfPASiHLjhco=;
        b=R0bLGG/dF8IT992guOW0/73SPiODPxLTjnAPYrudizPtoeci8EH3e4iuFOe4ND5qEA
         1CXbwtCcOV01PwndqtBMTviZX66Cji8S/jiiW5BW0XbiG5wcAzQRHy8dBHvzvwIeO7tQ
         cXeDyoH823Altcm7/Q1cKPBIezpmkPQbGw/cjL7kgEp4m9RflhrtWoxds3xoAHBveXH8
         ayhP20db9cmb9zhM9bf6LrB4chZhqSLjs1b3GYI36/JgoulxFpwtVgAh0SbhiDy68MLl
         Qca3nOH+GTRwdeML45NZYYvn1y1z44m1X2k87Qb1l+E4rYiBzJgG6LzLJ4hupMyTrzH9
         ZPyg==
X-Forwarded-Encrypted: i=1; AJvYcCUn2Vcex8DnZfsqP5e3iqVu/JjF8Mx4puadbouT3C+T6XN+SgxgL7Ku5bbMllprsB7id2blcnGs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8WKXudBYNWNsUuvR4ese8dIBDWooyHwurT2/osJ+CQ0PSD4q
	wA+PZmzPmGjPb94K4SThehz2Cu9ix804/BKj2tCOxA3+KSREXs3FYgLpGH1Yvw==
X-Google-Smtp-Source: AGHT+IHMuRe4JiqCCfpTVHmSm+FewrxBnBkGSC7Nzs4TDMNE+u2iWG54d8b/+ap0PMLoJ5C40bnP5Q==
X-Received: by 2002:a05:620a:1928:b0:7ac:e8bf:894a with SMTP id af79cd13be357-7b1755db38cmr237177885a.20.1729553990490;
        Mon, 21 Oct 2024 16:39:50 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1659c88f1sm226044385a.17.2024.10.21.16.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 16:39:50 -0700 (PDT)
Date: Mon, 21 Oct 2024 19:39:49 -0400
Message-ID: <b94aa34a25a19ea729faa1c8240ebf5b@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241021_1626/pstg-lib:20241021_1624/pstg-pwork:20241021_1626
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 4/6] LSM: lsm_context in security_dentry_init_security
References: <20241014151450.73674-5-casey@schaufler-ca.com>
In-Reply-To: <20241014151450.73674-5-casey@schaufler-ca.com>

On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the (secctx,seclen) pointer pair with a single lsm_context
> pointer to allow return of the LSM identifier along with the context
> and context length. This allows security_release_secctx() to know how
> to release the context. Callers have been modified to use or save the
> returned data from the new structure.
> 
> Special care is taken in the NFS code, which uses the same data structure
> for its own copied labels as it does for the data which comes from
> security_dentry_init_security().  In the case of copied labels the data
> has to be freed, not released.
> 
> The scaffolding funtion lsmcontext_init() is no longer needed and is
> removed.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> ---
>  fs/ceph/super.h               |  3 +--
>  fs/ceph/xattr.c               | 16 ++++++----------
>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>  fs/nfs/dir.c                  |  2 +-
>  fs/nfs/inode.c                | 17 ++++++++++-------
>  fs/nfs/internal.h             |  8 +++++---
>  fs/nfs/nfs4proc.c             | 22 +++++++++-------------
>  fs/nfs/nfs4xdr.c              | 22 ++++++++++++----------
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/nfs4.h          |  8 ++++----
>  include/linux/nfs_fs.h        |  2 +-
>  include/linux/security.h      | 26 +++-----------------------
>  security/security.c           |  9 ++++-----
>  security/selinux/hooks.c      |  9 +++++----
>  14 files changed, 80 insertions(+), 101 deletions(-)

...

> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 039898d70954..47652d217d05 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -457,7 +457,7 @@ static inline void nfs4_label_free(struct nfs4_label *label)
>  {
>  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
>  	if (label) {
> -		kfree(label->label);
> +		kfree(label->lsmctx.context);

Shouldn't this be a call to security_release_secctx() instead of a raw
kfree()?

>  		kfree(label);
>  	}
>  #endif

--
paul-moore.com
