Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61FBC169C4
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 21:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73179218D9
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 21:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfBFVK3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:10:29 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:42661 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBFVK2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Feb 2019 16:10:28 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 71E385605E9
        for <selinux@vger.kernel.org>; Wed,  6 Feb 2019 22:10:25 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id a11so14483799otr.10
        for <selinux@vger.kernel.org>; Wed, 06 Feb 2019 13:10:25 -0800 (PST)
X-Gm-Message-State: AHQUAubwqPJ0j5Z7O7k+y9A7B0U3tDoAla8wlavt8+xlphHLfS6TRjvs
        TSTS1V4hZsZI/bO6MgWRd94D7dA/xuvTJdpYo1Q=
X-Google-Smtp-Source: AHgI3Iag+mLbANPbNSbvZ0p5CgL0RTvo5oZRlKb33OcQJh1dLyKjzZXz/DJTkOKRkk1z3lQHTPM9oTJFcHEquxXzcqY=
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr6222950otj.301.1549487424444;
 Wed, 06 Feb 2019 13:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20190201164940.31255-1-vmojzis@redhat.com>
In-Reply-To: <20190201164940.31255-1-vmojzis@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 6 Feb 2019 22:10:13 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kbayQPTz5HHzcStCtkSkAf4TnKFLWDpOYityh-5d05jQ@mail.gmail.com>
Message-ID: <CAJfZ7=kbayQPTz5HHzcStCtkSkAf4TnKFLWDpOYityh-5d05jQ@mail.gmail.com>
Subject: Re: [PATCH] python/semanage/seobject: Fix listing boolean values
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  6 22:10:25 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 1, 2019 at 5:49 PM Vit Mojzis <vmojzis@redhat.com> wrote:
>
> Fix gathering boolean values by fixing always False if condition
> (determining whether the values are listed from local store).
>
> Fix listing boolean values by printing the correct values and not
> forcing the use of security_get_boolean_active (which causes
> crash when listing booleans that are not present in active policy).
>
> Fixes:
>     # dnf install selinux-policy-mls
>     # cat > mypolicy.cil
>     (boolean xyz false)
>
>     # semodule -i mypolicy.cil -s mls
>
>     # semanage boolean -l -S mls
>     ...
>     irssi_use_full_network         (off  ,  off)  Allow the Irssi IRC Client to connect to any port, and to bind to any unreserved port.
>     mozilla_plugin_use_bluejeans   (off  ,  off)  Allow mozilla plugin to use Bluejeans.
>     OSError: No such file or directory
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

I confirm this fixes the issue and I merged this patch. Thanks!

Nicolas

> ---
>  python/semanage/seobject.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 556d3ba5..b31a90c1 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -2807,7 +2807,7 @@ class booleanRecords(semanageRecords):
>              value = []
>              name = semanage_bool_get_name(boolean)
>              value.append(semanage_bool_get_value(boolean))
> -            if self.modify_local and boolean in self.current_booleans:
> +            if self.modify_local and name in self.current_booleans:
>                  value.append(selinux.security_get_boolean_pending(name))
>                  value.append(selinux.security_get_boolean_active(name))
>              else:
> @@ -2849,4 +2849,4 @@ class booleanRecords(semanageRecords):
>              print("%-30s %s  %s %s\n" % (_("SELinux boolean"), _("State"), _("Default"), _("Description")))
>          for k in sorted(ddict.keys()):
>              if ddict[k]:
> -                print("%-30s (%-5s,%5s)  %s" % (k, on_off[selinux.security_get_boolean_active(k)], on_off[ddict[k][2]], self.get_desc(k)))
> +                print("%-30s (%-5s,%5s)  %s" % (k, on_off[ddict[k][2]], on_off[ddict[k][0]], self.get_desc(k)))
> --
> 2.17.2
>

