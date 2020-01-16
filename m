Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F3C33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B292E20730
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="BInPKA1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgAPQdz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:33:55 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:42973 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPQdy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 11:33:54 -0500
X-EEMSG-check-017: 46515451|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="46515451"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 16 Jan 2020 16:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579192431; x=1610728431;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=C9jcebGN5Y6nq+IXwDDpJJ9bJMV0SiuvMmFPT5kVkvM=;
  b=BInPKA1LpqhpCCiXNas9P6BjBdkXgxs2OTkfcmNzn3vxB5sKOsWieqb2
   p5CKdFcK5CCxczP1R8WPYfOfYSW1oaqdTaqCKHnq7bkOWap8KtPa91O9K
   SL1qAicme2zFv+qccnE6FDOJ9ap39VZcQEWegCpc4tqUSucMcCrm3pdDa
   AR0PgJlpQetTycTVAr2KuVFQAPGb3qWbd+t4lG2iC8uUbyzqodzcNW++q
   yN2G69LOs+uEfSzgnNxIkGGLVZRC4H1ALa3EGhJoeSHUKpGtmvQPlLwh6
   GnvViZSU43XVsHFe6wZupsds4BY/68Y7H439Ggw/zisNwRYjFyW8L2bGu
   w==;
X-IronPort-AV: E=Sophos;i="5.70,326,1574121600"; 
   d="scan'208";a="37883664"
IronPort-PHdr: =?us-ascii?q?9a23=3AkA/1NRWnd1BpZEPq/CsssNGi18TV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSFu6dThVPEFb/W9+hDw7KP9fy5BSpYvN3R7ThCKMUKC0?=
 =?us-ascii?q?Zez51O3kQJO42sMQXDNvnkbig3ToxpdWRO2DWFC3VTA9v0fFbIo3e/vnY4Ex?=
 =?us-ascii?q?T7MhdpdKyuQtaBx8u42Pqv9JLNfg5GmCSyYa9oLBWxsA7dqtQajZFtJ6osxR?=
 =?us-ascii?q?bFuGdEduRZyW5rJV+YghLw6tut8JJ5/Clcpvws+9RcXanmeqgzUKBVAikhP2?=
 =?us-ascii?q?0p/sPgqAPNTRGI5nsSU2UWlgRHDg3Y5xzkXZn/rzX3uPNl1CaVIcP5Q7Y0WS?=
 =?us-ascii?q?+/76hwUx/nlD0HNz8i/27JjMF7kb9Wrwigpxx7xI7UfZ2VOf9jda7TYd8WWW?=
 =?us-ascii?q?xMVdtKWidfHo2zcZcAD+sZPeZZsYb9oUcOrQCjDgWoHe/j1yNEimPz0aA83e?=
 =?us-ascii?q?shCwXG1xE+EdwIvnrfsdH5OL4cXO2xyaXFyyjIYfFL1jfn8IXGbw4vof+MU7?=
 =?us-ascii?q?xzf8Tex0YgGAHZgVufsoHlIzGY2/4Rv2SH4edtV+SigHMnpQFrpTivw98hhJ?=
 =?us-ascii?q?TVho0L0lDE9Tt2wIAoLtOlTU50e9qkEJ9OuCCaKoB7RdgiTHxzuCsh1r0HuY?=
 =?us-ascii?q?K0fCgNyJg9wR7fcOaIf5KH4hLkSuacODF1j29mdrKnnxu+7Eetx+LmWsS0zV?=
 =?us-ascii?q?pGtDRJn9bSunwXyhDe7NWMROFn8Ue7wzmP0hje6uRDIU8pi6XWM4Uhwrsslp?=
 =?us-ascii?q?oLtkTDAzP2lF32jKCIckUk/fCl6/j9bbX8p5+cKpR0hhv/MqQolMy/Bv84PR?=
 =?us-ascii?q?YSUGSB5eS91KHs/U3+QLlQiP05jrLZv4zAKcQep665BxdZ0ocl6xmhEzeryM?=
 =?us-ascii?q?kUkHYIIV5feB+LkpLlN0/BLfzmF/uznkygkDJxyPDHOr3hDI/NLn/GkLr5Zr?=
 =?us-ascii?q?Zy9lVcxREvzdFf+51UCrYBLOj1Wk/qrtPUFBA5Mwuqw+r/EtVyypseWX6TAq?=
 =?us-ascii?q?+eKK7StlqI5uU0I+mKfoAapCjyJuM/5/HwkHA5mUUSfbWz0ZQLb3C4G+xsI1?=
 =?us-ascii?q?+Fbnr0ntcBDWAKsxIlTOP0jF2CUDhTZ2u9Xq8n+DE7B5ypDZ3ZSoCunrOBxi?=
 =?us-ascii?q?G7EYNSZmxcDVCMC3jofZ2eW/gQcCKSPtNhkjscWLi5UYAhyBWuuRTiy7V9M+?=
 =?us-ascii?q?rU/jQUtZfk1Nhy/e3ciws++iBzD8SYgCmxSDRTmG8SSj1++adkp0V2x1TLha?=
 =?us-ascii?q?99hOdeHNdez+lEXgczKdjXyOksT5jpVwbAeMqZYEipT8/gAjwrSN81hdgUbA?=
 =?us-ascii?q?I1I9y/iljm2C2wDvdBj7WWALQs+7/Ymn32INxwjX3B0f9yoUMhR550KWC+hq?=
 =?us-ascii?q?N5vzPWDorNnlTRw72mbowAzSXN8yGF1mPIs0ZGBl0jGZ7ZVGwSMxOF5e/y4V?=
 =?us-ascii?q?nPGvr3UuUq?=
X-IPAS-Result: =?us-ascii?q?A2CuBABljiBe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBIqhBCJA4ZfAQEBBoE3iW6RSQkBAQEBAQEBAQE3AQGEQAKCJjgTAhABA?=
 =?us-ascii?q?QEEAQEBAQEFAwEBbIVDgjspAYJ6AQUjBBFRCw4KAgImAgJXBgEMBgIBAYJjP?=
 =?us-ascii?q?4JXJawrfzOFSoNNgT6BDiiMNnmBB4E4D4JdPodZgl4EjVqJVkaXVoJDgkmTY?=
 =?us-ascii?q?QYbmnCOXJ0VIoFYKwgCGAghD4MnUBgNiA0XjkEjAzCNbAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 16 Jan 2020 16:33:47 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00GGX7xH018881;
        Thu, 16 Jan 2020 11:33:08 -0500
Subject: Re: [PATCH 1/6] selinux: do not allocate ancillary buffer on first
 load
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200116120439.303034-1-omosnace@redhat.com>
 <20200116120439.303034-2-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b54c441c-a0fc-7c56-e1ad-4b95cc60b644@tycho.nsa.gov>
Date:   Thu, 16 Jan 2020 11:34:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116120439.303034-2-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/16/20 7:04 AM, Ondrej Mosnacek wrote:
> In security_load_policy(), we can defer allocating the newpolicydb
> ancillary array to after checking state->initialized, thereby avoiding
> the pointless allocation when loading policy the first time.
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/ss/services.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 55cf42945cba..42ca9f6dbbf4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2183,26 +2183,17 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   	int rc = 0;
>   	struct policy_file file = { data, len }, *fp = &file;
>   
> -	oldpolicydb = kcalloc(2, sizeof(*oldpolicydb), GFP_KERNEL);
> -	if (!oldpolicydb) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> -	newpolicydb = oldpolicydb + 1;
> -
>   	policydb = &state->ss->policydb;
>   
>   	newsidtab = kmalloc(sizeof(*newsidtab), GFP_KERNEL);
> -	if (!newsidtab) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	if (!newsidtab)
> +		return -ENOMEM;
>   
>   	if (!state->initialized) {
>   		rc = policydb_read(policydb, fp);
>   		if (rc) {
>   			kfree(newsidtab);
> -			goto out;
> +			return rc;
>   		}
>   
>   		policydb->len = len;
> @@ -2211,14 +2202,14 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		if (rc) {
>   			kfree(newsidtab);
>   			policydb_destroy(policydb);
> -			goto out;
> +			return rc;
>   		}
>   
>   		rc = policydb_load_isids(policydb, newsidtab);
>   		if (rc) {
>   			kfree(newsidtab);
>   			policydb_destroy(policydb);
> -			goto out;
> +			return rc;
>   		}
>   
>   		state->ss->sidtab = newsidtab;
> @@ -2231,9 +2222,16 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
>   		selinux_status_update_policyload(state, seqno);
>   		selinux_netlbl_cache_invalidate();
>   		selinux_xfrm_notify_policyload();
> -		goto out;
> +		return 0;
>   	}
>   
> +	oldpolicydb = kcalloc(2, sizeof(*oldpolicydb), GFP_KERNEL);
> +	if (!oldpolicydb) {
> +		kfree(newsidtab);
> +		return -ENOMEM;
> +	}
> +	newpolicydb = oldpolicydb + 1;
> +
>   	rc = policydb_read(newpolicydb, fp);
>   	if (rc) {
>   		kfree(newsidtab);
> 

