Return-Path: <SRS0=KzaI=W7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D9FC3A5A7
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 15:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7E2208E4
	for <selinux@archiver.kernel.org>; Wed,  4 Sep 2019 15:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qG6muAu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfIDPb6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:31:58 -0400
Received: from UCOL19PA34.eemsg.mail.mil ([214.24.24.194]:57733 "EHLO
        UCOL19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbfIDPb6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Sep 2019 11:31:58 -0400
X-EEMSG-check-017: 18553483|UCOL19PA34_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="18553483"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UCOL19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Sep 2019 15:31:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1567611111; x=1599147111;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=J6OUOUpt0SxXrq2N0c9lkqRZAWi54n9GuYnnH6VrzkE=;
  b=qG6muAu2WLYCcmCLODFlVov/o9OMywFdpbWKTONei7RBOyb81J3RO1UF
   8ikEZ/mxDR9AZPY+XX+lcVQeMdbPhr6gKUcSDqD8smOl+EOh6PwH3V3au
   /MSQitsDOCcIIlTypCIvFpjcbNslaCLbeqa/FmlEcyz/ZWyxv5S3Ne+03
   He3lt5LKSKIvaTt+mfI67+w3Y0En+fE7z1CUw0FVrVuwmeirFfsV9IAQS
   4QSfMTpySwS/HH7o89bOao/f1lF2xFkyG3LsN/ac1W3XhwHffin1VsHwr
   /wSUcgqupxDDpqq7mNwYGoLGKcvN0S1Muygl3iQDiVaSFeVKL9bTRlmUh
   Q==;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="32345165"
IronPort-PHdr: =?us-ascii?q?9a23=3A/U2mox1mFB01npPjsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesUKPTxwZ3uMQTl6Ol3ixeRBMOHsqgC0rWL+PC+EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCejbb9oMRm7rwXcusYVjIZjN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlsKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK4Ihw7Eslp?=
 =?us-ascii?q?oTtl7PHinql0XtkKCabEAk+ums6+j/Y7XmoIGTN5Nshw3jPakjldazDOQlPg?=
 =?us-ascii?q?QUQWSW9vqw2Kf+8UHhRbVFlPw2kq3XsJDAIsQbo7a0AxRI3YY48Bu/Ezen38?=
 =?us-ascii?q?gYnXkANl5FfgmHgJLzN1HBJ/D4E++zg06wnzdz2/DGIrrhD43VLnfZjbfhea?=
 =?us-ascii?q?1w61ZGxwouydBT/pdUCrYGIPLpRED9rsDXDhg8Mwas2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KZM73dvkGT5u0zJOmMY4wVtS3hJPgl/f7uino5mV4Afamsx5cXb2q4Hvt+KU?=
 =?us-ascii?q?WDfXXsmssBEXsNvgcmUOPlkkaCXiBTZnupRKIz+jE7B5i7DYfNQoCinqaB0D?=
 =?us-ascii?q?6nEZJMfGxJFleMEXLwfYWeR/gMcD6SItNmkjEcTriuVYsh1RCotA/nxLtqNf?=
 =?us-ascii?q?TU+iIGupL5ztR15PPclQs09TNqC8SRyWaNT3t7nmkQXT85wLh/oVBhyleEya?=
 =?us-ascii?q?V4h/1YFdpO5/JGSws6LoDTwPBnC9DoWwLBYteIRE+jQtWhHD4xU9YxzMEVbk?=
 =?us-ascii?q?ZjFNWtkArD0zCpA7ALjbyLAoI78qbG03j2PcZ9xG7M1LM9gFk+XstPKWqmi7?=
 =?us-ascii?q?Z99wjWAI7JiV+Zl6exdakH2i7C7mKDwnSPvE1CVw5wS6rFV2gFZkTKtdT5+l?=
 =?us-ascii?q?/CT7i2BLs6MgtBzsCDJbVOat3tllVLX+3jN8rDbGKxgWiwGQyEya+LbIrvY2?=
 =?us-ascii?q?8dxjnSCFAYkwAP+naLLQo+BiCho2LYFjBuF1XvY0P2/ul4s3O0UEk0whqWYE?=
 =?us-ascii?q?J70bq1/RgVhf2ARPwJ2rIIojsuqzJxHAX149WDE9OdoyJ5dbhYJNY6501Kk2?=
 =?us-ascii?q?nesl9TJJulept+i0YefgI/hEbn0xF6G80UisQxhG87xwp1b6SD2RVOcC3Ojs?=
 =?us-ascii?q?O4AaHeNmSnpEPnUKXRwFyLlY/Lq6o=3D?=
X-IPAS-Result: =?us-ascii?q?A2DfBAAJ2G9d/wHyM5BmHQEBBQEHBQGBZ4FpBSqBQDIqh?=
 =?us-ascii?q?CGPXAEBBoE2iW+KB4cfCQEBAQEBAQEBATQBAgEBhD8CgjIjOBMCCwEBAQQBA?=
 =?us-ascii?q?QEBAQYDAQFshTqCOikBgmYBAQEBAgEjBBFBBQsLGAICJgICVxMGAgEBgl8/g?=
 =?us-ascii?q?XcFD6pRfzOFSoM1gUmBDCiLeBh4gQeBESeCaz6HT4JYBIxPL4dxXpZXgimCK?=
 =?us-ascii?q?IlYiFsGG5hrLagoIYFYKwgCGAghD4Mngk4XFY4pJAMwgQYBAY5zAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Sep 2019 15:31:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x84FVmdT014118;
        Wed, 4 Sep 2019 11:31:48 -0400
Subject: Re: [PATCH] selinux: fix residual uses of current_security() for the
 SELinux blob
To:     paul@paul-moore.com
Cc:     keescook@chromium.org, casey@schaufler-ca.com,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com,
        John Johansen <john.johansen@canonical.com>
References: <20190904143248.7003-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <38c27c97-d525-9afb-3f2d-9d3190444ae2@tycho.nsa.gov>
Date:   Wed, 4 Sep 2019 11:31:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904143248.7003-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/4/19 10:32 AM, Stephen Smalley wrote:
> We need to use selinux_cred() to fetch the SELinux cred blob instead
> of directly using current->security or current_security().  There
> were a couple of lingering uses of current_security() in the SELinux code
> that were apparently missed during the earlier conversions. IIUC, this
> would only manifest as a bug if multiple security modules including
> SELinux are enabled and SELinux is not first in the lsm order.

To further qualify that, it would only manifest as a bug if multiple 
non-exclusive security modules that use the cred security blob are 
enabled and SELinux is not first.  I don't think that is possible today 
in existing upstream kernels since the cred blob-using modules are 
currently all exclusive and tomoyo switched to using the task security 
blob instead.  Obviously that will change if/when the stacking for AA 
support lands and may already be an issue in Ubuntu depending on what 
stacking patchsets and what lsm order it is using.

> After
> this change, there appear to be no other users of current_security()
> in-tree; perhaps we should remove it altogether.
> 
> Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>   security/selinux/hooks.c          |  2 +-
>   security/selinux/include/objsec.h | 20 ++++++++++----------
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d55571c585ff..f1b763eceef9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3435,7 +3435,7 @@ static int selinux_inode_copy_up_xattr(const char *name)
>   static int selinux_kernfs_init_security(struct kernfs_node *kn_dir,
>   					struct kernfs_node *kn)
>   {
> -	const struct task_security_struct *tsec = current_security();
> +	const struct task_security_struct *tsec = selinux_cred(current_cred());
>   	u32 parent_sid, newsid, clen;
>   	int rc;
>   	char *context;
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
> index 231262d8eac9..d2e00c7595dd 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -40,16 +40,6 @@ struct task_security_struct {
>   	u32 sockcreate_sid;	/* fscreate SID */
>   };
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
>   enum label_initialized {
>   	LABEL_INVALID,		/* invalid or not initialized */
>   	LABEL_INITIALIZED,	/* initialized */
> @@ -188,4 +178,14 @@ static inline struct ipc_security_struct *selinux_ipc(
>   	return ipc->security + selinux_blob_sizes.lbs_ipc;
>   }
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
>   #endif /* _SELINUX_OBJSEC_H_ */
> 

