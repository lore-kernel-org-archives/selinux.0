Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0E8C282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 16:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DC12072A
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 16:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ay2W0ksp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgAHQ01 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:26:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31919 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726670AbgAHQ00 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 11:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578500785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ddpVTAD5tuy4MlIaDNoskAOjyegZDTpKVfpc5WWwkFE=;
        b=Ay2W0ksp7A36l0XHJoJhf5OvpzsvEYy4pDjWH0uG52+JCCo8/SLrWm9A8AysqhNGhLwYG3
        MiQXtum78sCPzMw7f9Uao3z8IHcM9zbXRpsncLbFAoLqLrWYuMmixc8L4cIe7rCESagRo0
        i10/chjTUUPubSUzzPYiR3K/H7/uMmU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-qZI4xR6RNKq54y9HfQNUzg-1; Wed, 08 Jan 2020 11:26:22 -0500
X-MC-Unique: qZI4xR6RNKq54y9HfQNUzg-1
Received: by mail-oi1-f199.google.com with SMTP id e22so1891133oig.1
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2020 08:26:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddpVTAD5tuy4MlIaDNoskAOjyegZDTpKVfpc5WWwkFE=;
        b=g2ZLm8feWeoPJMsEvnDshmDB7cFcLz38ZpXlfZHOXuyHZCopE3Ov9otJT0/KFrXuMC
         U6o9ctgu6QauiTzyny9xOAupPrV1971mnm09crHQLadnjTS6RN07g0xCnvVJOzO0PfMl
         Ws3zF+cSYHCg35QoPakZwGHOc/hOKbfiyAKKubMgN/4WPZLNjVnKDSrEPUa1Qxapztda
         LukcaerdpN/wiLcTLszmBD/kVbMkaeABUvTcZtsRZn0aejCW14hx15i7In5S8TPUwY6+
         VbjrrRz9D2bPvne0hoOkCX1PtNcZZUJ7TFpbn5lYwdUXPaW+x+D70NdFcne/BRqO2J6V
         wWDg==
X-Gm-Message-State: APjAAAXprHsGM+EoOPnukNZOg2htAq0NVu7ipv6Z1x+6ME6tEaZpC+LV
        smN63h2aK9m31cZyfVyd03kqL5bO7yVlQ/NDlhC5qsGBJHiJ9/fSO2ARXen1XQv5khRuQ3kiQD1
        JuTeuRlo4MUWeu6SuvSFn4dN9dx6vUdozfA==
X-Received: by 2002:aca:f555:: with SMTP id t82mr3878616oih.103.1578500781865;
        Wed, 08 Jan 2020 08:26:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqRgVscu+P/QVaKXLsMxv0r5azm908Pj5Lsr1+KB8WuDakzUCM25V1vRSNbUP1YmLxyUBDVXqmUB15v1bijvE=
X-Received: by 2002:aca:f555:: with SMTP id t82mr3878595oih.103.1578500781606;
 Wed, 08 Jan 2020 08:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20200107202322.27380-1-sds@tycho.nsa.gov> <CAHC9VhRH9aPY8ehdA4JseYSMxSCh3zORcM=EnH-srA4qrvQhiw@mail.gmail.com>
 <a6397631-12b7-c6b9-d735-75151b31bf4b@tycho.nsa.gov>
In-Reply-To: <a6397631-12b7-c6b9-d735-75151b31bf4b@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Jan 2020 17:26:10 +0100
Message-ID: <CAFqZXNubWE9--yweD0rEJVkvYUXaDJDMV2o3S3j6crrWkf-ASA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: deprecate setting checkreqprot to 1
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 8, 2020 at 5:08 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/8/20 12:57 AM, Paul Moore wrote:
> > On Tue, Jan 7, 2020 at 3:22 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >>
> >> Deprecate setting the SELinux checkreqprot tunable to 1 via kernel
> >> parameter or /sys/fs/selinux/checkreqprot.  Setting it to 0 is left
> >> intact for compatibility since Android and some Linux distributions
> >> do so for security and treat an inability to set it as a fatal error.
> >> Eventually setting it to 0 will become a no-op and the kernel will
> >> stop using checkreqprot's value internally altogether.
> >>
> >> checkreqprot was originally introduced as a compatibility mechanism
> >> for legacy userspace and the READ_IMPLIES_EXEC personality flag.
> >> However, if set to 1, it weakens security by allowing mappings to be
> >> made executable without authorization by policy.  The default value
> >> for the SECURITY_SELINUX_CHECKREQPROT_VALUE config option was changed
> >> from 1 to 0 in commit 2a35d196c160e3 ("selinux: change
> >> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default") and both Android
> >> and Linux distributions began explicitly setting
> >> /sys/fs/selinux/checkreqprot to 0 some time ago.
> >>
> >> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> >> ---
> >> RFC-only, not yet tested.
> >>
> >>   Documentation/admin-guide/kernel-parameters.txt | 1 +
> >>   security/selinux/Kconfig                        | 3 +++
> >>   security/selinux/hooks.c                        | 4 ++++
> >>   security/selinux/selinuxfs.c                    | 6 ++++++
> >>   4 files changed, 14 insertions(+)
> >
> > No objection so long as the testing goes okay, although I don't think
> > we will see any surprises.
>
> Booting with this patch did produce one surprise; it logged a warning
> claiming that checkreqprot was set to 1 via kernel parameter on Fedora.
> This was incorrect; it is actually defaulted to 1 via kernel config on
> Fedora (Fedora kernel config still has
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1 at least in F31), so I
> moved the check to checkreqprot_setup() so that it will only log if
> explicitly set via kernel parameter.  Fedora is switching checkreqprot
> to 0 from systemd-tmpfiles via an entry in
> /usr/lib/tmpfiles.d/selinux-policy.conf, so at least it isn't left as 1
> after startup.

Interesting... should I send a PR to change the kernel config on
Fedora? Does anyone know why the
/usr/lib/tmpfiles.d/selinux-policy.conf approach was used instead of
just setting the kernel config option to 0? I assume the config option
just didn't exist yet back then?

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

