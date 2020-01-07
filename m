Return-Path: <SRS0=B3ih=24=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60366C3F68F
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 16:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6742146E
	for <selinux@archiver.kernel.org>; Tue,  7 Jan 2020 16:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SiBGMtQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgAGQqh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:46:37 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com ([66.163.185.153]:46270
        "EHLO sonic305-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728235AbgAGQqh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jan 2020 11:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578415592; bh=THzlC/CLqoUX7NDJRcs7MzNCNbtXKudB7Fch7pOuhbA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=SiBGMtQWjWF9f9S+VIdv7xFrLLuDbWRBBgt71l2wnKvT0MgPYJebI0iNz2ygySsjVzA0j/A/3Oitni9CkDe8mSj+2Yzmf5HIziSa1HDrteoWCBniBtdG/slJD9413TGpOKK4hqDT4TY0mb312j7ZA6nFsQ3ojEKQgbrlWX32/cp0n+7U+irsZMqe+DthDhCcnMDg5pyPsuPGa+HsQAO0eTYyzDhbSlCUt4AOsualp9wxsX3fiL9DTOtkqpUNXhb4UFOG/vTR11bigIWu5K7oo9BS4x5XBw2p81gUsBNR7PwxLPzq8xXAQiReh3niQ4r7OG42avRJJbsp/YCTOZpjLw==
X-YMail-OSG: tFl9e4sVM1lal9UrXWH0MiJL_OvyYzojElovXAr9JJhherJPQLQEJMv3bGZApY_
 1jEBeJEzMKSVuQ_KPxAMBm.P7p6mfIF1rVJUeaRDl6IjnU1DivnNznb3VuPGws2AGfWqMUUo_SdE
 Q_IY.pLfUYPkdWfHqnP35rQXmVw.JdS4Q22Z2ay40a4jyYpMRk0kX0laTiY68bBpkG27M_PtxT.T
 5Ni44fsMhpNOX6e7dDgs75xfL6EZiRbZkpIEuTB8ChSq9U.wA6miwmig4l71EZErL4Kl5TkM4t08
 i1JVYcGK6vLav7VJ9r_Brcaiodwjbo89IekkrrOnXuUfn7Ps5sv9ptLX8uubETuIeQYfYC6YrK5I
 moio88ruHbr39iH7laZ5TEj.XgYB_7neynNLPcZR7YwYwYpyFAfA5s8tyhpldUzPvztKl9q.Oayb
 yk2RfF7XHo0OXxbF8HRuzKXiSMkGOiUTL_It.P_fFKrLuHxQLYDmtysxqwk4uRccquBj5mrdCA1.
 CIkEjT23vqumOqq8.bbjLdG6vCNcTNluevgJtsFLx6sxbUdIrNmPvvSq5TRmNvUQp07_FDlhcrEB
 iJe8b74OLzxNtIbuRVjH9BjC7M5QChTouR1TOs8mVHU9wvDEXxAiqjxdxm9tphjACKMKeRBFUDP3
 GXBm1OT0NKP21ol5H_15U73BVzy4bsCkEVBAbyx0wal8vpstkhQ5Qbz3HpViM9ymJyFmSSG.esVr
 fG9.szDruRFpYCAgxrFAw1yV7E5DSXv.jDErCWgRpIw_iVpSKB4mDCWxYU7RLpHgN0dM2_RhJ_4v
 pjgOEI1xKNjzf4bur9O5TWlMRqPxLJ3hCah0SNPDDQLgDOwHkDDKih38xXwSHXKPQdQvRc.k4Cj7
 oeEpA3nemohp7D5kKRzVBZH32.r7_bjOT.R6qoHJwLEliAl6l0tuIPxgNimoL1IGVJbRDnydCw4t
 tP0RWxRiFYf7_FNEzB8LJm84myn7z1Kk1c575bVLDHxunsnprU2HI9Xk7vS1NR8eMOTPZEUADgy0
 XO3fIYQTFdf9EmPgE.QJftZkJJNkGFLxJW2yz74fRfcEzzo3T4cyZz.dzy537lzz2j3HJBA1Q8we
 8yUaxEyprrUBwO4m2dGo.3P6wam7EURcvQ1W_4RKMKwJ91.n5hlCvaeiJpZifUXmIrSFxNk_Zdel
 BtjCOw05CGRjlMCpRP8jrOoRqAttpKtOq.6guV0hZr_bOOwpKvUC.rUDeC5FOp1784PzQpU54d0g
 BB_UPAEll99pMBEybkPTsA1vjnRPbbMxIEIz4rpZg5t20I7TD39_qfZaUSnpPhlGsYxjItiscLGu
 u8ZgVzNAwfDWKH2udkFpO9dP4fpd4rLT4DTT_joxCDYKTX4bWvaainvnhMvYqzfLdgFnN0kwYq_X
 ROXUDI0CWDaXzyA6HKYI-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Jan 2020 16:46:32 +0000
Received: by smtp422.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1b31a762bafac9ad7ff80e47e8f29cfb;
          Tue, 07 Jan 2020 16:46:27 +0000 (UTC)
Subject: Re: [PATCH 2/2] security,selinux: get rid of security_delete_hooks()
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200107133154.588958-1-omosnace@redhat.com>
 <20200107133154.588958-3-omosnace@redhat.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <4b03ae58-4e8c-dae2-7e5e-70159d0464eb@schaufler-ca.com>
Date:   Tue, 7 Jan 2020 08:46:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200107133154.588958-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/7/2020 5:31 AM, Ondrej Mosnacek wrote:
> The only user is SELinux, which is hereby converted to check the
> disabled flag in each hook instead of removing the hooks from the list.=

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

I don't see any problems with this solution from a global
LSM or Smack specific perspective. I would leave any judgement
of its impact on SELinux to the maintainers thereof.
To the extent it matters, then

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/lsm_hooks.h    |  31 --
>  security/Kconfig             |   5 -
>  security/apparmor/lsm.c      |   6 +-
>  security/commoncap.c         |   2 +-
>  security/loadpin/loadpin.c   |   2 +-
>  security/lockdown/lockdown.c |   2 +-
>  security/security.c          |   5 +-
>  security/selinux/Kconfig     |   6 -
>  security/selinux/hooks.c     | 742 ++++++++++++++++++++++++++++++-----=

>  security/smack/smack_lsm.c   |   4 +-
>  security/tomoyo/tomoyo.c     |   6 +-
>  security/yama/yama_lsm.c     |   2 +-
>  12 files changed, 654 insertions(+), 159 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 20d8cf194fb7..5064060ce910 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -27,7 +27,6 @@
> =20
>  #include <linux/security.h>
>  #include <linux/init.h>
> -#include <linux/rculist.h>
> =20
>  /**
>   * union security_list_options - Linux Security Module hook function l=
ist
> @@ -2145,36 +2144,6 @@ extern struct lsm_info __start_early_lsm_info[],=
 __end_early_lsm_info[];
>  		__used __section(.early_lsm_info.init)			\
>  		__aligned(sizeof(unsigned long))
> =20
> -#ifdef CONFIG_SECURITY_SELINUX_DISABLE
> -/*
> - * Assuring the safety of deleting a security module is up to
> - * the security module involved. This may entail ordering the
> - * module's hook list in a particular way, refusing to disable
> - * the module once a policy is loaded or any number of other
> - * actions better imagined than described.
> - *
> - * The name of the configuration option reflects the only module
> - * that currently uses the mechanism. Any developer who thinks
> - * disabling their module is a good idea needs to be at least as
> - * careful as the SELinux team.
> - */
> -static inline void security_delete_hooks(struct security_hook_list *ho=
oks,
> -						int count)
> -{
> -	int i;
> -
> -	for (i =3D 0; i < count; i++)
> -		hlist_del_rcu(&hooks[i].list);
> -}
> -#endif /* CONFIG_SECURITY_SELINUX_DISABLE */
> -
> -/* Currently required to handle SELinux runtime hook disable. */
> -#ifdef CONFIG_SECURITY_WRITABLE_HOOKS
> -#define __lsm_ro_after_init
> -#else
> -#define __lsm_ro_after_init	__ro_after_init
> -#endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
> -
>  extern int lsm_inode_alloc(struct inode *inode);
> =20
>  #endif /* ! __LINUX_LSM_HOOKS_H */
> diff --git a/security/Kconfig b/security/Kconfig
> index 2a1a2d396228..456764990a13 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -32,11 +32,6 @@ config SECURITY
> =20
>  	  If you are unsure how to answer this question, answer N.
> =20
> -config SECURITY_WRITABLE_HOOKS
> -	depends on SECURITY
> -	bool
> -	default n
> -
>  config SECURITYFS
>  	bool "Enable the securityfs filesystem"
>  	help
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index b621ad74f54a..cd83812a440f 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1158,13 +1158,13 @@ static int apparmor_inet_conn_request(struct so=
ck *sk, struct sk_buff *skb,
>  /*
>   * The cred blob is a pointer to, not an instance of, an aa_task_ctx.
>   */
> -struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init =3D {
> +struct lsm_blob_sizes apparmor_blob_sizes __ro_after_init =3D {
>  	.lbs_cred =3D sizeof(struct aa_task_ctx *),
>  	.lbs_file =3D sizeof(struct aa_file_ctx),
>  	.lbs_task =3D sizeof(struct aa_task_ctx),
>  };
> =20
> -static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init =
=3D {
> +static struct security_hook_list apparmor_hooks[] __ro_after_init =3D =
{
>  	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
>  	LSM_HOOK_INIT(capget, apparmor_capget),
> @@ -1368,7 +1368,7 @@ static const struct kernel_param_ops param_ops_aa=
intbool =3D {
>  	.get =3D param_get_aaintbool
>  };
>  /* Boot time disable flag */
> -static int apparmor_enabled __lsm_ro_after_init =3D 1;
> +static int apparmor_enabled __ro_after_init =3D 1;
>  module_param_named(enabled, apparmor_enabled, aaintbool, 0444);
> =20
>  static int __init apparmor_enabled_setup(char *str)
> diff --git a/security/commoncap.c b/security/commoncap.c
> index f4ee0ae106b2..1471d9a5a9bc 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1339,7 +1339,7 @@ int cap_mmap_file(struct file *file, unsigned lon=
g reqprot,
> =20
>  #ifdef CONFIG_SECURITY
> =20
> -static struct security_hook_list capability_hooks[] __lsm_ro_after_ini=
t =3D {
> +static struct security_hook_list capability_hooks[] __ro_after_init =3D=
 {
>  	LSM_HOOK_INIT(capable, cap_capable),
>  	LSM_HOOK_INIT(settime, cap_settime),
>  	LSM_HOOK_INIT(ptrace_access_check, cap_ptrace_access_check),
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index ee5cb944f4ad..9bbc08bee2c0 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -180,7 +180,7 @@ static int loadpin_load_data(enum kernel_load_data_=
id id)
>  	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
>  }
> =20
> -static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init =3D=
 {
> +static struct security_hook_list loadpin_hooks[] __ro_after_init =3D {=

>  	LSM_HOOK_INIT(sb_free_security, loadpin_sb_free_security),
>  	LSM_HOOK_INIT(kernel_read_file, loadpin_read_file),
>  	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.=
c
> index 5a952617a0eb..8071d0f542c8 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -71,7 +71,7 @@ static int lockdown_is_locked_down(enum lockdown_reas=
on what)
>  	return 0;
>  }
> =20
> -static struct security_hook_list lockdown_hooks[] __lsm_ro_after_init =
=3D {
> +static struct security_hook_list lockdown_hooks[] __ro_after_init =3D =
{
>  	LSM_HOOK_INIT(locked_down, lockdown_is_locked_down),
>  };
> =20
> diff --git a/security/security.c b/security/security.c
> index 2b5473d92416..3138a5d99813 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -27,6 +27,7 @@
>  #include <linux/backing-dev.h>
>  #include <linux/string.h>
>  #include <linux/msg.h>
> +#include <linux/rculist.h>
>  #include <net/flow.h>
> =20
>  #define MAX_LSM_EVM_XATTR	2
> @@ -68,14 +69,14 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDE=
NTIALITY_MAX+1] =3D {
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] =3D "confidentiality",
>  };
> =20
> -struct security_hook_heads security_hook_heads __lsm_ro_after_init;
> +struct security_hook_heads security_hook_heads __ro_after_init;
>  static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
> =20
>  static struct kmem_cache *lsm_file_cache;
>  static struct kmem_cache *lsm_inode_cache;
> =20
>  char *lsm_names;
> -static struct lsm_blob_sizes blob_sizes __lsm_ro_after_init;
> +static struct lsm_blob_sizes blob_sizes __ro_after_init;
> =20
>  /* Boot-time LSM user choice */
>  static __initdata const char *chosen_lsm_order;
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 996d35d950f7..caa5711478ad 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -26,7 +26,6 @@ config SECURITY_SELINUX_BOOTPARAM
>  config SECURITY_SELINUX_DISABLE
>  	bool "NSA SELinux runtime disable"
>  	depends on SECURITY_SELINUX
> -	select SECURITY_WRITABLE_HOOKS
>  	default n
>  	help
>  	  This option enables writing to a selinuxfs node 'disable', which
> @@ -37,11 +36,6 @@ config SECURITY_SELINUX_DISABLE
>  	  portability across platforms where boot parameters are difficult
>  	  to employ.
> =20
> -	  NOTE: selecting this option will disable the '__ro_after_init'
> -	  kernel hardening feature for security hooks.   Please consider
> -	  using the selinux=3D0 boot parameter instead of enabling this
> -	  option.
> -
>  	  If you are unsure how to answer this question, answer N.
> =20
>  config SECURITY_SELINUX_DEVELOP
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 47ad4db925cf..9ac2b6b69ff9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -650,13 +650,15 @@ static int selinux_set_mnt_opts(struct super_bloc=
k *sb,
>  {
>  	const struct cred *cred =3D current_cred();
>  	struct superblock_security_struct *sbsec =3D sb->s_security;
> -	struct dentry *root =3D sbsec->sb->s_root;
>  	struct selinux_mnt_opts *opts =3D mnt_opts;
>  	struct inode_security_struct *root_isec;
>  	u32 fscontext_sid =3D 0, context_sid =3D 0, rootcontext_sid =3D 0;
>  	u32 defcontext_sid =3D 0;
>  	int rc =3D 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	mutex_lock(&sbsec->lock);
> =20
>  	if (!selinux_initialized(&selinux_state)) {
> @@ -693,7 +695,7 @@ static int selinux_set_mnt_opts(struct super_block =
*sb,
>  	    && !opts)
>  		goto out;
> =20
> -	root_isec =3D backing_inode_security_novalidate(root);
> +	root_isec =3D backing_inode_security_novalidate(sbsec->sb->s_root);
> =20
>  	/*
>  	 * parse the mount options, check if they are valid sids.
> @@ -919,10 +921,14 @@ static int selinux_sb_clone_mnt_opts(const struct=
 super_block *oldsb,
>  	int rc =3D 0;
>  	const struct superblock_security_struct *oldsbsec =3D oldsb->s_securi=
ty;
>  	struct superblock_security_struct *newsbsec =3D newsb->s_security;
> +	int set_fscontext, set_context, set_rootcontext;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
> -	int set_fscontext =3D	(oldsbsec->flags & FSCONTEXT_MNT);
> -	int set_context =3D	(oldsbsec->flags & CONTEXT_MNT);
> -	int set_rootcontext =3D	(oldsbsec->flags & ROOTCONTEXT_MNT);
> +	set_fscontext =3D		(oldsbsec->flags & FSCONTEXT_MNT);
> +	set_context =3D		(oldsbsec->flags & CONTEXT_MNT);
> +	set_rootcontext =3D	(oldsbsec->flags & ROOTCONTEXT_MNT);
> =20
>  	/*
>  	 * if the parent was able to be mounted it clearly had no special lsm=

> @@ -1041,6 +1047,9 @@ static int selinux_add_mnt_opt(const char *option=
, const char *val, int len,
>  	int token =3D Opt_error;
>  	int rc, i;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	for (i =3D 0; i < ARRAY_SIZE(tokens); i++) {
>  		if (strcmp(option, tokens[i].name) =3D=3D 0) {
>  			token =3D tokens[i].opt;
> @@ -1100,6 +1109,9 @@ static int selinux_sb_show_options(struct seq_fil=
e *m, struct super_block *sb)
>  	struct superblock_security_struct *sbsec =3D sb->s_security;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!(sbsec->flags & SE_SBINITIALIZED))
>  		return 0;
> =20
> @@ -2044,22 +2056,27 @@ static inline u32 open_file_to_av(struct file *=
file)
> =20
>  static int selinux_binder_set_context_mgr(struct task_struct *mgr)
>  {
> -	u32 mysid =3D current_sid();
> -	u32 mgrsid =3D task_sid(mgr);
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
>  	return avc_has_perm(&selinux_state,
> -			    mysid, mgrsid, SECCLASS_BINDER,
> +			    current_sid(), task_sid(mgr), SECCLASS_BINDER,
>  			    BINDER__SET_CONTEXT_MGR, NULL);
>  }
> =20
>  static int selinux_binder_transaction(struct task_struct *from,
>  				      struct task_struct *to)
>  {
> -	u32 mysid =3D current_sid();
> -	u32 fromsid =3D task_sid(from);
> -	u32 tosid =3D task_sid(to);
> +	u32 mysid, fromsid, tosid;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	mysid =3D current_sid();
> +	fromsid =3D task_sid(from);
> +	tosid =3D task_sid(to);
> +
>  	if (mysid !=3D fromsid) {
>  		rc =3D avc_has_perm(&selinux_state,
>  				  mysid, fromsid, SECCLASS_BINDER,
> @@ -2076,11 +2093,12 @@ static int selinux_binder_transaction(struct ta=
sk_struct *from,
>  static int selinux_binder_transfer_binder(struct task_struct *from,
>  					  struct task_struct *to)
>  {
> -	u32 fromsid =3D task_sid(from);
> -	u32 tosid =3D task_sid(to);
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
>  	return avc_has_perm(&selinux_state,
> -			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
> +			    task_sid(from), task_sid(to),
> +			    SECCLASS_BINDER, BINDER__TRANSFER,
>  			    NULL);
>  }
> =20
> @@ -2088,13 +2106,18 @@ static int selinux_binder_transfer_file(struct =
task_struct *from,
>  					struct task_struct *to,
>  					struct file *file)
>  {
> -	u32 sid =3D task_sid(to);
> +	u32 sid;
>  	struct file_security_struct *fsec =3D selinux_file(file);
>  	struct dentry *dentry =3D file->f_path.dentry;
>  	struct inode_security_struct *isec;
>  	struct common_audit_data ad;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid =3D task_sid(to);
> +
>  	ad.type =3D LSM_AUDIT_DATA_PATH;
>  	ad.u.path =3D file->f_path;
> =20
> @@ -2126,19 +2149,26 @@ static int selinux_binder_transfer_file(struct =
task_struct *from,
>  static int selinux_ptrace_access_check(struct task_struct *child,
>  				     unsigned int mode)
>  {
> -	u32 sid =3D current_sid();
> -	u32 csid =3D task_sid(child);
> +	u16 cls =3D SECCLASS_PROCESS;
> +	u32 perm =3D PROCESS__PTRACE;
> =20
> -	if (mode & PTRACE_MODE_READ)
> -		return avc_has_perm(&selinux_state,
> -				    sid, csid, SECCLASS_FILE, FILE__READ, NULL);
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	if (mode & PTRACE_MODE_READ) {
> +		cls =3D SECCLASS_FILE;
> +		perm =3D FILE__READ;
> +	}
> =20
>  	return avc_has_perm(&selinux_state,
> -			    sid, csid, SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
> +			    current_sid(), task_sid(child), cls, perm, NULL);
>  }
> =20
>  static int selinux_ptrace_traceme(struct task_struct *parent)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    task_sid(parent), current_sid(), SECCLASS_PROCESS,
>  			    PROCESS__PTRACE, NULL);
> @@ -2147,6 +2177,9 @@ static int selinux_ptrace_traceme(struct task_str=
uct *parent)
>  static int selinux_capget(struct task_struct *target, kernel_cap_t *ef=
fective,
>  			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(target), SECCLASS_PROCESS,
>  			    PROCESS__GETCAP, NULL);
> @@ -2157,6 +2190,9 @@ static int selinux_capset(struct cred *new, const=
 struct cred *old,
>  			  const kernel_cap_t *inheritable,
>  			  const kernel_cap_t *permitted)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    cred_sid(old), cred_sid(new), SECCLASS_PROCESS,
>  			    PROCESS__SETCAP, NULL);
> @@ -2175,6 +2211,9 @@ static int selinux_capset(struct cred *new, const=
 struct cred *old,
>  static int selinux_capable(const struct cred *cred, struct user_namesp=
ace *ns,
>  			   int cap, unsigned int opts)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return cred_has_capability(cred, cap, opts, ns =3D=3D &init_user_ns);=

>  }
> =20
> @@ -2186,6 +2225,9 @@ static int selinux_quotactl(int cmds, int type, i=
nt id, struct super_block *sb)
>  	if (!sb)
>  		return 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmds) {
>  	case Q_SYNC:
>  	case Q_QUOTAON:
> @@ -2210,11 +2252,17 @@ static int selinux_quota_on(struct dentry *dent=
ry)
>  {
>  	const struct cred *cred =3D current_cred();
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return dentry_has_perm(cred, dentry, FILE__QUOTAON);
>  }
> =20
>  static int selinux_syslog(int type)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (type) {
>  	case SYSLOG_ACTION_READ_ALL:	/* Read last kernel messages */
>  	case SYSLOG_ACTION_SIZE_BUFFER:	/* Return size of the log buffer */
> @@ -2248,6 +2296,9 @@ static int selinux_vm_enough_memory(struct mm_str=
uct *mm, long pages)
>  {
>  	int rc, cap_sys_admin =3D 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	rc =3D cred_has_capability(current_cred(), CAP_SYS_ADMIN,
>  				 CAP_OPT_NOAUDIT, true);
>  	if (rc =3D=3D 0)
> @@ -2335,6 +2386,9 @@ static int selinux_bprm_set_creds(struct linux_bi=
nprm *bprm)
>  	struct inode *inode =3D file_inode(bprm->file);
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	/* SELinux context only depends on initial program or script and not
>  	 * the script interpreter */
>  	if (bprm->called_set_creds)
> @@ -2505,6 +2559,9 @@ static void selinux_bprm_committing_creds(struct =
linux_binprm *bprm)
>  	struct rlimit *rlim, *initrlim;
>  	int rc, i;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	new_tsec =3D selinux_cred(bprm->cred);
>  	if (new_tsec->sid =3D=3D new_tsec->osid)
>  		return;
> @@ -2552,6 +2609,9 @@ static void selinux_bprm_committed_creds(struct l=
inux_binprm *bprm)
>  	u32 osid, sid;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	osid =3D tsec->osid;
>  	sid =3D tsec->sid;
> =20
> @@ -2592,11 +2652,17 @@ static void selinux_bprm_committed_creds(struct=
 linux_binprm *bprm)
> =20
>  static int selinux_sb_alloc_security(struct super_block *sb)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return superblock_alloc_security(sb);
>  }
> =20
>  static void selinux_sb_free_security(struct super_block *sb)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	superblock_free_security(sb);
>  }
> =20
> @@ -2622,6 +2688,9 @@ static int selinux_sb_eat_lsm_opts(char *options,=
 void **mnt_opts)
>  	bool first =3D true;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	while (1) {
>  		int len =3D opt_len(from);
>  		int token;
> @@ -2682,6 +2751,9 @@ static int selinux_sb_remount(struct super_block =
*sb, void *mnt_opts)
>  	u32 sid;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!(sbsec->flags & SE_SBINITIALIZED))
>  		return 0;
> =20
> @@ -2732,6 +2804,9 @@ static int selinux_sb_kern_mount(struct super_blo=
ck *sb)
>  	const struct cred *cred =3D current_cred();
>  	struct common_audit_data ad;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type =3D LSM_AUDIT_DATA_DENTRY;
>  	ad.u.dentry =3D sb->s_root;
>  	return superblock_has_perm(cred, sb, FILESYSTEM__MOUNT, &ad);
> @@ -2742,6 +2817,9 @@ static int selinux_sb_statfs(struct dentry *dentr=
y)
>  	const struct cred *cred =3D current_cred();
>  	struct common_audit_data ad;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type =3D LSM_AUDIT_DATA_DENTRY;
>  	ad.u.dentry =3D dentry->d_sb->s_root;
>  	return superblock_has_perm(cred, dentry->d_sb, FILESYSTEM__GETATTR, &=
ad);
> @@ -2755,6 +2833,9 @@ static int selinux_mount(const char *dev_name,
>  {
>  	const struct cred *cred =3D current_cred();
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (flags & MS_REMOUNT)
>  		return superblock_has_perm(cred, path->dentry->d_sb,
>  					   FILESYSTEM__REMOUNT, NULL);
> @@ -2766,6 +2847,9 @@ static int selinux_umount(struct vfsmount *mnt, i=
nt flags)
>  {
>  	const struct cred *cred =3D current_cred();
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return superblock_has_perm(cred, mnt->mnt_sb,
>  				   FILESYSTEM__UNMOUNT, NULL);
>  }
> @@ -2776,6 +2860,9 @@ static int selinux_fs_context_dup(struct fs_conte=
xt *fc,
>  	const struct selinux_mnt_opts *src =3D src_fc->security;
>  	struct selinux_mnt_opts *opts;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!src)
>  		return 0;
> =20
> @@ -2828,6 +2915,9 @@ static int selinux_fs_context_parse_param(struct =
fs_context *fc,
>  	struct fs_parse_result result;
>  	int opt, rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	opt =3D fs_parse(fc, &selinux_fs_parameters, param, &result);
>  	if (opt < 0)
>  		return opt;
> @@ -2844,11 +2934,17 @@ static int selinux_fs_context_parse_param(struc=
t fs_context *fc,
> =20
>  static int selinux_inode_alloc_security(struct inode *inode)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return inode_alloc_security(inode);
>  }
> =20
>  static void selinux_inode_free_security(struct inode *inode)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	inode_free_security(inode);
>  }
> =20
> @@ -2859,6 +2955,9 @@ static int selinux_dentry_init_security(struct de=
ntry *dentry, int mode,
>  	u32 newsid;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	rc =3D selinux_determine_inode_label(selinux_cred(current_cred()),
>  					   d_inode(dentry->d_parent), name,
>  					   inode_mode_to_security_class(mode),
> @@ -2879,6 +2978,9 @@ static int selinux_dentry_create_files_as(struct =
dentry *dentry, int mode,
>  	int rc;
>  	struct task_security_struct *tsec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	rc =3D selinux_determine_inode_label(selinux_cred(old),
>  					   d_inode(dentry->d_parent), name,
>  					   inode_mode_to_security_class(mode),
> @@ -2902,6 +3004,9 @@ static int selinux_inode_init_security(struct ino=
de *inode, struct inode *dir,
>  	int rc;
>  	char *context;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	sbsec =3D dir->i_sb->s_security;
> =20
>  	newsid =3D tsec->create_sid;
> @@ -2941,50 +3046,75 @@ static int selinux_inode_init_security(struct i=
node *inode, struct inode *dir,
> =20
>  static int selinux_inode_create(struct inode *dir, struct dentry *dent=
ry, umode_t mode)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_create(dir, dentry, SECCLASS_FILE);
>  }
> =20
>  static int selinux_inode_link(struct dentry *old_dentry, struct inode =
*dir, struct dentry *new_dentry)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_link(dir, old_dentry, MAY_LINK);
>  }
> =20
>  static int selinux_inode_unlink(struct inode *dir, struct dentry *dent=
ry)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_link(dir, dentry, MAY_UNLINK);
>  }
> =20
>  static int selinux_inode_symlink(struct inode *dir, struct dentry *den=
try, const char *name)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_create(dir, dentry, SECCLASS_LNK_FILE);
>  }
> =20
>  static int selinux_inode_mkdir(struct inode *dir, struct dentry *dentr=
y, umode_t mask)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_create(dir, dentry, SECCLASS_DIR);
>  }
> =20
>  static int selinux_inode_rmdir(struct inode *dir, struct dentry *dentr=
y)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_link(dir, dentry, MAY_RMDIR);
>  }
> =20
>  static int selinux_inode_mknod(struct inode *dir, struct dentry *dentr=
y, umode_t mode, dev_t dev)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_create(dir, dentry, inode_mode_to_security_class(mode));
>  }
> =20
>  static int selinux_inode_rename(struct inode *old_inode, struct dentry=
 *old_dentry,
>  				struct inode *new_inode, struct dentry *new_dentry)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return may_rename(old_inode, old_dentry, new_inode, new_dentry);
>  }
> =20
>  static int selinux_inode_readlink(struct dentry *dentry)
>  {
> -	const struct cred *cred =3D current_cred();
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
> -	return dentry_has_perm(cred, dentry, FILE__READ);
> +	return dentry_has_perm(current_cred(), dentry, FILE__READ);
>  }
> =20
>  static int selinux_inode_follow_link(struct dentry *dentry, struct ino=
de *inode,
> @@ -2995,6 +3125,9 @@ static int selinux_inode_follow_link(struct dentr=
y *dentry, struct inode *inode,
>  	struct inode_security_struct *isec;
>  	u32 sid;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	validate_creds(cred);
> =20
>  	ad.type =3D LSM_AUDIT_DATA_DENTRY;
> @@ -3040,6 +3173,9 @@ static int selinux_inode_permission(struct inode =
*inode, int mask)
>  	int rc, rc2;
>  	u32 audited, denied;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	from_access =3D mask & MAY_ACCESS;
>  	mask &=3D (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND);
> =20
> @@ -3086,6 +3222,9 @@ static int selinux_inode_setattr(struct dentry *d=
entry, struct iattr *iattr)
>  	unsigned int ia_valid =3D iattr->ia_valid;
>  	__u32 av =3D FILE__WRITE;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	/* ATTR_FORCE is just used for ATTR_KILL_S[UG]ID. */
>  	if (ia_valid & ATTR_FORCE) {
>  		ia_valid &=3D ~(ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_MODE |
> @@ -3109,6 +3248,9 @@ static int selinux_inode_setattr(struct dentry *d=
entry, struct iattr *iattr)
> =20
>  static int selinux_inode_getattr(const struct path *path)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return path_has_perm(current_cred(), path, FILE__GETATTR);
>  }
> =20
> @@ -3131,9 +3273,12 @@ static int selinux_inode_setxattr(struct dentry =
*dentry, const char *name,
>  	struct inode_security_struct *isec;
>  	struct superblock_security_struct *sbsec;
>  	struct common_audit_data ad;
> -	u32 newsid, sid =3D current_sid();
> +	u32 newsid, sid;
>  	int rc =3D 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (strcmp(name, XATTR_NAME_SELINUX)) {
>  		rc =3D cap_inode_setxattr(dentry, name, value, size, flags);
>  		if (rc)
> @@ -3154,6 +3299,8 @@ static int selinux_inode_setxattr(struct dentry *=
dentry, const char *name,
>  	if (!inode_owner_or_capable(inode))
>  		return -EPERM;
> =20
> +	sid =3D current_sid();
> +
>  	ad.type =3D LSM_AUDIT_DATA_DENTRY;
>  	ad.u.dentry =3D dentry;
> =20
> @@ -3225,6 +3372,9 @@ static void selinux_inode_post_setxattr(struct de=
ntry *dentry, const char *name,
>  	u32 newsid;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	if (strcmp(name, XATTR_NAME_SELINUX)) {
>  		/* Not an attribute we recognize, so nothing to do. */
>  		return;
> @@ -3260,20 +3410,25 @@ static void selinux_inode_post_setxattr(struct =
dentry *dentry, const char *name,
> =20
>  static int selinux_inode_getxattr(struct dentry *dentry, const char *n=
ame)
>  {
> -	const struct cred *cred =3D current_cred();
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
> -	return dentry_has_perm(cred, dentry, FILE__GETATTR);
> +	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
>  }
> =20
>  static int selinux_inode_listxattr(struct dentry *dentry)
>  {
> -	const struct cred *cred =3D current_cred();
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
> -	return dentry_has_perm(cred, dentry, FILE__GETATTR);
> +	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
>  }
> =20
>  static int selinux_inode_removexattr(struct dentry *dentry, const char=
 *name)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (strcmp(name, XATTR_NAME_SELINUX)) {
>  		int rc =3D cap_inode_removexattr(dentry, name);
>  		if (rc)
> @@ -3297,6 +3452,9 @@ static int selinux_path_notify(const struct path =
*path, u64 mask,
> =20
>  	struct common_audit_data ad;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type =3D LSM_AUDIT_DATA_PATH;
>  	ad.u.path =3D *path;
> =20
> @@ -3345,6 +3503,9 @@ static int selinux_inode_getsecurity(struct inode=
 *inode, const char *name, void
>  	char *context =3D NULL;
>  	struct inode_security_struct *isec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return -EOPNOTSUPP;
> +
>  	if (strcmp(name, XATTR_SELINUX_SUFFIX))
>  		return -EOPNOTSUPP;
> =20
> @@ -3385,6 +3546,9 @@ static int selinux_inode_setsecurity(struct inode=
 *inode, const char *name,
>  	u32 newsid;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return -EOPNOTSUPP;
> +
>  	if (strcmp(name, XATTR_SELINUX_SUFFIX))
>  		return -EOPNOTSUPP;
> =20
> @@ -3410,6 +3574,10 @@ static int selinux_inode_setsecurity(struct inod=
e *inode, const char *name,
>  static int selinux_inode_listsecurity(struct inode *inode, char *buffe=
r, size_t buffer_size)
>  {
>  	const int len =3D sizeof(XATTR_NAME_SELINUX);
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (buffer && len <=3D buffer_size)
>  		memcpy(buffer, XATTR_NAME_SELINUX, len);
>  	return len;
> @@ -3417,16 +3585,24 @@ static int selinux_inode_listsecurity(struct in=
ode *inode, char *buffer, size_t
> =20
>  static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
>  {
> -	struct inode_security_struct *isec =3D inode_security_novalidate(inod=
e);
> +	struct inode_security_struct *isec;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
> +	isec =3D inode_security_novalidate(inode);
>  	*secid =3D isec->sid;
>  }
> =20
>  static int selinux_inode_copy_up(struct dentry *src, struct cred **new=
)
>  {
> -	u32 sid;
> +	struct inode_security_struct *isec;
>  	struct task_security_struct *tsec;
>  	struct cred *new_creds =3D *new;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (new_creds =3D=3D NULL) {
>  		new_creds =3D prepare_creds();
>  		if (!new_creds)
> @@ -3435,14 +3611,17 @@ static int selinux_inode_copy_up(struct dentry =
*src, struct cred **new)
> =20
>  	tsec =3D selinux_cred(new_creds);
>  	/* Get label from overlay inode and set it in create_sid */
> -	selinux_inode_getsecid(d_inode(src), &sid);
> -	tsec->create_sid =3D sid;
> +	isec =3D inode_security_novalidate(d_inode(src));
> +	tsec->create_sid =3D isec->sid;
>  	*new =3D new_creds;
>  	return 0;
>  }
> =20
>  static int selinux_inode_copy_up_xattr(const char *name)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return -EOPNOTSUPP;
> +
>  	/* The copy_up hook above sets the initial context on an inode, but w=
e
>  	 * don't then want to overwrite it by blindly copying all the lower
>  	 * xattrs up.  Instead, we have to filter out SELinux-related xattrs.=

> @@ -3466,6 +3645,9 @@ static int selinux_kernfs_init_security(struct ke=
rnfs_node *kn_dir,
>  	int rc;
>  	char *context;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	rc =3D kernfs_xattr_get(kn_dir, XATTR_NAME_SELINUX, NULL, 0);
>  	if (rc =3D=3D -ENODATA)
>  		return 0;
> @@ -3537,14 +3719,16 @@ static int selinux_file_permission(struct file =
*file, int mask)
>  	struct inode *inode =3D file_inode(file);
>  	struct file_security_struct *fsec =3D selinux_file(file);
>  	struct inode_security_struct *isec;
> -	u32 sid =3D current_sid();
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
>  	if (!mask)
>  		/* No permission to check.  Existence test. */
>  		return 0;
> =20
>  	isec =3D inode_security(inode);
> -	if (sid =3D=3D fsec->sid && fsec->isid =3D=3D isec->sid &&
> +	if (current_sid() =3D=3D fsec->sid && fsec->isid =3D=3D isec->sid &&
>  	    fsec->pseqno =3D=3D avc_policy_seqno(&selinux_state))
>  		/* No change since file_open check. */
>  		return 0;
> @@ -3554,6 +3738,9 @@ static int selinux_file_permission(struct file *f=
ile, int mask)
> =20
>  static int selinux_file_alloc_security(struct file *file)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return file_alloc_security(file);
>  }
> =20
> @@ -3606,6 +3793,9 @@ static int selinux_file_ioctl(struct file *file, =
unsigned int cmd,
>  	const struct cred *cred =3D current_cred();
>  	int error =3D 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case FIONREAD:
>  	/* fall through */
> @@ -3692,6 +3882,9 @@ static int selinux_mmap_addr(unsigned long addr)
>  {
>  	int rc =3D 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (addr < CONFIG_LSM_MMAP_MIN_ADDR) {
>  		u32 sid =3D current_sid();
>  		rc =3D avc_has_perm(&selinux_state,
> @@ -3708,6 +3901,9 @@ static int selinux_mmap_file(struct file *file, u=
nsigned long reqprot,
>  	struct common_audit_data ad;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (file) {
>  		ad.type =3D LSM_AUDIT_DATA_FILE;
>  		ad.u.file =3D file;
> @@ -3729,7 +3925,12 @@ static int selinux_file_mprotect(struct vm_area_=
struct *vma,
>  				 unsigned long prot)
>  {
>  	const struct cred *cred =3D current_cred();
> -	u32 sid =3D cred_sid(cred);
> +	u32 sid;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid =3D cred_sid(cred);
> =20
>  	if (selinux_state.checkreqprot)
>  		prot =3D reqprot;
> @@ -3768,9 +3969,10 @@ static int selinux_file_mprotect(struct vm_area_=
struct *vma,
> =20
>  static int selinux_file_lock(struct file *file, unsigned int cmd)
>  {
> -	const struct cred *cred =3D current_cred();
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
> -	return file_has_perm(cred, file, FILE__LOCK);
> +	return file_has_perm(current_cred(), file, FILE__LOCK);
>  }
> =20
>  static int selinux_file_fcntl(struct file *file, unsigned int cmd,
> @@ -3779,6 +3981,9 @@ static int selinux_file_fcntl(struct file *file, =
unsigned int cmd,
>  	const struct cred *cred =3D current_cred();
>  	int err =3D 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case F_SETFL:
>  		if ((file->f_flags & O_APPEND) && !(arg & O_APPEND)) {
> @@ -3817,6 +4022,9 @@ static void selinux_file_set_fowner(struct file *=
file)
>  {
>  	struct file_security_struct *fsec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	fsec =3D selinux_file(file);
>  	fsec->fown_sid =3D current_sid();
>  }
> @@ -3825,10 +4033,12 @@ static int selinux_file_send_sigiotask(struct t=
ask_struct *tsk,
>  				       struct fown_struct *fown, int signum)
>  {
>  	struct file *file;
> -	u32 sid =3D task_sid(tsk);
>  	u32 perm;
>  	struct file_security_struct *fsec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	/* struct fown_struct is never outside the context of a struct file *=
/
>  	file =3D container_of(fown, struct file, f_owner);
> =20
> @@ -3840,15 +4050,16 @@ static int selinux_file_send_sigiotask(struct t=
ask_struct *tsk,
>  		perm =3D signal_to_av(signum);
> =20
>  	return avc_has_perm(&selinux_state,
> -			    fsec->fown_sid, sid,
> +			    fsec->fown_sid, task_sid(tsk),
>  			    SECCLASS_PROCESS, perm, NULL);
>  }
> =20
>  static int selinux_file_receive(struct file *file)
>  {
> -	const struct cred *cred =3D current_cred();
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
> -	return file_has_perm(cred, file, file_to_av(file));
> +	return file_has_perm(current_cred(), file, file_to_av(file));
>  }
> =20
>  static int selinux_file_open(struct file *file)
> @@ -3856,6 +4067,9 @@ static int selinux_file_open(struct file *file)
>  	struct file_security_struct *fsec;
>  	struct inode_security_struct *isec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	fsec =3D selinux_file(file);
>  	isec =3D inode_security(file_inode(file));
>  	/*
> @@ -3883,7 +4097,12 @@ static int selinux_file_open(struct file *file)
>  static int selinux_task_alloc(struct task_struct *task,
>  			      unsigned long clone_flags)
>  {
> -	u32 sid =3D current_sid();
> +	u32 sid;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid =3D current_sid();
> =20
>  	return avc_has_perm(&selinux_state,
>  			    sid, sid, SECCLASS_PROCESS, PROCESS__FORK, NULL);
> @@ -3898,6 +4117,9 @@ static int selinux_cred_prepare(struct cred *new,=
 const struct cred *old,
>  	const struct task_security_struct *old_tsec =3D selinux_cred(old);
>  	struct task_security_struct *tsec =3D selinux_cred(new);
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	*tsec =3D *old_tsec;
>  	return 0;
>  }
> @@ -3910,11 +4132,17 @@ static void selinux_cred_transfer(struct cred *=
new, const struct cred *old)
>  	const struct task_security_struct *old_tsec =3D selinux_cred(old);
>  	struct task_security_struct *tsec =3D selinux_cred(new);
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	*tsec =3D *old_tsec;
>  }
> =20
>  static void selinux_cred_getsecid(const struct cred *c, u32 *secid)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	*secid =3D cred_sid(c);
>  }
> =20
> @@ -3925,11 +4153,13 @@ static void selinux_cred_getsecid(const struct =
cred *c, u32 *secid)
>  static int selinux_kernel_act_as(struct cred *new, u32 secid)
>  {
>  	struct task_security_struct *tsec =3D selinux_cred(new);
> -	u32 sid =3D current_sid();
>  	int ret;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ret =3D avc_has_perm(&selinux_state,
> -			   sid, secid,
> +			   current_sid(), secid,
>  			   SECCLASS_KERNEL_SERVICE,
>  			   KERNEL_SERVICE__USE_AS_OVERRIDE,
>  			   NULL);
> @@ -3950,11 +4180,13 @@ static int selinux_kernel_create_files_as(struc=
t cred *new, struct inode *inode)
>  {
>  	struct inode_security_struct *isec =3D inode_security(inode);
>  	struct task_security_struct *tsec =3D selinux_cred(new);
> -	u32 sid =3D current_sid();
>  	int ret;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ret =3D avc_has_perm(&selinux_state,
> -			   sid, isec->sid,
> +			   current_sid(), isec->sid,
>  			   SECCLASS_KERNEL_SERVICE,
>  			   KERNEL_SERVICE__CREATE_FILES_AS,
>  			   NULL);
> @@ -3968,6 +4200,9 @@ static int selinux_kernel_module_request(char *km=
od_name)
>  {
>  	struct common_audit_data ad;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type =3D LSM_AUDIT_DATA_KMOD;
>  	ad.u.kmod_name =3D kmod_name;
> =20
> @@ -4012,35 +4247,37 @@ static int selinux_kernel_module_from_file(stru=
ct file *file)
>  static int selinux_kernel_read_file(struct file *file,
>  				    enum kernel_read_file_id id)
>  {
> -	int rc =3D 0;
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
>  	switch (id) {
>  	case READING_MODULE:
> -		rc =3D selinux_kernel_module_from_file(file);
> -		break;
> +		return selinux_kernel_module_from_file(file);
>  	default:
>  		break;
>  	}
> -
> -	return rc;
> +	return 0;
>  }
> =20
>  static int selinux_kernel_load_data(enum kernel_load_data_id id)
>  {
> -	int rc =3D 0;
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
>  	switch (id) {
>  	case LOADING_MODULE:
> -		rc =3D selinux_kernel_module_from_file(NULL);
> +		return selinux_kernel_module_from_file(NULL);
>  	default:
>  		break;
>  	}
> -
> -	return rc;
> +	return 0;
>  }
> =20
>  static int selinux_task_setpgid(struct task_struct *p, pid_t pgid)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__SETPGID, NULL);
> @@ -4048,6 +4285,9 @@ static int selinux_task_setpgid(struct task_struc=
t *p, pid_t pgid)
> =20
>  static int selinux_task_getpgid(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__GETPGID, NULL);
> @@ -4055,6 +4295,9 @@ static int selinux_task_getpgid(struct task_struc=
t *p)
> =20
>  static int selinux_task_getsid(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSESSION, NULL);
> @@ -4062,11 +4305,17 @@ static int selinux_task_getsid(struct task_stru=
ct *p)
> =20
>  static void selinux_task_getsecid(struct task_struct *p, u32 *secid)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	*secid =3D task_sid(p);
>  }
> =20
>  static int selinux_task_setnice(struct task_struct *p, int nice)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
> @@ -4074,6 +4323,9 @@ static int selinux_task_setnice(struct task_struc=
t *p, int nice)
> =20
>  static int selinux_task_setioprio(struct task_struct *p, int ioprio)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
> @@ -4081,6 +4333,9 @@ static int selinux_task_setioprio(struct task_str=
uct *p, int ioprio)
> =20
>  static int selinux_task_getioprio(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSCHED, NULL);
> @@ -4091,6 +4346,9 @@ static int selinux_task_prlimit(const struct cred=
 *cred, const struct cred *tcre
>  {
>  	u32 av =3D 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!flags)
>  		return 0;
>  	if (flags & LSM_PRLIMIT_WRITE)
> @@ -4107,6 +4365,9 @@ static int selinux_task_setrlimit(struct task_str=
uct *p, unsigned int resource,
>  {
>  	struct rlimit *old_rlim =3D p->signal->rlim + resource;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	/* Control the ability to change the hard limit (whether
>  	   lowering or raising it), so that the hard limit can
>  	   later be used as a safe reset point for the soft limit
> @@ -4121,6 +4382,9 @@ static int selinux_task_setrlimit(struct task_str=
uct *p, unsigned int resource,
> =20
>  static int selinux_task_setscheduler(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
> @@ -4128,6 +4392,9 @@ static int selinux_task_setscheduler(struct task_=
struct *p)
> =20
>  static int selinux_task_getscheduler(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__GETSCHED, NULL);
> @@ -4135,6 +4402,9 @@ static int selinux_task_getscheduler(struct task_=
struct *p)
> =20
>  static int selinux_task_movememory(struct task_struct *p)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), task_sid(p), SECCLASS_PROCESS,
>  			    PROCESS__SETSCHED, NULL);
> @@ -4146,6 +4416,9 @@ static int selinux_task_kill(struct task_struct *=
p, struct kernel_siginfo *info,
>  	u32 secid;
>  	u32 perm;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!sig)
>  		perm =3D PROCESS__SIGNULL; /* null signal; existence test */
>  	else
> @@ -4162,11 +4435,13 @@ static void selinux_task_to_inode(struct task_s=
truct *p,
>  				  struct inode *inode)
>  {
>  	struct inode_security_struct *isec =3D selinux_inode(inode);
> -	u32 sid =3D task_sid(p);
> +
> +	if (selinux_disabled(&selinux_state))
> +		return;
> =20
>  	spin_lock(&isec->lock);
>  	isec->sclass =3D inode_mode_to_security_class(inode->i_mode);
> -	isec->sid =3D sid;
> +	isec->sid =3D task_sid(p);
>  	isec->initialized =3D LABEL_INITIALIZED;
>  	spin_unlock(&isec->lock);
>  }
> @@ -4506,6 +4781,9 @@ static int selinux_socket_create(int family, int =
type,
>  	if (kern)
>  		return 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	secclass =3D socket_type_to_security_class(family, type, protocol);
>  	rc =3D socket_sockcreate_sid(tsec, secclass, &newsid);
>  	if (rc)
> @@ -4525,6 +4803,9 @@ static int selinux_socket_post_create(struct sock=
et *sock, int family,
>  	u32 sid =3D SECINITSID_KERNEL;
>  	int err =3D 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!kern) {
>  		err =3D socket_sockcreate_sid(tsec, sclass, &sid);
>  		if (err)
> @@ -4555,6 +4836,9 @@ static int selinux_socket_socketpair(struct socke=
t *socka,
>  	struct sk_security_struct *sksec_a =3D socka->sk->sk_security;
>  	struct sk_security_struct *sksec_b =3D sockb->sk->sk_security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	sksec_a->peer_sid =3D sksec_b->sid;
>  	sksec_b->peer_sid =3D sksec_a->sid;
> =20
> @@ -4572,6 +4856,9 @@ static int selinux_socket_bind(struct socket *soc=
k, struct sockaddr *address, in
>  	u16 family;
>  	int err;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err =3D sock_has_perm(sk, SOCKET__BIND);
>  	if (err)
>  		goto out;
> @@ -4796,6 +5083,9 @@ static int selinux_socket_connect(struct socket *=
sock,
>  	int err;
>  	struct sock *sk =3D sock->sk;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err =3D selinux_socket_connect_helper(sock, address, addrlen);
>  	if (err)
>  		return err;
> @@ -4805,6 +5095,9 @@ static int selinux_socket_connect(struct socket *=
sock,
> =20
>  static int selinux_socket_listen(struct socket *sock, int backlog)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__LISTEN);
>  }
> =20
> @@ -4816,6 +5109,9 @@ static int selinux_socket_accept(struct socket *s=
ock, struct socket *newsock)
>  	u16 sclass;
>  	u32 sid;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err =3D sock_has_perm(sock->sk, SOCKET__ACCEPT);
>  	if (err)
>  		return err;
> @@ -4837,22 +5133,34 @@ static int selinux_socket_accept(struct socket =
*sock, struct socket *newsock)
>  static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *=
msg,
>  				  int size)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__WRITE);
>  }
> =20
>  static int selinux_socket_recvmsg(struct socket *sock, struct msghdr *=
msg,
>  				  int size, int flags)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__READ);
>  }
> =20
>  static int selinux_socket_getsockname(struct socket *sock)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__GETATTR);
>  }
> =20
>  static int selinux_socket_getpeername(struct socket *sock)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__GETATTR);
>  }
> =20
> @@ -4860,6 +5168,9 @@ static int selinux_socket_setsockopt(struct socke=
t *sock, int level, int optname
>  {
>  	int err;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err =3D sock_has_perm(sock->sk, SOCKET__SETOPT);
>  	if (err)
>  		return err;
> @@ -4870,11 +5181,17 @@ static int selinux_socket_setsockopt(struct soc=
ket *sock, int level, int optname
>  static int selinux_socket_getsockopt(struct socket *sock, int level,
>  				     int optname)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__GETOPT);
>  }
> =20
>  static int selinux_socket_shutdown(struct socket *sock, int how)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return sock_has_perm(sock->sk, SOCKET__SHUTDOWN);
>  }
> =20
> @@ -4889,6 +5206,9 @@ static int selinux_socket_unix_stream_connect(str=
uct sock *sock,
>  	struct lsm_network_audit net =3D {0,};
>  	int err;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type =3D LSM_AUDIT_DATA_NET;
>  	ad.u.net =3D &net;
>  	ad.u.net->sk =3D other;
> @@ -4921,6 +5241,9 @@ static int selinux_socket_unix_may_send(struct so=
cket *sock,
>  	struct common_audit_data ad;
>  	struct lsm_network_audit net =3D {0,};
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ad.type =3D LSM_AUDIT_DATA_NET;
>  	ad.u.net =3D &net;
>  	ad.u.net->sk =3D other->sk;
> @@ -4994,13 +5317,15 @@ static int selinux_socket_sock_rcv_skb(struct s=
ock *sk, struct sk_buff *skb)
>  	int err;
>  	struct sk_security_struct *sksec =3D sk->sk_security;
>  	u16 family =3D sk->sk_family;
> -	u32 sk_sid =3D sksec->sid;
>  	struct common_audit_data ad;
>  	struct lsm_network_audit net =3D {0,};
>  	char *addrp;
>  	u8 secmark_active;
>  	u8 peerlbl_active;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (family !=3D PF_INET && family !=3D PF_INET6)
>  		return 0;
> =20
> @@ -5041,7 +5366,7 @@ static int selinux_socket_sock_rcv_skb(struct soc=
k *sk, struct sk_buff *skb)
>  			return err;
>  		}
>  		err =3D avc_has_perm(&selinux_state,
> -				   sk_sid, peer_sid, SECCLASS_PEER,
> +				   sksec->sid, peer_sid, SECCLASS_PEER,
>  				   PEER__RECV, &ad);
>  		if (err) {
>  			selinux_netlbl_err(skb, family, err, 0);
> @@ -5051,7 +5376,7 @@ static int selinux_socket_sock_rcv_skb(struct soc=
k *sk, struct sk_buff *skb)
> =20
>  	if (secmark_active) {
>  		err =3D avc_has_perm(&selinux_state,
> -				   sk_sid, skb->secmark, SECCLASS_PACKET,
> +				   sksec->sid, skb->secmark, SECCLASS_PACKET,
>  				   PACKET__RECV, &ad);
>  		if (err)
>  			return err;
> @@ -5069,6 +5394,9 @@ static int selinux_socket_getpeersec_stream(struc=
t socket *sock, char __user *op
>  	struct sk_security_struct *sksec =3D sock->sk->sk_security;
>  	u32 peer_sid =3D SECSID_NULL;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (sksec->sclass =3D=3D SECCLASS_UNIX_STREAM_SOCKET ||
>  	    sksec->sclass =3D=3D SECCLASS_TCP_SOCKET ||
>  	    sksec->sclass =3D=3D SECCLASS_SCTP_SOCKET)
> @@ -5102,6 +5430,9 @@ static int selinux_socket_getpeersec_dgram(struct=
 socket *sock, struct sk_buff *
>  	u16 family;
>  	struct inode_security_struct *isec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (skb && skb->protocol =3D=3D htons(ETH_P_IP))
>  		family =3D PF_INET;
>  	else if (skb && skb->protocol =3D=3D htons(ETH_P_IPV6))
> @@ -5128,6 +5459,9 @@ static int selinux_sk_alloc_security(struct sock =
*sk, int family, gfp_t priority
>  {
>  	struct sk_security_struct *sksec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	sksec =3D kzalloc(sizeof(*sksec), priority);
>  	if (!sksec)
>  		return -ENOMEM;
> @@ -5145,6 +5479,9 @@ static void selinux_sk_free_security(struct sock =
*sk)
>  {
>  	struct sk_security_struct *sksec =3D sk->sk_security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	sk->sk_security =3D NULL;
>  	selinux_netlbl_sk_security_free(sksec);
>  	kfree(sksec);
> @@ -5155,6 +5492,9 @@ static void selinux_sk_clone_security(const struc=
t sock *sk, struct sock *newsk)
>  	struct sk_security_struct *sksec =3D sk->sk_security;
>  	struct sk_security_struct *newsksec =3D newsk->sk_security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	newsksec->sid =3D sksec->sid;
>  	newsksec->peer_sid =3D sksec->peer_sid;
>  	newsksec->sclass =3D sksec->sclass;
> @@ -5164,6 +5504,9 @@ static void selinux_sk_clone_security(const struc=
t sock *sk, struct sock *newsk)
> =20
>  static void selinux_sk_getsecid(struct sock *sk, u32 *secid)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	if (!sk)
>  		*secid =3D SECINITSID_ANY_SOCKET;
>  	else {
> @@ -5175,10 +5518,14 @@ static void selinux_sk_getsecid(struct sock *sk=
, u32 *secid)
> =20
>  static void selinux_sock_graft(struct sock *sk, struct socket *parent)=

>  {
> -	struct inode_security_struct *isec =3D
> -		inode_security_novalidate(SOCK_INODE(parent));
> +	struct inode_security_struct *isec;
>  	struct sk_security_struct *sksec =3D sk->sk_security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
> +	isec =3D inode_security_novalidate(SOCK_INODE(parent));
> +
>  	if (sk->sk_family =3D=3D PF_INET || sk->sk_family =3D=3D PF_INET6 ||
>  	    sk->sk_family =3D=3D PF_UNIX)
>  		isec->sid =3D sksec->sid;
> @@ -5200,6 +5547,9 @@ static int selinux_sctp_assoc_request(struct sctp=
_endpoint *ep,
>  	u32 conn_sid;
>  	int err =3D 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!selinux_policycap_extsockclass())
>  		return 0;
> =20
> @@ -5270,6 +5620,9 @@ static int selinux_sctp_bind_connect(struct sock =
*sk, int optname,
>  	struct sockaddr *addr;
>  	struct socket *sock;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (!selinux_policycap_extsockclass())
>  		return 0;
> =20
> @@ -5346,6 +5699,9 @@ static void selinux_sctp_sk_clone(struct sctp_end=
point *ep, struct sock *sk,
>  	struct sk_security_struct *sksec =3D sk->sk_security;
>  	struct sk_security_struct *newsksec =3D newsk->sk_security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	/* If policy does not support SECCLASS_SCTP_SOCKET then call
>  	 * the non-sctp clone version.
>  	 */
> @@ -5367,6 +5723,9 @@ static int selinux_inet_conn_request(struct sock =
*sk, struct sk_buff *skb,
>  	u32 connsid;
>  	u32 peersid;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err =3D selinux_skb_peerlbl_sid(skb, family, &peersid);
>  	if (err)
>  		return err;
> @@ -5384,6 +5743,9 @@ static void selinux_inet_csk_clone(struct sock *n=
ewsk,
>  {
>  	struct sk_security_struct *newsksec =3D newsk->sk_security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	newsksec->sid =3D req->secid;
>  	newsksec->peer_sid =3D req->peer_secid;
>  	/* NOTE: Ideally, we should also get the isec->sid for the
> @@ -5401,6 +5763,9 @@ static void selinux_inet_conn_established(struct =
sock *sk, struct sk_buff *skb)
>  	u16 family =3D sk->sk_family;
>  	struct sk_security_struct *sksec =3D sk->sk_security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	/* handle mapped IPv4 packets arriving via IPv6 sockets */
>  	if (family =3D=3D PF_INET6 && skb->protocol =3D=3D htons(ETH_P_IP))
>  		family =3D PF_INET;
> @@ -5413,6 +5778,9 @@ static int selinux_secmark_relabel_packet(u32 sid=
)
>  	const struct task_security_struct *__tsec;
>  	u32 tsid;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	__tsec =3D selinux_cred(current_cred());
>  	tsid =3D __tsec->sid;
> =20
> @@ -5423,17 +5791,26 @@ static int selinux_secmark_relabel_packet(u32 s=
id)
> =20
>  static void selinux_secmark_refcount_inc(void)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	atomic_inc(&selinux_secmark_refcount);
>  }
> =20
>  static void selinux_secmark_refcount_dec(void)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	atomic_dec(&selinux_secmark_refcount);
>  }
> =20
>  static void selinux_req_classify_flow(const struct request_sock *req,
>  				      struct flowi *fl)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	fl->flowi_secid =3D req->secid;
>  }
> =20
> @@ -5441,6 +5818,9 @@ static int selinux_tun_dev_alloc_security(void **=
security)
>  {
>  	struct tun_security_struct *tunsec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	tunsec =3D kzalloc(sizeof(*tunsec), GFP_KERNEL);
>  	if (!tunsec)
>  		return -ENOMEM;
> @@ -5452,12 +5832,20 @@ static int selinux_tun_dev_alloc_security(void =
**security)
> =20
>  static void selinux_tun_dev_free_security(void *security)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	kfree(security);
>  }
> =20
>  static int selinux_tun_dev_create(void)
>  {
> -	u32 sid =3D current_sid();
> +	u32 sid;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid =3D current_sid();
> =20
>  	/* we aren't taking into account the "sockcreate" SID since the socke=
t
>  	 * that is being created here is not a socket in the traditional sens=
e,
> @@ -5475,6 +5863,9 @@ static int selinux_tun_dev_attach_queue(void *sec=
urity)
>  {
>  	struct tun_security_struct *tunsec =3D security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return avc_has_perm(&selinux_state,
>  			    current_sid(), tunsec->sid, SECCLASS_TUN_SOCKET,
>  			    TUN_SOCKET__ATTACH_QUEUE, NULL);
> @@ -5485,6 +5876,9 @@ static int selinux_tun_dev_attach(struct sock *sk=
, void *security)
>  	struct tun_security_struct *tunsec =3D security;
>  	struct sk_security_struct *sksec =3D sk->sk_security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	/* we don't currently perform any NetLabel based labeling here and it=

>  	 * isn't clear that we would want to do so anyway; while we could app=
ly
>  	 * labeling without the support of the TUN user the resulting labeled=

> @@ -5501,8 +5895,13 @@ static int selinux_tun_dev_attach(struct sock *s=
k, void *security)
>  static int selinux_tun_dev_open(void *security)
>  {
>  	struct tun_security_struct *tunsec =3D security;
> -	u32 sid =3D current_sid();
>  	int err;
> +	u32 sid;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid =3D current_sid();
> =20
>  	err =3D avc_has_perm(&selinux_state,
>  			   sid, tunsec->sid, SECCLASS_TUN_SOCKET,
> @@ -5885,6 +6284,9 @@ static unsigned int selinux_ipv6_postroute(void *=
priv,
> =20
>  static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return selinux_nlmsg_perm(sk, skb);
>  }
> =20
> @@ -5922,6 +6324,9 @@ static int ipc_has_perm(struct kern_ipc_perm *ipc=
_perms,
> =20
>  static int selinux_msg_msg_alloc_security(struct msg_msg *msg)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return msg_msg_alloc_security(msg);
>  }
> =20
> @@ -5930,9 +6335,11 @@ static int selinux_msg_queue_alloc_security(stru=
ct kern_ipc_perm *msq)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid =3D current_sid();
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	isec =3D selinux_ipc(msq);
>  	ipc_init_security(isec, SECCLASS_MSGQ);
> =20
> @@ -5940,7 +6347,7 @@ static int selinux_msg_queue_alloc_security(struc=
t kern_ipc_perm *msq)
>  	ad.u.ipc_id =3D msq->key;
> =20
>  	rc =3D avc_has_perm(&selinux_state,
> -			  sid, isec->sid, SECCLASS_MSGQ,
> +			  current_sid(), isec->sid, SECCLASS_MSGQ,
>  			  MSGQ__CREATE, &ad);
>  	return rc;
>  }
> @@ -5949,7 +6356,9 @@ static int selinux_msg_queue_associate(struct ker=
n_ipc_perm *msq, int msqflg)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid =3D current_sid();
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
>  	isec =3D selinux_ipc(msq);
> =20
> @@ -5957,7 +6366,7 @@ static int selinux_msg_queue_associate(struct ker=
n_ipc_perm *msq, int msqflg)
>  	ad.u.ipc_id =3D msq->key;
> =20
>  	return avc_has_perm(&selinux_state,
> -			    sid, isec->sid, SECCLASS_MSGQ,
> +			    current_sid(), isec->sid, SECCLASS_MSGQ,
>  			    MSGQ__ASSOCIATE, &ad);
>  }
> =20
> @@ -5966,6 +6375,9 @@ static int selinux_msg_queue_msgctl(struct kern_i=
pc_perm *msq, int cmd)
>  	int err;
>  	int perms;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case IPC_INFO:
>  	case MSG_INFO:
> @@ -5997,9 +6409,14 @@ static int selinux_msg_queue_msgsnd(struct kern_=
ipc_perm *msq, struct msg_msg *m
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
>  	struct common_audit_data ad;
> -	u32 sid =3D current_sid();
> +	u32 sid;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid =3D current_sid();
> +
>  	isec =3D selinux_ipc(msq);
>  	msec =3D selinux_msg_msg(msg);
> =20
> @@ -6045,9 +6462,14 @@ static int selinux_msg_queue_msgrcv(struct kern_=
ipc_perm *msq, struct msg_msg *m
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
>  	struct common_audit_data ad;
> -	u32 sid =3D task_sid(target);
> +	u32 sid;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid =3D task_sid(target);
> +
>  	isec =3D selinux_ipc(msq);
>  	msec =3D selinux_msg_msg(msg);
> =20
> @@ -6069,9 +6491,11 @@ static int selinux_shm_alloc_security(struct ker=
n_ipc_perm *shp)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid =3D current_sid();
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	isec =3D selinux_ipc(shp);
>  	ipc_init_security(isec, SECCLASS_SHM);
> =20
> @@ -6079,8 +6503,8 @@ static int selinux_shm_alloc_security(struct kern=
_ipc_perm *shp)
>  	ad.u.ipc_id =3D shp->key;
> =20
>  	rc =3D avc_has_perm(&selinux_state,
> -			  sid, isec->sid, SECCLASS_SHM,
> -			  SHM__CREATE, &ad);
> +			  current_sid(), isec->sid,
> +			  SECCLASS_SHM, SHM__CREATE, &ad);
>  	return rc;
>  }
> =20
> @@ -6088,7 +6512,9 @@ static int selinux_shm_associate(struct kern_ipc_=
perm *shp, int shmflg)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid =3D current_sid();
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
>  	isec =3D selinux_ipc(shp);
> =20
> @@ -6096,8 +6522,8 @@ static int selinux_shm_associate(struct kern_ipc_=
perm *shp, int shmflg)
>  	ad.u.ipc_id =3D shp->key;
> =20
>  	return avc_has_perm(&selinux_state,
> -			    sid, isec->sid, SECCLASS_SHM,
> -			    SHM__ASSOCIATE, &ad);
> +			    current_sid(), isec->sid,
> +			    SECCLASS_SHM, SHM__ASSOCIATE, &ad);
>  }
> =20
>  /* Note, at this point, shp is locked down */
> @@ -6106,6 +6532,9 @@ static int selinux_shm_shmctl(struct kern_ipc_per=
m *shp, int cmd)
>  	int perms;
>  	int err;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case IPC_INFO:
>  	case SHM_INFO:
> @@ -6141,6 +6570,9 @@ static int selinux_shm_shmat(struct kern_ipc_perm=
 *shp,
>  {
>  	u32 perms;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (shmflg & SHM_RDONLY)
>  		perms =3D SHM__READ;
>  	else
> @@ -6154,9 +6586,11 @@ static int selinux_sem_alloc_security(struct ker=
n_ipc_perm *sma)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid =3D current_sid();
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	isec =3D selinux_ipc(sma);
>  	ipc_init_security(isec, SECCLASS_SEM);
> =20
> @@ -6164,8 +6598,8 @@ static int selinux_sem_alloc_security(struct kern=
_ipc_perm *sma)
>  	ad.u.ipc_id =3D sma->key;
> =20
>  	rc =3D avc_has_perm(&selinux_state,
> -			  sid, isec->sid, SECCLASS_SEM,
> -			  SEM__CREATE, &ad);
> +			  current_sid(), isec->sid,
> +			  SECCLASS_SEM, SEM__CREATE, &ad);
>  	return rc;
>  }
> =20
> @@ -6173,7 +6607,9 @@ static int selinux_sem_associate(struct kern_ipc_=
perm *sma, int semflg)
>  {
>  	struct ipc_security_struct *isec;
>  	struct common_audit_data ad;
> -	u32 sid =3D current_sid();
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> =20
>  	isec =3D selinux_ipc(sma);
> =20
> @@ -6181,8 +6617,8 @@ static int selinux_sem_associate(struct kern_ipc_=
perm *sma, int semflg)
>  	ad.u.ipc_id =3D sma->key;
> =20
>  	return avc_has_perm(&selinux_state,
> -			    sid, isec->sid, SECCLASS_SEM,
> -			    SEM__ASSOCIATE, &ad);
> +			    current_sid(), isec->sid,
> +			    SECCLASS_SEM, SEM__ASSOCIATE, &ad);
>  }
> =20
>  /* Note, at this point, sma is locked down */
> @@ -6191,6 +6627,9 @@ static int selinux_sem_semctl(struct kern_ipc_per=
m *sma, int cmd)
>  	int err;
>  	u32 perms;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case IPC_INFO:
>  	case SEM_INFO:
> @@ -6235,6 +6674,9 @@ static int selinux_sem_semop(struct kern_ipc_perm=
 *sma,
>  {
>  	u32 perms;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (alter)
>  		perms =3D SEM__READ | SEM__WRITE;
>  	else
> @@ -6247,7 +6689,9 @@ static int selinux_ipc_permission(struct kern_ipc=
_perm *ipcp, short flag)
>  {
>  	u32 av =3D 0;
> =20
> -	av =3D 0;
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (flag & S_IRUGO)
>  		av |=3D IPC__UNIX_READ;
>  	if (flag & S_IWUGO)
> @@ -6261,12 +6705,17 @@ static int selinux_ipc_permission(struct kern_i=
pc_perm *ipcp, short flag)
> =20
>  static void selinux_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *seci=
d)
>  {
> -	struct ipc_security_struct *isec =3D selinux_ipc(ipcp);
> -	*secid =3D isec->sid;
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
> +	*secid =3D selinux_ipc(ipcp)->sid;
>  }
> =20
>  static void selinux_d_instantiate(struct dentry *dentry, struct inode =
*inode)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	if (inode)
>  		inode_doinit_with_dentry(inode, dentry);
>  }
> @@ -6279,6 +6728,9 @@ static int selinux_getprocattr(struct task_struct=
 *p,
>  	int error;
>  	unsigned len;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return -EINVAL;
> +
>  	rcu_read_lock();
>  	__tsec =3D selinux_cred(__task_cred(p));
> =20
> @@ -6325,10 +6777,15 @@ static int selinux_setprocattr(const char *name=
, void *value, size_t size)
>  {
>  	struct task_security_struct *tsec;
>  	struct cred *new;
> -	u32 mysid =3D current_sid(), sid =3D 0, ptsid;
> +	u32 mysid, sid =3D 0, ptsid;
>  	int error;
>  	char *str =3D value;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return -EINVAL;
> +
> +	mysid =3D current_sid();
> +
>  	/*
>  	 * Basic control over ability to set these attributes at all.
>  	 */
> @@ -6466,17 +6923,26 @@ abort_change:
> =20
>  static int selinux_ismaclabel(const char *name)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return (strcmp(name, XATTR_SELINUX_SUFFIX) =3D=3D 0);
>  }
> =20
>  static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *sec=
len)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return -EOPNOTSUPP;
> +
>  	return security_sid_to_context(&selinux_state, secid,
>  				       secdata, seclen);
>  }
> =20
>  static int selinux_secctx_to_secid(const char *secdata, u32 seclen, u3=
2 *secid)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return security_context_to_sid(&selinux_state, secdata, seclen,
>  				       secid, GFP_KERNEL);
>  }
> @@ -6490,6 +6956,9 @@ static void selinux_inode_invalidate_secctx(struc=
t inode *inode)
>  {
>  	struct inode_security_struct *isec =3D selinux_inode(inode);
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	spin_lock(&isec->lock);
>  	isec->initialized =3D LABEL_INVALID;
>  	spin_unlock(&isec->lock);
> @@ -6511,6 +6980,9 @@ static int selinux_inode_notifysecctx(struct inod=
e *inode, void *ctx, u32 ctxlen
>   */
>  static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u=
32 ctxlen)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	return __vfs_setxattr_noperm(dentry, XATTR_NAME_SELINUX, ctx, ctxlen,=
 0);
>  }
> =20
> @@ -6532,6 +7004,9 @@ static int selinux_key_alloc(struct key *k, const=
 struct cred *cred,
>  	const struct task_security_struct *tsec;
>  	struct key_security_struct *ksec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	ksec =3D kzalloc(sizeof(struct key_security_struct), GFP_KERNEL);
>  	if (!ksec)
>  		return -ENOMEM;
> @@ -6550,6 +7025,9 @@ static void selinux_key_free(struct key *k)
>  {
>  	struct key_security_struct *ksec =3D k->security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	k->security =3D NULL;
>  	kfree(ksec);
>  }
> @@ -6568,6 +7046,9 @@ static int selinux_key_permission(key_ref_t key_r=
ef,
>  	if (perm =3D=3D 0)
>  		return 0;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	sid =3D cred_sid(cred);
> =20
>  	key =3D key_ref_to_ptr(key_ref);
> @@ -6584,6 +7065,9 @@ static int selinux_key_getsecurity(struct key *ke=
y, char **_buffer)
>  	unsigned len;
>  	int rc;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	rc =3D security_sid_to_context(&selinux_state, ksec->sid,
>  				     &context, &len);
>  	if (!rc)
> @@ -6602,6 +7086,9 @@ static int selinux_ib_pkey_access(void *ib_sec, u=
64 subnet_prefix, u16 pkey_val)
>  	struct ib_security_struct *sec =3D ib_sec;
>  	struct lsm_ibpkey_audit ibpkey;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err =3D sel_ib_pkey_sid(subnet_prefix, pkey_val, &sid);
>  	if (err)
>  		return err;
> @@ -6625,6 +7112,9 @@ static int selinux_ib_endport_manage_subnet(void =
*ib_sec, const char *dev_name,
>  	struct ib_security_struct *sec =3D ib_sec;
>  	struct lsm_ibendport_audit ibendport;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	err =3D security_ib_endport_sid(&selinux_state, dev_name, port_num,
>  				      &sid);
> =20
> @@ -6645,6 +7135,9 @@ static int selinux_ib_alloc_security(void **ib_se=
c)
>  {
>  	struct ib_security_struct *sec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	sec =3D kzalloc(sizeof(*sec), GFP_KERNEL);
>  	if (!sec)
>  		return -ENOMEM;
> @@ -6656,6 +7149,9 @@ static int selinux_ib_alloc_security(void **ib_se=
c)
> =20
>  static void selinux_ib_free_security(void *ib_sec)
>  {
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	kfree(ib_sec);
>  }
>  #endif
> @@ -6667,6 +7163,9 @@ static int selinux_bpf(int cmd, union bpf_attr *a=
ttr,
>  	u32 sid =3D current_sid();
>  	int ret;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	switch (cmd) {
>  	case BPF_MAP_CREATE:
>  		ret =3D avc_has_perm(&selinux_state,
> @@ -6734,23 +7233,27 @@ static int bpf_fd_pass(struct file *file, u32 s=
id)
> =20
>  static int selinux_bpf_map(struct bpf_map *map, fmode_t fmode)
>  {
> -	u32 sid =3D current_sid();
>  	struct bpf_security_struct *bpfsec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	bpfsec =3D map->security;
>  	return avc_has_perm(&selinux_state,
> -			    sid, bpfsec->sid, SECCLASS_BPF,
> +			    current_sid(), bpfsec->sid, SECCLASS_BPF,
>  			    bpf_map_fmode_to_av(fmode), NULL);
>  }
> =20
>  static int selinux_bpf_prog(struct bpf_prog *prog)
>  {
> -	u32 sid =3D current_sid();
>  	struct bpf_security_struct *bpfsec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	bpfsec =3D prog->aux->security;
>  	return avc_has_perm(&selinux_state,
> -			    sid, bpfsec->sid, SECCLASS_BPF,
> +			    current_sid(), bpfsec->sid, SECCLASS_BPF,
>  			    BPF__PROG_RUN, NULL);
>  }
> =20
> @@ -6758,6 +7261,9 @@ static int selinux_bpf_map_alloc(struct bpf_map *=
map)
>  {
>  	struct bpf_security_struct *bpfsec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>  	if (!bpfsec)
>  		return -ENOMEM;
> @@ -6772,6 +7278,9 @@ static void selinux_bpf_map_free(struct bpf_map *=
map)
>  {
>  	struct bpf_security_struct *bpfsec =3D map->security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	map->security =3D NULL;
>  	kfree(bpfsec);
>  }
> @@ -6780,6 +7289,9 @@ static int selinux_bpf_prog_alloc(struct bpf_prog=
_aux *aux)
>  {
>  	struct bpf_security_struct *bpfsec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	bpfsec =3D kzalloc(sizeof(*bpfsec), GFP_KERNEL);
>  	if (!bpfsec)
>  		return -ENOMEM;
> @@ -6794,6 +7306,9 @@ static void selinux_bpf_prog_free(struct bpf_prog=
_aux *aux)
>  {
>  	struct bpf_security_struct *bpfsec =3D aux->security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	aux->security =3D NULL;
>  	kfree(bpfsec);
>  }
> @@ -6802,11 +7317,14 @@ static void selinux_bpf_prog_free(struct bpf_pr=
og_aux *aux)
>  static int selinux_lockdown(enum lockdown_reason what)
>  {
>  	struct common_audit_data ad;
> -	u32 sid =3D current_sid();
> +	u32 sid;
>  	int invalid_reason =3D (what <=3D LOCKDOWN_NONE) ||
>  			     (what =3D=3D LOCKDOWN_INTEGRITY_MAX) ||
>  			     (what >=3D LOCKDOWN_CONFIDENTIALITY_MAX);
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	if (WARN(invalid_reason, "Invalid lockdown reason")) {
>  		audit_log(audit_context(),
>  			  GFP_ATOMIC, AUDIT_SELINUX_ERR,
> @@ -6814,6 +7332,8 @@ static int selinux_lockdown(enum lockdown_reason =
what)
>  		return -EINVAL;
>  	}
> =20
> +	sid =3D current_sid();
> +
>  	ad.type =3D LSM_AUDIT_DATA_LOCKDOWN;
>  	ad.u.reason =3D what;
> =20
> @@ -6827,7 +7347,7 @@ static int selinux_lockdown(enum lockdown_reason =
what)
>  				    LOCKDOWN__CONFIDENTIALITY, &ad);
>  }
> =20
> -struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init =3D {
> +struct lsm_blob_sizes selinux_blob_sizes __ro_after_init =3D {
>  	.lbs_cred =3D sizeof(struct task_security_struct),
>  	.lbs_file =3D sizeof(struct file_security_struct),
>  	.lbs_inode =3D sizeof(struct inode_security_struct),
> @@ -6838,7 +7358,12 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_r=
o_after_init =3D {
>  #ifdef CONFIG_PERF_EVENTS
>  static int selinux_perf_event_open(struct perf_event_attr *attr, int t=
ype)
>  {
> -	u32 requested, sid =3D current_sid();
> +	u32 requested, sid;
> +
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	sid =3D current_sid();
> =20
>  	if (type =3D=3D PERF_SECURITY_OPEN)
>  		requested =3D PERF_EVENT__OPEN;
> @@ -6859,6 +7384,9 @@ static int selinux_perf_event_alloc(struct perf_e=
vent *event)
>  {
>  	struct perf_event_security_struct *perfsec;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
>  	perfsec =3D kzalloc(sizeof(*perfsec), GFP_KERNEL);
>  	if (!perfsec)
>  		return -ENOMEM;
> @@ -6873,6 +7401,9 @@ static void selinux_perf_event_free(struct perf_e=
vent *event)
>  {
>  	struct perf_event_security_struct *perfsec =3D event->security;
> =20
> +	if (selinux_disabled(&selinux_state))
> +		return;
> +
>  	event->security =3D NULL;
>  	kfree(perfsec);
>  }
> @@ -6880,23 +7411,27 @@ static void selinux_perf_event_free(struct perf=
_event *event)
>  static int selinux_perf_event_read(struct perf_event *event)
>  {
>  	struct perf_event_security_struct *perfsec =3D event->security;
> -	u32 sid =3D current_sid();
> =20
> -	return avc_has_perm(&selinux_state, sid, perfsec->sid,
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	return avc_has_perm(&selinux_state, current_sid(), perfsec->sid,
>  			    SECCLASS_PERF_EVENT, PERF_EVENT__READ, NULL);
>  }
> =20
>  static int selinux_perf_event_write(struct perf_event *event)
>  {
>  	struct perf_event_security_struct *perfsec =3D event->security;
> -	u32 sid =3D current_sid();
> =20
> -	return avc_has_perm(&selinux_state, sid, perfsec->sid,
> +	if (selinux_disabled(&selinux_state))
> +		return 0;
> +
> +	return avc_has_perm(&selinux_state, current_sid(), perfsec->sid,
>  			    SECCLASS_PERF_EVENT, PERF_EVENT__WRITE, NULL);
>  }
>  #endif
> =20
> -static struct security_hook_list selinux_hooks[] __lsm_ro_after_init =3D=
 {
> +static struct security_hook_list selinux_hooks[] __ro_after_init =3D {=

>  	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr)=
,
>  	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
>  	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder)=
,
> @@ -7315,18 +7850,19 @@ int selinux_disable(struct selinux_state *state=
)
>  		return -EINVAL;
>  	}
> =20
> +	/*
> +	 * Unregister netfilter hooks (must be done before
> +	 * selinux_mark_disabled()).
> +	 */
> +	selinux_nf_ip_exit();
> +
>  	selinux_mark_disabled(state);
> =20
>  	pr_info("SELinux:  Disabled at runtime.\n");
> =20
> -	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
> -
>  	/* Try to destroy the avc node cache */
>  	avc_disable();
> =20
> -	/* Unregister netfilter hooks. */
> -	selinux_nf_ip_exit();
> -
>  	/* Unregister selinuxfs. */
>  	exit_sel_fs();
> =20
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index ecea41ce919b..de50c69846e0 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4583,7 +4583,7 @@ static int smack_dentry_create_files_as(struct de=
ntry *dentry, int mode,
>  	return 0;
>  }
> =20
> -struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init =3D {
> +struct lsm_blob_sizes smack_blob_sizes __ro_after_init =3D {
>  	.lbs_cred =3D sizeof(struct task_smack),
>  	.lbs_file =3D sizeof(struct smack_known *),
>  	.lbs_inode =3D sizeof(struct inode_smack),
> @@ -4591,7 +4591,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_a=
fter_init =3D {
>  	.lbs_msg_msg =3D sizeof(struct smack_known *),
>  };
> =20
> -static struct security_hook_list smack_hooks[] __lsm_ro_after_init =3D=
 {
> +static struct security_hook_list smack_hooks[] __ro_after_init =3D {
>  	LSM_HOOK_INIT(ptrace_access_check, smack_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, smack_ptrace_traceme),
>  	LSM_HOOK_INIT(syslog, smack_syslog),
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 716c92ec941a..9dcdef99d431 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -486,7 +486,7 @@ static int tomoyo_socket_sendmsg(struct socket *soc=
k, struct msghdr *msg,
>  	return tomoyo_socket_sendmsg_permission(sock, msg, size);
>  }
> =20
> -struct lsm_blob_sizes tomoyo_blob_sizes __lsm_ro_after_init =3D {
> +struct lsm_blob_sizes tomoyo_blob_sizes __ro_after_init =3D {
>  	.lbs_task =3D sizeof(struct tomoyo_task),
>  };
> =20
> @@ -533,7 +533,7 @@ static void tomoyo_task_free(struct task_struct *ta=
sk)
>   * tomoyo_security_ops is a "struct security_operations" which is used=
 for
>   * registering TOMOYO.
>   */
> -static struct security_hook_list tomoyo_hooks[] __lsm_ro_after_init =3D=
 {
> +static struct security_hook_list tomoyo_hooks[] __ro_after_init =3D {
>  	LSM_HOOK_INIT(cred_prepare, tomoyo_cred_prepare),
>  	LSM_HOOK_INIT(bprm_committed_creds, tomoyo_bprm_committed_creds),
>  	LSM_HOOK_INIT(task_alloc, tomoyo_task_alloc),
> @@ -569,7 +569,7 @@ static struct security_hook_list tomoyo_hooks[] __l=
sm_ro_after_init =3D {
>  /* Lock for GC. */
>  DEFINE_SRCU(tomoyo_ss);
> =20
> -int tomoyo_enabled __lsm_ro_after_init =3D 1;
> +int tomoyo_enabled __ro_after_init =3D 1;
> =20
>  /**
>   * tomoyo_init - Register TOMOYO Linux as a LSM module.
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index 94dc346370b1..c47d4e09bfb4 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -421,7 +421,7 @@ static int yama_ptrace_traceme(struct task_struct *=
parent)
>  	return rc;
>  }
> =20
> -static struct security_hook_list yama_hooks[] __lsm_ro_after_init =3D =
{
> +static struct security_hook_list yama_hooks[] __ro_after_init =3D {
>  	LSM_HOOK_INIT(ptrace_access_check, yama_ptrace_access_check),
>  	LSM_HOOK_INIT(ptrace_traceme, yama_ptrace_traceme),
>  	LSM_HOOK_INIT(task_prctl, yama_task_prctl),

