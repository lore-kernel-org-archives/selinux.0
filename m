Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323278;
	b=jKjmVPipscO74RCm4r16hjD162zVK6OYHS7v+5RKsJ+aGQcvXM4MePMaSxShsTtNW/gw
	 /1vQbXxyS2xX8RfEKc4/UylS45zkIy0bE7rJu/HejS6t2Xrr5i+d3IORDhAg61Bygszdf
	 rsLzeR4+Y89KxPe3FeTGi8wAf8MMXit4aoNupp+XObonMSLL0xYAo3aHDzcJ9/tyGiDI6
	 uypNmARqeAemcSdGKXc++1zh6bFCNHVZdYSD+2Qg7/K3rLlgXDloUmmam3L1BuL3GoXeA
	 X+t2SFwCpfSY2ChEbQJ5mRzDvOTuC4R8kztNwvl+lGCHi+Z1V5G6ffXlPj8mICEvb1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
	b=4/b/UuCX42TIJPWJ20s1x07D15BKuaTzQ+AitFEwU7nI1HgURCidtaicoob5kKuL8UCX
	 Avxptds5GxaIvxlGHq/vHiDo8h7vT7eZDiHoh2gDmLK3krfPVOFs1Zq7nF6CpnTaA/Fx8
	 wC16q9owJe5ZVZM3cW2+ZpX/Tj4si4E/74C5GIAJ/3dXhC9070EhTB3z6jeEK5GmgQGI9
	 mgyz5miDaUjalDztQJgCWc0CfVWEiVYequphixNbh2zsInfBPU2OZ+pDHE5s5N99y8o54
	 OQe/bZVtwCR0YZqO8wMspvUuBpZ5qMpoOHGA9pe0NPucuQ734TJcInIz6Hzw8WXl+bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A260A261F
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 15:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208A260A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e977109392so12284605ad.0
        for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 07:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323277; x=1794928077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=LHozpx7ZkQyIUBsAkv4C311vzxfheFN2pzrL9Y/FTHkEXQzaVUkMAz9U9wFUejAOr8
         YATASi40x9WcOvyF4dkS6SJQ2bBJHO0yE68WsOT8oewufPXMhMYT6O7d4/5H33a+EMHR
         jjCu1KqktdAA/9c8ZIpbjFjA/3BLyNbgEZc3fS3F9+PTZ5y3jCgkJQ9rhGft5ONP+cJO
         aTEF5vn9sQP8UWqDXO8UszNcV0yZFTKvtrsUk25y1Sz/3h5njQt9uj1PBQLO+FuWPgpB
         LsGoLTWDE/iFYFuKD+GJLya2PXFipxPXM8zYDthkWkjgd0549O004Xgoom3qc/ylK84T
         vykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323277; x=1794928077;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=cFPyo9Pdr2TmYsYfjBefmB19CRNzzGkdDPJ0pTmMchivvGcSjjwsF9B/NjS5NjJCs1
         cJkjEN+R6BYtFPE/fpreXyFGF+96gCF/0QnoOFXEklsCVz5IqFDHuGJ5enLhKBh60U1u
         qJLOEoidaFvg+5O/aPJMg5+BbCLS/8fczUForczqBz3H4I92eTL42oMxnBTi5Aj//gEz
         s1GEUSGga8XNdFsQuHJmAv6ULIPltPAXu1ppr/XBK07BqyeK7PXW70wUd7szu4kig5qL
         zRP02BGxeMfmjxzzXnWnTJMuxGiknc3g0xYM1rsGYbPP+PydIk/5x/W9rWhJFoLLrsH3
         ORDw==
X-Forwarded-Encrypted: i=1; AL+hErHramrPYcZfTfmmdz7i/IXDZyzrwg7K6WyTEbznrgN8t3hCx5uZONaYIxZHFo6L5a1aKruSHZR1@vger.kernel.org
X-Gm-Message-State: APuU4Z/NpTkQdnIWA9ftOYoR1guLO+2AA0uvFPs0Yt+F8N4XBFnW1JPT
	ETGirxZ1VXFS831/dRJSVuubdzh0WpEcOzuRNsa7k6Paho5BKCw/PiaKSv06sDW1p9E=
X-Gm-Gg: AYBFou0yqOwz4L7vcEsQtLewYgX2ECd5Y3JZj2Z+04EnReWrvguJBW/URn0OSJd8m2u
	Ly3AfX5IwlszKXmHLwe+kGj1Dwn3jFArPuw0e9LOlYp/Ra3A+S5eg1NHm1367+vXpYKfvqidQNy
	C7p2CeUYWiUc4z4R9B8l0YS8nxKPCB6qsIHYqXzK9ToVI16Oeu68iknc3ajxkGj1zVgpChcf7gU
	pKUaoYCBLl/XNUd79wrNIqVi3LRnvfFTlOR/UWjScogzLZyL4KC32q6sjgrYQ4fhzP/jfWNG0CF
	5Dpt430OEXNpzrDn2Jxl189bfO2sZIqkgGB1uUuNCg3cfMepOeqocqbXw5NGjQZe4T0gXuBrOGh
	a10IW1o8GIlKifu6VEvBeBoiG9HiM6FYm/XrQ1nuQY4ftyW/ySrY4EgyBl0v9ulleLdZY2lm1qQ
	QHi0OuFVFEYBfBfb+mm6iFyLDLRsTH9pUBYHruQCQg2EJ09eD57wS1kRztcgfIUN5BA+JZRtZbX
	Rfxd3bM22M9+eyYfdKCs5eWynuV2OGO6IQ46YHUypUiSG/NlAqDhkegzhX4bfVCPGVIyv7V4Hza
	YS+igCX/1M4zDEwIlvDGMzSOkSpC1N5sF3ocPd/DL3ME+udDat+jwza+AO5ZFtl+LK585etf86x
	ZxRLQs8+dTis=
X-Received: by 2002:a17:902:d481:b0:2ed:1ef3:9ec with SMTP id d9443c01a7336-2edb9172a2dmr26826345ad.14.1794323276968;
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Received: from [192.168.2.6] ([27.75.101.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d78dbcsm10397575ad.27.2026.11.10.07.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Message-ID: <71f76e5e-ce24-4a71-863a-169ad262c510@gmail.com>
Date: Tue, 10 Nov 2026 22:07:46 +0700
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 36/41] nvmet: refuse files on pseudo filesystems as
 namespace backing files
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Language: en-US
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2026 4:14 PM, Christian Brauner wrote:
> The file backend takes any path that isn't a block device. With
> buffered_io=1 that includes files on procfs or sysfs which then get read
> and written by a kernel worker on behalf of the host. Refuse files on
> pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  drivers/nvme/target/io-cmd-file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index dfa8aa46188c..71c69bac5394 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -52,6 +52,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  		goto err;
>  	}
>  
> +	if (file_is_pseudo(ns->file)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
>  	nvmet_file_ns_revalidate(ns);
>  
>  	/*
> 

I noticed patch 41/41 doesn't include a test for nvmet. Would it make
sense to add one with buffered_io=1? The test would need a pseudo file
that can be opened with O_RDWR and supports both read_iter and
write_iter. Otherwise, it could pass without ever reaching the new
file_is_pseudo() check.

Thanks.
