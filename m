Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686762;
	b=j0HFTX2/y5nLL9dHqxtw2sACvdTUnsevC4lrUcY0MEkcQoswiAbh7/BdzS1bWXnSVh60
	 aPUGpksdDY53Zw7ZRK7h2xhzugAb0s8o9bhJz4j5lj9heLQmw1LRxAEjDFWgkWsK6CHhB
	 86a9UYgFo/OAlc4LDeDfsyN0OlupvjBATxHTgiqa4l5EMNBujsYzBI40Rxa8iErk6xxoU
	 vyutijcif8aYi3azyAcDv+thIwkNPXwIHZZqAQs4CmZOLhTOhz8tazHrz48/0MNSnNeqM
	 vKOI38S16JhXeS/U28nhu0YWI/mSHSBgWxvDCyyqcesaVIp1Orm+mDICyv651uoJ5Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
	b=kjGZInKufoMCL52lHZoxfQlqsj6gEjlOGszr4hujaSTZtpXLbsWtr+ny823aKvQuUb39
	 gA8HaQPOJgEgGlc/6ZyrJllKa6Q8rvncI/0T+quc47OWyP6/oTJQWl/3vAk70irxtFbXZ
	 KpSdO0mpoSPslucp58br9cxmsD7Hhx8XgLlJsOAOpQ4LSuUJDqkN71zUiZMISRzIHbCAu
	 EHxxsTiWxVOHLjjAaHOQYZe4GSgK/930+pzitgKZnBbn3gYqeYsHxfCiql21x6Gn+Pi6a
	 WVXZNSg8J18uFF8BVTR4MUvqP652Fs1+vg1IZQEopgFxo+W9qyfrwA12GLAYOFFK9NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA060A3807
	for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 20:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8CA060A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso2481002a91.2
        for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686761; x=1795291561; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=WyNKKpANsG5sdrHWGAt+Y38DvSIGt+WnCUyNYCZoBM4YbSq3wCVAHI95jQ8BFTGgLn
         +vM7af/q0i5zrzjZXXnriwzXN4L/RbeBg/iztvO0eyeIXYNiQp/OYlS5LD9yZqr2gKgm
         1I+5A88e/cV4J0nLZfgp0f7sQwj9jY0Q4quBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686761; x=1795291561;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=K5tT119Jc0xCyJcNskkAS5OmPh/l0cb0XeolXTgC2nMztDbd/mndO7HZ+0OVU7srt7
         CcO3QqWMJ/R4NIYgL3tCPnO8SfL8q0qR1pXpsNT+7SImG70fPXi1myxuPEJJNbHlNTYy
         x1rEmLQfhBchKINt1x4/qXY0xpTGXY/Kv8+VqJeO9eJKWKhWgS9MMQNmmJWzE5/F8jse
         M5rlb64xA2glgkOkcNgZcpfqc/SaikFscuQERbxe36iL81E3iAhNCZu8FZo0pM6tyUV2
         ZT3t0o8mjLjPwCOwo0j9dTcNh+QukWRR52pT9GZZQORSx2Syf9GqC8i3GM62zCR2UShA
         qRCw==
X-Forwarded-Encrypted: i=1; AL+hErEI5cWsrtV9u7GGUNWd228NvTjlMlcCG932URRuhX7/9/tN5YE4ByITYGYxHiWGv9nL4kMrB08C@vger.kernel.org
X-Gm-Message-State: APuU4Z/kdYYL9MZwgJ4hK6y24SzFF/a5dLMmcVsP3QsaBlRa63baK5sB
	MQax8ZiiuHfeOy7Xj/zZep/wSs1zWTBvIS/iGunGhrpEmYlPMRfRiAF5goNEmovLiWM=
X-Gm-Gg: AYBFou1GAMAEka8kqqJLvAbFd9QYFr10NZZfItQ2yRb6XjyLGU5lyIczcdY1rEcy9F3
	dFIQp3JcgWawRJGF1YaYms/Agkca3tur3DswDehPeQWE3Uf/qm+Ui45p3o5vp2GDHq7JQc9TQRr
	C1Y133RHJ/n8372E4gPGdcO7s0Ks9ZYV1DmuenNXiPPZ3rXjfJr2/oPDkg4Wt/yIr/XhMAvh8hk
	vWdLrXV+cI41zGNzoEzlgX6lPVXJeKIlkFodN5irZJ+fBNnm0yPqNfxE3qJB8HtFPYIgOtMBbBx
	wCDGO6qlKY3uobji1DCBwmTfkE9Cwj4u11FDc3vOzvp+ZnjDhzLtFcxzliyHLnfYIfMGbJzpgr2
	dhNAUe1JY8nMb56GP+sDrP0c6+qn3vtKwRG+O44No96zl1Ki5Z3+eDTzyQ2LgZwVQCt09eXWCng
	wQlBV47Pa9t7oUFMFNUy7ERQmj2ukG0b89aO4sxM0o+sh2sBS9fRwwjnl8QmuqX3B9xaFkkRCYB
	enBvNBf04kCNQqPeIkBTpK9XbCF4zQVF3eXAs6fecry0zo/eqYG0oituFVYSUZ7uKPyLJ8oHtny
	HZPKjr9dIhj2y9KW4m0xKOT4zIiQBSC8L8NtIVNgjwCi8zhM0xbOs5b9xu1GtG9vsB6z9Ruo9sI
	G5KyuZcQKH+EtrRRWnl0fHGMDFbt+78+gIBTkiqL2CI+mSpubjUsv1FHtr0XtUtdOLov4XCItzi
	2mJGNnLWc7ZUpFYeb3sm68MKKqcYqEtom0JNvspHjPTt9CBpZ2dXjbBYNs
X-Received: by 2002:a17:90b:2584:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b1b0ba61famr5629200a91.33.1794686761104;
        Sat, 14 Nov 2026 12:06:01 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm5258887a91.0.2026.11.14.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:06:00 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:57 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
In-Reply-To: <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>+	/* Look through stacking filesystems at the inode with the data. */
>+	if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEUDO)
>+		return -EINVAL;

This looks good in general, but what the bots said about O_PATH files
here is real. With FMODE_PATH this is reached for a file that was never
opened, so on overlayfs nothing has been through ovl_open() to look up
the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
itself, and when that fails it hits the WARN(1) at its end and returns
the overlayfs dentry, so the check passes as well.

Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
it's easy to trigger with that. From a quick test with a metacopy file
whose redirect into a data-only layer points at nothing, registering an
O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives

     ovl_d_real(/f, 0): real dentry not found
     WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
     [...]
      file_check_backing+0x308/0x5e0
      fuse_backing_new+0x219/0x4a0
      fuse_backing_open+0xe8/0x390
      fuse_dev_ioctl+0x53a/0x7d0

and the ioctl still succeeds. A normal open of that file fails with
ENOENT, so nothing could have used it as a backing file anyway, but with
panic_on_warn this is now a panic.

Maybe ovl_d_real() should just stop warning when the lookup fails, now
that it has a caller that isn't trace_uprobe? The check would still pass
for an O_PATH file whose lowerdata couldn't be looked up at that point,
though.

Thanks!

Chris
