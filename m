Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305681;
	b=YDSC5BdLctLF+UhBTYnQjnyeXW42D5wNOvKjWarHaJO2fLNOO7Cd3flcWFRD2M5yHfjA
	 2Ol2pyTgA03Ila7pwur5+nbj6wHdiKGioVRIVhJWZEWW+FqtXdxP59sCDaEK53imouXl+
	 UTYlYe8zEaLft0zhgwrLhuG5WxG5WPhm+9y1i3xWDZt683A/9kU2yajOWBg2Vxy3anZR6
	 DMv8/qeWw208wpr5dKapZu1PG7x6Hu6tLSnkK9/tiUtOQ0khfD0BAfvxGBD/rUm3lmd3+
	 abrb8oY9avMr/9HHCRuOi3ORR2hOGJE4d0M+xeinDZK5qMEDuMorEUt5QN+YBvtT0JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
	b=hsUd1S+HS+K76rZjrXxyIcDe6m4LHAAH3kNDGx/VFQhRpZgX6jLLSFCKmI/+dxmq1TJ1
	 exp9KJwDgZjcMKe6dOnzK3c/RzGZLhGAFGy2JHDqarOM6rgLjNRwFlO/ooB373eJpmdEU
	 4Ikuy5AbHWGEzqzyhOfpEQCOcuQynq8+DGvc14BG59g2NBMQlq9Q7taouVZ2/EPJu53oU
	 bMYYm6wasFZbFDQkixRm+hE89rRwDmdRo4CvCUM+sY69xm3Ror9myZvNvBroBb+1khxT7
	 WOoEnOJdNHOIUHxxCsf43gAAPRmIyUjVfOV9hH0e23NrQBkS8uTIHQDvbl24QPD3ByA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrlQYRb4;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899C9606AA40
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 10:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 899C9606AA40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrlQYRb4
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c504bfd7393so80979366b.0
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794305678; x=1794910478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=DrlQYRb4d+FJBQLFk4gip1vdMb9pZcbFm0QRoW/O9nsnnIGk5B/dcI7komCKzkv/uM
         Uz0TTkL3EB0XOLA2v0TTxwYvqDOvah1wiwbB4uUsiRRXfj1OcdvtnHWnMQS6yfKTNN5Y
         2S+sbZpFj/oUd6OIfB1K+t4luOgmpm8MRta8dNUBz+XdEb16ui6jztHrAySR2QYDDBtW
         UcH7ksMk3kyTCuhLg24n4RSbgP43bR1MD63YWBBHbNHKba+s6Adtgd3r0iiTavTYgvkx
         vCBmyxhjfzRfUpjuhY0K7x1CK/3uUIf/0FzbTbFW5bHu/k5G1xko0Cr6O3LrrObY61iA
         y+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794305678; x=1794910478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=yLIIE0JQtTKQdl9VBOBh6RJ7Guncs/jTfWgFwItqbTkkZJU/Js80p4vJ8xtnpvNDp9
         +7hNBzf+Dd5JxcoZLC7X+UYL51wOL3dxP26JmA7q/EiGTQmEDaoIzzVqYvTk01+HT+Xz
         t8rwpCgSpsV8zvpRFYoorZfs2JOXMfK48JUbnlYTL2ZleXMBAF20EWtTyB3ox5xYEZBb
         Tu80GagUzKC2Wid3mIARQ02+qBGdGzL2z8RGRNitF8TDawd9afS94BFqkQQ6IBrql8+k
         uKmIOgnYL8EzT0F0DZNJUaecTM3mvVS0AKWdWdXk4KyKgAB5BGCfJe/XaXjoAA36Cn8F
         zbMA==
X-Forwarded-Encrypted: i=1; AL+hErGQ7Xyr6JVqx4dTy8LvheTExx1dfTEis3UBtCcDKUyxwM7ubH3YBVWFySX8hwf3dn4rWZpJjTTY@vger.kernel.org
X-Gm-Message-State: APuU4Z/9wFlZkzCkC4mSLXa78OQUvV9RQd/rWQH3BatrLmu6HJCics/u
	XDPsiqqcuwsW+aeGsqaaUP1LSWR08nqGo9trNVtgy8atHS+/iA6/krCs
X-Gm-Gg: AYBFou0Lw88sxRDL7A2Ozf5gEwGTTPLsl0x0MaQl/8hG3Ex5vkc2C1OFnaTYvN7Rz2F
	pC/kOgOU5zSTq97Gv9ZNk56Jz9MZcM1hRhZx5cyhH/lJhnf2X+8f8fJQnekpBYKnF+9JdEbcxJA
	v8KeQjUDs7059LV8BwwyEcClkSOg2MBiPpgMQ3G1vzhSSGqgPjX/T3ziOON70XOGCa9wd6WAj3a
	j7ebmkT8Ui7CC4ylX47v2VXusemLHyOb67Cv0UxLgoDZwXbw3o0dB6zKTrXL7Ed06e6dFbkG49R
	Why+IznSmYTbogpC9QV6qb0kKEdEiDL3EQOL4t/3fvDU6Ip4TLIhxmUfNB9u71WrIDrmb+ovBsb
	Ga2SBn9Io+IeU4Ubzr5QDKbOsuF0cciJR30xpiTuXiWOqqibV9H84ReC7jAOgdUsbo4Y3kj9XYV
	MC2+5BDpciRiyyE7e14K5B2LmqjDgmD1ild5DiNPhelKdUpZu76f3xCauT6Jnz8qEHLeFMWoJ0r
	WYBC4I2dee6kRfCeiyLAKTJXDWuHtq+9D//yO6w+wwxYBMTzG8H/JwL3/5XdkV3PK/ukEK7Q5UR
	Memp4bFNF5OmTc1NWMxomEQkTFGLBLzxGrwAbnbKkN5je8HrZyNBfAvZGVH+kMCHIFJXHolrdFz
	rTe9ikG5CFJnn
X-Received: by 2002:a17:907:944d:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c504963ce05mr189793966b.44.1794305677695;
        Tue, 10 Nov 2026 02:14:37 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593eacsm90433466b.36.2026.11.10.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:14:36 -0800 (PST)
Date: Tue, 10 Nov 2026 11:14:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avLui6Mpf8GbKbtc@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>

On Tue, Nov 10, 2026 at 10:14:54AM +0100, Christian Brauner wrote:
> The fuse server can register any regular file as a backing file. procfs
> and binfmt_misc files are already refused by the stacking depth check as
> both set s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH. sysfs and the
> other pseudo filesystems aren't. Reads and writes of the fuse file would
> then be done on the pseudo file with the fuse server's credentials.
> Refuse files on pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/fuse/backing.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 8c21a8a74efb..4e4fb810ddaa 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -147,6 +147,9 @@ static int fuse_backing_open_file(struct fuse_conn *fc, struct fuse_backing *fb,
>  		if (inode->i_sb->s_stack_depth >= fc->max_stack_depth)
>  			return -ELOOP;
>  
> +		if (file_is_pseudo(file))
> +			return -EINVAL;
> +
>  		fb->type = FUSE_BACKING_PATH;
>  		fb->path = file->f_path;
>  		path_get(&fb->path);
> 
> -- 
> 2.53.0
> 

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

