Return-Path: <SRS0=ebWe=YZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A48CA9ED1
	for <selinux@archiver.kernel.org>; Fri,  1 Nov 2019 10:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BE82086D
	for <selinux@archiver.kernel.org>; Fri,  1 Nov 2019 10:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfKAKzN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:55:13 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:36391 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfKAKzN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 Nov 2019 06:55:13 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7F9DA564911
        for <selinux@vger.kernel.org>; Fri,  1 Nov 2019 11:55:09 +0100 (CET)
Received: by mail-ot1-f51.google.com with SMTP id v24so2734201otp.5
        for <selinux@vger.kernel.org>; Fri, 01 Nov 2019 03:55:09 -0700 (PDT)
X-Gm-Message-State: APjAAAU/oTZNmSCNU/6VSI3SjkXWoi3XQYGbpLojcfybONILtAI9E/h3
        5dtHlC9WpVS3mGDbdffS3x+Q3s7OBpNAvTUw3Xc=
X-Google-Smtp-Source: APXvYqzkTFRipWIapkp5qwF9Mt9OJU/BxgSziqhNqcXMV5HGHJdwf36JqBguVe8ngEQeyWviQLWIMgw+q1Ln2ABlj3Q=
X-Received: by 2002:a9d:588b:: with SMTP id x11mr6173644otg.189.1572605708535;
 Fri, 01 Nov 2019 03:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <pjd1rut9rnh.fsf@redhat.com>
In-Reply-To: <pjd1rut9rnh.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Fri, 1 Nov 2019 11:54:57 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nOVSMNZHCYexgEk=xAfMfEA1pVkvVs5YANurj86VNMug@mail.gmail.com>
Message-ID: <CAJfZ7=nOVSMNZHCYexgEk=xAfMfEA1pVkvVs5YANurj86VNMug@mail.gmail.com>
Subject: Re: ANN: SELinux userspace 3.0-rc1 release candidate
To:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri Nov  1 11:55:09 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 31, 2019 at 10:43 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hello,
>
> A 3.0-rc1 release candidate for the SELinux userspace is now
> available at:
>
> https://github.com/SELinuxProject/selinux/wiki/Releases
>
> Please give it a test and let us know if there are any issues.
>
> If there are specific changes that you think should be called out
> in release notes for packagers and users in the final release
> announcement, let us know.

Hello, I started testing this RC on a test virtual machine (which uses
Arch Linux and refpolicy) and something changed in a quite unexpected
way: "semodule --verbose" is now a lot more noisy than 2.9. Here is an
example of what I get when rebuilding the policy:

# semodule --verbose -B
Committing changes:
Disabling optional 'ada_optional_6' at
/var/lib/selinux/refpolicy/tmp/modules/400/ada/cil:63
Failed to resolve typeattributeset statement at
/var/lib/selinux/refpolicy/tmp/modules/400/ada/cil:66
Disabling optional 'anaconda_optional_9' at
/var/lib/selinux/refpolicy/tmp/modules/400/anaconda/cil:183
Failed to resolve typeattributeset statement at
/var/lib/selinux/refpolicy/tmp/modules/400/anaconda/cil:189
Disabling optional 'apache_optional_92' at
/var/lib/selinux/refpolicy/tmp/modules/400/apache/cil:3449
Failed to resolve typeattributeset statement at
/var/lib/selinux/refpolicy/tmp/modules/400/apache/cil:3499
...

Such an output could be useful when debugging issues about optional
modules, but they may make other issues harder to find among all the
messages. Would it be possible to hide these specific messages by
default in verbose mode?

Thanks,
Nicolas

