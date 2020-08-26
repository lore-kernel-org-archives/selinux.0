Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5917C433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0923208E4
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 13:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qC5TAQSD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgHZNvj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgHZNvi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 09:51:38 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56023C061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:51:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a21so2991003ejp.0
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YURiogtuNe91tnu17U+XQYmhBceQmwu9ofO2tRN7fvE=;
        b=qC5TAQSDFBiIHcVKOXPKlAoy+bf1/3JLzk3HZ6/NdFNxOjLRy0KKYeHLXvsj5IeYUQ
         U5NzV980vRMbz53wFpa3Jq3hq/++KTwYFarJEAyrwytXjq5M+4l2Jox4tedNJQtpzXf9
         6VYdQA974RUHiSzqIJ6ZSoF6X+bEZ56sqQZ+BGBGlHTTsXAGaXQdFpvxa3tFantZLc9Z
         eUqRzzaC7FHw3Q5TB01Fs0nX1nna7BZiqlfdo514RvIceIGvzh/xN18R7feYtAds7bp7
         6TgGnys3yw+uJDcez7KI+FI1YvMOAgTy+CHNuu7kuxXC1SSrGdRB4Xd2bEmvX+dt27yj
         PtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YURiogtuNe91tnu17U+XQYmhBceQmwu9ofO2tRN7fvE=;
        b=HUAeC4xyw1vOdG3ioE1uB1E7BTyeMqptNzXc+aCZVQXvdE09BTfux712yr4Qd/Xir3
         0EYTdFl0IpEzIf7WmOTVbd7PpnlBeqtVXfO4c8vyeBtBzberJpIBf4MSDe6GzBf0+Suy
         F8Rw1j892rGrwIDDOyH0AO6RAciUrhJgYxFQqwDqb5o6JFDsI/A85oW+OoOKUVazraob
         E3Yy3tiPk4MYOcTfsdWWo35PdMVBsKl+sSYgPsjGVchCJEHdw6LcSl/StyjMlEwJ53UG
         FzcgbggVKTJoQJ0o053h1EIDuQDpPqcHyrqI0kMAogAc7vy9YZiIHMZPMZoU4S/Cnber
         zLGg==
X-Gm-Message-State: AOAM531R4mQ0ejG69oXH9uoD60AvQ37vpJu4acSrti0oqTGb8Xyj8iB/
        wSgX2vFRCfzcr4HL5l9TzpFABxhdWUb/gPNcnPtv
X-Google-Smtp-Source: ABdhPJx+e6OvYWb9dl1fzmgtAo9YoBcTtbz9K/Tyeti7N8O7DQfKLB4y3jmuxWVn7s7DZFnsgKAo9WLe7mu9cWvSnNk=
X-Received: by 2002:a17:906:7c46:: with SMTP id g6mr15360582ejp.178.1598449895827;
 Wed, 26 Aug 2020 06:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200825065953.1566718-1-omosnace@redhat.com> <20200825065953.1566718-2-omosnace@redhat.com>
 <CAEjxPJ4JKHKFgF9VobJTrMBDhaqC0EKorC=qfm=t77Krd-Npsw@mail.gmail.com>
 <CAFqZXNtOd7VXQWh9B3fnmY0MUy0HLHh75u_=6UE7UaTO2ZjYSw@mail.gmail.com> <CAEjxPJ7_zk63cyHEPeyrhPgDRJ_jzzx8kyQACvWiNoC3-KzLsA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7_zk63cyHEPeyrhPgDRJ_jzzx8kyQACvWiNoC3-KzLsA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Aug 2020 09:51:24 -0400
Message-ID: <CAHC9VhSBsTU++65fPqZvdvdT_Ja+zaj-toUSa6iVLBCt8vQOBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 9:02 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Generally the core SELinux permission checking code assumes it can be
> called from any context (including hardirq) and under any locking
> conditions, and hooks that are for permission checking (not security
> blob allocation/management) do the same.  This allows permission
> checks to be performed while locks are held by the caller. and from
> arbitrary contexts  I'd be inclined to just leave selinux_lockdown
> unchanged given that it might be called anywhere much like capable().

Agreed.  The code paths relating to policy load, etc. are good
candidates for an ATOMIC->KERNEL conversion, assuming no other
constraints, but I'm somewhat nervous of converting stuff in hook.c
that doesn't have a hard sleep-ability defined.

The other question about this patchset is motivation: were you seeing
problem reports relating to SELinux memory failures when the system
was under pressure, or is this preemptive?

--
paul moore
www.paul-moore.com
