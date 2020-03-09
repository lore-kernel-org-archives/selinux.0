Return-Path: <SRS0=v7Ke=42=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EDDC10F27
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 12:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00B12067C
	for <selinux@archiver.kernel.org>; Mon,  9 Mar 2020 12:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHVRN8b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgCIMFw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:05:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42048 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725942AbgCIMFw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Mar 2020 08:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583755551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/I/mxCyTZ8R7iiMtXcOy3OgpYFXmSqSlnsxJXl9KeLs=;
        b=jHVRN8b0r3X0iiec3sYNt5dSiwOIu1VyODTuCxtJfJa+6LbScR6iyTeTSkpOHr6BclIFR4
        sqklQAdRdEykSQ3jW7kA0mqN5vQQeGRTqQnfsTjqT/+ldYwcqLsp3y6foEozoKHmaHVEDE
        O1tMkDqy6kb77zYAbMZT5ZP2nH77nIA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-ZQR95KrIOAa8qwMGJ91__w-1; Mon, 09 Mar 2020 08:05:49 -0400
X-MC-Unique: ZQR95KrIOAa8qwMGJ91__w-1
Received: by mail-oi1-f200.google.com with SMTP id d131so76533oif.21
        for <selinux@vger.kernel.org>; Mon, 09 Mar 2020 05:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/I/mxCyTZ8R7iiMtXcOy3OgpYFXmSqSlnsxJXl9KeLs=;
        b=VNNO4PStp0gvVrlquaGA0gH44S/hEymjjHFnYDRTS63N+z0ooJR9cNuas7uaPmI4At
         uYegzcm4ZXzCMoiXcuPON0tWsyHi22ToJjpgOsbDAvulH6SUmOsaZL4chgNgo/o2ssON
         +fhzEhLB/df+DRellcx2GsWkyyr5li1jW67mho3SQp4L08PvqUkNbsdCA5Z9RCnBLT1n
         pj6K2KNPk24PMsbFL8Te0w2XSCCDHD10QFAM3ImTZ2Vo4/AiT1DUTsB0fG3fcNs2PFbt
         kRcpeMQGOXpd0XigsRvwKJ1QBhZDpNLxHP1JhBiBvPnhJ45k/U2FwGJLqnVLX/awLYFF
         Fh8Q==
X-Gm-Message-State: ANhLgQ19H0HXJATogwdeL2DLPLm5eUIxEc7xkbnhxie6oIwX+MK+1H+Z
        K/k3vnpIL8vfPsy6+LxPPAqXAYF4XbLuZtfFMPWjHLWh8wYQvyh47HFnwTIL3RasdpVL42ylf9f
        evpI/5tAq1b+FE4qXmVdIlu+HdUebwGX7Lg==
X-Received: by 2002:a9d:19c8:: with SMTP id k66mr1024447otk.43.1583755546852;
        Mon, 09 Mar 2020 05:05:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvMdAgXSk7o8R8ByKjHad4VUR4JYMx3IGCLLEA2jznvbnOMCS1fHyzTeajqCkc7oB/bvx9JPi/F/A+8dax6BfI=
X-Received: by 2002:a9d:19c8:: with SMTP id k66mr1024421otk.43.1583755546481;
 Mon, 09 Mar 2020 05:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200304212831.18292-1-jwcart2@gmail.com>
In-Reply-To: <20200304212831.18292-1-jwcart2@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 9 Mar 2020 13:05:35 +0100
Message-ID: <CAFqZXNsv_rn0XY_0fUu3nh6XUHoW2G4htBVyLTGDtvEDjabqVA@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Do not check flavor when checking for
 duplicate parameters
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 10:28 PM James Carter <jwcart2@gmail.com> wrote:
> A parameter of a macro was only considered to be a duplicate if it
> matched both the name and flavor of another parameter. While it is
> true that CIL is able to differentiate between those two parameters,
> there is no reason to use the same name for two macro parameters and
> it is better to return an error for what is probably an error.
>
> Remove the check of the flavors when checking for duplicate parameters.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_build_ast.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index 307b1ee3..fcecdc4f 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -5304,11 +5304,9 @@ int cil_gen_macro(struct cil_db *db, struct cil_tree_node *parse_current, struct
>                 struct cil_list_item *curr_param;
>                 cil_list_for_each(curr_param, macro->params) {
>                         if (param->str == ((struct cil_param*)curr_param->data)->str) {
> -                               if (param->flavor == ((struct cil_param*)curr_param->data)->flavor) {
> -                                       cil_log(CIL_ERR, "Duplicate parameter\n");
> -                                       cil_destroy_param(param);
> -                                       goto exit;
> -                               }
> +                               cil_log(CIL_ERR, "Duplicate parameter\n");
> +                               cil_destroy_param(param);
> +                               goto exit;
>                         }
>                 }
>
> --
> 2.17.1
>

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

