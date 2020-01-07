Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39407C282DD
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 19:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15047206DB
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 19:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgAGTqL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:46:11 -0500
Received: from namei.org ([65.99.196.166]:55800 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgAGTqL (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 7 Jan 2020 14:46:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 007JjhWJ000801;
        Tue, 7 Jan 2020 19:45:43 GMT
Date:   Wed, 8 Jan 2020 06:45:43 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH 1/2] selinux: treat atomic flags more carefully
In-Reply-To: <20200107133154.588958-2-omosnace@redhat.com>
Message-ID: <alpine.LRH.2.21.2001080644500.575@namei.org>
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-2-omosnace@redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 7 Jan 2020, Ondrej Mosnacek wrote:

> The disabled/enforcing/initialized flags are all accessed concurrently
> by threads so use the appropriate accessors that ensure atomicity and
> document that it is expected.
> 
> Use smp_load/acquire...() helpers (with memory barriers) for the
> initialized flag, since it gates access to the rest of the state
> structures.
> 
> Note that the disabled flag is currently not used for anything other
> than avoiding double disable, but it will be used for bailing out of
> hooks once security_delete_hooks() is removed.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>

-- 
James Morris
<jmorris@namei.org>

