Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C15C83004
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 13:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAA62085B
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 13:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ta7i4sMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgD2Ncd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:32:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51099 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726836AbgD2Ncd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Apr 2020 09:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588167151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bf3kxis0btJgtVhJQlPwmJnY9M8HIdjbWMpOD7tiVrY=;
        b=Ta7i4sMak+p7e0E5owJWYOOIAOwamsEZTsKVn8DiI/aO5jTmxbUK3R+zEz/ByrbVfj+xpJ
        WbTGUteLEK+sGzonzAz4fLRCjJpzdHOakGJTbHk+w+TchEmU9YnZ6eIeodP2vFMioXI35/
        7NlzciMp5ZLgqwmzdCjlB0OnlInBa1Y=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-5VxdnDavOxGM4qpWa0k_nw-1; Wed, 29 Apr 2020 09:32:26 -0400
X-MC-Unique: 5VxdnDavOxGM4qpWa0k_nw-1
Received: by mail-oo1-f71.google.com with SMTP id a144so2399462oob.6
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2020 06:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bf3kxis0btJgtVhJQlPwmJnY9M8HIdjbWMpOD7tiVrY=;
        b=es4cPLb1gfwl1MPK/aDDqwx2P7KmPIYwy2h4Y/2LcBx9r4j5hVuIu09HXXl3Qoj5L8
         yRuCHvuBLxlTelomaNe1Rnnq1lLtT8psoyoN7i+UKMUwg2DB8EyrjCEKKeuRjLt34CjP
         c6g+7ux+21iQ8zTWHrdwqG4HG4i6IsA0asx9wppNVv+qQqg/3c4aRjAUnrVXw3I1MpKa
         3eGtbQWK2fMDAIBEscC0MVIRppNlOO8Xl97ERSO3BIiUpsf0CBjm+Di1z29u5b9ksR/6
         zi1xJ2MZ4ZoDopjDBs7aFApsWM1bVc9j58gjgfPtso+YbtVoZ2JNWpWrrb7YtJhIyp5r
         U62g==
X-Gm-Message-State: AGi0Pub4Ch61GpByJU9Sdn6A3/YELrq/h4SLl9uVdmcQU2WQfazVMa7V
        IytOuKPPM4P8b2DVOXF/f/lJ0Sq/JemHjJX8AvoTgmaFNvjw5cwgcUHyO/+yyA80YRYkHRy3eXZ
        62AItnxqKu9zOmN0JNA9jleXtBAojmqlJMQ==
X-Received: by 2002:a4a:7011:: with SMTP id r17mr27113649ooc.17.1588167145494;
        Wed, 29 Apr 2020 06:32:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypJOKx2XaJ21j+Of+N8/HPxm0iumAt04qu3nEx6pVAxonv7aNRyTotycK9QIHj8gO7y/qxKfQ233mGEPk7rsAkk=
X-Received: by 2002:a4a:7011:: with SMTP id r17mr27113618ooc.17.1588167145179;
 Wed, 29 Apr 2020 06:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200429073053.83660-1-weiyongjun1@huawei.com> <20200429130738.GQ2014@kadam>
In-Reply-To: <20200429130738.GQ2014@kadam>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 29 Apr 2020 15:32:13 +0200
Message-ID: <CAFqZXNs=YTn-mnzSEssR1szRhSw7Ajdaqg=wy88O_F3gBL2rOQ@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: fix error return code in policydb_read()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 29, 2020 at 3:15 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Wed, Apr 29, 2020 at 07:30:53AM +0000, Wei Yongjun wrote:
> > Fix to return negative error code -ENOMEM from the kvcalloc() error
> > handling case instead of 0, as done elsewhere in this function.
> >
>
> Please add a Fixes tag and Cc Kent.
>
> Fixes: acdf52d97f82 ("selinux: convert to kvmalloc")
>
>
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  security/selinux/ss/policydb.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index a0b3dc152468..a51e051df2cc 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -2638,6 +2638,7 @@ int policydb_read(struct policydb *p, void *fp)
> >       if (rc)
> >               goto bad;
> >
> > +     rc = -ENOMEM;
> >       p->type_attr_map_array = kvcalloc(p->p_types.nprim,
> >                                         sizeof(*p->type_attr_map_array),
> >                                         GFP_KERNEL);
>
> There is another bug earlier in the function as well:
>
> security/selinux/ss/policydb.c
>   2537
>   2538          rc = next_entry(buf, fp, sizeof(u32));
>   2539          if (rc)
>   2540                  goto bad;
>   2541          nel = le32_to_cpu(buf[0]);
>   2542
>   2543          p->role_tr = hashtab_create(role_trans_hash, role_trans_cmp, nel);
>   2544          if (!p->role_tr)
>   2545                  goto bad;
>                         ^^^^^^^^
>
>   2546          for (i = 0; i < nel; i++) {
>   2547                  rc = -ENOMEM;
>
> This style of setting the error code seems very bug prone.
>
> The Fixes tag for this one is:
> Fixes: e67b2ec9f617 ("selinux: store role transitions in a hash table")

FYI, this one is also indirectly fixed by this patch, which is
currently pending review:
https://patchwork.kernel.org/patch/11514495/

>
> Just put both tags in the commit message.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

