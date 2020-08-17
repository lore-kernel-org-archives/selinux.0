Return-Path: <SRS0=6AtE=B3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E8FC433DF
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 17:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDA02067C
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 17:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNHSYK7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbgHQRrP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388632AbgHQRql (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 13:46:41 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CE7C061389
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 10:46:40 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n128so11682707oif.0
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 10:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HGROQwRwndjUkn3w9kEprNNpGdEqX4tZQCUA25HSF30=;
        b=bNHSYK7E2+WaLdXDwcDpmT92jhw6KVJS3rNVtHXMFM32u0mTCFnd9daA5n+8HWI5my
         GqsAfsLSUnJ89qZ9stcsDd/cR8Q8c6i3UZuaWVnl6noUlVgR0oJah9OgcK8byq/x2mrY
         HVZ0WtsIke14wjhY039PDQJdLMRnrizam/QXWOZtUqj9mjIQUnkKnDHNr27dmDhdJsqY
         hdgfzEaTc86FfOIQIKH6beEqHlDMCjMXrhmX3PB36yfHRkQXb6MgOqh/jGdU+wXuWqYb
         795tSFfgosnRuPi1Bkm+wKhh+QZgNgIoySBqcKENT23HcsWaBgkE6qOgxZiNhmxewM05
         eQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HGROQwRwndjUkn3w9kEprNNpGdEqX4tZQCUA25HSF30=;
        b=EFDC0pDFKHGn4Xv2tuE04FwhBGx3La/9doMsOIkMdQyf/bsmb6tEPTw5tJvaY3pfDW
         3HbawT28tXod4685Gx2KyBUdpSLe6Qd3TCG0zoC4PdaPqAXu1RWQaKoWVAgQwSJgFd7z
         EYNPZEWSMWmU2WmKkZ4M/tzLX+nEWZvLB7ICThoheijSq6Q7zULsYKMAj0G7npdE4vsD
         8e2BMQyhjKD2i9mALjjeK/+CAEEIuIVEvL+99vBoIbUbD+jrH4OqhVjNmoAljoEJHL5D
         GoHSxTD+ehsTlT71o1F3qoy+QSZFQQkR6T6fctasH36Eu3UkEyHabP61Yx2wM8sgAPvo
         DDZQ==
X-Gm-Message-State: AOAM530d0MTn9wSzpgcZloomteYAPJjU1mE0qBsX/H+wH1QxRfAmzNcy
        UZStjB3UfoKeMiwtv3ChqzxpPnbB1detIPiVm/w=
X-Google-Smtp-Source: ABdhPJxhAF3Hufzdce/1ksvtjrDt96AN09ivPwGZ8/a/4w5vs+eSiK58+ttd66BfwBuzWN2sk8L4V2dVFmAhWKVVdp0=
X-Received: by 2002:a05:6808:47:: with SMTP id v7mr10211755oic.128.1597686399675;
 Mon, 17 Aug 2020 10:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <2ce8defb-523c-01c0-560c-7881d0a99416@gmail.com>
In-Reply-To: <2ce8defb-523c-01c0-560c-7881d0a99416@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 17 Aug 2020 13:49:41 -0400
Message-ID: <CAP+JOzStOhn92uN_04R8JbVy1_5noQUVfoG-O6+2WnsKG8tcdw@mail.gmail.com>
Subject: Re: Resource usage of CIL compared to HLL
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 17, 2020 at 9:48 AM bauen1 <j2468h@googlemail.com> wrote:
>
> Hi,
>
> I usually test all my patches against refpolicy and my own cil policy (ht=
tps://gitlab.com/bauen1/bauen1-policy/) on small VMs in the range of 1 vcpu=
, 512mb memory and a few gb of disk space (Comparable to the cheapest VPS p=
lan you can get and still run reasonable stuff on).
> Recently I've started hitting the memory limit while building my cil poli=
cy using semodule / secilc.
>
> I've found that secilc can easily hit ~400mb memory usage while building =
dssp3 or ~260mb while building my policy.
> semodule invokes the same functions as secilc to build the policy but req=
uires somewhere between 100mb - 200mb for whatever it is doing.
> Running semodule against a normal refpolicy installation only requires ~1=
60mb memory total.
> This means that installing refpolicy on my VMs is not an issue, but even =
my CIL policy that is far from complete will easily OOM the machine.
> While adding additional memory isn't really an issue, I'm a bit annoyed t=
hat building an incomplete CIL policy requires ~2.8 times the memory that a=
 complete refpolicy requires.
>
> After a bit of testing using valgrind, I believe this is mostly due to th=
e way CIL handles blockinherit by duplicating the entire AST of the origina=
l block into the target.
> This works very well and is very simple, but also doesn't scale very well=
.
> For example my policy has a few "base templates", e.g. `file.template` th=
at contain a lot of general use macros, e.g. `relabel_files`, `manage_blk_f=
iles`. A similar approach is taken by grift in dssp3.
> All of these macros (~130) are copied to every block containing a file ty=
pe (only ~470) resulting in a lot of duplicate memory.
>
> Is it even possible to change libsepol, e.g. to use a COW for copy_ast_tr=
ee (and similiar) or is this behavior required e.g. for `in` or would a cha=
nge not be worth it due to additional complexity ?
>

Long before we developed CIL I had experimented with parsing Refpolicy
with a lua program that I created. I was really worried about memory
usage when developing that, so I did not copy anything. When it was
proposed to copy the AST for CIL I was sceptical and reworked my lua
program to see what the impact would be. It turned out to be easier to
do, faster, and did not require any more memory. The memory lost due
to copying the AST was made up by not having as many symbol tables.

If a lot of the macros that are being inherited are not used, then it
might be worthwhile to add a step to remove unused macros. Of course,
to really save the memory usage only the macros that are going to be
used should be copied, but I don't think that would be easy to do.

I will admit that I am not a big user of inheritance. What is gained
from inheriting all of the macros like that?

Thanks for the report. I will take a look to see if there might be a
fairly easy way to improve the situation.
Jim
