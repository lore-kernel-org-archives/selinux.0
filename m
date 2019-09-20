Return-Path: <SRS0=JJ8R=XP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE726C49ED7
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 14:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92432080F
	for <selinux@archiver.kernel.org>; Fri, 20 Sep 2019 14:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="exIWO/j7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387898AbfITOWS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:22:18 -0400
Received: from USFB19PA36.eemsg.mail.mil ([214.24.26.199]:2949 "EHLO
        USFB19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387892AbfITOWS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Sep 2019 10:22:18 -0400
X-EEMSG-check-017: 10486793|USFB19PA36_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="10486793"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA36.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 20 Sep 2019 14:22:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1568989336; x=1600525336;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=Fq7FgjJOEArN/qPiEiJnDTa0ERb8kqlkohPx53dmmaY=;
  b=exIWO/j7QO0tAK8G5zi3S3ccjfl2SeXUSBfRsyK8pj9MqJAvOWsLaXYB
   M29us+YRSwzGOIByZMK4+58VNL4EqoRWzTz+mYAJUGvsDDh/DPj704ZyH
   B1/hNlUA6nfHkucGpWaIopW3Rf9kbKFhbeSJ0QQhRu88vCvyNHPk/yX+3
   e4kmGC4E4rE/EwB7sHOYjG9j4gSDcb6/c3nhVS7dvk7sLj35cGT8JKxve
   FmjJ3XeN2xWA56mfYZ0IqlT9W9lNzVXcC91K9EFU/xPQt6wDTRoFKjVv3
   FXtqy+00NNCPfbWUEYAmGIf1HGuSqjdPCqZz9VSrQ+BVUDBIJCjDfYnfK
   w==;
X-IronPort-AV: E=Sophos;i="5.64,528,1559520000"; 
   d="scan'208";a="28143878"
IronPort-PHdr: =?us-ascii?q?9a23=3AkIRiNR8pGWHKav9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B22+4cTK2v8tzYMVDF4r011RmVBN6dsagP1Lae8/i5HzBZu9DZ6DFKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMIjYd8Jao8yB?=
 =?us-ascii?q?TEqWZMd+hK2G9kP12ekwvi6suq4JJv7yFcsO89+sBdVqn3Y742RqFCAjQ8NG?=
 =?us-ascii?q?A16szrtR3dQgaK+3ARTGYYnAdWDgbc9B31UYv/vSX8tupmxSmVJtb2QqwuWT?=
 =?us-ascii?q?Sj9KhkVhnlgzoaOjEj8WHXjstwjL9HoB+kuhdyzZLYbJ2TOfFjZa7WY88USn?=
 =?us-ascii?q?RdUcZQTyxBA52zb40TD+oaIO1Uq5Dxq0YSoReiAAWhAu3gyiVMhnTrw6M01e?=
 =?us-ascii?q?ovGhzC0AA5Ad4DtHHYodPoP6kQTO+11rHFwyjdYfNY2Tnz64bGfR4urv6OQb?=
 =?us-ascii?q?1+ftHcyVUtGg7fklmctYLoMjGT2+8Qs2ab9e1gVee3hmA6twF+vCCvxscyhY?=
 =?us-ascii?q?nPm4kb11XE+j99wIYxO9K5SFNwbNm/EJRNrCGXLJd2Q8M+TGFovyY20LsGuY?=
 =?us-ascii?q?WhcyQQx5QnwADfZuWBfoOV7BzjU+ORLi15hHJjYL+wmxey8VK8xe34SMa4yU?=
 =?us-ascii?q?xFrjBZktnNuHACzQDc6tScSvdn4kih3jOP2gbO4e9HOUA5jbfXJpEuz7Iqlp?=
 =?us-ascii?q?cfrF7PEjH5lUnolqOaa0Mp8fWy5ev9eLXpvJqcOpdxigH5L6shhNSyAf89Mg?=
 =?us-ascii?q?gSR2ib/vm81KH78U35XrpKivo2n7HFsJ/AP8Qbp7O5AxRP3oY/6xewEzem0N?=
 =?us-ascii?q?MCkXkBMF1FYw6Ig5LsO1HPJPD0Ffa/g1Kynzd33/3KI7LsD5rXInXDjbvtZ6?=
 =?us-ascii?q?hx5kFCxAYp0NxT/5dUBasAIPL3VE/xrtvYDhohPgyv3unnE85w1p8eWG2TAq?=
 =?us-ascii?q?+ZN7nesVmT5u01OeWMa4gVuCjlJ/g/+/HulWM5mUMafaSx25sXaWy3HvNiI0?=
 =?us-ascii?q?qDenrgmNYBEWANvgolV+znk1iCXDFcZnqoWKI8/D47Apq8DYjfXoCtnKCB3C?=
 =?us-ascii?q?CjE51NeG9GDlGMEXH1d4SLQPoMdi2SLdF7kjAeVriuVZUh1Rewuw/+0bZnKf?=
 =?us-ascii?q?DU+iJL/a7kgf507OrXnAp61DtzFN/Vh2eMRGZwl3hORjgxx7tXpBBtjFCZ3v?=
 =?us-ascii?q?48y+dVEd1V+uNhTAg3L9jfwvZ8BtS0XRjOLfmTT1PzecmrGTE8SJoKxtYKZ0?=
 =?us-ascii?q?tsU4G5ggvrwzuhA7hTkaeCQpMz7PSPjDDKO89hxiOeh+EahF48T54KbDf3iw?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2CgAQDR34Rd/wHyM5BlHAEBAQQBAQcEAQGBVQUBAQsBg?=
 =?us-ascii?q?XMqbVMyKoQijxdNAQEBAQEBBoE2iXWPLYF7CQEBAQEBAQEBAS8FAQIBAYQ/A?=
 =?us-ascii?q?oMJIzYHDgIMAQEBBAEBAQEBBQMBAWyFLQyCOikBgmcBBSMEEVELGAICJgICV?=
 =?us-ascii?q?wYBDAYCAQGCXz8BgXYUD6wJfzOENwEDAQIDCENAgzaBQwaBDCgBjAgYeIEHg?=
 =?us-ascii?q?REngms+gmEEhGqCWASMTYk1lwuCLIIuhFeNfwYbmSaOGpsYDiOBWCsIAhgII?=
 =?us-ascii?q?Q+DJxM9EBSBWheDT4pvJAMwAYEFAQGONgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 20 Sep 2019 14:22:14 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8KEMEiF009328;
        Fri, 20 Sep 2019 10:22:14 -0400
Subject: Re: [PATCH v2 1/2] libselinux: ensure strlen() is not called on NULL
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
References: <20190920055955.2780-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8142cbbb-055d-d61e-2f43-8e6b34306e61@tycho.nsa.gov>
Date:   Fri, 20 Sep 2019 10:22:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190920055955.2780-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/20/19 1:59 AM, Nicolas Iooss wrote:
> When compile_regex() calls regex_prepare_data() and this function fails
> in the following condition:
> 
>      *regex = regex_data_create();
>      if (!(*regex))
>          return -1;
> 
> ... error_data has been zero-ed and compile_regex() calls:
> 
>      regex_format_error(&error_data,
>          regex_error_format_buffer,
>          sizeof(regex_error_format_buffer));
> 
> This leads to a call to strlen(error_data->error_buffer), where
> error_data->error_buffer is NULL.
> 
> Avoid this by checking that error_data->error_buffer is not NULL before
> trying to format it.
> 
> This issue has been found using clang's static analyzer:
> https://337-118970575-gh.circle-artifacts.com/0/output-scan-build/2019-09-01-181851-6152-1/report-0b122b.html#EndPath
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Personally, I would have just used a single error message for both cases 
(and only wrapped the condition itself with #ifdef...#else...#endif), 
but I'm ok with this as well.

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   libselinux/src/regex.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index a6fcbbfec1f3..c835dd1b0e5d 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -519,6 +519,29 @@ void regex_format_error(struct regex_error_data const *error_data, char *buffer,
>   	if (pos >= buf_size)
>   		goto truncated;
>   
> +	/* Return early if there is no error to format */
> +#ifdef USE_PCRE2
> +	if (!error_data->error_code) {
> +		rc = snprintf(buffer + pos, buf_size - pos, "no error code");
> +		if (rc < 0)
> +			abort();
> +		pos += rc;
> +		if (pos >= buf_size)
> +			goto truncated;
> +		return;
> +	}
> +#else
> +	if (!error_data->error_buffer) {
> +		rc = snprintf(buffer + pos, buf_size - pos, "empty error");
> +		if (rc < 0)
> +			abort();
> +		pos += rc;
> +		if (pos >= buf_size)
> +			goto truncated;
> +		return;
> +	}
> +#endif
> +
>   	if (error_data->error_offset > 0) {
>   #ifdef USE_PCRE2
>   		rc = snprintf(buffer + pos, buf_size - pos, "At offset %zu: ",
> 

