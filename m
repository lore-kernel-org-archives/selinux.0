Return-Path: <SRS0=09KC=QN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39088C282CC
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 20:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07348217F9
	for <selinux@archiver.kernel.org>; Wed,  6 Feb 2019 20:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfBFUqX convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Wed, 6 Feb 2019 15:46:23 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:41862 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfBFUqX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Feb 2019 15:46:23 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 4C4895611E6
        for <selinux@vger.kernel.org>; Wed,  6 Feb 2019 21:46:19 +0100 (CET)
Received: by mail-ot1-f45.google.com with SMTP id a11so14358221otr.10
        for <selinux@vger.kernel.org>; Wed, 06 Feb 2019 12:46:19 -0800 (PST)
X-Gm-Message-State: AHQUAuYmkh72Vsc7oKzgEvxDNJS5QIzs/GifJkOxWtPQkWL0urB5bwRR
        WInzYui4wvOIapx7vjLToedpJqBmoL73G2qxOqI=
X-Google-Smtp-Source: AHgI3IZEZqbv4mcUEr4xx/BQrJ1iqGZDXG7ewR2bB9A+xD/nkrqUc3ZNUW1DJNWF6oRuuQWHM5j/7dDc5r7pY2Ebgcs=
X-Received: by 2002:a9d:70d5:: with SMTP id w21mr6169625otj.301.1549485978307;
 Wed, 06 Feb 2019 12:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20190131194208.3855-1-plautrba@redhat.com>
In-Reply-To: <20190131194208.3855-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Wed, 6 Feb 2019 21:46:07 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=kYgvh3QeXBzWbMcjMuSKt1VaGkaxj=xiJ_0PFsihhPMQ@mail.gmail.com>
Message-ID: <CAJfZ7=kYgvh3QeXBzWbMcjMuSKt1VaGkaxj=xiJ_0PFsihhPMQ@mail.gmail.com>
Subject: Re: [PATCH] dbus: Fix name of polkit function
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Dan Walsh <dwalsh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Feb  6 21:46:19 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 31, 2019 at 8:42 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> From: Dan Walsh <dwalsh@redhat.com>
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Hi,
As I am unfamiliar with D-Bus code, I try to understand what is the
nature of this change (is-it a bugfix, an improvement, something
else?). Here are the facts:

- Currently, dbus/selinux_server.py uses «
@slip.dbus.polkit.require_auth("org.selinux.change_default_mode") »
for function « change_default_mode ».
- "org.selinux.change_default_mode" does not exist, and I do not know
whether that means that some kind of default policykit policy gets
applied.
- "org.selinux.change_policy_type" is defined in
dbus/org.selinux.policy, without any user.
- The commit that introduced dbus/selinux_server.py (commit
e6a1298e5421 ("These are massive changes involved in building new
GUI.")) added a function named « change_default_mode », without any
specific policykit access checking.
- Commit e8718ef51463 ("Make sure we do the polkit check on all dbus
interfaces.") added «
@slip.dbus.polkit.require_auth("org.selinux.change_default_mode") » in
policycoreutils/sepolicy/selinux_server.py.

If I understand correctly, this last commit is buggy and should have
added "org.selinux.change_default_mode" to
policycoreutils/sepolicy/org.selinux.policy. Therefore this new patch
fixes a bug and removes an unused policykit action. Is this right? If
yes, I suggest adding this to the commit description:

    Add missing action org.selinux.change_default_mode for
change_default_mode() and remove unused action
org.selinux.change_policy_type.

    Fixes: e8718ef51463 ("Make sure we do the polkit check on all dbus
interfaces.")

Would this be acceptable?

Thanks,
Nicolas

> ---
>  dbus/org.selinux.policy | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/dbus/org.selinux.policy b/dbus/org.selinux.policy
> index 01266102..9772127b 100644
> --- a/dbus/org.selinux.policy
> +++ b/dbus/org.selinux.policy
> @@ -70,9 +70,9 @@
>           <allow_active>auth_admin_keep</allow_active>
>          </defaults>
>      </action>
> -    <action id="org.selinux.change_policy_type">
> -        <description>SELinux write access</description>
> -        <message>System policy prevents change_policy_type access to SELinux</message>
> +    <action id="org.selinux.change_default_mode">
> +        <description>Change SELinux default enforcing mode</description>
> +        <message>System policy prevents change_default_policy access to SELinux</message>
>          <defaults>
>            <allow_any>no</allow_any>
>            <allow_inactive>no</allow_inactive>
> --
> 2.20.1
>

