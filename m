Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3228C3A5A9
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 15:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC64722CF5
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 15:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QnrixGyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfIDPQI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:16:08 -0400
Received: from sonic303-27.consmr.mail.ne1.yahoo.com ([66.163.188.153]:43082
        "EHLO sonic303-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729888AbfIDPQI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Sep 2019 11:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567610166; bh=R2SpcOFSfSxnXasA1iCUbEqBgcZ1kI59YtSsJdElbLE=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=QnrixGyCzrjMwXStVUIgS+lnOEe5tYR7O/Pv6GX0+wnfb8euwYm7I9MURQtxBoWVGlmghhKkmwk5i2UfkaOfwmICCVFRGPoaATgVBYVmmaQRPBIwnbFixFDSrRjWsdeBXPxKnhleszIoDCc3atc3y2fsTO0kTYcrX8abCEzP4iL0TRura+0/B1iDBp2w1zJ1u1KKfRLZi9Yodou4EyJQhPvrkgEuurC7APHieQS4IX9snjaZtXgcGI1yE7uLKGrucFp+BxfbxHmgSxxaNwWSmMuLC7eUqlYYXLxoez97RI3EdwIA/hfYjruDeuHprbQRf2QQ1xiVpWCNTwriHmZz0A==
X-YMail-OSG: TmOEjXgVM1nub_Jjl9QW8Sjc3WbzTmANNCCe79xTLNmB8uxtmMSpB9uUlEK2GVi
 iLt8tNfnj3xB0VSoRp9uA2NtKMPoaVHgruZtaPhWBeXnGNJ3C_veddHnPl1u5721cnpX2ChCvXIT
 0wMT743eQPHkC3GS0dlXgmKI.EgVey8gXMwy2kfD0vtjMwW_Gd6d9pUETPPOnbtgc5RhFeCdVrmf
 7z0kVp.KlMcbZ48oPivOWEgESSkNwYtZSBXgmVsZ0CRN0.3tBCWoCcpKmDswh893HjyKg91C3vFc
 fHauAR3JhLEJw9uBeMXMNFnEas_QI0G5Q_K3TzkCMJcAW2t._IdXljrAsa_HU0gx.T3sz4KAfTx7
 0LDkz.OVlejH6IORUwOe2qOpDJMxjSu5Gd5G29mPeYufHT9lVCIehJWS61XuTiCPvjT69kuctG1D
 KDXMCGIRBv34hiIDXxOwy1sgLRDXknrnB6QS1K575qyHSMYzrQeggCbqu1_p1K0VAX2LxH_.KIdp
 cNOEZd9.X5xxGYt.p3VJkTp4yJxiGDL8pYl1fHXsrOhpm2YfuYwFXCEKPyceqrdBLHkNFRZXPvIn
 3SypJE4z41qlxdUnxFlgAkGeygK5gjlpG7dqHvDVqyJ6ySMl3PxQgVap6bFG_5bTsJjqABRzUYyF
 cHurHJdtY4n2uNIxfYfnZZUXuugY1kKSMMmJ9xznVgiw07I57fH5hKLo14PMNSk7v9.mKp4V509L
 GkYiCDu06xFKSNdjXAEY4riSgNcVgvVnCK64QQo20o4Kfvr0fzsymVVwvSGbjh6_1RqursEuvVPx
 jO2U6nB8p6VRg5atZOWdvhbI.DvBOfm.BYmoJvltv0D9ZHDUaEJXmo_zK4JiFQoesr5B5I_Y8l_X
 _PD3i6U5T_SPCnnj.j2Nt3CsZS5JhgnojVMNf.qAQ8R_0nbApGp.4SDRvbmkDTxOEgs7PKNFgZoP
 3jWA7Jxmdt6CD5W99wve9NEhMrXtUl7XSL7y1.1sSrvt6y8xUpQP7DRVRWSBPZIZUeRimlv.XwrB
 Z46OMeqw.RJjkbMUHMbxXIbuu7TR.EQ4TkWueyUil1fM3lkQ8hLE2kvXJgcCrnXXeqPDj4ukcWdM
 a0t7b79Qrqt1NcnAD4Q6IBfWjrCE.WTH0T6UmglzNuZahv6CBCnkgi50kjK9mvMeKMksoo7r.Pj1
 T.yIx6TPEL_iHoESEikD6238SY5IwGqm3wA57AxZ8mgvsur.VRCRAGimNvpVUG826UpqiF5lfckD
 oEfIDUZauLuHYgO0U4qnJmgKAvd0OR7c1wK780dlzp_loLjhQVebbjS6u0cQKF4McmzGXnxA_lgi
 Jr.XCM.7DJpYT.6_dudqee048jEo0dQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 4 Sep 2019 15:16:06 +0000
Received: by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0ffca9b564eea69d38a8f998eb2a3aa1;
          Wed, 04 Sep 2019 15:16:01 +0000 (UTC)
Subject: Re: [PATCH] selinux: fix residual uses of current_security() for the
 SELinux blob
To:     Stephen Smalley <sds@tycho.nsa.gov>, paul@paul-moore.com
Cc:     keescook@chromium.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        dhowells@redhat.com, casey@schaufler-ca.com
References: <20190904143248.7003-1-sds@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <0edb10a8-7c6a-bee1-b6d4-382ee1ed51ee@schaufler-ca.com>
Date:   Wed, 4 Sep 2019 08:16:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904143248.7003-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/2019 7:32 AM, Stephen Smalley wrote:
> We need to use selinux_cred() to fetch the SELinux cred blob instead
> of directly using current->security or current_security().  There
> were a couple of lingering uses of current_security() in the SELinux code
> that were apparently missed during the earlier conversions.

Thank you for finding this.

>  IIUC, this
> would only manifest as a bug if multiple security modules including
> SELinux are enabled and SELinux is not first in the lsm order. After
> this change, there appear to be no other users of current_security()
> in-tree; perhaps we should remove it altogether.

I agree.

>
> Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/selinux/hooks.c          |  2 +-
>  security/selinux/include/objsec.h | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d55571c585ff..f1b763eceef9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3435,7 +3435,7 @@ static int selinux_inode_copy_up_xattr(const char *name)
>  static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
>  					struct kernfs_node *kn)
>  {
> -	const struct task_security_struct *tsec = current_security();
> +	const struct task_security_struct *tsec = selinux_cred(current_cred());
>  	u32 parent_sid, newsid, clen;
>  	int rc;
>  	char *context;
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 231262d8eac9..d2e00c7595dd 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -40,16 +40,6 @@ struct task_security_struct {
>  	u32 sockcreate_sid;	/* fscreate SID */
>  };
>  
> -/*
> - * get the subjective security ID of the current task
> - */
> -static inline u32 current_sid(void)
> -{
> -	const struct task_security_struct *tsec = current_security();
> -
> -	return tsec->sid;
> -}
> -
>  enum label_initialized {
>  	LABEL_INVALID,		/* invalid or not initialized */
>  	LABEL_INITIALIZED,	/* initialized */
> @@ -188,4 +178,14 @@ static inline struct ipc_security_struct *selinux_ipc(
>  	return ipc->security + selinux_blob_sizes.lbs_ipc;
>  }
>  
> +/*
> + * get the subjective security ID of the current task
> + */
> +static inline u32 current_sid(void)
> +{
> +	const struct task_security_struct *tsec = selinux_cred(current_cred());
> +
> +	return tsec->sid;
> +}
> +
>  #endif /* _SELINUX_OBJSEC_H_ */
