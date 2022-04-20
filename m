Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D58EC433EF
	for <selinux@archiver.kernel.org>; Wed, 20 Apr 2022 19:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347457AbiDTTEg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Apr 2022 15:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240130AbiDTTEg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Apr 2022 15:04:36 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97842BE5
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 12:01:48 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l9-20020a056830268900b006054381dd35so1724893otu.4
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4soX3KabjwU0FEA7c0j7G//u3xmYLObYRS1y0wfqs3U=;
        b=flmYg6YM9qyjAluoOMrr7iyFNyGUQ2LFcMjuQN3w78JVayrWnOBO+GM6qFaPAHzEd9
         PhrJpWmka9lXFQc9mucnvGd5iIzd77yYcSgOBjxO3qKJ5h+8MQqOfLIFDxwHWt1X8pkD
         CyakI2nEGiEf3D7pIGoMD+989DQ8rZHBInHlHTXPceeuwu2ve2E65njQFFBv3ZTIg3T6
         O41Pieiy4/LJEqt/R+Pzv2xaC7PJG7eH4aVeEnzxn6R0DWVIV3wf2ciMNKbui37ES8sY
         Y2AkZvBBVFbT0nMDrAsXaE5MIp550iY2X7LRnVfny7hPL+WD0Yu9EE2xegApcEzsqPiI
         jcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4soX3KabjwU0FEA7c0j7G//u3xmYLObYRS1y0wfqs3U=;
        b=nYW13r809WHNoEBorBgMShCnU6VpzGjBEHQdx3omxfAaYx9G9vwgsCUBVNqpj7NjGF
         aC6TdF1YbZCxMpOAlzBrc6Bzb6po+hrUyJj1d5hoqhQbOpFowZMZBRa+SnnEiOyG/10w
         9Cpxlgz4s0TTLBhdf7ogzoz+R8YVJxenv8e4IqxZRMbwcSLqfjfX5Ggk0yDpknmbHbL1
         31eeZh/QLxRBF93sIVD+BrLg7/bMwS0+xYbxIYS1XpWP+J1CqFUWN7eeo7GoH6jb2pkb
         jBAWISl0Dz8yivrjOh1fOjTW34CvpE94GxU04as7jHL6anIMrCVs1IYoBto8xTHzP9QB
         0p3A==
X-Gm-Message-State: AOAM532bXhhBs0pXwebcid+SsGTEn0PcW4DfHkwaR6oe/JlZziAos32r
        4AohvwoxnJLQ+0CvKVY6hKzbQRDoLYAelbQFqffkrSY5
X-Google-Smtp-Source: ABdhPJydYpsNsP5+j/HOmyaurdRV7w+gPD+VT/GxM7Q55aMYWDImmxgJpgrNP+wwt1LrMe+uRwNFoHXBKOs5RW8QdKs=
X-Received: by 2002:a9d:744c:0:b0:605:513d:2c66 with SMTP id
 p12-20020a9d744c000000b00605513d2c66mr4513464otk.154.1650481308058; Wed, 20
 Apr 2022 12:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220414135141.1723610-1-jwcart2@gmail.com> <875yn3twl1.fsf@redhat.com>
In-Reply-To: <875yn3twl1.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 20 Apr 2022 15:01:37 -0400
Message-ID: <CAP+JOzQP1m-zFNE9=GFpbxPVjAeE4geZQou-mMF+-wvuze84fQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] libsepol/test Include policydb.h header for
 policydb_t declaration
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 20, 2022 at 2:54 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > Since test-linker-cond-map.h and test-linker-types.h references
> > policydb_t, include the policydb header file.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> For all 5 patches:
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>

These patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/tests/test-linker-cond-map.h | 2 ++
> >  libsepol/tests/test-linker-types.h    | 2 ++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/libsepol/tests/test-linker-cond-map.h b/libsepol/tests/test-linker-cond-map.h
> > index 148c6f62..740a722e 100644
> > --- a/libsepol/tests/test-linker-cond-map.h
> > +++ b/libsepol/tests/test-linker-cond-map.h
> > @@ -21,6 +21,8 @@
> >  #ifndef __TEST_LINKER_COND_MAP_H__
> >  #define __TEST_LINKER_COND_MAP_H__
> >
> > +#include <sepol/policydb/policydb.h>
> > +
> >  extern void base_cond_tests(policydb_t * base);
> >  extern void module_cond_tests(policydb_t * base);
> >
> > diff --git a/libsepol/tests/test-linker-types.h b/libsepol/tests/test-linker-types.h
> > index 0c860ebf..acad5e0e 100644
> > --- a/libsepol/tests/test-linker-types.h
> > +++ b/libsepol/tests/test-linker-types.h
> > @@ -21,6 +21,8 @@
> >  #ifndef __TEST_LINKER_TYPES_H__
> >  #define __TEST_LINKER_TYPES_H__
> >
> > +#include <sepol/policydb/policydb.h>
> > +
> >  extern void base_type_tests(policydb_t * base);
> >  extern void module_type_tests(policydb_t * base);
> >
> > --
> > 2.34.1
>
