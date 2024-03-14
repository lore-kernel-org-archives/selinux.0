Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12671747
	for <selinux@vger.kernel.org>; Thu, 14 Mar 2024 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429148; cv=none; b=jrYY1Zpi7hrFkoX85PCXUF/zekFECUvBwi9lD2DwaT16T1DU8z+vOr54Q/HuwmnwhzfzyK7ADGdE2b/EdA7AyQmNfGB81mnAtNSmVxpZyBW0KyPyP1DGFAwO7US4qeRDNOLHsR/xUFKLcYpCT/yY9QjAWVUDBKAKbX1qNQOSu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429148; c=relaxed/simple;
	bh=Thm9T1/0T5it6qIG3pC/2CtUUjSKOa3iZKBNw/SaTFA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mQPwsUZnCQu0i0qMl0coBnZPsCEAb8QgRaQh+6WPuWDmyuz8uBwAT4h6vZi+WDU8tsdWRqkOaGIPiMusXS4fpZLyPMiq8NBd+yL/FMY660XUsn3YDD9uHHqtsNAz3k5zD2AQjYzc/bnHVge9AZ1b12Ou20p4pTQ8DdoqXPEtbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmsnet.nl; spf=pass smtp.mailfrom=xmsnet.nl; dkim=pass (1024-bit key) header.d=xmsnet.nl header.i=@xmsnet.nl header.b=jTOc5Q5O; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmsnet.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmsnet.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xmsnet.nl header.i=@xmsnet.nl header.b="jTOc5Q5O"
X-KPN-MessageId: 17b81548-e215-11ee-9a83-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 17b81548-e215-11ee-9a83-00505699b430;
	Thu, 14 Mar 2024 16:11:11 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 199f2b03-e215-11ee-b054-0050569981f5;
	Thu, 14 Mar 2024 16:11:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xmsnet.nl; s=xmsnet01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=PfMIUeu0DdQ/Z86KbUFGlZWMRGZi1XY1HONCBD0NupU=;
	b=jTOc5Q5OS8DPKmKdn6i4sZrIXZBsl4fVbonCTFz3Ep3coZiq3OdxvBk4UZ35MUaDPw8g2mOdVKlZM
	 VrwJK5cjPqHgHCkN4UHwFv5roRkaZUDjOERaNFPtCPBk76Ub3iYyAbkRl45lR0mjgZg4XIzycf9MuL
	 da2BOHaek955EAh8=
X-KPN-MID: 33|5v+gIGvaUgLJZyNRJYcCUl9HYBIUizNiZX46AWnmNAkSc/PRlXoxI/Qy89D6fA8
 2LaVIZ15ZxB7qHl+zbX8FWg==
X-CMASSUN: 33|y5CB2FCvwLm2alN3ZP7M+Y3m5DVfi03OUElGy6tdc+ODR6w0WEJf2gAvL3ZFrQQ
 8sRtqLL7CRZ8ZAKu7WZohX5+Sw55CxIhUCxZdgSK230Y=
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 19936e64-e215-11ee-ae78-00505699eff2;
	Thu, 14 Mar 2024 16:11:14 +0100 (CET)
Date: Thu, 14 Mar 2024 16:11:14 +0100 (CET)
From: Winfried <winfried_mb2@xmsnet.nl>
To: Jordan Williams <jordan@jwillikers.com>, selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Message-ID: <663367736.1859904.1710429074631@kpc.webmail.kpnmail.nl>
In-Reply-To: <f87f2db0-3c2b-4ac9-94f3-ef7f0d95d3e8@jwillikers.com>
References: <20240313224806.2859045-1-jwcart2@gmail.com>
 <f87f2db0-3c2b-4ac9-94f3-ef7f0d95d3e8@jwillikers.com>
Subject: Re: [PATCH] libselinux, libsepol: Add CFLAGS and LDFLAGS to
 Makefile checks
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

Fine with me as well. 
Thanks, 
Winfried

> Op 14-03-2024 14:59 CET schreef Jordan Williams <jordan@jwillikers.com>:
> 
>  
> On 3/13/24 17:48, James Carter wrote:
> > In libselinux there is an availability check for strlcpy() and
> > in both libselinux and libsepol there are availability checks for
> > reallocarray() in the src Makfiles. CFLAGS and LDFLAGS are needed
> > for cross-compiling, but, unfortunately, the default CFLAGS cause
> > all of these availability checks to fail to compile because of
> > compilationerrors (rather than just the function not being available).
> >
> > Add CFLAGS and LDFLAGS to the availibility checks, update the checks
> > so that a compilation error will only happen if the function being
> > checked for is not available, and make checks for the same function
> > the same in both libselinux and libsepol.
> >
> > Suggested-by: Jordan Williams <jordan@jwillikers.com>
> > Suggested-by: Winfried Dobbe <winfried_mb2@xmsnet.nl>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >   libselinux/src/Makefile | 4 ++--
> >   libsepol/src/Makefile   | 2 +-
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index d3b981fc..41cfbdca 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -104,13 +104,13 @@ override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
> >   
> >   # check for strlcpy(3) availability
> >   H := \#
> > -ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char*d,*s;strlcpy(d, s, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> > +ifeq (yes,$(shell printf '${H}include <string.h>\nint main(void){char d[2];const char *s="a";return (size_t)strlcpy(d,s,sizeof(d))>=sizeof(d);}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> >   override CFLAGS += -DHAVE_STRLCPY
> >   endif
> >   
> >   # check for reallocarray(3) availability
> >   H := \#
> > -ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){reallocarray(NULL, 0, 0);return 0;}' | $(CC) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> > +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> >   override CFLAGS += -DHAVE_REALLOCARRAY
> >   endif
> >   
> > diff --git a/libsepol/src/Makefile b/libsepol/src/Makefile
> > index 16b9bd5e..7b0e8446 100644
> > --- a/libsepol/src/Makefile
> > +++ b/libsepol/src/Makefile
> > @@ -31,7 +31,7 @@ endif
> >   
> >   # check for reallocarray(3) availability
> >   H := \#
> > -ifeq (yes,$(shell printf '${H}define _GNU_SOURCE\n${H}include <stdlib.h>\nint main(void){void*p=reallocarray(NULL, 1, sizeof(char));return 0;}' | $(CC) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> > +ifeq (yes,$(shell printf '${H}include <stdlib.h>\nint main(void){return reallocarray(NULL,0,0)==NULL;}' | $(CC) $(CFLAGS) $(LDFLAGS) -x c -o /dev/null - >/dev/null 2>&1 && echo yes))
> >   override CFLAGS += -DHAVE_REALLOCARRAY
> >   endif
> >   
> This works great, thanks!
