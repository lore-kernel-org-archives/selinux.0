Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89F6C282DD
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 20:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45F92080A
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 20:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgAGUAC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:00:02 -0500
Received: from namei.org ([65.99.196.166]:55824 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728358AbgAGUAB (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 7 Jan 2020 15:00:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 007Jxmfk001686;
        Tue, 7 Jan 2020 19:59:48 GMT
Date:   Wed, 8 Jan 2020 06:59:48 +1100 (AEDT)
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
Subject: Re: [PATCH 2/2] security,selinux: get rid of
 security_delete_hooks()
In-Reply-To: <20200107133154.588958-3-omosnace@redhat.com>
Message-ID: <alpine.LRH.2.21.2001080653220.575@namei.org>
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-3-omosnace@redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 7 Jan 2020, Ondrej Mosnacek wrote:

> The only user is SELinux, which is hereby converted to check the
> disabled flag in each hook instead of removing the hooks from the list.
> 
> The __lsm_ro_after_init macro is now removed and replaced with
> __ro_after_init directly.
> 
> This fixes a race condition in SELinux runtime disable, which was
> introduced with the switch to hook lists in b1d9e6b0646d ("LSM: Switch
> to lists of hooks").
> 
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/lsm_hooks.h    |  31 --
>  security/Kconfig             |   5 -
>  security/apparmor/lsm.c      |   6 +-
>  security/commoncap.c         |   2 +-
>  security/loadpin/loadpin.c   |   2 +-
>  security/lockdown/lockdown.c |   2 +-
>  security/security.c          |   5 +-
>  security/selinux/Kconfig     |   6 -
>  security/selinux/hooks.c     | 742 ++++++++++++++++++++++++++++++-----
>  security/smack/smack_lsm.c   |   4 +-
>  security/tomoyo/tomoyo.c     |   6 +-
>  security/yama/yama_lsm.c     |   2 +-
>  12 files changed, 654 insertions(+), 159 deletions(-)

Please separate the changes for each LSM into separate patches (the 
__lsm_ro_after_init removal patch can be last).

>  config SECURITY_SELINUX_DEVELOP
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 47ad4db925cf..9ac2b6b69ff9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -650,13 +650,15 @@ static int selinux_set_mnt_opts(struct super_block *sb,
>  {
>  	const struct cred *cred = current_cred();
>  	struct superblock_security_struct *sbsec = sb->s_security;
> -	struct dentry *root = sbsec->sb->s_root;
>  	struct selinux_mnt_opts *opts = mnt_opts;

Seems like there are a bunch of unrelated cleanups mixed in here.

> -	int set_fscontext =	(oldsbsec->flags & FSCONTEXT_MNT);
> -	int set_context =	(oldsbsec->flags & CONTEXT_MNT);
> -	int set_rootcontext =	(oldsbsec->flags & ROOTCONTEXT_MNT);
> +	set_fscontext =		(oldsbsec->flags & FSCONTEXT_MNT);
> +	set_context =		(oldsbsec->flags & CONTEXT_MNT);
> +	set_rootcontext =	(oldsbsec->flags & ROOTCONTEXT_MNT);
>  

...

>  static int selinux_binder_set_context_mgr(struct task_struct *mgr)
>  {
> -	u32 mysid = current_sid();
> -	u32 mgrsid = task_sid(mgr);
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
>  
>  	return avc_has_perm(&selinux_state,
> -			    mysid, mgrsid, SECCLASS_BINDER,
> +			    current_sid(), task_sid(mgr), SECCLASS_BINDER,
>  			    BINDER__SET_CONTEXT_MGR, NULL);
>  }
>  

Ditto, etc.

Please don't do this.


-- 
James Morris
<jmorris@namei.org>

