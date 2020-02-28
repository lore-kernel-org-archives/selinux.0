Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E26C3F2D2
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 18:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C545246A0
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 18:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TstZP91u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgB1SHg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:07:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40613 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB1SHg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 13:07:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id a36so3409576otb.7
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 10:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3c67KyinWy2WDqzoIZnAGt7bmcIdmTzij9euLf354OE=;
        b=TstZP91u5q87QvGELiAqZ/ZTs9UrUH4totzswnn6L4y5P7QtAYYOtDWoNNE3hCxoKn
         l4ucnEluH0Lr8+WHKIaHIdcMiUG3gPbI8y67KdqG0uPbvzoKa7tIF1RYDyqOLLfEqRSG
         9bsH7a8bKAlgNZ/s2+dftNggkTSBS6AYJ9XjN+ci3bQmecLXkERgREglqMiZORtGaPd6
         oGdrWzfxYk3NXBJMf543IYV6qPtxN+2/VK1qwzH3SuQNmAGLEtCrucyFUQTYEMUV2UOT
         YXlz/55YPWFLFTVFUryXbdUGVSGGdB8B/6HCsBgI0fhEtKW3Z5+uEYwUY/rPQuVAfGkl
         ng1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3c67KyinWy2WDqzoIZnAGt7bmcIdmTzij9euLf354OE=;
        b=cmfqPAFDpouD9njW3x18Iq0DNW0bIlEH9hJKCfWD3J7L20S6onuFmU3sCHPRrDpymJ
         yejR8XQuxnyiiW/QkceM9XAClRJuubeuNl7PtlvorhCRDGL/XVZLLcSnFf0JKsU3RA5T
         UQSZLnVp+a+27dX9p2m8boN/I0bTvu8CzuAx9uZfS8hKM1zMRckSw35oIGgTK3q+//+M
         VGgf17W/gfXJcLzZ75jOGEL+v29+AN/bSo34r/8qGxvJ+pAu68sLyI5IoVSMnVeI6I14
         YvDHGpZb0eGfGhwIQE9u0m2rS2DycnZajOR2+GC/R+Cs+bgpLfA+AX13oQw9Y0n2GKzr
         9F9g==
X-Gm-Message-State: APjAAAWiQqxzheA0iFTnlQCW8j7cP58+vJGOSoCl67OPVK1Z8oIXR7yI
        uzTXPXbiOfkw+SFQc5CehE6lBB5ie4ixbOcl/Mo=
X-Google-Smtp-Source: APXvYqyisewZAFZkTn7sDd/aXXFHr0XW9oUs5DzAUUjob4GNi9Qw62LDDb2l7oNw3a9Df8ORCLbKbPiWqbDe2o3XGZ8=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr4056817otk.89.1582913255730;
 Fri, 28 Feb 2020 10:07:35 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com>
In-Reply-To: <20200227160257.340737-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 28 Feb 2020 13:08:53 -0500
Message-ID: <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>, jwcart2@gmail.com
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This series contains two small changes (these don't seem to affect
> performance measurably, but are nonetheless logical) and a patch that
> changes how the policy optimization "type_map" helper structure is
> represented, which speeds up the whole process.
>
> Ondrej Mosnacek (3):
>   libsepol: skip unnecessary check in build_type_map()
>   libsepol: optimize inner loop in build_type_map()
>   libsepol: speed up policy optimization

Not a comment on the patches themselves, but this made me wonder if
the optimization support is actually tested by our travis
configuration.
Doesn't appear to be (e.g. no usage of -O/--optimize or semanage.conf
with optimize-policy true).
