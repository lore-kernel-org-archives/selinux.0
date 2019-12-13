Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF7EC7E0BF
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342C424718
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfLMStT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:49:19 -0500
Received: from namei.org ([65.99.196.166]:37392 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfLMStS (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 13 Dec 2019 13:49:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xBDImkv5010187;
        Fri, 13 Dec 2019 18:48:46 GMT
Date:   Sat, 14 Dec 2019 05:48:46 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
In-Reply-To: <CAFqZXNv=AnPxHuQCusoJQGEJ8Q+yF7_TPBCRyAcE5OPzoYFc9w@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1912140547490.9693@namei.org>
References: <20191211140833.939845-1-omosnace@redhat.com> <66706222-b6af-5099-e485-b99391ad70b3@i-love.sakura.ne.jp> <CAFqZXNv=AnPxHuQCusoJQGEJ8Q+yF7_TPBCRyAcE5OPzoYFc9w@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 12 Dec 2019, Ondrej Mosnacek wrote:

> I'd say the burden of implementing this would lie on the arms of
> whoever prepares the patches for dynamic load/unload.

Correct, and I don't see any such patches being accepted.

Go and look at some exploits, where LSM is used as a rootkit API...


-- 
James Morris
<jmorris@namei.org>

