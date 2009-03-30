Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2UBk59v017565
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 07:46:05 -0400
Received: from mx2.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2UBk4GP019361
	for <selinux@tycho.nsa.gov>; Mon, 30 Mar 2009 11:46:05 GMT
Message-ID: <49D0B0F9.8040102@redhat.com>
Date: Mon, 30 Mar 2009 07:46:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Vikram Noel Ambrose <noel.ambrose@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: xine_init() causes segfault in libselinux
References: <49D00BEB.2030000@gmail.com>
In-Reply-To: <49D00BEB.2030000@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 03/29/2009 08:01 PM, Vikram Noel Ambrose wrote:
> Hello Everyone,
>
> I've managed to find a repeatable segfault scenario with some very basic
> libxine code.
>
> libxine if anyone doesnt know is a very popular audio backend for many
> userspace applications in KDE and Gnome.
>
> Here is the code: http://en.pastebin.ca/1376316
>
> The code basically opens a file stream with no Audio or Video drivers,
> and just reads the meta data from the file (title information), and then
> quits.
>
> A gdb backtrace and valgrind have led me to believe there is a fault in
> libselinux.
>
> Though this could very possibly be a fault in libxine, I'd have thought
> libselinux would be more resilient to such issues. Especially since
> glibc didnt complain.
>
> If you would like to run this test code, simply install xine-lib-devel
> and then compile the test program.
>
> $ gcc -lxine -g test.c
> $ ./a.out
>
> I'm using an up-to-date FC10 x86_64 installation.
> 2.6.27.19-170.2.35.fc10.x86_64
>
>
> Vikram
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
This is most likely a problem with libxine.  SELinux uses a 
constructor/destructor when the library is loaded that allocates and 
frees memory.  If the app that loads SELinux corrupts this memory for 
some reason, the SELinux destructor will segfault.  Similar bugs have 
been reported against libselinux, and all have been the fault of the 
calling app/library so far.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
