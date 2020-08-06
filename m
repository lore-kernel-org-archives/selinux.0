Return-Path: <SRS0=AdpT=BQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E429C433E0
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 02:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CA372245C
	for <selinux@archiver.kernel.org>; Thu,  6 Aug 2020 02:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="f7nsHNxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHFCfI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFCfH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Aug 2020 22:35:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD200C061574
        for <selinux@vger.kernel.org>; Wed,  5 Aug 2020 19:35:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id jp10so22039796ejb.0
        for <selinux@vger.kernel.org>; Wed, 05 Aug 2020 19:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgnTEaZbUhvpthkh33rsC6biGkpHN5BZh6g7PrkCiQQ=;
        b=f7nsHNxFSwQWud7Hl6knlRW+5FH7OQiAdseWrDY97kT8ETKW4gvDJ9bBIw8JJoMtkb
         No+qIZROJTvec9gSxyh/e5rnQpmwlq0PvKyggE1o2qY5+HhFw/mxXxAAHprnMeWgeJSO
         muUx8N22SKRbER/9XzYA6+7ZqxLcW6p+Y0nbUTzDYeIMvrA1nl4dnYCJ031CUXc/UbIm
         0R7lIEqM3fcxe4T5ALfmhmsW0f+fQJ3M8t0raBZ7Nax8UkDNNqma0pri9TnoiDISinOB
         mG+6WigN5s/nG4gtKVF8FTNXUe+iCEfdLw28VshdyMZDrOhDkvK9z0K2b/haiv2KMJ6p
         l7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgnTEaZbUhvpthkh33rsC6biGkpHN5BZh6g7PrkCiQQ=;
        b=nYggmcg5zQhBJItB4CU5uLh4S6hTf0oYLknx49nkEjWVBo+XNJiara+cK0LSSutljL
         B+yXH+1mlL+HOWbwKtEY6juO0fADcTNlwGes73oQDcmDqFd0vr32XEpMg2EdXfIMeN0W
         Wn1ad1a5L1o0NXzrcBR5lt3sgItx+NmLDIYy2+APKje/ZHJGVdVg3r1KfM6m8eb4qulN
         ieHeC5+VliPexWEodY2pOvSAJqJ1QEbHvkcfD9+HgeUPmkRvTvDyNHTFYCm4s3iLZ+nw
         atTEcU311CcjJgG4NNExX86F92UISvtXulOGjlVUV+Emjj1wu7BiYb42PG1QAsCjCHxq
         jyMA==
X-Gm-Message-State: AOAM530QaJO7F8TV3j8SOt5Xy5N32zqpebnOW0RNdsAkez77zw+NCg9N
        eFLKc1Y/F4NJXDJERKW73+fSWxpMRQQ1/HT6CBnZmL15TA==
X-Google-Smtp-Source: ABdhPJzepm4wD8u0v38wHSmCHZD5EjP+c3PMbBazs3klUL8v7lf8g5/42JMD4p1/y/ZQjeEHASM3hl069wc1NbrrzHo=
X-Received: by 2002:a17:906:e0e:: with SMTP id l14mr2097899eji.398.1596681303312;
 Wed, 05 Aug 2020 19:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <159650470076.8961.12721446818345626943.stgit@sifl>
 <159650482872.8961.7516871249534865160.stgit@sifl> <837e782ff80f69e8e4d44bc49ff2ced54b0aef2c.camel@btinternet.com>
In-Reply-To: <837e782ff80f69e8e4d44bc49ff2ced54b0aef2c.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 5 Aug 2020 22:34:52 -0400
Message-ID: <CAHC9VhR5ik=yk5Oo=n_B3JhKyJuBVaSa5rUNsPdHMtH78b83mw@mail.gmail.com>
Subject: Re: [RFC,selinux-notebook PATCH 05/18] xperm_rules: fully convert to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 4, 2020 at 12:14 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Mon, 2020-08-03 at 21:33 -0400, Paul Moore wrote:

...

> > +*rule_name*
> > +
> > +The applicable *allowxperm*, *dontauditxperm*, *auditallowxperm*
> > +or *neverallowxperm* rule keyword.
> > +
> > +*source_type*
> > +
> > +One or more source / target *type*, *typealias* or *attribute*
> > identifiers.
> > +Multiple entries consist of a space separated list enclosed in
> > braces \'{}\'.
> > +Entries can be excluded from the list by using the negative operator
> > \'-\'.
> > +
> > +*target_type*
> > +
> > +The target_type can have the *self* keyword instead of *type*,
> > *typealias* or
> > +*attribute* identifiers. This means that the *target_type* is the
> > same as the
> > +*source_type*.
> > +
> > +*class*
> > +
> > +One or more object classes. Multiple entries consist of a space
> > separated list
> > +enclosed in braces \'{}\'.
>
> I've had a rethink on this and wonder if it would be clearer if the
> descriptions were a bullet list:
>
> *class*
>
> - One or more object classes. Multiple ...

Ooops.  I forgot about this comment in my inbox when I merged the
patchset; although I guess even if we go with the bulleted list having
the table in markdown first should make this easier.

I guess we could give it a try and see how it looks?  My only concern
is that sometimes a list with only one item can look a bit "off".  Or
an I misunderstanding what you are proposing?

-- 
paul moore
www.paul-moore.com
