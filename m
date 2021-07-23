Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031AAC4338F
	for <selinux@archiver.kernel.org>; Fri, 23 Jul 2021 15:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFC4560EB5
	for <selinux@archiver.kernel.org>; Fri, 23 Jul 2021 15:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbhGWPCa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28556 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235558AbhGWPC3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 23 Jul 2021 11:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627054983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=tLA1zgeMtCNR7SzAiaWjVWguwCwlhmHg0/5q4o/+zjo=;
        b=czO92rSLrB7fY77swEA1nRVxDo9fBl/7gRx+PKt+ujixu9aQI2MblS+J5xJu23Wi+ccoOS
        nPcUqMxQqLiJ0PX0Tt6BfOXetyw+Y++YCxzrfss5Y4RtBBKUu/7zWl3NxlPe3FSNczyyRr
        XrIJY8pZFX4urP3d4ruIC6bqLIXnzmo=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-_m4SP965NwOcSQlZwI4t_g-1; Fri, 23 Jul 2021 11:43:01 -0400
X-MC-Unique: _m4SP965NwOcSQlZwI4t_g-1
Received: by mail-yb1-f200.google.com with SMTP id w200-20020a25c7d10000b02905585436b530so2400023ybe.21
        for <selinux@vger.kernel.org>; Fri, 23 Jul 2021 08:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tLA1zgeMtCNR7SzAiaWjVWguwCwlhmHg0/5q4o/+zjo=;
        b=sOUSGksQ15nS54EjjmZ7cY7Sei3q84EamDyiwl8wcThYVw2gCZANCGc6dS61JxJWMr
         6CD03PMif6GTgRw9nz1rzeiNcE90druMfTTbDEtmeyn+Sg0Tbvi1McXqijMyS+iji4NP
         jArmAQQyIs5MbpwFrJP34my3NaNHtfiZJdQ4UVpsOTNs3SIYGyszJadX+4BDbo0Ax872
         Vbt+dfkjRWxKhlD7jx0EMsZEx6bWV2GYd7PAc2/v+vBwGu7r4TsYzuTSyV3N43CJcWXT
         LbSFz0hF/QxXYUyamkhOKZ1D+er5ezdLmx6UBw+rkoDFJia5+l/qQU5uDzOlBcDkHYil
         oSQA==
X-Gm-Message-State: AOAM532fiisFOB1yAfzLt6htbtOs5G+869h2wqmQHu4ky6FpLWQdg8pS
        tNIaF96ZbL7MH81kvJVZX7UBEWBAXxp4SjbJfs+YVjF+kJye00g3/2wJ+/Vu5rXDxH8o5tb9eor
        aPs102CIQQIUiczCIctpZwLxBy3G2nQO01w==
X-Received: by 2002:a25:c709:: with SMTP id w9mr6927165ybe.456.1627054980903;
        Fri, 23 Jul 2021 08:43:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFzxI/yuSZqz5EGAgRyy6mNUBQ0ErnrqcLgM9ybdHKQob2POEnibZpy5dNxqKbeu2D2CHhe6Khx7to70RgJlg=
X-Received: by 2002:a25:c709:: with SMTP id w9mr6927141ybe.456.1627054980753;
 Fri, 23 Jul 2021 08:43:00 -0700 (PDT)
MIME-Version: 1.0
From:   Garrett Tucker <gtucker@redhat.com>
Date:   Fri, 23 Jul 2021 11:42:50 -0400
Message-ID: <CAEN2sdo3wVKXnEUASFTbhR81kOYNgU1CbR0XMUNCTt8keOHC6A@mail.gmail.com>
Subject: libsepol CVE patch issue
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi everyone, I'm a product security engineer at Red Hat and we noticed
that libsepol CVE-2021-36087 was assigned, and marked as resolved
within the OSS-Fuzz project. The patch info provided for the CVE
appears to be wrong, and after looking into the provided commits and
commit ranges, these seem to be the wrong commits and commit ranges
for this CVE.

Would anyone be able to confirm if there is a fix for this CVE, and if
so, point us towards the correct patch for this.

All the best,

Garrett

