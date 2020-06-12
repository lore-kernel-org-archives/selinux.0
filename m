Return-Path: <SRS0=GKMn=7Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9811C433DF
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 07:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CBB207D8
	for <selinux@archiver.kernel.org>; Fri, 12 Jun 2020 07:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Keld1SlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgFLHvV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:51:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53716 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726491AbgFLHvU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jun 2020 03:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591948278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grI6nWGxdFYR+2gV7YLo+XnBrhioxqL+q5cJAP/VrB0=;
        b=Keld1SlHK9ZYfbg6e1xwwbJHDwfnWMkQMSQsKRGigdoQfk+pFSkrh++URu9ydjLMO90WG9
        t62IHOfrX511M4MrED4xHqCyCOlMKkvRUKP8yHhV20FuSwDHu3XFgPdnpVAe9u4zDgNO4z
        eiv6GlO+h5bH8NWRDKCxF06FxfcKcG4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-QPj-5i-WOdmwXyeA0fTYLA-1; Fri, 12 Jun 2020 03:51:12 -0400
X-MC-Unique: QPj-5i-WOdmwXyeA0fTYLA-1
Received: by mail-lf1-f71.google.com with SMTP id r143so2393716lff.13
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2020 00:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grI6nWGxdFYR+2gV7YLo+XnBrhioxqL+q5cJAP/VrB0=;
        b=GdR4gaUIbNR6pzDEAb3MN+AiIPvdod3aOenQVnjJJx8PgIMbNH2bjvRk9rjPE7odW9
         ejKPktpYOrh9ulNLH+Vf46/QjXc5KDZZ94VGw/i5LenxOgkPSnGSKnxSWS84Pitd2Cep
         VzSvFc1uoAV2JuiEk4mg0uwhfVXn6XJ3YOFdqWqSipiGSSYO2uifLohC7CPU2COL3Esk
         pmUUD8T6bwWHb2/CuMlKQeifcp3jObv7jAwzxSriGfpjtohm5rq3alkR2/Ug/EijaD3J
         mxmOKtYzGIVTMmgub896KLLfontHvX8QPI3Hn+eRIn1yzseCzMpZT2gzmnmIM8ysQiZE
         o9kA==
X-Gm-Message-State: AOAM532A8G0oqrqqYbhbl7pDPSJSW5ziDnfORggK2trosIMbbt2btGa0
        2rD4NjCEgNCyAKJ0UxnnKMexf+fykdPvRc9ECSgEnTwbM6eEoYYo5hJfXSzHeNP+kGXrLy0Ah8s
        Aclsv0SKNdcxAG+IgX24c/oWbxvR8R4i96w==
X-Received: by 2002:a2e:8043:: with SMTP id p3mr5738711ljg.217.1591948270567;
        Fri, 12 Jun 2020 00:51:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/JTMFBvXt7O/Z7+cVdAL/GN/g5rs1TwU0pWF+CTjhP0DJ/WkTYI5gqq+1wX2k1E3Ja6CWJfdhKIJ8JTvzSiA=
X-Received: by 2002:a2e:8043:: with SMTP id p3mr5738696ljg.217.1591948270330;
 Fri, 12 Jun 2020 00:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200611204746.6370-1-trix@redhat.com> <20200611204746.6370-2-trix@redhat.com>
In-Reply-To: <20200611204746.6370-2-trix@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 12 Jun 2020 09:51:00 +0200
Message-ID: <CAFqZXNtPjzh2OPaLkMfV_b=-=uU7Z0887-sWUjSG2YJ8e1ucfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix another double free
To:     Tom Rix <trix@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 11, 2020 at 10:48 PM <trix@redhat.com> wrote:
[...]
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index da94a1b4bfda..d0d6668709f0 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -392,26 +392,21 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
>
>                 rc = next_entry(buf, fp, sizeof(u32) * 2);
>                 if (rc)
> -                       goto err;
> +                       return rc;
>
>                 expr->expr_type = le32_to_cpu(buf[0]);
>                 expr->bool = le32_to_cpu(buf[1]);
>
>                 if (!expr_node_isvalid(p, expr)) {
>                         rc = -EINVAL;
> -                       goto err;
> +                       return rc;
>                 }

Sorry for more nitpicking... This can be further simplified to just
"return -EINVAL;" and the braces can be removed.

>         }
>
>         rc = cond_read_av_list(p, fp, &node->true_list, NULL);
>         if (rc)
> -               goto err;
> +               return rc;
>         rc = cond_read_av_list(p, fp, &node->false_list, &node->true_list);
> -       if (rc)
> -               goto err;
> -       return 0;
> -err:
> -       cond_node_destroy(node);
>         return rc;

Also here you can skip the rc assignment:

return cond_read_av_list(p, fp, &node->false_list, &node->true_list);

>  }
>
> --
> 2.18.1

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

