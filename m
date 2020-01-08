Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8FC282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 15:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CA120692
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 15:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfybRHA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbgAHPUo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:20:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31917 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726556AbgAHPUo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 10:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578496842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WtTraUV1IdwND0btzRMeewGXfNtcpYLLCO7vUHGQjiA=;
        b=PfybRHA5wGKWFxDnMUAAEhQB8DRsie4kDAI5oABLn828od0vpWKyIL8VGk7r+vZtcvyUX0
        HRCKGaOhWpouB62OjxlISJQ4cqbpfEd/xEXq+7ppWT+LoJBx0TFOW6PxiteRIE8ZwvODXT
        goKKl+SIhD2OVSXswfbhLcCNWV4Ki0M=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-FaCJ8_krMQ-H3qbbtZoNPg-1; Wed, 08 Jan 2020 10:20:41 -0500
X-MC-Unique: FaCJ8_krMQ-H3qbbtZoNPg-1
Received: by mail-ot1-f72.google.com with SMTP id e11so1871705otq.1
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2020 07:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WtTraUV1IdwND0btzRMeewGXfNtcpYLLCO7vUHGQjiA=;
        b=NXJnZDqyxx3Gv+4JFSwe7oaFGMN6BDfJnSUQOpGAP0ZE8d9BHlFEStfk9woOaIbRta
         KTsJ035HBam5K5qGv99RHL6hAC4bNjAIcimA2a6vdZKQmdq1wi2C1qY9VOBmGYcFyhw1
         ptdDM8cDUVw4Bawyd8HUJUAgVFxtEUx8lX6lXZp7nwLPlP5CkKs56ki2ilJKfbCp4zVI
         ht3L374GNbEvojUxTiU5pQ4k6gZQsMvThsUmGsE0jNj5+2p7PtG/XvNdAa8Jh/FLWYcd
         ReHvtmaO8Cjh0lRnaz683pNNKIf+M3QuJlRUjumsrMT54KMqTh3VuQReOt+WaezPhHig
         7h7A==
X-Gm-Message-State: APjAAAX+Jc4vRd5sUkgBgDiXjH1fpR0EBmcQr8TPo1/8zb4gEwckKK4t
        vIFzrs5TJ0ja9j8dZy6tPIaTFDGeqEyqkgp3jghr2lKrgzYldha0xgHXngpoFrcY4sKyyS17oZ7
        R2C3XzD9c/9Bcsosgi+tb6DUyKzgMmhY6ug==
X-Received: by 2002:aca:4d4f:: with SMTP id a76mr3544033oib.26.1578496839541;
        Wed, 08 Jan 2020 07:20:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqztgRMmyUeM/WTyk+vus+jo8Hewq8/mMd69fvQwFsOXYCbCD3ShOV+EWJEMdgIpGK081wm+Ow7untk8x6lo8o4=
X-Received: by 2002:aca:4d4f:: with SMTP id a76mr3544011oib.26.1578496839199;
 Wed, 08 Jan 2020 07:20:39 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
 <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov> <CAFqZXNtEubfR_HQFZyjG0A2vbHMkqe5jnvo7jVxCCZE_2QgR2A@mail.gmail.com>
 <b2575c0d-afec-1631-ea19-a34bee688b34@tycho.nsa.gov>
In-Reply-To: <b2575c0d-afec-1631-ea19-a34bee688b34@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Jan 2020 16:20:28 +0100
Message-ID: <CAFqZXNtanJdhVuK=zO=R9dJ8kxz0tRRLsqhaRe=mEm3_03uaLQ@mail.gmail.com>
Subject: Re: incorrect sysfs contexts
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 8, 2020 at 4:04 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/8/20 8:34 AM, Ondrej Mosnacek wrote:
> > On Wed, Dec 18, 2019 at 4:35 PM Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
> >> On 12/18/19 10:13 AM, Christian G=C3=B6ttsche wrote:
> >>> Hi,
> >>>
> >>> I am trying to refine contexts of sysfs.
> >>>
> >>> When using genfscon statements like:
> >>>       genfscon sysfs /  system_u:object_r:sysfs_t:s0
> >>>       genfscon sysfs /class/net  system_u:object_r:net_sysfs_t:s0
> >>>       genfscon sysfs /devices  system_u:object_r:generic_device_sysfs=
_t:s0
> >>>       genfscon sysfs /devices/system/cpu  system_u:object_r:cpu_sysfs=
_t:s0
> >>>       genfscon sysfs /devices/system/cpu/online
> >>> system_u:object_r:cpu_online_sysfs_t:s0
> >>>       genfscon sysfs /firmware  system_u:object_r:firmware_sysfs_t:s0
> >>>       genfscon sysfs /module/apparmor  system_u:object_r:apparmor_sys=
fs_t:s0
> >>>
> >>> and file context definitions like:
> >>>       /sys(/.*)?
> >>> gen_context(system_u:object_r:sysfs_t,s0)
> >>>       /sys/module/apparmor(/.*)?
> >>> gen_context(system_u:object_r:apparmor_sysfs_t,s0)
> >>>       /sys/devices/system/cpu(/.*)?
> >>> gen_context(system_u:object_r:cpu_sysfs_t,s0)
> >>>       /sys/devices/system/cpu/online          --
> >>> gen_context(system_u:object_r:cpu_online_sysfs_t,s0)
> >>>       /sys/firmware(/.*)?
> >>> gen_context(system_u:object_r:firmware_sysfs_t,s0)
> >>>       /sys/devices(/.*)?
> >>> gen_context(system_u:object_r:generic_device_sysfs_t,s0)
> >>>       /sys/devices/.*/sd[a-z](/.*)?
> >>> gen_context(system_u:object_r:harddrive_sysfs_t,s0)
> >>>       /sys/devices/.*/hwmon(/.*)?
> >>> gen_context(system_u:object_r:hwmon_sysfs_t,s0)
> >>>       /sys/class/net(/.*)?
> >>> gen_context(system_u:object_r:net_sysfs_t,s0)
> >>>       /sys/devices/.*/net(/.*)?
> >>> gen_context(system_u:object_r:net_sysfs_t,s0)
> >>>
> >>> with a systemd tmpfiles entry:
> >>>       #Type Path        Mode UID  GID  Age Argument
> >>>       Z     /sys        -    -    -    -   -
> >>>
> >>> I still get incorrect labeled entries after boot:
> >>>
> >>> $ restorecon -v -R -n /
> >>> Would relabel /sys/devices/platform/intel_rapl_msr.0/subsystem from
> >>> system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/0-0:AD1980/subsyst=
em
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/contro=
lC0/device
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/contro=
lC0/subsystem
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D=
1c/device
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D=
1c/subsystem
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D=
0c/device
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D=
0c/subsystem
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/device
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/subsys=
tem
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D=
0p/device
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>> Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D=
0p/subsystem
> >>> from system_u:object_r:sysfs_t:s0 to
> >>> system_u:object_r:generic_device_sysfs_t:s0
> >>>
> >>> Using auditallow statements reveals no accesses.
> >>>
> >>> How can I enforce these entries to be created with correct labels?
> >>
> >> kernel version? v5.2 introduced improved sysfs/kernfs support for
> >> inheritance of SELinux labels, circa commit
> >> e19dfdc83b60f196e0653d683499f7bc5548128f ("kernfs: initialize security
> >> of newly created nodes").
> >
> > That's correct, since v5.2 the full-name genfs labeling will not work,
> > you will have to substitute these rules with filename type transitions
> > (or set the labels manually).
>
> Wait...is that really true?  If so, that's a kernel-userspace interface
> regression, which isn't permitted.  New kernel with old policy must
> continue to provide the same behavior. Android certainly relies upon
> extensive labeling of sysfs nodes.

Wait... actually I think it should work. I thought for a while that
the xattr would be updated if a node's attribute would differ from its
parent's, but that's not how the kernfs hook works. It will only
explicitly change a child's xattr context if the parent's one has been
explicitly set (which can usually be done only upon a request from
userspace). Sorry for the false alarm.

Looking at the restorecon output above it looks like all the
mislabeled files are symlinks, so this is likely also caused by the
S_ISLNK() exception.

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

