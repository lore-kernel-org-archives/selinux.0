Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB919C4332F
	for <selinux@archiver.kernel.org>; Fri, 14 Oct 2022 10:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJNKlJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Oct 2022 06:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiJNKlI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Oct 2022 06:41:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35F61C69E3
        for <selinux@vger.kernel.org>; Fri, 14 Oct 2022 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665744065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8I0dFc/bPwtED2+VqxSN4EIMJXmu+Fr0l+Q/2kq0Vxc=;
        b=BHnNRdL+GDpArZ9FeO7Urdj2yuoWnVwvjVBuWe/ov3DzYxGbfuGgzqJQgFEI3/trlqq5Uu
        C4tjTDAnbvuR1vV+QQPNYPdUI9LpTIy6VyL69wB1dIy4+xWwVpAmi1Kgcgdf1JesSTHE/7
        xIhGoFdaYgYQjyRgahFMl66NZfh9Al4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-Lwm_yTyFOhi3Azfv8oVl4Q-1; Fri, 14 Oct 2022 06:41:02 -0400
X-MC-Unique: Lwm_yTyFOhi3Azfv8oVl4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B94A0862FF0
        for <selinux@vger.kernel.org>; Fri, 14 Oct 2022 10:41:01 +0000 (UTC)
Received: from localhost (ovpn-194-85.brq.redhat.com [10.40.194.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 70E4F21449A0
        for <selinux@vger.kernel.org>; Fri, 14 Oct 2022 10:41:01 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH] libselinux: Add missing '\n' to avc_log() messages
In-Reply-To: <20221011112733.194079-1-plautrba@redhat.com>
References: <20221011112733.194079-1-plautrba@redhat.com>
Date:   Fri, 14 Oct 2022 12:41:00 +0200
Message-ID: <877d12sn5v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libselinux/src/avc.c          | 2 +-
>  libselinux/src/avc_internal.c | 4 ++--
>  libselinux/src/checkAccess.c  | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> index 8d5983a2fe0c..98a3fcae41c8 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -725,7 +725,7 @@ void avc_audit(security_id_t ssid, security_id_t tsid,
>  	if (denied)
>  		log_append(avc_audit_buf, " permissive=%u", result ? 0 : 1);
>  
> -	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
> +	avc_log(SELINUX_AVC, "%s\n", avc_audit_buf);


There is a conflict between this change and commit 142372522c7e ("libselinux: avoid
newline in avc message").

I'll send another version without it.


>  
>  	avc_release_lock(avc_log_lock);
>  }
> diff --git a/libselinux/src/avc_internal.c b/libselinux/src/avc_internal.c
> index 71a1357bc564..c550e5788527 100644
> --- a/libselinux/src/avc_internal.c
> +++ b/libselinux/src/avc_internal.c
> @@ -59,7 +59,7 @@ int avc_process_setenforce(int enforcing)
>  	int rc = 0;
>  
>  	avc_log(SELINUX_SETENFORCE,
> -		"%s:  op=setenforce lsm=selinux enforcing=%d res=1",
> +		"%s:  op=setenforce lsm=selinux enforcing=%d res=1\n",
>  		avc_prefix, enforcing);
>  	if (avc_setenforce)
>  		goto out;
> @@ -81,7 +81,7 @@ int avc_process_policyload(uint32_t seqno)
>  	int rc = 0;
>  
>  	avc_log(SELINUX_POLICYLOAD,
> -		"%s:  op=load_policy lsm=selinux seqno=%u res=1",
> +		"%s:  op=load_policy lsm=selinux seqno=%u res=1\n",
>  		avc_prefix, seqno);
>  	rc = avc_ss_reset(seqno);
>  	if (rc < 0) {
> diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
> index 022cd6b5ecab..319af267c6a7 100644
> --- a/libselinux/src/checkAccess.c
> +++ b/libselinux/src/checkAccess.c
> @@ -44,7 +44,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
>         sclass = string_to_security_class(class);
>         if (sclass == 0) {
>  	       rc = errno;
> -	       avc_log(SELINUX_ERROR, "Unknown class %s", class);
> +	       avc_log(SELINUX_ERROR, "Unknown class %s\n", class);
>  	       if (security_deny_unknown() == 0)
>  		       return 0;
>  	       errno = rc;
> @@ -54,7 +54,7 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
>         av = string_to_av_perm(sclass, perm);
>         if (av == 0) {
>  	       rc = errno;
> -	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
> +	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s\n", perm, class);
>  	       if (security_deny_unknown() == 0)
>  		       return 0;
>  	       errno = rc;
> -- 
> 2.37.3

