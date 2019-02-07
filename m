Return-Path: <SRS0=93oN=QO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE02C282C2
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 12:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B22190C
	for <selinux@archiver.kernel.org>; Thu,  7 Feb 2019 12:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBGMkb convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Thu, 7 Feb 2019 07:40:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfBGMkb (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 7 Feb 2019 07:40:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C154EC065F9F;
        Thu,  7 Feb 2019 12:40:30 +0000 (UTC)
Received: from localhost (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57DAF277C8;
        Thu,  7 Feb 2019 12:40:30 +0000 (UTC)
References: <pjdtvhns3pq.fsf@redhat.com> <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     "selinux\@vger.kernel.org" <selinux@vger.kernel.org>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: gcc 9.0.0 build issues
In-reply-to: <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
Date:   Thu, 07 Feb 2019 13:40:28 +0100
Message-ID: <pjdlg2rydoj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 07 Feb 2019 12:40:30 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Ondrej Mosnacek <omosnace@redhat.com> writes:

> On Fri, Feb 1, 2019 at 8:36 PM Petr Lautrbach 
> <plautrba@redhat.com> wrote:
>> gcc-9.0.0-0.3.fc30.x86_64 from Fedora Rawhide:
>>
>> gcc version 9.0.0 20190119 (Red Hat 9.0.0-0.3) (GCC)
>>
...
>> When libselinux is built separately, other CFLAGS is used:
>>
>> $ cd libselinux
>>
>> $ make DESTDIR=~/obj install install-pywrap
>> ...
>>
>> make[1]: Entering directory
>> '/home/build/SELinuxProject-selinux/libselinux/src'
>>
>> cc -O -Wall -W -Wundef -Wformat-y2k -Wformat-security 
>> -Winit-self
>> -Wmissing-include-dirs -Wunused -Wunknown-pragmas
>> -Wstrict-aliasing -Wshadow -Wpointer-arith -Wbad-function-cast
>> -Wcast-align -Wwrite-strings -Waggregate-return
>> -Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes
>> -Wmissing-declarations -Wmissing-noreturn
>> -Wmissing-format-attribute -Wredundant-decls -Wnested-externs
>> -Winline -Winvalid-pch -Wvolatile-register-var
>> -Wdisabled-optimization -Wbuiltin-macro-redefined -Wattributes
>> -Wmultichar -Wdeprecated-declarations -Wdiv-by-zero
>> -Wdouble-promotion -Wendif-labels -Wextra -Wformat-extra-args
>> -Wformat-zero-length -Wformat=2 -Wmultichar -Woverflow
>> -Wpointer-to-int-cast -Wpragmas -Wno-missing-field-initializers
>> -Wno-sign-compare -Wno-format-nonliteral 
>> -Wframe-larger-than=32768
>> -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions
>> -fasynchronous-unwind-tables -fdiagnostics-show-option
>> -funit-at-a-time -Werror -Wno-aggregate-return
>> -Wno-redundant-decls -fipa-pure-const -Wlogical-op
>> -Wpacked-bitfield-compat -Wsync-nand -Wcoverage-mismatch -Wcpp
>> -Wformat-contains-nul -Wnormalized=nfc 
>> -Wsuggest-attribute=const
>> -Wsuggest-attribute=noreturn -Wsuggest-attribute=pure
>> -Wtrampolines -Wjump-misses-init -Wno-suggest-attribute=pure
>> -Wno-suggest-attribute=const -U_FORTIFY_SOURCE 
>> -D_FORTIFY_SOURCE=2
>> -Wstrict-overflow=5 -I../include -D_GNU_SOURCE
>> -DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
>> booleans.c: In function ‘security_get_boolean_names’:
>> booleans.c:39:5: error: assuming signed overflow does not occur
>> when changing X +- C1 cmp C2 to X cmp C2 -+ C1
>> [-Werror=strict-overflow]
>>    39 | int security_get_boolean_names(char ***names, int *len)
>>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>
> This one is really weird... Perhaps a bug in GCC? At the very 
> least
> the warning message and source code location are super 
> confusing,
> which is a bug on its own...

It's detected only with -Wstrict-overflow=3 and higher. Makefile 
in
libselinux uses level 5 which was added by commit
9fe430345 ("Makefile: add -Wstrict-overflow=5 to CFLAGS)

The problem code is on lines 84 and 85 in 
libselinux/src/booleans.c:

84:	for (--i; i >= 0; --i)
85:    free(n[i]);


It could be suppressed by something like this:

--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -39,7 +39,7 @@ static int filename_select(const struct dirent 
*d)
 int security_get_boolean_names(char ***names, int *len)
 {
        char path[PATH_MAX];
-       int i, rc;
+       int i, j, rc;
        struct dirent **namelist;
        char **n;
 
@@ -81,8 +81,8 @@ int security_get_boolean_names(char ***names, 
int *len)
        free(namelist);
        return rc;
       bad_freen:
-       for (--i; i >= 0; --i)
-               free(n[i]);
+       for (j = 0; j < i; j++)
+               free(n[j]);
        free(n);
       bad:
        goto out;


William, what would you consider to be the right fix in this case?


