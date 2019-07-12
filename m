Return-Path: <SRS0=P1AD=VJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6DEC742D6
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 17:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D952054F
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 17:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sd9o6LHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfGLR7G (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:59:06 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:45966
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbfGLR7G (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jul 2019 13:59:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562954341; bh=qz1iRg1RwDEm0gTgchTUhFMwJiO5GTNpvNW/JLuXiFs=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sd9o6LHSnF5nwwKuZ3PAFmP4dv2tQqozymsi5nMP8ycYA9+qH4PWxhKyymtcv3cy8YimApg6N6id117h2SvgH9k448bqyqN1+b2CPmKYC8SiYsoQJp5HJvcYxkB9nuC+ZvLMoY915X4+DOVerKmBU+RCUj4nbO11sxQti3e1k0qHE4v7pZj9lQWoU+ERL9X6zL0bd7VZHrLSbJDsDosQKn67be4NyN37mAtMDkMnZicx4luDmY/ABDDUYs9y7YmmuMC2zUR0HyT5QUtDQiMIze4DeR5EotjK0mt65egAqC/LK1MjF+njS4PbnMNpwMEKtnuZmtlm5leenPFAnMPrVg==
X-YMail-OSG: L_Vj_PQVM1k5N6tkoQEdFzdCjsKdOjqXZzE89X8jSvVIDYVbt_I3EnHuTCab9ZH
 MPOXSud5QFiQe1klvU.rsCi8QLM1v86aY5Q1mPgfkDqOaXxs4b4ZgpogSO3WebCeF21L75Ydd7rD
 I3LVBad4dsyGd7dOGLq6YO_kftzVzTdUD4RzziMyZyu_WDp0VJSLx6W4g8NLFYRARmhetVRIUPHn
 fY0N2FhhzSpenGUq5Zvf9V2wgX34Mzt7WyH2CNioaUTj.sNNMtBtql5fwl0OfbTieknJDjxvwlDY
 tyWIq.j2xr_o0uZbOr_d9YIOuOvlPa5xjies_A7qO6I3aQ65oWqFYNDlUPurTzusuQi5CxbjMiOQ
 .3hqjKeVbtDVnKR7xCwjSzGqEf00RJjf4aoGzC_r5cAcbZBiNFQx3dexnqsnInHACaviGo8CyRW0
 dK4F4kNlJOiwVj.geVAk51mHiqdCJhPMD2hxOtvxQX3I8lwrY8NsvtaBMNng9ZVAmaO_ht_qGQJm
 jW1oPcDDPV2EXxEr2k9MhmLV9Dkx4p73T62zrM2m1_3YY_d6SpVVDj9BM0336y23dcae7P.mKmqZ
 SASJ0D9UBJIeEEfnth_qgQDGNejxTwtFM27Nsuh_mogAw1eW6Fkg5NQHFHhctXMbtFZH4GsSGnOG
 fQXMJGBH1L1PFxKi6x6tci3etr4oljp6RY.F1d_KBON8DPEK4AJm_Dc0_0MJWw22ZoCOWmgLQyTp
 iETVoc7J9RF8P5fC9bVV00HzySVowS4QMHSG8PNk3p3Pxr6S0sLEy8ZESPo1aD471fWGsj2._1fO
 WtQynkAAs8.Ihuq743eVWUCBiWy35YTfi_Jda0OXtNdK9JB_CHka6_g9G0YAh_i8RiW1Fo7_KKOa
 vHG.TgiuM4wkq9crcdpA_D85yLAhs.4GoyhGRnqGyprs0FAi9mwYgszXjZlg8.ODzHDxLrDt_qwt
 S3SZUruGgPmp3AHnahZQBY_iuu13gAHgD0eF.ta2.hjrg4WBLkO_RMZB.zwX7G26KBjHnx7Z.rQK
 hC7LpWU._qvuYY9eTCoYI2Gdv48Dc_Tu5Bc2rPfTRqBMoRT869Zv3Mxzp9JInXMBIIwmqFrhIAu8
 OkCNzho1IQ3NiWiGh.H_bqwlmu1AkBjx7z.02vBe8zrbkycEOcNUpOiBWxvbU6IpK_VytBg9MYHb
 HIYNBMi8Hvs1hD.Jah7_RW2QDBI8mdGuWl_RfY2qwa1xE4hx_mjpotBeZB0ksDrZqzi20cLgobQo
 Yl902l6VtmgU7VB3w8S464t5_IDEjhzt2MlPW
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 12 Jul 2019 17:59:01 +0000
Received: by smtp419.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5d9e616ee99f5b301747f2d39473d023;
          Fri, 12 Jul 2019 17:58:57 +0000 (UTC)
Subject: Re: [RFC PATCH] security,capability: pass object information to
 security_capable
To:     Nicholas Franck <nhfran2@tycho.nsa.gov>, paul@paul-moore.com
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        luto@amacapital.net, jmorris@namei.org, sds@tycho.nsa.gov,
        keescook@chromium.org, serge@hallyn.com,
        john.johansen@canonical.com, mortonm@chromium.org,
        casey@schaufler-ca.com
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
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
Message-ID: <680c35a8-1ee5-725d-b33c-7bdced39763c@schaufler-ca.com>
Date:   Fri, 12 Jul 2019 10:58:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/12/2019 10:34 AM, Nicholas Franck wrote:
> At present security_capable does not pass any object information
> and therefore can neither audit the particular object nor take it
> into account. Augment the security_capable interface to support
> passing supplementary data. Use this facility initially to convey
> the inode for capability checks relevant to inodes. This only
> addresses capable_wrt_inode_uidgid calls; other capability checks
> relevant to inodes will be addressed in subsequent changes. In the
> future, this will be further extended to pass object information for
> other capability checks such as the target task for CAP_KILL.

This seems wrong to me. The capability system has nothing to do
with objects. Passing object information through security_capable()
may be convenient, but isn't relevant to the purpose of the interface.
It appears that there are very few places where the object information
is actually useful.

> In SELinux this new information is leveraged here to include the inode
> in the audit message. In the future, it could also be used to perform
> a per inode capability checks.

I suggest that you want a mechanism for adding the inode information
to the audit record instead.

What would a "per inode" capability check be? Capability checks are
process checks, not object checks.

> It would be possible to fold the existing opts argument into this new
> supplementary data structure. This was omitted from this change to
> minimize changes.
>
> Signed-off-by: Nicholas Franck <nhfran2@tycho.nsa.gov>
> ---
>  include/linux/capability.h             |  7 ++++++
>  include/linux/lsm_audit.h              |  5 +++-
>  include/linux/lsm_hooks.h              |  3 ++-
>  include/linux/security.h               | 23 +++++++++++++-----
>  kernel/capability.c                    | 33 ++++++++++++++++++--------=

>  kernel/seccomp.c                       |  2 +-
>  security/apparmor/capability.c         |  8 ++++---
>  security/apparmor/include/capability.h |  4 +++-
>  security/apparmor/ipc.c                |  2 +-
>  security/apparmor/lsm.c                |  5 ++--
>  security/apparmor/resource.c           |  2 +-
>  security/commoncap.c                   | 11 +++++----
>  security/lsm_audit.c                   | 21 ++++++++++++++--
>  security/safesetid/lsm.c               |  3 ++-
>  security/security.c                    |  5 ++--
>  security/selinux/hooks.c               | 20 +++++++++-------
>  security/smack/smack_access.c          |  2 +-
>  17 files changed, 110 insertions(+), 46 deletions(-)
>
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index ecce0f43c73a..f72de64c179d 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -211,6 +211,8 @@ extern bool capable(int cap);
>  extern bool ns_capable(struct user_namespace *ns, int cap);
>  extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
>  extern bool ns_capable_setid(struct user_namespace *ns, int cap);
> +extern bool ns_capable_inode(struct user_namespace *ns, int cap,
> +			     const struct inode *inode);
>  #else
>  static inline bool has_capability(struct task_struct *t, int cap)
>  {
> @@ -246,6 +248,11 @@ static inline bool ns_capable_setid(struct user_na=
mespace *ns, int cap)
>  {
>  	return true;
>  }
> +static bool ns_capable_inode(struct user_namespace *ns, int cap,
> +			     const struct inode *inode)
> +{
> +	return true;
> +}
>  #endif /* CONFIG_MULTIUSER */
>  extern bool privileged_wrt_inode_uidgid(struct user_namespace *ns, con=
st struct inode *inode);
>  extern bool capable_wrt_inode_uidgid(const struct inode *inode, int ca=
p);
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index 915330abf6e5..15d2a62639f0 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -79,7 +79,10 @@ struct common_audit_data {
>  		struct dentry *dentry;
>  		struct inode *inode;
>  		struct lsm_network_audit *net;
> -		int cap;
> +		struct  {
> +			int cap;

> +			struct cap_aux_data *cad;
> +		} cap_struct;
>  		int ipc_id;
>  		struct task_struct *tsk;
>  #ifdef CONFIG_KEYS
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 47f58cfb6a19..b2a37d613030 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1469,7 +1469,8 @@ union security_list_options {
>  	int (*capable)(const struct cred *cred,
>  			struct user_namespace *ns,
>  			int cap,
> -			unsigned int opts);
> +			unsigned int opts,
> +			struct cap_aux_data *cad);
>  	int (*quotactl)(int cmds, int type, int id, struct super_block *sb);
>  	int (*quota_on)(struct dentry *dentry);
>  	int (*syslog)(int type);
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 659071c2e57c..8fce5e69dc52 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -77,9 +77,18 @@ enum lsm_event {
>  	LSM_POLICY_CHANGE,
>  };
> =20
> +
> +struct cap_aux_data {
> +	char type;
> +#define CAP_AUX_DATA_INODE	1
> +	union	{
> +		const struct inode *inode;
> +	} u;
> +};
> +
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace =
*ns,
> -		       int cap, unsigned int opts);
> +		       int cap, unsigned int opts, struct cap_aux_data *cad);
>  extern int cap_settime(const struct timespec64 *ts, const struct timez=
one *tz);
>  extern int cap_ptrace_access_check(struct task_struct *child, unsigned=
 int mode);
>  extern int cap_ptrace_traceme(struct task_struct *parent);
> @@ -215,9 +224,10 @@ int security_capset(struct cred *new, const struct=
 cred *old,
>  		    const kernel_cap_t *inheritable,
>  		    const kernel_cap_t *permitted);
>  int security_capable(const struct cred *cred,
> -		       struct user_namespace *ns,
> -		       int cap,
> -		       unsigned int opts);
> +		     struct user_namespace *ns,
> +		     int cap,
> +		     unsigned int opts,
> +		     struct cap_aux_data *cad);
>  int security_quotactl(int cmds, int type, int id, struct super_block *=
sb);
>  int security_quota_on(struct dentry *dentry);
>  int security_syslog(int type);
> @@ -478,9 +488,10 @@ static inline int security_capset(struct cred *new=
,
>  static inline int security_capable(const struct cred *cred,
>  				   struct user_namespace *ns,
>  				   int cap,
> -				   unsigned int opts)
> +				   unsigned int opts,
> +				   struct cap_aux_data *cad)
>  {
> -	return cap_capable(cred, ns, cap, opts);
> +	return cap_capable(cred, ns, cap, opts, NULL);
>  }
> =20
>  static inline int security_quotactl(int cmds, int type, int id,
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 1444f3954d75..c3723443904a 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -297,7 +297,7 @@ bool has_ns_capability(struct task_struct *t,
>  	int ret;
> =20
>  	rcu_read_lock();
> -	ret =3D security_capable(__task_cred(t), ns, cap, CAP_OPT_NONE);
> +	ret =3D security_capable(__task_cred(t), ns, cap, CAP_OPT_NONE, NULL)=
;
>  	rcu_read_unlock();
> =20
>  	return (ret =3D=3D 0);
> @@ -338,7 +338,7 @@ bool has_ns_capability_noaudit(struct task_struct *=
t,
>  	int ret;
> =20
>  	rcu_read_lock();
> -	ret =3D security_capable(__task_cred(t), ns, cap, CAP_OPT_NOAUDIT);
> +	ret =3D security_capable(__task_cred(t), ns, cap, CAP_OPT_NOAUDIT, NU=
LL);
>  	rcu_read_unlock();
> =20
>  	return (ret =3D=3D 0);
> @@ -363,7 +363,8 @@ bool has_capability_noaudit(struct task_struct *t, =
int cap)
> =20
>  static bool ns_capable_common(struct user_namespace *ns,
>  			      int cap,
> -			      unsigned int opts)
> +			      unsigned int opts,
> +			      struct cap_aux_data *cad)
>  {
>  	int capable;
> =20
> @@ -372,7 +373,7 @@ static bool ns_capable_common(struct user_namespace=
 *ns,
>  		BUG();
>  	}
> =20
> -	capable =3D security_capable(current_cred(), ns, cap, opts);
> +	capable =3D security_capable(current_cred(), ns, cap, opts, cad);
>  	if (capable =3D=3D 0) {
>  		current->flags |=3D PF_SUPERPRIV;
>  		return true;
> @@ -393,7 +394,7 @@ static bool ns_capable_common(struct user_namespace=
 *ns,
>   */
>  bool ns_capable(struct user_namespace *ns, int cap)
>  {
> -	return ns_capable_common(ns, cap, CAP_OPT_NONE);
> +	return ns_capable_common(ns, cap, CAP_OPT_NONE, NULL);
>  }
>  EXPORT_SYMBOL(ns_capable);
> =20
> @@ -411,7 +412,7 @@ EXPORT_SYMBOL(ns_capable);
>   */
>  bool ns_capable_noaudit(struct user_namespace *ns, int cap)
>  {
> -	return ns_capable_common(ns, cap, CAP_OPT_NOAUDIT);
> +	return ns_capable_common(ns, cap, CAP_OPT_NOAUDIT, NULL);
>  }
>  EXPORT_SYMBOL(ns_capable_noaudit);
> =20
> @@ -430,7 +431,7 @@ EXPORT_SYMBOL(ns_capable_noaudit);
>   */
>  bool ns_capable_setid(struct user_namespace *ns, int cap)
>  {
> -	return ns_capable_common(ns, cap, CAP_OPT_INSETID);
> +	return ns_capable_common(ns, cap, CAP_OPT_INSETID, NULL);
>  }
>  EXPORT_SYMBOL(ns_capable_setid);
> =20
> @@ -470,7 +471,7 @@ bool file_ns_capable(const struct file *file, struc=
t user_namespace *ns,
>  	if (WARN_ON_ONCE(!cap_valid(cap)))
>  		return false;
> =20
> -	if (security_capable(file->f_cred, ns, cap, CAP_OPT_NONE) =3D=3D 0)
> +	if (security_capable(file->f_cred, ns, cap, CAP_OPT_NONE, NULL) =3D=3D=
 0)
>  		return true;
> =20
>  	return false;
> @@ -503,7 +504,8 @@ bool capable_wrt_inode_uidgid(const struct inode *i=
node, int cap)
>  {
>  	struct user_namespace *ns =3D current_user_ns();
> =20
> -	return ns_capable(ns, cap) && privileged_wrt_inode_uidgid(ns, inode);=

> +	return ns_capable_inode(ns, cap, inode) &&
> +		privileged_wrt_inode_uidgid(ns, inode);
>  }
>  EXPORT_SYMBOL(capable_wrt_inode_uidgid);
> =20
> @@ -524,7 +526,18 @@ bool ptracer_capable(struct task_struct *tsk, stru=
ct user_namespace *ns)
>  	cred =3D rcu_dereference(tsk->ptracer_cred);
>  	if (cred)
>  		ret =3D security_capable(cred, ns, CAP_SYS_PTRACE,
> -				       CAP_OPT_NOAUDIT);
> +				       CAP_OPT_NOAUDIT, NULL);
>  	rcu_read_unlock();
>  	return (ret =3D=3D 0);
>  }
> +
> +bool ns_capable_inode(struct user_namespace *ns, int cap,
> +			const struct inode *inode)
> +{
> +	struct cap_aux_data cad;
> +
> +	cad.type =3D CAP_AUX_DATA_INODE;
> +	cad.u.inode =3D inode;
> +	return ns_capable_common(ns, cap, CAP_OPT_NONE, &cad);
> +}
> +EXPORT_SYMBOL(ns_capable_inode);
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 811b4a86cdf6..d59dd7079ece 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -446,7 +446,7 @@ static struct seccomp_filter *seccomp_prepare_filte=
r(struct sock_fprog *fprog)
>  	 */
>  	if (!task_no_new_privs(current) &&
>  	    security_capable(current_cred(), current_user_ns(),
> -				     CAP_SYS_ADMIN, CAP_OPT_NOAUDIT) !=3D 0)
> +			     CAP_SYS_ADMIN, CAP_OPT_NOAUDIT, NULL) !=3D 0)
>  		return ERR_PTR(-EACCES);
> =20
>  	/* Allocate a new seccomp_filter */
> diff --git a/security/apparmor/capability.c b/security/apparmor/capabil=
ity.c
> index 752f73980e30..c45192a16733 100644
> --- a/security/apparmor/capability.c
> +++ b/security/apparmor/capability.c
> @@ -50,7 +50,7 @@ static void audit_cb(struct audit_buffer *ab, void *v=
a)
>  	struct common_audit_data *sa =3D va;
> =20
>  	audit_log_format(ab, " capname=3D");
> -	audit_log_untrustedstring(ab, capability_names[sa->u.cap]);
> +	audit_log_untrustedstring(ab, capability_names[sa->u.cap_struct.cap])=
;
>  }
> =20
>  /**
> @@ -148,13 +148,15 @@ static int profile_capable(struct aa_profile *pro=
file, int cap,
>   *
>   * Returns: 0 on success, or else an error code.
>   */
> -int aa_capable(struct aa_label *label, int cap, unsigned int opts)
> +int aa_capable(struct aa_label *label, int cap, unsigned int opts,
> +	       struct cap_aux_data *cad)
>  {
>  	struct aa_profile *profile;
>  	int error =3D 0;
>  	DEFINE_AUDIT_DATA(sa, LSM_AUDIT_DATA_CAP, OP_CAPABLE);
> =20
> -	sa.u.cap =3D cap;
> +	sa.u.cap_struct.cap =3D cap;
> +	sa.u.cap_struct.cad =3D cad;
>  	error =3D fn_for_each_confined(label, profile,
>  			profile_capable(profile, cap, opts, &sa));
> =20
> diff --git a/security/apparmor/include/capability.h b/security/apparmor=
/include/capability.h
> index 1b3663b6ab12..d888f09d76d1 100644
> --- a/security/apparmor/include/capability.h
> +++ b/security/apparmor/include/capability.h
> @@ -20,6 +20,7 @@
>  #include "apparmorfs.h"
> =20
>  struct aa_label;
> +struct cap_aux_data;
> =20
>  /* aa_caps - confinement data for capabilities
>   * @allowed: capabilities mask
> @@ -40,7 +41,8 @@ struct aa_caps {
> =20
>  extern struct aa_sfs_entry aa_sfs_entry_caps[];
> =20
> -int aa_capable(struct aa_label *label, int cap, unsigned int opts);
> +int aa_capable(struct aa_label *label, int cap, unsigned int opts,
> +	       struct cap_aux_data *cad);
> =20
>  static inline void aa_free_cap_rules(struct aa_caps *caps)
>  {
> diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> index aacd1e95cb59..deb5267ca695 100644
> --- a/security/apparmor/ipc.c
> +++ b/security/apparmor/ipc.c
> @@ -108,7 +108,7 @@ static int profile_tracer_perm(struct aa_profile *t=
racer,
>  	aad(sa)->peer =3D tracee;
>  	aad(sa)->request =3D 0;
>  	aad(sa)->error =3D aa_capable(&tracer->label, CAP_SYS_PTRACE,
> -				    CAP_OPT_NONE);
> +				    CAP_OPT_NONE, NULL);
> =20
>  	return aa_audit(AUDIT_APPARMOR_AUTO, tracer, sa, audit_ptrace_cb);
>  }
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 87500bde5a92..82790accb679 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -172,14 +172,15 @@ static int apparmor_capget(struct task_struct *ta=
rget, kernel_cap_t *effective,
>  }
> =20
>  static int apparmor_capable(const struct cred *cred, struct user_names=
pace *ns,
> -			    int cap, unsigned int opts)
> +			    int cap, unsigned int opts,
> +			    struct cap_aux_data *cad)
>  {
>  	struct aa_label *label;
>  	int error =3D 0;
> =20
>  	label =3D aa_get_newest_cred_label(cred);
>  	if (!unconfined(label))
> -		error =3D aa_capable(label, cap, opts);
> +		error =3D aa_capable(label, cap, opts, cad);
>  	aa_put_label(label);
> =20
>  	return error;
> diff --git a/security/apparmor/resource.c b/security/apparmor/resource.=
c
> index 552ed09cb47e..9b3d4b4437f2 100644
> --- a/security/apparmor/resource.c
> +++ b/security/apparmor/resource.c
> @@ -124,7 +124,7 @@ int aa_task_setrlimit(struct aa_label *label, struc=
t task_struct *task,
>  	 */
> =20
>  	if (label !=3D peer &&
> -	    aa_capable(label, CAP_SYS_RESOURCE, CAP_OPT_NOAUDIT) !=3D 0)
> +	    aa_capable(label, CAP_SYS_RESOURCE, CAP_OPT_NOAUDIT, NULL) !=3D 0=
)
>  		error =3D fn_for_each(label, profile,
>  				audit_resource(profile, resource,
>  					       new_rlim->rlim_max, peer,
> diff --git a/security/commoncap.c b/security/commoncap.c
> index c477fb673701..1860ea50f473 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -68,7 +68,7 @@ static void warn_setuid_and_fcaps_mixed(const char *f=
name)
>   * kernel's capable() and has_capability() returns 1 for this case.
>   */
>  int cap_capable(const struct cred *cred, struct user_namespace *targ_n=
s,
> -		int cap, unsigned int opts)
> +		int cap, unsigned int opts, struct cap_aux_data *cad)
>  {
>  	struct user_namespace *ns =3D targ_ns;
> =20
> @@ -226,7 +226,7 @@ static inline int cap_inh_is_capped(void)
>  	 * capability
>  	 */
>  	if (cap_capable(current_cred(), current_cred()->user_ns,
> -			CAP_SETPCAP, CAP_OPT_NONE) =3D=3D 0)
> +			CAP_SETPCAP, CAP_OPT_NONE, NULL) =3D=3D 0)
>  		return 0;
>  	return 1;
>  }
> @@ -1211,7 +1211,8 @@ int cap_task_prctl(int option, unsigned long arg2=
, unsigned long arg3,
>  		    || (cap_capable(current_cred(),
>  				    current_cred()->user_ns,
>  				    CAP_SETPCAP,
> -				    CAP_OPT_NONE) !=3D 0)			/*[4]*/
> +				    CAP_OPT_NONE,
> +				    NULL) !=3D 0)				/*[4]*/
>  			/*
>  			 * [1] no changing of bits that are locked
>  			 * [2] no unlocking of locks
> @@ -1307,7 +1308,7 @@ int cap_vm_enough_memory(struct mm_struct *mm, lo=
ng pages)
>  	int cap_sys_admin =3D 0;
> =20
>  	if (cap_capable(current_cred(), &init_user_ns,
> -				CAP_SYS_ADMIN, CAP_OPT_NOAUDIT) =3D=3D 0)
> +				CAP_SYS_ADMIN, CAP_OPT_NOAUDIT, NULL) =3D=3D 0)
>  		cap_sys_admin =3D 1;
> =20
>  	return cap_sys_admin;
> @@ -1328,7 +1329,7 @@ int cap_mmap_addr(unsigned long addr)
> =20
>  	if (addr < dac_mmap_min_addr) {
>  		ret =3D cap_capable(current_cred(), &init_user_ns, CAP_SYS_RAWIO,
> -				  CAP_OPT_NONE);
> +				  CAP_OPT_NONE, NULL);
>  		/* set PF_SUPERPRIV if it turns out we allow the low mmap */
>  		if (ret =3D=3D 0)
>  			current->flags |=3D PF_SUPERPRIV;
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 33028c098ef3..4871b2508a4a 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -229,9 +229,26 @@ static void dump_common_audit_data(struct audit_bu=
ffer *ab,
>  	case LSM_AUDIT_DATA_IPC:
>  		audit_log_format(ab, " key=3D%d ", a->u.ipc_id);
>  		break;
> -	case LSM_AUDIT_DATA_CAP:
> -		audit_log_format(ab, " capability=3D%d ", a->u.cap);
> +	case LSM_AUDIT_DATA_CAP: {
> +		const struct inode *inode;
> +
> +		if (a->u.cap_struct.cad) {
> +			switch (a->u.cap_struct.cad->type) {
> +			case CAP_AUX_DATA_INODE: {
> +				inode =3D a->u.cap_struct.cad->u.inode;
> +
> +				audit_log_format(ab, " dev=3D");
> +				audit_log_untrustedstring(ab,
> +					inode->i_sb->s_id);
> +				audit_log_format(ab, " ino=3D%lu",
> +					inode->i_ino);
> +				break;
> +			}
> +			}
> +		}
> +		audit_log_format(ab, " capability=3D%d ", a->u.cap_struct.cap);
>  		break;
> +	}
>  	case LSM_AUDIT_DATA_PATH: {
>  		struct inode *inode;
> =20
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index cecd38e2ac80..c74ed83e9501 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -80,7 +80,8 @@ static bool check_setuid_policy_hashtable_key_value(k=
uid_t parent,
>  static int safesetid_security_capable(const struct cred *cred,
>  				      struct user_namespace *ns,
>  				      int cap,
> -				      unsigned int opts)
> +				      unsigned int opts,
> +				      struct cap_aux_data *cad)
>  {
>  	if (cap =3D=3D CAP_SETUID &&
>  	    check_setuid_policy_hashtable_key(cred->uid)) {
> diff --git a/security/security.c b/security/security.c
> index 613a5c00e602..06274a7b9c4e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -691,9 +691,10 @@ int security_capset(struct cred *new, const struct=
 cred *old,
>  int security_capable(const struct cred *cred,
>  		     struct user_namespace *ns,
>  		     int cap,
> -		     unsigned int opts)
> +		     unsigned int opts,
> +		     struct cap_aux_data *cad)
>  {
> -	return call_int_hook(capable, 0, cred, ns, cap, opts);
> +	return call_int_hook(capable, 0, cred, ns, cap, opts, cad);
>  }
> =20
>  int security_quotactl(int cmds, int type, int id, struct super_block *=
sb)
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f77b314d0575..d6c699ed06be 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1618,7 +1618,10 @@ static inline u32 signal_to_av(int sig)
> =20
>  /* Check whether a task is allowed to use a capability. */
>  static int cred_has_capability(const struct cred *cred,
> -			       int cap, unsigned int opts, bool initns)
> +				int cap,
> +				unsigned int opts,
> +				bool initns,
> +				struct cap_aux_data *cad)
>  {
>  	struct common_audit_data ad;
>  	struct av_decision avd;
> @@ -1628,7 +1631,8 @@ static int cred_has_capability(const struct cred =
*cred,
>  	int rc;
> =20
>  	ad.type =3D LSM_AUDIT_DATA_CAP;
> -	ad.u.cap =3D cap;
> +	ad.u.cap_struct.cad =3D cad;
> +	ad.u.cap_struct.cap =3D cap;
> =20
>  	switch (CAP_TO_INDEX(cap)) {
>  	case 0:
> @@ -2165,9 +2169,9 @@ static int selinux_capset(struct cred *new, const=
 struct cred *old,
>   */
> =20
>  static int selinux_capable(const struct cred *cred, struct user_namesp=
ace *ns,
> -			   int cap, unsigned int opts)
> +			   int cap, unsigned int opts, struct cap_aux_data *cad)
>  {
> -	return cred_has_capability(cred, cap, opts, ns =3D=3D &init_user_ns);=

> +	return cred_has_capability(cred, cap, opts, ns =3D=3D &init_user_ns, =
cad);
>  }
> =20
>  static int selinux_quotactl(int cmds, int type, int id, struct super_b=
lock *sb)
> @@ -2241,7 +2245,7 @@ static int selinux_vm_enough_memory(struct mm_str=
uct *mm, long pages)
>  	int rc, cap_sys_admin =3D 0;
> =20
>  	rc =3D cred_has_capability(current_cred(), CAP_SYS_ADMIN,
> -				 CAP_OPT_NOAUDIT, true);
> +				 CAP_OPT_NOAUDIT, true, NULL);
>  	if (rc =3D=3D 0)
>  		cap_sys_admin =3D 1;
> =20
> @@ -3101,9 +3105,9 @@ static bool has_cap_mac_admin(bool audit)
>  	const struct cred *cred =3D current_cred();
>  	unsigned int opts =3D audit ? CAP_OPT_NONE : CAP_OPT_NOAUDIT;
> =20
> -	if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, opts))
> +	if (cap_capable(cred, &init_user_ns, CAP_MAC_ADMIN, opts, NULL))
>  		return false;
> -	if (cred_has_capability(cred, CAP_MAC_ADMIN, opts, true))
> +	if (cred_has_capability(cred, CAP_MAC_ADMIN, opts, true, NULL))
>  		return false;
>  	return true;
>  }
> @@ -3563,7 +3567,7 @@ static int selinux_file_ioctl(struct file *file, =
unsigned int cmd,
>  	case KDSKBENT:
>  	case KDSKBSENT:
>  		error =3D cred_has_capability(cred, CAP_SYS_TTY_CONFIG,
> -					    CAP_OPT_NONE, true);
> +					    CAP_OPT_NONE, true, NULL);
>  		break;
> =20
>  	/* default case assumes that the command will go
> diff --git a/security/smack/smack_access.c b/security/smack/smack_acces=
s.c
> index fe2ce3a65822..e961bfe8f00a 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -640,7 +640,7 @@ bool smack_privileged_cred(int cap, const struct cr=
ed *cred)
>  	struct smack_known_list_elem *sklep;
>  	int rc;
> =20
> -	rc =3D cap_capable(cred, &init_user_ns, cap, CAP_OPT_NONE);
> +	rc =3D cap_capable(cred, &init_user_ns, cap, CAP_OPT_NONE, NULL);
>  	if (rc)
>  		return false;
> =20

