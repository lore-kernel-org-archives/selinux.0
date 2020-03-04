Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6BCC3F2CD
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646D720866
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aT6rNCK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCDOjH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:39:07 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:41472 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCDOjG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 09:39:06 -0500
Received: by mail-ot1-f51.google.com with SMTP id v19so2201026ote.8
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=678V0LQrEykEoWmnPJ+QR6iX3QdWXtaU5NNMsuJI/Mk=;
        b=aT6rNCK9mfQbuCDTU51bF6tisj8uGlOmuiLjHWjja2WimpK1RFF3lHBPVLLYNsMIuE
         T7yAOtu9JI4s2cBkD4VYP/UsiCZgQHMUpcF6R1FjZVi6Q9NHdr9kxTqE7bpde6ufjQxW
         m8e+OdooKrstjrLCeKkNQuAHsQ7yEeChe3D1EElYAlVEdVhsWkrkher7kHCrRv8TKcb8
         5U5SSwa2LlILi3CKhPbapzESAODo++0FtmeaC8l4T1ZFULKp2jXo4gSC6jODMlN0ZDll
         tuW3cTiy8Mif4fm10BQn7c8LyQTkMGBcRQ7S10imDZgpp8Vumoh833DiLVx07mOKK2V2
         l5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=678V0LQrEykEoWmnPJ+QR6iX3QdWXtaU5NNMsuJI/Mk=;
        b=iFvbpYuwPShBQ+DoXFYgn0x5vgYFtIg+XvuLEcklcWaw1ccn/nkoFI6D8FQubzchtr
         4I23fU7oqA5K0J0ptUaLT0hvmW2Al45cHfwqscC0lCko3QE2PZxV5JCcg9yDK1yid5/B
         7+hBpHX34o5zSMxGFZewRjY/5C1ASR117omSf7qQ2w1ur58K2OffDQ/z51aMmqDtG5Vu
         uMsCb6PbOWguSO7aIWrecBYvm8Z6QSvdOEkjX+OBbvmXSP+F8VwhAOwOPulCpjMpeMK+
         mIpeOtS6SXzybGfasT/HJWEfjFrvcRhHAhbceCxk/BW0Meh2sykmJBRTq0uMskAZW3XH
         UuMw==
X-Gm-Message-State: ANhLgQ09MTEpqLgZ/pskOogx8G2KNCqvYvIaSu0X6AbUyd2l2rD2Qy0Q
        Go+XCNgaGtLQ1Ay/n199gGonGYUHq+q/ihAMEkJvEA==
X-Google-Smtp-Source: ADFU+vvJE6Ssek4TC4aKIRQTlyMlKHVJpHumeJpOUIW1xrGo8a64hbX5Blyr9hhBNF7Xt8zpkh0YEA7mdI7jQnGhEZE=
X-Received: by 2002:a9d:6289:: with SMTP id x9mr2614762otk.340.1583332745739;
 Wed, 04 Mar 2020 06:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20200304072940.GA1026144@brutus.lan>
In-Reply-To: <20200304072940.GA1026144@brutus.lan>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 4 Mar 2020 09:40:17 -0500
Message-ID: <CAEjxPJ4qQgoMq6so-qGMm6fL5CKRKxC-TJXjxmEe=Qv2DAHGTQ@mail.gmail.com>
Subject: Re: strange pam selinux issue
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 2:30 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
> Some semi irrelevant background:
>
> I am designing an improved "targeted" policy. Common targeted policies
> are inefficient because they have several "unconfined" domains.
> Unconfined domains are expensive because they have a lot of rules associated with them.
> They're essentially all the same. Just duplicates.

Why can't you just define a single unconfined attribute with
associated allow rules, and then define multiple domains that
have that attribute?  Where is the duplication occurring?  Name-based
type transitions?  IMHO, those should be used far more
sparsely than they are presently in Fedora and there has been some
optimization recently in how they are internally represented.

> I decided to have just one unconfined domain: "the system", and everything that is not targeted ends up in the system domain.
> So now I want to have a confined login shell with role access to the system a'la: staff_u:staff_r:staff_t -> staff_u:unconfined_r:unconfined_t
> pam_selinux seemingly cannot deal with this scenario as shown above. pam_selinux has many other issues. One of them is its concept of
> "default_type". There is no such thing as a "default_type" and implying that there is a "default_type" causes issues.

default_type was to support providing a default type to use when only
a role was specified to e.g. newrole or pam_selinux.  Not sure that's
a problem.

> There are other issues related to this as well: the env_params option depends on the "context contains" access vector being present.
> It will not work even if you have handle_unknown=allow set.

Probably needs to be converted to using selinux_check_access().
