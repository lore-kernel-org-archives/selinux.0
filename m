Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA3DC2D0DB
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 13:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908952075D
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 13:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="pxv4eVXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbgAXN3t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jan 2020 08:29:49 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:16907 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387634AbgAXN3t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jan 2020 08:29:49 -0500
X-EEMSG-check-017: 49328223|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,357,1574121600"; 
   d="scan'208";a="49328223"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 Jan 2020 13:29:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579872585; x=1611408585;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Rr08VRjjLk5Sh1rOF3sfT58GlrG+bDp+V/hz4op4M3U=;
  b=pxv4eVXk7wNsOOBOj3J9zHiQ6S+czKnLUWnEflyMYUemobAWeNJ8P4m7
   c0GvWY4mMnCDhA8wMDhnJSbe1XLaSXhUpmyoMEJAcur0/4ysNvdF/HIi4
   enOR7QEx5LUnhkrMj/D+VNy00D4bgjPXyA0Pbro5vndn4aYNiqUef7b4S
   73UK0lKqpZjSUVdg9PChYtmdXXIjcioL+5VdKxZvKeuHgiXFrUIhshPAV
   Ht8Kt4rutxHn4LodeJIGWojkHxEh0lgw3i7smaMRyNDOFb+9//MViP+4F
   2pCAPqRU2Hp7mFZrJ+wxPv4YjsQUYXslAouZbpyyH5IlNIEXfu2wSS/ZD
   A==;
X-IronPort-AV: E=Sophos;i="5.70,357,1574121600"; 
   d="scan'208";a="38201264"
IronPort-PHdr: =?us-ascii?q?9a23=3ATO/0HR2dOrmCRtJpsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseITKPad9pjvdHbS+e9qxAeQG9mCt7Qe16GK4uigATVGvc/a9ihaMdRlbF?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam5VuJ6k+xh?=
 =?us-ascii?q?bGpnZDZuBayX91KV6JkBvw+8m98IR//yhMvv4q6tJNX7j9c6kkV7JTES4oM3?=
 =?us-ascii?q?oy5M3ltBnDSRWA634BWWgIkRRGHhbI4gjiUpj+riX1uOx92DKHPcLtVrA7RS?=
 =?us-ascii?q?6i76ZwRxD2jioMKiM0/3vWisx0i6JbvQ6hqhliyIPafI2ZKPxzdb7TctMAQW?=
 =?us-ascii?q?pKQ9hfWSpPDIiha4cDFuoMMOJdo4T7ulAArwaxBRO0Ce3y1DFIiH/406403e?=
 =?us-ascii?q?svHg7J3hAvEd0VvXTIrtj4LrseXfy7waTKyzjIcvNY2S366IjNah0vvO2MUq?=
 =?us-ascii?q?xoccrR10YvER7OgEiVqYP/OzOV0voCsmiG5OdnTuKglnUnphptojmv2sgsio?=
 =?us-ascii?q?7JipgTylDf7yp12ok1JdqmSENiZ9OvDZhetzmCOodrTc4vTHtktSYnxrEcp5?=
 =?us-ascii?q?K2czYGxI46yxPZdveJaZKH4gj5W+aUOTp4gXVld6+hiBuq6kigz/H8VtGz0F?=
 =?us-ascii?q?ZXsipJitnMuW4J1xzU8sWHVuFy/l2g2TaSzADf8OBEIUY6larcMJ4u3KI/mo?=
 =?us-ascii?q?APsUXDAiD2mEL2gLWQdko44ein9/7rYrDnpp+YL4N0iwf+PboymsGnHOg1PQ?=
 =?us-ascii?q?cDU3Kb9OihzrHv40L0TKtQgvEriqXZtYrVJcUfpq63GQ9V1YMj5g6kDzi7y9?=
 =?us-ascii?q?QVhmUHLVJZdxKHiIjlIVfOIOviAvuljFSslylry+jcPrL9GpXNMmTDkLD5cL?=
 =?us-ascii?q?Zm9UFczAszzdZC55NbEbwBPv3zVVHrtNDCDR82LRa0w+D5B9V5zI8eXniPAq?=
 =?us-ascii?q?CBOqPIrVCI/v4vI/WLZIINozn9Kvcl5/nojXIihFASY7Km3ZoNZ3C+BPhmJF?=
 =?us-ascii?q?+ZYXW/yusGRHwHugs4UfzCllKPS3hQamy0UqZ64Ss0W6y8CoKWfZygmLyM2m?=
 =?us-ascii?q?+AG5RSYm1XQgSXHWzAa5SPW/BKbjmbZMBmjGpXBvCaV4Y92ET250fBwL19I7?=
 =?us-ascii?q?+Rp3wV?=
X-IPAS-Result: =?us-ascii?q?A2BTAACp7ype/wHyM5BlHAEBAQEBBwEBEQEEBAEBgWkFA?=
 =?us-ascii?q?QELAYF8gW0gEiqEEokDhngGgTeJb4olhSmBewkBAQEBAQEBAQE3AQGEQAKCR?=
 =?us-ascii?q?jYHDgIQAQEBBAEBAQEBBQMBAWyFQ4I7KYJ7AQUjBBFBEAsYAgImAgJXEwYCA?=
 =?us-ascii?q?QGCVww/glclrHV/M4VKg0GBPoEOKgGMMHmBB4ERJw+CXT6HWYJeBI1ciVhGl?=
 =?us-ascii?q?16CQ4JMk2UGG5p8LatBCSmBWCsIAhgIIQ+DJ1AYDYgNF45BIwMwjVYBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 Jan 2020 13:29:44 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00ODT2Q3210275;
        Fri, 24 Jan 2020 08:29:02 -0500
Subject: Re: [PATCH] libselinux: export flush_class_cache(), call it on
 policyload
To:     selinux@vger.kernel.org
Cc:     bigon@debian.org
References: <20200121162532.29494-1-sds@tycho.nsa.gov>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <2f5f7fa0-4db2-d2e8-2c57-6e28e4c5a770@tycho.nsa.gov>
Date:   Fri, 24 Jan 2020 08:30:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200121162532.29494-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/21/20 11:25 AM, Stephen Smalley wrote:
> Rename flush_class_cache() to selinux_flush_class_cache(), export it
> for direct use by userspace policy enforcers, and call it on all policy
> load notifications rather than only when using selinux_check_access().
> This ensures that policy reloads that change a userspace class or
> permission value will be reflected by subsequent string_to_security_class()
> or string_to_av_perm() calls.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

This is now applied.  This should resolve the lingering problems with 
dbus-daemon not getting the updated class/permission values via 
string_to_security_class/string_to_av_perm after a policy reload that 
changes the dbus class.

> ---
>   libselinux/include/selinux/selinux.h |  3 +++
>   libselinux/src/avc_internal.c        |  2 ++
>   libselinux/src/checkAccess.c         | 13 -------------
>   libselinux/src/selinux_internal.h    |  3 +--
>   libselinux/src/stringrep.c           |  4 +++-
>   5 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index fe46e681488d..7922d96b70c7 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -418,6 +418,9 @@ extern int security_av_string(security_class_t tclass,
>   /* Display an access vector in a string representation. */
>   extern void print_access_vector(security_class_t tclass, access_vector_t av);
>   
> +/* Flush the SELinux class cache, e.g. upon a policy reload. */
> +extern void selinux_flush_class_cache(void);
> +
>   /* Set the function used by matchpathcon_init when displaying
>      errors about the file_contexts configuration.  If not set,
>      then this defaults to fprintf(stderr, fmt, ...). */
> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> index 49cecc96daee..568a3d928ac1 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -23,6 +23,7 @@
>   #include "callbacks.h"
>   #include "selinux_netlink.h"
>   #include "avc_internal.h"
> +#include "selinux_internal.h"
>   
>   #ifndef NETLINK_SELINUX
>   #define NETLINK_SELINUX 7
> @@ -207,6 +208,7 @@ static int avc_netlink_process(void *buf)
>   				avc_prefix, rc, errno);
>   			return rc;
>   		}
> +		selinux_flush_class_cache();
>   		rc = selinux_netlink_policyload(msg->seqno);
>   		if (rc < 0)
>   			return rc;
> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> index 16bfcfb63f85..7227ffe51eac 100644
> --- a/libselinux/src/checkAccess.c
> +++ b/libselinux/src/checkAccess.c
> @@ -10,25 +10,12 @@
>   static pthread_once_t once = PTHREAD_ONCE_INIT;
>   static int selinux_enabled;
>   
> -static int avc_reset_callback(uint32_t event __attribute__((unused)),
> -		      security_id_t ssid __attribute__((unused)),
> -		      security_id_t tsid __attribute__((unused)),
> -		      security_class_t tclass __attribute__((unused)),
> -		      access_vector_t perms __attribute__((unused)),
> -		      access_vector_t *out_retained __attribute__((unused)))
> -{
> -	flush_class_cache();
> -	return 0;
> -}
> -
>   static void avc_init_once(void)
>   {
>   	selinux_enabled = is_selinux_enabled();
>   	if (selinux_enabled == 1) {
>   		if (avc_open(NULL, 0))
>   			return;
> -		avc_add_callback(avc_reset_callback, AVC_CALLBACK_RESET,
> -				 0, 0, 0, 0);
>   	}
>   }
>   
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
> index 8b4bed2fd0d1..61b78aaa7c10 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -107,8 +107,7 @@ hidden_proto(selinux_trans_to_raw_context);
>   hidden_proto(security_get_initial_context);
>   hidden_proto(security_get_initial_context_raw);
>   hidden_proto(selinux_reset_config);
> -
> -hidden void flush_class_cache(void);
> +hidden_proto(selinux_flush_class_cache);
>   
>   extern int require_seusers hidden;
>   extern int selinux_page_size hidden;
> diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
> index 4db95398e138..29757b750878 100644
> --- a/libselinux/src/stringrep.c
> +++ b/libselinux/src/stringrep.c
> @@ -158,7 +158,7 @@ err1:
>   	return NULL;
>   }
>   
> -hidden void flush_class_cache(void)
> +void selinux_flush_class_cache(void)
>   {
>   	struct discover_class_node *cur = discover_class_cache, *prev = NULL;
>   	size_t i;
> @@ -180,6 +180,8 @@ hidden void flush_class_cache(void)
>   	discover_class_cache = NULL;
>   }
>   
> +hidden_def(selinux_flush_class_cache)
> +
>   security_class_t string_to_security_class(const char *s)
>   {
>   	struct discover_class_node *node;
> 

