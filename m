Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A37E267B10
	for <selinux@vger.kernel.org>; Tue, 11 Feb 2025 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311878; cv=none; b=oz/c21WQLOx+TgIKTV9iAEn6Q3z5XKlWaSub/R1cVePyiA/QHHooocUFxvmWiGnhrj1XfWRAHHgsfCigTVXwSVxTV5pYbgzLlJ2lMp/hEYHi4wW489SuSlGoSVGd52tMn7jTgjmQKuWfKsOZ5M58WMN92MG1K0SXuaN5f+ztLQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311878; c=relaxed/simple;
	bh=62UEhC4p5MqK7FCNG7eSEsLvykepY/oe0mQcjWyO+RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LG4WvxhbjzeL8acpcCoKXvASPIrzZbmp7gBq5hNGwlHAxBxmY/yaSfJzwYmCR+Fd8T9GDodrFC1AKGL8hMkPHToWXTepZfDGTe9ReNO/LIJU7CW0EOEo4Vr9EwBq094Iu7u3OavfGGezEn1nf5RSTEHHzP+dCQMaXfLUxHdEGjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GfB7In2m; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GfB7In2m"
Received: from [192.168.1.13] (pool-96-241-22-207.washdc.fios.verizon.net [96.241.22.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6BA1D2107AB0;
	Tue, 11 Feb 2025 14:11:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BA1D2107AB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739311876;
	bh=Txmn4WCsilAviIqpv0eFl9nlwMxmJRAKsBJLsjqVkGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GfB7In2mJOCIz5awG7s3eHhJANf5yPHhF6oT3EdcTwuQp9VYXG3UymKdHZuDI6VDC
	 /ZK1wsTHRKQ8rMwT+wC7bHE1mWH9RkuP4gajICqShMYIxCAc5sSYN2kd0kjxqDaZm1
	 RiABoo/P+bFAGTlUerm5JKWQh44joMEu6sQ2z3II=
Message-ID: <9316b48f-64f0-469b-8dde-1386aa13d384@linux.microsoft.com>
Date: Tue, 11 Feb 2025 17:11:15 -0500
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Support static-only builds
To: Alyssa Ross <hi@alyssa.is>, selinux@vger.kernel.org
Cc: Nicolas Iooss <nicolas.iooss@m4x.org>
References: <20250211211651.1297357-3-hi@alyssa.is>
Content-Language: en-US
From: Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20250211211651.1297357-3-hi@alyssa.is>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/11/2025 4:16 PM, Alyssa Ross wrote:
> Sometimes it's useful to have a static-only toolchain.  This can be
> due to targetting some weird embedded platform, or it can be because
> it ensures that no dynamic libraries are sneaking into a system that's
> supposed to be 100% static due to non-cooperative build systems.  Most
> build systems support static-only builds, e.g. autoconf provides a
> --disable-shared configure option.
> 
> selinux's custom make-based build system did not support such an
> option, so here I've added one.  Apart from the obvious changes, I had
> to make the utilities that use external libraries link against them
> manually, because that can't be inferred from the static selinux
> libraries.  For downstream users of libselinux using pkg-config, this
> shouldn't be a problem, because libselinux.pc already includes the
> Requires.private line that specifies libpcre should be linked against
> as well.
> 
> Signed-off-by: Alyssa Ross <hi@alyssa.is>
> ---
> Changes since v3:
> 
>   • Resolve conflicts.
>   • Add selabel_compare to PCRE_USERS.
>   • Use pkg-config for libselinux in policycoreutils, so PCRE is linked.
> 
> v2: https://lore.kernel.org/selinux/20211113141616.361640-1-hi@alyssa.is
> 
>   libselinux/src/Makefile              | 11 ++++++++---
>   libselinux/utils/Makefile            |  8 +++++++-
>   libsemanage/src/Makefile             |  9 +++++++--
>   libsepol/src/Makefile                | 11 ++++++++---
>   policycoreutils/Makefile             |  5 +++++
>   policycoreutils/load_policy/Makefile |  2 +-
>   policycoreutils/newrole/Makefile     |  2 +-
>   policycoreutils/run_init/Makefile    |  2 +-
>   policycoreutils/secon/Makefile       |  2 +-
>   policycoreutils/semodule/Makefile    |  3 ++-
>   policycoreutils/sestatus/Makefile    |  2 +-
>   policycoreutils/setfiles/Makefile    |  2 +-
>   policycoreutils/setsebool/Makefile   |  3 ++-
>   policycoreutils/unsetfiles/Makefile  |  2 +-
>   14 files changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 213c7d34..261c22d4 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -147,7 +147,10 @@ endif
>   
>   SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./ $(DISABLE_FLAGS)
>   
> -all: $(LIBA) $(LIBSO) $(LIBPC)
> +all: $(LIBA) $(LIBPC)
> +ifneq ($(DISABLE_SHARED),y)
> +all: $(LIBSO)
> +endif
>   
>   pywrap: all selinuxswig_python_exception.i
>   	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) setup.py build_ext
> @@ -186,11 +189,13 @@ $(SWIGRUBYCOUT): $(SWIGRUBYIF)
>   install: all
>   	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
>   	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> -	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
> -	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>   	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
>   	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> +ifneq ($(DISABLE_SHARED),y)
> +	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
> +	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>   	ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
> +endif
>   
>   install-pywrap: pywrap
>   	CFLAGS="$(CPPFLAGS) $(CFLAGS) $(SWIG_CFLAGS)" $(PYTHON) -m pip install --prefix=$(PREFIX) `test -n "$(DESTDIR)" && echo --root $(DESTDIR) --ignore-installed --no-deps` $(PYTHON_SETUP_ARGS) .
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 0d7095b1..6b1dc7c9 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -53,7 +53,13 @@ else
>   TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
>   endif
>   
> -sefcontext_compile: LDLIBS += ../src/libselinux.a $(PCRE_LDLIBS) -lsepol
> +sefcontext_compile: LDLIBS += ../src/libselinux.a -lsepol
> +
> +PCRE_USERS = matchpathcon sefcontext_compile selabel_compare \
> +	selabel_digest selabel_get_digests_all_partial_matches \
> +	selabel_lookup selabel_lookup_best_match \
> +	selabel_partial_match
> +$(PCRE_USERS): LDLIBS += $(PCRE_LDLIBS)
>   
>   all: $(TARGETS)
>   
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 8dfbd762..7d60b1e9 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -67,7 +67,10 @@ SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
>   
>   SWIGRUBY = swig -Wall -ruby -o $(SWIGRUBYCOUT) -outdir ./
>   
> -all: $(LIBA) $(LIBSO) $(LIBPC)
> +all: $(LIBA) $(LIBPC)
> +ifneq ($(DISABLE_SHARED),y)
> +all: $(LIBSO)
> +endif
>   
>   pywrap: all $(SWIGSO)
>   
> @@ -137,11 +140,13 @@ swigify: $(SWIGIF)
>   install: all
>   	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
>   	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> -	install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
>   	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
>   	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
>   	test -f $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION) || install -m 644 -D semanage.conf $(DESTDIR)$(DEFAULT_SEMANAGE_CONF_LOCATION)
> +ifneq ($(DISABLE_SHARED),y)
> +	install -m 755 $(LIBSO) $(DESTDIR)$(LIBDIR)
>   	cd $(DESTDIR)$(LIBDIR) && ln -sf $(LIBSO) $(TARGET)
> +endif
>   
>   install-pywrap: pywrap
>   	test -d $(DESTDIR)$(PYTHONLIBDIR) || install -m 755 -d $(DESTDIR)$(PYTHONLIBDIR)
> diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> index 71fa3ed7..a1aed072 100644
> --- a/libsepol/src/Makefile
> +++ b/libsepol/src/Makefile
> @@ -45,7 +45,10 @@ LDFLAGS += -undefined dynamic_lookup
>   LN=gln
>   endif
>   
> -all: $(LIBA) $(LIBSO) $(LIBPC)
> +all: $(LIBA) $(LIBPC)
> +ifneq ($(DISABLE_SHARED),y)
> +all: $(LIBSO)
> +endif
>   
>   
>   $(LIBA):  $(OBJS)
> @@ -87,11 +90,13 @@ endif
>   install: all
>   	test -d $(DESTDIR)$(LIBDIR) || install -m 755 -d $(DESTDIR)$(LIBDIR)
>   	install -m 644 $(LIBA) $(DESTDIR)$(LIBDIR)
> -	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
> -	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>   	test -d $(DESTDIR)$(LIBDIR)/pkgconfig || install -m 755 -d $(DESTDIR)$(LIBDIR)/pkgconfig
>   	install -m 644 $(LIBPC) $(DESTDIR)$(LIBDIR)/pkgconfig
> +ifneq ($(DISABLE_SHARED),y)
> +	test -d $(DESTDIR)$(SHLIBDIR) || install -m 755 -d $(DESTDIR)$(SHLIBDIR)
> +	install -m 755 $(LIBSO) $(DESTDIR)$(SHLIBDIR)
>   	$(LN) -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/$(TARGET)
> +endif
>   
>   relabel:
>   	/sbin/restorecon $(DESTDIR)$(SHLIBDIR)/$(LIBSO)
> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> index 32ad0201..7acd51dd 100644
> --- a/policycoreutils/Makefile
> +++ b/policycoreutils/Makefile
> @@ -1,5 +1,10 @@
>   SUBDIRS = setfiles load_policy newrole run_init secon sestatus semodule setsebool scripts po man hll unsetfiles
>   
> +PKG_CONFIG ?= pkg-config
> +
> +LIBSELINUX_LDLIBS := $(shell $(PKG_CONFIG) --libs libselinux)
> +export LIBSELINUX_LDLIBS
> +

I think that in the DISABLE_SHARED case, the pkg-config command needs 
--static as well.  I tried your patch, and I get errors that the 
downstream users of libselinux have undefined references to libpcre2, 
and they are being build without -lpcre2-8.  Based on the pkg-config man 
page, it looks like Requires.private libraries are only included if the 
--static flag is passed.

I also see that restorecond is not including -lpcre2-8.  It probably 
needs the same treatment as policycoreutils/*.

Finally, I was unable to get the install-rubywrap and install-pywrap 
targets to build with DISABLE_SHARED=y.  I wasn't able to figure out the 
ultimate issue there.

-Daniel
