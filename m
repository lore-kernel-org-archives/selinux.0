Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904515;
	b=skkKH+QufikxZAG1EeFzHejkU7pKEN04fRcwPzaZ19aA7KS2xsmmCGMceYmIENm+aIEO
	 Hzl8hzRUifP6fD3VpKcRK4OauHOtenW8g3mzVNduAvHc/T9EtEU0mWRtluEXpycXt1WmJ
	 htJwQnY5U0VYc6hmkIgKk31tJrX9kKTOK9fg/M6D0nftiyd/mEUgfanS3SWv2nNkWyClE
	 FHrT5Mxl4mYhDKrCGJMpj0Ed2rzhcH92iOS/5uVixdRIW47RJiD0pHHCjFwkscCsYquia
	 RQlzC/ZMTXYRCr2iTvOkW5KZ5Hm9mstkHFBzr9bokdzNqMoUrRplc2zkMKHWLquV8qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
	b=VLitcolj2GiJ2gNAD+6vJdua5mmPgEyVh7OlaKaNxju0DzWtrooSyIhJj0Pi6ikbwYsC
	 kikqVwqmlCu5Z700FiPBYHaQ4JD2SOASlvNE19jJlrjRrEL7YN3AfPOzogY8Asmjhw0+U
	 +i5V9FDoNOGvTl3Co78P3O5UjXeC7lhOoNM5WoM+DsWtL7Vt7lDucJBCEgKdFFw2cZFIi
	 /Z7Nq+ZtcSX0rwuq3LgmfFeh5DW2gPBzNf9wDIVMF2KEkthreGGWZjAwpkbLR+zozBaQN
	 q2ePJlRFbuQXuMvFcuOPRw8FJprNgJJhvkWJtr8PaqZc97d6mYJaMS24MO/1S4IhBWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=asHWLUHh;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98270606A8A7
	for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 08:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98270606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=asHWLUHh
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a33359c1b3so506527f8f.3
        for <selinux@vger.kernel.org>; Tue, 17 Nov 2026 00:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794904510; x=1795509310; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=asHWLUHh9Osx9c7ISjHVvBK+jrwM+bEKiKQ5ZLUG8jHeL8cbDrdmay7aq+azwtlrvN
         q7YkHw224WJQO7TnM1AyMygFYXrlY29jKpq3C9XROr0oTqsA+UK4p+WS5GMy+xx9DTRb
         nuDA+OEO8+ykjkDq/RDjAwEfWgenycj+snq2KkG6mulygb6NKchr6plM71+t8W0/+aGL
         LigMC+giRqQ92TsunABClmE52NWQSdRqhQeez7lH76lemvGh63Ic8nud3Qte/9KpQmbQ
         YrdviXjfG5hlS64KIE7Iq0kMRVYmtZMNK2hkMRb6Cz1tihRk5N+J71aJKPK+K5E0SOED
         KbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904510; x=1795509310;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cVfVc99Mj9JzDjRqkRlx7bbwk4z1TaP6S9xba6j1G0=;
        b=ivfNOV+E1rIlaqOPlTLYNOOeZtYyo4sbs/M9lhJ/JJY6nNWVn6NxUvKodKcEb3Gz2a
         kEkVZDC8Xn/Q6NRa7am/d+EBa+d+jvLZ4TM3CT6CoyJj3+LavG0mpBfr4HBVLZ8fKNlL
         rx2JnU10dkSlZQeHx5l3Q7VGv6UyVMcPFmBDyTGbD6ZedwedGcEvW9M0YmsLU4ysnc4q
         k41LP0A1CvNlm7x9TlMuuQjbSP8l5aVlF6bspoRAATnW87HEOJRc1OO3OMyAisJBxTjR
         6pfXiralFUAw1oUHAYg8ZmBmsjM9VgJvlr26az5sF2xjddIivmLFUBeB7DhQxXmpq//Z
         IetQ==
X-Forwarded-Encrypted: i=1; AL+hErFbVarM8rhTzObJHZe8nrKwu/WwFls9rXkIXbBbaNV2DZ6yH/rZFYA58tV6vcMZSBACtNSHQTGC@vger.kernel.org
X-Gm-Message-State: APuU4Z8DTL4QAeuhsrCWt8z5YBmWLdrwLjXDkoWMp9Xaj9FLSIFAmAeg
	BhiI7SLrqPfe4Rr1V+6wlu60reXOG8xAsEwa9kvwh58XZMLxJZJimOujLgROrqo95/z2
X-Gm-Gg: AZFdTZeyrkJHe3r27r2FK5Z89sEIyNAZi8JczEokRbJGdZL9aOphlJKKiu0Zl26wwfE
	m9jsT8uHTIeWtkkCuKwe4rR1pyyYI9rxcG9qlIkTGf4WaJNs80VC71Ab3UgWHe9cqd7+zmA/efl
	YJQ5q+VkBzg3z+xh39Jq3MlnnvnBodml5bXjCEsAjI//o1gywcev7EZlnJ2/Xh7qTfSteff9g5w
	PbUX5I3mKjn+otuWMMZkH8SqbqVvJzJ+CxusMmcTpnmJjozOozxSm0p/dmwbY44rfH1Nbug5OsC
	2H6XV8jRenfDmKkbb3hCgeBLmK2frSDk5SlLPkn8NqS4pP1OtR+9dnPW3eHgDVoOqFxod3qH/+c
	ZqO6Ob+tAMwNUIrGE79HffcI6MHwPs6quooG4rnvDS0lbfpUZj0LuKDocB7cCZlJbFDERTBDDJA
	xrgN3wDicwU/kdTHWj2WR7TOpV3Dcv5+LEWmv+PdTWv1i9KCDnJjD/pztI7BNu/+6pq0WTqLoyH
	gg43skQvlOSGCCxJ9jJ8zW74WLq/1CcZLb0X8Q+fjqQNaqnaobyC9hPnthK3o3Tx+pLuZnHhYRK
	z+/Ts15d50zev+nqHsrsdG6+EAf6I6Ajot3TtEb8LEPidmJyfOSxgeRwMJkRo1IjqB4ZuYuJjKX
	fbFGtj6TCdtHPRs4bivvmpz3sZgjivysLpCJ4fTYp0oIzwZrz4xfONojH
X-Received: by 2002:adf:e193:0:b0:48c:7306:18e9 with SMTP id ffacd0b85a97d-49c728c6e6amr26569239f8f.43.1794904509932;
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:de4c:6789:33ce:97c2? (p200300cf572c2800de4c678933ce97c2.dip0.t-ipconnect.de. [2003:cf:572c:2800:de4c:6789:33ce:97c2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm26338505f8f.36.2026.11.17.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:35:09 -0800 (PST)
Message-ID: <b0ec2cd8f9b7a6a2e4a54c6df2fa897bce068cbd.camel@amutable.com>
Subject: Re: [PATCH RFC v3 28/44] ocfs2: use fc_init_pseudo() for dlmfs
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, Chris Down	 <chris@chrisdown.name>
Date: Tue, 17 Nov 2026 09:35:07 +0100
In-Reply-To: <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
	 <20261116-work-loop-pseudo-v3-28-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 12:05 +0100, Christian Brauner wrote:
> Initialize dlmfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. dlmfs never holds executables or
> device nodes.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Chris Down <chris@chrisdown.name>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/ocfs2/dlmfs/dlmfs.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index d3bfcada3e3bf..1789ec96dc130 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -21,6 +21,7 @@
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/pagemap.h>
> =C2=A0#include <linux/types.h>
> =C2=A0#include <linux/slab.h>
> @@ -563,6 +564,7 @@ static const struct fs_context_operations
> dlmfs_context_ops =3D {
> =C2=A0
> =C2=A0static int dlmfs_init_fs_context(struct fs_context *fc)
> =C2=A0{
> +	fc_init_pseudo(fc);
> =C2=A0	fc->ops =3D &dlmfs_context_ops;
> =C2=A0
> =C2=A0	return 0;
