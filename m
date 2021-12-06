Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E22C4332F
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 16:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356784AbhLFQE7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Dec 2021 11:04:59 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:36927
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1387245AbhLFP7D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Dec 2021 10:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638806134; bh=JaHhrCbG8hzghG3pQ5K/lq8BNnAcHlR7ZQK1fbnhLlc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=FP3wqM1SncOznJvFvnp3LtIPvuse7cMdYtEVC0wfxL9SrgMjIxXwsIOEXfh0eZ4cU4HiGPba73cj8+pF6APDYDcaVUD4wOq1hlnU4YDnhJSbNQL3nj4qbrd0pv9CaJ80VcS6Duj0+Lp+CyGFzbw3tNlHMVFRfPcEzcWSSt1JR4utoKoo7ri3TQzaePsj9PCW2AL+UKXPmthk9d2uFog4aSb3WEwuHNHW6kJ49MZtf0B1jzI7RXdx/WjbsNiGmXupOBBHjyugkhtQu4MZ7gN8hnChxKPAhue8B5ZznE4Dny7YAS0RAeiUVbQtWm85R5l9OymN5Nhs1oOYr6C2tP1XzQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638806134; bh=fHm1ICea/G/NzQtsjjiXcfF4L0hiKoU9ubVOCG0r28o=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=lcELw18PxyoDcnhpzO3Zty+PJ86fA1vErKJhjePUt7oF6hn+15hcKB7LI3TVOF99aANtAbzYZb0xOmENkJGecOzAvKXzdWvHKDSfwW7qbnTu2pWNX/9u7r2X7fHQrV0d2C2P8x3ZdIBiDoMeO7vg7LfBqriD2HYYihBAGUhiIdTF3oc2sEYlzYe0dzYgldYtPLk7BuNLF0jBiXLmX5Af0mNRIsNcP0bMvCKFu4Qpg05uNCuW3LkMq8EKipdeRqwxPxjZqkFMKh8bYexjpnSfwkBkjRi2njw2tfi0FwpcPlv7eK3whnNcS+71BRVyHVX4KR6Eh+QQH6XaAuawm3p04w==
X-YMail-OSG: NIeNbeIVM1m0HrGSJa6bKk4vGa7H4fqbrdkiZcto3P4.KlFsjgURie8Jw0mQ6FC
 oMq74uEnls.jy83hclKwgUBhKvJUPzM4Azsf2d8KQo48yYWFOFYrLwbUGy7SGWS1ipju4uTcoZRA
 l2laE3GlbGqCf9gb8aPmKMpwSg36SD5IW_M8iAU.MbL50EIIu3nIj7JF2pdCbPFAt1zWYCrqqa1A
 cbQY8VOn.fN2Duk_cwfeK5IOLfAirUNrFkBFB.ikapRTaXPheIEuQLYSgi09uRMyqUeNDbyJMKic
 CO1ApM2BWidYgYC4Mp.bTBQMfSSXMYl0Gk7oJy.FKByqcWliM2k.bseYhVvbtwn1kNN0F.ALTnO7
 SdAAS1Txcs4yQ77PgCzl8f9oQ8dMBN9nZT6pW6wgF1Dw15LycHfEDG6hYX460Ia5T_pOl6G.zz5D
 E1xlw017H6kLKx0jrfjXiLtr69zt4YVKPakwMGdr1fYKqwTJlycn3m4yB9VLvqABkOvCNu7nZzBC
 z1eDoIQa1rK_YNbAhlAnYtaAtDWYQtmg7AQ2U4y1nccRe0ViYgdmt1b4D71.dHh4MQH34QKI5zXO
 RCZLn_l02JGtwSUsDNYB8h6ZfGX9ktiQ3lBp64DlWnpfgbTAfTh0KsOQ0v4lcPWZP9MO0io98Rbo
 z58Muy4tLO0CcgvJHwnRupunkTOinQz7NYLO6cdSicKZBJFiAmYRK28.k8.UAxtZkDvLJI3Bgyxj
 8_wxGZlJOh1hBFTwKdb8LrUy7ei3x9NNbfblkyFLHa7hpC5g3dHixQV0wXv9owPcnuX8qBa7hQ7.
 UTTl88vPAma65klc7vhb42rq5OJoZ2UhyihULt5rEL2mUqxb7GPEZE8BHxk417fzg1h_KL5y7P1q
 Ffvt88BllEQaGkJ7qNQ8QAH4f8twAAQBGnqmpCulbkXmTHapoVn9LRSgs3nErhA2VHyweMEFD.ck
 f6aketWBmklJbo3t1u5uZOFIhNR0oesOF1oK.85kQcw3OCHz8RJNpM7ghxVtU6XQFdHQsrziD1Ns
 wl1qh2uGvLyNJH7T1dS9GBgOX7Jj9aU928jjLsxnJLJt_6f37kuY4YlmzS.EdsD5Q6KpzFhta0G7
 lFtUIIiPK3wYo9MjY8dKUtTGeF4jonPJsTuRuRL3K_c3PQ0fvHpuEDXyiJtR6PcYKzL1f9oKyp1u
 qEPBRhmNZdyZIct5YjcCsS36f1HdI77C3osc0UVtIDl5C2yXmQbanuQLATGIgTTJj0G8F7QqZYXR
 g4Ki1q8yWCAPnhTCBejc79HIQtdcQqm98NB1UKzZSUA1Y21fwRvbMJI6i4wAr1ZM2ca8C9_ASQuH
 sl0v7wbsoFq5SnI1JHPlVJSkoi46PRsVQMGfPfz5ViBV9N.7TFyUJPhsaafrZHX9dCy_xrKbbBCE
 gC5JjrkOyl5p50TDb_sS2Surpch3aBLfg0xDAXzedlkBWOAmmbPNCeRPv1EvPKM5OC_8nLf653lE
 mM3_4u1ZyKOJfXfrIcpm4OomHOsDg8bYaFi0Jmiw0pXaR6mkro2Xtwvg4m44PqI3UjjzRQAqp1E9
 j9D6ZsDTUKpzWp2CkfHK2NdA1Yzr4VuWOKl2JcKxbCeJo6F9u0X6qjlqo.kL2iUDLVInBvpGmVBl
 afhpEzlo45bNjSsCbETL0h0XCXjmdaJiCteC5DrmX2CTyt1cB5R4sw4nPH7QDUpf8Ao0MLQ7DmNh
 AuKRoKqaKtXk83dN9quhSKw05FJknhEdLvFDMsW72uoWJNCDXo2X1H7g1g9L8jHfK9Y4G_OLwq2n
 uZjZubc4bttHngcrfN.sAm2EyEd4s0D4WxQIj.j3TCZ4I_Ym4WZRgS.Li77FStJIljO6WXw1lz_6
 NZGtQTe1l8qkJYnLrNB7cALlO15If2lnP8U_jYmeVbjfjsZxeChaxNoxPXIkLQsM.mM7rpXXEEDP
 RyloNdNZZyMsauBQMONUOmmjhsq7z72HhmDliki8byzFZxeGkY7L_qkNAgltEpmm0J5Gp2Q98vE6
 aGNUl4NDvokxT9.G5yIIKhYecHFOp9b3qEj0hbN3qxZz0qcGdkZADlaRMLU6w8lD6r8C_v5dlNQM
 LXH9FKAOuGHefUBjqhRqPzEVnEv2hBlbnT5gew44UifUpciDGFkUT7ouIObr5TXf3u3hBi2tcfOH
 UvL5nNoHMiiSqssSs06AKYHoF10aoi5pZ4V9vhzr7O4wlWQGgcHQUsrOz0A_257ndl_5b4H_qFNr
 AeoreEQmOVLHLnp0_3bvMCQQIf7Qgtx5O0bCdMEIGyVv77YUtwyBOtjKBOoGiclfWyIkxGKAkb2K
 0
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Dec 2021 15:55:34 +0000
Received: by kubenode514.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fa0b382a1f298cf32b44157a87068673;
          Mon, 06 Dec 2021 15:55:30 +0000 (UTC)
Message-ID: <2abc762e-9248-0342-037e-19e360cd0b16@schaufler-ca.com>
Date:   Mon, 6 Dec 2021 07:55:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] security,selinux: remove security_add_mnt_opt()
Content-Language: en-US
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20211206132406.235872-1-omosnace@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211206132406.235872-1-omosnace@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/6/2021 5:24 AM, Ondrej Mosnacek wrote:
> Its last user has been removed in commit f2aedb713c28 ("NFS: Add
> fs_context support.").
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>   include/linux/lsm_hook_defs.h |  2 --
>   include/linux/lsm_hooks.h     |  2 --
>   include/linux/security.h      |  8 -------
>   security/security.c           |  8 -------
>   security/selinux/hooks.c      | 39 -----------------------------------
>   5 files changed, 59 deletions(-)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index df8de62f4710..7f5c35d72082 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -78,8 +78,6 @@ LSM_HOOK(int, 0, sb_set_mnt_opts, struct super_block *sb, void *mnt_opts,
>   LSM_HOOK(int, 0, sb_clone_mnt_opts, const struct super_block *oldsb,
>   	 struct super_block *newsb, unsigned long kern_flags,
>   	 unsigned long *set_kern_flags)
> -LSM_HOOK(int, 0, sb_add_mnt_opt, const char *option, const char *val,
> -	 int len, void **mnt_opts)
>   LSM_HOOK(int, 0, move_mount, const struct path *from_path,
>   	 const struct path *to_path)
>   LSM_HOOK(int, 0, dentry_init_security, struct dentry *dentry,
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index d45b6f6e27fd..73cb0ab2bc03 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -180,8 +180,6 @@
>    *	Copy all security options from a given superblock to another
>    *	@oldsb old superblock which contain information to clone
>    *	@newsb new superblock which needs filled in
> - * @sb_add_mnt_opt:
> - * 	Add one mount @option to @mnt_opts.
>    * @sb_parse_opts_str:
>    *	Parse a string of security data filling in the opts structure
>    *	@options string containing all mount options known by the LSM
> diff --git a/include/linux/security.h b/include/linux/security.h
> index bbf44a466832..a4f0c421dd0c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -313,8 +313,6 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>   				struct super_block *newsb,
>   				unsigned long kern_flags,
>   				unsigned long *set_kern_flags);
> -int security_add_mnt_opt(const char *option, const char *val,
> -				int len, void **mnt_opts);
>   int security_move_mount(const struct path *from_path, const struct path *to_path);
>   int security_dentry_init_security(struct dentry *dentry, int mode,
>   				  const struct qstr *name,
> @@ -711,12 +709,6 @@ static inline int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>   	return 0;
>   }
>   
> -static inline int security_add_mnt_opt(const char *option, const char *val,
> -					int len, void **mnt_opts)
> -{
> -	return 0;
> -}
> -
>   static inline int security_move_mount(const struct path *from_path,
>   				      const struct path *to_path)
>   {
> diff --git a/security/security.c b/security/security.c
> index c88167a414b4..0c49a1f05ac4 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -994,14 +994,6 @@ int security_sb_clone_mnt_opts(const struct super_block *oldsb,
>   }
>   EXPORT_SYMBOL(security_sb_clone_mnt_opts);
>   
> -int security_add_mnt_opt(const char *option, const char *val, int len,
> -			 void **mnt_opts)
> -{
> -	return call_int_hook(sb_add_mnt_opt, -EINVAL,
> -					option, val, len, mnt_opts);
> -}
> -EXPORT_SYMBOL(security_add_mnt_opt);
> -
>   int security_move_mount(const struct path *from_path, const struct path *to_path)
>   {
>   	return call_int_hook(move_mount, 0, from_path, to_path);
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 62d30c0a30c2..8ea92f08e6bd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1023,44 +1023,6 @@ Einval:
>   	return -EINVAL;
>   }
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
>   static int show_sid(struct seq_file *m, u32 sid)
>   {
>   	char *context = NULL;
> @@ -7298,7 +7260,6 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>   	LSM_HOOK_INIT(fs_context_dup, selinux_fs_context_dup),
>   	LSM_HOOK_INIT(fs_context_parse_param, selinux_fs_context_parse_param),
>   	LSM_HOOK_INIT(sb_eat_lsm_opts, selinux_sb_eat_lsm_opts),
> -	LSM_HOOK_INIT(sb_add_mnt_opt, selinux_add_mnt_opt),
>   #ifdef CONFIG_SECURITY_NETWORK_XFRM
>   	LSM_HOOK_INIT(xfrm_policy_clone_security, selinux_xfrm_policy_clone),
>   #endif
