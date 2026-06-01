Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA48370AD6
	for <selinux@vger.kernel.org>; Mon,  1 Jun 2026 19:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341140; cv=pass; b=m8puGkbkOAbc2jvzGlf6dSNt9h4rk41hzHZkBJaOpH+JGiDt93x29UWFCWweA/+aCpwEWVchwbBXsHV6/SkFvj9I/iGejgRu0Vtt75mqXsxYCY6cgLcJNcRXQqCyLK146jV1hTK7H/nsFIJBgE84CwWDZ64WUTFEhwcT1MtxO9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341140; c=relaxed/simple;
	bh=yPl+7um9cReLMSHEvMdQoEMLZw2wZbKrftm8d5lTmdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOqUtC8JarmRNIcjgqI+hF59cYDxLdK/wihb+RshaSCKGWR0XWJH+6wkiOocBtOsdBXfTbOFvlWkJAylFG5qkDrgCdHuBE9HggXIo+LftVGon1yvs8ljnMynLZUsEiWwltwdq/feDfy+PwMzCr5fS6YK5+5Rv5EI7e0kEtj9GW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/4p0211; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/4p0211"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so529058a12.3
        for <selinux@vger.kernel.org>; Mon, 01 Jun 2026 12:12:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780341138; cv=none;
        d=google.com; s=arc-20240605;
        b=JjyT2VjgwbU9kPzJJq/pQ0FXwp7dqfo0wxnyYTILiGcUx69K8NREiRoDUp5FskFDud
         NYdy3BrlacQBqrojYgjonlhv25ZwEssTY98gu3eMTDa/4/jYjEKvfaYfZ0EMxtIzc7NA
         hkTkA03YgLm5Ck4JCeWmr87LbxxHXncqJ7C00iuWCl0lfHTgM7lPjJGjBrXLr8tv0mLg
         4wSgP8VrlIrxK1xGvl4H1aoWi+lBthre/I60hhF8Npwn9rEMlPmksLzCfdTA7RLj9PaP
         MBxV+JVwz7i1G5VySNt7/n2EWJwd1FeJpnwyZovOAdSc6yq5umP38gy2Rn9HjIPS3ON8
         WYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OzDH6ar5/UkyBT7UwzX/rpmXmEEHrJC8RYFj46oHrtA=;
        fh=+SOaqlllj/x9oPTKUNrw3U6f73KzX4NDehXGGqjpy64=;
        b=RyVF5xkcn1Yq0fflAR+/6smd16b/Nkl+Hxz991nEvoX/z/gh+Mr15SEe08rgh6hACC
         55N2towR6xegNb2ek3nkK7oQuzFJ/I6oCpS5nzZuajMuF4cXMO6g0vM/0kO9YAnbaU0r
         WkBH2z3tNbTMHEAl58y7rYFs6R8WV/4CmlyWS0LH0GpyAtHNS8qPtX0mHOmA2iIL8yaq
         aMZaTGquu6gM4r9l9Mpzlho8HIKqUb+Jy9Spz4g+XbHnWFC+ttd9MLEEbmjLt3vVOmnO
         RAXcNR/qF6NK3qBJja+9INFrZTd4Ij5eQBCT8dhVC9o9Kz6p/RnB7tEv3weWETv7na84
         Q7ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780341138; x=1780945938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzDH6ar5/UkyBT7UwzX/rpmXmEEHrJC8RYFj46oHrtA=;
        b=h/4p0211j3bN5Y7ptqa4oS6eC20HXPckaFqOQSGXUUB/jRh92mruMNI88WONWMcYHg
         Q0zWTM7WUr904FsPfGBvNSs5+tx1GzkSgVDrwIBma7aHXF4/oiTGqu2trdBlr2nrfsCj
         LVmHS4xZHrG08FHVqEgB8PiR/5bRxaDF0dFDcgTwhAWlzw/UnPOFhE7fgsNmOFxn2aCn
         ul+VmH5fapgHv/KrXlH6lsmy398NzuEWAojfgGUxUwbYnjMlG3hWlQFG1yqTXWhiLqnx
         eWKZetPATqD014wgnoH8N/W4IWfZf/muUkuQZkl0WgjspNH54bEJtUUqlTMcbyDxtSOb
         xkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341138; x=1780945938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OzDH6ar5/UkyBT7UwzX/rpmXmEEHrJC8RYFj46oHrtA=;
        b=kpvsoNFLWtrPAj3RcfH+kntBxA49Jm8I7xbgfaELoNrEYI7rgLNaDHwiqqDRIGbVDo
         hAUEdUXk7VurXb5TfDfIVhBnpMU+7cgqf+sjbIsS6SpmHI6nXh8zZ27o1ILRBbnIaqtQ
         WSBOxcmnC1Nq9fR0XOREeSuNRe6zhWaDVGYIZKaqu5GWnByuj4QIFtcl7a6ZyigSXDdN
         gKlWGozVqSNCH4AUC4jW6vDcirdzJdD2G6WGJ+PjRMHwEx3ZBRwpZ9lpdk9b/3gYkNNG
         56ulLtXSZr8DKgQgSVPgq4q0faXWlOSVVQkdSQSrbTH8OMfLmfUx+4Wq5d1gjcuyujo5
         HmgQ==
X-Gm-Message-State: AOJu0Yw0PirCl8ttgeSqrmeQYWfACQkXnxni42tyfI2+AU0THLofilzy
	0J4FvTf04ycblMSQY+x7g5MxZLMUyDm79flIswp0xTGXUacDUSmiLX1Iblu/ArEEiFvtW+Rru2s
	K/fml3ZMaZfL7BqaxhP+5gMjs5nT21q0=
X-Gm-Gg: Acq92OF8JKxfz3FGAGjOMmFsxqSte1aiOclMXV6QXlApgnuq6cPmjTpUTyT92cysRHL
	yJ5N62PPBVBsgyN2OLEjZCuD8nL9fklbIgUnqJ2a0036RT00wVdkKw8QHyBrOtnorCUK0WfMjLE
	QO71HQYjVO53Gu0rDPv0uVAJ1ILOIbi3Hff3fCT0qZ9cCDymShiEPyVNQuEMXrwpgAiiuzB/NWq
	FE301eVKb4wqh18HWce0baHZuu6M4hrM3LH75CSowqXMWYVmnAbJN8JBMbNNX6facoLbQ0wMUk5
	OTWcqey93vhCamypn0ncWGdE4yTe
X-Received: by 2002:a05:6a21:4986:b0:39f:216:f400 with SMTP id
 adf61e73a8af0-3b427f98d67mr10439850637.14.1780341138473; Mon, 01 Jun 2026
 12:12:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601141904.60859-3-cahu@suse.de>
In-Reply-To: <20260601141904.60859-3-cahu@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 1 Jun 2026 15:12:07 -0400
X-Gm-Features: AVHnY4LkEafng5YlUVplqNNUPTk_e3gNONs99yXUkfe3sR7HISS9ZoOpjCUcmvA
Message-ID: <CAEjxPJ6icHimK5FJG572NF+GMbZ54cS3T3=imi3y9hiFs6ATUg@mail.gmail.com>
Subject: Re: [PATCH v3] libsemanage: Require LIBSO before SWIGSO and
 SWIGRUBYSO (bsc#1266385)
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, lautrbach@redhat.com, fvogt@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 10:26=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> We encountered race conditions where the built order was:
> 1. libsemanage.a
> 2. python-3.13_semanage.so
> 3. libsemanage.so.*
>
> That happened when make was called with `-j2`.
>
> In this case, python-3.13_semanage.so tries to use libsemanage.a and
> - on s390x: succeeds and builds an incorrect python-3.13_semanage.so
>   (that one was found during product testing)
> - on x86: fails (manually reproduced, never encountered IRL)
>   Reproducer:
>   ```
>   cd selinux/libsemanage/src
>   make clean
>   make pywrap
>   find . -wholename "*libsemanage.so*" -delete
>   find . -wholename "*python*.so" -delete
>   make python-3.13_semanage.so
>   -> fails
>   ```
>
> Therefor hard-require "all" when DISABLE_SHARED=3Dn
> so that LIBSO is present before SWIGSO and
> probably also SWIGRUBYSO.
>
> Signed-off-by: Cathy Hu <cahu@suse.de>
> ---
>  libsemanage/src/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index f870dc68..0241ef71 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -82,10 +82,10 @@ $(SWIGLOBJ): $(SWIGCOUT)
>  $(SWIGRUBYLOBJ): $(SWIGRUBYCOUT)
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS) $(RUBYINC) -fPIC -DSHA=
RED -c -o $@ $<
>
> -$(SWIGSO): $(SWIGLOBJ)
> +$(SWIGSO): $(SWIGLOBJ) all
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $<=
 -lsemanage $(PYLIBS)
>
> -$(SWIGRUBYSO): $(SWIGRUBYLOBJ)
> +$(SWIGRUBYSO): $(SWIGRUBYLOBJ) all
>         $(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -L. -fPIC -shared -o $@ $^=
 -lsemanage $(RUBYLIBS)

This appears to break the build,
from https://github.com/stephensmalley/selinux/actions/runs/26775577869/job=
/78926174312
:

make[2]: Entering directory '/home/runner/work/selinux/selinux/libsemanage/=
src'
swig -Wall -ruby -o semanageswig_ruby_wrap.c -outdir ./ semanageswig_ruby.i
clang -fdeclspec -I/tmp/destdir/usr/include -I../include
-I../../libselinux/include -D_GNU_SOURCE -Wno-error
-Wno-unused-but-set-variable -Wno-unused-variable -Wno-shadow
-Wno-unused-parameter -Wno-missing-prototypes
-Wno-missing-field-initializers
-I/opt/hostedtoolcache/Ruby/3.3.11/x64/include/ruby-3.3.0/x86_64-linux
-I/opt/hostedtoolcache/Ruby/3.3.11/x64/include/ruby-3.3.0 -fPIC
-DSHARED -c -o rubysemanageswig_ruby_wrap.lo semanageswig_ruby_wrap.c
clang -fdeclspec -I/tmp/destdir/usr/include -I../include
-I../../libselinux/include -D_GNU_SOURCE -L/tmp/destdir/usr/lib -L.
-fPIC -shared -o ruby_semanage.so rubysemanageswig_ruby_wrap.lo all
-lsemanage -L/opt/hostedtoolcache/Ruby/3.3.11/x64/lib
-L/opt/hostedtoolcache/Ruby/3.3.11/x64/lib/x86_64-linux
-Wl,-rpath,/opt/hostedtoolcache/Ruby/3.3.11/x64/lib
-L/opt/hostedtoolcache/Ruby/3.3.11/x64/lib -lruby
clang: error: no such file or directory: 'all'
make[2]: *** [Makefile:89: ruby_semanage.so] Error 1
make[2]: Target 'install-rubywrap' not remade because of errors.
make[2]: Leaving directory '/home/runner/work/selinux/selinux/libsemanage/s=
rc'
make[1]: *** [Makefile:23: install-rubywrap] Error 2
make[1]: Leaving directory '/home/runner/work/selinux/selinux/libsemanage'
make: *** [Makefile:45: install-rubywrap] Error 1
Error: Process completed with exit code 2.
