Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44EMbeo001694
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 10:22:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 82B9823E6D4
 for <selinux@tycho.nsa.gov>; Thu,  4 May 2017 14:22:31 +0000 (UTC)
Received: from hulk.lan (unknown [10.40.2.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 294BE17DC6
 for <selinux@tycho.nsa.gov>; Thu,  4 May 2017 14:22:31 +0000 (UTC)
Subject: Re: [PATCH] libsepol: Add INCLUDEDIR to utils/Makefile
To: SELinux <selinux@tycho.nsa.gov>
References: <20170504140857.18863-1-plautrba@redhat.com>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <6e6bc5c8-2a86-2189-8e1c-dc512de699e2@redhat.com>
Date: Thu, 4 May 2017 16:22:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170504140857.18863-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The patch is wrong, please disregard.

I'm not sure about the right fix in order not to break gentoo use case.
I'd just revert fcb5d5c change in libsepol/utils/Makefile for now.



On 05/04/2017 04:08 PM, Petr Lautrbach wrote:
> fcb5d5c removed ../include from CFLAGS from libsepol/utils/Makefile so
> that a build tool can't find sepol/sepol.h when libsepol is built on a
> system without sepol.h in standard paths.
> 
> Fixes:
> chkcon.c:1:10: fatal error: sepol/sepol.h: No such file or directory
>  #include <sepol/sepol.h>
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libsepol/utils/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
> index a13164e1..f5097be7 100644
> --- a/libsepol/utils/Makefile
> +++ b/libsepol/utils/Makefile
> @@ -1,6 +1,7 @@
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
>  BINDIR ?= $(PREFIX)/bin
> +INCLUDEDIR ?= $(PREFIX)/include
>  
>  CFLAGS ?= -Wall -Werror
>  LDFLAGS += -L../src
> 
