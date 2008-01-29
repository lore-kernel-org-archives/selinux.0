Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0TAUhD9006077
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 05:30:43 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0TAUgfr018913
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 10:30:42 GMT
Received: from ns.i.cz (brana.i.cz [193.179.36.134])
	by vidle.i.cz (Postfix) with ESMTP id 0DD7A1CC86
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 11:30:41 +0100 (CET)
Received: from bobek.localdomain (bobek.pm.i.cz [192.168.64.71])
	by ns.i.cz (Postfix) with ESMTP id DA8E05C0A
	for <selinux@tycho.nsa.gov>; Tue, 29 Jan 2008 11:30:40 +0100 (CET)
Received: from zito by bobek.localdomain with local (Exim 4.63)
	(envelope-from <vaclav.ovsik@i.cz>)
	id 1JJnjk-0005fI-J0
	for selinux@tycho.nsa.gov; Tue, 29 Jan 2008 11:30:40 +0100
Date: Tue, 29 Jan 2008 11:30:40 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Subject: Re: Patch to add python audit2why bindings.
Message-ID: <20080129103040.GB21672@bobek.pm.i.cz>
References: <4787936A.8030803@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4787936A.8030803@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Fri, Jan 11, 2008 at 11:03:54AM -0500, Daniel J Walsh wrote:
> ...
> --- nsalibselinux/src/audit2why.c	1969-12-31 19:00:00.000000000 -0500
> +++ libselinux-2.0.46/src/audit2why.c	2008-01-11 10:51:10.000000000 -0500
> @@ -0,0 +1,460 @@
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <ctype.h>
> +#include <errno.h>
> +#include <getopt.h>
> +#include <limits.h>
> +#include <sepol/sepol.h>
> +#include <sepol/policydb/services.h>
> +#include <Python.h>
> +#include <selinux/selinux.h>
> +

I had a bit problem with headers order on Debian Etch.

zito@bobek:~/proj/iczlinux/selinux/libselinux/src$ cc -Werror -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute -I../include -I/usr/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64  -I/usr/include/python2.5 -fPIC -DSHARED -c -o audit2why.lo audit2why.c
In file included from /usr/include/python2.5/Python.h:8,
                 from audit2why.c:9:
/usr/include/python2.5/pyconfig.h:932:1: error: "_POSIX_C_SOURCE" redefined
In file included from /usr/include/unistd.h:26,
                 from audit2why.c:1:
/usr/include/features.h:150:1: error: this is the location of the previous definition


After moving `#include <Python.h>' on the first line, compilation succeded.
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
