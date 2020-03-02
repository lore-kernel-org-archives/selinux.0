Return-Path: <SRS0=NbdY=4T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E13DC3F2D1
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 20:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF855214DB
	for <selinux@archiver.kernel.org>; Mon,  2 Mar 2020 20:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzFqinXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgCBUK2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:10:28 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38594 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBUK2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Mar 2020 15:10:28 -0500
Received: by mail-oi1-f196.google.com with SMTP id 2so543157oiz.5
        for <selinux@vger.kernel.org>; Mon, 02 Mar 2020 12:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XIKwgR6O4bjyTSzsoFBCLOGhxdwbPWV8NH9PQ1SrJo=;
        b=rzFqinXundYUQAySDjnKshiLtZHAl5W3+wDFX8Qedt46PCdbZKz4ZwxjO73QauRLKv
         jksNZ0UEATK5BNOo2pjPdaHj6C/JHmQUpRYHwD1wXBPKklb23264AEoomPagglyGb9lE
         v6DW3uuYdx7j05lvRFfY8NQsgSdtKS4ah9wF7R5xlxErQAhwR9F+DMbiF7a4km7sIan9
         YUABdEjW9H+k74TxvuyxAt0C8DuI1f5V9NgaJoYDbP16TlnZDSCW1Una+CgCXfF1JGp7
         3gk0g/SNdu51CaEzoB92vfsNKE1HhNlZrN1C0aTKmNCc/3VyLYwdMHnasfNRzOOMnaMR
         rWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XIKwgR6O4bjyTSzsoFBCLOGhxdwbPWV8NH9PQ1SrJo=;
        b=udq68DJNWEYJfuObQiJ03zcgL2uuHVqgYxYe+HUsMOzst+jol61pxjePmTBLyyF92I
         jFmSXNoIq2CI0EI1P2AUyhKm1X+f4pWkdQWUTXjypNoKN9618Q03d/KC8PKeaDWilVZn
         NkxdE3yPhrND/cVSn9zxFgpmwUUPai5rgY5OqP62qwaUM9CwUDmy9u857W6f4pvq3Evr
         u8FJ2h8GuJavW4fGhL9oH0baENUI8CLa3CB6Lt+NHvgPE31h92SCt+GFk9SlIyhL7Q2x
         yevqzB15BIvYr7qTNh8V7LLAfHFJbsAQReaf4qZ9vLHnyXywxdtMND4BjJg3u3uO+HwR
         Gedw==
X-Gm-Message-State: ANhLgQ2Zhd1hG6nB9rtS9LMPdejn0ZcwWpbNtM4E20kjuV0ie6R5NtE7
        S4hhX0Ul9EJvnGKLojljLgH4BSs/C831HC65Clg=
X-Google-Smtp-Source: ADFU+vvGVlBcbK8jyexGxrL6ufNIPwnJY2c6IaeUX0oFzVAIc5KbtaTgwjQ8lkXePC1MJ1Nopkp4nja8Qh7eXE8ODJI=
X-Received: by 2002:a54:4086:: with SMTP id i6mr95663oii.65.1583179826084;
 Mon, 02 Mar 2020 12:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
 <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
 <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com> <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com>
In-Reply-To: <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 2 Mar 2020 15:12:13 -0500
Message-ID: <CAEjxPJ4yBFQ7S46wY5S33dheP-t8T9Xf8EHEUR5E3beWXjBH3A@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 2, 2020 at 10:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Yeah, there is currently no test for this. I have something hackish
> that I used locally - I'll try to convert it to something more usable
> an automated and integrate it into the repo.

FWIW, my "test" in this case was to generate unoptimized and optimized
policies before and after the patches,
and use cmp as a first level check on whether the kernel policy was
completely unchanged by the patches, and then when
cmp failed on the old and new optimized policies, I used checkpolicy
-M -F -o policy.conf -b policy.32 to decompile each of the
optimized policies to policy.conf sources, and then I diff'd the two
policy.conf files to see if/where they actually differed.
(normally I'd use sediff for this kind of thing but in this case we
want to see non-semantic differences between the policies wrt
optimization, not just semantic differences, and also sediff took too
much time and memory on Fedora policies until recent changes
by James that I don't think have made their way into an official release yet.)
