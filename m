Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n32KCMCx023871
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 16:12:22 -0400
Received: from manicmethod.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n32KCLvu008013
	for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2009 20:12:21 GMT
Message-ID: <49D51C19.1000105@manicmethod.com>
Date: Thu, 02 Apr 2009 16:12:09 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Vikram Noel Ambrose <noel.ambrose@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: xine_init() causes segfault in libselinux
References: <49D00BEB.2030000@gmail.com>
In-Reply-To: <49D00BEB.2030000@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vikram Noel Ambrose wrote:
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

I can't reproduce this on an x86 F10 install with either the latest libselinux 
or trunk libselinux. Can you try installing a libselinux from trunk with DEBUG=1 
make flag so the backtrace will give more information?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
