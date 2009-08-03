Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n73IWY4j007080
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 14:32:34 -0400
Received: from mail.gmx.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n73IW77Z021923
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 18:32:07 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: best way to comile userspace to use lib64 for x86_64
Date: Tue, 4 Aug 2009 02:32:27 +0800
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <4A770542.3050103@gmail.com> <200908040117.41723.linuxweb@gmx.net> <4A772A98.6050303@gmail.com>
In-Reply-To: <4A772A98.6050303@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908040232.27984.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I found quite a good source of information for this is the CLFS-documentation.
There you can find lots of stuff on how to make things go where you want them.

> Dennis Wronka wrote:
> > This can be quite hard at times. For most packages you can use --libdir
> > with configure, but some packages still want to put their stuff into /lib
> > or /usr/lib OpenSSL for example seems to require quite a few edits in the
> > Makefiles.
> >
> > Here's what I have to "rape" OpenSSL into installing into /usr/lib64
> >
> > if [ "$(uname -a | grep x86_64)" != "" ]; then
> > 	for FILE in $(find . -name Makefile); do
> > 		sed -i 's@$(INSTALLTOP)/lib@&64@g' ${FILE}
> > 		sed -i 's@$${exec_prefix}/lib@&64@g' ${FILE}
> > 	done
> > fi
> >
> > Btw, if you compile a pure 64-bit system I suggest simply linking /lib to
> > /lib64 and /usr/lib to /usr/lib64
> > Saves you lots of headaches with misplaced stuff...
> >
> >> As an experimanet I'm building an x86_64 system, in doing so
> >> I'm noticing I need to have the libs point to /lib64 and /usr/lib64
> >> what is the easiest way to do this for the
> >> userspace from git. looking at the Makefiles seems a bit confusing,
> >> using LIBDIR=/lib64 does make /usr/lib64 but does not  make /lib64.
> >>
> >> any ideas?
> >>
> >> Justin P. Mattock
> >>
> >> --
> >> This message was distributed to subscribers of the selinux mailing list.
> >> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> >> with the words "unsubscribe selinux" without quotes as the message.
>
> Cool thanks,
> The linking to lib like what you had said
> is probably the best bet(noticed ubuntu does that,
> but fedora does not) especially with the file relabeling.
> (unless the file relabeling is already aware of lib64's).
>
> As for openssl(thanks for that)
> I had a bit of a headache with perl already.
> not sure if I have the patience for this.
>
> Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
