Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56491C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 17:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5B920756
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 17:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="c1qCcImm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgEVRRt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 13:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730801AbgEVRRt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 13:17:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B5EC061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 10:17:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a2so13815819ejb.10
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZxRPiGwCgbqhUu92r6A+mGvTi0VjpXxbv87h1M71os=;
        b=c1qCcImmM3M9z0zf5rTn00/xqq6nzCW3XdsuwqQoHZsQUQ/2p50gIWJ+kJZPVwWGR3
         hOO/8tHWSNT4UsfWyyGNKx4E7GNLTWXg7xqa48OBiuR+O6URUtOugL2W/qO18Pfm80by
         nTzy19Vcb+nEOfamGR3VeElhflMXsC/Q7PU3ttOq4b76T0og1CLJG6kYmD7ZiqLNXHN1
         lzsTt8s4GW5KySUcFqrBBP0m3BGDj1MP0VKkS+CBlHFRfj25RvlnKUdGrHnm5dnW+RhR
         EVxqYz/KTdgA4XNyvlHoTty+JRAwx3VxDKcuSwB7KjjBBzdoFNej5rep/JOqmbCZBh7N
         eMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZxRPiGwCgbqhUu92r6A+mGvTi0VjpXxbv87h1M71os=;
        b=dnGQutImVUG9CWto9uB6mp+EyiMcyXiWDO2OSeXUdGtkzaDMszL1MzOMdTUywWGveN
         aSPTiSbWsnElnyUR0ItcO89fbNWdqLi15V6sbr1yLIg5kOPxtpGwuYsS7u6FDSy3UJZt
         OD0z0f6fzVYDuuUAUrw2OUVCM4YhNVulT7ts6ZCmg1prCb8mtz9PBaxEpB38VVj1aTfx
         wiuDBg6NWP6Fbsd+Jd/ShmK9HCcxdtscVMzCrWPxo5o0vwiLyWTtEf8uFtohnYeOIBCb
         6k5bhAF+K5IBK2smM5ptb7NwZp9UMrHXezMMDfCieNqJ+pEp30RBbnLzb7vpX2DPnOS9
         ZvNg==
X-Gm-Message-State: AOAM533qm08LAyB5TsAMxZK8dwCURhSyiP6FMP9ZEpCwjFoSkWTXLECY
        8Cw9Hit9yprH+fHyOaPlyLVb9IxRDrJtR3em46SJW7D/Iw==
X-Google-Smtp-Source: ABdhPJwesZJCtNI+0HsS4AFL0OHWloM1UBE9HS8CfYG4h2N6ZNO45rkrNaaHccPv73SZuPLm1dP+gO1YF65YVYp5BhY=
X-Received: by 2002:a17:906:4d82:: with SMTP id s2mr8799968eju.542.1590167866246;
 Fri, 22 May 2020 10:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200520165322.GA225268@nyx> <CAHC9VhQUYVmsXgXUqi6CUa2Np68-PajDkzd7BsDGk7kxLz+Uiw@mail.gmail.com>
 <20200521171627.GA326433@nyx>
In-Reply-To: <20200521171627.GA326433@nyx>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 May 2020 13:17:35 -0400
Message-ID: <CAHC9VhSpjCYvqovK+PsNxqTkgxdXs2kQkF5-7Qk7_FY+Zn78dg@mail.gmail.com>
Subject: Re: Documentation on Enabling NetLabel
To:     Paul Tagliamonte <paultag@debian.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 21, 2020 at 1:16 PM Paul Tagliamonte <paultag@debian.org> wrote:
> On Wed, May 20, 2020 at 02:39:49PM -0400, Paul Moore wrote:
> > Presumably it works when you are in permissive mode but fails when you
> > are in enforcing mode, or does it fail in permissive too?
>
> That's correct, everything seems A-OK in permissive mode, and starts to
> get denied (likely correctly) in enforcing mode.
>
> > If it works in permissive mode but you aren't seeing any AVC failures,
> > you may want to try removing the dontaudit rules from the policy.  You
> > can do that via 'semodule -DB' (the semodule(8) manpage has some
> > examples).
>
> Just tried that, thank you for the suggestion! I don't see any
> additional logging, but I'm going to follow up more comprehensively
> after reading the documentation. I'll give this a stronger go tonight.

Okay, let us know what you find out.  I'm a little concerned that you
didn't see any additional AVC denials in the logs; if the system is
working in permissive and you're not seeing any denials with the
dontaudits removed something is off.

> > You may find that in the near term you need something like Fedora's
> > unlabelednet policy module which blanket allows unlabeled network
> > traffic to all the domains on the system.
>
> Ah! This makes _so much_ sense. I was wondering where rules defining
> this behavior lived. Looks like it's a (very comprenstive?) RH specific
> changeset that we don't carry in Debian. I've got some work cut out for
> me from the looks of it.

The basic idea is that you have some type attribute which represents
all the domains on the system and you grant that attribute the ability
to talk to unlabeled traffic.  Perhaps the Fedora patch might not be a
direct fit, but I imagine you could do something very similar for
Debian without too much difficulty (warning: I'm saying this without
looking at the Debian policy).

However, it is worth mentioning again that this approach allows
unlabeled traffic *everywhere* and isn't really suitable for a system
in a proper labeled network (it somewhat defeats the purpose of
setting up labeling in the first place).

> I started to graft sections I thought were relevent from policy-rhel-7.2-base.patch
> into my local policies, but I think I'm super in over my head. This is
> likely going to take me some time to work through, but it's monumentally
> helpful. I was only looking at the upstream rules and our package, which
> explains why I was missing a lot of this.
>
> I assume since this is being maintained by a lot of folks working
> upstream too which makes me suspect this is a WONTFIX situation
> with the upstream rules. Seems like I ought to tread lightly here.

I'm not sure I would jump to the same conclusion.  First the RHEL 7.x
policy, like RHEL 7.x in general, is quite old; second, while we do
regularly perform some basic labeled networking tests as part of the
SELinux test suite, it definitely doesn't get the same level of
everyday testing that other parts of SELinux receive.

If you hit a problem you can't solve don't be afraid to speak up.
Either it's something in your policy we can (hopefully) help you
resolve, or it's a real bug in the system that we can (hopefully) get
fixed for everyone.

> > It's not clear which interface you sniffed, was it the loopback
> > interface?
>
> I was sniffing from the VM Host (a laptop) to see what was coming in/out
> of the network when I tried to initiate an SSH connection from the LAN
> to the VM, since that *should* be unlabeled and pass through (although
> given the bit above about the default unlabeled rules, it's likely
> getting filtered out).

Depending on the age of the kernel on your host, there *may* be issues
with it passing CIPSO traffic properly, even if it isn't configured
(there were bugs in older kernels that have since been fixed).
However, since you're not sending CIPSO traffic outside the guest this
shouldn't be an issue.

> I was trying to minimally set up labeling for localhost (without
> impacting the LAN NIC) to make a baby step in enabling NetLabel with
> enforcement on, and still allowing network I/O except where I was
> placing specific rules in place.

If you want to take even smaller steps, you can combine the NetLabel
domain and address selectors such that only specific apps/domains will
send labeled traffic over loopback.

* https://www.paul-moore.com/blog/d/2009/02/netlabel_address_selectors.html

-- 
paul moore
www.paul-moore.com
