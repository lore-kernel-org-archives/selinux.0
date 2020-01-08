Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2499DC282DD
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 18:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F2B2067D
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 18:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgAHSsE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:48:04 -0500
Received: from namei.org ([65.99.196.166]:56228 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbgAHSsE (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Jan 2020 13:48:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 008IllBQ028558;
        Wed, 8 Jan 2020 18:47:47 GMT
Date:   Thu, 9 Jan 2020 05:47:47 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH 2/2] security,selinux: get rid of
 security_delete_hooks()
In-Reply-To: <CAFqZXNvbNqrTJWxdQU4P-7O-kLRcGW+QcL7LY5Ca8rULLm2ScA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2001090547340.27794@namei.org>
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-3-omosnace@redhat.com> <alpine.LRH.2.21.2001080653220.575@namei.org> <CAFqZXNvbNqrTJWxdQU4P-7O-kLRcGW+QcL7LY5Ca8rULLm2ScA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 8 Jan 2020, Ondrej Mosnacek wrote:

> > >  {
> > >       const struct cred *cred = current_cred();
> > >       struct superblock_security_struct *sbsec = sb->s_security;
> > > -     struct dentry *root = sbsec->sb->s_root;
> > >       struct selinux_mnt_opts *opts = mnt_opts;
> >
> > Seems like there are a bunch of unrelated cleanups mixed in here.
> 
> These are not unrelated - we need to avoid dereferencing the security
> structs before checking selinux_disabled(), because they may be NULL
> or uninitialized when SELinux has been diabled.

Ok.

-- 
James Morris
<jmorris@namei.org>

