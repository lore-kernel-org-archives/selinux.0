Return-Path: <SRS0=UzCa=NB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DD6ECDE3D
	for <selinux@archiver.kernel.org>; Sun, 21 Oct 2018 09:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27B62083E
	for <selinux@archiver.kernel.org>; Sun, 21 Oct 2018 09:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27B62083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeJURcC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 21 Oct 2018 13:32:02 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:36716 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeJURcC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 21 Oct 2018 13:32:02 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Oct 2018 13:32:00 EDT
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id B5D76560663
        for <selinux@vger.kernel.org>; Sun, 21 Oct 2018 11:10:55 +0200 (CEST)
Received: by mail-ot1-f44.google.com with SMTP id x4so35776225otg.3
        for <selinux@vger.kernel.org>; Sun, 21 Oct 2018 02:10:55 -0700 (PDT)
X-Gm-Message-State: ABuFfogKKycr5r6jwhiP+aTb6kWck55p5v5ZBqOPWXa4NJ7Q5Odvqpnl
        xLCn6tJC4XWNF/GAtfoMmwX3Kw0RIHO3cf5foqw=
X-Google-Smtp-Source: ACcGV615fKiFi/ADpnxBwCudBHsYoNSMCACuLeJdxL+wOiAeW/uAgL0yJY9H/rY3A6murOBFZO/fJ0n8sxrXR0wTt0w=
X-Received: by 2002:a9d:41f6:: with SMTP id v51mr24570669oti.368.1540113054461;
 Sun, 21 Oct 2018 02:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181016100533.12249-1-vmojzis@redhat.com> <20181016100533.12249-3-vmojzis@redhat.com>
In-Reply-To: <20181016100533.12249-3-vmojzis@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 21 Oct 2018 11:10:43 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nTojoSkL8Eg84ZX429+tETXOVDJ7m0rC3R3dHqK93VSQ@mail.gmail.com>
Message-ID: <CAJfZ7=nTojoSkL8Eg84ZX429+tETXOVDJ7m0rC3R3dHqK93VSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] python/sepolicy: Stop rejecting aliases in sepolicy commands
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Oct 21 11:10:56 2018 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 16, 2018 at 12:05 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Fix CheckDomain and CheckPortType classes to properly deal with aliases.
>
> Resolves:
>    https://bugzilla.redhat.com/show_bug.cgi?id=1600009
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/sepolicy/sepolicy.py          |  8 +++-----
>  python/sepolicy/sepolicy/__init__.py | 10 +++++++++-
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
[...]
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index 8484b28c..0da3917b 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -447,6 +447,14 @@ def get_file_types(setype):
>      return mpaths
>
>
> +# determine if entered type is an alias
> +# and return corresponding type name
> +def get_real_type_name(name):
> +    try:
> +        return next(info(TYPE, name))["name"]
> +    except (RuntimeError, StopIteration):
> +        return None
> +

When I first read the function comment, I did not understand whether
the returned value was a kind of SELinux type (like something which
would say "a file type", "a port type") or the SELinux type which is
aliased. It is the second interpretation which is implemented.
Moreover, this comment seems to be better in a function docstring. I
suggest changing this into the following:

def get_real_type_name(name):
    """Return the real name of a type:

    * If 'name' refers to a type, return the same name.
    * If 'name' refers to a type alias, return the corresponding name.
    * Otherwise return None.
    """

What do you think of this suggestion?

Moreover, when is RuntimeError triggered, in the exception that are caught?

Thanks for your patches,
Nicolas
PS: sorry for the delay, I have been quite busy the last days.

