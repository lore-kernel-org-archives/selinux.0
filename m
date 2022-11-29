Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B780C46467
	for <selinux@archiver.kernel.org>; Tue, 29 Nov 2022 16:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiK2QPa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 29 Nov 2022 11:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiK2QPS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 29 Nov 2022 11:15:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAEF25D1
        for <selinux@vger.kernel.org>; Tue, 29 Nov 2022 08:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669738462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vngNi6TUBp9i3iqj9IZtQhZLbkpXHm/dB1FajdDq0cY=;
        b=AqkItZPLgktN/pr88JOVcfaRSCqoKLBaHL4xkVB+PaVObe0Vou3IVFCkeX8SMOTu2CT8E5
        aqjQ5O4FRU4TzbkWO/qklctZhzqF+9YCebX5q7M0G7c2PMelNitEkXZBXiC/xEUKlK7Yyp
        SHaImdT8vUiwAxCYX0yfz5LS7mak6cU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-8b8G2-plPW6sVbd6VifDJg-1; Tue, 29 Nov 2022 11:14:21 -0500
X-MC-Unique: 8b8G2-plPW6sVbd6VifDJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF6C0801585;
        Tue, 29 Nov 2022 16:14:20 +0000 (UTC)
Received: from localhost (ovpn-192-247.brq.redhat.com [10.40.192.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1F7540C2140;
        Tue, 29 Nov 2022 16:14:20 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org, James Carter <jwcart2@gmail.com>
Subject: Re: [RFC PATCH] Use `pip install` instead of `setup.py install`
In-Reply-To: <87fse14u6u.fsf@redhat.com>
References: <20221122161106.55037-1-lautrbach@redhat.com>
 <CAP+JOzRit39R5OKLFvHt0CdOixEHrBvybq3UWa6VicwMHG5NQA@mail.gmail.com>
 <CAP+JOzTzBC2mW=9mH=T2SYNpk8cXD0-MMcJjKpUeeUs9nAy=ww@mail.gmail.com>
 <87fse14u6u.fsf@redhat.com>
Date:   Tue, 29 Nov 2022 17:14:20 +0100
Message-ID: <87cz954u1v.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <lautrbach@redhat.com> writes:

> James Carter <jwcart2@gmail.com> writes:
>
>> On Wed, Nov 23, 2022 at 11:04 AM James Carter <jwcart2@gmail.com> wrote:
>>>
>>> On Tue, Nov 22, 2022 at 11:15 AM Petr Lautrbach <lautrbach@redhat.com> wrote:
>>> >
>>> > Fixes:
>>> >     /usr/lib/python3.11/site-packages/setuptools/command/install.py:34: SetuptoolsDeprecationWarning: setup.py install is deprecated. Use build and pip and other standards-based tools.
>>> >
>>> > Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>>>
>>> Acked-by: James Carter <jwcart2@gmail.com>
>>>
>>> > ---
>>> >  README.md                | 4 +++-
>>> >  libselinux/src/Makefile  | 2 +-
>>> >  python/sepolicy/Makefile | 2 +-
>>> >  3 files changed, 5 insertions(+), 3 deletions(-)
>>> >
>>> > diff --git a/README.md b/README.md
>>> > index 529b7e46c871..e11b0028f4ba 100644
>>> > --- a/README.md
>>> > +++ b/README.md
>>> > @@ -62,6 +62,7 @@ dnf install \
>>> >  # For Python and Ruby bindings
>>> >  dnf install \
>>> >      python3-devel \
>>> > +    python3-pip \
>>
>> So I noticed that I get the following message when building:
>>   Processing /home/jim/work/selinux/python/sepolicy
>>     Preparing metadata (setup.py): started
>>     Preparing metadata (setup.py): finished with status 'done'
>>   Using legacy 'setup.py install' for sepolicy, since package 'wheel'
>> is not installed.
>>
>> Installing python3-wheel gives the following instead:
>>   Building wheels for collected packages: sepolicy
>>     Building wheel for sepolicy (setup.py): started
>>     Building wheel for sepolicy (setup.py): finished with status 'done'
>>
>> It is not a strict dependency, but maybe we should add python3-wheel.
>> Unless, of course, there is some reason we don't want to be creating
>> these python wheels.
>>
>
>
> I don't see any reason why we wouldn't use it. Below is the diff. From
> what I know, .dist-info is the new and better format for metadata. Also,
> the Fedora packaging guidelines suggest using .dist-info.
>
> I'll send another patch with python3-wheel and python3-setuptools which
> is necessary.
>

without python3-wheel vs with python3-wheel

@@ -152,12 +152,14 @@
 ./usr/lib64/python3.11
 ./usr/lib64/python3.11/site-packages
 ./usr/lib64/python3.11/site-packages/selinux
-./usr/lib64/python3.11/site-packages/selinux-3.4-py3.11.egg-info
-./usr/lib64/python3.11/site-packages/selinux-3.4-py3.11.egg-info/dependency_links.txt
-./usr/lib64/python3.11/site-packages/selinux-3.4-py3.11.egg-info/installed-files.txt
-./usr/lib64/python3.11/site-packages/selinux-3.4-py3.11.egg-info/PKG-INFO
-./usr/lib64/python3.11/site-packages/selinux-3.4-py3.11.egg-info/SOURCES.txt
-./usr/lib64/python3.11/site-packages/selinux-3.4-py3.11.egg-info/top_level.txt
+./usr/lib64/python3.11/site-packages/selinux-3.4.dist-info
+./usr/lib64/python3.11/site-packages/selinux-3.4.dist-info/direct_url.json
+./usr/lib64/python3.11/site-packages/selinux-3.4.dist-info/INSTALLER
+./usr/lib64/python3.11/site-packages/selinux-3.4.dist-info/METADATA
+./usr/lib64/python3.11/site-packages/selinux-3.4.dist-info/RECORD
+./usr/lib64/python3.11/site-packages/selinux-3.4.dist-info/REQUESTED
+./usr/lib64/python3.11/site-packages/selinux-3.4.dist-info/top_level.txt
+./usr/lib64/python3.11/site-packages/selinux-3.4.dist-info/WHEEL
 ./usr/lib64/python3.11/site-packages/selinux/audit2why.cpython-311-x86_64-linux-gnu.so
 ./usr/lib64/python3.11/site-packages/_selinux.cpython-311-x86_64-linux-gnu.so
 ./usr/lib64/python3.11/site-packages/selinux/__init__.py
@@ -202,12 +204,14 @@
 ./usr/lib/python3.11/site-packages/sepolgen/util.py
 ./usr/lib/python3.11/site-packages/sepolgen/yacc.py
 ./usr/lib/python3.11/site-packages/sepolicy
-./usr/lib/python3.11/site-packages/sepolicy-3.4-py3.11.egg-info
-./usr/lib/python3.11/site-packages/sepolicy-3.4-py3.11.egg-info/dependency_links.txt
-./usr/lib/python3.11/site-packages/sepolicy-3.4-py3.11.egg-info/installed-files.txt
-./usr/lib/python3.11/site-packages/sepolicy-3.4-py3.11.egg-info/PKG-INFO
-./usr/lib/python3.11/site-packages/sepolicy-3.4-py3.11.egg-info/SOURCES.txt
-./usr/lib/python3.11/site-packages/sepolicy-3.4-py3.11.egg-info/top_level.txt
+./usr/lib/python3.11/site-packages/sepolicy-3.4.dist-info
+./usr/lib/python3.11/site-packages/sepolicy-3.4.dist-info/direct_url.json
+./usr/lib/python3.11/site-packages/sepolicy-3.4.dist-info/INSTALLER
+./usr/lib/python3.11/site-packages/sepolicy-3.4.dist-info/METADATA
+./usr/lib/python3.11/site-packages/sepolicy-3.4.dist-info/RECORD
+./usr/lib/python3.11/site-packages/sepolicy-3.4.dist-info/REQUESTED
+./usr/lib/python3.11/site-packages/sepolicy-3.4.dist-info/top_level.txt
+./usr/lib/python3.11/site-packages/sepolicy-3.4.dist-info/WHEEL
 ./usr/lib/python3.11/site-packages/sepolicy/booleans.py
 ./usr/lib/python3.11/site-packages/sepolicy/communicate.py
 ./usr/lib/python3.11/site-packages/sepolicy/generate.py




>
> Thanks,
>
> Petr
>
>
>>
>>> >      ruby-devel \
>>> >      swig
>>> >  ```
>>> > @@ -92,6 +93,7 @@ apt-get install --no-install-recommends --no-install-suggests \
>>> >  # For Python and Ruby bindings
>>> >  apt-get install --no-install-recommends --no-install-suggests \
>>> >      python3-dev \
>>> > +    python3-pip \
>>> >      ruby-dev \
>>> >      swig
>>> >  ```
>>> > @@ -102,7 +104,7 @@ To build and install everything under a private directory, run:
>>> >
>>> >      make DESTDIR=~/obj install install-rubywrap install-pywrap
>>> >
>>> > -On Debian `PYTHON_SETUP_ARGS=--install-layout=deb` needs to be set when installing the python wrappers in order to create the correct python directory structure.
>>> > +On Debian `PYTHON_SETUP_ARGS='--install-option "--install-layout=deb"'` needs to be set when installing the python wrappers in order to create the correct python directory structure.
>>> >
>>> >  To run tests with the built libraries and programs, several paths (relative to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PATH` and `$PYTHONPATH`.
>>> >  This can be done using [./scripts/env_use_destdir](./scripts/env_use_destdir):
>>> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>>> > index dc2848322e4d..0f6396ababa4 100644
>>> > --- a/libselinux/src/Makefile
>>> > +++ b/libselinux/src/Makefile
>>> > @@ -187,7 +187,7 @@ install: all
>>> >         ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
>>> >
>>> >  install-pywrap: pywrap
>>> > -       $(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
>>> > +       $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
>>> >         install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init__.py
>>> >         ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
>>> >
>>> > diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
>>> > index d983e409e5e6..57a2e55edbbf 100644
>>> > --- a/python/sepolicy/Makefile
>>> > +++ b/python/sepolicy/Makefile
>>> > @@ -27,7 +27,7 @@ test:
>>> >         @$(PYTHON) test_sepolicy.py -v
>>> >
>>> >  install:
>>> > -       $(PYTHON) setup.py install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
>>> > +       $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS) .
>>> >         [ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
>>> >         install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
>>> >         (cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
>>> > --
>>> > 2.38.1
>>> >

