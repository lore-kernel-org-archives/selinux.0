Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032D0C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 11:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD09206EB
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 11:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/v6Di+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgCMLx3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:53:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54922 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726708AbgCMLx3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 07:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584100407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VXhzbAM+eC0Ry+JfuHBN4sb7D/JsTls95UH4ewcanOU=;
        b=S/v6Di+VQvTNZBXBNl7NwuqYsLuOBXUygFqXhOPxNqJKxdzXF+L2xJJKP3dPaCFpvTtHyI
        GYdy1BZH34zXmF2DUFi+yHlF5XLvNT+huQqvXiLRejwwW1XatF0YU/ykIhtTc33JNXoEK5
        uYVElTNpXo7DQ/0rFBL76YqfkdUsDLk=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-nPFBKqWWOdmGUXb2sNf40g-1; Fri, 13 Mar 2020 07:53:25 -0400
X-MC-Unique: nPFBKqWWOdmGUXb2sNf40g-1
Received: by mail-ot1-f70.google.com with SMTP id h6so5474692otq.12
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 04:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXhzbAM+eC0Ry+JfuHBN4sb7D/JsTls95UH4ewcanOU=;
        b=Dwo98+0jEOt6nOqZbX5dYfAGGB6hhLBNTiGTzPVvVOcsA47SwSXsLXeHRQOv9bN6hK
         2yTU81a8w3/Fimc3bUv58xir7RIY8K6gMTh22ToCR6M7uX/qRcxg/90OlmMug+4SDY+k
         sVnNVyFSt1xKq4zEyeKOXcOf8v+KSmwvSmRmonizLQEXGzXGvF4aSJSIMXKtG4veA3I5
         Neq9iYozfqQuL/gp7+blfLkRCPfdfHofFd18alIO5SJvKPkIhYlyFGH2GqZlVdHTuIDu
         iTfsiJVWoAbhg8bnGnD71OUwgrzxVD+M1F+fiy2fiU1FGDPjDQMFdI9NDQLCgUqHeoV4
         M+nQ==
X-Gm-Message-State: ANhLgQ1Fdnmn7GxgzEYolItwZRA0F+kpKCsdQ9LCNOgjC2YAHqeRkWfC
        /6lSnvGJKL3aq84g8ifPLEDIjf+Z2GLXRa/L2sRLeFQbk8ffU8JcMq+HUFcXSOofWm+Ws6ftrOP
        XN9nNDpBbXr2OIE7W9X9eCrbZWumBw85wQg==
X-Received: by 2002:aca:488a:: with SMTP id v132mr6622981oia.166.1584100405124;
        Fri, 13 Mar 2020 04:53:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu9bi2q3pj5+yjKQrz8L5Lb8j0p0oFf9dB/zT6qVGu/yan5ig+uCf7Vlz6b0TXuDiBYmsQ6uHdQl8nsydfq3fQ=
X-Received: by 2002:aca:488a:: with SMTP id v132mr6622977oia.166.1584100404939;
 Fri, 13 Mar 2020 04:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com>
In-Reply-To: <20200227160257.340737-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 13 Mar 2020 12:53:13 +0100
Message-ID: <CAFqZXNvR6BKuk4Y3DAPUpy5kWkEJ409W1vysrQ5kxh5OsB14UQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 5:02 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This series contains two small changes (these don't seem to affect
> performance measurably, but are nonetheless logical) and a patch that
> changes how the policy optimization "type_map" helper structure is
> represented, which speeds up the whole process.
>
> Ondrej Mosnacek (3):
>   libsepol: skip unnecessary check in build_type_map()
>   libsepol: optimize inner loop in build_type_map()
>   libsepol: speed up policy optimization
>
>  libsepol/src/optimize.c | 119 +++++++++++++++++++++++++++++++---------
>  1 file changed, 94 insertions(+), 25 deletions(-)
>
> --
> 2.24.1

I can see this series marked as "Changes Requested" in patchwork - is
there anything requested other than a test for policy optimization?
After 692716fc5fd5 ("libsepol/cil: raise default attrs_expand_size to
2") the second no longer leads to a different output (with expand size
>=2).

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

