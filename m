Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958486;
	b=MbILcdrHYldgCPNW14ieQXc7iBJlOZ6QVZ0Jru2YQOQHnCj+/tDntgx5V7lC+xUvG6HA
	 BvsKTe6xYTTS3rwgKka2G7HNPZJk7wmRkvj10cghnXS0ZVndcg+sSjPSBzPVbbffEXzE6
	 X5Cx1SEJdS7gQ1nHiDNIhuZ7kHukfUtEESSb6GCUhUhDXKnBqwRO9iUo7GE1uelTx9VW4
	 7zdt+q8V+I9l2KBOfCFjbQhrMrkoSj7lZUxeSOe0zQQFeSheWem31jfVnZjiCRu1hCE9b
	 KbFkw8MD54idNXBpE5hyaqDpe+Qm+qxVqY74S0WWGsgayCIzPv9OGGieRM0CBpWKcZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=id7sxPUZ1q5vwEsAL+ZQA4c7CaWDRU0GTvUGmQVP1r4=;
	b=PC9ns5xeY7MTQbserDVG8EZvkl3lSwHWAXkfiY+6Wg+yHZvAP5ekHg844nB7GvEwoic5
	 rxVdRI5u4TvAvGNUa4Ti7o1hEhX62782nX2EVDDU5TJQ2Lp/+IsLF0b+Es7/VtYvo74L6
	 1CI4Yas3UOm52kQ1k498CjblvWqMVLkNJ+ewHpPd927IcH3HHMZyXDP2PU7h68S+2DN4G
	 0Qp/ykgZzL8Yewd9mcmBKdWk/bZaVh22JrkLLTjF9XwRYZVoJexbcgwh/NgcueQ9fMhND
	 vzrREj66HgS346+dvMjpPxeI81jjFfp+sK27FFxD+JlpsrHfmmbNDhJdxWvySJkkWUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PRr5dLBj;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411BA606A31C
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 23:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 411BA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PRr5dLBj
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f22a8515eso37986985a.2
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794958484; x=1795563284; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=id7sxPUZ1q5vwEsAL+ZQA4c7CaWDRU0GTvUGmQVP1r4=;
        b=PRr5dLBjAs05ylRi2AXLL0lTt2IRquA8ljp3pqeJPErlk/8PgAPrbJeb5L3wCfYpa4
         XDYg/SSGs1hy4t8K+/Pp2PiFQx3NJhZscZFEkHYDBy/vZZXIK8wPt1b8bU/aiP11Aror
         r2GnSzAJl8YAMrvOZ9zn1J7tRliIlMrZCaSyvO1BKafTr1o5vnDRkuheZbUs3qaGJKbw
         GZZ0QuyXsQLRhhKtgXaxoG43vf79JCmBRlf2ehljTRfDruOrXulaw85CZqHDE9ak195A
         eJ6eF8rJUuh1V7SM65zr4OBPFIDmlixPlsEtIh2VtMq10Xt4Rwuc5EzZPn5JnzwasjJF
         zOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794958484; x=1795563284;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=id7sxPUZ1q5vwEsAL+ZQA4c7CaWDRU0GTvUGmQVP1r4=;
        b=YbNdhxm9eOvXKgujNALzZiwov0BxTXEOAA4QmZfs73wq/6g0MUunwC45NFSDn5FXBF
         5ynMSnBbNoQPLdFlp008qF9QvK9vDotuJy5aUIx5uMK3txJ2wEs64qzcUN+Bgy0h8VRP
         ahttUr7kHSBD97pfY/L5ztC4LMdFcYNxMBey4enxRro4Yc3qZyzb6Ml0dYFNG9EUEdMn
         An3xQQ+lWka1RFnb0rLHq+aYElJCFh7p1/mzNmXuMzSva4XbUphImqX4P+DFLLB0l/V5
         17I8T9kVXHIGFXVsdbOC54/bvYfRl9PmzptgMiPzQScZubqzcUJ90pizidvXZ362MzB+
         QCkw==
X-Forwarded-Encrypted: i=1; AL+hErF9b26baKdKCVnFpcR61LbJjKxMhExzqTYHGlmLuq/MEBBj3BpupRkGrckqWN24wv57Z/OMn+8Y@vger.kernel.org
X-Gm-Message-State: APuU4Z8rXkSFBdsuQzzWym69YNVt/jW1JaeKx1baIQbvt+oRMyqKI6uj
	a9uyrqVx6qflBZ6Sm3eSxxLm/NT/kbkFVOxXTjLLiYagr5nXDp1+qe3khTaQcY1ctQ==
X-Gm-Gg: AYBFou02DHX8Yyu0u0NEsx4IDYfR6269KIOTrczF6oWd3ugXNQGHVZBR23/5rNo8AcE
	8ec/cJXk5hmU5irKi53z3lCWKCRQmwtWqzYwu9TP9camh5zYzO4qaxWTCsItewy/iOYNZ3I3rSq
	fGOzflOS5dpM6PbLacS/P970uHbI8Jl5Uifk6IQk8LBMzl65RY6T6w7WpZaArGD3xYBIu3OhwPg
	eTIqZN7bAPDijmKHAElsPwW/Yx7qVbhJVoR7cu9Tr7USo8qjGEWoQ6u+YVhCPmrBw6Sa4zpcLY8
	dtxWAv9q8P7fDkVkvsLeulvAPT/77Bg8aNEpMWBVulqa6qtGIjLsKp/g159du8umBCj4Mgco7i/
	kW4sTQwWH+V+0vS3QsZwYfZYUnnC5wIu1yIsTUwSSsiX70BAwPsBYgdjhhlWnwRVeLBrNHER1xN
	68TFvBpoisWaanQYaXDms+ZtULgbD7bA4zRX8Z7JUO4GpMODbTUpe9Ziz9Gy4s9Duz3B60kWy7G
	M7EYrJqYKBozU96Y0CHeCzngXsz1t/eH+Swvn5FPZbSU6pZz0W8sL3l+Hcdiac7GYu2mNYcJ9UH
	M4NZVwDgjafkEflk3UFwSFXjBe6ei+M/IN7j6rS7Y5dOX21eKO7FwYFlGKOgOm+WUsraryTRI7I
	qDUDhEFFP1oq1ApuBIHAeuE32x/KdVZ4=
X-Received: by 2002:a05:620a:2906:b0:944:dbd:8253 with SMTP id af79cd13be357-949995ee428mr247457685a.59.1794958484257;
        Tue, 17 Nov 2026 15:34:44 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7c9a65sm41585085a.34.2026.11.17.15.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:34:42 -0800 (PST)
Date: Tue, 17 Nov 2026 18:34:41 -0500
Message-ID: <7a012ff555beb43b389ba5ab96e25ba3@paul-moore.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261117_1552/pstg-lib:20261117_1552/pstg-pwork:20261117_1552
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org, "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH RFC v3 18/44] selinux: use fc_init_pseudo() for selinuxfs
References: <20261116-work-loop-pseudo-v3-18-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-18-8cbbea1cf34f@kernel.org>

On Nov 16, 2026 sashiko-bot@kernel.org wrote:
> 
> Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
> refuses PROT_EXEC mappings but the status and policy files are only
> ever mapped for reading.
> 
> But selinuxfs needs device nodes. The kernel replaces file descriptors
> with /sys/fs/selinux/null on exec via dentry_open() which doesn't care
> about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
> path as /dev/null doesn't exist yet at that point. So clear SB_I_NODEV
> again in sel_fill_super().
> 
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Tested-by: Chris Down <chris@chrisdown.name>
> ---
>  security/selinux/selinuxfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 310e19efff1d0..d7ae853b6d685 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -18,6 +18,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/hex.h>
>  #include <linux/mount.h>
>  #include <linux/mutex.h>
> @@ -1852,6 +1853,9 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>  		/* last one */ {"", NULL, 0}
>  	};
>  
> +	/* Android init opens the null device below by path. */
> +	sb->s_iflags &= ~SB_I_NODEV;

See my comment in patch 17/44, this is also used internally in the
flush_unauthorized_files() function.  Once again I would prefer the
comment to be changed to the following:

  /* allow for the /sys/fs/selinux/null device node */

Acked-by: Paul Moore <paul@paul-moore.com>

>  	ret = selinux_fs_info_create(sb);
>  	if (ret)
>  		goto err;
> @@ -1955,6 +1959,7 @@ static const struct fs_context_operations sel_context_ops = {
>  
>  static int sel_init_fs_context(struct fs_context *fc)
>  {
> +	fc_init_pseudo(fc);
>  	fc->ops = &sel_context_ops;
>  	return 0;
>  }
> 
> -- 
> 2.53.0

--
paul-moore.com
