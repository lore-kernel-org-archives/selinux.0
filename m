Return-Path: <SRS0=s7s9=A3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146CEC433E2
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 12:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B8720760
	for <selinux@archiver.kernel.org>; Thu, 16 Jul 2020 12:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYgfVHlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgGPMkC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgGPMkB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jul 2020 08:40:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E303AC061755
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 05:40:00 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 12so4953740oir.4
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2020 05:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sa1orWR3vwTtEWAZQ8tkyD7wOWV2AXF2XDsbG8owGs0=;
        b=gYgfVHlc5f44AryKBgeF0H2JIjG/ZndYgpbpxLtx4xV7uwIxik59Ev/gD+RXb6P2+s
         r6LXyB5hxGcbXGRcq8nPDisExDaWxYGSaPeQRYWQVj0inXIfIXHYI48Ns4VhnDWF9cxG
         S1/RYTnRwSTVLrGFe8qL8O9bGpS6jcgnZYjqGsqJRPSknfopJNBmmkiFlxZkLYLiKSxJ
         K7E2xx3p61MMBVwJ6/RfE47hpkB9sCabthc341BE5affPICGGYTblS4Pfha6nP/LAOb0
         fyxXCpcGP+c3Y/VCELefAOtCnj9DZNLv8tUqMsWlVuQUZY/JT+g434WptHKC6EDcSba2
         yEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sa1orWR3vwTtEWAZQ8tkyD7wOWV2AXF2XDsbG8owGs0=;
        b=LiMjAXW6Q4ojbaLC4+8HSBlet0ac7z7gfxa/E8xHW8VQQdT8CHzehoeK1C0BtABtGY
         9ykHyzrjLbQVpIm2Nw3y22V6xh+Up95rF4lOm+B74VWF9ZF0faqDhQzujpiDlgqBu63I
         DJpAMyCS3H3X2yOyahEEG4CuM0xKS99a7AuBC0PBbqLL6NB1DCr9aeCL4jmWP3nCNPp8
         /lGFYMoVYqHRsRsmFB3JVrGfkpocic7mNNbwnJpaw8G/OjZnhNqqwVIL6MfY5hlfb/QS
         fbBHTOR26ibmnTxOxTzgcMWutNc2oJXUrboh+K33Tqo01kuuAP7UmkD821PiIh3IkuN/
         gWZA==
X-Gm-Message-State: AOAM530q82JHAm9Me0Qw/8peG2YxcHY8PiBRZ1CSHrLAfVT+IRe2NSEa
        WF+4xqKa1m0jvO0malGxlhGMbTmO5AO5CLXrSgYKlQ==
X-Google-Smtp-Source: ABdhPJy4tCUSprIRdsYHh7krOoFnbkxbkvEhxHiQ3bjgbjHRY+fHgGtUmI/JDEG3ZZZSCmAZyYhtjdYx4X338Ci/syc=
X-Received: by 2002:aca:2807:: with SMTP id 7mr3673967oix.140.1594903200326;
 Thu, 16 Jul 2020 05:40:00 -0700 (PDT)
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
 <CAEjxPJ5RGYQi4A7nD8b=tKv2OdC7f8wfMiwprApOCNADEi-ahg@mail.gmail.com> <CAMN686H=3RY-E1a01fWPY9QqGpUABVxJmQGrx00c53JrMVswZA@mail.gmail.com>
In-Reply-To: <CAMN686H=3RY-E1a01fWPY9QqGpUABVxJmQGrx00c53JrMVswZA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 16 Jul 2020 08:39:49 -0400
Message-ID: <CAEjxPJ6PQe0WPOA-LjNbfhRfDP7=dJ7N0aisCu9Y=WSHC7HXGA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Use sestatus if open
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 15, 2020 at 6:45 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
> Interestingly, the test program is working fine:
> https://github.com/mpalmi/selinux/tree/sestatus
> https://github.com/mpalmi/sestatus-test
>
> On a test run, I'm seeing both the status page and netlink socket
> notifications for load_polcy (twice for each case):
>
> ```
>  ./test
> opened avc successfully
> got netlink socket: 4
>
> watching netlink socket for events
> avc:  received policyload notice (seqno=3)
> policy reload notice received
> avc:  received policyload notice (seqno=4)
> policy reload notice received
> ^C
> watching sestatus page for events
> avc:  received policyload notice (seqno=5)
> policy reload notice received
> avc:  received policyload notice (seqno=6)
> policy reload notice received
> ^Cclosing netlink socket: 4
> destroying avc
> goodbye
> ```
>
> Still seeing the MAC_POLICY_LOAD audit message, but none of the usual
> USER_AVC policyload notices.

I only see one notification per load_policy invocation.  What versions
of kernel and dbus are you using?  Are you using dbus-daemon or
dbus-broker?  How are you testing dbus with this change - just doing a
make install relabel of libselinux and restarting dbus-daemon or
dbus-broker, then running load_policy and checking for USER_AVC
messages?  Is this on CentOS 7/8?
