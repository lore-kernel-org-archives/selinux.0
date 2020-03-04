Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA80DC3F2D1
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CC42166E
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sf7qMhWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgCDOZX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:25:23 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34464 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDOZX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 09:25:23 -0500
Received: by mail-ot1-f65.google.com with SMTP id j16so2185453otl.1
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 06:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zF1tVp7S64dPGBhP27WH9RfXCyBz8Cmiv5vl45Cb4Sk=;
        b=sf7qMhWyaXCbCyD2iZhguyXPRvT0jImDNbGviSYU1kv6efLM1N9wvv3GvJ39jvUoFP
         kTKvZj7+y8Xdb9EOcnwlgoZRlqcRGX0sYlJpsbfwvA1XWkRz1et3xarJOr8cCO3uzuFz
         9Hr9R+YQh/PacDeU8tmNTxv9vIu4pzoo5Q0hEwaejvEP3r3Qswq3cuSzUSgFwseiT+fA
         FyMs3Gm0reek+R/9gQRuCCTx8ZwITDaeSVdnA45aebGO0rvg/YzgffZB/XKukhexMpkN
         kvJBX9E6rZX9qLkMy4kkdVtGbSxZxERpK0XZK+r35wYOnrwN1E66JQnd0bnH5STz3hUn
         PgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zF1tVp7S64dPGBhP27WH9RfXCyBz8Cmiv5vl45Cb4Sk=;
        b=uaNfdMTaX1Pj5xThhlbpM/t9xucgZ9/mMI55JhfWHgpKL5Yujy+5VlR0PsmTzI9SEK
         4XvV3VXsuyjvjKj7W+bJVm6PM3JroVzbuCFRDKauYg/XhESJZFbmQ224+TsD+iyQr5Uf
         OGweteZnpK/4Bt7y5eV81tpw+tx264KIY+ToEr2c2J75i/P0bxT+34lv6amkBYoO/6gq
         bNXYzQhca+go4oXdmlTHqDouGNu1sIBNS4hoJucAMwhQ3iO51si5gWeLFyvQIOMg0IQ3
         Z3hFwnZyMNJAsPSeuwiFDH6iFNvTbOOgOzP5QFT5m9EWCjlAFtt6P5FDlIJ5k/2wj8sJ
         V6Mw==
X-Gm-Message-State: ANhLgQ3Qs/W/GKySBrYsFHvMMbIEbT6H3xcl9aOEqvVIN7cYuDtLUDSV
        gT7M2LmbKmppZombF5aDFkoS2DYQXBACowRl5U4=
X-Google-Smtp-Source: ADFU+vtF6h+LCZqtDMExNSb1T+VFEDA++qQAPEQ0RQnN+iK6Zk4/zlN2TYqB+lSciojrs/uS/tNgRm1yVcxQXpilKho=
X-Received: by 2002:a05:6830:22f2:: with SMTP id t18mr2643460otc.165.1583331922500;
 Wed, 04 Mar 2020 06:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAEjxPJ76uFc62tPhH_2FLN58kwh_7kbA356QzDR8T-gogGiW=w@mail.gmail.com>
 <CAEjxPJ4rjrtgDSZh163oNrXf3uX0uo+rNzreZ7M7py7MOwN8gw@mail.gmail.com>
 <CAEjxPJ7mEu2E76Z=nVvZLtpFr6kDz449F+XCuO=RdUjScz3auw@mail.gmail.com>
 <CAFqZXNt477qLVy-5B+MRy_Bvw5fqLWMeOFQDfkGfXD_i=SYghQ@mail.gmail.com>
 <CAEjxPJ66CZL6-+KbRKwicYuj50uvcTjr-O81LC+BhQGO-jaKew@mail.gmail.com>
 <CAEjxPJ5VMy5aRX_2_OB_4gwDmKAve+TMu-BJeSmqsWmM-PxRCg@mail.gmail.com>
 <CAFqZXNub7i2OyqWqU2snePw+XBfJxauh-0n2zgZy_q58sZovSw@mail.gmail.com> <CAFqZXNunTQfLAc7JAfZyvynPS0s=ADK0fbT1rXrcUCsMiDk9HA@mail.gmail.com>
In-Reply-To: <CAFqZXNunTQfLAc7JAfZyvynPS0s=ADK0fbT1rXrcUCsMiDk9HA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 4 Mar 2020 09:26:34 -0500
Message-ID: <CAEjxPJ5-nzostsGnca1OcVT9hm6XWP9F1ceFCU3--RAzLHXERQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 4:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> I played with this a bit by recompiling the local binary policy with
> secilc and then comparing the CIL of both binary policies (I used this
> script [1]) and the results are a bit confusing... There is no
> difference in result between -X 0 and -X 1 [2] and in both cases it
> removes some unused attributes (those are only referenced from
> neverallow rules) that were in the original policy
> (/etc/selinux/targeted/policy/policy.31 from my Fedora 31 machine),
> but not in the one recompiled via checkpolicy -C + secilc... At least
> I was able to confirm that secilc -X 2 really removes the attributes
> that have only one type and reduces the policy size by a few
> kilobytes.
>
> I suspect that the reason for the unremoved attributes in the policy
> built by semodule are due to a bug in libsepol: It seems that when it
> starts with a cildb that has the neverallow rules in the input policy
> + has disable_neverallow set, it removes the rules but not the
> attributes that are used only in them. Only when it reads the policy
> again, it identifies these unused attributes (since there are no
> longer any neverallow rules in the input) and removes them
> unconditionally. It could be something else, but if I'm right then I
> think libsepol should be fixed to remove the unused attributes right
> away. I don't dare digging into the CIL code to investigate it, though
> ;)

James will have to confirm the details but IIRC we had to keep
attributes in the policy
when they are referenced by a neverallow in order to avoid breaking
Android because
it uses the attribute definition from the policy as part of CTS
validation of OEM policies
(it extracts the neverallows from the AOSP policy, extracts the binary
policy from the device,
and checks the neverallows against the device policy).

>
> [1] https://gitlab.com/omos/selinux-misc/-/blob/master/diffexpand.sh
> [2] Okay, this part is not really confusing, sonce semodule should
> already build the policy with an equivalent of -X 1, so -X 0 should
> yield the same result.
