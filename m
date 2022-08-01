Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C946BC19F2C
	for <selinux@archiver.kernel.org>; Mon,  1 Aug 2022 08:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiHAICZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Aug 2022 04:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiHAICY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Aug 2022 04:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F90A10FDE
        for <selinux@vger.kernel.org>; Mon,  1 Aug 2022 01:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659340941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UDZxrDxP/xsqWP59QxruXP9RPQf6dxENsTYXjuaKjso=;
        b=D4MKkmxMm0gwxMvuD8vfsce/pdmtXssFd1RGB+t8y4AyIeWr1vTKqtKsVrmcKxE2cjbR29
        T3B1XmUvuuGvIspPqTBmm9gxbQ7z/MsGe2TnOe1yfTjXGRNaFuiVDseLAXXlvIRqbG94lE
        sJwJcGqRxYNWyH6o71oMAvC7oeKiLB4=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-3aI7AFh-Oa2Qwn3e3I5_Wg-1; Mon, 01 Aug 2022 04:02:20 -0400
X-MC-Unique: 3aI7AFh-Oa2Qwn3e3I5_Wg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-31f56f635a9so86812587b3.4
        for <selinux@vger.kernel.org>; Mon, 01 Aug 2022 01:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=UDZxrDxP/xsqWP59QxruXP9RPQf6dxENsTYXjuaKjso=;
        b=ORnaA8RpgOKPAcOxefhNXuSHrXI4TR01DlkIooV8BX+GtgdAdLx0FfoQAEJTjEOBOi
         +Pe5UHyEA/RCxQEXw+D1cnUSIFsVk6SFIxZNvXXYlAc02YQhdDc7Sjd3qiFXZ9cYGw2f
         sPrW+XJdiXQFRpQtPZX9yXCKGX3SUoYYdcvS6crdd3FQlkO5U+AwZEBwAY9jT5ved3Bj
         718TRGF7FWiQhfHca4ZerebLeEpvzhEzaoyfjUpor/cQSghxKqke0ex9TwmhkEZAq8HO
         oGSc40Z4NSRDSE1WtaWBqH2sx+zQ0mnncqA0FdNGbR1h+kMrcBlZqHFGqfU+RCe4CYm9
         nuFA==
X-Gm-Message-State: ACgBeo00ULUGs4mDJD88/UBPNzYLnT4Cg4Wclm2DWPZSyLA0EwnczKq9
        hHI3YglyCC45Na+fXUKfhtRPGaBsWwNdEFBhg6eMkLj5L21MflNhsxDc9VK5XNVlwmf6OuYTGtg
        3n5VDAp3thFDbW0lbyLnxEmnhuUtqdSjIFw==
X-Received: by 2002:a81:5d06:0:b0:31e:3b24:4a86 with SMTP id r6-20020a815d06000000b0031e3b244a86mr12031975ywb.245.1659340939916;
        Mon, 01 Aug 2022 01:02:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5titKzdfhkujFWgTZAIQ+BVzQihVcuhI+GOCUSqBhxyFZRb455szH11IQh+3z3dGYJ+JzLifSRfUFvEKiBCes=
X-Received: by 2002:a81:5d06:0:b0:31e:3b24:4a86 with SMTP id
 r6-20020a815d06000000b0031e3b244a86mr12031957ywb.245.1659340939654; Mon, 01
 Aug 2022 01:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220729120229.207584-1-omosnace@redhat.com> <CAFqZXNvZFeOcgRtVKG3JPCPMb2E42Ot-B+BxbnRxWF9Jz-TvhA@mail.gmail.com>
In-Reply-To: <CAFqZXNvZFeOcgRtVKG3JPCPMb2E42Ot-B+BxbnRxWF9Jz-TvhA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 1 Aug 2022 10:02:08 +0200
Message-ID: <CAFqZXNuBBOVWC6eZxK=-AK36OhS3xDDniOmhJc0N4ujOYpmPLw@mail.gmail.com>
Subject: Re: [PATCH testsuite 00/24] Clean up testsuite policy and support
 running as sysadm_t
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 29, 2022 at 2:27 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Jul 29, 2022 at 2:02 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > This series aim for two things:
> > 1. Refactor the policy so that it is easier to work with.
> > 2. Leverage the refactoring to fully support running the testsuite
> >    as sysadm_u:sysadm_r:sysadm_t.
> >
> > The gist of this work lies in unifying how test domains are defined,
> > deduplicating the various boilerplate spread out all across the
> > individual files (and not even used consistently), and in abstracting
> > the policy caller domain/role away from the individual test policies
> > into test_general.te. Some tests also had to be massaged to not
> > hard-code unconfined_* and be generic against the context of the
> > testsuite caller.
> >
> > The series also extends the CI to test running the testsuite as sysadm_*
> > and also verify that no unconfined_t/sysadm_t unexpected denials are
> > produced (which would usually indicate a missing dontaudit rule in the
> > testsuite policy).
>
> Lol, I got a bounce for patches 4 and 5 because they are too long :D
> Hopefully the list owners can approve them manually. If not, I'll
> submit this series as a GitHub PR and post a link here.

The patches are still not there, so opened a pull request:
https://github.com/SELinuxProject/selinux-testsuite/pull/82

One can fetch the contents of the PR in the git-format-patch format
through the following URL:
https://github.com/SELinuxProject/selinux-testsuite/pull/82.patch

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

