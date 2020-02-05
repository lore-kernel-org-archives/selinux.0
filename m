Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8458FC352A2
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4242F20730
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 15:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="OkMY6dL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgBEPh0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:37:26 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:32029 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgBEPhZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 10:37:25 -0500
X-EEMSG-check-017: 54895075|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="54895075"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Feb 2020 15:37:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580917041; x=1612453041;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=yyO5Qkb2mUvTFE5iOeyIyGmva9CdWcgpCB59/ynz3yk=;
  b=OkMY6dL9b6cPSiOPEUImVe7R+58cDUuL7ogHgSSK6+t7S9fH4N0TTrNz
   kYTIUEYs/oM940mwdDn1uXJNYPRvYxdRwwvk2xLSiVoFy5LmY6hQR2477
   V3KLrVxvzdZWDMIVIKIUoA4Z4MtlgRBB5LjCuv2osriBVXkXL1SxvLmgC
   ILX5KVoptjmziiE38jlIc5AQRkkvwZMlLeQgdcauuoEODsQlxqkiDBM3H
   e1sznB+lEdMblDEeWwULrHwdESBYskWz+ikGPXvw5qvzV7RPDToba+9ga
   fAg6zVV8DvR83GVKByRtifVihghD0lIloJ0SAkMnI1k051fCfDYhTmwRV
   g==;
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="32711178"
IronPort-PHdr: =?us-ascii?q?9a23=3AIkssOxTyhBVCYjiFyoJvGxW919psv+yvbD5Q0Y?=
 =?us-ascii?q?Iujvd0So/mwa6zYxGN2/xhgRfzUJnB7Loc0qyK6vymBDVLvsjJ8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HJr3dVdOhbx2JlLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsOqofVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDnMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlinxlf7e/iAyz8Uim0uD8Wci00E?=
 =?us-ascii?q?pKripYidbArGwC1xvW6sWBV/Bz/V+h1C6S2w3c5exIO0A5mbfBJ5I/zbM8iI?=
 =?us-ascii?q?AfvVnFEyTrgkv5lrWWeV8h+uWw7uTnZajpqYGEOo9vjwH+LrwumsuiAeQkKg?=
 =?us-ascii?q?QOX3aU+eC71LD74U32Wq9KjvwrkqnCqpzaJMIbpqC+Aw9OzIks9wyzDyum0d?=
 =?us-ascii?q?sEnXkHK0hJeBSbgIjyJ17COvX4Dfa7g1i0kTdrwe7JPqH5D5nQIXXOn63tcL?=
 =?us-ascii?q?Zg50JG1gY+ws5T64hJBr0ZJfL8QE7xtNjWDh8jNAy0xv7qCM5g2YMFQm+PHq?=
 =?us-ascii?q?+YP7/SsV+P/O4vJfKMa5UPtDbyLPgl+ebijWUlll8FYampwZwXZWigHvRiOU?=
 =?us-ascii?q?qZfGbsgs0aHmgQpQc+VvLlh0CCUTFJe3a+Rb4z5jY+CIi+F4fMWpitgKCd3C?=
 =?us-ascii?q?e8BpBWfX5JClSNEXfuaoWFVOwBaDydIsB/iDwIT7uhRJE71RGoqgD6z6BrLu?=
 =?us-ascii?q?3O+i0X5trf041N6vHJ3TU76CBuBc2W0ynZV2V9g38STTYexq1zoUVhjFyE1P?=
 =?us-ascii?q?48y+dVEd1V+uNhTAg3L9jfwvZ8BtS0XRjOLfmTT1PzecmrGTE8SJoKxtYKZ0?=
 =?us-ascii?q?tsU4G5ggvrwzuhA7hTkaeCQpMz7PSPjDDKO89hxiOeh+EahF48T54KbDb3iw?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DeBAC44Dpe/wHyM5BlHQEBAQkBEQUFAYF7gX2BGFUgE?=
 =?us-ascii?q?iqEFYkDhmMGgRIliXCKJ4ckCQEBAQEBAQEBASsMAQGDe0UCgl44EwIQAQEBB?=
 =?us-ascii?q?AEBAQEBBQMBAWyFNwyCOykBgwEBAQEBAgEjFUYLCw4KAgImAgJXBgEMBgIBA?=
 =?us-ascii?q?YJjPwGCVgUgD6tGdYEyhUqDQYE4BoEOKow8eYEHgREnDAOCXT6CZAKEdYJeB?=
 =?us-ascii?q?I1biV9Gl2aCRIJOhHyOcwYbmwktjjWIapRGIoFYKwgCGAghDzuCbFAYDZIQi?=
 =?us-ascii?q?nEjAzCOTwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 05 Feb 2020 15:37:20 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 015FaTR3143668;
        Wed, 5 Feb 2020 10:36:29 -0500
Subject: Re: [PATCH v2] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20200204194603.525561-1-plautrba@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <586d36e7-3296-3e22-85ea-95a8649a8409@tycho.nsa.gov>
Date:   Wed, 5 Feb 2020 10:38:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204194603.525561-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/4/20 2:46 PM, Petr Lautrbach wrote:
> get_ordered_context_list() code used to ask the kernel to compute the complete
> set of reachable contexts using /sys/fs/selinux/user aka
> security_compute_user(). This set can be so huge so that it doesn't fit into a
> kernel page and security_compute_user() fails. Even if it doesn't fail,
> get_ordered_context_list() throws away the vast majority of the returned
> contexts because they don't match anything in
> /etc/selinux/targeted/contexts/default_contexts or
> /etc/selinux/targeted/contexts/users/
> 
> get_ordered_context_list() is rewritten to compute set of contexts based on
> /etc/selinux/targeted/contexts/users/ and
> /etc/selinux/targeted/contexts/default_contexts files and to return only valid
> contexts, using security_check_context(), from this set.
> 
> Fixes: https://github.com/SELinuxProject/selinux/issues/28
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
<snip>
> After:
>>>> selinux.get_ordered_context_list("staff_u", "system_u:system_r:crond_t:s0-s0:c0.c1023")
> ['staff_u:staff_r:staff_t:s0-s0:c0.c1023', 'staff_u:staff_r:cronjob_t:s0-s0:c0.c1023', 'staff_u:staff_r:staff_t:s0-s0:c0.c1023', 'staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023', 'staff_u:unconfined_r:unconfined_t:s0-s0:c0.c1023', 'staff_u:staff_r:cronjob_t:s0-s0:c0.c1023', 'staff_u:sysadm_r:cronjob_t:s0-s0:c0.c1023', 'staff_u:system_r:system_cronjob_t:s0-s0:c0.c1023', 'staff_u:unconfined_r:unconfined_cronjob_t:s0-s0:c0.c1023']

We should likely de-duplicate the list; I think that was being handled 
previously by virtue of using the reachable contexts as our baseline and 
just re-ordering them.  Here we just need to check whether we already 
have a context in the list before inserting a new one.

> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
> index 689e46589f30..a3dcaea2ffc4 100644
> --- a/libselinux/src/get_context_list.c
> +++ b/libselinux/src/get_context_list.c
> @@ -114,61 +115,25 @@ int get_default_context(const char *user,
<snip>
> @@ -243,23 +209,66 @@ static int get_context_order(FILE * fp,
<snip>
> +		context_range_set(usercon, fromlevel);
> +		usercon_str = context_str(usercon);

Both context_range_set() and context_str() could fail on an allocation 
failure, returning 1 or NULL respectively.

