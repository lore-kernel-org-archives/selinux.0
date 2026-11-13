Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564705;
	b=Doge13DMyXGUgKD1yttsLNqmKS9E3wGWXt2luL2l8NTQiZaHmWfhKPOdZmdjTumFXiY4
	 mcJnXJz9LC5awLsm8ldH1RGU7yKVA9RNz2KIgE5pailWLvznzbaUR0EPPusSVFENIyFz3
	 B+caSWl2SJitau/FAqbEZ96RHa4KqgxcI/WYdBuVLlW2QARCv3iyqeKv4M6Z9KCNAw2W/
	 lE8m/YffEAgJ+QRnj0jbHWhtsBzz8btEk2R00tOUVT5C08HIiHilTFJ6MR/rUptm9FiyO
	 RzuW1yh9FtODvft1Xnrd6eBeFJ7bQLf7rfm6Y62k2D3hBBvXRO0vPV0v3A4mScQVkjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564705;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
	b=RKA3fEaANxrFZ5F/FinofQyLn8lqr+EqhlCScDqAB1P3BCDzj7Kd3paEpC7Plse/86+q
	 gzLlJ7ILX69z2jsp6mX7PmiEc7nUmM+gMb34LigBj06u64B0T1dxw9b6buNcJPMpK36eH
	 8/9YJaqsXcoRBhVzPbFeCB8o0yqas/stRUrJD3BvN5d8PMG0wFCA0tl70tpdlsglUaxBb
	 wFplqcR6wTuTCRkI3lppuJeRYk/Y0v8sEiTmOYZjzbxoEirKIFJFvuBkUvqZbHdom7tOP
	 1UMU8SbgjC8FiV3Hn/sknEaJgpY8PgScVdKhHFv+2InRf/4m6n219vVMJeGore0PP+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BADxd+iU;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977FB606A88E
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 977FB606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BADxd+iU
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4922523d1afso333867f8f.0
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564703; x=1795169503; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
        b=BADxd+iUI5Bylfm9xHmZjb4pgHg0fbyWkyp8vNCt747iYknkt4pGGRNYLQ78EH/z4x
         Vbi/Jq3+E8iOs58TJRk6WPlWSpFf2OpeZbjgHeXjXzKeHm9XnJ+eEvU2VLt6liCBRq7I
         79Td6VY4SiSTAXWOIivpd5ztVkC+DBAB/J4OfHn49+YeU7s/KQ9yNfnwb8sPZOTKoGu0
         Zirp8LScbJznGaQAXzatlGuiy/pBfqScnET/jGobuhYjlwMbyAqyeVJ7smTe1nJkO+dB
         h89eeA8CIS4pNdPKyjqDo55n+EKX5qBSzrC2C/95dZzzzQLBvHRJ+46c+P8Bzg/7r93a
         +u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564703; x=1795169503;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gXMsjTg9KyNTuX1cuQ9yr2iJq2/VClhNCtHhh+FL0ZU=;
        b=dH9vPIDuAE8SLYrjsZUY0VA3JqiCmCf3Ysoy3UIhmfGifQVptUQ7GkmLvlSpgUVi1C
         6Dd+E9ErhOHfM72FM23iYYpG8Y94C9Vc+SMtvz8ZTNL9Dpj9+vFIs9fJ9xPYymyraLvu
         SOVqFl577zVjOaDon+A9wSE1RST0lDTu9QaE38a6sM/+FHpJFq98BevO9Ii11MCC530K
         rFnDvQhQqYlXWHTkqi5ondP+49JVb2M8WSZBrcQ8dzecYleCWySd6QOYBe/PiNCBoZtb
         k+WzDslkQcl9NtDPzTY1u6f5aOWkCrvTJ+gLcnbyaQkZcSTw1DEChsEYRpYfbIKNjEGf
         1w3g==
X-Forwarded-Encrypted: i=1; AL+hErHw7DUOHhF5/F2XTFsR/KX+je83eou1j1qUqZb129S+UxBuwwLv1wJRbDk5Fkr0lRIQFa/ocrY3@vger.kernel.org
X-Gm-Message-State: APuU4Z/UQ4QEIG1iz/9dfd5Lac+tw04XXxektqp8g6y+QM0xe3yPrcEg
	bD4lHgtbt8G8JGQ2bY+PK5/WhU5yh40GrB5RPEpvttNb4g7v0nmMWdSLuUxhobH8vPIr
X-Gm-Gg: AYBFou0RTMSUk9LH9NEJUqOjVaEfedEd8IH1hXaunTcRZRUrjMIO653Bz+8GUB6fLw7
	Cg6KM/TbbvLjMn0ZtsXfFxnkiUX4pyrM+cwFwxUkqRJD7MPPWRvTr9ayJ8CPRBSZEbBh1f+SyY0
	9K7lc1Bao9I8ppwbh2jdCeumwxR8EXRLvpEAj3kDLq9L3VGa9wK//C4K5gNF7hHSA6ISfFnJysv
	DJ0/auM37vOVyYsmVxbnNA7juJEiqDT51DwU9CZxrEVWLQ0gISKuOmC2QKlKdii4p22LcLuppx+
	wbr1iKN/YztX7+1p23R6i6LPqZ0+Me41OJDqWdBoxJjwxLCb/8w9K3SU0YRD74bNTKHqIsG4Cjn
	Q+TpQXLiPPo40wRzG9gvPkNoDvmIw3JOSZUKjqDHU7dq/DqAd8BL/yFTiuTleBPCtooBA+qUmR5
	zrYQpdE2qgtqK9kAdljVP5iGxuXxHnHBDdX9Shwo7C6LaIG55XHsOdvae413FH/Dju0R6hNCu5K
	Fn22JfgssyLJurcYFI1glpn4yUdjxhQYtPIPxE3+dHXp29BeQQc9u1Cb5FsNSbHD/Ec4B6mG2nf
	vJmrut4Gi7sXkbzJono3XKv2Zv1gyUDSAqNfQNSRaNpYszvG+sC+B+xHud+k9u0=
X-Received: by 2002:a05:6000:2501:b0:488:88ec:59c3 with SMTP id ffacd0b85a97d-49c73259cc3mr5012611f8f.14.1794564703010;
        Fri, 13 Nov 2026 02:11:43 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1797sm4931434f8f.11.2026.11.13.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:11:42 -0800 (PST)
Message-ID: <ff6d2a8c8623f5476d5c352dac1ad98ab3da303c.camel@amutable.com>
Subject: Re: [PATCH RFC 18/41] selinux: use fc_init_pseudo() for selinuxfs
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
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:11:40 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-18-4c998976c6c7@kernel.org>
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

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and
> SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
> refuses PROT_EXEC mappings but the status and policy files are only
> ever mapped for reading.
>=20
> But selinuxfs needs device nodes. The kernel replaces file
> descriptors
> with /sys/fs/selinux/null on exec via dentry_open() which doesn't
> care
> about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
> path as /dev/null doesn't exist yet at that point. So clear
> SB_I_NODEV
> again in sel_fill_super().
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
   I.=20
> ---
> =C2=A0security/selinux/selinuxfs.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/security/selinux/selinuxfs.c
> b/security/selinux/selinuxfs.c
> index 310e19efff1d..d7ae853b6d68 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -18,6 +18,7 @@
> =C2=A0#include <linux/vmalloc.h>
> =C2=A0#include <linux/fs.h>
> =C2=A0#include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/hex.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/mutex.h>
> @@ -1852,6 +1853,9 @@ static int sel_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0 /* last one */ {"", NULL, 0}
> =C2=A0 };
> =C2=A0
> + /* Android init opens the null device below by path. */
> + sb->s_iflags &=3D ~SB_I_NODEV;
> +
> =C2=A0 ret =3D selinux_fs_info_create(sb);
> =C2=A0 if (ret)
> =C2=A0 goto err;
> @@ -1955,6 +1959,7 @@ static const struct fs_context_operations
> sel_context_ops =3D {
> =C2=A0
> =C2=A0static int sel_init_fs_context(struct fs_context *fc)
> =C2=A0{
> + fc_init_pseudo(fc);
> =C2=A0 fc->ops =3D &sel_context_ops;
> =C2=A0 return 0;
> =C2=A0}
