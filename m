Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E118AC1975A
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 22:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB62120714
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 22:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="KEb9xHV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQWvx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:51:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42045 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgCQWvx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 18:51:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id b21so18266625edy.9
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2020 15:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sEmHChYUt55afE42DDfSLqMflv036MfHVf4psMBmjYI=;
        b=KEb9xHV/UCzVqHXUcx88yohKCwKhvH74GJkanSGmwXs1u0e+Nogc8JXLrIkiK3YyLa
         5Dmnr6vzHEQuqVyDlr6u2K/tJcIKn+Oq6CO05Uy0TVuTT64euc32hA39ctYpe98Ieu51
         qLWtiaZrFQtUDZD8oL5jzYDPgoQLPmaV3u6Ha7fL2V+QeNCmOXeqWMblblWvsOIVPwDH
         hqZRk6rxmtS6uDdKj6BW7k0qxCMH8Jru6f/rMSOjoGcZM3OZ1vqd0Z8D9c2g2rWu4aWl
         d+jIbUh4L+Emnnr5T3cXw1MfoZWIljvUgqk1ju4DGY0Zi+MxIWe+83B7LHRdcuTG4rHY
         5lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sEmHChYUt55afE42DDfSLqMflv036MfHVf4psMBmjYI=;
        b=gI4vigrclHsd4+xSGrljj/hNILk2M/kcLLmPKpouHmFcc9KQ0LSmLZ5BZ1wNUof/E3
         ZhjvaoJLDqRUhFzHQ+NqeCTTW2umBZeyBonDlRdrkjeFmaG8todUX4rozjaaj5fB21L2
         iRixegHchsLXGfsdeEkl+Ly1A5qchP10c8cpjdR3TAocVsbpVtKNXvzL/6yTy8hJzDIV
         r7jg24jHTbZ/xJBaso/rfs4N9OXvXbFuGtGj8E52iisaGP2bt6x5v/1Q+dcdqhSyVvbe
         SA6/EZdDFzUm+Ai2eHyLlRL9QN+9kPdgp4ST4nga0Hs1fk39CVg/UQdtxyfMTijFsNAu
         9IBg==
X-Gm-Message-State: ANhLgQ2yCtxmCSqc+JpHdrYHfraF35pNkEnarcVGZocGUY0Q21JKPwA/
        q6FSrwCXHamXYvcm8cuXV8/M57lOavNkP5Z/W+vJaPCdGA==
X-Google-Smtp-Source: ADFU+vvgmnzlm/BE8vwKt3HYHpJ6O/td+Fw6NL61dyvepz32b03sFRhLoIFqCypHHZkorb6Lzev3vrcWgU+FauR/1GM=
X-Received: by 2002:a17:907:105a:: with SMTP id oy26mr1351132ejb.308.1584485510354;
 Tue, 17 Mar 2020 15:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200317221237.vrkru2kdc63zq3vi@chatter.i7.local>
In-Reply-To: <20200317221237.vrkru2kdc63zq3vi@chatter.i7.local>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Mar 2020 18:51:38 -0400
Message-ID: <CAHC9VhTF8MH7UodKLGmAmMNzUeh-68W92pivnBgJfGhWV5F7HQ@mail.gmail.com>
Subject: Re: Looking for help testing patch attestation
To:     selinux@vger.kernel.org, linux-audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 17, 2020 at 6:12 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> Hello, all:
>
> I'm reaching out to you because you're a security-oriented mailing list
> and would likely be among the folks most interested in end-to-end
> cryptographic patch attestation features -- or, at least, you're likely
> to be least indifferent about it. :)
>
> In brief:
>
> - the mechanism I propose uses an external mailing list for attestation
>   data, so list subscribers will see no changes to the mailing list
>   traffic at all (no proliferation of pgp signatures, extra junky
>   messages, etc)
> - attestation can be submitted after the fact for patches/series that
>   were already sent to the list, so a maintainer can ask for attestation
>   to be provided post-fact before they apply the series to their git
>   tree
> - a single attestation document is generated per series (or, in fact,
>   any collection of patches)
>
> For technical details of the proposed scheme, please see the following
> LWN article:
> https://lwn.net/Articles/813646/
>
> The proposal is still experimental and requires more real-life testing
> before I feel comfortable inviting wider participation. This is why I am
> approaching individual lists that are likely to show interest in this
> idea.
>
> If you are interested in participating, all you need to do is to install
> the "b4" tool and start submitting and checking patch attestation.
> Please see the following post for details:
>
> https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation
>
> With any feedback, please email the tools@linux.kernel.org list in order
> to minimize off-topic conversations on this list.

Hi Konstantin,

You might want to extend this test to the LSM list as well.  I'm
refraining from CC'ing them on this email because I don't want to
spoil your beta test rollout, but I think it would be a good thing to
do.

Speaking as the person who merges patches for both the SELinux and
audit kernel subsystems, I look at every patch I merge; I don't
blindly merge patches (even from certain "trusted" individuals).
Simply put, I've always considered that to be part of the job.  While
the patch attestation could provide some assurance about who created
the patch (assuming a reasonable web-of-trust), and that it hadn't
been tampered with, I feel it is more important to review correctness
than it is to guarantee provenance.  If you ever develop a tool which
can help with the correctness part, I'll gladly jump to the front of
the line to test that one! ;)

Having said that, I'm happy to see work going into tools like this,
and at some point I'll look into adding it into my workflow for an
extra level of safety (although I'm on the fence about making it
mandatory for submissions).  Sorry to disappoint, but I'm probably not
the best test monkey right now.

-- 
paul moore
www.paul-moore.com
