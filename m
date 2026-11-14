Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686760;
	b=uEmkR7ymOM7Dn7+rqVfexzVzo9oHRbhLeyRNwXza72oFzlNiKf6QksiWVWBGpTm3xQg+
	 UnozxnE6t1NI/UFe8jxenvdLy71Up26zwCXR/2lola/1GTysuzL52dEQQON9ucZ/VKBPm
	 dQ/BzIvQghru2AX+kpQKGDE0qQ5x6eN2EG6ljQtw2oLnGxcYLghgJ4sEO42A1mggD6Zim
	 BvBvOusxPlj1VNHNPlzNrKNtiLxwLN/pS3diSbJiDbMVYce/Y8jjWsUF1zIxCipU1gr0b
	 T4NgGBFeAwLN2CHtV9Ywd8eRvL2s5quZryp1fh/optpY6exllXiXTJnKew/Hm6AgKvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
	b=0gjPrs/qqctcYviaBnbCZTkE8cSVm2QRxTuW2wmSD+YxT2pI7epczcUOteTItUFN5xh1
	 dkBqZVD7UVBfYgGQzLQkj/V2CfI11vLAxGMWDvNPuiOi2dCMwS/CBc3+2i07wITwglJhc
	 d1jv+PKdx1o2XKrKJTbm0jNKjETQLrAz6+EgjV/8tS7VdxZjAf3PoqDFHoyWXEMh9ln6j
	 NMizvObn1+eivFUvPFJzRxi1ynsZQIl/hS4yVwiVQW7KHk8U8DWfPnx5NQTQp7D27pN23
	 4PLVzPspMnyflb6MHo0qlllnchG9RmgaifGw/Z5i2FKpHSptzCI4EOnn90JeBBVfNrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA360A2602
	for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 20:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46BA360A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so814323a12.0
        for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686758; x=1795291558; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=t4xxtvlP4RAICjpBIWPIkESb6EJJVOcRd9+LEytv251d1ZQsfD2pYblwETMOf/zroc
         BDzAo5elUgpAiRA0oYEfExHYSjjGywxztBxThvGs665InMbo4S8LytfXKr2B4Cw2IX6x
         hCl30XcWjOl3zGKKK0Vny1KN9lt2zjyLiPz3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686758; x=1795291558;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=YdNffEJTE5hOyFv4qtNrde7iH6wFYytIq3U9j4SlHjURVRltiz7V7/B0pf0q1vKt1g
         eOHO4UtbgcdDsi80iO1g4eZ8+tirnCmwN4j2U+YZwuXSRcc5TwL3yhLmzXH4Zg0MAwgv
         xVC4cIp7l2kCqQVPKxiiDYyq/ZtT15PZZkCULhgLd6EDrLehwqeCUxleNs6wLV8fd2QA
         5Gg1OOukicpKq1tytSH4mSFXLx6w4O0+K/3P3Tv6Ngse88bJvIUaQo1FO/DwcvOGQ55p
         U0k2lt8yFZ5o93DvMA4HSv8E9PY4E0spxeuMy2oPtZ4SH3tZ6KyH8KtfIzd0fxKPp7wb
         GPrA==
X-Forwarded-Encrypted: i=1; AL+hErGX70+6SZ23TIYwtiTfdXVCbUmT1alrod/uacNXvLEDjzN9raI6EzpoeelxoO+VLGytBg1jhlM9@vger.kernel.org
X-Gm-Message-State: APuU4Z+WaZ+peuAs6rd4VbYRQO/jkCXLQZFbxP0CZQzC/lYIUOXUpa3C
	CA38lhk6WQswiR3HfylF005Vf4wILpxQhuNzwsKZ9sOvbk+ofKP2pANXB1y6Oi8vB8U=
X-Gm-Gg: AYBFou27C9pEgjzakJPIaDzH54TeNUoCHqHVE5WFuGngrajQkYm9tytm5/J6fljeluA
	P1WCtwexqOvEoxAU5Z7fKWjlwJ/BQhLhIQ3UaMoBj8u1HhkkILJCElJ45EeRGHGlpNOf4pbbHBc
	/qlPYzftYWkNA3bF3VdZpGJwtx3jr9Sw6JOrIZY5XsUK3Q4h99ru//z8B5xq3OXNAKSgCEF6UAT
	vJTKVZME9W4nPds9UhuYn+Eli9IrIAYsZhvL2smVWU1swqoPwJigvkY1DJKFyDeFicUQW82H5tx
	NLe1pBQL4CgTMruK3KoHca8BlheLWUDxmzFuTgFbGLbdU1dYUij8vxNf9e12UOFoPYMjMhFS/v+
	D9RxrweeoIEnT0BiN0e/gyFsSPePPb0kA9DlRxKrwncsAxYGgJxCdomIgeW/N+/d/1G29PZizqu
	W7J0cbClWpGa8o5uK1ldT2+SPb7EmAj5SO7D+ref4eDlz/eaNvAJf16By9KWHRnt28JNw32n7Qv
	1S8knw2/gDfjkeTSU2k4eX8PgEa+0fkdMdMahN3uS06YZhQNmP2YDI4hY+yuKJ2ZdvY5yDYpyzI
	26VQ9vS360a45ppXfIjFG3Je7efCACXsW+9Y3TB0997YV55QUyS2RAuRCdTzXGics3GKmIPU3E0
	ZLRPZxy39WBNmJqZugm9mOfCPUEJwHrxVN/3+QPhm6m1xQ3ANBIMlMPGE2v/R1Wi4l7s1BKrgmb
	fi7x4AzsmG7RNhJSPoWszpwH0tVFt1gLAGpoLsl9YzfmeXJWaih7b+TEbl
X-Received: by 2002:a17:90b:3b8a:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b1b0b5f2c1mr6192503a91.52.1794686758572;
        Sat, 14 Nov 2026 12:05:58 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm4654869a91.1.2026.11.14.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:57 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:55 -0800
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
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
In-Reply-To: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
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
Message-ID: <20261114120555.cbfaf8ab8a92fb25@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>AppArmor puts a .null device node into securityfs but only ever opens
>it via dentry_open() which doesn't care about SB_I_NODEV.

Not a big deal, but userspace can see that node too, as
/sys/kernel/security/apparmor/.null. Opening it by path works in current
kernels and fails with EACCES after this patch. Now, I don't know of
anything that does that, but selinuxfs gets SB_I_NODEV cleared again in
the next patch for the same kind of node, so I think we should do the
same thing here. If not, it would be good to have a line in the
changelog saying that opening it by path is meant to stop working.

Once that's fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>
