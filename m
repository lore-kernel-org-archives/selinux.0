Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6827CC47247
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B00A215A4
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 14:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="b1kRl2v4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgEEOVv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 10:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729449AbgEEOVu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 10:21:50 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71669C061A0F
        for <selinux@vger.kernel.org>; Tue,  5 May 2020 07:21:50 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id pg17so1798566ejb.9
        for <selinux@vger.kernel.org>; Tue, 05 May 2020 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4WZgvu6iqzjkKd4BlYTSZGC1oUtt37QQVzR82vLWP8=;
        b=b1kRl2v4epTun1fbqxEwtfWnpeEwQcINeeUGDY50M2Ih/193TE9K0Hd+bo7HVVRIvp
         ial5iom8/mZtj7W95sDx+7RDcbtDOf2YgsPddcyyB6/cFM4+1Hv29mtgmZayWnwsJybE
         JRfsElbyF8n/QuC0Gc8q6E80lXD1ipVBcnDIXLGJvlu9dtebS+c8Opz7vB0rTnyez8V0
         icXSbL2PL/ngMlfsVqWcMSFkeD5n34Ss39DlIcXmLrAKZ9snRACqENiNCDGmT9Vdv6jC
         dnBf9vOZXLufsDw69UAl5TwxPPRlxn35pwgYZ7RFXGyTOTAg9N3KEf6gcEMr1e13kWft
         mvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4WZgvu6iqzjkKd4BlYTSZGC1oUtt37QQVzR82vLWP8=;
        b=AaoBKcAvgDLUwgIbrsUrWLhKC2qk10G6NIX5EPnQq7pqUNteofLWCfEyV2OEGZJrFh
         YY84MqOf0qqRB6MCA1KCsFckyC8rnfKX6qmAZNGgWwbW6XSDIGPddpztPsi1tbRWkvQk
         hqiD/453I9CL5T1UfJxwRWScbYyCMflzwEfKetvzsQhO3Vc6u6L+E3cELjK9kWiLMR4u
         0t8qAqMBB0ndD8H3abzqsCvwZKdzwh/YYDJUcLrre2wu1MHXK5SIUENL9EPqt20pMQoI
         zgtLfAOzj2PlCOVVczN7JKmmjMtB8U9X74fS4tdgbHIvKSDKiPvFFlbqskUlxfp+VdUp
         paaw==
X-Gm-Message-State: AGi0PubvlI3BCVE2ry4+zupGmjIKnUcYLr5eW+mHakrgtK2Yv0Yr5WeH
        jO7bbn7Lh2lerhuK7wEN32qjI8lggm0tNGrWzm8=
X-Google-Smtp-Source: APiQypIJ1DjJtUb9ZkTHEcN9H/xx22cEUboH7x0kUCjP7u4JivgEfTna4yoKFfyomSxSRU7YZwrttg1/07yR3F7I4i0=
X-Received: by 2002:a17:906:17c5:: with SMTP id u5mr2862676eje.275.1588688509055;
 Tue, 05 May 2020 07:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135727.GD7308@workstation>
In-Reply-To: <20200505135727.GD7308@workstation>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 5 May 2020 16:21:37 +0200
Message-ID: <CAJ2a_DfH-faLvYsE2jabaSHFbTBNqDpU1Q5xre00OCS-3g7c0Q@mail.gmail.com>
Subject: Re: Intent to release 3.1-rc1
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Di., 5. Mai 2020 um 15:57 Uhr schrieb Petr Lautrbach <plautrba@redhat.com>:
>
> Hello,
>
> I'd like to release 3.1-rc1 until end of this week.

sounds good

> https://patchwork.kernel.org/patch/11392367/ libselinux/getconlist: add verbose switch to print more information

This patch can be ignored.

Quoting Stephen Smalley:
> More generally, the libselinux utils could stand an overhaul:
> - a number of them are really just examples or tests of using the
> libselinux APIs and not really suitable for end users in their current
> form,
> - some of them should be prefixed with some kind of namespacing (e.g.
> se or selinux) to avoid potential conflicts,
> - there is overlap among getdefaultcon, getconlist, and getseuser;
> probably should be coalesced or some dropped

Maybe we can discuss the libselinux utils in general during the next
release cycle.

> https://github.com/SELinuxProject/selinux/pull/174  Use quote include for files located in the local directory

I think this pull request is obsolete now as the dso headers are gone.
