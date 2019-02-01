Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD2DC282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 19:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812C82082C
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 19:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBATgM convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Fri, 1 Feb 2019 14:36:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11349 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbfBATeN (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 1 Feb 2019 14:34:13 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA5ADC0C49D8
        for <selinux@vger.kernel.org>; Fri,  1 Feb 2019 19:34:12 +0000 (UTC)
Received: from workstation (ovpn-204-55.brq.redhat.com [10.40.204.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 140F85D6AA
        for <selinux@vger.kernel.org>; Fri,  1 Feb 2019 19:34:11 +0000 (UTC)
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     "selinux\@vger.kernel.org" <selinux@vger.kernel.org>
Subject: gcc 9.0.0 build issues
Date:   Fri, 01 Feb 2019 20:34:09 +0100
Message-ID: <pjdtvhns3pq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 01 Feb 2019 19:34:12 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


gcc-9.0.0-0.3.fc30.x86_64 from Fedora Rawhide:

gcc version 9.0.0 20190119 (Red Hat 9.0.0-0.3) (GCC)

$ make DESTDIR=~/obj install install-pywrap
...

make[2]: Entering directory 
'/home/build/SELinuxProject-selinux/libsepol/src'
cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute 
-Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes 
-Wundef -Wunused -Wwrite-strings -I. -I../include -D_GNU_SOURCE 
-I../cil/include -fPIC -c -o genbools.o genbools.c
In function ‘strtrim’,
    inlined from ‘process_boolean.constprop’ at genbools.c:52:2:
genbools.c:24:2: error: ‘strncpy’ output may be truncated copying 
8191 bytes from a string of length 8191 
[-Werror=stringop-truncation]
   24 |  strncpy(dest, ptr, size);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~

...

make[2]: Entering directory 
'/home/build/SELinuxProject-selinux/libsepol/src'
cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute 
-Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes 
-Wundef -Wunused -Wwrite-strings -I. -I../include -D_GNU_SOURCE 
-I../cil/include -fPIC -DSHARED -c -o genbools.lo genbools.c
In function ‘strtrim’,
    inlined from ‘process_boolean.constprop’ at genbools.c:52:2:
genbools.c:24:2: error: ‘strncpy’ output may be truncated copying 
8191 bytes from a string of length 8191 
[-Werror=stringop-truncation]
   24 |  strncpy(dest, ptr, size);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~

...

make[2]: Entering directory 
'/home/build/SELinuxProject-selinux/libselinux/src'
cc -O2 -Werror -Wall -Wextra -Wmissing-format-attribute 
-Wmissing-noreturn -Wpointer-arith -Wshadow -Wstrict-prototypes 
-Wundef -Wunused -Wwrite-strings -I../include -D_GNU_SOURCE 
-DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
In function ‘strtrim’,
    inlined from ‘process_boolean’ at booleans.c:362:2:
booleans.c:335:2: error: ‘strncpy’ output may be truncated copying 
between 8188 and 8191 bytes from a string of length 8191 
[-Werror=stringop-truncation]
  335 |  strncpy(dest, ptr, size);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~

...



When libselinux is built separately, other CFLAGS is used:

$ cd libselinux

$ make DESTDIR=~/obj install install-pywrap
...

make[1]: Entering directory 
'/home/build/SELinuxProject-selinux/libselinux/src'

cc -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self 
-Wmissing-include-dirs -Wunused -Wunknown-pragmas 
-Wstrict-aliasing -Wshadow -Wpointer-arith -Wbad-function-cast 
-Wcast-align -Wwrite-strings -Waggregate-return 
-Wstrict-prototypes -Wold-style-definition -Wmissing-prototypes 
-Wmissing-declarations -Wmissing-noreturn 
-Wmissing-format-attribute -Wredundant-decls -Wnested-externs 
-Winline -Winvalid-pch -Wvolatile-register-var 
-Wdisabled-optimization -Wbuiltin-macro-redefined -Wattributes 
-Wmultichar -Wdeprecated-declarations -Wdiv-by-zero 
-Wdouble-promotion -Wendif-labels -Wextra -Wformat-extra-args 
-Wformat-zero-length -Wformat=2 -Wmultichar -Woverflow 
-Wpointer-to-int-cast -Wpragmas -Wno-missing-field-initializers 
-Wno-sign-compare -Wno-format-nonliteral -Wframe-larger-than=32768 
-fstack-protector-all --param=ssp-buffer-size=4 -fexceptions 
-fasynchronous-unwind-tables -fdiagnostics-show-option 
-funit-at-a-time -Werror -Wno-aggregate-return 
-Wno-redundant-decls -fipa-pure-const -Wlogical-op 
-Wpacked-bitfield-compat -Wsync-nand -Wcoverage-mismatch -Wcpp 
-Wformat-contains-nul -Wnormalized=nfc -Wsuggest-attribute=const 
-Wsuggest-attribute=noreturn -Wsuggest-attribute=pure 
-Wtrampolines -Wjump-misses-init -Wno-suggest-attribute=pure 
-Wno-suggest-attribute=const -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 
-Wstrict-overflow=5 -I../include -D_GNU_SOURCE 
-DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
booleans.c: In function ‘security_get_boolean_names’:
booleans.c:39:5: error: assuming signed overflow does not occur 
when changing X +- C1 cmp C2 to X cmp C2 -+ C1 
[-Werror=strict-overflow]
   39 | int security_get_boolean_names(char ***names, int *len)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


