Return-Path: <SRS0=obw9=P5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF85C2F3A6
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 13:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FD62085A
	for <selinux@archiver.kernel.org>; Mon, 21 Jan 2019 13:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfAUNZr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:25:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbfAUNZr (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 21 Jan 2019 08:25:47 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D05E81F01;
        Mon, 21 Jan 2019 13:25:47 +0000 (UTC)
Received: from workstation (unknown [10.43.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A1AB6531D;
        Mon, 21 Jan 2019 13:25:46 +0000 (UTC)
References: <20190120191933.21343-1-nicolas.iooss@m4x.org>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH 1/3] Travis-CI: upgrade PyPy to 6.0
In-reply-to: <20190120191933.21343-1-nicolas.iooss@m4x.org>
Date:   Mon, 21 Jan 2019 14:25:44 +0100
Message-ID: <pjdk1iydtwn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 21 Jan 2019 13:25:47 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> PyPy 6.0 was released in April 2018 but became available on 
> Travis-CI
> only recently. Now that it is available, use it.
>
> While at it, compile Python modules with libpypy-c.so, now that 
> PyPy
> provides this library. This would enable linking Python modules 
> with
> -Wl,-no-undefined (or -Wl,-z,defs) and help fixing issues with
> https://github.com/SELinuxProject/selinux/pull/130.
>
> Tracking issues:
> * https://github.com/travis-ci/travis-ci/issues/9542
> * https://travis-ci.community/t/pypy-2-7-on-xenial/889
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!

Acked-by: Petr Lautrbach <plautrba@redhat.com>

https://github.com/SELinuxProject/selinux/pull/132


> ---
>  .travis.yml | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 08a29b2f5adc..b8e97f83bbcd 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -20,10 +20,8 @@ env:
>      - PYVER=python2.7 RUBYLIBVER=2.5.1
>      - PYVER=python3.5 RUBYLIBVER=2.5.1
>      - PYVER=python3.6 RUBYLIBVER=2.5.1
> -    # pypy2.7 seems not to be available in Travis-CI Xenial 
> template yet.
> -    # https://github.com/travis-ci/travis-ci/issues/9542
> -    #- PYVER=pypy RUBYLIBVER=2.5.1
> -    - PYVER=pypy3.5 RUBYLIBVER=2.5.1
> +    - PYVER=pypy2.7-6.0 RUBYLIBVER=2.5.1
> +    - PYVER=pypy3.5-6.0 RUBYLIBVER=2.5.1
>  
>      # Test several Ruby versions
>      - PYVER=python3.7 RUBYLIBVER=2.4
> @@ -98,8 +96,12 @@ before_script:
>    - export PYTHON="$VIRTUAL_ENV/bin/python"
>    # Use the header files in /opt/python/... for Python because 
>    the virtualenvs do not provide Python.h
>    - export PKG_CONFIG_PATH="/opt/python/$($PYTHON -c 'import 
>    sys;print("%d.%d.%d" % sys.version_info[:3])')/lib/pkgconfig"
> -  # PyPy does not provide a config file for pkg-config nor a 
> pypy-c.so
> -  - if echo "$PYVER" | grep -q pypy ; then export 
> PYINC=-I$($PYTHON -c 'import sys;print(sys.prefix)')/include 
> PYLIBS= ; fi
> +  # PyPy does not provide a config file for pkg-config
> +  # libpypy-c.so is provided in bin/libpypy-c.so for PyPy and 
> bin/libpypy3-c.so for PyPy3
> +  - if echo "$PYVER" | grep -q pypy ; then
> +        export PYINC=-I$($PYTHON -c 'import 
> sys;print(sys.prefix)')/include ;
> +        export PYLIBS="$($PYTHON -c 'import sys;print("-L%s/bin 
> -l%s" % (sys.prefix, "pypy-c" if sys.version_info < (3,) else 
> "pypy3-c"))')" ;
> +    fi
>  
>    # Find the Ruby executable with version $RUBYLIBVER
>    - rvm reinstall ruby-$RUBYLIBVER --binary

