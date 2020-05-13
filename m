Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397BDCA90AF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 11:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E2E206CC
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 11:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjOFZGxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgEML4l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 07:56:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25387 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725962AbgEML4l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 07:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589370999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OYx9mXoNReCaXFzxDKq3VYPz9zUpe8yub6odpZvdpY4=;
        b=EjOFZGxC4QCyhmEoTQCidrjQGaLlhNrPzJFOam9NQmsY1dDbvWkYGMCeaxh0Plhm2ubh26
        jeoc4aTY06NF9Bbo6TL3du31Ml+Dyeo1Ct4mrx5hth1EMMW2WUwtFfmNj1532gdXfuAkRF
        zLtxAOFrGGpbrQvfo9FgphWC+QU3QM0=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-z6dMa3qzNGi8-WR9GbP7ow-1; Wed, 13 May 2020 07:56:37 -0400
X-MC-Unique: z6dMa3qzNGi8-WR9GbP7ow-1
Received: by mail-oi1-f198.google.com with SMTP id w198so15274865oie.8
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 04:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYx9mXoNReCaXFzxDKq3VYPz9zUpe8yub6odpZvdpY4=;
        b=K9T70I+BH5Sg8HMTudWRO3IWGl30+d2gYHll+/1ZC2Q6s8pZr3BKR6D/cfg8k2A20O
         1vORjrT5TOBV1lxn+F/JInQo1EsJZUgn8oBiIH8G36DSB+nAg8iemNcA8p/jlwrN+8R4
         XaauFSPwRAfyotK9k6+q6/BE1AI0nqfmMopJ/q7wurqjFQ1NhzFvCkj92H3ngXy/AsyO
         tSkmeH9/5hlOpVZXZEZMrc52EnaGUblb71VijQDMabvGZdXVp2YB5sWuFW0yd/UTU+o6
         Z6RvqgvgdjvD//zFe65MO5UcGF5omlbQHS/JZVAUx7gtH4cIpnxJa5r6zcC9x7JHXbHm
         JM2Q==
X-Gm-Message-State: AGi0Pubm3OeKNRuiYO0tkirm5bCy96Yhi8rqLJU0QyXHG+rQ7LLYNOqE
        f6xFma3PAi3tvCqMtW7R0R+8hY6GsMKAkQz7zsZF+drtap2mKIo6xF8pi2oezGZYhRZIuc1vTju
        /6gUFgJkx+L+9J6B4SQY3RydprVHwqjMqDw==
X-Received: by 2002:aca:b6c2:: with SMTP id g185mr27574849oif.166.1589370997313;
        Wed, 13 May 2020 04:56:37 -0700 (PDT)
X-Google-Smtp-Source: APiQypIAgcMRIVUcpQ/MGDieCcaduOG14lH+n0VMEzAddBqbOdM2ZthPWyT7ws/3wwg0LHK5NyUVQS+NHyReGIKIWnQ=
X-Received: by 2002:aca:b6c2:: with SMTP id g185mr27574839oif.166.1589370997083;
 Wed, 13 May 2020 04:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200511150118.838-1-stephen.smalley.work@gmail.com> <CAFqZXNs0RnZo1X-y0GTDXBQDJqSgSAVWsw1+G7bFuTku1OPeNg@mail.gmail.com>
In-Reply-To: <CAFqZXNs0RnZo1X-y0GTDXBQDJqSgSAVWsw1+G7bFuTku1OPeNg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 13 May 2020 13:56:26 +0200
Message-ID: <CAFqZXNtZgOahzq3+e7viQo4Px3Cf0OWZ5Js1_kHze-GhyiK9OQ@mail.gmail.com>
Subject: Re: [PATCH v2 testsuite] tests/filesystem: fix quotas_test
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 11, 2020 at 8:27 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Mon, May 11, 2020 at 5:01 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > As per the man page, quotactl(2) expects to be passed a pointer to
> > a 4-byte buffer for Q_GETFMT.  The kernel copies a single u32 value.
> > On Ubuntu, this was detected as a stack smash when running the test.
> > Fix the test program.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

Patch applied.

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

