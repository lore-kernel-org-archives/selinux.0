Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794698411;
	b=VtqfWdXUhamnPBQg4JAK2DZ/2hvKa8VzYsaHGNy4cKwpM0CfGAAveyy/pEvCDi2FkrgO
	 zAZn13xaSQWlyfnpowFpFEx9w4wX6/fUb6AtztE7hwtynpHtOPOajTzIoLLDqOFVcgZjD
	 a0ZDh6rul/x2XxiQ89ynWzJOs2I0gMSUwlBxrISPe0bGqaQW4raFj/hQgNr6MwhSzvmkM
	 90DGWWJsLqd0xLpe4Dg6EzZHi7z0ycbYrnPHyh1So+wPD/Aq2rb4nVOGOxcJkiuMtNJpT
	 QFhSwt0km/Y3MS4snFRIbEbUgnkfNowlznKfIcJsiMu18kBMMrzKiscjGCV1tK7u19g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
	b=sCj3y9/2B2aleVU5yqPaD+YY7exVPlQ/0GWq//7vyRlaxAsfDUCns2oVVughcz3HqmnF
	 Vv6pJdYBbCXnHbt30HhFBDK88WAjm5ZSJvkRKuOBWtXHtt/Ik3zzSm3Lx68r/v0z4mi3y
	 /R6pARU+8xzXXHhAVSkWrx6NnPurIqZLi76fFNKUfEbHuT+6my7D18SWj03snv6FHKm2Z
	 e8WiNT1LQslWSMj17+p5BewtuIKKdV7T0US/OG4S8HMa7Cln6BHBH+E9NMCEKoYb6VNPV
	 ZY65yNP6qemcbcg9tcfPIeb2mxLnhisNeq9JyydoBToL4vIaC0+BaxDjkDap+qknyUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B1606A33B
	for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 23:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 087B1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b7245ab5e2so5593825a12.1
        for <selinux@vger.kernel.org>; Sat, 14 Nov 2026 15:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794698409; cv=none;
        d=google.com; s=arc-20260327;
        b=VoCKAQ5fbSg72PhSPKsAlNpNm2WVE42p8WkR9vM6HWFdIOIE0nfQ1LjKtxJNFXRu6b
         6ZFOh5/R2CHo+T3ic28eBqZwQdcXxtCw6sfFYD73HlM6j4JIsvTrN/MJN5U38O0+OcOj
         fJ89IfTZjGzdHkCjM94+orYY0PkjIBE8EwMbHDyI0HLRF+xqH71gSo8+mS2z8yyR8Lz1
         Lkot3lfmhNEyzfQxekViyd9ySBaS3bDxB8CdNksTtuu1CcyJvUHID/COrUPW8Kh8KiWo
         oYxhC/4OryaLJLe8yC7L2T3tpUkbJWnDz6DsPGq7m9AgalHaLDEEc2mQaKwTkKBeGEOu
         aW/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        fh=svgngMQ0OAzcM6nxdmM6P6T/CQLrDpYDO7K4NASljYs=;
        b=PzyoLHeQDd6/lB4kGG7CIUnxKmSCH6tIZpkwpypV/3TPVpuNcpyUOLI6fEwIfKQ46H
         cZhfBIkZpYy0xzBchxtwx0J2XkxkEHxe/nXwjl0jJ+zgLno71hwyvDEGMmm0zj+5SuHz
         /x6zO1qMWGsieNwukjpKgkjJTkuULNwG+sKXN/dzmuTPDTaiF1mlslg+muLoYJNBZNW1
         EUGVNC0YE8U+ZElIeXBPcEq8tQW8xuh1WI5XmIqgXW9CGZ7UQey57lNvK0o/suO60dvm
         73mejOe5gTwPs49GKUHFIJyt5k8w3qAylBwAfiTh2U+oLFqlhiq5Ig7xahuD3ZYsPo4Y
         ffuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794698409; x=1795303209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=bZ4A5V+6Vs4HKIPLNbCXlaoHg6GUiZAgPE1CoHup/u8F9XnmCFMSb6naMqQFAl++mw
         +LZR0jt78s/FhrwMU+95xN0Ho10rZ/g9p6M/dfGpr9SfvlaOXM2WfiTCtO0CejnyefhK
         5gg17lDjyCI6S+pTTK/DIWzHtcTY1JHkLI4t/I/Teu6/Lgz9A0oKfkx231Ay53Fdu4Kp
         zCo0ecwmPzO3ZOIddRCFMjOjLH94BU3oXsC8cOhJgJSeLFwZkZlFyxo1cq6JVw7hHb6A
         21NW8PziNlBat7d4DfM9UgO0YIScpglsDnmQoGQNIOQhlOx3hw76q6t8+8jTPfBn24eS
         FVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794698409; x=1795303209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=UmuRo379NEWogwtuKNikR2RjQrEzzPSWRbSroloqZX7XIpTAZJq1r+GUW0aNRRrAiG
         1Dqr5anSLKioIqgD2a0lqS5ztMW5gCrsilxYgN07eOC91RuGAYsNWB7Pt35PqkDRgiZs
         nfokRQ8+6MVZsb25VoLUUJLw0EGc0i/3QuJwYkU06wGNDBLJvezmq76U85hDiIXY2pmT
         2qlp+toUclAhCQqEcWorFgzBWIiFzBaxPozpyA/P/HA4NY0IrxCCRCP0kg2Il+T1ybnz
         39VMVhHJh2+mNlXawApseVWOuFeEeZnCe8lkg9DKL/uwJbmxKJdFwAnMd3qZY47m7rPT
         51ww==
X-Forwarded-Encrypted: i=1; AL+hErEx6Z1Gtw5cm/gsnRPDLHRuTB77gSf5NPn0J/aokPzYuZYbGW9hFr36vnM5KbBRqbwIvTj/1NYy@vger.kernel.org
X-Gm-Message-State: APuU4Z+xWaMfHOxFaoZhhGqW9MnI0fPXZZzLjv2OIPwr1cat0n7UzOgc
	D+t9O1WJbicIJTDTXL1/E/j/5tO/czhSY/P6HFAWbatDn+y7uVF/ifNE9NOaGZ4MwOmT55X+rnS
	2tPEXjXrvs5sBTa0i3HzHzXJ+qRqAbxg=
X-Gm-Gg: AYBFou1LXmQse//QLp0Uv3t/wZVxKCMDVVsXiPfFYGdOvNMK0wAbTvNUuK/8TimjxfY
	I0fa4MOB43PXkUPkYcujM26B5M81UxGR/PhXZWc0SHoH/asP0O135N1zlt+jaUyf2pOJSj5JleY
	7ZAdRTdUuGa6tiY/mNROosMx3F5P/GUxk05c2UhiX/xFoHikZkvoWWjtD9l5zSJSpM/Rzk18y5N
	MpXE/s1W3EN2SiM3tlXA5RR47PoFfiC7jS9+vJFgsGY66sjqyIjV0+96bdGKavG6n8GoQCPe7gw
	XEBqt+52ObApuLmOzMune11mn2KvtuJsabnHcHW4/yl6dwQk13QrduhmG61CJh8eecq10HIN3mx
	HbfENA4QpOujOuyxKZn5LNP15d8e6e26uHFQEgSrwSzJlplUps3G/872HSP6FzbyJp1dFfw==
X-Received: by 2002:a05:6402:e10:b0:6b7:f00e:5e56 with SMTP id
 4fb4d7f45d1cf-6b7f00e5f37mr1542816a12.1.1794698409123; Sat, 14 Nov 2026
 15:20:09 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org> <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
In-Reply-To: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 00:19:57 +0100
X-Gm-Features: AclHuK_YVxhIpv6JLzeNAX5mX5IHGfu05WS6uQ-TCKewxE3JKeci2PyA-UDMCbo
Message-ID: <CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
To: Chris Down <chris@chrisdown.name>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 9:06=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> Hi Christian,
>
> Christian Brauner writes:
> >+      /* Look through stacking filesystems at the inode with the data. =
*/
> >+      if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEU=
DO)
> >+              return -EINVAL;
>
> This looks good in general, but what the bots said about O_PATH files
> here is real. With FMODE_PATH this is reached for a file that was never
> opened, so on overlayfs nothing has been through ovl_open() to look up
> the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
> itself, and when that fails it hits the WARN(1) at its end and returns
> the overlayfs dentry, so the check passes as well.
>
> Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
> it's easy to trigger with that. From a quick test with a metacopy file
> whose redirect into a data-only layer points at nothing, registering an
> O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives
>
>      ovl_d_real(/f, 0): real dentry not found
>      WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
>      [...]
>       file_check_backing+0x308/0x5e0
>       fuse_backing_new+0x219/0x4a0
>       fuse_backing_open+0xe8/0x390
>       fuse_dev_ioctl+0x53a/0x7d0
>
> and the ioctl still succeeds. A normal open of that file fails with
> ENOENT, so nothing could have used it as a backing file anyway, but with
> panic_on_warn this is now a panic.
>
> Maybe ovl_d_real() should just stop warning when the lookup fails, now
> that it has a caller that isn't trace_uprobe?

Yeh I guess that this needs to be a Fixes for lazy data lookup.

The correct fix would be to teach all the callers to deal with an error.

> The check would still pass
> for an O_PATH file whose lowerdata couldn't be looked up at that point,
> though.

One observation relevant to this patch set is that a datadir layer has no
business being a pseudo fs and that can and should be blocked explicitly
at overlayfs mount time.

The other observation is that fuse_passthrough_open() should probably
check the backing_file that was opened for io in addition to checking
in fuse_backing_open(), which could have different FMODE and specifically
could be FMODE_PATH.

Thanks,
Amir.
