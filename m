Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGJr1Ue2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743DF10CF
	for <selinux@vger.kernel.org>; Fri,  8 Dec 2023 03:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702033545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEBKpJYqxW8UjGQ7HIELfDYiMjiMUmcOCnzzcYiYRUs=;
	b=AGJr1Ue29os4ZJTNg7diEqgXqOBxSDyT0g1kTXBOmt9H69erzItPruSIkRRyASY4N1oAxw
	UCeKaNfGBUH4A0ZeyB9RVs7ClDHp6kTsDF1aN+K8nXt+wDu4uG/1m3X7CFVYOOKN+1ST+7
	vgsEn0Etgiz+h5fTiDz2hqITF3zTvAc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-MCLggH2QNR-uzKf5u0dd4w-1; Fri, 08 Dec 2023 06:05:44 -0500
X-MC-Unique: MCLggH2QNR-uzKf5u0dd4w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1f6c9e3296so19171066b.1
        for <selinux@vger.kernel.org>; Fri, 08 Dec 2023 03:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033543; x=1702638343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEBKpJYqxW8UjGQ7HIELfDYiMjiMUmcOCnzzcYiYRUs=;
        b=XgtxcgRl5hMYwvij9ZfKaC5ggMoaPXsVeuldCvVURrHXDm4HYxf274+YFOWaHYVFM0
         J09kS5h/CPKaHz6/BjF2p5hNWPMw6yR3r+Xl5Si6CoVn0jXrTvA404GxoKzB+Hjbm8Dc
         yvzibPGbMLglIqpbwG4tlm51+ML+aFdL32aI5WkPxXuJIvwx7JbrIx2Y47ZViW71OVcU
         8ICKpS5nVXli87aHfqdEndMlObjP+5blQP2T24/Ci84eUtfdrRIQZO22OMerzSJIK3UE
         y/z6VT9IoL1raR5Rp2OZAT21fJ8lc1JZt76CU7ELeBL+kCu9fPYPgyrUcqs8uKBo2FzT
         6MSg==
X-Gm-Message-State: AOJu0YwQecJ3tAK6cq+MvyK31xdL4v8eo8bH7fakK6nOUrmoyCyL/5a4
	mq+dq+i6VBIh0bkp5KjMjjtWkS07WH0wbF5VJ4itX8oJzRKxT+pKGOaSNDxbRYbCoPDIoJZU09f
	VUi4jw7OvALA52rLWsA==
X-Received: by 2002:a17:907:cc1c:b0:a18:615c:66ff with SMTP id uo28-20020a170907cc1c00b00a18615c66ffmr2236538ejc.49.1702033543052;
        Fri, 08 Dec 2023 03:05:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIijvUa4+2E/7EJdCIaJ1WuZlxokZoLm8uGigz+PJg5T3e6lKgS9bQTVnMVoUzmvlqJiyJQw==
X-Received: by 2002:a17:907:cc1c:b0:a18:615c:66ff with SMTP id uo28-20020a170907cc1c00b00a18615c66ffmr2236512ejc.49.1702033542526;
        Fri, 08 Dec 2023 03:05:42 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:7466:b10d:58c8:869f:7e91])
        by smtp.gmail.com with ESMTPSA id vi8-20020a170907d40800b00a1c7b20e9e6sm870626ejc.32.2023.12.08.03.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 03:05:41 -0800 (PST)
Date: Fri, 8 Dec 2023 06:05:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, jmorris@namei.org, serge@hallyn.com,
	stephen.smalley.work@gmail.com, eparis@parisplace.org,
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
Message-ID: <20231208060249-mutt-send-email-mst@kernel.org>
References: <20231020155819.24000-5-maxime.coquelin@redhat.com>
 <2b8269b7c58ebf9b260b4e2a0676bc22.paul@paul-moore.com>
 <8ec2ae21-603d-4ce1-944b-09e042751806@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ec2ae21-603d-4ce1-944b-09e042751806@redhat.com>

On Fri, Dec 08, 2023 at 12:01:15PM +0100, Maxime Coquelin wrote:
> Hello Paul,
> 
> On 11/8/23 03:31, Paul Moore wrote:
> > On Oct 20, 2023 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > 
> > > This patch introduces LSM hooks for devices creation,
> > > destruction and opening operations, checking the
> > > application is allowed to perform these operations for
> > > the Virtio device type.
> > > 
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > ---
> > >   drivers/vdpa/vdpa_user/vduse_dev.c  | 12 +++++++
> > >   include/linux/lsm_hook_defs.h       |  4 +++
> > >   include/linux/security.h            | 15 ++++++++
> > >   security/security.c                 | 42 ++++++++++++++++++++++
> > >   security/selinux/hooks.c            | 55 +++++++++++++++++++++++++++++
> > >   security/selinux/include/classmap.h |  2 ++
> > >   6 files changed, 130 insertions(+)
> > 
> > My apologies for the late reply, I've been trying to work my way through
> > the review backlog but it has been taking longer than expected; comments
> > below ...
> 
> No worries, I have also been busy these days.
> 
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 2aa0e219d721..65d9262a37f7 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -21,6 +21,7 @@
> > >    *  Copyright (C) 2016 Mellanox Technologies
> > >    */
> > > +#include "av_permissions.h"
> > >   #include <linux/init.h>
> > >   #include <linux/kd.h>
> > >   #include <linux/kernel.h>
> > > @@ -92,6 +93,7 @@
> > >   #include <linux/fsnotify.h>
> > >   #include <linux/fanotify.h>
> > >   #include <linux/io_uring.h>
> > > +#include <uapi/linux/virtio_ids.h>
> > >   #include "avc.h"
> > >   #include "objsec.h"
> > > @@ -6950,6 +6952,56 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
> > >   }
> > >   #endif /* CONFIG_IO_URING */
> > > +static int vduse_check_device_type(u32 sid, u32 device_id)
> > > +{
> > > +	u32 requested;
> > > +
> > > +	if (device_id == VIRTIO_ID_NET)
> > > +		requested = VDUSE__NET;
> > > +	else if (device_id == VIRTIO_ID_BLOCK)
> > > +		requested = VDUSE__BLOCK;
> > > +	else
> > > +		return -EINVAL;
> > > +
> > > +	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested, NULL);
> > > +}
> > > +
> > > +static int selinux_vduse_dev_create(u32 device_id)
> > > +{
> > > +	u32 sid = current_sid();
> > > +	int ret;
> > > +
> > > +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVCREATE, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return vduse_check_device_type(sid, device_id);
> > > +}
> > 
> > I see there has been some discussion about the need for a dedicated
> > create hook as opposed to using the existing ioctl controls.  I think
> > one important point that has been missing from the discussion is the
> > idea of labeling the newly created device.  Unfortunately prior to a
> > few minutes ago I hadn't ever looked at VDUSE so please correct me if
> > I get some things wrong :)
> > 
> >  From what I can see userspace creates a new VDUSE device with
> > ioctl(VDUSE_CREATE_DEV), which trigger the creation of a new
> > /dev/vduse/XXX device which will be labeled according to the udev
> > and SELinux configuration, likely with a generic udev label.  My
> > question is if we want to be able to uniquely label each VDUSE
> > device based on the process that initiates the device creation
> > with the call to ioctl()?  If that is the case, we would need a
> > create hook not only to control the creation of the device, but to
> > record the triggering process' label in the new device; this label
> > would then be used in subsequent VDUSE open and destroy operations.
> > The normal device file I/O operations would still be subject to the
> > standard SELinux file I/O permissions using the device file label
> > assigned by systemd/udev when the device was created.
> 
> I don't think we need a unique label for VDUSE devices, but maybe
> Michael thinks otherwise?

I don't know.
All this is consumed by libvirt, you need to ask these guys.


> > 
> > > +static int selinux_vduse_dev_destroy(u32 device_id)
> > > +{
> > > +	u32 sid = current_sid();
> > > +	int ret;
> > > +
> > > +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVDESTROY, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return vduse_check_device_type(sid, device_id);
> > > +}
> > > +
> > > +static int selinux_vduse_dev_open(u32 device_id)
> > > +{
> > > +	u32 sid = current_sid();
> > > +	int ret;
> > > +
> > > +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVOPEN, NULL);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return vduse_check_device_type(sid, device_id);
> > > +}
> > > +
> > >   /*
> > >    * IMPORTANT NOTE: When adding new hooks, please be careful to keep this order:
> > >    * 1. any hooks that don't belong to (2.) or (3.) below,
> > > @@ -7243,6 +7295,9 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
> > >   #ifdef CONFIG_PERF_EVENTS
> > >   	LSM_HOOK_INIT(perf_event_alloc, selinux_perf_event_alloc),
> > >   #endif
> > > +	LSM_HOOK_INIT(vduse_dev_create, selinux_vduse_dev_create),
> > > +	LSM_HOOK_INIT(vduse_dev_destroy, selinux_vduse_dev_destroy),
> > > +	LSM_HOOK_INIT(vduse_dev_open, selinux_vduse_dev_open),
> > >   };
> > >   static __init int selinux_init(void)
> > > diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> > > index a3c380775d41..d3dc37fb03d4 100644
> > > --- a/security/selinux/include/classmap.h
> > > +++ b/security/selinux/include/classmap.h
> > > @@ -256,6 +256,8 @@ const struct security_class_mapping secclass_map[] = {
> > >   	  { "override_creds", "sqpoll", "cmd", NULL } },
> > >   	{ "user_namespace",
> > >   	  { "create", NULL } },
> > > +	{ "vduse",
> > > +	  { "devcreate", "devdestroy", "devopen", "net", "block", NULL} },
> > 
> > I think we can just call the permissions "create", "open", and "destroy"
> > since the "dev" prefix is somewhat implied by this being a dedicated
> > VDUSE object class.
> 
> Ack, I can remove the "dev" prefix in next revision.
> 
> > 
> > I don't see where you are using the "net" and "block" permissions above,
> > is this a leftover from a prior draft of this patch or are you planning
> > to do something with these permissions?
> 
> It is actually used, but maybe not in a correct way.
> If you look at each hook, there are two checks performed:
> 1. Check for the operation type: create/destroy/open
> 2. Check for the device type: block/net
> 
> It means that the application will have to combine one (or more)
> operation type with one (or more) device type.
> 
> Does that make sense?
> 
> Thanks,
> Maxime
> 
> > 
> > >   	{ NULL }
> > >     };
> > > -- 
> > > 2.41.0
> > 
> > --
> > paul-moore.com
> > 

