Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C077ECAAD8
	for <selinux@archiver.kernel.org>; Thu, 22 Sep 2022 18:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiIVSFX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiIVSFG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Sep 2022 14:05:06 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA7464F38D
        for <selinux@vger.kernel.org>; Thu, 22 Sep 2022 11:04:51 -0700 (PDT)
Received: from [192.168.1.10] (pool-173-66-202-112.washdc.fios.verizon.net [173.66.202.112])
        by linux.microsoft.com (Postfix) with ESMTPSA id 590C020B929C;
        Thu, 22 Sep 2022 11:04:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 590C020B929C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663869891;
        bh=zXXBNUjcRu+kpeNpK+umGlTvDltFa1cc93FA4KNc9VE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=YhulbIq9h+IluCsBFjH2lGM7PWxG1yPqfWry9hJADLbOpA/CxumYbKTXwqjkis4ir
         AYVagwO+v1wuFCJc/ZjzY18weZ4mXLH+Oth3M7l7B1PMeV/iCl34xg6dEdfPRAbIwc
         aerPAv30TO1hWvuXrNtDQzHy+WjBWJQddinc3EF0=
Message-ID: <c614d089-31e2-573a-17d0-91eca5e9b218@linux.microsoft.com>
Date:   Thu, 22 Sep 2022 14:04:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] libsemanage: Allow user to set SYSCONFDIR
Content-Language: en-US
To:     Matt Sheets <masheets@linux.microsoft.com>, selinux@vger.kernel.org
References: <20220922180255.2923-1-masheets@linux.microsoft.com>
From:   Daniel Burgener <dburgener@linux.microsoft.com>
In-Reply-To: <20220922180255.2923-1-masheets@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/22/2022 2:02 PM, Matt Sheets wrote:
> This change will allow a user to set the location of their
> sysconfdir, defaulted to /etc, if they are installing into
> nonstandard locations.
> 
> Signed-off-by: Matt Sheets <masheets@linux.microsoft.com>
> ---
>   libsemanage/src/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index 71c2a1d2..01df0181 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -11,6 +11,7 @@ PKG_CONFIG ?= pkg-config
>   PREFIX ?= /usr
>   LIBDIR ?= $(PREFIX)/lib
>   INCLUDEDIR ?= $(PREFIX)/include
> +SYSCONFDIR ?= /etc
>   PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
>   PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
>   PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
> @@ -19,7 +20,7 @@ RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] +
>   RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
>   RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
>   
> -DEFAULT_SEMANAGE_CONF_LOCATION=/etc/selinux/semanage.conf
> +DEFAULT_SEMANAGE_CONF_LOCATION=$(SYSCONFDIR)/selinux/semanage.conf
>   
>   ifeq ($(DEBUG),1)
>   	export CFLAGS ?= -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror

That looks good thanks.  Sorry, one last request.  This is a generic 
yocto issue, right?  Are you able to provide publicly visible links to 
the upstream yocto project in the git commit message to justify why 
using a nonstandard /etc is a normal/reasonable thing to do?
