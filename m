Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4BBC433F5
	for <selinux@archiver.kernel.org>; Wed, 20 Apr 2022 18:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346947AbiDTS44 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Apr 2022 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346847AbiDTS4z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Apr 2022 14:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E18B946645
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650480848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SMFuta+ToLpfRYJmHaZ8ODShu/KesOqWwJvNu43j23Q=;
        b=EtgY8AnBvGc32bweAOsV6RcAArcuFXlm74KBqUBtKvQCnlhtRNzzznjmgPNeolkYhNrtJx
        949mhOi7aUCWz1ouCRROKmR7RLAGORNff5IRiemFKVOhgRQauamCaDZj/PeZNKLNSTP/Ly
        999VAV3vTSSP8zrK8oXf4UKel+fgjnI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-xW2YxR0SNF2skzBYpwc0jg-1; Wed, 20 Apr 2022 14:54:04 -0400
X-MC-Unique: xW2YxR0SNF2skzBYpwc0jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2987B1014A60;
        Wed, 20 Apr 2022 18:54:04 +0000 (UTC)
Received: from localhost (unknown [10.40.192.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C19AA40CF91D;
        Wed, 20 Apr 2022 18:54:03 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Cc:     cgzones@googlemail.com
Subject: Re: [PATCH 1/5] libsepol/test Include policydb.h header for
 policydb_t declaration
In-Reply-To: <20220414135141.1723610-1-jwcart2@gmail.com>
References: <20220414135141.1723610-1-jwcart2@gmail.com>
Date:   Wed, 20 Apr 2022 20:54:02 +0200
Message-ID: <875yn3twl1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> Since test-linker-cond-map.h and test-linker-types.h references
> policydb_t, include the policydb header file.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

For all 5 patches:

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
>  libsepol/tests/test-linker-cond-map.h | 2 ++
>  libsepol/tests/test-linker-types.h    | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/libsepol/tests/test-linker-cond-map.h b/libsepol/tests/test-linker-cond-map.h
> index 148c6f62..740a722e 100644
> --- a/libsepol/tests/test-linker-cond-map.h
> +++ b/libsepol/tests/test-linker-cond-map.h
> @@ -21,6 +21,8 @@
>  #ifndef __TEST_LINKER_COND_MAP_H__
>  #define __TEST_LINKER_COND_MAP_H__
>  
> +#include <sepol/policydb/policydb.h>
> +
>  extern void base_cond_tests(policydb_t * base);
>  extern void module_cond_tests(policydb_t * base);
>  
> diff --git a/libsepol/tests/test-linker-types.h b/libsepol/tests/test-linker-types.h
> index 0c860ebf..acad5e0e 100644
> --- a/libsepol/tests/test-linker-types.h
> +++ b/libsepol/tests/test-linker-types.h
> @@ -21,6 +21,8 @@
>  #ifndef __TEST_LINKER_TYPES_H__
>  #define __TEST_LINKER_TYPES_H__
>  
> +#include <sepol/policydb/policydb.h>
> +
>  extern void base_type_tests(policydb_t * base);
>  extern void module_type_tests(policydb_t * base);
>  
> -- 
> 2.34.1

