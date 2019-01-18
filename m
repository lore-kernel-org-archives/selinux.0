Return-Path: <SRS0=8zWZ=P2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2429AC43387
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 13:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC17E2087E
	for <selinux@archiver.kernel.org>; Fri, 18 Jan 2019 13:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Kwbfx3ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfARNgH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:36:07 -0500
Received: from upbd19pa07.eemsg.mail.mil ([214.24.27.82]:63302 "EHLO
        upbd19pa07.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfARNgH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Jan 2019 08:36:07 -0500
X-EEMSG-check-017: 193374237|UPBD19PA07_EEMSG_MP7.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by upbd19pa07.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Jan 2019 13:36:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547818562; x=1579354562;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3tT01C4iucN5FjZ6nIdb0M0SldffES3KMCGsYIvn67Y=;
  b=Kwbfx3ugpGrw4xuY9Hcb6XXmp6tWADsUgx7mVMnDAdfZPj5zp7+M3yi4
   /kp7SN77N5fDZgZ8CNGR+cm5Pl6cpMxClyRNaJUigKAIH5NP6Rw/bjTxu
   M8qXrUBgdTT90nTNN6F+2QOCy8lfAv2nyhwaVkwyH1bvznaV/UaXK1UMv
   ZdszCb60gvFGSrfg53LgjpweNu1xd3tEscSf926pR/L1kHfP9mwBor5ew
   YN04cEhgzSg6s8c22EHxCOy/16G7Ai14jg0HXWdJTmFBS3haqjY6z1PLE
   XyaphDyKYVRSsLENFiT/eZ2qVY4wCmlbi5OJq5ums758kwtDaDMv7/gDD
   w==;
X-IronPort-AV: E=Sophos;i="5.56,491,1539648000"; 
   d="scan'208";a="19659009"
IronPort-PHdr: =?us-ascii?q?9a23=3A3i3DIRRQ8jBASvT5GLmsBfgBhNpsv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa67ZRKEt8tkgFKBZ4jH8fUM07OQ7/iwHzRYqb+681k6OKRWUB?=
 =?us-ascii?q?EEjchE1ycBO+WiTXPBEfjxciYhF95DXlI2t1uyMExSBdqsLwaK+i764jEdAA?=
 =?us-ascii?q?jwOhRoLerpBIHSk9631+ev8JHPfglEnjWwba9xIRmssQndqtQdjJd/JKo21h?=
 =?us-ascii?q?bHuGZDdf5MxWNvK1KTnhL86dm18ZV+7SleuO8v+tBZX6nicKs2UbJXDDI9M2?=
 =?us-ascii?q?Ao/8LrrgXMTRGO5nQHTGoblAdDDhXf4xH7WpfxtTb6tvZ41SKHM8D6Uaw4VD?=
 =?us-ascii?q?K/5KpwVhTmlDkIOCI48GHPi8x/kqRboA66pxdix4LYeZyZOOZicq/Ye94VS3?=
 =?us-ascii?q?BBXsJMXCJfBI2yYZYEA+4YMepFs4Xxol0Dpga8CwaxHuPi0iJGiGH43aM60O?=
 =?us-ascii?q?ovHw/J0wMiEN0Sv3rZt8n1OaUIXOyp0KXFwzfOYvVL0jn98ojIdRUhrOmRU7?=
 =?us-ascii?q?Jsb8XR0UkvGB3Djl6NtILlOima1uAJs2eF7+trSOWii3U6pAFquTWv2scthZ?=
 =?us-ascii?q?XJhoIS0FzE8z55z5wvKd23T057f8epHZ1NvC+UMIt2R9ktQ2BuuCsi0L0Jp4?=
 =?us-ascii?q?O0fCgQx5Q73RLQd/uHc42O7xn+V+iROS91iG9qdb+wnRq/8VWsxvfiWsS7zl?=
 =?us-ascii?q?pGtDdJn9/RvX4XzRPT8NKISv5l80ek3jaAyh7c5/lfIUAxiarbM5khwqMslp?=
 =?us-ascii?q?YLsUTMACv2mELuga+KbEok4Omo6/n8Yrn8up+dN5N7igH5Mqg0nMywHf84PR?=
 =?us-ascii?q?QUU2ie+OS80KXv/Uz/QLpUkv07irTVvZ/VKMgBpqO1HhVZ3pgs5hqhFTuqzc?=
 =?us-ascii?q?wUnXwdI1JEfBKHgZLpO1bLIP3gFvewnk+snSx3x/HGIrLhApLNImLFkLf6Z7?=
 =?us-ascii?q?lx8UFcyA0tzdxH/ZJbFqkBIO7vWk/2rNHYCRo5Mwuvw+bhEtpyyp0RVHmVAq?=
 =?us-ascii?q?CHLazSsUWH5v41L+aQY48VvS73K+I56P72kX85hVgdcLGy3ZQJbHC4H/JmI1?=
 =?us-ascii?q?iWYHf3nNcBHnkFvhAkQOzpllKCSzhTaGi2X64m4TE7Eo2mB5/ZRo+xmLyBwD?=
 =?us-ascii?q?u7HppOa2BeEF+MDHPoep6cW/gWdSKSJtZtkjkDVbimUY8uywuiuxP9y7piNu?=
 =?us-ascii?q?DU4DEXtYr/1Nhp4O3ejRUy9T1yD8SA3GCBVnt7nn4VSD83wKByulZ9xUme3q?=
 =?us-ascii?q?h4mfNYCcZf6O9OUgc/LZTc1fB1C8juWgLdedeEUE2mQtq8ATEsVd0+2MQDY1?=
 =?us-ascii?q?xjFNq/jhDMxTaqD6UJmLyMAZw+6rjc0GTpJ8Zh13bG07EsgEQoQ8RVMW2mna?=
 =?us-ascii?q?5/+hPJB4HXjkqZl7yldbgG0CHR82eDyDnGgEYNdwh8S6jHFVUYfU3fptn6rh?=
 =?us-ascii?q?fFSri1D70sPyNbxMKCI7cMYdrs2xEOX/rnOdLDc0qvlGqqQxWF3LWBaMztYW?=
 =?us-ascii?q?pZlB3UFUxMtgcU53vOYRA3GyOJu2vDCHlrElX1bgXn9uwo+12hSUph9B2Hd0?=
 =?us-ascii?q?1s0fKO/xcRgfGNA6cI0qkspDYqqzIyGk20md3RFYzT9EJaYKxAbIZlsx983m?=
 =?us-ascii?q?XDulk4Z8X4Ig=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2BPAACi1UFc/wHyM5BkGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?YFbKWaBAieEAZRPAQEEBoEICCWJM5BJMAgBhEACglsiOBIBAwEBAQEBAQIBb?=
 =?us-ascii?q?BwMgjopAYJmAQEBAQIBIxVBEAsOCgICJgICVwYBDAYCAQGCXz8BgXQFCA+rE?=
 =?us-ascii?q?YEvhUOEdAWBC4s2F3iBB4E4DIIqNYMeBBiBMYMfglcCiVAVhiVJOVaQPgmHJ?=
 =?us-ascii?q?IpxBhiSFIoEhRyNWiGBVisIAhgIIQ+DJ4InF4NLinEhAzABgQQBAYkGAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 18 Jan 2019 13:36:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0IDZx8Y022239;
        Fri, 18 Jan 2019 08:35:59 -0500
Subject: Re: [RFC PATCH] selinux: log invalid contexts in AVCs
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, Steve Grubb <sgrubb@redhat.com>,
        Daniel Walsh <dwalsh@redhat.com>
References: <20190118100429.11703-1-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f8e77d94-c192-5888-1153-3ca38919fbc2@tycho.nsa.gov>
Date:   Fri, 18 Jan 2019 08:38:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190118100429.11703-1-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/18/19 5:04 AM, Ondrej Mosnacek wrote:
> In case a file has an invalid context set, in an AVC record generated
> upon access to such file, the target context is always reported as
> unlabeled. This patch adds new optional fields to the AVC record (slcon
> and tlcon) that report the actual context string if it differs from the
> one reported in scontext/tcontext. This is useful for diagnosing SELinux
> denials.
> 
> To trigger an AVC that illustrates this situation:
> 
>      # setenforce 0
>      # touch /tmp/testfile
>      # setfattr -n security.selinux -v system_u:object_r:banana_t:s0 /tmp/testfile
>      # runcon system_u:system_r:sshd_t:s0 cat /tmp/testfile
> 
> AVC before:
> 
> type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file permissive=1
> 
> AVC after:
> 
> type=AVC msg=audit(1547801083.248:11): avc:  denied  { open } for  pid=1149 comm="cat" path="/tmp/testfile" dev="tmpfs" ino=6608 scontext=system_u:system_r:sshd_t:s0 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tlcon=system_u:object_r:banana_t:s0 tclass=file permissive=1
> 
> Cc: Daniel Walsh <dwalsh@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1135683
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>   security/selinux/avc.c | 49 +++++++++++++++++++++++++-----------------
>   1 file changed, 29 insertions(+), 20 deletions(-)
> 
> I'm not entirely sure about the record format here, so I'm Cc'ing
> linux-audit and Steve for feedback. I went for optional fields to
> minimize the size of the record, but maybe a different format is
> preferred. If so, let me know and I'll do a respin.
> 
> Also, I accept suggestions for better field names than "slcon"/"tlcon"
> ("lcon" is meant as an acronym for "literal context", but I'm not sure
> if that's a good name...).

We've typically referred to them as "raw contexts", as in the comments 
in hooks.c:selinux_inode_getsecurity():
         /*
          * If the caller has CAP_MAC_ADMIN, then get the raw context
          * value even if it is not defined by current policy; otherwise,
          * use the in-core value under current policy.
          * Use the non-auditing forms of the permission checks since
          * getxattr may be called by unprivileged processes commonly
          * and lack of permission just means that we fall back to the
          * in-core context value, not a denial.
          */

On the other hand, we also use that term in the selinux userspace to 
refer to the kernel contexts before they are translated by mcstransd. 
Still, I think raw is better than literal here.

> 
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 9b63d8ee1687..4a181ed56e37 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -165,6 +165,32 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
>   	audit_log_format(ab, " }");
>   }
>   
> +static void avc_dump_sid(struct audit_buffer *ab, struct selinux_state *state,
> +			 u32 sid, char type)
> +{
> +	int rc;
> +	char *context, *lcontext;
> +	u32 context_len, lcontext_len;
> +
> +	rc = security_sid_to_context(state, sid, &context, &context_len);
> +	if (rc) {
> +		audit_log_format(ab, "%csid=%d ", type, sid);
> +		return;
> +	}
> +
> +	audit_log_format(ab, "%ccontext=%s ", type, context);
> +
> +	/* in case of invalid context report also the actual context string */
> +	rc = security_sid_to_context_force(state, sid, &lcontext,
> +					   &lcontext_len);
> +	if (!rc) {
> +		if (strcmp(context, lcontext))
> +			audit_log_format(ab, "%clcon=%s ", type, lcontext);
> +		kfree(lcontext);
> +	}
> +	kfree(context);

Optimally we'd have a nicer way of testing whether a SID corresponds to 
an invalid context rather than having to turn it into a context string 
and compare.  Maybe a new security server interface?

> +}
> +
>   /**
>    * avc_dump_query - Display a SID pair and a class in human-readable form.
>    * @ssid: source security identifier
> @@ -174,28 +200,11 @@ static void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
>   static void avc_dump_query(struct audit_buffer *ab, struct selinux_state *state,
>   			   u32 ssid, u32 tsid, u16 tclass)
>   {
> -	int rc;
> -	char *scontext;
> -	u32 scontext_len;
> -
> -	rc = security_sid_to_context(state, ssid, &scontext, &scontext_len);
> -	if (rc)
> -		audit_log_format(ab, "ssid=%d", ssid);
> -	else {
> -		audit_log_format(ab, "scontext=%s", scontext);
> -		kfree(scontext);
> -	}
> -
> -	rc = security_sid_to_context(state, tsid, &scontext, &scontext_len);
> -	if (rc)
> -		audit_log_format(ab, " tsid=%d", tsid);
> -	else {
> -		audit_log_format(ab, " tcontext=%s", scontext);
> -		kfree(scontext);
> -	}
> +	avc_dump_sid(ab, state, ssid, 's');
> +	avc_dump_sid(ab, state, tsid, 't');
>   
>   	BUG_ON(!tclass || tclass >= ARRAY_SIZE(secclass_map));
> -	audit_log_format(ab, " tclass=%s", secclass_map[tclass-1].name);
> +	audit_log_format(ab, "tclass=%s", secclass_map[tclass-1].name);
>   }
>   
>   /**
> 

