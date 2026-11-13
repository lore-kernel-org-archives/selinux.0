Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564161;
	b=piJMa76lVSymI4LMEpF7rZA28+W7dnxrIrg+wZjohFY64Ll6k3avgsN3ph5Fml8lBBCZ
	 1kS+zzMqW5AaXxWfTN7HTUHrhiNGU75R5P0IAjGmPtZswwdSGXLyfDQJV8cYUxu4Ax+4N
	 scRoLW8TV3InXW0voPM0OygKxrS0cTYFlVPkCdmn4/4VSI9u/ejyN6C+65hPgwniy5Sue
	 pxw15NcOSFyNTJhPaAu1HMkmLF7hv3Ya16gpPZKXf+u9KszrrBPDtEfr0GuBxk97IBj28
	 eVtzP4V28cGxvdthJXztyvjfHRCLy0KPyY4jotk3ONnVjeqJYZZ7nS9TtPhKEZ8p3vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
	b=jRy4FoIzsSr53kQV2SpmZAgdJg5RHPTr7vXK1D4OTQhBATmF78BNfAutZ8uk/mBPTJ86
	 3Q3IE2r6pVkE8axdwLtvZtVXu+oYelLXiS0Ow/oILK1VSQUr+eqRNxQW6zLH2YspYVLfx
	 y7aqZeuVvm8zWNjpAVu+1cWHj54HGk/MFPHCbtwrx0Tr4xYQ6x5GBD+NENsEaJVrlvlKm
	 HvnF3tEDQ7wLMpySBEFnWA5JG+QvYMBMXS3Jeykt0LTR/BtDg+Tx1Q0TcsEecCRu34q2v
	 HwR5Rf7C/H4OfmySRWFwqKCoLMtzxaZtRP5n4ZB/hwZQy8r0bJDEGz4L3eKowp3PR5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EgTTjz5w;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E7606A88E
	for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 10:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D51E7606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EgTTjz5w
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c49c32650adso135814466b.0
        for <selinux@vger.kernel.org>; Fri, 13 Nov 2026 02:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794564159; x=1795168959; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
        b=EgTTjz5wCJxsGLytKYZU81rQbAzYRel258q4rVhi5vK2xrQmQDal1yzp7Dtf678if6
         JjRQl+ZMXR5MwM/OWFtCjapsFpKPIJy4k0q9tv42ACCpenoDrYRhgwteGx9fsXnPo36A
         CmpJgecE0sejy6MR6tgTdtDQCHZyCNaM/wReBJem7BxQRTbXuUIxXx4ekm3/N1csmjzv
         gCoizy5cyPI1qWsTUdiFYdDS/1za3AmjDubKBZhhOvaszW7al+E0zABuX1J+7mV9GIsQ
         KNDYaQIAk2oxmRBvszTyhTc1FmwCZoCx7jL+YHG3X20//Nw1xxSADrBopi8MjhF9SAS0
         utQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794564159; x=1795168959;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8oHy35ptJ0fLQb2YrI1vdssfNtJpVRQvJ6BVJKFTHRg=;
        b=mfvWxNgdc1YyDFiszLFcusX4LFnwXgEhqj+sKIiA9dxp9QJyZIWRM0GQkJBPJSEeH1
         aC8RQkwhwsmcFY7fZcHQah7yQnQSRL7CGe6naVUPLWd0d6eBWW/qR5YUuHMms7Iac39u
         +7yGb7++gcktsw/igfd5U3N2ALmRMAPo9l4URQdFsKZHfHtqkEI3JBObvVVuDapswmxW
         d7+2rDq6suaRDFSIFUU75w3lr6nKFOr4S+R9PezkqEje4C0VQYOwDz648UrMb0Tv2gjh
         aAp5kzrwzJ6v3ltFqu1cvcJdKi70jHVgu7K1dDeKMOC7ibhX5Qw4hk6LiiYmljIqKguU
         vl/Q==
X-Forwarded-Encrypted: i=1; AL+hErGv6ECcaLC3mA7wTd1hw91AbRco06HbQirgyp/VhLB1jarIp0x98kE/kI5PNJ77unEVSnrblVSc@vger.kernel.org
X-Gm-Message-State: APuU4Z9ptLGtIA0k2W8pRTQP7iPXJxf7IZGxjkDcYeaplzpbENrzxSHV
	Lg1V0XYdv6EOT1zZVMgAb9ezqWnqJJ1+i4KzGvYlU/miuKGRy+z152S7IcNAQWF8fxj8
X-Gm-Gg: AYBFou2gwdzTqlRep+6CHzIyZxpJlt0YSmK3EO6GEP5f1mgOxZ7npgHH3aiVGv0ng1Y
	eIdnqU4xGX54HgyOzoH0jYjwzDxSYry0gEOk1jKUkMpqPEhItPq/bZNZGCKVM6LrhSCT4Z+zKkG
	2//Nu6u1/0/2uZkhgFV4eCiyrjWrKsdM5V11IRXepilw5CIdi9S97TrkJoP2X20b7kOlj+FFiUT
	bcTRqipUUgQ/kMhTf3C5OCn+SK52mdr7UGPYLvmaZOsDR264bHedhoLShVD4hdXMqlkrt2G9+/A
	pVFyEm1VUCKSH7LLWuOAqFOJMgsdyjQ9upMVCEuKdZCACSo6KwHEe3Nn7l7j+ey6d3KxLq5X7fM
	RwKoJGXVzFKfFkHkLVsZGJCNdlsr8PK5uVcylOZz9n0dS8n95dC6POyrMkQ5wE44bK5ppXEQXl+
	lSNoDO5DDhhobiiLRbeCj5+nScaYB3ZojO6u08x/LFZ4EafFKdrFc+rRN9e64QzFdwsQfAa3a6C
	9TwRjHw5pXvH8j/m76HoQgjP+FM2wn4DIC1dma7un/jGdlGq8Luy+IU9lMqT5k9v6ls4eatzT2L
	xH4l2p+V7wEY8cTkt7Hm6wOsYF12jFvz2aWb66ql2NlagAWZOefhgfuWCg8DHaw=
X-Received: by 2002:a17:907:7b93:b0:c29:f5d5:5a9c with SMTP id a640c23a62f3a-c509654de57mr163595166b.38.1794564159104;
        Fri, 13 Nov 2026 02:02:39 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b23afdsm74417566b.13.2026.11.13.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:02:38 -0800 (PST)
Message-ID: <8c51aa1ad231dea30af06ecf761a971f5958d063.camel@amutable.com>
Subject: Re: [PATCH RFC 05/41] kernfs: use fc_init_pseudo()
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
Date: Fri, 13 Nov 2026 11:02:36 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-5-4c998976c6c7@kernel.org>
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
> Initialize all kernfs based filesystems as pseudo filesystems in
> kernfs_get_tree() instead of raising SB_I_NOEXEC and SB_I_NODEV by
> hand
> in kernfs_fill_super(). This adds SB_I_PSEUDO for sysfs, cgroupfs and
> resctrl.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/kernfs/mount.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index a0be784bfb06..6b60d212b003 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -8,6 +8,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/fs.h>
> +#include <linux/pseudo_fs.h>
> =C2=A0#include <linux/mount.h>
> =C2=A0#include <linux/init.h>
> =C2=A0#include <linux/magic.h>
> @@ -298,8 +299,6 @@ static int kernfs_fill_super(struct super_block
> *sb, struct kernfs_fs_context *k
> =C2=A0	struct dentry *root;
> =C2=A0
> =C2=A0	info->sb =3D sb;
> -	/* Userspace would break if executables or devices appear on
> sysfs */
> -	sb->s_iflags |=3D SB_I_NOEXEC | SB_I_NODEV;
> =C2=A0	sb->s_blocksize =3D PAGE_SIZE;
> =C2=A0	sb->s_blocksize_bits =3D PAGE_SHIFT;
> =C2=A0	sb->s_magic =3D kfc->magic;
> @@ -388,6 +387,7 @@ int kernfs_get_tree(struct fs_context *fc)
> =C2=A0	info->ns =3D kfc->ns_tag;
> =C2=A0	INIT_LIST_HEAD(&info->node);
> =C2=A0
> +	fc_init_pseudo(fc);
> =C2=A0	fc->s_fs_info =3D info;
> =C2=A0	sb =3D sget_fc(fc, kernfs_test_super, kernfs_set_super);
> =C2=A0	if (IS_ERR(sb))
