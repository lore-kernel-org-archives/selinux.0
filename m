Return-Path: <SRS0=nflz=SO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A451C10F0E
	for <selinux@archiver.kernel.org>; Fri, 12 Apr 2019 14:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDDD20850
	for <selinux@archiver.kernel.org>; Fri, 12 Apr 2019 14:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1znPqYgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfDLOrC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:47:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35187 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOrC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Apr 2019 10:47:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id u21so7718265lfu.2
        for <selinux@vger.kernel.org>; Fri, 12 Apr 2019 07:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MMNlpaDZw0LtgKx2hP0BP1T8lOLg4oe+JOSkGm6m6vk=;
        b=1znPqYgp49GNHKbU9s7/Rsxgmi9/xdVbTMN9ijrc1cY0xY7kw9yVqGQyr7YRghKrZN
         II5nSdifUbp0uvHhC3D9Q1fnM9NKcIyMWkcA9ARoUKPhzDs79z+XH/AX0CH8HSxf/CIv
         pMR3m69N7z96JH0kddI5yDTMMAl2xNnm9HMZLLs/rLEgVW7GoPnv6bA+OZHo0TSEklwg
         kMwhjJVV2xv3CpdaKB5MsZ6r2hW7FJkp4x9yROoWcD2MHX1vFllb1HO/GALC7gQiVZJJ
         aiG4yuPrL7TgIygBnD6c2whHu3sUPBnNnE/4SkcgKB5XvJBXp+o07ZyajmwuP1mli+8L
         7mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MMNlpaDZw0LtgKx2hP0BP1T8lOLg4oe+JOSkGm6m6vk=;
        b=tv2HXSRTZGZTGEoBGCMqM7yMm5a8CBGs1+AZHj7eTS09Pd8Wji+nUvDWuif44Tjki2
         UFuC5n/xGyAzFfb4a9+/Tho55q3nqegU1b1ZCZSdCeI6fC0vqqvPODVK/dzyTJI8t0LY
         7Rnnt4b+c9c1BfZMW3FDawLhTYvvt99fpcP3KwirulxE7tz9Nn5a+wP1mmyk3czfY1ey
         E0ZxQDlFYnbWb4pzglgZvrN9Y9BNuWJWh73AA9DJxK1+TPPrUIg20ocu95lV+KqDqQhz
         VXMvzuEhY8lgdGcwGWbXzgz3WmwM6qn+UaeJLrFaaflQJ6no1ftXxdv1yVVaY+XaAqda
         Okww==
X-Gm-Message-State: APjAAAVeH9JE30IHA5yW/8Wter1tT/UoEG+/ztGLnCyPAgCPjpbChOiP
        9rp1YYuiEMYj5vUYb0iIjlXfnAv5+otO5bMDjAyr
X-Google-Smtp-Source: APXvYqxs/P83hc7iz9Ud4nbKj8YaQkhIw7u+0lUZnElf1Kz5rNenm0REG0kmnsVJcugL/oW8i4uVtgWr1VQSZg1PsJo=
X-Received: by 2002:ac2:592b:: with SMTP id v11mr8199582lfi.85.1555080419994;
 Fri, 12 Apr 2019 07:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190403122611.6543-1-richard_c_haines@btinternet.com>
 <CAHC9VhTTeetqR03+zaV0d_2rdHr4r6eKnqKNrXO6k9O7+tz=gQ@mail.gmail.com>
 <a1869fe6f41148a956ff902d7077356fc729b28b.camel@btinternet.com>
 <CAHC9VhRXgNk0qMS+-=wUt3wYoteauCv3UdPuPrYPyTEV8zXcHw@mail.gmail.com>
 <2ef270d1e0ce2edbbddc07fba754cb99f2b093d4.camel@btinternet.com> <CAHC9VhQujkY+Cbkb=ge10JXYyCmftphNOzCCeBaHXLXGMa6_ig@mail.gmail.com>
In-Reply-To: <CAHC9VhQujkY+Cbkb=ge10JXYyCmftphNOzCCeBaHXLXGMa6_ig@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 12 Apr 2019 10:46:48 -0400
Message-ID: <CAHC9VhSDzofwhqhAKaScfzB21cnus8=iir-TayjEeWfDa9h9rA@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Update binder test applications
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 11, 2019 at 6:07 PM Paul Moore <paul@paul-moore.com> wrote:
> On the negative side I realized when playing with your test changes
> that I wasn't building BINDERFS in my test kernels - oops.  I'm fixing
> that now, but I might not get a chance to do another test until
> tomorrow; at least I can verify that your BINDERFS testing logic works
> :)

I rebuilt my test kernel (the latest "secnext" builds have it) with
BINDERFS only to realize that Fedora Rawhide doesn't seem to ship
/usr/include/linux/android/binderfs.h so I manually copied the file
from the kernel-devel package only to run into this when building the
new binder tests:

# make
cc -DHAVE_BINDERFS    check_binder.c binder_common.c binder_common.h
-lselinux -lrt -o check_binder
binder_common.c: In function =E2=80=98cmd_name=E2=80=99:
binder_common.c:35:7: error: =E2=80=98BR_TRANSACTION_SEC_CTX=E2=80=99 undec=
lared (first use in t
his function); did you mean =E2=80=98BC_TRANSACTION_SG=E2=80=99?
  35 |  case BR_TRANSACTION_SEC_CTX:
     |       ^~~~~~~~~~~~~~~~~~~~~~
     |       BC_TRANSACTION_SG
binder_common.c:35:7: note: each undeclared identifier is reported only onc=
e for
each function it appears in
binder_common.c: In function =E2=80=98print_trans_data=E2=80=99:
binder_common.c:126:23: error: =E2=80=98FLAT_BINDER_FLAG_TXN_SECURITY_CTX=
=E2=80=99 undeclared (f
irst use in this function)
 126 |          obj->flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX ? "YES" : "N=
O");
     |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make: *** [<builtin>: check_binder] Error 1
# grep "BR_TRANSACTION_SEC_CTX" *
binder_common.c:        case BR_TRANSACTION_SEC_CTX:
binder_common.c:                return "BR_TRANSACTION_SEC_CTX";
service_provider.c:             case BR_TRANSACTION_SEC_CTX: {
# grep "BR_TRANSACTION_SEC_CTX" /usr/include/linux/android/binderfs.h
# grep "BR_TRANSACTION_SEC_CTX" /usr/include/linux/android/binder.h

... and that's when I stopped playing with this.  If it helps, I
pulled my binderfs.h file from a current Rawhide kernel.  What are you
using to run these tests?

At the very least, I'm thinking we'll also want to include some notes
in the README.md file under the "Optional Prerequisites" section about
how to get this running with BINDERFS.

--
paul moore
www.paul-moore.com
