Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2TNxkZ6027229
	for <selinux@tycho.nsa.gov>; Sun, 29 Mar 2009 19:59:46 -0400
Received: from rv-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2TNxjDg018246
	for <selinux@tycho.nsa.gov>; Sun, 29 Mar 2009 23:59:46 GMT
Received: by rv-out-0708.google.com with SMTP id k29so2000955rvb.54
        for <selinux@tycho.nsa.gov>; Sun, 29 Mar 2009 16:59:44 -0700 (PDT)
Message-ID: <49D00BEB.2030000@gmail.com>
Date: Sun, 29 Mar 2009 20:01:47 -0400
From: Vikram Noel Ambrose <noel.ambrose@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: xine_init() causes segfault in libselinux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Everyone,

I've managed to find a repeatable segfault scenario with some very basic 
libxine code.

libxine if anyone doesnt know is a very popular audio backend for many 
userspace applications in KDE and Gnome.

Here is the code: http://en.pastebin.ca/1376316

The code basically opens a file stream with no Audio or Video drivers, 
and just reads the meta data from the file (title information), and then 
quits.

A gdb backtrace and valgrind have led me to believe there is a fault in 
libselinux.

Though this could very possibly be a fault in libxine, I'd have thought 
libselinux would be more resilient to such issues. Especially since 
glibc didnt complain.

If you would like to run this test code, simply install xine-lib-devel 
and then compile the test program.

$ gcc -lxine -g test.c
$ ./a.out

I'm using an up-to-date FC10 x86_64 installation. 
2.6.27.19-170.2.35.fc10.x86_64


Vikram


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
