Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF83C2BA17
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 16:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D730249B0
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 16:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hAbbD7rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgDFQ4S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:56:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35757 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729039AbgDFQ4S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 12:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586192177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ag8+zfbqBmu3eWRyCGueTdurGPsJrW+OFAbT9+jTC4Y=;
        b=hAbbD7rONW6q1X79oU+ZIELdXp4ku2ZpL5FUDr1eQCDFHqggCl/qeKg6XD+Qz7Rcg7LJb4
        BIn6Feco0RjlV+9/f8xHpXGrSWV2DkA0+shQT/m4+k4r3gLEUNKEPERcIn0Vj5LiUroQw5
        mabCgpibV8WUWyNwC3WwToxYvwJIJrc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-wyDIPupRMqidwqIxXIaPfw-1; Mon, 06 Apr 2020 12:56:11 -0400
X-MC-Unique: wyDIPupRMqidwqIxXIaPfw-1
Received: by mail-oi1-f199.google.com with SMTP id m19so403652oie.16
        for <selinux@vger.kernel.org>; Mon, 06 Apr 2020 09:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ag8+zfbqBmu3eWRyCGueTdurGPsJrW+OFAbT9+jTC4Y=;
        b=BDNGBduvwUt4yfjnKrIWgTJbhvc5UChvAbmrBF3Oh6isSizd9DCAxv+b5Ev64P4ng+
         E4jBntGkdinwYO+9Lgt+3QwY8z9r8BUcGBtCUlaPjtkNp360otibnCLLuR3rnayi53GG
         Ql3sj6x3XXwxi+U1/f1W5ad31sGy60ncZ/tlY0/x7exvHVZxfoEq/nc6iPGNU7MfHsCB
         TggVWIbK+AHgC6IKSkVxomDZjEsiU6S01awGx+hK2h00wE/leidFbYj7+q/u9leAJQpv
         I+i48t+kXjmn80KHbWgCWMO9uSyC9y2adhIgh/P9iR19zeBBpndJKBOvsaFdCTQYO3Bw
         l1iA==
X-Gm-Message-State: AGi0PuZ8C3b4AlmSHNKp4rbAUYSgP2gTiAIWagkVSaFisYdj2syOWQcY
        cWiiEBQpRbaLp5+LRnV+R5QVyksvi/2ZtBJgFX330OdgtFXMQlIQf8fmOyUqzoBhU2fuyRIpqlj
        CgCM1FcAyJ677V2tDTP4qEY3oP2qarnaZvQ==
X-Received: by 2002:a54:4f0a:: with SMTP id e10mr158903oiy.127.1586192170680;
        Mon, 06 Apr 2020 09:56:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypIEtDcScA6jnbgGxfBk5wNUMp6ROQzT8lrvGd+KLpfIv0PUSD/QuzWfTjAhNaEB4bZ6/2aKjOmcNXua6Gbpi2U=
X-Received: by 2002:a54:4f0a:: with SMTP id e10mr158886oiy.127.1586192170427;
 Mon, 06 Apr 2020 09:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200406141604.69308-1-rfilo@redhat.com>
In-Reply-To: <20200406141604.69308-1-rfilo@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 6 Apr 2020 18:55:59 +0200
Message-ID: <CAFqZXNvk=UoVRdpk4m4byh-kKU5LUp08C52Nx-MkfcywZ+4rig@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Add missing errno setup
To:     Richard Filo <rfilo@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

On Mon, Apr 6, 2020 at 4:16 PM Richard Filo <rfilo@redhat.com> wrote:
>
> fixes: https://src.fedoraproject.org/tests/selinux/issue/51
>
> Errno is not set to ENOENT when lookup_all() doesn't find any match.

Please put the issue link after the explanation (the link is just
additional information).

Also, you need to add a "Signed-off-by:" line to the end of the commit
message (for legal reasons), see:
https://github.com/SELinuxProject/selinux/blob/master/CONTRIBUTING.md#contributing-code
https://opensource.com/article/18/3/cla-vs-dco-whats-difference

> ---
>  libselinux/src/label_file.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 300625c2..113bb9b7 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -948,6 +948,8 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
>                         goto finish;
>                 }
>         }
> +       if (result && !result[0])

'result' can never be NULL here, so you can drop the first part of the check.

> +               errno = ENOENT;
>
>  finish:
>         free(clean_key);
> --
> 2.25.2
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

