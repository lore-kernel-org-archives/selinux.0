Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EA4C3F2CD
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 15:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E52C21739
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 15:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRQxkxgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCDPcC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:32:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41566 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCDPcC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 10:32:02 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so2460445oie.8
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 07:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQPhqPIL+jDftvR+xFm9CsZjlFdK8WlxHbgS5N2Ubvk=;
        b=DRQxkxgAynPSUn3qszNSFRM2PJwYTB2Pl5p+rEy+BubcFfFzddQkABxEHhjQ0lSAHA
         9e63qu5tVtDBWGty1HaS9brh6qRD+UsKF3nZUcDw3u8QPhOG22rG5jtVCK5o5zJgcggI
         TJqMJzN0iLSqZsKzm5CzLkXG/TN7w9tYdNTIMDw7qoyel2BPLIhYRX0+dHsiTcp8fupo
         rYPQWsJVzpPmxsNqbYEx3pCeXHwPJuGOv3DuKA4tT6u7w15neKvoLivT0uDXZTBol30T
         1jaViuLzWqsyu9E0Pqvzob6zpY1iMMM8WucD4yC4rfsEgiDd0unLAHu4s6xEpDbahfuR
         dBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQPhqPIL+jDftvR+xFm9CsZjlFdK8WlxHbgS5N2Ubvk=;
        b=ffuiNrVdvbImYhjkAjxKRcR3PafYnXZIcPXOB6lG4ZGWPeNT2LFt/DwGqkHZK+Wgou
         CpXmwOtMkqiyicMXsguVM+21/FmVElARlOkxLqEpkyzNwd15o/hEpZvG+cfWAX58NGN6
         hxaRBWFDA3lTAwq6nji2FfXXEiHqrhIEUKvUTCYL3+oTQBkxtdCAAs4DVWZjyBm+k14A
         Cq6BTV/m/lCtyd0dfJf8FE1BuStRuW7e9gHGMCbtwDD6j/3xfLtNMeuF2KD82lI3EU0g
         n4+Y4FHvatik9SjeH+TvdvDf+HoeW7f+yY+511adx4FId+yXeS+pHZ473ZGSFC8TIBRT
         zMVQ==
X-Gm-Message-State: ANhLgQ0UdedYnMInVxPdN83iDMshTWvpfc7b9mEs4ifC7bTZeswkvkg2
        0iyUFaeku3eVxNv76bbhydemco2WD+Gw3+h2Fbw=
X-Google-Smtp-Source: ADFU+vsuscBU3a8bL8gJWyeOYrvTdpmJx6ST8XjINX72NT7OjgHguuY8+q4uktvx6wU4XT+jByYGTuwQ8Yf0uwKwzy4=
X-Received: by 2002:a05:6808:8ee:: with SMTP id d14mr2017360oic.138.1583335921535;
 Wed, 04 Mar 2020 07:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
 <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
 <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com>
 <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com>
 <CAEjxPJ66CZL6-+KbRKwicYuj50uvcTjr-O81LC+BhQGO-jaKew@mail.gmail.com>
 <CAEjxPJ5VMy5aRX_2_OB_4gwDmKAve+TMu-BJeSmqsWmM-PxRCg@mail.gmail.com>
 <CAFqZXNub7i2OyqWqU2snePw+XBfJxauh-0n2zgZy_q58sZovSw@mail.gmail.com>
 <CAFqZXNunTQfLAc7JAfZyvynPS0s=ADK0fbT1rXrcUCsMiDk9HA@mail.gmail.com> <CAEjxPJ5-nzostsGnca1OcVT9hm6XWP9F1ceFCU3--RAzLHXERQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5-nzostsGnca1OcVT9hm6XWP9F1ceFCU3--RAzLHXERQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 4 Mar 2020 10:33:26 -0500
Message-ID: <CAP+JOzR4YKKaNw8FwF85OJfSny40tRWVu8iEJsmEx41-nHF9aQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 9:25 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Mar 4, 2020 at 4:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > I played with this a bit by recompiling the local binary policy with
> > secilc and then comparing the CIL of both binary policies (I used this
> > script [1]) and the results are a bit confusing... There is no
> > difference in result between -X 0 and -X 1 [2] and in both cases it
> > removes some unused attributes (those are only referenced from
> > neverallow rules) that were in the original policy
> > (/etc/selinux/targeted/policy/policy.31 from my Fedora 31 machine),
> > but not in the one recompiled via checkpolicy -C + secilc... At least
> > I was able to confirm that secilc -X 2 really removes the attributes
> > that have only one type and reduces the policy size by a few
> > kilobytes.
> >
> > I suspect that the reason for the unremoved attributes in the policy
> > built by semodule are due to a bug in libsepol: It seems that when it
> > starts with a cildb that has the neverallow rules in the input policy
> > + has disable_neverallow set, it removes the rules but not the
> > attributes that are used only in them. Only when it reads the policy
> > again, it identifies these unused attributes (since there are no
> > longer any neverallow rules in the input) and removes them
> > unconditionally. It could be something else, but if I'm right then I
> > think libsepol should be fixed to remove the unused attributes right
> > away. I don't dare digging into the CIL code to investigate it, though
> > ;)
>
> James will have to confirm the details but IIRC we had to keep
> attributes in the policy
> when they are referenced by a neverallow in order to avoid breaking
> Android because
> it uses the attribute definition from the policy as part of CTS
> validation of OEM policies
> (it extracts the neverallows from the AOSP policy, extracts the binary
> policy from the device,
> and checks the neverallows against the device policy).
>

Steve is correct, we keep attributes that appear in neverallow rules
to avoid breaking Android. We also keep attributes that appear in
typeattributesets for attributes that appear in neverallow rules.

See commits 67b410e80f0917bf1b378997cac0dddf1e6406f7 (libsepol/cil:
Keep attributes used by generated attributes in neverallow rules) and
0be23c3f15fdbef35a57d8586aeeae9b1f7606cc (libsepol/cil: Add ability to
expand some attributes in binary policy) for more details.

Jim
