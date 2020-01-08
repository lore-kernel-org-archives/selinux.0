Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EB4C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 13:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E56120720
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 13:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDiUGO91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgAHNeY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:34:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44270 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726254AbgAHNeY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 08:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578490463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5e6oDIjGPP+kpwliK6oWq5B6YoFGnXP3SInuWmvFNfw=;
        b=ZDiUGO91jMEedoY+WomVHaGrjSW7Hb4uNii9RopfF7a2FfWF4ksQjIlj2YayXCaXMwdkMz
        pZ/uzp8plZDWkAS6H5Qe5oF6kCi+8DmlEqJ3Xc5RbmrVBFSbb6e3hWxPjd8v00tJcEI8JC
        +QNybH41NFPpojNT+sRmsntZGVA11rM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-J5_4QejwM4ei64MJWyvw5g-1; Wed, 08 Jan 2020 08:34:22 -0500
X-MC-Unique: J5_4QejwM4ei64MJWyvw5g-1
Received: by mail-ot1-f72.google.com with SMTP id o14so1688107otp.4
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2020 05:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5e6oDIjGPP+kpwliK6oWq5B6YoFGnXP3SInuWmvFNfw=;
        b=Hnfd+Imt/Ek7D6tM+d88LaQPguJd+a/1payMVP7huF4TDvdEGcZpg+VnAW29rLaEmt
         ABox+agB8Emxb7oSqVlhSa+GaPL3tullngciKu6+byk429y2dcfl1BngFC/3+hZD/Irv
         yJ7T8UVJCN/ak+KZA8y+edF0hk3gf/HCXbPI2BhcqEup1Ij2RTbeHOQFUCsEyD2+lhlE
         7FZtHFcsj7sA8ZPOm/wyuySftIixFuzIklWVnw3mPfXkqMoQK8YHhqDfrpKnPlNjb/ms
         I+tMaHCOt+avxBojtBnTTmSrboE/ZaOvpvfNBkjsG4hf8dc0VvEpoOmUqnKmRfeyW3cb
         BG3g==
X-Gm-Message-State: APjAAAXBwogdeUidtZMl8nSIV3oUimbKJ6T74nPppv/W1Yx/tvU2xENY
        2ZnbnHtnpz59hWj0p6ErVDhbaImPkBpqfm1/xTQ06y5UnrTGTzzKhfNrv0JrRGpZDlLdrdfe/6f
        DMg+BvPcsTOWyv4BEZgGczht5pLpsLxprcA==
X-Received: by 2002:aca:4d4f:: with SMTP id a76mr3118387oib.26.1578490461318;
        Wed, 08 Jan 2020 05:34:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxnOy0QGTrvicuXhgXQ8pm7VwCFmN6pHvr+jSkbKvkxtiAwPQiVuhqMeLOBNNGi8oVW2PgbOUHgcLmmlX4lIxA=
X-Received: by 2002:aca:4d4f:: with SMTP id a76mr3118364oib.26.1578490460977;
 Wed, 08 Jan 2020 05:34:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJ2a_Ddz0dXzuhyyO_SNNZRc==8K7Nba0N6Rh_u+yig6c7w3tQ@mail.gmail.com>
 <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov>
In-Reply-To: <ed8c325b-f8e8-3e91-81cf-1db5c59e2bc0@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Jan 2020 14:34:09 +0100
Message-ID: <CAFqZXNtEubfR_HQFZyjG0A2vbHMkqe5jnvo7jVxCCZE_2QgR2A@mail.gmail.com>
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

On Wed, Dec 18, 2019 at 4:35 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/18/19 10:13 AM, Christian G=C3=B6ttsche wrote:
> > Hi,
> >
> > I am trying to refine contexts of sysfs.
> >
> > When using genfscon statements like:
> >      genfscon sysfs /  system_u:object_r:sysfs_t:s0
> >      genfscon sysfs /class/net  system_u:object_r:net_sysfs_t:s0
> >      genfscon sysfs /devices  system_u:object_r:generic_device_sysfs_t:=
s0
> >      genfscon sysfs /devices/system/cpu  system_u:object_r:cpu_sysfs_t:=
s0
> >      genfscon sysfs /devices/system/cpu/online
> > system_u:object_r:cpu_online_sysfs_t:s0
> >      genfscon sysfs /firmware  system_u:object_r:firmware_sysfs_t:s0
> >      genfscon sysfs /module/apparmor  system_u:object_r:apparmor_sysfs_=
t:s0
> >
> > and file context definitions like:
> >      /sys(/.*)?
> > gen_context(system_u:object_r:sysfs_t,s0)
> >      /sys/module/apparmor(/.*)?
> > gen_context(system_u:object_r:apparmor_sysfs_t,s0)
> >      /sys/devices/system/cpu(/.*)?
> > gen_context(system_u:object_r:cpu_sysfs_t,s0)
> >      /sys/devices/system/cpu/online          --
> > gen_context(system_u:object_r:cpu_online_sysfs_t,s0)
> >      /sys/firmware(/.*)?
> > gen_context(system_u:object_r:firmware_sysfs_t,s0)
> >      /sys/devices(/.*)?
> > gen_context(system_u:object_r:generic_device_sysfs_t,s0)
> >      /sys/devices/.*/sd[a-z](/.*)?
> > gen_context(system_u:object_r:harddrive_sysfs_t,s0)
> >      /sys/devices/.*/hwmon(/.*)?
> > gen_context(system_u:object_r:hwmon_sysfs_t,s0)
> >      /sys/class/net(/.*)?
> > gen_context(system_u:object_r:net_sysfs_t,s0)
> >      /sys/devices/.*/net(/.*)?
> > gen_context(system_u:object_r:net_sysfs_t,s0)
> >
> > with a systemd tmpfiles entry:
> >      #Type Path        Mode UID  GID  Age Argument
> >      Z     /sys        -    -    -    -   -
> >
> > I still get incorrect labeled entries after boot:
> >
> > $ restorecon -v -R -n /
> > Would relabel /sys/devices/platform/intel_rapl_msr.0/subsystem from
> > system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/0-0:AD1980/subsystem
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC=
0/device
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/controlC=
0/subsystem
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c=
/device
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D1c=
/subsystem
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c=
/device
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0c=
/subsystem
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/device
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/subsyste=
m
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p=
/device
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> > Would relabel /sys/devices/pci0000:00/0000:00:05.0/sound/card0/pcmC0D0p=
/subsystem
> > from system_u:object_r:sysfs_t:s0 to
> > system_u:object_r:generic_device_sysfs_t:s0
> >
> > Using auditallow statements reveals no accesses.
> >
> > How can I enforce these entries to be created with correct labels?
>
> kernel version? v5.2 introduced improved sysfs/kernfs support for
> inheritance of SELinux labels, circa commit
> e19dfdc83b60f196e0653d683499f7bc5548128f ("kernfs: initialize security
> of newly created nodes").

That's correct, since v5.2 the full-name genfs labeling will not work,
you will have to substitute these rules with filename type transitions
(or set the labels manually).

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

