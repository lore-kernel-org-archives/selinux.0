Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BE6C433FE
	for <selinux@archiver.kernel.org>; Fri, 18 Nov 2022 08:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbiKRIgi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbiKRIf4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Nov 2022 03:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF888EB7D
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 00:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668760464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kFM/ybxvU+L2qPdMDNj9ek0dWiHWkBLap0OD1XuX6pE=;
        b=YtbNQsM2/nHestP4OqKX2ld8V70tELeCHZ6EndhuxCSmNH9OIHgpC8TLz7THysYmdj0fEF
        KPSgMSpnx9sw3u31+85qZJ4m+Ve6pEWsUUrK+LROLj8c0RkHz4D+uYePznADToM4YhEQBs
        k+HhdX3AtsYywousF6MAx6EfJjogLc8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-K5TlC9ssM-eMYz6MpDwCQw-1; Fri, 18 Nov 2022 03:34:22 -0500
X-MC-Unique: K5TlC9ssM-eMYz6MpDwCQw-1
Received: by mail-pg1-f199.google.com with SMTP id s16-20020a632c10000000b0047084b16f23so2764051pgs.7
        for <selinux@vger.kernel.org>; Fri, 18 Nov 2022 00:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFM/ybxvU+L2qPdMDNj9ek0dWiHWkBLap0OD1XuX6pE=;
        b=RVMinqkJhsPORzpr12MkZDE8sNWkuWjanwlQhlOgBCmwaufA+GD+N7bgnJ7PQCBdlm
         9tUouZFjj9Lan4xpcEM8V/ZSSXiNe/eXJYNq1bEdNY7bMG6GKzUEPImZvFdOqkh5CSVm
         wvHwep5sx+pvj1uy8WH0JiDHan6sMM7ThXQn3ab5NHlm7QetQtkCn1Y3nXEK0HYGpgeE
         VsVh6kE9A1yeADfwjEL/PlFh1SE3YAYxexuLzYugtpAYZTks2Lz9cLuRvJpdccdBiY11
         0yRxbpaRiMIHcnwDeyRvxNlboPtoDzU14dECIsD2KX03gCVcpl/Jj+kj/o5WQAga9FzN
         jAcw==
X-Gm-Message-State: ANoB5plIR2ix+NEBZvkb21OoT1bTKbLT3/14ewrbRc7MdlUoen8TKb0z
        o3selDAWr2dpG+sjhWIgR8HKFyJ38qbBYhx+5MFIxIAhJ+gHC4O9DmFT18t8p52tENquB2w5rrt
        qVPkSWfZBcF8mkU214nXVcSJ62gHnKMRu2g==
X-Received: by 2002:aa7:8608:0:b0:52f:db84:81cf with SMTP id p8-20020aa78608000000b0052fdb8481cfmr6938509pfn.26.1668760461559;
        Fri, 18 Nov 2022 00:34:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5brOWlLtVWB3Jdi7A3ZNvjPCqAc+puLJKVJC9E84/HO74oADeU+UoZRTWiIBhx8sKjMLQ6p5KdCCwlchDO0us=
X-Received: by 2002:aa7:8608:0:b0:52f:db84:81cf with SMTP id
 p8-20020aa78608000000b0052fdb8481cfmr6938486pfn.26.1668760461239; Fri, 18 Nov
 2022 00:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20221115194552.338640-1-plautrba@redhat.com>
In-Reply-To: <20221115194552.338640-1-plautrba@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 18 Nov 2022 09:34:08 +0100
Message-ID: <CAFqZXNtb3n5Fiy777KBTFnjgSGkKvvJt=JhNnteO_915esyHdQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] python/sepolicy: Fix sepolicy manpage -w ...
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Petr Lautrbach <lautrbach@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 15, 2022 at 8:49 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> From: Petr Lautrbach <lautrbach@redhat.com>
>
> Commit 7494bb1298b3 ("sepolicy: generate man pages in parallel")
> improved sepolicy performance but broke `sepolicy manpage -w ...` as it
> didn't collect data about domains and roles from ManPage() and so
> HTMLManPages() generated only empty page. This is fixed now, domains
> and roles are being collected and used for HTML pages.
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
> ---
>  python/sepolicy/sepolicy.py         | 13 +++++++++++--
>  python/sepolicy/sepolicy/manpage.py | 12 +++++-------
>  2 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy.py b/python/sepolicy/sepolicy.py
> index 733d40484709..2ca02ee9a0cf 100755
> --- a/python/sepolicy/sepolicy.py
> +++ b/python/sepolicy/sepolicy.py
[...]
> @@ -347,9 +348,17 @@ def manpage(args):
>      else:
>          test_domains = args.domain
>
> +    manpage_domains = set()
> +    manpage_roles = set()
>      p = Pool()
> +    async_results = []
>      for domain in test_domains:
> -        p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web])
> +        async_results.append(p.apply_async(manpage_work, [domain, path, args.root, args.source_files, args.web]))

> +    results = map(lambda x: x.get(), async_results)
> +    for result in results:
> +        manpage_domains.update(set(result[0]))
> +        manpage_roles.update(set(result[1]))

The above four lines can be written a bit more nicely as follows:

for result in async_results:
    domains, roles = result.get()
    manpage_domains.update(domains)
    manpage_roles.update(roles)

Note that set.update() accepts any iterable, it doesn't need to be a set.

> +
>      p.close()
>      p.join()
>
[...]


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

