Return-Path: <SRS0=nnTv=Y4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58083CA9EB5
	for <selinux@archiver.kernel.org>; Mon,  4 Nov 2019 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB3820848
	for <selinux@archiver.kernel.org>; Mon,  4 Nov 2019 15:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="my1SHSBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfKDPQt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:16:49 -0500
Received: from USFB19PA34.eemsg.mail.mil ([214.24.26.197]:40634 "EHLO
        USFB19PA34.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbfKDPQs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Nov 2019 10:16:48 -0500
X-EEMSG-check-017: 23826442|USFB19PA34_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,267,1569283200"; 
   d="scan'208";a="23826442"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA34.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 04 Nov 2019 15:16:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1572880607; x=1604416607;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9EYIc2Cd4cH3jbBp0PBmDZLWD+Cnh561jB8iiRGGYdA=;
  b=my1SHSBiEF5mS/Cs/iiS6XWXMHrNPzUR/1ThWOpXPtp01QRy49gxE3/T
   MKa15rjxrWc7X5dugpIG/oWcUdnstAKXuIcUE/VuhXJgfwH6vgpw5qqUb
   /rHKadD7ZR+YYahlCHr4DtDz/jopJxRbCGwKK4mm5O8FHS1QS5ENXMAhy
   eCf0VHMn+B/x2jgkDhEPl753F1zfr7f0d7eZeoY6S1fcAtP1T6796Xid5
   Jhg6AadpvRa75EeYA/l4VhHWmYgFh8kVFs9YbG2WntwQekQ9ufNNhzjQG
   rloJB/TEg8JhW9jsi8HLNV8cjRGz537H5oV/DWtgSUh+c/jnFncZXgzpz
   Q==;
X-IronPort-AV: E=Sophos;i="5.68,267,1569283200"; 
   d="scan'208";a="35061246"
IronPort-PHdr: =?us-ascii?q?9a23=3AiboTaRJADbNWhKJoW9mcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgfLv/xwZ3uMQTl6Ol3ixeRBMOHsqkC0rON+P+7EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMRm6sAvcusYUjIZsN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhTwZPDAl7m7Yls1wjLpaoB2/oRx/35XUa5yROPZnY6/RYc8WSW?=
 =?us-ascii?q?9HU8lfTSxBBp63YZUJAeQPIO1Uq5DxqlUKoBe7AwSnGeHhxSJShnLuwKM0ze?=
 =?us-ascii?q?ohHwHF0gIuEd0Bv3bbo8n6OqoJTeC4zrPFwSnfY/5Y2zrw7pXDfBA7ofGLWL?=
 =?us-ascii?q?J9adffyVUxGAPdjlWft4rlNC6I2OQIqWeb6+5gWvyvimU6rAxxuSWgxtw3h4?=
 =?us-ascii?q?nVhoMa1lDE9SJjzIYzPt23UlR3YdGjEJtOriyXMZZ9TMA6Q2xwpSo3xbILtY?=
 =?us-ascii?q?S7cSQX0pgr2RHSZ+Kdf4SV5B/oSfyfLi1ihH1/fbKynxOy8U+9xeLiTsS0y1?=
 =?us-ascii?q?NKrjZdktnLq3ANywTf6siZRft5+UeswSqP2BrJ6uFFPEA0jrDXK4Ihw7Eslp?=
 =?us-ascii?q?oTtl7PHinql0XtkKCabEAk+ums6+j/Y7XmoIGTN5Nshw3jPakjldazDOQlPg?=
 =?us-ascii?q?QUQWSW9vqw2Kf+8UHhRbVFlPw2kq3XsJDAIsQbo7a0AxRI3YY48Bu/Ezen38?=
 =?us-ascii?q?gYnXkANl5FfgmHgJLzN1HBJ/D4E++zg06wnzdz2/DGIrrhD43LLnjCjLjher?=
 =?us-ascii?q?J95FRHyAYpzNBf4JVUCqoaIP/oX0/8u9PZAgU+MwyuzObtEM992Z8GWWKTHq?=
 =?us-ascii?q?+ZN7vfsUSW6eIrIumMYpIVuTnmJvg76P7hk2U5lUUefaa3x5sXbm63HvB8L0?=
 =?us-ascii?q?Wee3rsjc8LEX0WsQomUOzqlFqCXCZWZ3azXKIz+Co2B5iiDYffQoCtgbqB3D?=
 =?us-ascii?q?q0H5FMYWBGEF+MQj/UcNCiWvwLbCuJau5mlScfHeynSoQm0Ri18g79zKF8Bu?=
 =?us-ascii?q?+I6msfr521kJBu6unSkwwi3SJ7At7b0GyXSWxw2GQSSGwYxqd69Hdhx0+D3K?=
 =?us-ascii?q?4wuPlREdhe9rsdSQshHYLNxOx9TdbpU0TOecnfGwXuecmvHTxkFoF5+NQJeU?=
 =?us-ascii?q?soXoz53x0=3D?=
X-IPAS-Result: =?us-ascii?q?A2BEBAAaOMBd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgX2Bd?=
 =?us-ascii?q?CxsVTIqhCmPWgEBAQEBAQaBNn+IZY9bgWcJAQEBAQEBAQEBJw0BAgEBgUyCd?=
 =?us-ascii?q?AKEDiQ4EwIOAQEBBAEBAQEBBQMBAWyFNwyCOykBgmwBAQEBAgEjFUEQCxgCA?=
 =?us-ascii?q?iYCAlcGAQwGAgEBgl8/AYJSBSCwcHWBMoVOgzKBSIEOKIwTGHiBB4ERJ4FtS?=
 =?us-ascii?q?TU+hC2DKII8IgSWOkSWdIIugjOEXo4fBhuDLpY3jkKbaCKBWCsIAhgIIQ+DJ?=
 =?us-ascii?q?wlHERSMXmyEICMDMIEFAQGNZgEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 04 Nov 2019 15:16:45 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA4FGhdf017233;
        Mon, 4 Nov 2019 10:16:44 -0500
Subject: Re: [PATCH 1/3] Makefile: fix cleaning files that starts with "-"
To:     Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@vger.kernel.org
Cc:     Michael Shigorin <mike@altlinux.org>
References: <20191101092724.7650-1-nicolas.iooss@m4x.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <40955c0d-85fe-80db-a55f-fa0083556a0b@tycho.nsa.gov>
Date:   Mon, 4 Nov 2019 10:16:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101092724.7650-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/1/19 5:27 AM, Nicolas Iooss wrote:
> libselinux/src/exception.sh creates a file named "-.o". This file is
> usually removed at the end of this script, but some failures in it could
> left it on the filesystem. "make clean" is then supposed to remove this
> file, but fails instead with:
> 
>      rm: invalid option -- '.'
>      Try 'rm ./-.o' to remove the file '-.o'.
>      Try 'rm --help' for more information.
> 
> This is due to "rm -f *.o" being expanded to "rm -f -.o". Prevent this
> buggy expansion by using "./*.o" in the command line. While at it, do so
> for other patterns like "*~".

Does any other software package use this idiom for clean?  I haven't 
seen it.  I'm wondering if we aren't better off doing any/all of the 
following:

1) Fix exception.sh to not create files starting in "-",
2) Fix our clean targets to only delete explicitly generated object file 
lists; some of them at least already have $(OBJS) $(LOBJS) so why do we 
need the extra wildcard?
3) Maybe use $(wildcard ...)?

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>   checkpolicy/test/Makefile                | 2 +-
>   libselinux/src/Makefile                  | 4 ++--
>   libselinux/utils/Makefile                | 2 +-
>   libsemanage/src/Makefile                 | 2 +-
>   libsepol/utils/Makefile                  | 2 +-
>   mcstrans/Makefile                        | 2 +-
>   mcstrans/man/Makefile                    | 2 +-
>   mcstrans/src/Makefile                    | 2 +-
>   mcstrans/utils/Makefile                  | 2 +-
>   policycoreutils/load_policy/Makefile     | 2 +-
>   policycoreutils/newrole/Makefile         | 2 +-
>   policycoreutils/po/Makefile              | 2 +-
>   policycoreutils/run_init/Makefile        | 2 +-
>   policycoreutils/secon/Makefile           | 2 +-
>   policycoreutils/semodule/Makefile        | 2 +-
>   policycoreutils/sestatus/Makefile        | 2 +-
>   policycoreutils/setfiles/Makefile        | 2 +-
>   policycoreutils/setsebool/Makefile       | 2 +-
>   python/audit2allow/Makefile              | 2 +-
>   python/sepolgen/Makefile                 | 2 +-
>   python/sepolgen/src/Makefile             | 2 +-
>   python/sepolgen/src/sepolgen/Makefile    | 2 +-
>   python/sepolgen/src/share/Makefile       | 2 +-
>   python/sepolgen/tests/Makefile           | 2 +-
>   python/sepolicy/Makefile                 | 2 +-
>   restorecond/Makefile                     | 2 +-
>   sandbox/Makefile                         | 2 +-
>   semodule-utils/semodule_expand/Makefile  | 2 +-
>   semodule-utils/semodule_link/Makefile    | 2 +-
>   semodule-utils/semodule_package/Makefile | 2 +-
>   30 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/checkpolicy/test/Makefile b/checkpolicy/test/Makefile
> index 89e7557c7aa6..ec8cc7299e4b 100644
> --- a/checkpolicy/test/Makefile
> +++ b/checkpolicy/test/Makefile
> @@ -19,4 +19,4 @@ dismod: dismod.o $(LIBSEPOLA)
>   	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS_LIBSEPOLA)
>   
>   clean:
> -	-rm -f dispol dismod *.o
> +	-rm -f dispol dismod ./*.o
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 2b1696a0c17b..63d6b0eda270 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -187,13 +187,13 @@ relabel:
>   clean-pywrap:
>   	-rm -f $(SWIGLOBJ) $(SWIGSO) $(AUDIT2WHYLOBJ) $(AUDIT2WHYSO)
>   	$(PYTHON) setup.py clean
> -	-rm -rf build *~ \#* *pyc .#*
> +	-rm -rf build ./*~ \#* ./*pyc .#*
>   
>   clean-rubywrap:
>   	-rm -f $(SWIGRUBYLOBJ) $(SWIGRUBYSO)
>   
>   clean: clean-pywrap clean-rubywrap
> -	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) *.o *.lo *~
> +	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) ./*.o ./*.lo ./*~
>   
>   distclean: clean
>   	rm -f $(GENERATED) $(SWIGFILES)
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index 361506384d08..1ac6f7dfd9f7 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -65,7 +65,7 @@ install: all
>   	install -m 755 $(TARGETS) $(DESTDIR)$(SBINDIR)
>   
>   clean:
> -	rm -f $(TARGETS) *.o *~
> +	rm -f $(TARGETS) ./*.o ./*~
>   
>   distclean: clean
>   
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index e029f0988dd8..7dcf4715878e 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -155,7 +155,7 @@ relabel:
>   	/sbin/restorecon $(DESTDIR)$(LIBDIR)/$(LIBSO)
>   
>   clean:
> -	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(SWIGRUBYSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c *.o *.lo *~
> +	-rm -f $(LIBPC) $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(SWIGRUBYSO) $(TARGET) conf-parse.c conf-parse.h conf-scan.c ./*.o ./*.lo ./*~
>   
>   distclean: clean
>   	rm -f $(GENERATED) $(SWIGFILES)
> diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
> index 31932c111026..26f7a02476a6 100644
> --- a/libsepol/utils/Makefile
> +++ b/libsepol/utils/Makefile
> @@ -16,7 +16,7 @@ install: all
>   	install -m 755 $(TARGETS) $(DESTDIR)$(BINDIR)
>   
>   clean:
> -	-rm -f $(TARGETS) *.o
> +	-rm -f $(TARGETS) ./*.o
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/mcstrans/Makefile b/mcstrans/Makefile
> index c993a9f52713..c3e4a148c66d 100644
> --- a/mcstrans/Makefile
> +++ b/mcstrans/Makefile
> @@ -8,7 +8,7 @@ install:
>   	$(MAKE) -C man install
>   
>   clean:
> -	rm -f *~ \#*
> +	rm -f ./*~ ./\#*
>   	$(MAKE) -C src clean
>   	$(MAKE) -C utils clean
>   	$(MAKE) -C man clean
> diff --git a/mcstrans/man/Makefile b/mcstrans/man/Makefile
> index 71713818c621..696430155c9f 100644
> --- a/mcstrans/man/Makefile
> +++ b/mcstrans/man/Makefile
> @@ -26,6 +26,6 @@ install: all
>   	done
>   
>   clean:
> -	-rm -f *~ \#*
> +	-rm -f ./*~ \#*
>   	-rm -f man5/*~ man5/\#*
>   	-rm -f man8/*~ man8/\#*
> diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> index 76ef055714e9..b7f14654889f 100644
> --- a/mcstrans/src/Makefile
> +++ b/mcstrans/src/Makefile
> @@ -34,5 +34,5 @@ install: all
>   	install -m 644 mcstrans.service $(DESTDIR)$(SYSTEMDDIR)/system/
>   
>   clean:
> -	-rm -f $(OBJS) $(LOBJS) $(TARGET) $(PROG) $(PROG_OBJS) *~ \#*
> +	-rm -f $(OBJS) $(LOBJS) $(TARGET) $(PROG) $(PROG_OBJS) ./*~ \#*
>   
> diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> index 9dfe772332b4..90ae75c29317 100644
> --- a/mcstrans/utils/Makefile
> +++ b/mcstrans/utils/Makefile
> @@ -30,7 +30,7 @@ test:
>   	./mlstrans-test-runner.py ../test/*.test
>   
>   clean:
> -	rm -f $(TARGETS) *.o *~ \#*
> +	rm -f $(TARGETS) ./*.o ./*~ \#*
>   
>   relabel:
>   
> diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
> index c1ba805b6a9a..9581eefc27f5 100644
> --- a/policycoreutils/load_policy/Makefile
> +++ b/policycoreutils/load_policy/Makefile
> @@ -26,7 +26,7 @@ install: all
>   	done
>   
>   clean:
> -	-rm -f $(TARGETS) *.o
> +	-rm -f $(TARGETS) ./*.o
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
> index 73ebd413da85..11b2a40b3d72 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -83,7 +83,7 @@ endif
>   endif
>   
>   clean:
> -	rm -f newrole *.o
> +	rm -f newrole ./*.o
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/policycoreutils/po/Makefile b/policycoreutils/po/Makefile
> index 575e143122e6..b201b90b2392 100644
> --- a/policycoreutils/po/Makefile
> +++ b/policycoreutils/po/Makefile
> @@ -123,7 +123,7 @@ refresh-po: Makefile
>   	done
>   
>   clean:
> -	@rm -fv *mo *~ .depend
> +	@rm -fv ./*mo ./*~ .depend
>   	@rm -rf tmp
>   
>   install: $(MOFILES)
> diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
> index e86364a496e6..b19540662eba 100644
> --- a/policycoreutils/run_init/Makefile
> +++ b/policycoreutils/run_init/Makefile
> @@ -50,7 +50,7 @@ ifeq ($(PAMH), y)
>   endif
>   
>   clean:
> -	-rm -f $(TARGETS) *.o
> +	-rm -f $(TARGETS) ./*.o
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
> index 576a6203dfa3..b17997914d69 100644
> --- a/policycoreutils/secon/Makefile
> +++ b/policycoreutils/secon/Makefile
> @@ -32,7 +32,7 @@ relabel:
>   	/sbin/restorecon $(DESTDIR)$(BINDIR)/secon
>   
>   clean:
> -	rm -f *.o core* secon *~ *.bak
> +	rm -f ./*.o core* secon ./*~ ./*.bak
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
> index 73801e487a76..e6520e877252 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -32,7 +32,7 @@ install: all
>   relabel:
>   
>   clean:
> -	-rm -f semodule *.o genhomedircon
> +	-rm -f semodule ./*.o genhomedircon
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
> index 8c4f45f804f2..4849405ec3cb 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -32,7 +32,7 @@ install: all
>   	install -m 644 sestatus.conf $(DESTDIR)$(ETCDIR)
>   
>   clean:
> -	rm -f sestatus *.o
> +	rm -f sestatus ./*.o
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
> index bc5a8db789a5..456f288d649b 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -45,7 +45,7 @@ install: all
>   	done
>   
>   clean:
> -	rm -f setfiles restorecon restorecon_xattr *.o setfiles.8.man
> +	rm -f setfiles restorecon restorecon_xattr ./*.o setfiles.8.man
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
> index 4b55046cecc4..217cf844aaba 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -32,7 +32,7 @@ install: all
>   relabel:
>   
>   clean:
> -	-rm -f setsebool *.o
> +	-rm -f setsebool ./*.o
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> index 15db549081dd..0a8008f63dee 100644
> --- a/python/audit2allow/Makefile
> +++ b/python/audit2allow/Makefile
> @@ -47,7 +47,7 @@ install: all
>   	done
>   
>   clean:
> -	rm -f *~ *.o sepolgen-ifgen-attr-helper test_dummy_policy
> +	rm -f ./*~ ./*.o sepolgen-ifgen-attr-helper test_dummy_policy
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/python/sepolgen/Makefile b/python/sepolgen/Makefile
> index 3aed330499a4..01d7b46c6918 100644
> --- a/python/sepolgen/Makefile
> +++ b/python/sepolgen/Makefile
> @@ -8,7 +8,7 @@ relabel: ;
>   clean:
>   	$(MAKE) -C src $@
>   	$(MAKE) -C tests $@
> -	rm -f *~ *.pyc
> +	rm -f ./*~ ./*.pyc
>   	rm -f parser.out parsetab.py
>   
>   indent: ;
> diff --git a/python/sepolgen/src/Makefile b/python/sepolgen/src/Makefile
> index 2815a13d3499..3e55309f8dcf 100644
> --- a/python/sepolgen/src/Makefile
> +++ b/python/sepolgen/src/Makefile
> @@ -9,7 +9,7 @@ relabel: ;
>   clean:
>   	$(MAKE) -C sepolgen $@
>   	$(MAKE) -C share $@
> -	rm -f *~ *.pyc
> +	rm -f ./*~ ./*.pyc
>   	rm -f parser.out parsetab.py
>   
>   indent: ;
> diff --git a/python/sepolgen/src/sepolgen/Makefile b/python/sepolgen/src/sepolgen/Makefile
> index cac8def7204e..83b17bb80227 100644
> --- a/python/sepolgen/src/sepolgen/Makefile
> +++ b/python/sepolgen/src/sepolgen/Makefile
> @@ -11,5 +11,5 @@ install: all
>   
>   clean:
>   	rm -f parser.out parsetab.py
> -	rm -f *~ *.pyc
> +	rm -f ./*~ ./*.pyc
>   	rm -rf __pycache__
> diff --git a/python/sepolgen/src/share/Makefile b/python/sepolgen/src/share/Makefile
> index 1a7133cbf5cb..4045be56597b 100644
> --- a/python/sepolgen/src/share/Makefile
> +++ b/python/sepolgen/src/share/Makefile
> @@ -7,4 +7,4 @@ install: all
>   	install -m 644 perm_map $(DESTDIR)$(SHAREDIR)
>   
>   clean:
> -	rm -f *~
> +	rm -f ./*~
> diff --git a/python/sepolgen/tests/Makefile b/python/sepolgen/tests/Makefile
> index 83d072f4e6aa..a5c23899e8fd 100644
> --- a/python/sepolgen/tests/Makefile
> +++ b/python/sepolgen/tests/Makefile
> @@ -1,7 +1,7 @@
>   PYTHON ?= python3
>   
>   clean:
> -	rm -f *~ *.pyc
> +	rm -f ./*~ ./*.pyc
>   	rm -f parser.out parsetab.py
>   	rm -f out.txt
>   	rm -f module_compile_test.fc
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 69f29fa962f9..0f55c5f30804 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -18,7 +18,7 @@ python-build:
>   
>   clean:
>   	$(PYTHON) setup.py clean
> -	-rm -rf build *~ \#* *pyc .#*
> +	-rm -rf build ./*~ \#* ./*pyc .#*
>   
>   sepolgen:
>   	ln -sf sepolicy sepolgen
> diff --git a/restorecond/Makefile b/restorecond/Makefile
> index 12452cd2f8e1..f200d70e6a8e 100644
> --- a/restorecond/Makefile
> +++ b/restorecond/Makefile
> @@ -54,7 +54,7 @@ relabel: install
>   	/sbin/restorecon $(DESTDIR)$(SBINDIR)/restorecond
>   
>   clean:
> -	-rm -f restorecond *.o *~
> +	-rm -f restorecond ./*.o ./*~
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/sandbox/Makefile b/sandbox/Makefile
> index 9da5e58db9e6..e0e2be5574ce 100644
> --- a/sandbox/Makefile
> +++ b/sandbox/Makefile
> @@ -44,7 +44,7 @@ test:
>   	@$(PYTHON) test_sandbox.py -v
>   
>   clean:
> -	-rm -f seunshare *.o *~
> +	-rm -f seunshare ./*.o ./*~
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-utils/semodule_expand/Makefile
> index e63dcff246d9..e5022fb598e7 100644
> --- a/semodule-utils/semodule_expand/Makefile
> +++ b/semodule-utils/semodule_expand/Makefile
> @@ -26,7 +26,7 @@ install: all
>   relabel:
>   
>   clean:
> -	-rm -f semodule_expand *.o
> +	-rm -f semodule_expand ./*.o
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/semodule-utils/semodule_link/Makefile b/semodule-utils/semodule_link/Makefile
> index c5cf69cd9ca3..ba5d97d115ad 100644
> --- a/semodule-utils/semodule_link/Makefile
> +++ b/semodule-utils/semodule_link/Makefile
> @@ -26,7 +26,7 @@ install: all
>   relabel:
>   
>   clean:
> -	-rm -f semodule_link *.o
> +	-rm -f semodule_link ./*.o
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> diff --git a/semodule-utils/semodule_package/Makefile b/semodule-utils/semodule_package/Makefile
> index 680ab836cfe6..c53628ae1365 100644
> --- a/semodule-utils/semodule_package/Makefile
> +++ b/semodule-utils/semodule_package/Makefile
> @@ -28,7 +28,7 @@ install: all
>   relabel:
>   
>   clean:
> -	-rm -f semodule_package semodule_unpackage *.o
> +	-rm -f semodule_package semodule_unpackage ./*.o
>   
>   indent:
>   	../../scripts/Lindent $(wildcard *.[ch])
> 

