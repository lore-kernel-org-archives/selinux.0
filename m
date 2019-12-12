Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16839C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 10:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BB4206DA
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 10:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfLLKbB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:31:01 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:55038 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfLLKbB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 05:31:01 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBCAUxo3016466;
        Thu, 12 Dec 2019 19:30:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Thu, 12 Dec 2019 19:30:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBCAUssV016407
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 12 Dec 2019 19:30:59 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>
References: <20191211140833.939845-1-omosnace@redhat.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <66706222-b6af-5099-e485-b99391ad70b3@i-love.sakura.ne.jp>
Date:   Thu, 12 Dec 2019 19:30:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191211140833.939845-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2019/12/11 23:08, Ondrej Mosnacek wrote:
> As a nice side effect, this allows marking the hooks (and other stuff)
> __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no longer
> makes sense, remove it and instead use SECURITY_SELINUX_DISABLE directly
> for turning on the runtime disable functionality, to emphasize that this
> is only used by SELinux and is meant to be removed in the future.

I don't like unconditionally marking __ro_after_init. I'm currently waiting for
Casey's stacking work to complete. I haven't given up dynamically loadable LSM modules.

In order to allow loading LSM modules after boot, I have to add lines
1093-1173, 1190-1195, 1208-1211, 1217-1220 in
https://osdn.net/projects/akari/scm/svn/blobs/head/trunk/akari/lsm-4.12.c .
I suggest grouping __lsm_ro_after_init variables into a special section and
implementing a legal method for temporarily making that section read-write.
Then, architectures with that method will be able to use __ro_after_init marking.

