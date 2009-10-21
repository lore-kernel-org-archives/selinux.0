Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9LEFIbI001520
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 10:15:18 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9LEH3Ie003321
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 14:17:03 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n9LE9Sd3009614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 09:09:29 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n9LE3uWN031042
	for <selinux@tycho.nsa.gov>; Wed, 21 Oct 2009 09:03:56 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: /lib/libsemanage.so.1 links to  /usr/lib/libustr-1.0.so.1
References: <87aazvu5d4.fsf@anzu.internal.golden-gryphon.com>
	<4AD489A5.7010708@manicmethod.com>
	<87k4yypls7.fsf@anzu.internal.golden-gryphon.com>
	<1255962053.3099.22.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 21 Oct 2009 09:03:56 -0500
In-Reply-To: <1255962053.3099.22.camel@moss-pluto.epoch.ncsc.mil> (Stephen
	Smalley's message of "Mon, 19 Oct 2009 10:20:53 -0400")
Message-ID: <87pr8gvo6r.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 19 2009, Stephen Smalley wrote:

> On Wed, 2009-10-14 at 00:49 -0500, Manoj Srivastava wrote:
>> On Tue, Oct 13 2009, Joshua Brindle wrote:
>> 
>> 
>> > Yes, I'm not sure why you'd need libsemanage during early boot, we
>> > probably should apply this:
>> >
>> > diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
>> > index cfb9558..c531a2f 100644
>> > --- a/libsemanage/src/Makefile
>> > +++ b/libsemanage/src/Makefile
>> > @@ -1,7 +1,7 @@
>> >  # Installation directories.
>> >  PREFIX ?= $(DESTDIR)/usr
>> >  LIBDIR ?= $(PREFIX)/lib
>> > -SHLIBDIR ?= $(DESTDIR)/lib
>> > +SHLIBDIR ?= $(PREFIX)/lib
>> >  INCLUDEDIR ?= $(PREFIX)/include
>> >  PYLIBVER ?= $(shell python -c 'import sys;print "python%d.%d" %
>> > sys.version_info[0:2]')
>> >  PYINC ?= /usr/include/${PYLIBVER}
>> >
>> 
>>         I've applied this patch in Debian unstable.
>
> My only concern with relocating libsemanage is whether it will create
> any compatibility problems for existing binaries previously linked
> against /lib/libsemanage.so.1.  Also it could get confusing if you
> build and install the newer version and existing binaries keep using
> the old library at the old location.  You likely need/want to symlink
> /lib/libsemanage.so.1 to the new location.

        As long as the new library location is in the ld.so path, there
 is no issue, is there?  At run time, ld.so searches the path, loads the
 shared libraries from the new location, prepares the program to run,
 and then runs it. At worst, there might be two copies of the library
 loaded into memory, in case there are programs already running linked
 with libsemanage.

        If I am wrong, and long running programs might be affected when
 the library location is yanked out from under them, some mitigating
 action may be taken. I am not sure there are any daemons yet linked
 with libsemanage, but I can arrange for any such daemons to be
 restarted during installation, once I get any bug report.

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
