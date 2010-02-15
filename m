Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1FMJvcM010410
	for <selinux@tycho.nsa.gov>; Mon, 15 Feb 2010 17:19:57 -0500
Received: from mail-iw0-f198.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1FMKAFc002277
	for <selinux@tycho.nsa.gov>; Mon, 15 Feb 2010 22:20:10 GMT
Received: by iwn36 with SMTP id 36so3482985iwn.3
        for <selinux@tycho.nsa.gov>; Mon, 15 Feb 2010 14:19:55 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 15 Feb 2010 14:19:54 -0800
Message-ID: <dd18b0c31002151419v1445e151j761c06e3cf39f5c0@mail.gmail.com>
Subject: label_file.c:434: error: implicit declaration of function 'fstat'
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

this is new:


make[2]: Leaving directory `/home/kernel/selinux/libselinux/include'
make -C src install
make[2]: Entering directory `/home/kernel/selinux/libselinux/src'
cc -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn
-Wmissing-format-attribute -I../include -I/usr/include -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=64   -c -o label_file.o label_file.c
cc1: warnings being treated as errors
label_file.c: In function 'init':
label_file.c:434: error: implicit declaration of function 'fstat'
label_file.c:436: error: implicit declaration of function 'S_ISREG'
make[2]: *** [label_file.o] Error 1
make[2]: Leaving directory `/home/kernel/selinux/libselinux/src'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/home/kernel/selinux/libselinux'
make: *** [install] Error 1

three areas where this could of been created
update glibc
updated kernel
update userspace(altohugh there was not vary many commits in the pull).



-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
