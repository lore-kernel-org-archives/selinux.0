Return-Path: <SRS0=6dkg=6B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58FCC2BB1D
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 20:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D46221E9
	for <selinux@archiver.kernel.org>; Fri, 17 Apr 2020 20:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2uXwb7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDQUuH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgDQUuG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Apr 2020 16:50:06 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70596C061A0C
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 13:50:05 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i2so3473876ils.12
        for <selinux@vger.kernel.org>; Fri, 17 Apr 2020 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D33Ywwx4zsVYQojB4N8AUsgLi5QOZg4T/WvD1fJ7FOw=;
        b=L2uXwb7yPY+nikjNTYUmAGOixO/ABcctcxv28tgAnKZDgTpWT/yZK50EZVJaf1ENO8
         VIJ0h9gi1SbS3QAhAkbRFley3zG6hWWdZZg57leDeseEoNe1xigP1wpmh7EEKR7Uuvyj
         GTaLR4oxaaHdMwvAM8XP/kxxsKN6uD3p64nTzNovOyQbc/+NnpDWA0JFBV4TSlsw6YCT
         31kfhI1gn+/Uw3SHlrTuuQ1UcVj6mwFTIF7Ft9ad7RLopKHvFRiPXiMVBO6ndRzJFkp6
         tYK2gDCHEIlmhzkOWJ3Qzsb50AnjjBUvD7c0u/G+pdM9KZGQ7Z4FzL3tIbbXDSF3qKwe
         lcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D33Ywwx4zsVYQojB4N8AUsgLi5QOZg4T/WvD1fJ7FOw=;
        b=YhCNytynISIR78ViDQ7LUybnP5Z/e7rQ15OP7Thm3QFtoBEQYvjg/DZjPyumDE5vhZ
         OwwjOzwgoi1c5O6EvoyD0Z7TkhIM3arocM/XwHtomeR8Qg48wLT3VY/11/jvIc/8KTut
         mykEDS28tl+KwC69TzhmxBHhrosdAbPH9PBqlzUI7vJquPvG9mpk1VgV02I2GtRhTNpN
         3fG/9qWg9QAB0Hdyp4ZBpQAlhCBA022EHjTjaW4dr+gQQuP2/97zUik7xFrlDyk1bF2m
         ymF7W/ttGiLIEBgH8554XvHsWSo1UoWWWZ4tAB6V+/oO6LDsg9CmvP+ci3UW5uaC5V9O
         mItQ==
X-Gm-Message-State: AGi0PuZtAvE4ci72TY29RuV3+Wk14HCIKaUcFanuKJVWpPrv4R9omb7f
        ZJjZPHl8VUVvOtrMlK7ZhpWWqi8pgN8KDkYjQiY=
X-Google-Smtp-Source: APiQypIH9GU4W2telQkBHwUf7tQpIxLaHpM7y0Ia79pZZziBIvk65jmF6aYyQwJIvZPurWmK/rY7omu5HtY9oLHvaz4=
X-Received: by 2002:a92:c6c8:: with SMTP id v8mr4769422ilm.129.1587156604513;
 Fri, 17 Apr 2020 13:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200412081001.23246-1-nicolas.iooss@m4x.org> <CAFftDdpmF6H21DmDLaYwJW9QQx3hBq7i14SEsKeA=ktPE0brKA@mail.gmail.com>
 <CAJfZ7==YbLMj4mKtD9KRA5YE=ySBMKZ9V45OfD1Uod5rPhzhRw@mail.gmail.com> <476DC76E7D1DF2438D32BFADF679FC5649ECC02C@ORSMSX101.amr.corp.intel.com>
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5649ECC02C@ORSMSX101.amr.corp.intel.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 17 Apr 2020 15:49:53 -0500
Message-ID: <CAFftDdqUOczNTKnQH2F3EvydYce+TwSQ+vCSF8mXfFkpi7FmjQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: add missing glue code to grab errno in
 Python bindings
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

>
> > -----Original Message-----
> > From: selinux-owner@vger.kernel.org [mailto:selinux-owner@vger.kernel.org]
> > On Behalf Of Nicolas Iooss
> > Sent: Monday, April 13, 2020 11:15 AM
> > To: William Roberts <bill.c.roberts@gmail.com>
> > Cc: SElinux list <selinux@vger.kernel.org>
> > Subject: Re: [PATCH 1/3] libselinux: add missing glue code to grab errno in Python
> > bindings
> >
> > On Mon, Apr 13, 2020 at 4:18 PM William Roberts <bill.c.roberts@gmail.com>
> > wrote:
> > >
> > > On Sun, Apr 12, 2020 at 3:12 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> > > >
> > > > The Python bindings for libselinux expose functions such as
> > > > avc_has_perm(), get_ordered_context_list(), etc. When these
> > > > functions encounter an error, they set errno accordingly and return
> > > > a negative value. In order to get the value of errno from Python
> > > > code, it needs to be "forwarded" in a way. This is achieved by glue
> > > > code in selinuxswig_python_exception.i, which implement raising an
> > > > OSError exception from the value of errno.
> > > >
> > > > selinuxswig_python_exception.i was only generating glue code from
> > > > functions declared in selinux.h and not in other headers. Add other
> > > > headers.
> > > >
> > > > selinuxswig_python_exception.i is generated by "bash exception.sh".
> > > > Mark the fact that exception.sh is a Bash script by adding a
> > > > shebang. This makes "shellcheck" not warn about the Bash array which
> > > > is used to list header files.
> > > >
> > > > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > > > ---
> > > >  libselinux/src/exception.sh                   |  18 +-
> > > >  libselinux/src/selinuxswig_python_exception.i | 396
> > > > ++++++++++++++++++
> > > >  2 files changed, 412 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/libselinux/src/exception.sh
> > > > b/libselinux/src/exception.sh index 33ceef804af5..644c7a05ec54
> > > > 100755
> > > > --- a/libselinux/src/exception.sh
> > > > +++ b/libselinux/src/exception.sh
> > > > @@ -1,3 +1,5 @@
> > > > +#!/bin/bash
> > > > +
> > > >  function except() {
> > > >  case $1 in
> > > >      selinux_file_context_cmp) # ignore @@ -15,10 +17,22 @@ echo "
> > > >  ;;
> > > >  esac
> > > >  }
> > > > -if ! ${CC:-gcc} -x c -c -I../include -o temp.o - -aux-info temp.aux
> > > > < ../include/selinux/selinux.h
> > > > +
> > > > +# Make sure that selinux.h is included first in order not to depend
> > > > +on the order # in which "#include <selinux/selinux.h>" appears in other files.
> > > > +FILE_LIST=(
> > > > +    ../include/selinux/selinux.h
> > > > +    ../include/selinux/avc.h
> > > > +    ../include/selinux/context.h
> > > > +    ../include/selinux/get_context_list.h
> > > > +    ../include/selinux/get_default_type.h
> > > > +    ../include/selinux/label.h
> > > > +    ../include/selinux/restorecon.h
> > > > +)
> > > > +if ! cat "${FILE_LIST[@]}" | ${CC:-gcc} -x c -c -I../include -o
> > > > +temp.o - -aux-info temp.aux
> > > >  then
> > > >      # clang does not support -aux-info so fall back to gcc
> > > > -    gcc -x c -c -I../include -o temp.o - -aux-info temp.aux <
> > ../include/selinux/selinux.h
> > > > +    cat "${FILE_LIST[@]}" | gcc -x c -c -I../include -o temp.o -
> > > > + -aux-info temp.aux
> > > >  fi
> > > >  for i in `awk '/<stdin>.*extern int/ { print $6 }' temp.aux`; do
> > > > except $i ; done  rm -f -- temp.aux temp.o diff --git
> > > > a/libselinux/src/selinuxswig_python_exception.i
> > > > b/libselinux/src/selinuxswig_python_exception.i
> > > > index cf6582595ee7..9f1f86a5564d 100644
> > > > --- a/libselinux/src/selinuxswig_python_exception.i
> > > > +++ b/libselinux/src/selinuxswig_python_exception.i
> > > > @@ -952,3 +952,399 @@
> > > >    }
> > > >  }
> > > >
> > > > +
> > > > +%exception avc_sid_to_context {
> > > > +  $action
> > > > +  if (result < 0) {
> > > > +     PyErr_SetFromErrno(PyExc_OSError);
> > > > +     SWIG_fail;
> > > > +  }
> > > > +}
> > > > +
> > > > +
> > > > +%exception avc_sid_to_context_raw {
> > > > +  $action
> > > > +  if (result < 0) {
> > > > +     PyErr_SetFromErrno(PyExc_OSError);
> > > > +     SWIG_fail;
> > > > +  }
> > > > +}
> > [...]
> > >
> > > A few comments:
> > > - overall looks fine, builds and works as expected.
> > > - Why the double newline space on the exception swig file? The other
> > > .i files seem to do a single newline?
> > >   is their something I am missing with syntax?
> > > - I have the following whitespace warning:
> > > Applying: libselinux: add missing glue code to grab errno in Python
> > > bindings
> > > .git/rebase-apply/patch:444: new blank line at EOF.
> > > +
> > > warning: 1 line adds whitespace errors.
> >
> > The last two points are due to the way the file is generated, by exception.sh:
> >
> > echo "
> > %exception $1 {
> >   \$action
> >   if (result < 0) {
> >      PyErr_SetFromErrno(PyExc_OSError);
> >      SWIG_fail;
> >   }
> > }
> > "
> > ... this introduces blank lines both before and after each exception blocks. We
> > could remove the one after the block by using }" in the shell script. I will submit a
> > patch that does this once this patch is merged, as this makes the file cleaner.
>
> WFM. Thanks for fixing this, I used the python bindings eons ago and remember
> being frustrated I didn't get really good errors.
>
> Acked-by: William Roberts <william.c.roberts@intel.com>

Merged:
https://github.com/SELinuxProject/selinux/pull/221
