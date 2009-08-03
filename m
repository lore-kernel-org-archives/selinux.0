Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n73HHn1J027478
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 13:17:49 -0400
Received: from mail.gmx.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id n73HHM7Z016163
	for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2009 17:17:22 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: best way to comile userspace to use lib64 for x86_64
Date: Tue, 4 Aug 2009 01:17:35 +0800
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <4A770542.3050103@gmail.com>
In-Reply-To: <4A770542.3050103@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200908040117.41723.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This can be quite hard at times. For most packages you can use --libdir with 
configure, but some packages still want to put their stuff into /lib or /usr/lib
OpenSSL for example seems to require quite a few edits in the Makefiles.

Here's what I have to "rape" OpenSSL into installing into /usr/lib64

if [ "$(uname -a | grep x86_64)" != "" ]; then
	for FILE in $(find . -name Makefile); do
		sed -i 's@$(INSTALLTOP)/lib@&64@g' ${FILE}
		sed -i 's@$${exec_prefix}/lib@&64@g' ${FILE}
	done
fi

Btw, if you compile a pure 64-bit system I suggest simply linking /lib to 
/lib64 and /usr/lib to /usr/lib64
Saves you lots of headaches with misplaced stuff...


> As an experimanet I'm building an x86_64 system, in doing so
> I'm noticing I need to have the libs point to /lib64 and /usr/lib64
> what is the easiest way to do this for the
> userspace from git. looking at the Makefiles seems a bit confusing,
> using LIBDIR=/lib64 does make /usr/lib64 but does not  make /lib64.
>
> any ideas?
>
> Justin P. Mattock
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
