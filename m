Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7979C433F5
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 16:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88AB161050
	for <selinux@archiver.kernel.org>; Thu, 23 Sep 2021 16:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhIWQWM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:22:12 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:39125
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233354AbhIWQWL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Sep 2021 12:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632414039; bh=CZaL+YCARYrkCYwJvkgtW97umUQnnOOBnr81YxCrEdk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=NJkX+YntfR5RvMf3FPwcCCEgsMsl1mpAsaNRBPqts6WH2AKizYIpKIE5zAdqlr5p2hb7cdj4ZRTBcYpbBW1mvnQiwB0h9q5Zq3bExx78eH8GwnY7q0CZs4ZOh6umc2KxRWn6DTQ9btgfVH9ei9Otw+VCUgVEHJgpfjdSUFUdv179FXHfaLceFs8E9pnonHTWpSC3gNOQqrAiL80irJOJyo55KD0ONpFBDCxNHoCF5hkh3pnUi8/+NPKQ1jNjpIppY8Sz1QEIYlSeM1qzuyoD4QZpUt8fri5LdBXwTUiLGS6WPZ+//MIJtx/IV0V9cJt4InG1sXn8DwS5PoToGthjGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632414039; bh=nQvPpli1pwuyKHS8bdop7eRewhVS+6sgLu+zkKBcAmr=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=rhW1fMmDKjmlAecYxx5J4RKFaodc7NpRtzs8e/+aCu3yATZ4SzztOng4EnDhtAZCvOyv1XKoTM/+G7aU2d2AKvk2OTFHgX1PPaDi0kSblTyemlN8ab2Y42fZuVfZ0FotZDnU6R8zLoErj7jopczrOg3IEaCF0as3dCaM83a/cE6vSf/BWBTmAD8lk/VGwCIJx7JGGoOZHTXtkoCWEAm2Rs6XwpyoF42L1IrQSirjb2s+J4be0Fug18WOJQGSkF27FPvSq5riuit+dx8d3LEQOdbdZjhFAuMRAfuyxasMuBSxNUe0Xz0bitkh5tAv6uw+yjhL5u/wvpfU8y1z1nvKDw==
X-YMail-OSG: OPpEpfwVM1moPsTsVYc4BNfJBiAc3.qdoU0Kq8uMLzRLt3Fi2zBBIA_fLFYqbH9
 UK1ksAfBvLWxG7mCeRHld7DxEFCJ1EmqvAKCNqUEC392u023mROQ9ydo9OUQpzqVqOJlS9hG.yJV
 kewgrKtketDskjGmMB38uKW.CBKxOEZxpFO0ZyqwoVM8fLe_6hURGi0Yw5faWc.MuXzk_9KKm.23
 LOfOaeBUafrIAtfEOVxUXrjSgiPhWk6Gp9i.IHZtuGlGQrLwuEkKENN3R1BGkfDnWgOiRNIB50W5
 9CxMu8JJkihzIjMUC2Z8YjGq_NLkDquhZXYkHMODzBX_7oetpGuIFuZoYDbWDZaX7n4zcjSciUuK
 4KoxCZ_nDFqI.AeQ64zy2c1jVgWzY9bSah3Pnjufk2PXoJtFeaTz2ALBVuaLAKVowyasoPdwObUf
 .ijY_3JW.hsdoMSsAg3MpeGLqj.H1258szS9ZVYjT6I5AYOD3SgMBm1AU7rdCYe.DNXVHjUI9.Dm
 x7qo7uaWXA2ror.zttsPYtKQdjozuW88aMARoPiUGONvBXQ1eLxo9fnHyhWu3CutZQ4NUYSGSnDl
 TBWB5Hm.XyHGdzFth0HWTLmhrxybnbClljIHwhO9BZJdSO9Fbg2LzgYGMWCVBRklUfzPzBHq_omh
 s0reGB8u5a.0FAj9hbpZySxZRs_j1T89nspEmVohl.5GuyPaXzkLSl3u4GjXFyGBTUZbLX48yqsD
 5GidI7Yo4Or_rjcPRkR.sxL_f1zKCPhduhz6g0lzgFf81deI_GtUzCTWv6uHYzxOL8WWs8iMAshm
 BFqR_9cbXc7569iC7wcHTzuvoByRIGrvJL8RYIB32FlF47XMUDPBq3vXqmS4QarrkLuFetwNshyg
 rTzlaIzOEdWyYBanukYTrfMUxcPCLlHsBA2cvBy6tj52nLzy.DgVq6wmrTi8YwDGFRfzLInTUkqn
 DyxxTV52s1diPqUyqLVdzbUWCIr_OtGLdlDw.XgpY2vQNUZq1aMLs_NvcfWCl0O8Y.wm22KD2bFF
 lLfyqkgqCoFFhYiSmXBTtqwEIjHdksUgPPdSfRva60siZuS1eySkARHIRRGH.yjblfXc13ErJ5Uy
 a2Ica5XnUn55OfGdpIMnRLSBHq40dvJH8vkTlcMhBI7E0zlLK8WLSm5sWtdRI_RDaLOpFOWkfXTh
 xlOg1M2tA01tqpK0rRd.z6r35BNFf7.R4Dvrju8rfro0bt1YP8IQ29ZzNwy.rHGWpII5H4lsyfF0
 .34QyuYz8tSVfKluT0tj1Ga2Nd9Q8QXPBcpkns6pLIogZL1bUXT7CjKDqZ6pwG4V7ghfb4Y4Y8vI
 oazBpW8IR.2Ujeesuj2GgbUG71eh2Qeynv3BC2esEmZqcc7IfJqt_AGGRog3m5QwWB0OT1wm0iAB
 Djn4Ihn3C.MyGvNq4hX0Mp_JL3rRmEYmtzP4.7N8AmWrWBw0ZJbfunJpPCmR3tynr_m7QVsmgcFU
 pjbUtNLD17qAKZnNnsIRwRPhMqOIhm2Oq_3V1SLNnIGhDkOjqRV6pV1LDkAudVPSQ7RvRaTyJXXm
 wBdspwU6sPTNDaFx5VTMhG3wpSqDQVhuAMSo1N7.BOQYicXLjevU2_1pJIJ2Tkd8kcLFfPsbn8kL
 BcTrVmrm.rShJ0SZh7UbvkF9ZRAWhHa9WaPz8V9T.xwDzEns0JQT_yNbYBZtAAGTcN_Z0KsbwVBv
 aBupyPzMwfce18DbFZvXEXtnDvqlc3.wZY0_Rs._AdlgDLiY2rsRBWoJZdcULdnOUSTG.3hopZgI
 2FgAU.jLw2ATN_poA0C5XWCYtk4unUzYL0H_NVSqw1u2CvXDDNLXeXoOcZNAde5x4RBMz6KQMG7c
 csbHbRwYwUOuzcLBOBgjFMiQmlBYRGJjnKie8gtxFMq31uxDQiWXGdn_Xr0hAtXNGdWJZsCCjpWC
 DIMyxv3zWyv9.CBoPZMJ6tub_J9zWBQ4I5sHPbqv29M5C.oa09b4iohlr2sQUw2ta9llv7HX6ngw
 Fvt8emBML.iAxeLnC.7U10NuCMR11WsDQml.pa2AFvDtrWRP4RSNI1zX4zHhi7kUVJaMDb5hkt.6
 GZciVu9NbhnoZPkE769Lst32jNvdUBIJxF5ARjmtw19GSIkRw.ioLoihnCsUVVoGg3BG2dGYhAXs
 ts8aUbKBr3tulPAV9Np7u0hK9oFJnX88YycM5lNlDtcgBJ3lHT_V4vPcjGfn8Bt9lsp_j3QIke5H
 BtdVzF.Z_XS6CNSaybdLxi7jqc4J8nbjFJWwmukKSTyaLoSPFqfKO5TUb0zljRgIBRFsHXQH7E3i
 Ka3Spmmydi2BxoUg5CzLR41ACjQBp2VNW.ASb5onOXyLCjN3PmETs
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Thu, 23 Sep 2021 16:20:39 +0000
Received: by kubenode516.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 7e0ecdf822e2010c3c1521b30bcfde4b;
          Thu, 23 Sep 2021 16:20:37 +0000 (UTC)
Subject: Re: [PATCH] selinux,smack: fix subjective/objective credential use
 mixups
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     jannh@google.com, Casey Schaufler <casey@schaufler-ca.com>
References: <163241206546.71956.16494958077958683533.stgit@olly>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <0d144c68-ecd2-872b-1c93-02cff28a060c@schaufler-ca.com>
Date:   Thu, 23 Sep 2021 09:20:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <163241206546.71956.16494958077958683533.stgit@olly>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.19043 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/23/2021 8:47 AM, Paul Moore wrote:
> Jann Horn reported a problem with commit eb1231f73c4d ("selinux:
> clarify task subjective and objective credentials") where some LSM
> hooks were attempting to access the subjective credentials of a task
> other than the current task.  Generally speaking, it is not safe to
> access another task's subjective credentials and doing so can cause
> a number of problems.
>
> Further, while looking into the problem, I realized that Smack was
> suffering from a similar problem brought about by a similar commit
> 1fb057dcde11 ("smack: differentiate between subjective and objective
> task credentials").
>
> This patch addresses this problem by restoring the use of the task's
> objective credentials in those cases where the task is other than the
> current executing task.  Not only does this resolve the problem
> reported by Jann, it is arguably the correct thing to do in these
> cases.
>
> Cc: stable@vger.kernel.org
> Fixes: eb1231f73c4d ("selinux: clarify task subjective and objective credentials")
> Fixes: 1fb057dcde11 ("smack: differentiate between subjective and objective task credentials")
> Reported-by: Jann Horn <jannh@google.com>
> Acked-by: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/selinux/hooks.c   |    4 ++--
>  security/smack/smack_lsm.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6517f221d52c..e7ebd45ca345 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2157,7 +2157,7 @@ static int selinux_ptrace_access_check(struct task_struct *child,
>  static int selinux_ptrace_traceme(struct task_struct *parent)
>  {
>  	return avc_has_perm(&selinux_state,
> -			    task_sid_subj(parent), task_sid_obj(current),
> +			    task_sid_obj(parent), task_sid_obj(current),
>  			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
>  }
>  
> @@ -6222,7 +6222,7 @@ static int selinux_msg_queue_msgrcv(struct kern_ipc_perm *msq, struct msg_msg *m
>  	struct ipc_security_struct *isec;
>  	struct msg_security_struct *msec;
>  	struct common_audit_data ad;
> -	u32 sid = task_sid_subj(target);
> +	u32 sid = task_sid_obj(target);
>  	int rc;
>  
>  	isec = selinux_ipc(msq);
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index cacbe7518519..21a0e7c3b8de 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2016,7 +2016,7 @@ static int smk_curacc_on_task(struct task_struct *p, int access,
>  				const char *caller)
>  {
>  	struct smk_audit_info ad;
> -	struct smack_known *skp = smk_of_task_struct_subj(p);
> +	struct smack_known *skp = smk_of_task_struct_obj(p);
>  	int rc;
>  
>  	smk_ad_init(&ad, caller, LSM_AUDIT_DATA_TASK);
> @@ -3480,7 +3480,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>   */
>  static int smack_getprocattr(struct task_struct *p, char *name, char **value)
>  {
> -	struct smack_known *skp = smk_of_task_struct_subj(p);
> +	struct smack_known *skp = smk_of_task_struct_obj(p);
>  	char *cp;
>  	int slen;
>  
>
