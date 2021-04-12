Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB5C433B4
	for <selinux@archiver.kernel.org>; Mon, 12 Apr 2021 16:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60FA6137C
	for <selinux@archiver.kernel.org>; Mon, 12 Apr 2021 16:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243877AbhDLQZX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Apr 2021 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243858AbhDLQYe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Apr 2021 12:24:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E25C061347
        for <selinux@vger.kernel.org>; Mon, 12 Apr 2021 09:24:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j18so22392377lfg.5
        for <selinux@vger.kernel.org>; Mon, 12 Apr 2021 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ueR+bzUQyBJ6Gmj9fHXIfDenKkhbJd11CuntNjq4ue8=;
        b=Al2PuI8Jtpzy/NwLxwtBoFYmkJnS/LiklYzPs1W31opZKivVBizLwtQrhvdcCOzNgl
         iFR4SpalKqJenVbjbDxeUakPBfXOWawua9ad3aoLoJ6u71vmqNsjc2z07HewEM5RCZnE
         537Yq4lD1OJ7BIDIr0AJhjMl3v314MH/ZEs9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ueR+bzUQyBJ6Gmj9fHXIfDenKkhbJd11CuntNjq4ue8=;
        b=MgQxic3dJVvtMdsWM8Y1HFnmq8F4DC+oMoyGWF2f3BcMItnRgjzzZmggGtgYxKFbE4
         9/CyR8yRKefpgTySRwKcQNAQenjZmJJvSUwOCeYRfsiC2f3M1lhYuB4wDnwGkTSuaQX7
         GuNMKxyAiHCjziqvXgNNH2OOvxUzJ9iuUI/BeN2MGZWWM/veM6f8Wqo87Eq8jgsnv3Qx
         +CByznSvtkY7NYB9J7J9fHM4yY6YdpnuB1PxIfnTDL1wTvCnA3FbQdWpoZBAW0ha4IO3
         YyiSm7w7DTDPYhP7LuLUOnMCWuPYSzNvLXvghiMdSBrPcZ35Ekc/jpfR5S6Ai6q8sWrz
         l3TQ==
X-Gm-Message-State: AOAM532gStdUGMGL/7rbJ5I9/EPwoW+6CwT4UTr4T5H9mWr7fR5mLWmM
        1kosxki4gUnjK8TN3hpTacNdiDHaHKpbZO43
X-Google-Smtp-Source: ABdhPJzW0DS7ji0Jg8XCK656BItdF+ZeE263L+yrdsG8gvGASKdXbnzPxDN/D2VwvZ4my5gRm/PbZg==
X-Received: by 2002:a05:6512:39d5:: with SMTP id k21mr9734406lfu.365.1618244647011;
        Mon, 12 Apr 2021 09:24:07 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x1sm1360346ljm.127.2021.04.12.09.24.05
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 09:24:06 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a36so5231787ljq.8
        for <selinux@vger.kernel.org>; Mon, 12 Apr 2021 09:24:05 -0700 (PDT)
X-Received: by 2002:a05:6512:31c7:: with SMTP id j7mr10731751lfe.41.1618244634563;
 Mon, 12 Apr 2021 09:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <E901E25F-41FA-444D-B3C7-A7A786DDD5D5@tuxera.com>
In-Reply-To: <E901E25F-41FA-444D-B3C7-A7A786DDD5D5@tuxera.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Apr 2021 09:23:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXqbSgqzv53C98sbaHVqpc+c8NZTpXC7bBMQT3OznE4g@mail.gmail.com>
Message-ID: <CAHk-=wiXqbSgqzv53C98sbaHVqpc+c8NZTpXC7bBMQT3OznE4g@mail.gmail.com>
Subject: Re: [PATCH v6 24/40] fs: make helpers idmap mount aware
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "alban@kinvolk.io" <alban@kinvolk.io>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "geofft@ldpreload.com" <geofft@ldpreload.com>,
        "hch@lst.de" <hch@lst.de>,
        "hirofumi@mail.parknet.co.jp" <hirofumi@mail.parknet.co.jp>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "lennart@poettering.net" <lennart@poettering.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mpatel@redhat.com" <mpatel@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "seth.forshee@canonical.com" <seth.forshee@canonical.com>,
        "smbarber@chromium.org" <smbarber@chromium.org>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "tkjos@google.com" <tkjos@google.com>,
        "tycho@tycho.ws" <tycho@tycho.ws>, "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 12, 2021 at 5:05 AM Anton Altaparmakov <anton@tuxera.com> wrote:
>
> Shouldn't that be using mnt_userns instead of &init_user_ns both for the setattr_prepare() and setattr_copy() calls?

It doesn't matter for a filesystem that hasn't marked itself as
supporting idmaps.

If the filesystem doesn't set FS_ALLOW_IDMAP, then mnt_userns is
always going to be &init_user_ns.

That said, I don't think you are wrong - it would probably be a good
idea to pass down the 'mnt_userns' argument just to avoid confusion.
But if you look at the history, you'll see that adding the mount
namespace argument to the helper functions (like setattr_copy())
happened before the actual "switch the filesystem setattr() function
over to get the namespace argument".

So the current situation is partly an artifact of how the incremental
filesystem changes were done.

           Linus
