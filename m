Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD90C3F2D2
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BFB2469D
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 15:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uot/Q4X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgB1PiU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:38:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46757 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgB1PiU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 10:38:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id g96so2897965otb.13
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 07:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wx9lHaLHMZ44HhfbWChrcl7nqLMJv2rru1ajO5dQYOw=;
        b=uot/Q4X97V85pdkU8ioDE2qh1TKvABwhF5dh7ixx/qfPnBDxrEItCaDuH616JTfIs3
         JrBpY9HLg7GfaTcfueln651iHWjH/ZlSi2UmGmzk4TT03Adn88GjT2sVLP5X0hnNbOdL
         8RjxW4F8P05v+uYD792xqlAxsNpzMxB/k+0Xhm0Outjyx683Adt2JoOkHtBwGgwfVFD6
         lz7bpzNtFEaveYTeEDgFPXCU5FyMrmTqRia1kPePYjMrR67NQlDmzw22ClvtDKsKCPXB
         haeU1m5YxsxztorBksQOoZco8JAKAkAF0St1JGtqpyOanMQFIXI53ajOq9IaW96H9sA0
         vX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wx9lHaLHMZ44HhfbWChrcl7nqLMJv2rru1ajO5dQYOw=;
        b=jajLrQowF+O++Nl5KVFDWtMBiWhr3aPg8jjNOQkUH6DfkMS1ztP6NLTAO0OXftrkvP
         gvytg0TpvryD5kuIJrugH+WVSTwPMob/LR93ghPxsx6N3dfBlTZZWJU00WcM1SsJlML8
         tQ6A8mBnaKXdx4lBADVeAloJXKDpMfDPxY37E9XNMxNxIEpcqoWJne1aPpbzjuC3eJ9j
         6lEBuHbO+mb1CrPjwX1WVGQVifrR4fqwmAH1QpFdXnQUoJRmIAK+SCyXu3BjIzcT0f4J
         Q7UZUXlxsHT3nB6BRwcvx6rL/M5GLp4CFV203R8gY4nuSeBZ6ur15dncGHkiP5+XApBQ
         QCag==
X-Gm-Message-State: APjAAAXuV29HcRhqQt53nLI99UWd90+2Lcvn4Xo8GIV/PFuS3r6Unc8j
        HtGkbSBqU9UifpcyNvzFnCSYG42mR85w0nwOp9Qsr/0i
X-Google-Smtp-Source: APXvYqzdCC5EgTooqlVipKiKiWrGkXhxLZgqAWUOscno4gbbGRMWybgYaTn33CUtquAwxmJ6qGxe03heIOmINT739M0=
X-Received: by 2002:a05:6830:140b:: with SMTP id v11mr3822537otp.340.1582904299844;
 Fri, 28 Feb 2020 07:38:19 -0800 (PST)
MIME-Version: 1.0
References: <CAEjxPJ4ae=FLqEDofLwSP0PEeqUqh1WtoSVFb9TrafMhawfhPg@mail.gmail.com>
 <20200228140524.2404-1-william.c.roberts@intel.com> <20200228140524.2404-5-william.c.roberts@intel.com>
In-Reply-To: <20200228140524.2404-5-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 28 Feb 2020 10:39:37 -0500
Message-ID: <CAEjxPJ52jwNh+TGnUkgGur=3hpdLPiT5cRZ6_Fzhy5aOOYGPjg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] libselinux: drop symbols from map
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ulrich Drepper <drepper@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 28, 2020 at 9:05 AM <bill.c.roberts@gmail.com> wrote:
>
> From: William Roberts <william.c.roberts@intel.com>
>
> Previously, libselinux was exporting the following symbols:
>   - dir_xattr_list;
>   - myprintf_compat;
>   - unmap_class;
>   - unmap_perm;

I had also suggested removing map_class, map_decision, map_perm.
