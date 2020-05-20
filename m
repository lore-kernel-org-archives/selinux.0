Return-Path: <SRS0=Lh2G=7C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75CFC433DF
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A242072C
	for <selinux@archiver.kernel.org>; Wed, 20 May 2020 18:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LaJSBN7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETSkD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 May 2020 14:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETSkC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 May 2020 14:40:02 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD6C061A0E
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 11:40:02 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j21so5353634ejy.1
        for <selinux@vger.kernel.org>; Wed, 20 May 2020 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAK2B7NyCUGtoWTQIVUIAh012PEpr0kw6tOaYreqnH0=;
        b=LaJSBN7gG4EewdAtxT/aVX5IbUvnR9oDKzIX6JK4WseGFQCtrecIqKV/TJ5kmyCxt8
         zBwLIkK/nLcTc56XEOTx0kpVGkphqdacIDGP1t3PGXN08xUZQ8qP8iLjLkAdH9G1vWRB
         lXoW88ynqQM6li0dXT+vIysKWbN5NGzsGAMqZN4m8pCETeKMu082mop8V8FghJ7n4sx2
         FWDFzeXrK6RxpyJtWaXPHUyHVh5/AA3mQYh1FQSOKzMSEuY+0zX+YySbCgL4KCRtdwY7
         7PJZVzjxl6DixY24JyyYx5ROMOM8OYjGO/LYvWWljLZSDywMbasfzLPPFOBBOJEq2rqr
         LHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAK2B7NyCUGtoWTQIVUIAh012PEpr0kw6tOaYreqnH0=;
        b=ZJ6vyDBiisWC7PBJXbXJMlMF+syggypQ+FV3qfNrGAlL1l36ZifnEGEqYRIT0FY0Y7
         UtHLZFi1iM+37uxMQ4e/GaTkFIMzMkc2vKRQyqpKq0mSXfwqMUEmiZBB5ENISP3LSWgz
         yHESCDthrVGwgFbn7cYMcdVkUPmSVZrh6v/eYhfpI2QH5vM6L7pqQ9gB1NsbQVz48TtH
         RyMFEBdoy4hN3j4lJt7rmkVBUtdfvmZS9OuBQahy5HqKbbYycPbdSG2obBGppohwe/67
         p9kojCL9jzWNzn+23lA+iDfO9Xv/kgFH99EljQUD795bQJKrYRXMZszYqHTpLkjtP7Bt
         Qwhg==
X-Gm-Message-State: AOAM531ImmTnXZTO2h3/h+IgRjKvp5msOAyBg6PkCqlktnskoNZ0XJ7Z
        7Dt3IInFBQgCVNdByboMQEtAftlpz3wgGOPOw9//
X-Google-Smtp-Source: ABdhPJyvAx9NsSjZ3WgdfwbBIL4V+WCsmOGvHuI5668cq4oG4eRjfnwnLWupRJFuwMI+yy2x1HfnJ5a5JDQ7jD44Rdo=
X-Received: by 2002:a17:907:40f1:: with SMTP id no1mr410540ejb.178.1590000000759;
 Wed, 20 May 2020 11:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200520165322.GA225268@nyx>
In-Reply-To: <20200520165322.GA225268@nyx>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 May 2020 14:39:49 -0400
Message-ID: <CAHC9VhQUYVmsXgXUqi6CUa2Np68-PajDkzd7BsDGk7kxLz+Uiw@mail.gmail.com>
Subject: Re: Documentation on Enabling NetLabel
To:     Paul Tagliamonte <paultag@debian.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 20, 2020 at 12:53 PM Paul Tagliamonte <paultag@debian.org> wrote:
> Hey SELinux folks,
>
> Sorry for the second email in no time, but I'm a bit stuck and could use
> some pointers to continue my quest to get NetLabel working on a Debian
> VM, and send patches to make it easier for others in the future :)
>
> I have SELinux and MLS working (even to some degree whilst enforcing!)
> in a VM, generally speaking. I can ssh in and do normal things. The
> rules need a bit more love, but it's in a fine state that I'm happy
> working from.
>
> I've been able to set up NetLabel to attach a security connect to
> connections (nice!) that show up when querying the peer context, but switching
> from permissive to `1` results in dropped traffic.
>
> I'm sure this is likely the result of (correct!) filtering going on, and
> because it's now gone from no context to a context, traffic is likely
> getting filtered out. I don't see anything in audit2why in permissive
> mode, but I also don't know if invalid network activity is logged.

Presumably it works when you are in permissive mode but fails when you
are in enforcing mode, or does it fail in permissive too?

If it works in permissive mode but you aren't seeing any AVC failures,
you may want to try removing the dontaudit rules from the policy.  You
can do that via 'semodule -DB' (the semodule(8) manpage has some
examples).

You may find that in the near term you need something like Fedora's
unlabelednet policy module which blanket allows unlabeled network
traffic to all the domains on the system.

> I've tried tcpdump on the host, to no avail. I see packets going in, and
> not much coming out. I've kept the kernel on the VM host on a version that
> doesn't have NETLABEL enabled, in an effort to not have the host kernel get
> in the way.
>
> Specifically, I've tried:
>
> ```
> netlabelctl cipsov4 add local doi:2
> netlabelctl unlbl accept on
>
> netlabelctl map del default
> netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
> netlabelctl map add default address:::/0 protocol:unlbl
> netlabelctl map add default address:10.128.0.0/24 protocol:unlbl
> netlabelctl map add default address:127.0.0.1 protocol:cipsov4,2
> ```

It's not clear which interface you sniffed, was it the loopback
interface?  That is the only interface which should be doing any
explicit labeling; if you see CIPSO IP options on non-loopback
interfaces something is wrong.  I would also expect you to see CIPSO
options on the loopback traffic, do you?

As an aside, Wireshark does know how to parse CIPSO options so you
should be able to peek at them that way; although Wireshark does not
know about the "local" tag type we use on loopback (... and it
shouldn't, it's a horrible abuse of CIPSO, done intentionally <g>).

> On localhost, I can't connect to any running daemons (such as SSH), and
> I've specifically not added the NIC that is bridged to my LAN (in a maybe
> misguided attempt to keep traffic from the LAN unmarked) to any netlabel
> rules. I was also unable to connect to the OpenSSH server via the
> network IP either.

Try removing the dontaudit rules (above) and see if that helps with
the AVCs.  Let us know what you find.

> When enforcing without running the above netlabel commands, I can ssh into the
> box successfully.
>
> Thanks for any help anyone can provide, and thank you all very much for
> being so helpful for my last question!

-- 
paul moore
www.paul-moore.com
