Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9E64wij025618
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 02:04:58 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n9E646Ba018946
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 06:04:06 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n9E5xJsV026165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 00:59:21 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n9E5niSx005247
	for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2009 00:49:45 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: /lib/libsemanage.so.1 links to  /usr/lib/libustr-1.0.so.1
References: <87aazvu5d4.fsf@anzu.internal.golden-gryphon.com>
	<4AD489A5.7010708@manicmethod.com>
Date: Wed, 14 Oct 2009 00:49:44 -0500
In-Reply-To: <4AD489A5.7010708@manicmethod.com> (Joshua Brindle's message of
	"Tue, 13 Oct 2009 10:07:33 -0400")
Message-ID: <87k4yypls7.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 13 2009, Joshua Brindle wrote:


> Yes, I'm not sure why you'd need libsemanage during early boot, we
> probably should apply this:
>
> diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
> index cfb9558..c531a2f 100644
> --- a/libsemanage/src/Makefile
> +++ b/libsemanage/src/Makefile
> @@ -1,7 +1,7 @@
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
>  LIBDIR ?= $(PREFIX)/lib
> -SHLIBDIR ?= $(DESTDIR)/lib
> +SHLIBDIR ?= $(PREFIX)/lib
>  INCLUDEDIR ?= $(PREFIX)/include
>  PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" %
> sys.version_info[0:2]')
>  PYINC ?= /usr/include/${PYLIBVER}
>

        I've applied this patch in Debian unstable.

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
