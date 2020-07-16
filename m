Return-Path: <SRS0=s7s9=A3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBFDC433DF
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 15:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1664F207CB
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 15:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="J+b8NXO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgGPPoU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGPPoU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 11:44:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A6AC061755
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 08:44:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so8046707ljp.6
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2LWom6o/XZFkpDyVUB34Hrk0Idqcc35WOSPBapcibTM=;
        b=J+b8NXO/xj6TjbGPklhpyb4GXp+3GY1sarCtXo8AaYOwstYzmAwYsRdFknH7jbDEL3
         b7VG5bR8GiQViA+2syD49cmCN+0tntTurV6VR/b752ltaIFLvWtkLv9gFc8dOE5RBnbA
         AP3iEsT/l9v69GJlUGRIDZUTEeHdnY1kmh0BcNuwSJi0Hqt6obBGUgVO4Ukop44bmMhv
         zT4ZaWacQ0DjL3Ur2dB8obeAAoLkQRQQ3369wczD3KqIEwVMuNDKDqb6jSuoGkVCe4nI
         YVTg3HQfuf2OBQb2iTQ7tDvOhGbtBapNEb1x/8XWy7/snlIJdnsG2m2fSUCEzDQFDLr8
         Y6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LWom6o/XZFkpDyVUB34Hrk0Idqcc35WOSPBapcibTM=;
        b=L2lBPntVw1D6u9hJ1J4kx4rUiNLmifLRoener4HXWBHhD0x92vOCaNw8rahzaUCU72
         Onn9DMPvydkd6ThPeb3hFhYmMTaal2s0efZgne30ElG9ptAJ0BRYbI2kK0lhWQvWckNv
         8kFY5mmKxbQ2IRxF22ZHWrIvgGF1G7/XXLIArifeOrlTM44cH1sXABLE/uuk+jQy++bK
         wRpS6frwVE5e2PLJM2LjAtz6kznKF70/gAEKiRnxpDLe75cZvNKPKfwtg9jvkdjYDMQv
         dx4l+hYq3/8WOv/KTzjR/Rc4RieS9VaSJOjX82p4RPWuoikQ3mOwshXAqbgpGwF6jhh1
         +3xg==
X-Gm-Message-State: AOAM531m0xHmSlrzpYX+YS5eOw7MjQ2583L0UO+JPvwSb/AO0kuKlX7l
        4GsK8p1CRm17q4koXUdoyaM2x/iK593LDgvQIxp0Ldad7aA=
X-Google-Smtp-Source: ABdhPJyLQ8pU7XoTsSUjYZP1259dWJ0Ev7nGFmLiRdSuFdNtwr25/FzcgttFpDR1P03LxZrBGk/gJiTgM8c3MnVqpsc=
X-Received: by 2002:a2e:8707:: with SMTP id m7mr2250446lji.350.1594914258298;
 Thu, 16 Jul 2020 08:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200714202934.42424-1-mike.palmiotto@crunchydata.com>
 <CAEjxPJ5m31kcXH66viy3R-ncbBJCET8Wm3+DjphDeZ0iV3giEA@mail.gmail.com>
 <CAMN686GqFW_40pcX=fkb8XUVFczg7+md8tqoS45C4VNcbcq-ww@mail.gmail.com>
 <CAEjxPJ5mb9iz8OnGUMS6i0i5sbmxf=Ff6h6ey95SgJzXjgyuDw@mail.gmail.com>
 <CAMN686HGb5-TmKAa3h+eof6a451CMa7Qd9n5F9FX_ozw31BWAg@mail.gmail.com>
 <CAMN686F4uT7__dvy22V_Y9_zqd6ckw=14gs6RcExuT-3ru6NtA@mail.gmail.com>
 <CAEjxPJ4B4sOjy_ZW+hCMjA7Uy6KGO5HT8tMdFp_obF_raXiqUw@mail.gmail.com>
 <CAMN686EudnKSaR89rKm8xOkYJVJA8-eXFc__1k4QMH9Vyp5b1w@mail.gmail.com>
 <CAMN686F=msEb59N4pjroKFzZU4sH+81UzeyL91Hbvy3bddunqg@mail.gmail.com>
 <CAEjxPJ5RGYQi4A7nD8b=tKv2OdC7f8wfMiwprApOCNADEi-ahg@mail.gmail.com>
 <CAMN686H=3RY-E1a01fWPY9QqGpUABVxJmQGrx00c53JrMVswZA@mail.gmail.com>
 <CAEjxPJ6PQe0WPOA-LjNbfhRfDP7=dJ7N0aisCu9Y=WSHC7HXGA@mail.gmail.com>
 <CAMN686Ep659JPUhvkfSZ2eCxSwz8EkL6sdZ5kTT0td0buYi=Qw@mail.gmail.com>
 <CAEjxPJ56fWB-_k749aXOESJaDEJqQnQOznGZJkYm_=2LFJ6BEQ@mail.gmail.com> <CAEjxPJ7ZFZmyVNRCuYUb8+1YwUhp4XBj8CX-DBNECiSfAYKwxQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7ZFZmyVNRCuYUb8+1YwUhp4XBj8CX-DBNECiSfAYKwxQ@mail.gmail.com>
From:   Mike Palmiotto <mike.palmiotto@crunchydata.com>
Date:   Thu, 16 Jul 2020 11:44:07 -0400
Message-ID: <CAMN686G=NHciMQy3-PjJ=hdT9zfCT+-Eh4uVDgk4aN8r2ospcA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 16, 2020 at 11:28 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 16, 2020 at 11:12 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
<snip>
> >
> > That version of dbus did not call avc_netlink_acquire_fd().  It only
> > calls avc_init() with a thread callback,
> > with the expectation that avc_init() will create the thread (as it did
> > prior to your patch).  So you can't move that part.
> > Not sure what happens if you leave it there.
>
> Oh, I see - you'd need to ensure that the netlink socket is created
> first, or change the thread function to call
> selinux_status_updated() instead of checking netlink.  I guess the
> question is what is the actual behavior required.
> dbus doesn't care so much whether we are using netlink here but only
> that the thread gets created, checks whether
> there is a notification, and calls a callback if so.  So it seems that
> you could just change avc_init to call selinux_status_open(1),
> then if avc_using_threads, create a thread with a function that just
> loops on selinux_status_updated() calls.  No need to
> call an avc_netlink_* function at all (except in the fallback case
> inside of sestatus.c).  Does that make sense?

Yeah, that all makes sense. I'll test it out and hopefully post a new
patch later today.

Thanks again.

-- 
Mike Palmiotto
https://crunchydata.com
