Return-Path: <SRS0=2SWW=27=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75C1C282DD
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 22:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9950F20678
	for <selinux@archiver.kernel.org>; Fri, 10 Jan 2020 22:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cGC3plO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgAJWM2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jan 2020 17:12:28 -0500
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:44240 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727199AbgAJWM1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jan 2020 17:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578694345; bh=tgajxGOCFd+YX/EWj/wGVCdnylzt85qhR4U/kk6O+nI=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=cGC3plO13Zd8DOP8+DU+bLO/ahqqjMuT6pT13c2eHtQEQnwT6VdM249qND+9dX7Tl8wLEZ+/i83f2OWC+z3+DEIujNwEHXrb0A8yOseofPwR3NodCy8t0jysVBPKvrWPNkYQULkmr2LkE+MB8JWetPVr+W2jxdXznvh88P1LS7QA0J3aoPmUsjF9LeUu892q8hZeXhsTPx0gbMWmkh3VnHGLFd9Aw+SUt/NsXs5lkCF3+wKTyYyGfGkw7nPHLnglN29IgTw+Hucl2FiqhVhT5+FZ8qEPXrz+hBYvRqsfKSOwez6q8Bhzt7jabmgz0g1JP83o5xCXtQ5xNUA5TwAPzQ==
X-YMail-OSG: mva4kHYVM1lQiHsfUW2zakUV1ZoumJ2TBax7R4Tf6Q_Tsq_8Ell4DOpMLp1M5SP
 GoVpe5zbdYa25pefHnNc0rORFTTYrvxgKFYKE1gXWvSXfPtqWCk1cN6tXJheT3j4ZlZKAHpYrPRQ
 QIwO2cfQR1FCTEJ1OzbjSvOdJI_OLi1h1FYafeC2RovYUcH_.PccyHFqdroOWatYonZCoBwHiwFl
 .iElw4CRjYAJdqSFlaLNJ4nKJDSxCszSCc4GuRrLC7zxiJkanE_6mTntfs2J._F.DVfkltcj2UXF
 AnfX0qLURfZ5D5yu2R0WqqUYvykm.pnpIde_dmHR4d5YTT8x1XtqesbPgZ36Akgk1oEaB2ukrXqu
 EOR82z5Vi1RotfOTWyhpp5u790lZoDfnT5UU_V_5nUiD_YxnA6.KTMTzHZPWhOTCVnULImFjUMLX
 QWMkduL8.cHD9KkMHYnYqUUZdqEePlT0jYPByWH_6t0jJ2NpLthqCxBRa_4CMyjN6jQvkoNpoNnC
 f_AdRIZd.HnTApZjFcHS4fOezBdC5K0yK5q7Uk0HzBr7VFXNnFtq5HMXX1kHZGAzXhAaswb3clUa
 Q41fjxkqr84TDgU16Cx61J4pYzNNg8_64DYdMiEmL9PbtkipR_82sqIpUGko3dC0BMVvHt4yfUf8
 y7Fx5DJjrTFbJMxBbQZO3hFEUhkEMArVatOaMTnLpXlSkYG4uMtKJsbf5iqqv3dExkN_QGNqrOPw
 yXdojyicwkHqE10f3.6pebc.3fLir6dhcu2XdWSjspyZl_Kvg_ffgBC42YgOWhAFVmuCFxFHvu37
 Sr.K1pFD_AFKBZ0eVkw1E.V2bVGceSN4o31wB_VHjAANu1aADLDDAGDvGRnHyHEebWyhIlBYoP.P
 sye5KON5_8H4uXB3gVvnKuR0AFHsLjVuHkKw1vp8GiD6IFuM9Ifbw1pU_HrQsVWhetCIMdwgP3E4
 kcUUuaH7hFCWZqPqaoOgxCEM8ytvRLK874KSOm7cM8wkU5iCjydcmqaxfyaU4j7e555Kc2L4xwLF
 neSuP5P.rVz.hAZvuSoBpaJ.SSE3loI6tSTlZeOSrniHvM2xTfH_p8nYLV_FfXkmdPRKZ0WcBC8Q
 8z4VnnC8RxfsGK6MyPe.cu1bfgCdWlmmdhrf8Mx4TUIdnycY.ij2Zv.CAINQ35v3Rz1nVAXg2dFI
 8gHziLjr7REtsmNmLfdU1qZV8JKq8VmdX49m4Rqs6lxOFQuhcadTtZ6TXi_3tXiX5.HJidNrECF1
 dMrBWpVx6re4n.R2fkJS.BR9yVG20ZhK3EAGdiejsvq4lDjZ6TZ2rnCFVrVp_cyPMy0wPCQNkThy
 7jxpX_NLNGOUmrx4tv_z8oGxDM2IVIAAMjKs9tprSG7wYpabCYgAL6Jv6iZuXzMqmsb8H5pr14tY
 5WFAmMqcSEMNrflCKtbbURDSc7.WM2BF1KRBfEQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 10 Jan 2020 22:12:25 +0000
Received: by smtp402.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dbfb4f171bbc5732779f065f21f7ccb1;
          Fri, 10 Jan 2020 22:12:24 +0000 (UTC)
Subject: Re: [RFC PATCH] selinux: remove redundant allocation and helper
 functions
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
References: <157869192997.484726.14884768578207909170.stgit@chester>
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
Message-ID: <0d6e862c-e03b-48ca-e141-b7b17f72d1fa@schaufler-ca.com>
Date:   Fri, 10 Jan 2020 14:12:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <157869192997.484726.14884768578207909170.stgit@chester>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/10/2020 1:32 PM, Paul Moore wrote:
> This patch removes the inode, file, and superblock security blob
> allocation functions and moves the associated code into the
> respective LSM hooks.  This patch also removes the inode_doinit()
> function as it was a trivial wrapper around
> inode_doinit_with_dentry() and called from one location in the code.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

I don't usually comment on SELinux code, but I can't help
but encourage this sort of clean-up. Thank you.

> ---
>  security/selinux/hooks.c |   94 ++++++++++++++++++----------------------------
>  1 file changed, 36 insertions(+), 58 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2c84b12d50bc..1305fc51bfae 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -238,24 +238,6 @@ static inline u32 task_sid(const struct task_struct *task)
>  	return sid;
>  }
>  
> -/* Allocate and free functions for each kind of security blob. */
> -
> -static int inode_alloc_security(struct inode *inode)
> -{
> -	struct inode_security_struct *isec = selinux_inode(inode);
> -	u32 sid = current_sid();
> -
> -	spin_lock_init(&isec->lock);
> -	INIT_LIST_HEAD(&isec->list);
> -	isec->inode = inode;
> -	isec->sid = SECINITSID_UNLABELED;
> -	isec->sclass = SECCLASS_FILE;
> -	isec->task_sid = sid;
> -	isec->initialized = LABEL_INVALID;
> -
> -	return 0;
> -}
> -
>  static int inode_doinit_with_dentry(struct inode *inode, struct dentry *opt_dentry);
>  
>  /*
> @@ -354,37 +336,6 @@ static void inode_free_security(struct inode *inode)
>  	}
>  }
>  
> -static int file_alloc_security(struct file *file)
> -{
> -	struct file_security_struct *fsec = selinux_file(file);
> -	u32 sid = current_sid();
> -
> -	fsec->sid = sid;
> -	fsec->fown_sid = sid;
> -
> -	return 0;
> -}
> -
> -static int superblock_alloc_security(struct super_block *sb)
> -{
> -	struct superblock_security_struct *sbsec;
> -
> -	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
> -	if (!sbsec)
> -		return -ENOMEM;
> -
> -	mutex_init(&sbsec->lock);
> -	INIT_LIST_HEAD(&sbsec->isec_head);
> -	spin_lock_init(&sbsec->isec_lock);
> -	sbsec->sb = sb;
> -	sbsec->sid = SECINITSID_UNLABELED;
> -	sbsec->def_sid = SECINITSID_FILE;
> -	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
> -	sb->s_security = sbsec;
> -
> -	return 0;
> -}
> -
>  static void superblock_free_security(struct super_block *sb)
>  {
>  	struct superblock_security_struct *sbsec = sb->s_security;
> @@ -406,11 +357,6 @@ static void selinux_free_mnt_opts(void *mnt_opts)
>  	kfree(opts);
>  }
>  
> -static inline int inode_doinit(struct inode *inode)
> -{
> -	return inode_doinit_with_dentry(inode, NULL);
> -}
> -
>  enum {
>  	Opt_error = -1,
>  	Opt_context = 0,
> @@ -598,7 +544,7 @@ static int sb_finish_set_opts(struct super_block *sb)
>  		inode = igrab(inode);
>  		if (inode) {
>  			if (!IS_PRIVATE(inode))
> -				inode_doinit(inode);
> +				inode_doinit_with_dentry(inode, NULL);
>  			iput(inode);
>  		}
>  		spin_lock(&sbsec->isec_lock);
> @@ -2593,7 +2539,22 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>  
>  static int selinux_sb_alloc_security(struct super_block *sb)
>  {
> -	return superblock_alloc_security(sb);
> +	struct superblock_security_struct *sbsec;
> +
> +	sbsec = kzalloc(sizeof(struct superblock_security_struct), GFP_KERNEL);
> +	if (!sbsec)
> +		return -ENOMEM;
> +
> +	mutex_init(&sbsec->lock);
> +	INIT_LIST_HEAD(&sbsec->isec_head);
> +	spin_lock_init(&sbsec->isec_lock);
> +	sbsec->sb = sb;
> +	sbsec->sid = SECINITSID_UNLABELED;
> +	sbsec->def_sid = SECINITSID_FILE;
> +	sbsec->mntpoint_sid = SECINITSID_UNLABELED;
> +	sb->s_security = sbsec;
> +
> +	return 0;
>  }
>  
>  static void selinux_sb_free_security(struct super_block *sb)
> @@ -2845,7 +2806,18 @@ static int selinux_fs_context_parse_param(struct fs_context *fc,
>  
>  static int selinux_inode_alloc_security(struct inode *inode)
>  {
> -	return inode_alloc_security(inode);
> +	struct inode_security_struct *isec = selinux_inode(inode);
> +	u32 sid = current_sid();
> +
> +	spin_lock_init(&isec->lock);
> +	INIT_LIST_HEAD(&isec->list);
> +	isec->inode = inode;
> +	isec->sid = SECINITSID_UNLABELED;
> +	isec->sclass = SECCLASS_FILE;
> +	isec->task_sid = sid;
> +	isec->initialized = LABEL_INVALID;
> +
> +	return 0;
>  }
>  
>  static void selinux_inode_free_security(struct inode *inode)
> @@ -3555,7 +3527,13 @@ static int selinux_file_permission(struct file *file, int mask)
>  
>  static int selinux_file_alloc_security(struct file *file)
>  {
> -	return file_alloc_security(file);
> +	struct file_security_struct *fsec = selinux_file(file);
> +	u32 sid = current_sid();
> +
> +	fsec->sid = sid;
> +	fsec->fown_sid = sid;
> +
> +	return 0;
>  }
>  
>  /*
>
>
