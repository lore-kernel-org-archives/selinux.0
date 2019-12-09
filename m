Return-Path: <SRS0=wrJH=Z7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D09C43603
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 23:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC379206D5
	for <selinux@archiver.kernel.org>; Mon,  9 Dec 2019 23:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="n1G5Dnqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfLIXtH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:49:07 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43043 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLIXtH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Dec 2019 18:49:07 -0500
Received: by mail-lf1-f66.google.com with SMTP id 9so12147552lfq.10
        for <selinux@vger.kernel.org>; Mon, 09 Dec 2019 15:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjQVXgXQc5aSCVlgBrUQlpOSIuqtaBl2i2S/dCVoUpg=;
        b=n1G5DnqdDWQHvjRBNd8jQ4tu4cdfjUp9oSjZ2ixYhB33WFrbRHARdBF3nKD6iBoyFI
         M1OnRibZb/jfJw5lpR4DaJoYlLX3NoUPSrPIPZs5npkYbnr85TAxzsCm/cnvwhIP3e6/
         Lh8aDVcOXaDJF7CzYFIb6fYczUnlaGe0Y79rBJ9oLv6NnF0pe3mVRSSK4ohbGp69N4Qs
         RVPEYa51jM5dE0tr/GgMpcb8HbuYtV6vFzgksOayiEGc9o+w5qfJkEaiyPZHaEQJOm7w
         uYAfjfFQgFYigHPj00vuYSuUXuklKlRdoWn+2wBT6qQv8W4XPEP7vxGmbSLhLjPGOWGb
         JmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjQVXgXQc5aSCVlgBrUQlpOSIuqtaBl2i2S/dCVoUpg=;
        b=nCOecoBbpJlQO+pQRrK6ygbT1keMtedDbxdQViZxdmsny2wRuYgwm+Ux5FaD/434LB
         AYiXvGSvRfvOla47niCMhoJnhWT7BPeNBF2mIMe3zFzMKLOP1M7pwcqZlWNeIkWqkDuT
         0xAYvFq68PAND9WvY2w3AuaMkUKYEtOCBpTHSoG1OJEs1g2jb1ACBzt3uYqimIVuPftr
         sM/s+fLfLmb7vxZtmEkJ08DCHjkni3Elha1yk2FJYxRJ7Nzf15EEKbVQJTfPrZxfZeSA
         QqgoMCttq1VTFML4Z8gwQxA23tAN1vrY819Sql5XKivJPF0N1qfqC3zd+sxsyYxeKU+F
         grnQ==
X-Gm-Message-State: APjAAAXU1kaqQdQkLQazqJ6/7iqO64cKKF9Vu4KiXsV65VIBWrOrzDkF
        u0//gvk3fdmKPMThmj0Yd11l5B8r/vjxE6FBkZaC
X-Google-Smtp-Source: APXvYqw8JvNjrklJuf+Hl9hGv31Wh49QUKlskfT0I7iESTWeA6DsTlAVBUGV2ez9UQRQoVmI0TNQPYiyoN/DYPHu5FU=
X-Received: by 2002:a19:f514:: with SMTP id j20mr15643397lfb.31.1575935345046;
 Mon, 09 Dec 2019 15:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20191122211656.3647-1-sds@tycho.nsa.gov>
In-Reply-To: <20191122211656.3647-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Dec 2019 18:48:53 -0500
Message-ID: <CAHC9VhT9oiJg1odtb0J1XkMMOqo7yxsMeGS1avHeE3kFX=35rQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: clean up selinux_inode_permission MAY_NOT_BLOCK tests
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 22, 2019 at 4:17 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Through a somewhat convoluted series of changes, we have ended up
> with multiple unnecessary occurrences of (flags & MAY_NOT_BLOCK)
> tests in selinux_inode_permission().  Clean it up and simplify.
> No functional change.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> This patch is relative to the two patches I posted earlier today for
> MAY_NOT_BLOCK / ref-walk handling.  Just a cleanup of something I
> noticed while doing those two.
>
>  security/selinux/hooks.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged, thanks.

-- 
paul moore
www.paul-moore.com
