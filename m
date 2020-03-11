Return-Path: <SRS0=h1bs=44=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A893C10F27
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDDD2071B
	for <selinux@archiver.kernel.org>; Wed, 11 Mar 2020 14:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiUVljtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgCKOyO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:54:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34010 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbgCKOyO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Mar 2020 10:54:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id j16so2253561otl.1
        for <selinux@vger.kernel.org>; Wed, 11 Mar 2020 07:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdTKOHRcNvUjs9w8M4cO/IAC8O2Qtd+bQT2kT1sSVF0=;
        b=JiUVljtjc86FiCx1wjceBYR8uwTHeqdI/vSPGd++b5c/43Nbe3J9PCp0y9i+kb6aUK
         i7AkBa4G2Z51pdfqYMCSVZTxVF54JUKFKGxqpZSrxN86lUCZf+nskib3OCdFsKlXIGYi
         njCvVBA2ZQVY94nnuJIxhJUa+mDkgnwK9NIYPAChBe+H1tEk29lxaT9LFA22nNKU6Mu5
         3QjLKLvnUjwEJYRqGjQmHMN2xL7xXFF18B8AdSKh+gntqHSuLim75Mx4kkWu9iLCoPe0
         5ZvXiPjJ8I+U/BjHO8PkOPmkmjBxcRH9DlwDx1v1WJYyVKQXSz+RokEgegqlHdlfkEwY
         gSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdTKOHRcNvUjs9w8M4cO/IAC8O2Qtd+bQT2kT1sSVF0=;
        b=KcXSh9wPEv5xRX3NUnxnIBPr64CaJflJcJ/javZZ7azso7om7YAJVMv5jFQJZMJVDH
         KBfPbfNqIIUA4CO5qivgCMqydJTRpdxOAl7Z857YJ8W0RC2XJLYcY/dvIGgwwnWY55UL
         EP7JjgeN3pKv3FerqzIr3DJTgntf0/AXQzYORIDJL9jzGH1FYundmayjPn0I2re6LSUx
         tNSrMdLt2yZpuC1PJ9OZXECH9fotyrM97wLQqEPwFPB3kb5OUOMQpGUjI9CSuPpurbsa
         Oj4uo9sSzGaOsNUAsnSSAtyjjmyBoQ6LzLfUyJ9UjjyS2oADaR/GXOx0/n8j0oKah2f6
         TU7Q==
X-Gm-Message-State: ANhLgQ0n7RJ0MTWNg0HXr5fVY6975+R0If8ap0j002Msd57qzN7Qv1r3
        QS/50cA4rb/D1fz0trlL+Cailn8mHHA8iuFpVPU=
X-Google-Smtp-Source: ADFU+vt1MQ7LHpV6IF6lfFwzi7mbH35cg5Fb1YTMz9QoZLVx0VqOBG420YfCoo55IADcQsPCHzq1uxgfx6sORkfmfHw=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr2645633otl.135.1583938453195;
 Wed, 11 Mar 2020 07:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200310162456.32240-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200310162456.32240-1-richard_c_haines@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 11 Mar 2020 10:55:05 -0400
Message-ID: <CAEjxPJ4USNdqFY40vPnviLPHSZR22Tpq0y1L+LauJenKXRw6HA@mail.gmail.com>
Subject: Re: [RFC V3 PATCH 0/2] selinux-testsuite: Use native filesystem for tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 10, 2020 at 12:25 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> If you test on the selinux-next kernel (that has the XFS patch [1]) with
> the "NFS: Ensure security label is set for root inode" patch [2], then all
> tests should pass. Anything else will give varying amounts of fails.
>
> The filesystem types tested are: ext4, xfs, vfat and nfs4.
>
> I've revamped the nfs.sh to handle tests that require specific mount
> options, these plus many more are now in tests/nfs_filesystem. This only
> gets run by nfs.sh.

I don't really understand why you moved tests that could only be run
from nfs.sh out of it into
tests/nfs_filesystem?

>
> There are two minor workarounds involving multiple mounts returning EBUSY.
> These are either bugs or features.
>
> Not tested on travis.

travis will require you to add the new dependencies to the packages
list in .travis.yml.  You can test this yourself by
pushing a branch with your changes to your own clone on GitHub and
checking travis-ci.org for the result.
