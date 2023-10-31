Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F70C4332F
	for <selinux@archiver.kernel.org>; Tue, 31 Oct 2023 10:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbjJaKME (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 31 Oct 2023 06:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbjJaKMD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 31 Oct 2023 06:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965B383
        for <selinux@vger.kernel.org>; Tue, 31 Oct 2023 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698747079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7pU6gRMWWss40bsP0tytUBoPjR2GexGH6sA0SdvX4g=;
        b=RXINUOmlr51fdb7KOgu4/mUGdiZV+NnceWZQK2gsJ07Qt33J0ELlDxHnA9p1fbLnYM9GZi
        IIygyUIPI2+GhHDUwr3E6lTo5Ks1Dz3mT2ji+afGTMGUNiVOyyFHkDdjn2CH8pdS6FnH50
        v6hXwt1JsVwR2g4SYWcJcAbVQlZpyzA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-UnE5WCWQPbuvxJJL8so-Ug-1; Tue, 31 Oct 2023 06:11:18 -0400
X-MC-Unique: UnE5WCWQPbuvxJJL8so-Ug-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC97E81D8A8;
        Tue, 31 Oct 2023 10:11:17 +0000 (UTC)
Received: from localhost (unknown [10.45.224.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CB0E492BE0;
        Tue, 31 Oct 2023 10:11:17 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     Cathy Hu <cahu@suse.de>, selinux@vger.kernel.org
Cc:     selinux@suse.de, Cathy Hu <cahu@suse.de>
Subject: Re: [PATCH v2] sepolicy/manpage.py: make output deterministic
In-Reply-To: <20231025131903.12044-1-cahu@suse.de>
References: <8734xzhtvh.fsf@redhat.com> <20231025131903.12044-1-cahu@suse.de>
Date:   Tue, 31 Oct 2023 11:11:16 +0100
Message-ID: <87pm0vgkzf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Cathy Hu <cahu@suse.de> writes:

> The list entries in the alphabetically grouped dict are
> not sorted, which results in non-deterministic output for
> index.html.
>
> Sort entries of those lists to make the output deterministic
> to be able to have reproducible builds.
>
> See https://reproducible-builds.org/ for reasoning.
> This patch was done while working on reproducible builds for openSUSE.
>
> Signed-off-by: Cathy Hu <cahu@suse.de>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

> ---
>  python/sepolicy/sepolicy/manpage.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
> index a488dcbf..62999019 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -156,7 +156,7 @@ def get_alphabet_manpages(manpage_list):
>              if j.split("/")[-1][0] == i:
>                  temp.append(j.split("/")[-1])
>  
> -        alphabet_manpages[i] = temp
> +        alphabet_manpages[i] = sorted(temp)
>  
>      return alphabet_manpages
>  
> -- 
> 2.42.0

