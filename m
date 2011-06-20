Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5KJl8qV022684
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2011 15:47:08 -0400
Received: from mail-iy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p5KJl7XI023622
	for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2011 19:47:07 GMT
Received: by iyf40 with SMTP id 40so4512201iyf.12
        for <selinux@tycho.nsa.gov>; Mon, 20 Jun 2011 12:47:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C87F2A77.BA088%csellers@tresys.com>
References: <4C4F2EFB.9080102@redhat.com>
	<C87F2A77.BA088%csellers@tresys.com>
Date: Mon, 20 Jun 2011 15:47:07 -0400
Message-ID: <BANLkTimR=nJ_ohro8UPqs+ECtQZ2_KJEjQ@mail.gmail.com>
Subject: Re: Patch for python3 for libselinux
From: Eric Paris <eparis@parisplace.org>
To: Chad Sellers <csellers@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
        dmalcolm@redhat.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Aug 4, 2010 at 2:32 PM, Chad Sellers <csellers@tresys.com> wrote:
> On 7/27/10 3:09 PM, "Daniel J Walsh" <dwalsh@redhat.com> wrote:
>
>> Resending patch I sent a month ago.  Can we get this upstream?

>> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>> index bf665ab..8aeb7a1 100644
>> --- a/libselinux/src/Makefile
>> +++ b/libselinux/src/Makefile

[snip]

>> @@ -123,8 +124,8 @@ install: all
>>
>>  install-pywrap: pywrap
>>      test -d $(PYTHONLIBDIR)/site-packages/selinux || install -m 755 -d
>> $(PYTHONLIBDIR)/site-packages/selinux
>> -    install -m 755 $(SWIGSO) $(PYTHONLIBDIR)/site-packages/selinux
>> -    install -m 755 $(AUDIT2WHYSO) $(PYTHONLIBDIR)/site-packages/selinux
>> +    install -m 755 $(SWIGSO)
>> $(PYTHONLIBDIR)/site-packages/selinux/_selinux.so
>
> I'm still not sure why PYPREFIX has been added, but assuming it should be
> shouldn't this be /$(PYPREFIX)_selinux.so, or better yet /$(SWIGSO)

So the reason it is defined is so you can build a python2 and python3
binding in the same source tree.  What you end up with is
python2_selinux.so and python3_selinux.so in the build tree, which get
installed in /usr/lib64/python2.7/site-packages/selinux/_selinux.so
and /usr/lib64/python3.2/site-packages/selinux/_selinux.so
respectively.

> The bigger problem is that it doesn't seem to build for me. Applying the
> patch (and fixing the Makefile with the below patch, as it doesn't look like
> it will currently build the python wrapper),

I don't need the Makefile change you listed.  I just build like:

make LIBDIR=/usr/lib64 PYTHON=/usr/bin/python3 PYPREFIX=python3
make LIBDIR=/usr/lib64 PYTHON=/usr/bin/python3 PYPREFIX=python3 swigify
make LIBDIR=/usr/lib64 PYTHON=/usr/bin/python3 PYPREFIX=python3 pywrap

Mind you this doesn't work since python on F16 is now in python3.2mu
and the PYINC variable is just python3.2.  It looks like Dan changed
Fedora to do:

-PYINC ?= /usr/include/$(PYLIBVER)
+PYINC ?= $(shell pkg-config --cflags `basename $(PYTHON)`)

which leads onto a change in the use of PYINC (since it now includes the -I)

I've added this patch to my tree that I'm trying to build out of the
outstanding selinux userspace work.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
