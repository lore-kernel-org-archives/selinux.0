Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58532C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 13:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321372074B
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 13:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S70LzJy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGINct (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgGINct (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 09:32:49 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D3EC08C5CE
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 06:32:49 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w17so1872054oie.6
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2wkDupfaZ3WMUyXw1FQN1ZsnNNQPxW4HtT9weQWW90=;
        b=S70LzJy4hEfyw4vhM5xGCNdqFoJoV3WB2l6x1OUC47tQP/JDIzbU7NfNQ7SdEbuudx
         /qcIVJbHIN62quDS8xYB8K3UNjILPT5dPYeIyfior/LC7bGAAdJS3AcUVNI+iykHjUQM
         SyAyhgV2ALSUgzOp1hCF2UQW1S2I9rzNBEGT1uRc3AUR+BT/pdPFk0SqNVWsxCJHVfDq
         MZE9iCgHdvy737FmXIJ14ErrEYBh+/zeXDwk46FgTiCa1y1clUCcyxUlx9IE+WwnN6mw
         FTYquIN8CMie1wJOxeJl9siq66a6IaWhi1nkxW9YTPzh7xRwbhmoQ8L7bQUtoSHibN96
         WMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2wkDupfaZ3WMUyXw1FQN1ZsnNNQPxW4HtT9weQWW90=;
        b=rJTHBiOsxwTVqKy8cEHrKtIP9IYDtf2Tivu1SAYpk32np5WCHt8/9RxR1HdmWyWfl8
         MgJqMXUr36q4Y4WsbwZnGZRGGUvJYMcHtFLBTdFxxdnoUrHus1Q4CnfTy+4BywFJst/i
         uV0o9DTDucsKeX4qEoFyQqOCp8Y8Zp3AAbiGRbi0H6GpWVQQYopLAPqMOP7aX2wufh5o
         t1bdVkhP1tBIH0ONHpLD6SrCe05jIxLV9ryPhHTtayaflP7cDGR63XbBqSg5AXG3bw+V
         c0dKN1W1RMKZyn4n7ixiKR2/cC8Ws7dR0LGVpFand/uRNWFsaaHU+qibZTOS06JWvluT
         h9LQ==
X-Gm-Message-State: AOAM530XXkma7rLPZaYLap/z7Ivj2IaI2zs24Jr3dgFgesZH6zz2LmIW
        IWc1CCFBwcz67jIyY4fgqyujgZJZ50g+qUb5VD19uDmW
X-Google-Smtp-Source: ABdhPJxyIzWkbAuSpKIGusObaJYYZj54cGNYxJa/I4UJ6rGItvvvPGu2zKSdJbmZYGm9Aw1pu5Tvp1CYXZb9G0TATWY=
X-Received: by 2002:aca:2807:: with SMTP id 7mr18036oix.140.1594301568665;
 Thu, 09 Jul 2020 06:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200709094509.1620563-1-plautrba@redhat.com>
In-Reply-To: <20200709094509.1620563-1-plautrba@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 9 Jul 2020 09:32:37 -0400
Message-ID: <CAEjxPJ5LWD-5gLELvkopjj4wopmpJs2PkkfEWBeWj0cHfx97tw@mail.gmail.com>
Subject: Re: 3.1 release notes draft
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 9, 2020 at 5:46 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
>
> I'd like to release 3.1 today/tommorow to open the development of other
> performance related improvemenets which which postponed. This is release notes
> draft which is based on RELEASE-20200518.txt and RELEASE-20200619.txt:
>
> RELEASE 202007XX (3.1)
>
> User-visible changes:
>
> * selinux/flask.h and selinux/av_permissions.h were removed

Also sepol/policydb/flask.h although hopefully there were no external
users of it.

> * `security_compute_user()` was deprecated - usage of /sys/fs/selinux/user { security:compute_user } might be revisited

Not sure what the last part "might be revisited" means; we have
removed all uses of it internal to libselinux and deprecated the
interface, with the intent of someday dropping it altogether and
removing the kernel interface.

One other user-visible change is commit
8677ce5e8f592950ae6f14cea1b68a20ddc1ac25 ("libsepol,checkpolicy:
support omitting unused initial sid contexts") which allows policies
to start omitting unused initial SID contexts going forward, as per
its description and
https://github.com/SELinuxProject/selinux-kernel/issues/12.
