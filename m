Return-Path: <SRS0=5iRL=QT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D22C282C4
	for <selinux@archiver.kernel.org>; Tue, 12 Feb 2019 16:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D61B20855
	for <selinux@archiver.kernel.org>; Tue, 12 Feb 2019 16:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbfBLQhk convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:37:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38719 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730715AbfBLQhk (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 12 Feb 2019 11:37:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C92C989AD9;
        Tue, 12 Feb 2019 16:37:39 +0000 (UTC)
Received: from workstation (unknown [10.40.205.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CDF15C219;
        Tue, 12 Feb 2019 16:37:38 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     "Roberts\, William C" <william.c.roberts@intel.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        "selinux\@vger.kernel.org" <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: gcc 9.0.0 build issues
References: <pjdtvhns3pq.fsf@redhat.com>
        <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
        <pjdlg2rydoj.fsf@redhat.com>
        <476DC76E7D1DF2438D32BFADF679FC5649CDF45F@ORSMSX101.amr.corp.intel.com>
        <3a9f2281-aad4-58fd-ab8e-cb99a8da0fae@tycho.nsa.gov>
        <476DC76E7D1DF2438D32BFADF679FC5649CE8B71@ORSMSX101.amr.corp.intel.com>
Date:   Tue, 12 Feb 2019 17:37:36 +0100
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649CE8B71@ORSMSX101.amr.corp.intel.com>
        (William C. Roberts's message of "Fri, 8 Feb 2019 19:40:35 +0000")
Message-ID: <pjdbm3hx8rz.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 12 Feb 2019 16:37:40 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

"Roberts, William C" <william.c.roberts@intel.com> writes:

>> -----Original Message-----
>> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>> Sent: Thursday, February 7, 2019 10:17 AM
>> To: Roberts, William C <william.c.roberts@intel.com>; Petr Lautrbach
>> <plautrba@redhat.com>; selinux@vger.kernel.org
>> Cc: Ondrej Mosnacek <omosnace@redhat.com>
>> Subject: Re: gcc 9.0.0 build issues
>> 
>> On 2/7/19 12:52 PM, Roberts, William C wrote:
>> >
>> >
>> >> -----Original Message-----
>> >> From: Petr Lautrbach [mailto:plautrba@redhat.com]
>> >> Sent: Thursday, February 7, 2019 4:40 AM
>> >> To: selinux@vger.kernel.org
>> >> Cc: Petr Lautrbach <plautrba@redhat.com>; Roberts, William C
>> >> <william.c.roberts@intel.com>; Ondrej Mosnacek <omosnace@redhat.com>
>> >> Subject: Re: gcc 9.0.0 build issues
>> >>
>> >>
>> >> Ondrej Mosnacek <omosnace@redhat.com> writes:
>> >>
>> >>> On Fri, Feb 1, 2019 at 8:36 PM Petr Lautrbach <plautrba@redhat.com>
>> >>> wrote:
>> >>>> gcc-9.0.0-0.3.fc30.x86_64 from Fedora Rawhide:
>> >>>>
>> >>>> gcc version 9.0.0 20190119 (Red Hat 9.0.0-0.3) (GCC)
>> >>>>
>> >> ...
>> >>>> When libselinux is built separately, other CFLAGS is used:
>> >>>>
>> >>>> $ cd libselinux
>> >>>>
>> >>>> $ make DESTDIR=~/obj install install-pywrap ...
>> >>>>
>> >>>> make[1]: Entering directory
>> >>>> '/home/build/SELinuxProject-selinux/libselinux/src'
>> >>>>
>> >>>> cc -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self
>> >>>> -Wmissing-include-dirs -Wunused -Wunknown-pragmas -Wstrict-aliasing
>> >>>> -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align
>> >>>> -Wwrite-strings -Waggregate-return -Wstrict-prototypes
>> >>>> -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations
>> >>>> -Wmissing-noreturn -Wmissing-format-attribute -Wredundant-decls
>> >>>> -Wnested-externs -Winline -Winvalid-pch -Wvolatile-register-var
>> >>>> -Wdisabled-optimization -Wbuiltin-macro-redefined -Wattributes
>> >>>> -Wmultichar -Wdeprecated-declarations -Wdiv-by-zero
>> >>>> -Wdouble-promotion -Wendif-labels -Wextra -Wformat-extra-args
>> >>>> -Wformat-zero-length -Wformat=2 -Wmultichar -Woverflow
>> >>>> -Wpointer-to-int-cast -Wpragmas -Wno-missing-field-initializers
>> >>>> -Wno-sign-compare -Wno-format-nonliteral
>> >>>> -Wframe-larger-than=32768
>> >>>> -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions
>> >>>> -fasynchronous-unwind-tables -fdiagnostics-show-option
>> >>>> -funit-at-a-time -Werror -Wno-aggregate-return -Wno-redundant-decls
>> >>>> -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand
>> >>>> -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
>> >>>> -Wsuggest-attribute=const -Wsuggest-attribute=noreturn
>> >>>> -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init
>> >>>> -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
>> >>>> -U_FORTIFY_SOURCE
>> >>>> -D_FORTIFY_SOURCE=2
>> >>>> -Wstrict-overflow=5 -I../include -D_GNU_SOURCE
>> >>>> -DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
>> >>>> booleans.c: In function ‘security_get_boolean_names’:
>> >>>> booleans.c:39:5: error: assuming signed overflow does not occur
>> >>>> when changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
>> >>>>     39 | int security_get_boolean_names(char ***names, int *len)
>> >>>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> >>>> cc1: all warnings being treated as errors
>> >>>
>> >>> This one is really weird... Perhaps a bug in GCC? At the very least
>> >>> the warning message and source code location are super confusing,
>> >>> which is a bug on its own...
>> >>
>> >> It's detected only with -Wstrict-overflow=3 and higher. Makefile in
>> >> libselinux uses level 5 which was added by commit
>> >> 9fe430345 ("Makefile: add -Wstrict-overflow=5 to CFLAGS)
>> >>
>> >> The problem code is on lines 84 and 85 in
>> >> libselinux/src/booleans.c:
>> >>
>> >> 84:	for (--i; i >= 0; --i)
>> >> 85:    free(n[i]);
>> >>
>> >>
>> >> It could be suppressed by something like this:
>> >>
>> >> --- a/libselinux/src/booleans.c
>> >> +++ b/libselinux/src/booleans.c
>> >> @@ -39,7 +39,7 @@ static int filename_select(const struct dirent
>> >> *d)
>> >>   int security_get_boolean_names(char ***names, int *len)  {
>> >>          char path[PATH_MAX];
>> >> -       int i, rc;
>> >> +       int i, j, rc;
>> >>          struct dirent **namelist;
>> >>          char **n;
>> >>
>> >> @@ -81,8 +81,8 @@ int security_get_boolean_names(char ***names, int
>> *len)
>> >>          free(namelist);
>> >>          return rc;
>> >>         bad_freen:
>> >> -       for (--i; i >= 0; --i)
>> >> -               free(n[i]);
>> >> +       for (j = 0; j < i; j++)
>> >> +               free(n[j]);
>> >>          free(n);
>> >>         bad:
>> >>          goto out;
>> >>
>> >>
>> >> William, what would you consider to be the right fix in this case?
>> >
>> > The previous code looks correct IMO, I can't see an actual problem.
>> > Looks like GCC complaining incorrectly or were missing something. In
>> > the case of gcc Incorrectly complaining I usually take a course of
>> > action to work around it, but Im not sure how other maintainers feel about that
>> @sds anything?
>> 
>> AFAICS, the code is correct as is.  Not a fan of rewriting code to appease overly
>> zealous compilers...
>> 
>
> So I looked at filing a bug with GCC, and one thing that helps it get looked at is sample code
> to trigger the problem. I'm not even seeing a GCC 9 release, so I am assuming it's in a dev
> mode? 
>
> Since you have it running could you see if you can re-produce the error in a snippet and file the bug?
>
> I would also diff the object file with -frwapv to see if it is producing different code for that loop.
>
> Bill

Fedora gcc is built with
--with-bugurl=http://bugzilla.redhat.com/bugzilla therefore I filed bug
there: https://bugzilla.redhat.com/show_bug.cgi?id=1676607

Petr
