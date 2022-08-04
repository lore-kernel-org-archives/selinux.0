Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E57C19F2B
	for <selinux@archiver.kernel.org>; Thu,  4 Aug 2022 11:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiHDLyp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Aug 2022 07:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiHDLyo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Aug 2022 07:54:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31B623A495
        for <selinux@vger.kernel.org>; Thu,  4 Aug 2022 04:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659614082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5JAufPDPsvJ5NRvZoJI1fjL6Jc/RX9nBSiQN4wOUyYA=;
        b=STNuaDKz/cBF7ISUYaww5swPipVatNwCLXYGS2ewLUbTnR5egv4LUAzs7jG64rx4xV011u
        wwzmZiwhP5/ufL4UUd7X1X2SfSgsl+zDUR4nPiGo1ti/TI881X6/CRJje8Xm3TFZ5pbTuD
        vCkcPEbzZj0pt5JW+BkNSJ+Vvqe8qyQ=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-wrqJ3IyvPRqXdBu82-Gu2Q-1; Thu, 04 Aug 2022 07:54:41 -0400
X-MC-Unique: wrqJ3IyvPRqXdBu82-Gu2Q-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-31f58599ad3so167921177b3.20
        for <selinux@vger.kernel.org>; Thu, 04 Aug 2022 04:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5JAufPDPsvJ5NRvZoJI1fjL6Jc/RX9nBSiQN4wOUyYA=;
        b=nvLZLLIOloPXKrjsV574uc61Xok+NTqOqsJSxIU4vZ4jBNTm+D7UtXAHbdCoS1o2LA
         mZPTCF7es+zhUD07D0/Cwh/Aen3ZZeYii8x71i/0Mg4kICMMkzcH3rD2/2KRpOZdlpzu
         ofMoDU60pVBXYBfexIW9aRf01XkakAg/KGcxqv4wTFrHKGZcilLZZYZeqHQueBl4s5go
         U//a+O4JgpFqVeZ9On86f1goPUnPUmvTRiC5rXPDEaOpAe5aMsCa+FIsitfFDIUfEkr7
         xh3h9XGE2T5pakWnKMFyzhTfXgLT4LMaupSrFNKpCtDLPbo/HUGEzVWuy29Y3/HYx6HJ
         MyVg==
X-Gm-Message-State: ACgBeo3g+ymS8yVErBwWckoRUufI68PsTIwyxBV7mi1vXUERssvQeKzn
        GkjC2zpWadkmm9guh71iS3p8txG9tAsebZ2s4bKsovfdOCOPm8iVDCsfUBRcLUtrcsq8SM6pn8h
        Ao3cGDTNxYeDSUoTXeFVzokGWEiJGeEh1uA==
X-Received: by 2002:a81:5d06:0:b0:31e:3b24:4a86 with SMTP id r6-20020a815d06000000b0031e3b244a86mr1301432ywb.245.1659614080690;
        Thu, 04 Aug 2022 04:54:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5dMhjFCL4zN9nA97e/seFufR0w+IiMRk6xVKMWvs3k1PODdWBmLXAP8PdbyNB+yw5aQpCyMaNs3viVGT+vgpQ=
X-Received: by 2002:a81:5d06:0:b0:31e:3b24:4a86 with SMTP id
 r6-20020a815d06000000b0031e3b244a86mr1301414ywb.245.1659614080457; Thu, 04
 Aug 2022 04:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220729120229.207584-1-omosnace@redhat.com> <20220729120229.207584-9-omosnace@redhat.com>
 <402ab967-1d76-40bc-f901-8c0339ef8b45@linux.microsoft.com> <CAFqZXNtq5-BwaDFjGPX6fPbg304-Mm7eMo0mNy6PrpuK9B7eCQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtq5-BwaDFjGPX6fPbg304-Mm7eMo0mNy6PrpuK9B7eCQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 4 Aug 2022 13:54:28 +0200
Message-ID: <CAFqZXNumd2dEFN6BdyAgoLrQ6vUkAx1SGV5LJHBi_6rYZ-mhsg@mail.gmail.com>
Subject: Re: [PATCH testsuite 08/24] policy: move userdom_sysadm_entry_spec_domtrans_to()
 to general policy
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 3, 2022 at 10:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Aug 2, 2022 at 3:55 PM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
> > On 7/29/2022 8:02 AM, Ondrej Mosnacek wrote:
> > > This is good to have for pretty much all domains, so remove the
> > > individual calls and move it to test_general.te.
> > >
> >
> > For whatever reason, test_sysnice.te uses
> >
> > domain_transition_pattern(sysadm_t, test_file_t, setnicedomain)
> >
> > instead of userdom_sysadm_entry_spec_domtrans_to().  I think the access
> > added in the global attribute here covers that and the
> > domain_transition_pattern() there can be deleted as well.
> >
> > Between that and the change to test_setnice.te in Patch 9, this comment
> > above those two lines seems obsolete and can probably be deleted:
> >
> > # Allow all of these domains to be entered from sysadm domain
> > # via a shell script in the test directory or by....]
>
> Oh, true... I did carefully search and remove all individual
> references to unconfined* but not sysadm*. I'll try to clean those up,
> too.

OK, I pushed a new version (see the GitHub PR) with sysadm* references
removed + corecmd_* rules also moved to general policy + some groups
of superfluous macro calls removed as well. There are probably still
some small cleanup opportunities left, but this is where I'm going to
stop for now.

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

