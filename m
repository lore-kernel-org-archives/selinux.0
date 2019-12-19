Return-Path: <SRS0=Xw2L=2J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89544C2D0D1
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 23:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5462421655
	for <selinux@archiver.kernel.org>; Thu, 19 Dec 2019 23:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Z4aN1MBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLSXkH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Dec 2019 18:40:07 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:46658
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727006AbfLSXkH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Dec 2019 18:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576798805; bh=livN2Xigk9A7Z8xaASD06WAD/1D0KoEf5drFCXwUss8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Z4aN1MBxWURNRd2QA5Yii4ud3liP5GUPzABKwj+DDVdRkiQ6R9Vx0FyY14glnv9F53GDb6q211SBaGAB+gvDWaXcHfun7JH9thgszuyutIC/quQEsdQdXoE7KbMFVpHMj9KKjAHFlUQImxgZdkx8gcsXu3lr4S6s8jjs2rQzsRwo9Ifzxl7q3bEFZTnF92mEl6SQvsnt36g65c/2vJ22Dtc2u3knch3nP6UDAB/ixRp+OOEmuXMEr+ecyNRg9i+BYka4Yp13pgprnf7HFnH/PiKHcRqPKkvrHlWysCuNa3kKPx9jGIni5AMHa6nm25yKKC2I4cSxnjXrLse0fU9plw==
X-YMail-OSG: 04h1HyIVM1knJtz4wI5FESW75W6KWiBjxHsQ9iQyWxnIO9WRNtY8pVmiBwuvXxJ
 JwUKBYzY4Jk6uL639CmSTu5XIkwqdSS_YGBEelRA3gB8M.rlac5o2WcK02nunaWWIpPe3bza5Eop
 p1J45n47zW59.5MDaG9KMM6OwDwQILlJkcXW9P2OIO5Ln6p_7g4xOD.YRuYDs8xuYyYbLzbdmvx2
 Kw7w5lxAQjzOU_fcqoHdOK1K3No9OjZdccdzEWUf3tsyH38mbfdJyqlLVUGsYQFMrXFAlrmXkXK.
 d1H.ThKLPN1dvmU8UXDEblzcHQnXqIGdfjZC2Ij37P5p2VUw8R8tHOokUqpEihspyRymzcLKIONq
 7nDeONmfwtUxe39tD1gRBRiKRMNb1bDQNJBmWfQiufBDU88Wj5igzIjg5TMfPwfMu7KMn.WADzda
 9T4BiKNb9LfTx1QPJc3342k39mNfQDXFsUWPAxOHNwnCxdGYsXHDC5YXBSGnw9VMPuWs0XqEf1_W
 itNTqTsuCY8XDbOiLHFbnF3aY2GQ0urDx.3m.1xdjf.CqRCHBfo3spx1ibofSajuxL153_gQBepC
 WD0_0LrPBlOWPqNv_BKKsoAq_I_2vu_M61LeG4Eg5yw7a.3MjmFN5uWb9NWuQED6.mB5vP8DjsO.
 AaSB4loVx307Uyi7TtYDCUxVvZUvZPTu8vsBY2HTe1nALwS1jH.BRbDsQkt6El5BriqRYBkz3iRF
 MCfwNLYq9mjDHPV8Qr4WFaB84MRibBRqiN2ZL3QFMrmIpF7N_KK1LOllmUncBFbUs53sQJ3DMKB7
 jbXDtXNW_gShpX2ebkXvwA9dMHEQGsVs9ny6vYrKHfZiWDPkv5B51h50lRWAzUNMczccYTzpVnmx
 MC1ElCmbI.9I0o7QBXxvvAOQ5Knac_6X6MJkKXstUw5F4jKFd0y2i6fK9Z9fI3r0YQUi4aBPH4lI
 AR_tZUp_2gI0JGHwQoeX1duNdkG5N2.A5vJsddgU0tntSyL3l_6LhjyBlBNK7h71E22tYHlPdjQ_
 Zfm33FjQkxcxbjsjMPGMkV09uL.Pnza_1LsXvk3.4FwALx4tqstXxWLPLz3Q9PDfx7h6isFauQT2
 8v6tBTezOhT6RtMcV9CQxb64GaRm.sQbAciw2E1y__wBlnbS5ebanl8MpUkoQRlsFiCD5.Ye4WNN
 SG6kafGNqdvP_xAQdvFPhtuw3h8RFGdu4mjHFWlhs3P3umDF7jIkRbTiNtWJLZ3oy0pg7fT6_QmV
 BKfw6XcZi9bfov6_c_34FXeqhIUtHY5y7LtGvG7SaxEXo8G8JP7HwKTAxy1GwZ5BGayXRwhUK_mH
 s_Uxes1Zz5VhtCaXbY_qMuDNJlKGvS.CUTrNvhJsPB7.GsLOA2l1MskYCYtEsSGp.mWfbDWLuRDu
 P6k46l7u3aoSR5j_Kmi_pZLSO7UaJE7OCYh9hQ.vES5vM1TrFHA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 19 Dec 2019 23:40:05 +0000
Received: by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 71711ae153ca12db4fbff8a003edb13a;
          Thu, 19 Dec 2019 23:40:03 +0000 (UTC)
Subject: Re: [RFC PATCH] selinux: deprecate disabling SELinux and runtime
To:     Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <157678334821.158235.2125894638773393579.stgit@chester>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <a023c681-3ede-a08d-d9ea-67ab49f10aa3@schaufler-ca.com>
Date:   Thu, 19 Dec 2019 15:40:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <157678334821.158235.2125894638773393579.stgit@chester>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/19/2019 11:22 AM, Paul Moore wrote:
> Deprecate the CONFIG_SECURITY_SELINUX_DISABLE functionality.  The
> code was originally developed to make it easier for Linux
> distributions to support architectures where adding parameters to the
> kernel command line was difficult.  Unfortunately, supporting runtime
> disable meant we had to make some security trade-offs when it came to
> the LSM hooks, as documented in the Kconfig help text:
>
>   NOTE: selecting this option will disable the '__ro_after_init'
>   kernel hardening feature for security hooks.   Please consider
>   using the selinux=0 boot parameter instead of enabling this
>   option.
>
> Fortunately it looks as if that the original motivation for the
> runtime disable functionality is gone, and Fedora/RHEL appears to be
> the only major distribution enabling this capability at build time
> so we are now taking steps to remove it entirely from the kernel.
> The first step is to mark the functionality as deprecated and print
> an error when it is used (what this patch is doing).  As Fedora/RHEL
> makes progress in transitioning the distribution away from runtime
> disable, we will introduce follow-up patches over several kernel
> releases which will block for increasing periods of time when the
> runtime disable is used.  Finally we will remove the option entirely
> once we believe all users have moved to the kernel cmdline approach.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  security/selinux/Kconfig     |    3 +++
>  security/selinux/selinuxfs.c |    6 ++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 996d35d950f7..580ac24c7aa1 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -42,6 +42,9 @@ config SECURITY_SELINUX_DISABLE
>  	  using the selinux=0 boot parameter instead of enabling this
>  	  option.
>  
> +	  WARNING: this option is deprecated and will be removed in a future
> +	  kernel release.
> +
>  	  If you are unsure how to answer this question, answer N.
>  
>  config SECURITY_SELINUX_DEVELOP
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 278417e67b4c..adbe2dd35202 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -281,6 +281,12 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
>  	int new_value;
>  	int enforcing;
>  
> +	/* NOTE: we are now officially considering runtime disable as
> +	 *       deprecated, and using it will become increasingly painful
> +	 *       (e.g. sleeping/blocking) as we progress through future
> +	 *       kernel releases until eventually it is removed */
> +	pr_err("SELinux:  Runtime disable is deprecated, use selinux=0 on the kernel cmdline.\n");
> +
>  	if (count >= PAGE_SIZE)
>  		return -ENOMEM;
>  
>
>
