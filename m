Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794859452;
	b=TwIXNQmUCTjrTd8IdtojVzUm6Ug8SzXGl5JhY5K54ijUTUVA5rv2i6ZDuLUdiODUJZU4
	 Q463lpKfXUEo/ppPwiwf2mes7W85E098tbaSz4DX8HxvBVhjpVa688gvE4mnR3HgSt/fK
	 bcTk8Ra07jKcVrHb3BnSc+EGV3rGMJe/yYuzcwCyjRNHfpHukt3nYEgY+VvtvH7cswkat
	 e0fdBtRiGEfAqtizGiRSWW+IQ64/myJqa/dvmsIVMsQxqWPGfLS9PfmvebGEj3oMhtplc
	 tuGt/mDDuMfyRUH3l/Oj8Z3bzLu9QjzjByu2F3o63XGZ581SMsYh9aYn+yp6e18n1sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
	b=2gxaDYP9uhsMNouztBi2qtim72Y+jk2vIW33ax271XNfulXTslCp+eFCVzI+dmONhp5r
	 vwDoYnP4zHunc0Vv9zkRP/2MXGr/KPh5J7b/5vP2dB3j9E5Rf3Q9PNPw++jHNCZYdupZ5
	 l/jNdv7Z9p4FK2zL2x0F9wOJFGn7T4LMem7R9SbZVeXmUTiKk5lxvBgb4h9khND9vQH/Z
	 mPn61renlxtVo+JxjBlSttPooi6xGpbfbCweNw0/tbmkUyUALTDXip93JCU/3MKQiEWJO
	 FRsGbydVstx2fWZJ+uylTaevfS18hKXt+/5JDPL8sdIoXCf1kfUhS5vZ5+fSS4jHdTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398BE606A335
	for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 20:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 398BE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hnqDx80H
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e47347279so1838156f8f.1
        for <selinux@vger.kernel.org>; Mon, 16 Nov 2026 12:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859448; cv=none;
        d=google.com; s=arc-20260327;
        b=SPpD7IHrsHCLACzRsGNctQt0Uexcu7xyaYoqsEy/3hXBl7M/n5b4yc5lndr9937s3t
         dsTrRBMdcQF/JtPp7+EoGsYNI5lRSfmbQ3sGtjog8mPOAbUdGY7mppfzHdWVbnUZqMPW
         PoQLyWngTQtGdGrmb+y68Fw5gCwbdjrAttp2WkNx3JAK223pn4WPOrtyBdW7KUJAQpuj
         bt4iKfD2LFsF6/PK3pvoq8UJwwdLhGaNogZbjoQzolV7xE4EvIcpo9yl139MtqJ9g5Ow
         2IjVAWaAI8N8D5L6tKjw9b6q3OTV7+Ln3Gggp2hNMeZwEPFE8zSNyzgMz48BQuLYk9RU
         DeoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        fh=jfJDKNjCKoiPiI6CmC8dkjIdorLQjfaS3+UgPz0kY2I=;
        b=Iz9CNapFLrOmB83Wj9fjKIQmusk+DADXh2KqKsKYslpv8E7R+P9FpANf+7E339cDd7
         PpWONILXf1TkDT+IRWlZFXG4fqFEC4OD680A4up4hIHZ6/5Nik1aIxMzu0U2tzNJQZaN
         nVloEe2TLjg69ihZbLcQl8M0TRpQshv3Ot+NDhiP6ihs3Etk305AUhe4imBQNRRz2JSu
         LhEZqLyf8Fl718Co5k0tbAfNZ7ypEyYeEb+zObZSZQeEboAoU/9D9+pzf4001j/1mGKp
         9xszKROev+HHxPZhkvMqCk74bzZpV8FMFDARel+SQ+k9Z23V1PjkpwGzArYIBUegGZr5
         ldJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859448; x=1795464248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=hnqDx80H1BHGMZ+jCw863LQE2wm4hG6wTw//ziQNWkZpZIjdyNNCtFJNcbykSvuJWZ
         RrqgQGru9l+9Rlw9NCoAO7RXSeH6CHzRwb+h6TsbT77V+vTLtC7o5AslWzWJ8+7yhciq
         sbJxN7Yoz6y6VYO91QUyEDVlXVHt5e/uzOZriYhKEljZIduQH6pNfhdOY5sHlJFueOxf
         bN/uTLfuNBjnHaTZ+WukZQS/Wa30tWyiKsfqEPmOKtkcPCgN1gGIeLsa9pfco/3ZvP3P
         koo3Bb9/+esUnHdHS2hTd5qtXE/k/xctadMJUuU/zchcL0VDKvTRNofZgdIQ6mLOou9W
         X5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859448; x=1795464248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FEtpE65JhLGyAYaL/FOW2ebUIws2WwBZ/4Zy8VNXUuw=;
        b=eQk9SSnI8ChsDaMSF4OshLi5lCPyJ6N4xXpQy87RuEPHc6k00mg1wnFUWWEyY7HoLg
         qxjDpNjlngYycs4ToCzPG/XmNdbcDPmcqUVdJhd1NECZQel6guNvzfdpNU6n8VIEvYSg
         u4/vJzAhqhbdHj62Se45CjhlC4dgCC9hnfDG9BprVivK8DQ88k7AAb/0SY+ZWP3PvN+C
         ruXQPRSZ3CZGg5BoXraGriiGpJCWQL0jqCvyVLiCbBtMhF4gdwdm86BZxzjpRbHXDfoa
         PS8XtIjzFjLfpqhDkhTGniAVQ0I3v/HWi+RtUjzf/8BgshGeAzwI3XQ6q21p/Y+59N1m
         Y2UA==
X-Forwarded-Encrypted: i=1; AL+hErH5Tp6PmvzSaGdYHzxaQ3+iFvgIuFFWwJdIGXZ7a3LojvOsyh9z+lbO/ykoi+hPhuJZfuh7zy/2@vger.kernel.org
X-Gm-Message-State: APuU4Z/nwNiWy7zBVDEz0Tn0dO5esm4PFMjF8hNlez2CmLbRpsXUAPvR
	8FZhiyZOMYGovZBE4oSPTRfJ5jMLJ/TuhirM3XhptC2xuCudH+0udU4LzjvPhM6W5WEJPD3HMdD
	2fMa2rMUoJ9GIImZy3Spe6f4cnQgd2Co=
X-Gm-Gg: AZFdTZcRSui2BHM7baz37pQp0vcLc+hm/qXF5Q4hBRhvfw0PlR3DQRGMI2ynScVs0b4
	fNiS7wrvzFyK5SrCJZmjdWER1LfhB1d3mbbsxeQZKDkI1LFGV7q2LfojIuE7K54xKxST+U63heR
	Ps46ZGg0xvvL99ziINJ+wK2jZSKctzC6WE2d9I8ifdr4Odq9JCrNViPL8b7z0slKvuOpF6Gevbx
	o/TdYjNplgjjONTLPSRi8erbvbeq8QRFbaJ3GqDG5Dx73WFe5J5OtMttwBicwcx9cOKdp8xYJbt
	ARa26W3wToKC+GsRvDMG3U06Yk8t7c3P+5NG4cZKCwgpn7hmm7LCPmXVqn4etCXjPoTiVn8WF9F
	z1v+L8JwfhAkPNUehkztd6lW2S9RbxaZ/141Ey4hCD5srOdznVb35BQ7TkgI6N7fy3tmTTV8Uh5
	9YC6ooTbLQConCjdT1bts=
X-Received: by 2002:a05:6000:4692:b0:491:3fdd:af34 with SMTP id
 ffacd0b85a97d-49d61c80db3mr13343868f8f.36.1794859448335; Mon, 16 Nov 2026
 12:04:08 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org> <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-9-8cbbea1cf34f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:03:57 -0800
X-Gm-Features: Aa3M54q6P4M0RFDCKQ8HHGNCWJafItTSPdWR1qNwVGtToDAv2VOv8vDfWHzYR6A
Message-ID: <CAEf4BzbLFVawibuX0wk=8uzy0WZSYHbkgK55d7rqLab2qAM1Fg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 09/44] bpf: use fc_init_pseudo() for bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org, 
	Alexander Mikhalitsyn <alex@amutable.com>, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:21=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  kernel/bpf/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index c6f328e4752e1..57cf3775c0766 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -15,6 +15,7 @@
>  #include <linux/namei.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/fs_parser.h>
>  #include <linux/kdev_t.h>
>  #include <linux/filter.h>
> @@ -1197,8 +1198,6 @@ static int bpf_fill_super(struct super_block *sb, s=
truct fs_context *fc)
>         sb->s_magic =3D BPF_FS_MAGIC;
>         sb->s_op =3D &bpf_super_ops;
>         sb->s_xattr =3D bpf_fs_xattr_handlers;
> -       sb->s_iflags |=3D SB_I_NOEXEC;
> -       sb->s_iflags |=3D SB_I_NODEV;
>         sb->s_time_gran =3D 1;
>
>         inode =3D bpf_get_inode(sb, NULL, S_IFDIR | 0777);
> @@ -1261,6 +1260,7 @@ static int bpf_init_fs_context(struct fs_context *f=
c)
>         opts->delegate_attachs =3D 0;
>
>         fc->s_fs_info =3D opts;
> +       fc_init_pseudo(fc);
>         fc->ops =3D &bpf_context_ops;
>         return 0;
>  }
>
> --
> 2.53.0
>
>
