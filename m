Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6626BC433EF
	for <selinux@archiver.kernel.org>; Thu, 14 Apr 2022 20:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiDNUkw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Apr 2022 16:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiDNUkv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Apr 2022 16:40:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0758E2F72
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 13:38:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so12214344ejd.5
        for <selinux@vger.kernel.org>; Thu, 14 Apr 2022 13:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afhpA9cnnyd+FZsuxTyvJSMJlIABU/P6HIJ5+Ns9a4Q=;
        b=hxCYYrxlLip39NNvguImwiMfQb3AXAw0qGFNXlfCkp9Zfz2pHj52GLzp2ebAQR9fba
         Kn3CJHEew/h/YpkVFM8pbmrsAoVRYxbL5WRixf5YdRVg9KmG6EZXjiJe3DIyR9N1qy3C
         JMR5cuH0n6yPGWZl9ex9SKQbiG5VWxSy4N1MCvXvyq8t82vxw0YExwPAsBp3n7wbY77b
         cu5726REJs4Ep9tT909gZSgoIHNGLgohf9w1RFxmjthkxXS2+jKzKjA5HhkPWFzOJtU0
         E220hMM8Rrs4VwKlkpfLU2nzBzCe/S+Z6u+BdeiOOzsbLaGc2Xtf+YSukoybAEMAs2ea
         vcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afhpA9cnnyd+FZsuxTyvJSMJlIABU/P6HIJ5+Ns9a4Q=;
        b=I88fde2SUbs630DgHmktMzln41UKyHK5HcnZyqnibci2CPHFlrX91Kl9cogjMXQDSo
         A0ICWBWUxZQH6Q95MKMyGCCW5SVqHRXmga/ZdmTJw7cNyOopBdR9fVNNiuqAonKOEH4v
         y5mG2sqs/I814EaotpXiQW9LgNs2GtdXaw0dIBU7N04dTH7MESO34dP4as3uZmt2uG6A
         6LsvLaT+nbAsQb1sRwzf2F/2s/WIe1DkEEHAvJENFtMiDs7/XGjUW2f/EROiwD6f9YbB
         Vfx5zqFSvi64JPZVy8D8Icgo1NsK0mMmMCm9WoAPjxlg88KfNQVV+nsYt8z1S2BbRQTS
         B1Rw==
X-Gm-Message-State: AOAM531bCpA84s+vcLmOFn0r4GbLJBLFJ0e2jgRtL2+TpBnKTpe8l9vd
        /gFkdFV6YcZTiWbHlR40X7p2HnVeSSshVgmH9cJHjvwfJg==
X-Google-Smtp-Source: ABdhPJxgehzky/nNQ8tmEkBNlwUwqOyKAhenCk9xmEL9QWGHWeEFPW4hTo0kPCZ2Bbs/b4ROAog4tD3Tbt9bkkwief0=
X-Received: by 2002:a17:907:9803:b0:6db:ab21:738e with SMTP id
 ji3-20020a170907980300b006dbab21738emr3669227ejc.112.1649968704181; Thu, 14
 Apr 2022 13:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220414184325.GD21485@fieldses.org>
In-Reply-To: <20220414184325.GD21485@fieldses.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 14 Apr 2022 16:38:13 -0400
Message-ID: <CAHC9VhR_-Gjh0=2GPhWXEkCPcgHuK4pqxia=ZH8EDLODGe63=w@mail.gmail.com>
Subject: Re: boot failures as of "selinux: checkreqprot is deprecated, add
 some ssleep() discomfort"
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     selinux@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 2:43 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> My Fedora 33 test VMs stopped booting linux-next recently; reverting
> 81200b0265b1 "selinux: checkreqprot is deprecated, add some ssleep()
> discomfort" allows them to boot again.
>
> I'm guessing this warning wasn't intended to be quite *that* dramatic?

Well, I dunno, we *really* want to get rid of that option ;)

Jokes aside, I'm sorry that caught you out, but thanks for reporting
it.  I thought I tested all the combinations, but obviously I missed
one.  The obvious fix is to move the ssleep() call out of
checkreqprot_set() and into sel_write_checkreqprot(); you'll still get
the error message on the console, but you'll only hit the sleep when
toggling the flag after boot, at runtime.  It's similar to the runtime
disable deprecation.  I'll work up a patch as soon as I'm done with
this email.

However, a couple of quick questions: this looks like a custom/hand
built kernel, yes?  If so, is this an old kernel config that you just
keep updating via 'make oldconfig' or something similar?  I'm asking
not to critique your kernel config choice (although this particular
Kconfig knob *is* going away), but rather I want to make sure there
isn't somebody/something out there still enabling this for a large
user base.

-- 
paul-moore.com
