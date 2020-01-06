Return-Path: <SRS0=/M55=23=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D7C33C9B
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 16:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841CF20848
	for <selinux@archiver.kernel.org>; Mon,  6 Jan 2020 16:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FdjedVY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgAFQMk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:12:40 -0500
Received: from UHIL19PA37.eemsg.mail.mil ([214.24.21.196]:23279 "EHLO
        UHIL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAFQMj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Jan 2020 11:12:39 -0500
X-EEMSG-check-017: 62978560|UHIL19PA37_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="62978560"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UHIL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 06 Jan 2020 16:12:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1578327157; x=1609863157;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=/HI1EUoFCNtCrMSdBscGuf/VBEsKjODCwVLvVb0ptW4=;
  b=FdjedVY/4nAmypYq2NmA6cdqufoTwGEF6+4vbLKOmO2TwX1S8TwusUTt
   eX6xgr0hEBMh2ME6uGL3qNGAc4LXCCxqioEb/Ln2qqyudwMGw48JEG3eM
   fTsyhiDuos51X504Ptd33SdAYZ8M8AGFZ/hJb1mWmhOrZ4DaFMkAIPRIm
   czzR1usmC6UhM/PFO2lXaxaP+3z5IZgQSDt/gnSENB9mIUUdzRLyxFwqE
   2U7R15QkgPEuUW68BQaSj5SBFrEc08SLzilPpMJ4OWisim3Ph8YOcHtlA
   Le9pLqr0T0ffkl36Ta1zfSNbpJvW7Yy5p4sS8mvgJ7KiLpWFXDeouAift
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,403,1571702400"; 
   d="scan'208";a="37385726"
IronPort-PHdr: =?us-ascii?q?9a23=3ArqbVDRJzEv+Jp2EqKdmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLvv6rarrMEGX3/hxlliBBdydt6sfzbCL6+uwBCQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngu6oAXNusUZgoZvKrs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1cQqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ54gxL4wmJ?=
 =?us-ascii?q?0TsV/dESDqgkn2kK+XeVkk+uiv8ejnZKnppoSAOINujwH+M6AultS+AeQ+LA?=
 =?us-ascii?q?cOQ3CW9fmz2bDs50H0QKhGguconqTWrpzWP9kXqra8AwBP04Yj7xi/Dy2h0N?=
 =?us-ascii?q?QdhXQHN09KeAmcgoj1O1DBPPD4DfClj1Sqizdk3erKPrLmApXTNnTDiqvufa?=
 =?us-ascii?q?5h605Azwo+1cxQ6IhPCr4fIPP+QVTxu8DYDhAjLgy0zeLnB8tn1o8HRW2AGL?=
 =?us-ascii?q?WVP7/VsV+N/ugvOfWDZJcJuDbhLPgo/+LhgmUimVADfailx4AXZ2y4Hvt8Pk?=
 =?us-ascii?q?WZb37sjckbEWoRvwo+SvDqh0OGUTJJe3myWKc87CkhCI26FYfDWpytgLuZ0S?=
 =?us-ascii?q?e5G51WYXpGCkqNEXfzbIiEXe0DaCeMLc9giDAEUqKhS4A53xG0qAD606ZnLv?=
 =?us-ascii?q?bT+iAAsZLj1d515/DclB0r7jx7EdiS03yXT2F1gmMJRyY63KV4oUNg11eD1b?=
 =?us-ascii?q?Z3judGFdxc+fxJSB02NZ3CwOxgDdD9RAbBcs2OSFa8TdWsGSsxQc4pw98Sf0?=
 =?us-ascii?q?Z9HM2vjgvd0CquAr8VkaGLBZMv/6LC0Hj+Odx9x2zF1KY/lVkmRNVANWm8iq?=
 =?us-ascii?q?547QjTCJbDk1+FmKayaaQcwCnN+X+AzWWQok5YSxJ/UaLCXXAcfUbZsdT55l?=
 =?us-ascii?q?nFT7+rCLQnLw5BxdSFKqtQZd3jlU9GS+v7ONTCf2KxnH+9BRSPxrOMaormYW?=
 =?us-ascii?q?cd3CLdCEcelQAT5miJNQ4lCyi9uW3eCjtuFVTuY0zw6+Z+rGm3QVMzzwGPd0?=
 =?us-ascii?q?dhzaa6+gYJhfyATPMexqoEtzknqzV7AVa93tTWB8ODpwV/ZqVcZ80y4FNc2G?=
 =?us-ascii?q?LYrgB9OpugL758iVIEaAR4pUDu1whtCopai8Qqqm0lwBBwKaKAyFlBbS+X3Y?=
 =?us-ascii?q?jsOr3LLWn/5AivZLTL2lHay9uW4r0A6Ok8q1n6uQGpEU0i82953NVPz3Sc4Z?=
 =?us-ascii?q?DKX0IuVsfaW1065lBBrLHTfyc56pmcgXZlKqSlmiTJ29s0Cu8o0FOrdpFUN6?=
 =?us-ascii?q?bSUEf5GtYXFo61I+wjhlatYwgsPeZO+apyNMSjM7OE3amxJud7tDSviGlGpo?=
 =?us-ascii?q?dn3QbE8yt6V/6NxJsO3uuZwhrCUjDwkVOsmt74lJoCZjwIGGe7jy/+C8oZfa?=
 =?us-ascii?q?B2fIAWGU+wLMCtgNZznZjgXzhf7lHwKUkB3ZqSZReKb1H7lTZV3EATrG3vzT?=
 =?us-ascii?q?C01BRogjopqeyZxyWIzOP8IklUclVXTXVv2A+/abO/iMoXCQ3xNVkk?=
X-IPAS-Result: =?us-ascii?q?A2CyAAAoWxNe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWsEA?=
 =?us-ascii?q?QELAYF8gWwBIBIqhAmJA4ZiAQEEBoESJYluiiSHJAkBAQEBAQEBAQE3AQGEQ?=
 =?us-ascii?q?AKCDTcGDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGCeQEBAQECASMEEUEFCwsYA?=
 =?us-ascii?q?gImAgJXBgEMBgIBAYJfP4JTBSCsXnV/M4VPgyiBPYEOKAGMMnmBB4ERJwwDg?=
 =?us-ascii?q?l0+h1mCXgSXFkaXPYJAgkWTTwYbgkaYFS2OJoFHmyIjgVgrCAIYCCEPgydQG?=
 =?us-ascii?q?A2NHheOQSMDMI5nAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 06 Jan 2020 16:12:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 006GBiLL229323;
        Mon, 6 Jan 2020 11:11:44 -0500
Subject: Re: [PATCH v13 15/25] LSM: Use lsmcontext in security_secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191224235939.7483-1-casey@schaufler-ca.com>
 <20191224235939.7483-16-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d3daba92-7a35-1883-9dca-6262e702cf30@tycho.nsa.gov>
Date:   Mon, 6 Jan 2020 11:15:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191224235939.7483-16-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/24/19 6:59 PM, Casey Schaufler wrote:
> Replace the (secctx,seclen) pointer pair with a single
> lsmcontext pointer to allow return of the LSM identifier
> along with the context and context length. This allows
> security_release_secctx() to know how to release the
> context. Callers have been modified to use or save the
> returned data from the new structure.
> 
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: netdev@vger.kernel.org
> ---

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 3305c4af43a8..224c7b4a1bc0 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1178,9 +1178,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   	struct audit_buffer	*ab;
>   	u16			msg_type = nlh->nlmsg_type;
>   	struct audit_sig_info   *sig_data;
> -	char			*ctx = NULL;
>   	u32			len;
> -	struct lsmcontext	scaff; /* scaffolding */
> +	struct lsmcontext	context = { };
>   
>   	err = audit_netlink_ok(skb, msg_type);
>   	if (err)
> @@ -1418,25 +1417,22 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>   	case AUDIT_SIGNAL_INFO:
>   		len = 0;
>   		if (lsmblob_is_set(&audit_sig_lsm)) {
> -			err = security_secid_to_secctx(&audit_sig_lsm, &ctx,
> -						       &len);
> +			err = security_secid_to_secctx(&audit_sig_lsm,
> +						       &context);
>   			if (err)
>   				return err;
>   		}
>   		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);

As I mentioned in my 2nd reply on the v12 version of this patch, you 
forgot to update this kmalloc() to use context.len, so you'll end up 
allocating too small a buffer and then writing out of bounds upon the 
memcpy below.  KASAN would have detected this for you if you enabled it 
in your kernel config.

>   		if (!sig_data) {
> -			if (lsmblob_is_set(&audit_sig_lsm)) {
> -				lsmcontext_init(&scaff, ctx, len, 0);
> -				security_release_secctx(&scaff);
> -			}
> +			if (lsmblob_is_set(&audit_sig_lsm))
> +				security_release_secctx(&context);
>   			return -ENOMEM;
>   		}
>   		sig_data->uid = from_kuid(&init_user_ns, audit_sig_uid);
>   		sig_data->pid = audit_sig_pid;
>   		if (lsmblob_is_set(&audit_sig_lsm)) {
> -			memcpy(sig_data->ctx, ctx, len);
> -			lsmcontext_init(&scaff, ctx, len, 0);
> -			security_release_secctx(&scaff);
> +			memcpy(sig_data->ctx, context.context, context.len);
> +			security_release_secctx(&context);
>   		}
>   		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
>   				 sig_data, sizeof(*sig_data) + len);
