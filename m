Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZqw1IWu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC62098
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 20:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702443178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAdbgfQ0YuZV7i44ECJUKgzL+mbD9IwwoDZYX761XnQ=;
	b=OZqw1IWu56QaLdLHESZ3cP3XzEtLDNyZizUMJI+cyISzrU5FdFKOnrVxi6PobapNhL02A/
	bk2rwYF9GHoBjpOABB4z7XcgZNDdGGW0QfmnZlyBF2ZH5JQ0iFJk5yEp4Wnmo5jueO/yaX
	xl7M5gR4NbKe13TPCt3bcWn6QBF2ZFo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-U9VGTb6iNPW1YjPanekgUQ-1; Tue, 12 Dec 2023 23:52:52 -0500
X-MC-Unique: U9VGTb6iNPW1YjPanekgUQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-58d0c968357so8062626eaf.1
        for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 20:52:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702443171; x=1703047971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAdbgfQ0YuZV7i44ECJUKgzL+mbD9IwwoDZYX761XnQ=;
        b=kboEts9xlyQLt/wBik1QuQauT3Q1D74OnaG5ndhZquZodXtOciycNCQZ78nC2pgsY8
         Ikt0/8a+L4zsRC8qRYiN5j9Q7NnapicEC80FDiDAnmF+Zs+5Aptipnlqq31TQYxSzH3V
         vPHegmGbVaG95K/V7gAoaPMRlH+w3Qoj4H+lAUgZ3Lq6nC8BWfCkvr8r8c21glelZeCT
         PxexR3OL/V7DtZeWCSHTX1wCEFbCf0/+akmna2CW4KWIZA66bIhBRdI2TOboXlbD4EZb
         d5yY/Kp++RMIOo0HXVfgd6I/MLYXyxnCVUZsQg4ySi9xHwcGlbeG9Pus0zLbcchwAIqn
         wuuQ==
X-Gm-Message-State: AOJu0YxuCjTSowK5YFIKMhyfaJ04N7SX069/sbr7zYLK1zLF11TSL+K5
	sAVOccZQYItoBcW02XCQAtmuV4rXKycI/RUcysIx0sUVtHrFfuxnsNfkXk1N2uv9aUxfxzArkwc
	k0DF3HBfLO1BOm5IPRN/aYveSTNsACe/QYg==
X-Received: by 2002:a05:6358:d3a0:b0:170:678:cb49 with SMTP id mp32-20020a056358d3a000b001700678cb49mr8194746rwb.26.1702443171186;
        Tue, 12 Dec 2023 20:52:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0buKfWzxWPThUdmlqXSXHZqhajudkEjo3BQXuLk358qKXlhNq9vU1NFeJV5laPGU8AcCftT6g3/50CeQJ8Do=
X-Received: by 2002:a05:6358:d3a0:b0:170:678:cb49 with SMTP id
 mp32-20020a056358d3a000b001700678cb49mr8194734rwb.26.1702443170887; Tue, 12
 Dec 2023 20:52:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com> <20231212131712.1816324-3-maxime.coquelin@redhat.com>
In-Reply-To: <20231212131712.1816324-3-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 13 Dec 2023 12:52:39 +0800
Message-ID: <CACGkMEthp13a20TGashiFNDovK+b10mgfdX8L=3Xv05g5-eo0w@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] vduse: Temporarily disable control queue features
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	eparis@parisplace.org, xieyongji@bytedance.com, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	david.marchand@redhat.com, lulu@redhat.com, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:17=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> Virtio-net driver control queue implementation is not safe
> when used with VDUSE. If the VDUSE application does not
> reply to control queue messages, it currently ends up
> hanging the kernel thread sending this command.
>
> Some work is on-going to make the control queue
> implementation robust with VDUSE. Until it is completed,
> let's disable control virtqueue and features that depend on
> it.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

I wonder if it's better to fail instead of a mask as a start.

Thanks

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 0486ff672408..fe4b5c8203fd 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -28,6 +28,7 @@
>  #include <uapi/linux/virtio_config.h>
>  #include <uapi/linux/virtio_ids.h>
>  #include <uapi/linux/virtio_blk.h>
> +#include <uapi/linux/virtio_ring.h>
>  #include <linux/mod_devicetable.h>
>
>  #include "iova_domain.h"
> @@ -46,6 +47,30 @@
>
>  #define IRQ_UNBOUND -1
>
> +#define VDUSE_NET_VALID_FEATURES_MASK           \
> +       (BIT_ULL(VIRTIO_NET_F_CSUM) |           \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |     \
> +        BIT_ULL(VIRTIO_NET_F_MTU) |            \
> +        BIT_ULL(VIRTIO_NET_F_MAC) |            \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |     \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |     \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |      \
> +        BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |      \
> +        BIT_ULL(VIRTIO_NET_F_HOST_ECN) |       \
> +        BIT_ULL(VIRTIO_NET_F_HOST_UFO) |       \
> +        BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |      \
> +        BIT_ULL(VIRTIO_NET_F_STATUS) |         \
> +        BIT_ULL(VIRTIO_NET_F_HOST_USO) |       \
> +        BIT_ULL(VIRTIO_F_ANY_LAYOUT) |         \
> +        BIT_ULL(VIRTIO_RING_F_INDIRECT_DESC) | \
> +        BIT_ULL(VIRTIO_RING_F_EVENT_IDX) |          \
> +        BIT_ULL(VIRTIO_F_VERSION_1) |          \
> +        BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |     \
> +        BIT_ULL(VIRTIO_F_RING_PACKED) |        \
> +        BIT_ULL(VIRTIO_F_IN_ORDER))
> +
>  struct vduse_virtqueue {
>         u16 index;
>         u16 num_max;
> @@ -1782,6 +1807,16 @@ static struct attribute *vduse_dev_attrs[] =3D {
>
>  ATTRIBUTE_GROUPS(vduse_dev);
>
> +static void vduse_dev_features_filter(struct vduse_dev_config *config)
> +{
> +       /*
> +        * Temporarily filter out virtio-net's control virtqueue and feat=
ures
> +        * that depend on it while CVQ is being made more robust for VDUS=
E.
> +        */
> +       if (config->device_id =3D=3D VIRTIO_ID_NET)
> +               config->features &=3D VDUSE_NET_VALID_FEATURES_MASK;
> +}
> +
>  static int vduse_create_dev(struct vduse_dev_config *config,
>                             void *config_buf, u64 api_version)
>  {
> @@ -1797,6 +1832,8 @@ static int vduse_create_dev(struct vduse_dev_config=
 *config,
>         if (!dev)
>                 goto err;
>
> +       vduse_dev_features_filter(config);
> +
>         dev->api_version =3D api_version;
>         dev->device_features =3D config->features;
>         dev->device_id =3D config->device_id;
> --
> 2.43.0
>

