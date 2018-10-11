Return-Path: <SRS0=mQjY=MX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB259C28CF8
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 23:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C94F2085B
	for <selinux@archiver.kernel.org>; Thu, 11 Oct 2018 23:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="thW9xkYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C94F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeJLH1u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:27:50 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33144 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeJLH1u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Oct 2018 03:27:50 -0400
Received: by mail-oi1-f195.google.com with SMTP id a203-v6so8550318oib.0
        for <selinux@vger.kernel.org>; Thu, 11 Oct 2018 16:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5PhSYPw3+xavB4aF3JyXWuS6HQhbEZw0QwGIO3KTSio=;
        b=thW9xkYlaDnZq9E+VPkrK48lLR1XvbVQXAD/oF6n+denK30q6dlLwt3R0o09/pt6uM
         KpoArsPzRWQAGapuPmddv2P+nscw5Y3fbNaCAKOQm8nmHv9zci1H8FW2ZrlYCKZMiqU5
         NXlbdh71j7z5QIxDzbosWHSIqw7816DlUp0XzFEvVAhjA1h4HD40pgQjlhdRCGHm+a4q
         Ndvsaxp4ArvRv89JUPqL4tIc/gZcaqU1xSaJGAO2SajEWNsa67Eq0D5ryW28AE9Jax3j
         MGi5v30D72CkmWf5esxXf+G79DGRh4b6QgulQzIFyyaRLXmm1U7zFjaHRlxIonv0mKPY
         Xbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5PhSYPw3+xavB4aF3JyXWuS6HQhbEZw0QwGIO3KTSio=;
        b=HgDBXDmjL+kytqlx96fqId7K5ekk3mmudKei/p/xEdJkKC5ED5OCwKpfxwzTf5urb6
         jkHr6e97m7RjSIw3hQKPSGoQ3W2qASV+ez20LEe6mYiZNMoE8PG9NyRq7X6HuKRxCWZc
         60RVoGgrbibjhu3ylhp9P/JZOOVXsQ7TEvTmZPWNVPSx5Fy6mgc5k0DusCzlt0r1wZ4n
         d3kKqRfdGoxfraJToSbCNE/xN6lbjk23zbWChaXYmuG4Mm/S7auiJezR5/KhUNq+DezG
         gGZmGfWhhOoMVRc18/mTarueaiX+cZSQqx6gBtE9ziV3XhvZSQHqABIhXgvGwge0dwRB
         5MLQ==
X-Gm-Message-State: ABuFfojsQKsEjGdJQSAwQG6ApBuvkaT2X1Hhie4i5rpbCx90gJtWIUrD
        uHRQKuTkWuaUWoORHFCCiC7frqN1KHVz9Wcum2MG1/q4
X-Google-Smtp-Source: ACcGV63IYNwwKxzmRhKRd4z38izd7WejaYQuIhs31nwPIwuEAwpMHEYc3MOaP5X7xMM7ZNwSwBPNaaiR+EG7LKQSKlg=
X-Received: by 2002:aca:59c4:: with SMTP id n187-v6mr1955811oib.279.1539302292908;
 Thu, 11 Oct 2018 16:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
In-Reply-To: <20181011123549.14875-1-jwcart2@tycho.nsa.gov>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 11 Oct 2018 16:58:01 -0700
Message-ID: <CAFftDdrGknwW3fJCU0+BptuS69qLcuKj+5gTchgkqJapTwjCTw@mail.gmail.com>
Subject: Re: [PATCH 0/4] libsepol: Cleanup initial sid handling when writing
 CIL and policy.conf files
To:     James Carter <jwcart2@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 11, 2018 at 5:37 AM James Carter <jwcart2@tycho.nsa.gov> wrote:
>
> [Resending because I originally only sent these to the new list]
>
> - Removes some redundent definitions of initial sid name strings
> - Adds range checking when looking up an initial sid name string for an index
> - Adds two new Xen initial sids
>
> James Carter (4):
>   libsepol: Rename kernel_to_common.c stack functions
>   libsepol: Eliminate initial sid string definitions in module_to_cil.c
>   libsepol: Check that initial sid indexes are within the valid range
>   libsepol: Add two new Xen initial SIDs
>
>  libsepol/src/kernel_to_cil.c    | 78 +++++++++++++++++++++------------
>  libsepol/src/kernel_to_common.c | 10 ++---
>  libsepol/src/kernel_to_common.h | 16 ++++---
>  libsepol/src/kernel_to_conf.c   | 78 +++++++++++++++++++++------------
>  libsepol/src/module_to_cil.c    | 78 +++++++++------------------------
>  5 files changed, 136 insertions(+), 124 deletions(-)

LGTM. I ran these locally and they seemed to be OK and I was able
to list the new SIDs from the policy db.

I staged them here to have travis run the CI as well:
https://github.com/SELinuxProject/selinux/pull/104

>
> --
> 2.17.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
