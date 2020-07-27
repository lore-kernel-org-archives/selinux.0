Return-Path: <SRS0=Yzg2=BG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71878C433E3
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 20:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B222074F
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 20:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgG0Ug5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:36:57 -0400
Received: from namei.org ([65.99.196.166]:55702 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0Ug4 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 27 Jul 2020 16:36:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 06RKabeM028144;
        Mon, 27 Jul 2020 20:36:37 GMT
Date:   Tue, 28 Jul 2020 06:36:37 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Audit-ML <linux-audit@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v19 13/23] LSM: Specify which LSM to display
In-Reply-To: <20200724203226.16374-14-casey@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.2007280636040.18670@namei.org>
References: <20200724203226.16374-1-casey@schaufler-ca.com> <20200724203226.16374-14-casey@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 24 Jul 2020, Casey Schaufler wrote:

> Create a new entry "display" in the procfs attr directory for
> controlling which LSM security information is displayed for a
> process. A process can only read or write its own display value.
> 
> The name of an active LSM that supplies hooks for
> human readable data may be written to "display" to set the
> value. The name of the LSM currently in use can be read from
> "display". At this point there can only be one LSM capable
> of display active. A helper function lsm_task_display() is
> provided to get the display slot for a task_struct.
> 
> Setting the "display" requires that all security modules using
> setprocattr hooks allow the action. Each security module is
> responsible for defining its policy.
> 
> AppArmor hook provided by John Johansen <john.johansen@canonical.com>
> SELinux hook provided by Stephen Smalley <sds@tycho.nsa.gov>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

jj: do you have any review/feedback on this?

-- 
James Morris
<jmorris@namei.org>

