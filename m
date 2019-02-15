Return-Path: <SRS0=IGSF=QW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EF9C43381
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361732190C
	for <selinux@archiver.kernel.org>; Fri, 15 Feb 2019 15:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbfBOPpz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:45:55 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46460 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfBOPpz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 Feb 2019 10:45:55 -0500
Received: by mail-ot1-f65.google.com with SMTP id w25so17121031otm.13
        for <selinux@vger.kernel.org>; Fri, 15 Feb 2019 07:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OiCgqlERhhojQuaFlWk/LlZgoAbDJtdNlcO0vs8HkM=;
        b=mSkE0E7mHCLb/UTjEWuwvC+fwcnkZ2Z3GI6l2tO2cFa1BIfWC0PrhNsUpdnYz76Swp
         aSaCU5HWx+fTjGzEDpCKYPAJvyaAYt1G7kn/BzYI5Tyn5KL/bGuEZDROvS82LHJyNTU1
         K+gUp5GaPSb3LootPAW/5D6iZ+v3HAmsgUyudKRcA/JEgKk9kEGPcr0qzpjirIkCdOoO
         D3fEsAs9J/YAcdY5+s/CZtj+77TdST89zjZTloR914GbRNcf1qY9ifaooyH/9EkRgiKN
         T0AsxIG01r1/pXRaQI4N7P1aEJdpp+09tgNooNbKobJeczVk0gxeREWKIuZ+19U0kEaF
         jKfQ==
X-Gm-Message-State: AHQUAubZVZLyvE8KlBz08X6rTDQv6IudnsooG+4fAgAu/bw8w/vJnswQ
        +BLVPh2L2k5gUTjOLEUqzlIo/rDbFLMLC6r1RB9VBg==
X-Google-Smtp-Source: AHgI3IZbTXM8UMmJZmoaY8bD89J2iU4YE3o8lshMkXFG+2DNiHqslsMAj8CiiHgaFw2Iz9v22GMpkz4nhKWpLK7KSjo=
X-Received: by 2002:a54:4f8f:: with SMTP id g15mr1009244oiy.166.1550245554986;
 Fri, 15 Feb 2019 07:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20190214095015.16032-1-omosnace@redhat.com> <20190214095015.16032-6-omosnace@redhat.com>
 <20190214154854.GO50184@devbig004.ftw2.facebook.com>
In-Reply-To: <20190214154854.GO50184@devbig004.ftw2.facebook.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 Feb 2019 16:45:44 +0100
Message-ID: <CAFqZXNuOg9ex_WqCCKYzPQSeqbGmo-KP4Yh9TB4bbMZziG314A@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] kernfs: initialize security of newly created nodes
To:     Tejun Heo <tj@kernel.org>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 14, 2019 at 4:49 PM Tejun Heo <tj@kernel.org> wrote:
> On Thu, Feb 14, 2019 at 10:50:15AM +0100, Ondrej Mosnacek wrote:
> > +static int kernfs_node_init_security(struct kernfs_node *parent,
> > +                                  struct kernfs_node *kn)
>
> Can we skip the whole thing if security is not enabled?

Do you mean just skipping the whole part when CONFIG_SECURITY=n? That
is easy to do and I can add it in the next respin (although the
compiler should be able to optimize most of it out in that case).

If you mean dynamically checking if calling the hook would actually do
anything (i.e. if any LSM actually registered that particular hook),
then that should also be possible (just check if
security_hook_heads.kernfs_init_security is a non-empty list), but I'm
not sure if that wouldn't be too hacky...

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
