Return-Path: <SRS0=k17o=CX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6882C433E2
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 15:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663AC21741
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 15:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hK4U5pmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgINPFF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Sep 2020 11:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgINPEo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Sep 2020 11:04:44 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E041C061788
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 08:04:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z22so432315ejl.7
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMHmb152SaQm2/QBC2asLYpTT/6SX5nUtX8yTfvQi+4=;
        b=hK4U5pmpgVl8MA8L+dCv6becZu0t6WIbYwo7PxqlKY4Sh5/VoPMS8bEP4cLFIcX5jj
         Jtr4ay6PucZyPvJ58vQEunOc4zDmJUNlH8UI1GwpIBM8cyF7qAx6y64jJoVuIaPvYiu1
         b7niHmipQGnerl0qBTFH2Zy8nQDBNkEtjfrZQj463lGc00/kC1hb9R5Rx7kCv0duxbF7
         hDjSjJ701ioItAzivAoPsLe210cLNSRXgzk4dSuWJrt7hCUfYihiNw+DyLVcN/2P2pNK
         kVc9JhPwgBAozWvfwd2GVDPxDVPvG7tXkBrA3S5u7+/lrqA0Wqa8rSIiTKD8O1kyZZhr
         yR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMHmb152SaQm2/QBC2asLYpTT/6SX5nUtX8yTfvQi+4=;
        b=cJ1foUGxV4jKPI+X4HOyB+VjI1iWSVGAeQ9GDu3Cc8NyC6o/O4Xj01J6XcPA+xQ6hm
         fk9OADFIUFgqIw89QvsqncQv5/pIw3sF2VCUCLYR4dZVhWcYQeIvfTtzqVzEJbtfs/sW
         yTVCqj5txQRVBO8cf0RkaeQT4Dfg/ofMhM+j7RP3BALU7pUQmLk1+hxWt6UBn0zJ6mI7
         WqoznaTzZRP3pKsrJ1enG00SNLd2n3JrAhZrYoTDVUSfEhrRjL0ol0PlfQ020Elkse7r
         UCfkVqIRc8O+kpA0AeH2s/YiSzk4M7wddM5QFkVZX5Bi+fOAcLRL08ot5GQOEFzqoYnz
         qwfQ==
X-Gm-Message-State: AOAM531vcViUmdR06K/DM8Eb+b+IOZlWNB4c408uAeNRy9QCXXvgt4a2
        kHun9rd2A0UGHeqJE72+fq6aWMEl++iYEOtwEMIj
X-Google-Smtp-Source: ABdhPJymAX2xZ3naXKm2QvQNpHVYFf2ze92rQt2WwvTuoHMPuAD0EUunI4ButmyNcoCd2w2mU3GPvwCokatjb0M/phA=
X-Received: by 2002:a17:906:a415:: with SMTP id l21mr14369570ejz.431.1600095883048;
 Mon, 14 Sep 2020 08:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200911164009.21926-1-nramas@linux.microsoft.com> <CAEjxPJ4JCRkiSnDq=HZjk2pLj0m2ayYTeEvQ2jevMd=yLMoXhg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4JCRkiSnDq=HZjk2pLj0m2ayYTeEvQ2jevMd=yLMoXhg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Sep 2020 11:04:31 -0400
Message-ID: <CAHC9VhQDYe1TQCG7waTEUxUhSzLHrqJGTG-OAQrgvR6E-iwEgQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: Add helper functions to get and set checkreqprot
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>, James Morris <jmorris@namei.org>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 14, 2020 at 9:25 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Sep 11, 2020 at 12:40 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > checkreqprot data member in selinux_state struct is accessed directly by
> > SELinux functions to get and set. This could cause unexpected read or
> > write access to this data member due to compiler optimizations and/or
> > compiler's reordering of access to this field.
> >
> > Add helper functions to get and set checkreqprot data member in
> > selinux_state struct. These helper functions use READ_ONCE and
> > WRITE_ONCE macros to ensure atomic read or write of memory for
> > this data member.
> >
> > Rename enforcing_enabled() to enforcing_get() to be consistent
> > with the corresponding set function name.
>
> I thought Paul said to only use the new names for checkreqprot_*() and
> not to touch enforcing_*()?  I don't really care either way about the
> names but usually we wouldn't mix renaming of something else with the
> introduction of these new helpers in a single patch.

It's generally a good idea when someone has provided feedback on a
patch to limit the changes in the next revision to just those changes
which have been suggested.  It helps to keep the patch focused on the
original issue, makes the follow-up reviews easier, and shortens the
develop/reverge/merge cycle.  It generally isn't too bad of a problem
in the SELinux code, but there are other subsystems where several
large patch revisions have been wasted because the patch author lost
focus and started making additional changes outside the scope of the
comments.  If you want to submit the additional changes anyway, my
recommendation would be to split them out into a second patch in a
patch series (make sure the original patch is first!).

Of course the best solution is always to ask if you are unsure :)
While I don't check my upstream email quite as often as some folks
here, I promise to respond to any follow-up questions if no one
answers first.

... and please don't let our small nitpicks discourage you from
submitting patches, we really do appreciate help and contributions :)

> FWIW, looking at the history, the enforcing functions were originally
> named is_enforcing() and set_enforcing() in aa8e712cee93d520e96a2ca8
> ("selinux: wrap global selinux state") .  Then Paul renamed them to
> enforcing_enabled() and enforcing_set() in e5a5ca96a42ca7eee19cf869
> ("selinux: rename the {is,set}_enforcing() functions").

-- 
paul moore
www.paul-moore.com
