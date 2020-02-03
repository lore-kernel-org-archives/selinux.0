Return-Path: <SRS0=lcCQ=3X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EB2C35247
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 19:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597FE2051A
	for <selinux@archiver.kernel.org>; Mon,  3 Feb 2020 19:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="n9S1dFUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgBCTgs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:36:48 -0500
Received: from UPDC19PA23.eemsg.mail.mil ([214.24.27.198]:51790 "EHLO
        UPDC19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCTgs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Feb 2020 14:36:48 -0500
X-EEMSG-check-017: 53728343|UPDC19PA23_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="53728343"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Feb 2020 19:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580758604; x=1612294604;
  h=subject:from:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Nz1TtZ+IEXgYM+n+AhtW/swRr0n6GVumGdQLLRLyf10=;
  b=n9S1dFUj3ou8c27WE3MEr5LJRUMQZamDy9aYrg0Yy9uYv2pHIngWq3Fa
   tNvnZWvhWL29iyYoybDMp56lLz+9SPLxYSDmDN+ssc0nVAAkN6rrSnsGG
   K+zetoadflfMhW17PYGX3SjFOg7DNTV/5F//AH88QMCCBCsr7cn+WpeS6
   eBdYxTlOyNsYpKeShl507hvAxopQxMxzYiv9g9lY5A6/+Uojql3GbsCsh
   cviHVakrC5kkZsPirqWXEnKFTGD7hZ6StuUEArcwZkUAaXnxAbQIwECQr
   eDGKirzuPYa0EO/aa8HpgEvekFIN5u+B+WqPeo+AtSD13ZXHSwcXCo9c4
   g==;
X-IronPort-AV: E=Sophos;i="5.70,398,1574121600"; 
   d="scan'208";a="38609981"
IronPort-PHdr: =?us-ascii?q?9a23=3ALWcMGh8dfE1lOf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+1uoRIJqq85mqBkHD//Il1AaPAdyHra4bwLOM6eigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4RvJ6Q+xh?=
 =?us-ascii?q?fUvHdEZfldyWd0KV6OhRrx6dq88ZB5/yhMp/4t8tNLXLnncag/UbFWFiktPX?=
 =?us-ascii?q?ov5M3suxnDTA+P6WUZX24LjBdGABXL4Q/jUJvpvST0quRy2C+BPc3rVr80Qi?=
 =?us-ascii?q?it771qSBDzligKMSMy/XzNhcxxiKJbpw+hpwB6zoXJboyZKOZyc6XAdt4BW2?=
 =?us-ascii?q?FPQtheWDBAAoOkbosAEewBPfpDr4Lgo1cCtAayCRWwCO/qzDJHiGX23akn2O?=
 =?us-ascii?q?o/Fw/I0hErE9YXvHnUqNj5MaEfWv23wqbV1zXOd+5Y1zfj5ojGcR4vr/+DUr?=
 =?us-ascii?q?1yfsXNxkciDB/Fg1aKpID5Iz+Y2OYAvm6G5ORgT+KvjGsnphlsrDiz2Mgsko?=
 =?us-ascii?q?nJiZwTylvZ6Ct5xZw6Jdm8SEFlYd+vDZxdtzqHOIttWc4iX2Fptzo6yr0Bo5?=
 =?us-ascii?q?K7ejMKx449yx7QbPyHbZGF7xT+X+iSOTd1nG9pdb2wihqo8UWs1/fwWte73V?=
 =?us-ascii?q?pUtCZJj9/BvW0X2RPJ8MiIUP5981+k2TaIyg/c9PlJIVsxlarHM54hxaMwlo?=
 =?us-ascii?q?YLvUTDACD2nEL2gbeKdko+4Oio6vnnYq78qp+dMY90hAb+Mr8wlcOjG+g4Lg?=
 =?us-ascii?q?gPUHSb+eS7zrHj+1H2QK5WgfEsl6nZsZTaKdwapq6/HQBVzp4u5wuwAjqpyt?=
 =?us-ascii?q?gVnWQLIEhbdB+IkYTlIUzCLOj9DfilglSslDlrx+rBPr3kGpjNNWXMkKz6cL?=
 =?us-ascii?q?Zh609T1AozzddF65JSEbEOOuj/WkD2tNzGFhM5KRC7w/77CNVh0YMTQX6ADb?=
 =?us-ascii?q?WCMKzMsV6F/fkvLPWMZIAPpTb9Jfwl6OD0jXMghVASZ7Ol0ocQaHC9Bv5mOV?=
 =?us-ascii?q?mWYWLwgtcdFmcHphYxQ/bxiFKcUT9ffW2yUL485j4hFYKmA4PDSZ63gLGa3S?=
 =?us-ascii?q?e7GIFWaX5CClyWDXjocICEUe8WaC2OOs9hjiAEVb+5Ro8j0BGusxX6y6BmLu?=
 =?us-ascii?q?rP4SAYs4js1N1r6O3Sjx0y8iZ0D8uF2WGXU250hn8IRyMx3K1npUx9y1GD0b?=
 =?us-ascii?q?V3gvBBDtxc+e9GUhogNZ7d0+x7C8n+WgfGftiUVVamRsupDCovTtI+3dAOeV?=
 =?us-ascii?q?xxG9a8gRDZ2SqlHbsVm6aMBJwu/aLWx2LxKNply3bayKkhiEErQtBROm2ih6?=
 =?us-ascii?q?5/8RXTBoHSnkWHmKala74c0DTO9Gid12qOul9XUApqXaXCR3AfaVPcrc7l6U?=
 =?us-ascii?q?PaU7+uFbMnPxNCycGcNKRKccHmjVJBRPfgI9nRf2Kxm323BRaNx7OMcY/qd3?=
 =?us-ascii?q?8a3CXHB0gOixoT8mqeNQgiGiehpHrTDD5pFVLvZUPg6+t+qHS7TkAuyQGKdF?=
 =?us-ascii?q?Nu17yu9xEJn/OcTfQT3rQFuCg9sTp0GEyx0M7RC9qFvwBhZrlTYcsh4Fdb0m?=
 =?us-ascii?q?LUrxR9MYKmL6Btm14ecgJ3s1rt1xppEIVAl9YlrHcxwQpzMK6Y1FRBdy2G0p?=
 =?us-ascii?q?zqIb3YMGry/A21a6HMwF3e1siZ9r0N6PQgs1/jph2mFlI+83V71NlYy2Oc6Y?=
 =?us-ascii?q?/XDAoWSp/xSlw49wV+p73DZyk94ITU1WdyPqWurjDC3NcpV6MZzUOLdsxSIe?=
 =?us-ascii?q?u/Hw/7DsMeCtLmfOcjgFW4RgkPPOlP+qo5JYatfr2N36v9eK5rlSmrnCJc64?=
 =?us-ascii?q?B0z0yI+jBUS+jU0pJDyPadmkOFUjDmlla6msb+nI1FIzYIES73zSniGZ4Ufa?=
 =?us-ascii?q?B5YJwKFXbrJsq729Fzr4DiVmQe91O5AV4Cnsizdl7adFH53AtNxWwJrnG93y?=
 =?us-ascii?q?i11Tp5l3cutKXM8jbJxrHZaBcfOmNNDFJnhFPoLJn828sWR2C0fgMpk12j/k?=
 =?us-ascii?q?+8yK9F8vcsZ1LPSFtFKnClZ1ppVbG94//bPp9C?=
X-IPAS-Result: =?us-ascii?q?A2D6AACKdThe/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBe4F9gW0gEoQ+iQOGXwEBBoESJYlvkUkJAQEBAQEBAQEBNwEBhEACglg4E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFQ4I7KQGDAgEFIw8BBUEQCxgCAiYCAlcGAQwIA?=
 =?us-ascii?q?QGCYz+CVyWsfIEyiROBPoEOKogshA55gQeBOAwDgl0+h1uCXgSWV4Enl2SCR?=
 =?us-ascii?q?YJOk2wGG5sIjmGdKyKBWCsIAhgIIQ+DKE8YDZ0BIwOPOQEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 03 Feb 2020 19:36:37 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 013JZbQg082047;
        Mon, 3 Feb 2020 14:35:40 -0500
Subject: Re: [PATCH v14 22/23] LSM: Add /proc attr entry for full LSM context
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20200124002306.3552-1-casey@schaufler-ca.com>
 <20200124002306.3552-23-casey@schaufler-ca.com>
 <1de8338a-9c1c-c13b-16f0-e47ebec0e7ea@tycho.nsa.gov>
 <f3dea066-1f6d-4b92-1a5b-dac25b58aae7@tycho.nsa.gov>
 <9afb8d9d-a590-0e13-bf46-53a347ea15dd@schaufler-ca.com>
 <6bd3e393-e1df-7117-d15a-81cb1946807b@tycho.nsa.gov>
 <446935fa-2926-c346-a273-ae1ecbb072cd@schaufler-ca.com>
 <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
Message-ID: <cdb0ba7f-2863-d721-7ec2-1e01464e2b41@tycho.nsa.gov>
Date:   Mon, 3 Feb 2020 14:37:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <09d96236-715a-344a-38bc-c05208698125@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/3/20 1:54 PM, Stephen Smalley wrote:
> I'd suggest something like the following instead:
> * @getprocattr
> *   Get the value of process attribute @name for task @p into a buffer
> *   allocated by the security module and returned via @value.  The
> *   caller will free the returned buffer via kfree.  The set of
> *   attribute names is fixed by proc but the format of @value is up
> *   to the security module authors except for the "context" attribute,
> *   whose value is required to be a NUL-terminated printable ASCII
> *   string without trailing whitespace.
> *   @p the task whose attribute is being fetched
> *   @name the name of the process attribute being fetched
> *   @value set to point to the buffer containing the attribute value
> *   Return the length of @value including the NUL on success, or -errno 
> on error.
> 
> The printable ASCII bit is based on what the dbus maintainer requested 
> in previous discussions.  The question of whether the terminating NUL 
> should be included in the returned length was otherwise left ambiguous 
> and inconsistent in your patch among the different security modules; if 
> you prefer not including it in the length returned by the security 
> modules, you'll need to adjust SELinux at least to not do so for "context".

BTW, I think the above guarantees with the exception of no trailing 
whitespace and whether the NUL byte is included or excluded from length 
are in reality also required for "current" (and SO_PEERSEC) or existing 
userspace will break.
