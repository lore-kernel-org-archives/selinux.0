Return-Path: <SRS0=x6f6=CB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62817C433E1
	for <selinux@archiver.kernel.org>; Sun, 23 Aug 2020 13:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3844A2078A
	for <selinux@archiver.kernel.org>; Sun, 23 Aug 2020 13:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GjEX48Ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgHWNaf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 23 Aug 2020 09:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgHWNac (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 23 Aug 2020 09:30:32 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33B5C061573
        for <selinux@vger.kernel.org>; Sun, 23 Aug 2020 06:30:31 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so8531495ejb.11
        for <selinux@vger.kernel.org>; Sun, 23 Aug 2020 06:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IAA+YSOlSDh5CIOC201G3wtpEXDdPYpildsy+4r4kg=;
        b=GjEX48Ni46tVKosG4Bf+AAwzBeAi9Y3awMEjRE/zOaEGkTc/iDLuNvcudYov8uU5Db
         Uez+4OHoOAs+2ZHkcPb/qUv2Sn6u58pR8ZtfGUVz2B6HrrVvMfiNDR3HLqA9OUIGy6OF
         1WSqiuiYjFnQNs16F5LPWSNj4MmrjFsOM1jn1u1exagWfLTVlHpGOflREA00dgeBAqWQ
         RVF7HuJZbthhdxPa8MtlK7mvvQCfMhprQmSm02OXvVF6NXpXCAGC0GZwiGU+QuwCYr/j
         aFbmHa68gV4eNyWBzDE0qKn27eB4nM4Ccn/x6xMNGsDW/rkWEMj3E+j2UjV9YIVdyaz/
         D2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IAA+YSOlSDh5CIOC201G3wtpEXDdPYpildsy+4r4kg=;
        b=lFCUnbWQPJ4fc6j1f3M/lRcbaqxQhboOr69My/0UWW36Gu3EF26AgUl2kTZw2UGkXV
         iP/Jb5ngY1swmmKT71hChyM6bh6FucN7PgOmDDEle3giwEHI9LfsE4uA8dn6VnHcdmkf
         cPZ05LVsj1b57RoQ0ig/NfPesgQYAeqhgGRUqtLOw6JqmKWoTWQo50Ww4z7BbnnlkFvz
         VXHs+edxbndhLx8vqJEav1hoALseNEUf459i9eIfReSUKOGFt19iv+7Zj3KC/5QbDbwD
         ZCuFays3f/GZbsCfTjQw22Oupt0TYLYoyOy/piM/4C4f4PQJzuDPfYVQMSQkKHfm1Vgs
         Q8Ew==
X-Gm-Message-State: AOAM530a15SV9BroHGiVDO6jxlFVVxNE7oaqNR7mX4BYXKJy+R1YEelr
        X5EleVJsbatDakbrmeEKwZnYBODdeQOqEiOT4ZOzAJrBR6E=
X-Google-Smtp-Source: ABdhPJxCeJaKmmnYTTrI38NbOX+sHmMvogpBDkO4Bd0g2oEBI9dUyc6Qx1+FtOx76o4Ku1BUk0H3jCAElcsy4lpb8KY=
X-Received: by 2002:a17:906:f9cf:: with SMTP id lj15mr1507293ejb.520.1598189426196;
 Sun, 23 Aug 2020 06:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200805194312.7188-1-mike.palmiotto@crunchydata.com>
 <56f3aed8-03e3-f847-967c-e9c8630f692b@gmail.com> <CAEjxPJ4F70OTPLi_u0Dz8LO7qs_1WuoaK9EqP4awVf92MViOtA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4F70OTPLi_u0Dz8LO7qs_1WuoaK9EqP4awVf92MViOtA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sun, 23 Aug 2020 15:30:15 +0200
Message-ID: <CAJ2a_DfkdX1Nmqs6_H-3k2qg=eYOuz3KDhS8EQYNG35jTR=bTw@mail.gmail.com>
Subject: Re: [PATCH v6] libselinux: use kernel status page by default
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Di., 11. Aug. 2020 um 14:14 Uhr schrieb Stephen Smalley
<stephen.smalley.work@gmail.com>:
>
> On Thu, Aug 6, 2020 at 8:05 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On 8/5/20 3:43 PM, Mike Palmiotto wrote:
> >
> > > Commit bc2a8f418e3b ("libselinux: add selinux_status_* interfaces for
> > > /selinux/status") introduced the sestatus mechanism, which allows for
> > > mmap()'ing of the kernel status page as a replacement for avc_netlink.
> > >
> > > The mechanism was initially intended for userspace object managers that
> > > were calculating access decisions within their application and did not
> > > rely on the libselinux AVC implementation. In order to properly make use
> > > of sestatus within avc_has_perm(), the status mechanism needs to
> > > properly set avc internals during status events; else, avc_enforcing is
> > > never updated upon sestatus changes.
> > >
> > > This commit gets rid of the default avc_netlink_open() in
> > > avc_init_internal(), replacing it with selinux_status_open(). In the
> > > event that the kernel status page cannot be mapped, the netlink fallback
> > > will be used. By default, avc_has_perm_noaudit() and
> > > selinux_check_access() will now attempt to read the kernel status page,
> > > which removes a system call from two critical code paths.
> > >
> > > Since the AVC thread create/stop callbacks were intended to avoid a
> > > system call in the critical code path, they no longer need to be created
> > > by default. In the event that the kernel status page is successfully
> > > mapped, threads will not be created. Threads will still be
> > > created/stopped for the sestatus fallback codepaths.
> > >
> > > Userspace object managers that still need a netlink socket can call
> > > avc_netlink_acquire_fd() to open and/or obtain one.
> > >
> > > Update the manpage to reflect the new avc_netlink_acquire_fd()
> > > functionality.
> > >
> > > Signed-off-by: Mike Palmiotto <mike.palmiotto@crunchydata.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Applied.

I think in `libselinux/src/sestatus.c` the static variable
`last_policyload` does not get updated during `selinux_status_open()`.

This leads to policyload-callbacks getting called if the first change
to the status page is an enforcing change.

Reproducible with trailed test binary:
Running the binary and during its runtime changing the enforcing
status via setenforce 0/1 triggers the policyload callback:

> ./test_selinux_status &
[1] 4091
selinux_status_updated returned 0
selinux_status_updated returned 0
> setenforce 0
selinux_status_updated returned 0
uavc:  received setenforce notice (enforcing=0)
setenforce_cb(0)
uavc:  received policyload notice (seqno=4)
policyload_cb(4)
selinux_status_updated returned 1
selinux_status_updated returned 0
> setenforce 1
selinux_status_updated returned 0
uavc:  received setenforce notice (enforcing=1)
setenforce_cb(1)
selinux_status_updated returned 1
selinux_status_updated returned 0
selinux_status_updated returned 0
selinux_status_updated returned 0
[1]+  Done                    ./test_selinux_status


<<<< test binary >>>>
#include <stdio.h>
#include <unistd.h>

#include <selinux/avc.h>

int policyload_cb(int seqno) {
        printf("policyload_cb(%d)\n", seqno);

        return 0;
}

int setenforce_cb(int enforcing) {
        printf("setenforce_cb(%d)\n", enforcing);

        return 0;
}

int main(void) {
        int r;

        r = selinux_status_open(0);
        if (r < 0) {
                fprintf(stderr, "Failed to open SELinux status page: %m\n");
                return EXIT_FAILURE;
        }

        selinux_set_callback(SELINUX_CB_POLICYLOAD, (union
selinux_callback) policyload_cb);
        selinux_set_callback(SELINUX_CB_SETENFORCE, (union
selinux_callback) setenforce_cb);

        for (int i = 0; i < 10; ++i) {
                sleep(1);

                r = selinux_status_updated();
                printf("selinux_status_updated returned %d\n", r);
        }

        selinux_status_close();

        return EXIT_SUCCESS;
}
