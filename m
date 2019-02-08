Return-Path: <SRS0=wfIc=QP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940A6C282CB
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 20:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C912177B
	for <selinux@archiver.kernel.org>; Fri,  8 Feb 2019 20:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBHULE convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>); Fri, 8 Feb 2019 15:11:04 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:42561 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfBHULD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Feb 2019 15:11:03 -0500
Received: by mail-ot1-f52.google.com with SMTP id v23so7889465otk.9
        for <selinux@vger.kernel.org>; Fri, 08 Feb 2019 12:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zAHg3u9HUPmGAskx2F8dlRyoIDy9MLH+FFzeGqH0EIg=;
        b=FiVBIpkpFx5E8BL53u0zlT/gXD8L1ONwwNg6zFL7hGCqncKUMNMxSdUyDgsCSOpAyy
         LtarBYZeYKbctOHFZ9EI3evdyHgSnlhGTfBh/fuRu4kNdy9wjE0nOotxKEYt+59hL3T6
         rDr3GK25F1Mep0TtzaDiiIJJdTEDzxujvIpnqTgfFI6COss7tuu1B1TlXjmSYV1iGcu1
         ur0XMrrRVgd8ln7hTIgye2jKJPuc04SA1xMZQOXq35+h3hVjFEhp3Keq0JSHW9H+0OUr
         Q49UugwBDp41ZnfDEhxevReGBJ4YdXFIu9STtEzI5VnvvmMOF5bC1f2ImDST4nuH3D0H
         BZuw==
X-Gm-Message-State: AHQUAubxy1G3JeMSdxHbeOunH0WIJKszKrFox24JgaRs+cDOmULgvafR
        Zq1mdh8V9VSI/LiyypC32Mk/zrasP7UTWFcz7Lb2Xg==
X-Google-Smtp-Source: AHgI3IbhZTsTPuMPmi2LR4PO2rRdHIuOg3zcLA1eys9b4Eu9eTBnl0CCnLSWJDH5Ct9pwOlApiPhjJQWNWdv5pR4shA=
X-Received: by 2002:a05:6830:2010:: with SMTP id e16mr14149581otp.86.1549656662957;
 Fri, 08 Feb 2019 12:11:02 -0800 (PST)
MIME-Version: 1.0
References: <pjdtvhns3pq.fsf@redhat.com> <CAFqZXNt8Df0KX9qVmsGtxZroy6s1SFBt1Qmi5Psuv6z0+kTB7Q@mail.gmail.com>
 <pjdlg2rydoj.fsf@redhat.com> <476DC76E7D1DF2438D32BFADF679FC5649CDF45F@ORSMSX101.amr.corp.intel.com>
 <3a9f2281-aad4-58fd-ab8e-cb99a8da0fae@tycho.nsa.gov> <476DC76E7D1DF2438D32BFADF679FC5649CE8B71@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649CE8B71@ORSMSX101.amr.corp.intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 8 Feb 2019 21:10:54 +0100
Message-ID: <CAFqZXNusqhuYf_ZO2vrE74=p9nn76=qDm4bGeo89u_Xz-RFZGQ@mail.gmail.com>
Subject: Re: gcc 9.0.0 build issues
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 8, 2019 at 8:40 PM Roberts, William C
<william.c.roberts@intel.com> wrote:
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > Sent: Thursday, February 7, 2019 10:17 AM
> > To: Roberts, William C <william.c.roberts@intel.com>; Petr Lautrbach
> > <plautrba@redhat.com>; selinux@vger.kernel.org
> > Cc: Ondrej Mosnacek <omosnace@redhat.com>
> > Subject: Re: gcc 9.0.0 build issues
> >
> > On 2/7/19 12:52 PM, Roberts, William C wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Petr Lautrbach [mailto:plautrba@redhat.com]
> > >> Sent: Thursday, February 7, 2019 4:40 AM
> > >> To: selinux@vger.kernel.org
> > >> Cc: Petr Lautrbach <plautrba@redhat.com>; Roberts, William C
> > >> <william.c.roberts@intel.com>; Ondrej Mosnacek <omosnace@redhat.com>
> > >> Subject: Re: gcc 9.0.0 build issues
> > >>
> > >>
> > >> Ondrej Mosnacek <omosnace@redhat.com> writes:
> > >>
> > >>> On Fri, Feb 1, 2019 at 8:36 PM Petr Lautrbach <plautrba@redhat.com>
> > >>> wrote:
> > >>>> gcc-9.0.0-0.3.fc30.x86_64 from Fedora Rawhide:
> > >>>>
> > >>>> gcc version 9.0.0 20190119 (Red Hat 9.0.0-0.3) (GCC)
> > >>>>
> > >> ...
> > >>>> When libselinux is built separately, other CFLAGS is used:
> > >>>>
> > >>>> $ cd libselinux
> > >>>>
> > >>>> $ make DESTDIR=~/obj install install-pywrap ...
> > >>>>
> > >>>> make[1]: Entering directory
> > >>>> '/home/build/SELinuxProject-selinux/libselinux/src'
> > >>>>
> > >>>> cc -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self
> > >>>> -Wmissing-include-dirs -Wunused -Wunknown-pragmas -Wstrict-aliasing
> > >>>> -Wshadow -Wpointer-arith -Wbad-function-cast -Wcast-align
> > >>>> -Wwrite-strings -Waggregate-return -Wstrict-prototypes
> > >>>> -Wold-style-definition -Wmissing-prototypes -Wmissing-declarations
> > >>>> -Wmissing-noreturn -Wmissing-format-attribute -Wredundant-decls
> > >>>> -Wnested-externs -Winline -Winvalid-pch -Wvolatile-register-var
> > >>>> -Wdisabled-optimization -Wbuiltin-macro-redefined -Wattributes
> > >>>> -Wmultichar -Wdeprecated-declarations -Wdiv-by-zero
> > >>>> -Wdouble-promotion -Wendif-labels -Wextra -Wformat-extra-args
> > >>>> -Wformat-zero-length -Wformat=2 -Wmultichar -Woverflow
> > >>>> -Wpointer-to-int-cast -Wpragmas -Wno-missing-field-initializers
> > >>>> -Wno-sign-compare -Wno-format-nonliteral
> > >>>> -Wframe-larger-than=32768
> > >>>> -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions
> > >>>> -fasynchronous-unwind-tables -fdiagnostics-show-option
> > >>>> -funit-at-a-time -Werror -Wno-aggregate-return -Wno-redundant-decls
> > >>>> -fipa-pure-const -Wlogical-op -Wpacked-bitfield-compat -Wsync-nand
> > >>>> -Wcoverage-mismatch -Wcpp -Wformat-contains-nul -Wnormalized=nfc
> > >>>> -Wsuggest-attribute=const -Wsuggest-attribute=noreturn
> > >>>> -Wsuggest-attribute=pure -Wtrampolines -Wjump-misses-init
> > >>>> -Wno-suggest-attribute=pure -Wno-suggest-attribute=const
> > >>>> -U_FORTIFY_SOURCE
> > >>>> -D_FORTIFY_SOURCE=2
> > >>>> -Wstrict-overflow=5 -I../include -D_GNU_SOURCE
> > >>>> -DNO_ANDROID_BACKEND   -c -o booleans.o booleans.c
> > >>>> booleans.c: In function ‘security_get_boolean_names’:
> > >>>> booleans.c:39:5: error: assuming signed overflow does not occur
> > >>>> when changing X +- C1 cmp C2 to X cmp C2 -+ C1 [-Werror=strict-overflow]
> > >>>>     39 | int security_get_boolean_names(char ***names, int *len)
> > >>>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > >>>> cc1: all warnings being treated as errors
> > >>>
> > >>> This one is really weird... Perhaps a bug in GCC? At the very least
> > >>> the warning message and source code location are super confusing,
> > >>> which is a bug on its own...
> > >>
> > >> It's detected only with -Wstrict-overflow=3 and higher. Makefile in
> > >> libselinux uses level 5 which was added by commit
> > >> 9fe430345 ("Makefile: add -Wstrict-overflow=5 to CFLAGS)
> > >>
> > >> The problem code is on lines 84 and 85 in
> > >> libselinux/src/booleans.c:
> > >>
> > >> 84:        for (--i; i >= 0; --i)
> > >> 85:    free(n[i]);
> > >>
> > >>
> > >> It could be suppressed by something like this:
> > >>
> > >> --- a/libselinux/src/booleans.c
> > >> +++ b/libselinux/src/booleans.c
> > >> @@ -39,7 +39,7 @@ static int filename_select(const struct dirent
> > >> *d)
> > >>   int security_get_boolean_names(char ***names, int *len)  {
> > >>          char path[PATH_MAX];
> > >> -       int i, rc;
> > >> +       int i, j, rc;
> > >>          struct dirent **namelist;
> > >>          char **n;
> > >>
> > >> @@ -81,8 +81,8 @@ int security_get_boolean_names(char ***names, int
> > *len)
> > >>          free(namelist);
> > >>          return rc;
> > >>         bad_freen:
> > >> -       for (--i; i >= 0; --i)
> > >> -               free(n[i]);
> > >> +       for (j = 0; j < i; j++)
> > >> +               free(n[j]);
> > >>          free(n);
> > >>         bad:
> > >>          goto out;
> > >>
> > >>
> > >> William, what would you consider to be the right fix in this case?
> > >
> > > The previous code looks correct IMO, I can't see an actual problem.
> > > Looks like GCC complaining incorrectly or were missing something. In
> > > the case of gcc Incorrectly complaining I usually take a course of
> > > action to work around it, but Im not sure how other maintainers feel about that
> > @sds anything?
> >
> > AFAICS, the code is correct as is.  Not a fan of rewriting code to appease overly
> > zealous compilers...
> >
>
> So I looked at filing a bug with GCC, and one thing that helps it get looked at is sample code
> to trigger the problem. I'm not even seeing a GCC 9 release, so I am assuming it's in a dev
> mode?
>
> Since you have it running could you see if you can re-produce the error in a snippet and file the bug?

FWIW, I extracted the relevant part of the code and I managed to
reproduce the warning with this self-contained snippet in Compiler
Explorer:

https://gcc.godbolt.org/z/LlVva9

>
> I would also diff the object file with -frwapv to see if it is producing different code for that loop.
>
> Bill
--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
