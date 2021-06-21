Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E518CC4743C
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 17:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9316108E
	for <selinux@archiver.kernel.org>; Mon, 21 Jun 2021 17:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFURUB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:20:01 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:45064 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230059AbhFURUA (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 21 Jun 2021 13:20:00 -0400
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 66CFA2A0018
        for <selinux@vger.kernel.org>; Mon, 21 Jun 2021 19:17:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 66CFA2A0018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1624295865;
        bh=uj5MpdMvbg7N6Z2ILkKZadby9C07Ye6OYbfg7FQmg4Y=;
        h=From:To:Subject:References:Date:In-Reply-To:From;
        b=IAFlpderH6/YqgDDj5VSdMyXVNJ8c8JwzKs7wBPVQ5bn0DPdfhew7erMJ+dTT4+0N
         FjT+VNnw8zsV/JQkDIEonz9oQEJl5RkT1JvQ1okoNhCXfXnI3aF0NZGEkmyeXBjkK7
         B9z5TqO8cleavlsIstcIVKPCnDcAVkXcyWzPx7TY=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: Re: [SELinux-notebook PATCH] computing_security_contexts.md:
 clarify mount options with comma
References: <20210621165854.285237-1-dominick.grift@defensec.nl>
Date:   Mon, 21 Jun 2021 19:17:42 +0200
In-Reply-To: <20210621165854.285237-1-dominick.grift@defensec.nl> (Dominick
        Grift's message of "Mon, 21 Jun 2021 18:58:54 +0200")
Message-ID: <871r8vi1c9.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick Grift <dominick.grift@defensec.nl> writes:

> If you have a comma in your context then mount will reject it without
> escaped quotes. This can be confusing and it is not well documented.

Ignore this patch. It is actually thoroughly documented in mount(8).

>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
>  src/computing_security_contexts.md | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/computing_security_contexts.md b/src/computing_security_contexts.md
> index bb946b5..11d54b8 100644
> --- a/src/computing_security_contexts.md
> +++ b/src/computing_security_contexts.md
> @@ -175,7 +175,10 @@ Notes:
>     keyword present.
>  2. There are mount options for allocating various context types:
>     *context=*, *fscontext=*, *defcontext=* and *rootcontext=*. They are
> -   fully described in the ***mount**(8)* man page.
> +   fully described in the ***mount**(8)* man page except for the fact that if
> +   your context contains a comma separator then you should wrap the context
> +   with escaped quotes. For example:
> +   *context=\"system_u:object_r:container_file_t:s0:c1,c2\"*.
>  
>  ### Network File System (nfsv4.2)

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
