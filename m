Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B014C433B4
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 18:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFBC6143D
	for <selinux@archiver.kernel.org>; Wed, 12 May 2021 18:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhELSdX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 May 2021 14:33:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355960AbhELS3v (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 May 2021 14:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620844122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yViV+D7nvZNWK7BrQFGGMNSG9K5nonUPRjpM+bk0vcY=;
        b=RQEHDKMyal8Wz4Bvz4p8dI8rlr3mq6bfqggP0EdLlvaBc+lXsK9mCGtfpJeNX+FU2PApO2
        Jak7kOQ8c2i2nsfzVrCv49YznYUcM3f8JBOpk8wLbTZsN5o1n4Ridrn5I7Rb6Uu2uuud+p
        l5lRQk2gXBNWXDpvaYAJxtJdUCKJas8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-EIFQYxLaN26RA8LvZUhSPA-1; Wed, 12 May 2021 14:28:40 -0400
X-MC-Unique: EIFQYxLaN26RA8LvZUhSPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9658E107ACCD;
        Wed, 12 May 2021 18:28:39 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEE7510074E5;
        Wed, 12 May 2021 18:28:24 +0000 (UTC)
Date:   Wed, 12 May 2021 14:28:21 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        linux-audit@redhat.com
Subject: Re: [PATCH v2] lsm_audit,selinux: pass IB device name by reference
Message-ID: <20210512182821.GB447005@madcap2.tricolour.ca>
References: <20210512143210.248684-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512143210.248684-1-omosnace@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2021-05-12 16:32, Ondrej Mosnacek wrote:
> While trying to address a Coverity warning that the dev_name string
> might end up unterminated when strcpy'ing it in
> selinux_ib_endport_manage_subnet(), I realized that it is possible (and
> simpler) to just pass the dev_name pointer directly, rather than copying
> the string to a buffer.
> 
> The ibendport variable goes out of scope at the end of the function
> anyway, so the lifetime of the dev_name pointer will never be shorter
> than that of ibendport, thus we can safely just pass the dev_name
> pointer and be done with it.

Agreed, this is better (other than the unrelated whitespace changes).

> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  include/linux/lsm_audit.h | 8 ++++----
>  security/selinux/hooks.c  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> v2: just pass the dev_name pointer and avoid the string copy
> 
> v1:
> https://lore.kernel.org/selinux/20210507130445.145457-1-omosnace@redhat.com/T/
> 
> diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
> index cd23355d2271..17d02eda9538 100644
> --- a/include/linux/lsm_audit.h
> +++ b/include/linux/lsm_audit.h
> @@ -48,13 +48,13 @@ struct lsm_ioctlop_audit {
>  };
>  
>  struct lsm_ibpkey_audit {
> -	u64	subnet_prefix;
> -	u16	pkey;
> +	u64 subnet_prefix;
> +	u16 pkey;
>  };
>  
>  struct lsm_ibendport_audit {
> -	char	dev_name[IB_DEVICE_NAME_MAX];
> -	u8	port;
> +	const char *dev_name;
> +	u8 port;
>  };
>  
>  /* Auxiliary data to use in generating the audit record. */
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 92f909a2e8f7..4d9764dad18f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6864,7 +6864,7 @@ static int selinux_ib_endport_manage_subnet(void *ib_sec, const char *dev_name,
>  		return err;
>  
>  	ad.type = LSM_AUDIT_DATA_IBENDPORT;
> -	strncpy(ibendport.dev_name, dev_name, sizeof(ibendport.dev_name));
> +	ibendport.dev_name = dev_name;
>  	ibendport.port = port_num;
>  	ad.u.ibendport = &ibendport;
>  	return avc_has_perm(&selinux_state,
> -- 
> 2.31.1
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

