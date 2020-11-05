Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C9DC00A89
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7705720782
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 12:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZGCRbZKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgKEMoZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:44:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730445AbgKEMoX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 07:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604580262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VA8TAVEjtlH/OxvV0Hd16Z1cothVPf9Q8iEB0APAluQ=;
        b=ZGCRbZKLFuTXLpphxyzqOcpGlXl6eL+588NJkiijsP870tsqXRXputyBG/hGqkLyWTmNbc
        NeR+oRixqaLu0hFae6+LFxRE+zpKq/UWzgMYsgKuAUvHec6zzcW1CJzl8cDJLRXRcplPix
        aRl43CxxMJWvIgpI96bCE/pgpFRfHic=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-johubFdoNLyC7HehvJ6yWQ-1; Thu, 05 Nov 2020 07:44:20 -0500
X-MC-Unique: johubFdoNLyC7HehvJ6yWQ-1
Received: by mail-lf1-f69.google.com with SMTP id w79so601419lff.8
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 04:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VA8TAVEjtlH/OxvV0Hd16Z1cothVPf9Q8iEB0APAluQ=;
        b=RO64Wye25YPxkwA8mkFh86aRpzzIRoLB+/r3xMX+qjQGYlDJH96mo21m0Li+Hbfgz4
         qtztoEiUET025r0pNQbEpajP18SNacaj6kPx3Mdb2UHJ25xSvLscjNpej9QI6fQ665dX
         R2LwFCFZHlbMDzkQpTGdmVs67ecbqA7KbfReBlMJLHNECDtWyM9OvO5dMxV9X4UOMcx+
         7oEnLktaby21jOpxFEyfW+vSw5Il7dhnQ2rgpxFA3IcWhF1rwVMeK1JVMI9FgFs7Woib
         ySNslximnkyRGcPnecn6CRy7lKIGwiZLZKp8BJUwuYWHfMK+/XMi39LlCOlMHGlT4h5l
         XMAQ==
X-Gm-Message-State: AOAM5337EWnw2WimqJMYvHL0TURO7LBQcsC1VShyTW9y0/vlEIxselER
        JDWtADsuUzshgBpGgDbBvw644mykRzfU09QilGUKdpjB8rcvK76kzMU/RZkuhMhuJOtNd7y7yxR
        7t6QVErwfhB/tDHNTn4P9cRAjXJ3qzglvag==
X-Received: by 2002:a19:c786:: with SMTP id x128mr864353lff.478.1604580258645;
        Thu, 05 Nov 2020 04:44:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQLdZ2Fgm7W9ljx2JbVIwo5KiFfyMOWc2rke4Zi24SgtKZ2vxhC4tzm8Okqdw77EsuXk2NdYGSlKyfnKYg1iY=
X-Received: by 2002:a19:c786:: with SMTP id x128mr864348lff.478.1604580258441;
 Thu, 05 Nov 2020 04:44:18 -0800 (PST)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Nov 2020 13:44:07 +0100
Message-ID: <CAFqZXNvT=G4HPiugi6vnnJMGLgv5MsumURQij0cnFjLrnXZ93Q@mail.gmail.com>
Subject: Possibly unwanted rootcontext= behavior?
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello everyone,

while trying to fix the NFS rootcontext= issue, I realized that this
funny thing is possible:

# mount -o rootcontext=system_u:object_r:lib_t:s0 -t tmpfs tmpfs /mnt
# ls -lZd /mnt
drwxrwxrwt. 2 root root system_u:object_r:lib_t:s0 40 nov  5 07:30 /mnt
# mount
[...]
tmpfs on /mnt type tmpfs
(rw,relatime,rootcontext=system_u:object_r:lib_t:s0,seclabel)
# chcon -t bin_t /mnt
# ls -lZd /mnt
drwxrwxrwt. 2 root root system_u:object_r:bin_t:s0 40 nov  5 07:30 /mnt
# mount
[...]
tmpfs on /mnt type tmpfs
(rw,relatime,rootcontext=system_u:object_r:bin_t:s0,seclabel)

I.e. if you mount a tree with rootcontext=<oldctx> and then relabel
the root node to <newctx>, the displayed mount options will report
rootcontext=<newctx> instead of rootcontext=<oldctx>. A side effect is
that if you try to mount the same superblock again, it will only
permit you to mount with rootcontext=<newctx>, not with
rootcontext=<oldctx>.

Is that intended, bad, or "weird, but doesn't matter" behavior?

I have a halfway written patch to disallow altering the root node's
context when mounted with rootcontext=, but I'm not sure if that's the
right thing to do or not.

Thanks,

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

