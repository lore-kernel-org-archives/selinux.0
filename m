Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC424BC0A
	for <selinux@vger.kernel.org>; Mon, 23 Jun 2025 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682080; cv=none; b=UpSDmcp5lUupGbvmG+994JMHs/ZmORCNrhDSK9cqG+bk7YM4sYUZ7tElIhRRwrPhAEEvCKS33SqDsTzwmKumSB0NqwaS5KIQek6kSxYPU7akCixLxdZN701aIVjXmv5TVzthfIIhcCKIyuaMWhwXeRjPOvdnddeIhvYd3n8283M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682080; c=relaxed/simple;
	bh=d7CWSC5UgGiqPKaaf3BbZx3sdpUOArELtiMhaocdaTQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h61tnhEhGpbkMrSEXmzNmQCKbjVsAqX7rYCXYDFTYxC5e1jDHmj9ZxTKv5VmWDeZHX/CS+p+reUnVi7Vi66BI78CUWjvJrqhn7tPFmCo47fn13C+Om0H8yYrRgF3XpF4h/gRdcFBT3734/Ey+hUZDD7bnXxpWn+pABGasqKaZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxH54E5B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxH54E5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750682077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gK6gKafP8TJYDhS1NEkveAJVO1gWMTzmHLRnGmMUtmo=;
	b=NxH54E5Bvy8E1FbUT/r9OFHg0Ors/19kOERvrRpEZz448KsApt00X0fatwiHseVgOrl39u
	ZRhAbfrAHza8nksQ64f9aoypSsajEmI0leaKDa0F9TLwgjhcTB3LLK0v9apYSBm/RVgDXw
	0e0B0YhL33gU9IR9h6GLRGSv+HVRW4Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-gk-7fETSMHuXLnfpRv5RQQ-1; Mon,
 23 Jun 2025 08:34:34 -0400
X-MC-Unique: gk-7fETSMHuXLnfpRv5RQQ-1
X-Mimecast-MFC-AGG-ID: gk-7fETSMHuXLnfpRv5RQQ_1750682071
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C5DC1800290;
	Mon, 23 Jun 2025 12:34:31 +0000 (UTC)
Received: from localhost (unknown [10.45.224.182])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06FC719560AB;
	Mon, 23 Jun 2025 12:34:30 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Alyssa Ross <hi@alyssa.is>, selinux@vger.kernel.org
Subject: Re: [PATCH v3] Support static-only builds - unconditional `-laudit
 -lbz2` in non-static policycoreutils build
In-Reply-To: <20250211211651.1297357-3-hi@alyssa.is>
References: <20250211211651.1297357-3-hi@alyssa.is>
Date: Mon, 23 Jun 2025 14:34:29 +0200
Message-ID: <87bjqebpre.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Alyssa Ross <hi@alyssa.is> writes:

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
> diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
> index 32ad0201..7acd51dd 100644
> --- a/policycoreutils/Makefile
> +++ b/policycoreutils/Makefile
> @@ -1,5 +1,10 @@
>  SUBDIRS = setfiles load_policy newrole run_init secon sestatus semodule setsebool scripts po man hll unsetfiles
>  
> +PKG_CONFIG ?= pkg-config
> +
> +LIBSELINUX_LDLIBS := $(shell $(PKG_CONFIG) --libs libselinux)
> +export LIBSELINUX_LDLIBS
> +
>  all install relabel clean indent:
>  	@for subdir in $(SUBDIRS); do \
>  		(cd $$subdir && $(MAKE) $@) || exit 1; \
> diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
> index ad80d500..37c0111b 100644
> --- a/policycoreutils/load_policy/Makefile
> +++ b/policycoreutils/load_policy/Makefile
> @@ -7,7 +7,7 @@ LOCALEDIR ?= $(DESTDIR)$(PREFIX)/share/locale
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += $(LDFLAGS) -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> -override LDLIBS += -lsepol -lselinux
> +override LDLIBS += $(LIBSELINUX_LDLIBS) -lsepol
>  
>  TARGETS=$(patsubst %.c,%,$(sort $(wildcard *.c)))
>  
> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
> index 4b8145d3..6e95e79f 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -25,7 +25,7 @@ VERSION = $(shell cat ../VERSION)
>  CFLAGS ?= -Werror -Wall -W
>  EXTRA_OBJS =
>  override CFLAGS += -DVERSION=\"$(VERSION)\" -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> -override LDLIBS += -lselinux
> +override LDLIBS += $(LIBSELINUX_LDLIBS)
>  ifeq ($(PAMH), y)
>  	override CFLAGS += -DUSE_PAM
>  	EXTRA_OBJS += hashtab.o
> diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
> index 619ebc1d..a5002587 100644
> --- a/policycoreutils/run_init/Makefile
> +++ b/policycoreutils/run_init/Makefile
> @@ -11,7 +11,7 @@ AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
> -override LDLIBS += -lselinux
> +override LDLIBS += $(LIBSELINUX_LDLIBS)
>  ifeq ($(PAMH), y)
>  	override CFLAGS += -DUSE_PAM
>  	override LDLIBS += -lpam -lpam_misc
> diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
> index 440503a1..daa3e10e 100644
> --- a/policycoreutils/secon/Makefile
> +++ b/policycoreutils/secon/Makefile
> @@ -8,7 +8,7 @@ WARNS=-Werror -W -Wall -Wundef -Wshadow -Wpointer-arith -Wbad-function-cast -Wca
>  VERSION = $(shell cat ../VERSION)
>  CFLAGS ?= $(WARNS) -O1
>  override CFLAGS += -DVERSION=\"$(VERSION)\"
> -override LDLIBS += -lselinux
> +override LDLIBS += $(LIBSELINUX_LDLIBS)
>  
>  all: secon
>  
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
> index 9fbf99d6..3855f95e 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -5,11 +5,12 @@ SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
>  
>  CFLAGS ?= -Werror -Wall -W
> -override LDLIBS += -lsepol -lselinux -lsemanage
> +override LDLIBS += -lsemanage -lsepol $(LIBSELINUX_LDLIBS)
>  SEMODULE_OBJS = semodule.o
>  
>  all: semodule genhomedircon
>  
> +semodule: LDLIBS += -laudit -lbz2

This change requires libaudit.so and and libbz2.so to be installed
during policycoreutils build. This had not been necessary before this
change.

While it can be changed in build system, e.g. in Fedora use
BuildRequires in policycoreutils.spec, neither semodule nor setseboot
does not use those 2 libraries directly.

I have not tested it yet but the following check could fix it:


ifneq ($(DISABLE_SHARED),y)
      semodule: LDLIBS += -laudit -lbz2
endif



>  semodule: $(SEMODULE_OBJS)
>  
>  genhomedircon:
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
> index aebf050c..b0df6d28 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -8,7 +8,7 @@ ETCDIR ?= /etc
>  
>  CFLAGS ?= -Werror -Wall -W
>  override CFLAGS += -D_FILE_OFFSET_BITS=64
> -override LDLIBS += -lselinux
> +override LDLIBS += $(LIBSELINUX_LDLIBS)
>  
>  all: sestatus
>  
> diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
> index 84ffb08b..0b27e934 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -6,7 +6,7 @@ MANDIR = $(PREFIX)/share/man
>  AUDITH ?= $(shell test -f /usr/include/libaudit.h && echo y)
>  
>  CFLAGS ?= -g -Werror -Wall -W
> -override LDLIBS += -lselinux -lsepol -lpthread
> +override LDLIBS += $(LIBSELINUX_LDLIBS) -lsepol -lpthread
>  
>  ifeq ($(AUDITH), y)
>  	override CFLAGS += -DUSE_AUDIT
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
> index fc5b4ff6..12b6315d 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -6,13 +6,14 @@ MANDIR = $(PREFIX)/share/man
>  BASHCOMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions
>  
>  CFLAGS ?= -Werror -Wall -W
> -override LDLIBS += -lselinux -lsemanage
> +override LDLIBS += -lsemanage $(LIBSELINUX_LDLIBS)
>  SETSEBOOL_OBJS = setsebool.o
>  
>  BASHCOMPLETIONS=setsebool-bash-completion.sh 
>  
>  all: setsebool
>  
> +setsebool: LDLIBS += -laudit -lbz2
>  setsebool: $(SETSEBOOL_OBJS)
>  
>  install: all
> diff --git a/policycoreutils/unsetfiles/Makefile b/policycoreutils/unsetfiles/Makefile
> index 9e5edc04..bdc1b9de 100644
> --- a/policycoreutils/unsetfiles/Makefile
> +++ b/policycoreutils/unsetfiles/Makefile
> @@ -3,7 +3,7 @@ SBINDIR ?= $(PREFIX)/sbin
>  MANDIR ?= $(PREFIX)/share/man
>  
>  override CFLAGS += -D_GNU_SOURCE
> -override LDLIBS += -lselinux
> +override LDLIBS += $(LIBSELINUX_LDLIBS)
>  
>  
>  all: unsetfiles
>
> base-commit: 71aec30d068789e856e7cc429b620ae1cfa890f1
> -- 
> 2.47.0

