Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE00CC433E0
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 08:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A712065D
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 08:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQ0wS4go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgENITi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 04:19:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgENITi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 04:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589444376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pQVOaHFHiMXvheEObJYgGQunYZZXG2Tp6JH5AzK9zjs=;
        b=RQ0wS4gobsBlaPv3VY0x+zwjXU3rpyCCSGtXvh2qaKsgpLLQWnjyrZ/5YmGmAMG1gxvWf2
        kAknENofvlubRL6KxrHlWCP1XIbMcSCxuUuMTfmzfwFe7CSxLRO7loroqyw7FNr1jTjm0o
        tVLrf+qcwhDibSKMRo7PjElqqbiH9Z0=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Hd6AgojGP7O_Azde2D8EEg-1; Thu, 14 May 2020 04:19:31 -0400
X-MC-Unique: Hd6AgojGP7O_Azde2D8EEg-1
Received: by mail-oo1-f71.google.com with SMTP id e197so1255803oob.14
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 01:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQVOaHFHiMXvheEObJYgGQunYZZXG2Tp6JH5AzK9zjs=;
        b=q2Ef3F82ez44Ef7wETpbJyil1hl9b744IzZPq8xSCzJxZNZRejczkVbE+ld+q6LwEO
         /K4IlMW8zs9RyTl3kn3AL0et5xtwsnJ+TSD1QbUwz9aFo/OTQDA5G0F6KtBDsoOUuB2k
         FAccthhV2ozjLPtVKJID6sgiikHAKEEu7/H5GaQHIVZtB3hrjVszjai3m7TaSBW3yFLZ
         GnAGEPfEf/u0JGKZOjBBTV7s+CshD8/MprUfvE0dl+4yovtnfHdvsoqGdBJPMja4iyIY
         4ZxK+vPIMRhlOhPGYd+w6J5keGpM9sgDghymQ8wSYrJpQQ4ksLpeBKD3u9Z9QK/agFLs
         d49Q==
X-Gm-Message-State: AGi0Puavxjb/ee5Po7+/dOafn/+lbF7YR8EBNKP1vu3FLQMwDGSnpbPn
        5aGP/VJPFRKVn0zDpXl1e4ZoazNEDskWLJRyDT4qO6ctzNZ3nIoyjnkakbaB9GskgfTC5OnfhAe
        uosK9xIO3kKT6z/4Lo22ewXTXlkNa42S3OQ==
X-Received: by 2002:aca:488c:: with SMTP id v134mr17626983oia.103.1589444370112;
        Thu, 14 May 2020 01:19:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypJkdqv52RsruNR31botm+S60qvJ4CvYc/EOUATp5JR8jU84P4AlwSMuE+QPCFhXD7ZEJOhA1vF9Mm4LcCzDUUQ=
X-Received: by 2002:aca:488c:: with SMTP id v134mr17626966oia.103.1589444369734;
 Thu, 14 May 2020 01:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200513211508.4477-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200513211508.4477-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 14 May 2020 10:19:18 +0200
Message-ID: <CAFqZXNtNSH8_8ow-ZkAMK=UXvs_rCieUr3xgn6pqrpb-Xvnbtw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: drop broken warning on duplicate filename transitions
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 13, 2020 at 11:16 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> As per the issue below, libsepol segfaults on loading old kernel policies
> that contain duplicate filename transition rules.  The segfault is due to
> the fact that the val_to_name arrays have not yet been populated at this
> point in the policydb_read() processing.  Since this warning apparently
> never worked since it was first introduced, drop it and just silently
> discard the duplicate like the kernel does.  I was not able to produce a
> policy with such duplicates using the current policy toolchain, either
> via CIL or via binary modules with manual semodule_link/expand.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/239
> Fixes: 8fdb2255215a1f14 ("libsepol,checkpolicy: convert rangetrans and filenametrans to hashtabs")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  libsepol/src/policydb.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 5b289a52..3992ea56 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -2655,15 +2655,8 @@ int filename_trans_read(policydb_t *p, struct policy_file *fp)
>                          * Some old policies were wrongly generated with
>                          * duplicate filename transition rules.  For backward
>                          * compatibility, do not reject such policies, just
> -                        * issue a warning and ignore the duplicate.
> +                        * ignore the duplicate.
>                          */
> -                       WARN(fp->handle,
> -                            "Duplicate name-based type_transition %s %s:%s \"%s\":  %s, ignoring",
> -                            p->p_type_val_to_name[ft->stype - 1],
> -                            p->p_type_val_to_name[ft->ttype - 1],
> -                            p->p_class_val_to_name[ft->tclass - 1],
> -                            ft->name,
> -                            p->p_type_val_to_name[otype->otype - 1]);

Not sure if it's the same situation, but should we also do something
about a similar pattern in checkpolicy/policy_define.c?

https://github.com/SELinuxProject/selinux/blob/63bf6afe5ed20e1d62f966de65882dc327fb2915/checkpolicy/policy_define.c#L3408

>                         free(ft);
>                         free(name);
>                         free(otype);
> --
> 2.23.3
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

