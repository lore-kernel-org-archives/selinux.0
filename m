Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC48C433DF
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 22:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6E52065F
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 22:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YgMVEkl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE0WMB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 18:12:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53035 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725385AbgE0WMA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 18:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590617519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2cKAJqbv3+TCPbL8CHMwZLEwrwyzusRp8ZKvhIblHS8=;
        b=YgMVEkl0SEwXtENwXdnCW1Nv7OgQFH0AJu2sd2ZeHawWrVMJqxlyMqQSk7XjjAp0R7zQUR
        8uIbQ0lKzm0+LV2iAk1drXeYpO2hpnOnApzKkKVx7OiuJ4Om0qQ1HvtZ/QaesHCHotMyA0
        kuz+lsc8lHjvRkCeN7mHJGAaW9dHtVI=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-bXg0Xh-qP9ConNJ_a_XEqw-1; Wed, 27 May 2020 18:11:58 -0400
X-MC-Unique: bXg0Xh-qP9ConNJ_a_XEqw-1
Received: by mail-pg1-f198.google.com with SMTP id y12so7217504pgi.20
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 15:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2cKAJqbv3+TCPbL8CHMwZLEwrwyzusRp8ZKvhIblHS8=;
        b=aTW8QAi1xMvrvyzyvPuC7MX9nSwaoBUZUBv/X22b1WT3lZZBNDZStl0OoPLMDCL7oM
         /9CTt1TcXhor1J0A3/BzqPFSsBGRiD29WKXJ5Rqoj/oK6JaDq99zpzr/P0a4Tj6ll9RM
         4nLNvP+JMpsi7jJ375kPfLKSb4RjjqKE4NE4hNN7vE1n3MUphJTxfmbTMf6y1gDVbVPA
         B9kfUk2t0aAs8uu+l6Kx8lMO1bkM7Gy0FO2lXf6pZwnBVcEgHQGcXVd6EETtMIU4C4Uq
         lO+lA8EBv3gAoMfHsZ4f+t3X+/S1aUsiuCrQQY8tt3jwuqG6/wTO7ymvCs8ZRf70Sscq
         0vXQ==
X-Gm-Message-State: AOAM532YXYdiS6i2prGv5b1YXo8HbvwuQ0miJZO8ySo53/JXHZ7EynAY
        ESLDfY8fqY9BMN+EQ0DfoTKp/MWyqvklqX0ue4YSyzg20oFTeoHwnz/enGeGfo0TF/OoiAtJPZN
        TQnoMFTeaJlagd7sYq62sO8gRY3suJSyjig==
X-Received: by 2002:a17:902:9681:: with SMTP id n1mr511994plp.152.1590617517054;
        Wed, 27 May 2020 15:11:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHOXintlytpoXhJbEmuFZSAhXp1Oz+6PLzg72zJfASxBAoyv0rIg78gTae/GqsVqX1RloPqE/vmiIZImnY9D0=
X-Received: by 2002:a17:902:9681:: with SMTP id n1mr511979plp.152.1590617516781;
 Wed, 27 May 2020 15:11:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200527220653.188794-1-jlebon@redhat.com>
In-Reply-To: <20200527220653.188794-1-jlebon@redhat.com>
From:   Jonathan Lebon <jlebon@redhat.com>
Date:   Wed, 27 May 2020 18:11:45 -0400
Message-ID: <CACpbjYr0fKbS8MFcHZJhVM11nxxAXefyotOsX9hwC_5kWJrE+g@mail.gmail.com>
Subject: Re: [PATCH] selinux: allow reading labels before policy is loaded
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Apologies, this should have had the subject line:

> [PATCH v3] selinux: allow reading labels before policy is loaded

I missed passing `-v 3` to `git format-patch`.

