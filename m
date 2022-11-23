Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6A5C433FE
	for <selinux@archiver.kernel.org>; Wed, 23 Nov 2022 16:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbiKWQQE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 23 Nov 2022 11:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbiKWQQE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 23 Nov 2022 11:16:04 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E8C78B26
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 08:16:03 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bj12so43779795ejb.13
        for <selinux@vger.kernel.org>; Wed, 23 Nov 2022 08:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m78wmoCmbGnmYyhMr0mN72Q7VbeNe2qt9AuDk05LWrw=;
        b=hCbi5kFL/u0ULQEsevcDtS/QunGtsjEjSkRC1eVq0vI9uJ++Jm6k/ybfORBqwDuguQ
         f/dgE9VQWTVf+ShWiZnam3ltIDnUOvlQrbeoLj35e5UaX+piuqF7dDdxFbUIOcnXtyGq
         TW4nbPk24gPUYa4AvoMJP2yxVz+4JDzp+p+HObLuJ1/h+DpTqtoNiSraR28PtHl1MvzW
         wqY7sF92pLwrf8pWNTsjRnxdkiv2E6KaApdMh0kORgdSzEY/Kwix7AphOFFwXct6fPua
         bucLLtSdcYuW5rfcV5De9ngBc2pG/SS5+3SThL3IozeH28Q5oH7wCWz8imL9Ik1Oe7i3
         6V4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m78wmoCmbGnmYyhMr0mN72Q7VbeNe2qt9AuDk05LWrw=;
        b=YyFgBcfsNORlrujRMMbK0wdtCOOibdRCjzut9r+5h8DkH/pi+Ioh2JkJhIR1hhnIIJ
         S51M143Wv776INessKmrPv84SVZSclq2IZ/14A9Nah6z5U11ifbXwV6nFsptPsAsGOqn
         ZqKULmxkMjZnoZtjM6KD7tlTlwiz55SefzRW64NaFJuyDscT1iuDMiH8o6Nlbj1tP6KG
         Xp7ucgdT+IBLgzHzOSL+ctluu4duRSgomgOesrZuXmjGaZU05GCC7nQZhXy/mJswn1DD
         T5XeGhHc1pOCBgTeWB3snT8FXlZYbY76IPVf4Ab3MT574UyLw1kNgb4WZYybosrWp39T
         IsOA==
X-Gm-Message-State: ANoB5pmvyh85iGlEbbUzugSHUN6XtKXnlUG0d8SlzrB626r7SgpdlnlO
        Eb9VibnaiyNGaP2wOHL8r1C2gdP3kgXOWjd+IFPwFOek
X-Google-Smtp-Source: AA0mqf6fyhuXWcExYjoDED/0mjsvhuhLkaDKELUIEQnnDZdJwoi0pOUESMzsSZMZC1VnQwic8DiZbgwa+db1hCaEztA=
X-Received: by 2002:a17:906:9da4:b0:7ae:100a:8dc0 with SMTP id
 fq36-20020a1709069da400b007ae100a8dc0mr23303044ejc.424.1669220161520; Wed, 23
 Nov 2022 08:16:01 -0800 (PST)
MIME-Version: 1.0
References: <d11c25c5-727e-342a-162a-e3851ff03d27@linux.microsoft.com>
In-Reply-To: <d11c25c5-727e-342a-162a-e3851ff03d27@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 23 Nov 2022 11:15:50 -0500
Message-ID: <CAP+JOzRp5thGEHwv2eMtA-O+O9iHUkciKGg7imkapBAhLfOxHg@mail.gmail.com>
Subject: Re: secilc genfscon parsing error
To:     Matthew Sheets <masheets@linux.microsoft.com>
Cc:     SELinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 23, 2022 at 10:55 AM Matthew Sheets
<masheets@linux.microsoft.com> wrote:
>
> Hi,
>
> I am seeing a parsing error from secilc when trying to compile the
> following line:
> (genfscon sysfs "/zap" file (system_u object_r foo ((s0) (s0))))
>
> But according to the documentation here:
> https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/cil_file_labeling_statements.md#genfscon
> I believe this should be a valid line.
>
> The compiler error given is:
> Invalid syntax
> Bad genfscon declaration at out.cil:129
> Failed to build AST
> Failed to compile cildb: -1
>
> If I remove the file keyword everything compiles correctly.
>
> Other interesting points of data:
>
> In ref policy there is the following line in selinux.te
> genfscon selinuxfs /booleans/ -- gen_context(system_u:object_r:boolean_t,s0)
>
> When compiling this to cil with checkpolicy the following line is produced:
> (genfscon selinuxfs "/booleans/" (system_u object_r boolean_t (systemlow
> systemlow)))
> Which has no reference to the optional file_type field.

CIL did not properly handle the optional file type until a year ago.
The SELinux userspace version 3.4, released last May, would be the
only one that has the fix.
Your rule will work with the latest release.

Thanks,
Jim
