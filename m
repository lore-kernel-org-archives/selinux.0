Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A4FC43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06BE2067C
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 18:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="GJXl90v6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfLQSL2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:11:28 -0500
Received: from USAT19PA20.eemsg.mail.mil ([214.24.22.194]:53774 "EHLO
        USAT19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQSL2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 13:11:28 -0500
X-EEMSG-check-017: 61429447|USAT19PA20_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="61429447"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USAT19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 18:11:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576606285; x=1608142285;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FxqWYHdpmK2JXg0zOnLCC8dqCnMoy4DrIWJPdvI/MvA=;
  b=GJXl90v6NL+XHUyicWUrvkSq9Kz8O5QMQzdcqU8gDIDEMzW1NVVgBYnq
   /ACYhCtIQ80ri+aSUNad2MBIt88tCPMb2hxhXkJqJVZOvfROJWy5nwsjI
   iWOf/Va9+vj8iKM3BdApWcmpoO6D2mOJnqDakkS7g6N6T6Qb09xxF0Eq7
   91nvPuO0mxgAtrktL2dpUWxq1sHkEE/g5PMyPKI7sTPVjyZqGfIsYhivG
   g6Na7zf826KrKxyqUfTDv9NJ75CuvDsPO52fJ+iuGFIY3GvAEYWnx8JK2
   duQeuaf+PcFlWcmhTa+CZPwnFZ+w3hio6sHFZc62FGvyzcgTMUh+OovX9
   w==;
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="31198984"
IronPort-PHdr: =?us-ascii?q?9a23=3A3vspcxfP/WP3zYLTtGVUt4pKlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc2+YxCN2/xhgRfzUJnB7Loc0qyK6vumAzRfqs/Z7zgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNcajZdgJ6o+1x?=
 =?us-ascii?q?fFvnlFcPlKyG11Il6egwzy7dqq8p559CRQtfMh98peXqj/Yq81U79WAik4Pm?=
 =?us-ascii?q?4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WS?=
 =?us-ascii?q?m+76puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQX?=
 =?us-ascii?q?NNUttNWyBdB4+xaYUAD/AFPe1FsYfzoVUApga6CQW1Gu/izjpEi3nr1qM4zu?=
 =?us-ascii?q?shCxnL0hE+EdIAsHrar9v7O6kdXu+30KbGwi7Ob+9U1Drn9ITEbh4srPOKUL?=
 =?us-ascii?q?ltccTR004vFwbdg1uNtYzqISuV1uQTvGid8uFuSOevhHQjqwF1vDeuxtonh4?=
 =?us-ascii?q?7Sho0I0VDJ7jl5wYYpKt24T053e9ikEIBKuC2AOIt2Rd0iTnhutS0nybMGoY?=
 =?us-ascii?q?a2cDUFxZko3RLSa+GLf5KW7h/sSuqdOyp0iXR4c7ylnRmy61KvyujkW8mx11?=
 =?us-ascii?q?ZFszRKn8HXtnAIyxzT8s+HSuZh/ku52TaAyQTT6uZcLEAoj6XbMZ8hwqMrlp?=
 =?us-ascii?q?YJsETDGCH2mELtjKCIakoo4PSo6uT7bbXmoZ+QLYl0hR3lMqsygMC/BOU4Mg?=
 =?us-ascii?q?wWU2ia/+SzyqHj8FXkTLhFgfA6iKnUvI3AKcgFqaO1HRVZ3ps75xa6FTim0d?=
 =?us-ascii?q?AYnXcdLFJCfRKKl5PpNEzVIP3jEfe+g0ijkDdsx/zcOL3hGY/CImLMkLfmY7?=
 =?us-ascii?q?Zx81RcxxYrzdBD+5JUDakML+7pVU/qqtPZDgQ0MxeozObnEtp9y40eWWaRDa?=
 =?us-ascii?q?+DKa/drUWH6vgzLOmLYY8foCz9JOQ95/7ykX85nkcQcrWz0psMdn+5Hu5qI1?=
 =?us-ascii?q?6FbnrsmNgBDGkKvg4gQ+zwk1CCUDhTZ2qsUKI4/D00FIWmDYLbTIC3nLOBxD?=
 =?us-ascii?q?u7HoFRZm1eCFCMFHDod5+eW/cNcyKfOclhnSYBVbe/So8tzxautBX1y7B/NO?=
 =?us-ascii?q?rb5jUYtY7/1Nhy/+DTkRAy9TppD8WSym2NVH97kX8VRz8s3aB/vUx8xk6G0a?=
 =?us-ascii?q?h/nvNYCNhT6O1SXwckOp7T0fZ6B8rxWg3fZNeJTkipQtG8DTE2VNIxzMcEY1?=
 =?us-ascii?q?xhFNW6khDDwy2qDqcOl7OVAJw086Tc32X+Jstm1XbG27cuj0M8TstMK2KmnK?=
 =?us-ascii?q?h/+BbXB4LTlEWZjamqf7wG3CHR7GeD0XaOvEZAXQ5zT6rKQ2sfaVfRrdT+5U?=
 =?us-ascii?q?PPVKOhCbQ9MgtGzM6CK7ZKatjzgVVBXvfjN8zUY3itlGeoGRaI2rSMYZLoe2?=
 =?us-ascii?q?Ua3CXdDlIIkwIU/XaGLwc+ADyhrHzYDDF1CV3geUXs8e54qHO6UkA71QWKY1?=
 =?us-ascii?q?d92Lqy/x4fneacRO8L3rIYpCchrC15HE6j0NLQBNqAugthfKNFbdM+/lhHz2?=
 =?us-ascii?q?TZuBJ5PpG7LqBun1oecwNpv0zwzRl3EZ9Pkcs3rHMw1gV+M6SY301bezOaxZ?=
 =?us-ascii?q?D6IqfXJXXq/BCzd67W3UnT0M6M9acS7PQ1sE3jsxu0Fkom6nln1t5V03yG5p?=
 =?us-ascii?q?rUFgYdTZXxUkNkvyR98prTeSQsr7jf1XRxP625qHeW0NsyCfoN0R2gdspRNK?=
 =?us-ascii?q?6eUQT7VcYdAp7qYOcjgFW4KAkPPOlP+qo5JeunceeL3OigO+Mk1DCjin5d4Z?=
 =?us-ascii?q?tV1EuJ+is6TfTHm94BwveFzk6cWjzhlla9o4XynoxZYTw6AGWy027nCZRXa6?=
 =?us-ascii?q?k0epwETS+1Lsm2wMhur4DiVmQe91O5AV4Cnsizdkm8dVv4iDZM2FwXrHrvoi?=
 =?us-ascii?q?6xyzh5gnl9taaE9DDfyOTlMhwcMyhEQ3c03gSkGpS9k91PBBvgVAMujhbwoB?=
 =?us-ascii?q?+glqU=3D?=
X-IPAS-Result: =?us-ascii?q?A2ARAABLGfld/wHyM5BlGgEBAQEBAQEBAQMBAQEBEQEBA?=
 =?us-ascii?q?QICAQEBAYFtAgEBAQELAYFzgW0gEiqEBIkDhngGgTeJaooihyMJAQEBAQEBA?=
 =?us-ascii?q?QEBNwEBhEACgjw3Bg4CEAEBAQQBAQEBAQUDAQFshUOCOykBgnkBAQEBAgEjF?=
 =?us-ascii?q?UEFCwsYAgImAgJXBgEMBgIBAYJfP4JTBSCtS3WBMoVPg0KBSIEOKAGMMXmBB?=
 =?us-ascii?q?4ERJw+CXT6HWYJeBI1BiUtGlzOCPoJCk0gGG5pJLY4gnF0jgVgrCAIYCCEPg?=
 =?us-ascii?q?ydQERSNHheOQSMDMJEeXwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 17 Dec 2019 18:11:24 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHIB4PL161176;
        Tue, 17 Dec 2019 13:11:05 -0500
Subject: Re: [PATCH v12 09/25] LSM: Use lsmblob in security_task_getsecid
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
References: <20191216223621.5127-1-casey@schaufler-ca.com>
 <20191216223621.5127-10-casey@schaufler-ca.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cb38eba1-1fb1-13df-e396-ee620794c375@tycho.nsa.gov>
Date:   Tue, 17 Dec 2019 13:11:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216223621.5127-10-casey@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/16/19 5:36 PM, Casey Schaufler wrote:
> Change the security_task_getsecid() interface to fill in
> a lsmblob structure instead of a u32 secid in support of
> LSM stacking. Audit interfaces will need to collect all
> possible secids for possible reporting.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org
> ---
>   drivers/android/binder.c              |  4 +--
>   include/linux/security.h              |  7 +++--
>   kernel/audit.c                        | 11 +++----
>   kernel/auditfilter.c                  |  4 +--
>   kernel/auditsc.c                      | 18 ++++++++----
>   net/netlabel/netlabel_unlabeled.c     |  5 +++-
>   net/netlabel/netlabel_user.h          |  6 +++-
>   security/integrity/ima/ima_appraise.c |  4 ++-
>   security/integrity/ima/ima_main.c     | 42 +++++++++++++++------------
>   security/security.c                   | 12 ++++++--
>   10 files changed, 69 insertions(+), 44 deletions(-)
> 

> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 300c8d2943c5..69e549164949 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -49,11 +49,13 @@ bool is_ima_appraise_enabled(void)
>   int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
>   {
>   	u32 secid;
> +	struct lsmblob blob;
>   
>   	if (!ima_appraise)
>   		return 0;
>   
> -	security_task_getsecid(current, &secid);
> +	security_task_getsecid(current, &blob);
> +	lsmblob_secid(&blob, &secid);
>   	return ima_match_policy(inode, current_cred(), secid, func, mask,
>   				IMA_APPRAISE | IMA_HASH, NULL, NULL);
>   }

I missed where lsmblob_secid() is defined?  Looks like it is later 
deleted by patch 12/25.  Leftover from an earlier version of the series? 
  Have you checked that it compiles after each patch?


