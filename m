Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5798C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 20:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82ABF20727
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 20:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=edgekeep-com.20150623.gappssmtp.com header.i=@edgekeep-com.20150623.gappssmtp.com header.b="HKyNhn2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEOUCL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 16:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbgEOUCK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 16:02:10 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB347C061A0C
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 13:02:10 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p12so3031112qtn.13
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgekeep-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=eZgwmnt/E5RolyA2AALIJQMMLuxrxkqm5Zjd3RX9a/Y=;
        b=HKyNhn2dik6fL1KoXvy8oXDzTBO0pzSLq/XPYxKeQANXY7Pg4XMJOSZ2ju8Qjuqam1
         GdAlAYXyYDlhKsPc1oCz9v4Mv9QgfmKwEJ9x7FB08wy0Ty3N/rmji424UyTGvG2PIe+G
         tHraEl8IsIL/XZaR7R7qIsCMygaDduI0IIsySUlLgx8AV+NXhZCpGEtehn7u/JAH/BM4
         HysfctwzB8uwhBJ6WVmlxQJQbTX5c9DP36RoB2Tn3K9Emqhb2KV2zWTUsfXb8icmOkEH
         991PQbMTi2TfpVGhDQABinUAuZB2/TFA4/qgyyopM1ji95pq0UMgkldygZUHYpPf9Hxg
         gyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eZgwmnt/E5RolyA2AALIJQMMLuxrxkqm5Zjd3RX9a/Y=;
        b=HxpnwHXKBAgcazoDEPJ1oyrok5Qmm7PfSmSwxGzF39Mrww24qvOdOPQtgMTkmSQbS+
         NbUQZ4fF5ie5wUxJz/vtepBWPz2XQFz7SQu9Sb2rys96+4p6iEieCa2Iif4Hhwzat4Y7
         /yJdjXk7RWg4bjNZSlPkBKq/LqjwV0/dW2/YNB9OUwB4b5liTg/J+nE38k7SdxLs98wx
         Itmr4zAwm8GRMnoG0uYw0FJVjG4RqP+JgN26eno4eHABbVouWqDhsMbwRR/lt57axbCm
         qnHBfAN+P8PUjJJ16qt8CIpnMLnhQVSZp0HT9/NhD8J7YfqxB4XyEBKMGomnProMCWOq
         Grbw==
X-Gm-Message-State: AOAM533l/FqlulkEv96VWyK1hh6dDZtCXiWQq+qr72KvnSebvUSljO0q
        ObBwvFWTQeU2pmKnYNrXG9kn/PC9A9nHNn5s3OQWdRCytOY=
X-Google-Smtp-Source: ABdhPJxdS2/1J8o9g9nBF/oqsG8PqOrTJzDhwLMmGy+ppQsOEgzaUhtL+qJecz25WucYQFzbK0XqMtMOvVMtJJm/FNo=
X-Received: by 2002:ac8:2c28:: with SMTP id d37mr5398844qta.68.1589572929694;
 Fri, 15 May 2020 13:02:09 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Whittaker <pww@edgekeep.com>
Date:   Fri, 15 May 2020 16:03:17 -0400
Message-ID: <CAGeouKH0MWHVmo-dFxzn4LViwGNLUoYnYYm6HrKzL5XgfMhd4w@mail.gmail.com>
Subject: Bad context in PostgreSQL page on SELinux Project wiki?
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Folks, with whom I can verify whether there are errors on the SELinux
Project Wiki?

Details: It looks like MCS information is missing from a few security
contexts on https://selinuxproject.org/page/NB_SQL_9.3

The schema row has

   security_label = 'unconfined_u:object_r:sepgsql_schema_t:s10'

which should likely be

   security_label = 'unconfined_u:object_r:sepgsql_schema_t:s0:c10'

Likewise, the database row has

    context = 'unconfined_u:object_r:postgresql_db_t:s0'

but I'm unsure whether this should be as is or whether it should also
have MCS info.

With whom can I verify this? (Not using PostgreSQL, just noticing
errors as I crawl through my hardcopy of the handbook.)

Thanks!

P

Peter Whittaker
EdgeKeep Inc.
www.edgekeep.com
+1 613 864 5337
+1 613 864 KEEP
