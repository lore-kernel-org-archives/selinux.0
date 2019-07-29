Return-Path: <SRS0=UHz+=V2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C19C433FF
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 21:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2292067D
	for <selinux@archiver.kernel.org>; Mon, 29 Jul 2019 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfG2VlV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:41:21 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48775 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfG2VlV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Jul 2019 17:41:21 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EE4455605E4
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 23:41:18 +0200 (CEST)
Received: by mail-ot1-f42.google.com with SMTP id b7so13957558otl.11
        for <selinux@vger.kernel.org>; Mon, 29 Jul 2019 14:41:18 -0700 (PDT)
X-Gm-Message-State: APjAAAWd0YtpLjgMBgoi5KqcRX55UEV/7eEP/U/gnX2VRgPY+93YbLO3
        xkHhEM7eTKtAV9jOnYOV3GYr7o2TjmbfPQpuxEw=
X-Google-Smtp-Source: APXvYqxWJS7KjgzHaf0Z0WSRaAqqRs0GOnz3p+X1Tonfl4n1LjKRSb6nkax84qPEGv2XnVDHQn1u9z1U2478KAMVsPM=
X-Received: by 2002:a05:6830:12d5:: with SMTP id a21mr15700209otq.29.1564436477981;
 Mon, 29 Jul 2019 14:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190702120905.9808-1-vmojzis@redhat.com> <20190702120905.9808-2-vmojzis@redhat.com>
In-Reply-To: <20190702120905.9808-2-vmojzis@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 29 Jul 2019 23:41:06 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nZ3mVRFD6d5OGq+r1srH+8bRr-hKeLi3kpc_bx3W5yTw@mail.gmail.com>
Message-ID: <CAJfZ7=nZ3mVRFD6d5OGq+r1srH+8bRr-hKeLi3kpc_bx3W5yTw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Fix mcstrans secolor examples
To:     Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Jul 29 23:41:19 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 2, 2019 at 2:09 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> According to "check_dominance" function:
> Range defined as "s15:c0.c1023" does not dominate any other range than
>  "s15:c0.c1023" (does not dominate "s15", "s15:c0.c200", etc.).
> While range defined as "s15-s15:c0.c1023" dominates all of the above.
>
> This is either a bug, or "s15:c0.c1023" should not be used in the
> examples.

Hello,
I am not familiar with the concepts about range dominance, so I do not
know whether this is a bug that should be fixed or if updating the
examples is better. Can someone please review this?

Cheers,
Nicolas

> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  libselinux/man/man5/secolor.conf.5                      | 4 ++--
>  libselinux/man/ru/man5/secolor.conf.5                   | 4 ++--
>  mcstrans/share/examples/urcsts-via-include/secolor.conf | 2 +-
>  mcstrans/share/examples/urcsts/secolor.conf             | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/man/man5/secolor.conf.5 b/libselinux/man/man5/secolor.conf.5
> index b834577a..a3bf2da1 100644
> --- a/libselinux/man/man5/secolor.conf.5
> +++ b/libselinux/man/man5/secolor.conf.5
> @@ -123,7 +123,7 @@ range s7\-s7:c0.c1023 = black red
>  .br
>  range s9\-s9:c0.c1023 = black orange
>  .br
> -range s15:c0.c1023   = black yellow
> +range s15\-s15:c0.c1023   = black yellow
>  .RE
>
>  .sp
> @@ -165,7 +165,7 @@ type xguest_t     = black green
>  .br
>  user sysadm_u     = white black
>  .br
> -range s0:c0.c1023 = black white
> +range s0-s0:c0.c1023 = black white
>  .br
>  user *            = black white
>  .br
> diff --git a/libselinux/man/ru/man5/secolor.conf.5 b/libselinux/man/ru/man5/secolor.conf.5
> index 4c1236ae..bcae80c1 100644
> --- a/libselinux/man/ru/man5/secolor.conf.5
> +++ b/libselinux/man/ru/man5/secolor.conf.5
> @@ -121,7 +121,7 @@ range s7\-s7:c0.c1023 = black red
>  .br
>  range s9\-s9:c0.c1023 = black orange
>  .br
> -range s15:c0.c1023   = black yellow
> +range s15\-s15:c0.c1023   = black yellow
>  .RE
>
>  .sp
> @@ -163,7 +163,7 @@ type xguest_t     = black green
>  .br
>  user sysadm_u     = white black
>  .br
> -range s0:c0.c1023 = black white
> +range s0\-s0:c0.c1023 = black white
>  .br
>  user *            = black white
>  .br
> diff --git a/mcstrans/share/examples/urcsts-via-include/secolor.conf b/mcstrans/share/examples/urcsts-via-include/secolor.conf
> index d35b3c67..3b3f5430 100644
> --- a/mcstrans/share/examples/urcsts-via-include/secolor.conf
> +++ b/mcstrans/share/examples/urcsts-via-include/secolor.conf
> @@ -17,5 +17,5 @@ range s3-s3:c0.c1023 = black tan
>  range s5-s5:c0.c1023 = white blue
>  range s7-s7:c0.c1023 = black red
>  range s9-s9:c0.c1023 = black orange
> -range s15:c0.c1023 = black yellow
> +range s15-s15:c0.c1023 = black yellow
>
> diff --git a/mcstrans/share/examples/urcsts/secolor.conf b/mcstrans/share/examples/urcsts/secolor.conf
> index d35b3c67..3b3f5430 100644
> --- a/mcstrans/share/examples/urcsts/secolor.conf
> +++ b/mcstrans/share/examples/urcsts/secolor.conf
> @@ -17,5 +17,5 @@ range s3-s3:c0.c1023 = black tan
>  range s5-s5:c0.c1023 = white blue
>  range s7-s7:c0.c1023 = black red
>  range s9-s9:c0.c1023 = black orange
> -range s15:c0.c1023 = black yellow
> +range s15-s15:c0.c1023 = black yellow
>
> --
> 2.17.2
>

