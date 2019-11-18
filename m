Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBBFC432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93B320748
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="UsiWJ10e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKROF5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:05:57 -0500
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:46036 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfKROF4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 09:05:56 -0500
X-EEMSG-check-017: 27774055|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,320,1569283200"; 
   d="scan'208";a="27774055"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Nov 2019 14:05:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574085955; x=1605621955;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=P+aSk9IS5GBAUrBug7yLhMxd/FPDpfR1w+V1tjWr8VA=;
  b=UsiWJ10elAuvGX8syTypkrAl2WPuhvww/o8dS5OYCr5BkiJVcZY11Dlx
   toDmvGLVaFqr/QEZ1jUvw7hzbeIRWVNSupiVyvd0GfjGAcxfKieLeP2s1
   raCdyNnvIvX+SmB8JV0Yt078r03wALkJa59xQTFsh3w0tSWFpze1Zg0/M
   ORw14FRJykKIYyz/lmkJi4kDv+uyDy4VITg1bv88CZ0hJMH0HNEQtgAfk
   wZrTmHmqYOtBzqzUsfPuF0isji/nmCNDCzk5ud0E5PBopiWyKI9FtsLSx
   jCKGbcxdTiPy26fPm9HWqM30E5x/ibYxM07N7RZqg5LOE2Z5fMFy/W0Zq
   Q==;
X-IronPort-AV: E=Sophos;i="5.68,320,1569283200"; 
   d="scan'208";a="30207722"
IronPort-PHdr: =?us-ascii?q?9a23=3AYnqgGxIqVd60lp4+0tmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeIvXxwZ3uMQTl6Ol3ixeRBMOHsqkC0raI+Pu4EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm7ogTcusYYjId+N6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK4Ihw7Eslp?=
 =?us-ascii?q?oTtl7PHinql0XtkKCabEAk+ums6+j/Y7XmoIGTN5Nshw3jPakjldazDOQlPg?=
 =?us-ascii?q?QUQWSW9vqw2Kf+8UHhRbVFlPw2kq3XsJDAIsQbo7a0AxRI3YY48Bu/Ezen38?=
 =?us-ascii?q?gYnXkANl5FfgmHgJLzN1HBJ/D4E++zg06wnzdz2/DGIrrhD43KLnjGl7fhZr?=
 =?us-ascii?q?B95FRAxwUt1t1f/YxbBawBIP3pRk/9rsDXDhg8Mwas2eboFM191p8CWWKIGq?=
 =?us-ascii?q?KZK73dsVuJ5uIpPumNa5QYuCjyK/c7/f7il3w5lkEHfamvw5QXbGq0HvN8I0?=
 =?us-ascii?q?WWMjLQhYImF2sQswh2aevxjlSJXD0bM3G3WLk67zo2IJirAYfKWsamh7nXmG?=
 =?us-ascii?q?+gE5lXYH1WIk6DHG2udIieXfoILiWILZxPiDsBAIO9Rpch2Bfmjwrzz75qP6?=
 =?us-ascii?q?KA4SEDnY7y39hyoevInFc98iIiXJfV6H2EU2whxjBAfDQxxq0q5BUmm1o=3D?=
X-IPAS-Result: =?us-ascii?q?A2A2BwBdodJd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bd?=
 =?us-ascii?q?CyBQTIqhCqPCFIBAQaBNolmkUMJAQEBAQEBAQEBNAECAQGEQAKCIyQ4EwIOA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFQ4I7KQGCbQEFIxVRCw4KAgImAgJXBgEMBgIBAYJfP?=
 =?us-ascii?q?4JTJbAFgTKFToMngUiBDiiMFRh4gQeBOIJrPodVgl4ElltGlwiCNII3kxIGG?=
 =?us-ascii?q?5oRjkicGSKBWCsIAhgIIQ+DJ1ARFJ9+IwMwgQUBAY1eAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Nov 2019 14:05:51 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xAIE5p2t022245;
        Mon, 18 Nov 2019 09:05:51 -0500
Subject: Re: [PATCH testsuite v3 2/3] policy: add fallbacks for
 Fedora-specific macros
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
References: <20191118123056.338496-1-omosnace@redhat.com>
 <20191118123056.338496-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <90518acb-e642-44a3-3ad1-7937d04f2a5e@tycho.nsa.gov>
Date:   Mon, 18 Nov 2019 09:05:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191118123056.338496-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/18/19 7:30 AM, Ondrej Mosnacek wrote:
> dev_rw_infiniband_dev() and mount_rw_pid_files() are not defined in
> refpolicy. Fall back to dev_rw_generic_files() and
> mount_rw_runtime_files() if they are not defined.
> 
> Also, userdom_search_admin_dir() is not defined in refpolicy because it
> doesn't have admin_home_t. Fall back to
> userdom_search_user_home_content(), which should apply for root's home
> directory under refpolicy.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Is there a reason you didn't make the changes I suggested to 
dev_rw_infiniband_dev()?

> ---
>   policy/test_policy.if | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index 939cd7e..38214a9 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -60,3 +60,24 @@ interface(`userdom_sysadm_entry_spec_domtrans_to',`
>           allow $1 sysadm_t:process sigchld;
>   ')
>   ')
> +
> +# Workarounds for refpolicy:
> +
> +ifdef(`dev_rw_infiniband_dev', `', ` dnl
> +interface(`dev_rw_infiniband_dev', `
> +    dev_rw_generic_files($1)
> +')
> +')
> +
> +ifdef(`mount_rw_pid_files', `', ` dnl
> +interface(`mount_rw_pid_files', `
> +    mount_rw_runtime_files($1)
> +')
> +')
> +
> +# Refpolicy doesn't have admin_home_t - assume /root will be user_home_dir_t.
> +ifdef(`userdom_search_admin_dir', `', ` dnl
> +interface(`userdom_search_admin_dir', `
> +    userdom_search_user_home_content($1)
> +')
> +')
> 

