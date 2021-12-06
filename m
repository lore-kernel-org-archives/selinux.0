Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79389C433F5
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 23:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbhLFX7A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Dec 2021 18:59:00 -0500
Received: from namei.org ([65.99.196.166]:54950 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355866AbhLFX67 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 6 Dec 2021 18:58:59 -0500
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 18:58:59 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 15C12AE;
        Mon,  6 Dec 2021 23:36:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 15C12AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1638833781; bh=teWzeRtiiMhFmCSfu+gbKtdiScbY7O3Ci2mlIEInb+E=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=b0o4/kuCjIsSxsv0s+8F4AnjWMqzgy2CNaK3dHVSZBHiOPGtcFre5AubDK8dM6ORD
         uSnEDfyc21Ntsvfbb3wuK8/evIMDee5OkqRQDhV/7vZMDJnUu85AUdbBirLNOG4u2M
         7KnZO2A7pT6k9Wyp+RX/yAw559iCvv6Fc8Zu1rC8=
Date:   Tue, 7 Dec 2021 10:36:21 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     "Serge E . Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] security,selinux: remove security_add_mnt_opt()
In-Reply-To: <20211206132406.235872-1-omosnace@redhat.com>
Message-ID: <5841d6ca-c316-36b-4087-a5affffa7a0@namei.org>
References: <20211206132406.235872-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 6 Dec 2021, Ondrej Mosnacek wrote:

> Its last user has been removed in commit f2aedb713c28 ("NFS: Add
> fs_context support.").
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>


Acked-by: James Morris <jamorris@linux.microsoft.com>

> ---
>  include/linux/lsm_hook_defs.h |  2 --
>  include/linux/lsm_hooks.h     |  2 --
>  include/linux/security.h      |  8 -------
>  security/security.c           |  8 -------
>  security/selinux/hooks.c      | 39 -----------------------------------
>  5 files changed, 59 deletions(-)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index df8de62f4710..7f5c35d72082 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -78,8 +78,6 @@ LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
>  LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
>  	 struct super_block *newsb, unsigned long kern_flags,
>  	 unsigned long *set_kern_flags)
> -LSM_HOOK(int, 0, sb_add_mnt_opt, const char *option, const char *val,
> -	 int len, void **mnt_opts)
>  LSM_HOOK(int, 0, move_mount, const struct path *from_path,
>  	 const struct path *to_path)
>  LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index d45b6f6e27fd..73cb0ab2bc03 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -180,8 +180,6 @@
>   *	Copy all security options from a given superblock to another
>   *	@oldsb old superblock which contain information to clone
>   *	@newsb new superblock which needs filled in
> - * @sb_add_mnt_opt:
> - * 	Add one mount @option to @mnt_opts.
>   * @sb_parse_opts_str:
>   *	Parse a string of security data filling in the opts structure
>   *	@options string containing all mount options known by the LSM
> diff --git a/include/linux/security.h b/include/linux/security.h
> index bbf44a466832..a4f0c421dd0c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -313,8 +313,6 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>  				struct super_block *newsb,
>  				unsigned long kern_flags,
>  				unsigned long *set_kern_flags);
> -int security_add_mnt_opt(const char *option, const char *val,
> -				int len, void **mnt_opts);
>  int security_move_mount(const struct path *from_path, const struct path *to_path);
>  int security_dentry_init_security(struct dentry *dentry, int mode,
>  				  const struct qstr *name,
> @@ -711,12 +709,6 @@ static inline int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>  	return 0;
>  }
>  
> -static inline int security_add_mnt_opt(const char *option, const char *val,
> -					int len, void **mnt_opts)
> -{
> -	return 0;
> -}
> -
>  static inline int security_move_mount(const struct path *from_path,
>  				      const struct path *to_path)
>  {
> diff --git a/security/security.c b/security/security.c
> index c88167a414b4..0c49a1f05ac4 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -994,14 +994,6 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>  }
>  EXPORT_SYMBOL(security_sb_clone_mnt_opts);
>  
> -int security_add_mnt_opt(const char *option, const char *val, int len,
> -			 void **mnt_opts)
> -{
> -	return call_int_hook(sb_add_mnt_opt, -EINVAL,
> -					option, val, len, mnt_opts);
> -}
> -EXPORT_SYMBOL(security_add_mnt_opt);
> -
>  int security_move_mount(const struct path *from_path, const struct path *to_path)
>  {
>  	return call_int_hook(move_mount, 0, from_path, to_path);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 62d30c0a30c2..8ea92f08e6bd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1023,44 +1023,6 @@ Einval:
>  	return -EINVAL;
>  }
>  
> -static int selinux_add_mnt_opt(const char *option, const char *val, int len,
> -			       void **mnt_opts)
> -{
> -	int token = Opt_error;
> -	int rc, i;
> -
> -	for (i = 0; i < ARRAY_SIZE(tokens); i++) {
> -		if (strcmp(option, tokens[i].name) == 0) {
> -			token = tokens[i].opt;
> -			break;
> -		}
> -	}
> -
> -	if (token == Opt_error)
> -		return -EINVAL;
> -
> -	if (token != Opt_seclabel) {
> -		val = kmemdup_nul(val, len, GFP_KERNEL);
> -		if (!val) {
> -			rc = -ENOMEM;
> -			goto free_opt;
> -		}
> -	}
> -	rc = selinux_add_opt(token, val, mnt_opts);
> -	if (unlikely(rc)) {
> -		kfree(val);
> -		goto free_opt;
> -	}
> -	return rc;
> -
> -free_opt:
> -	if (*mnt_opts) {
> -		selinux_free_mnt_opts(*mnt_opts);
> -		*mnt_opts = NULL;
> -	}
> -	return rc;
> -}
> -
>  static int show_sid(struct seq_file *m, u32 sid)
>  {
>  	char *context = NULL;
> @@ -7298,7 +7260,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
>  	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
>  	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
> -	LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
>  #ifdef CONFIG_SECURITY_NETWORK_XFRM
>  	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
>  #endif
> -- 
> 2.33.1
> 

-- 
James Morris
<jmorris@namei.org>

