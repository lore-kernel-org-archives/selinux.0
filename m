Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6UGRwgA008013
	for <selinux@tycho.nsa.gov>; Sat, 30 Jul 2005 12:28:00 -0400 (EDT)
Received: from mail.4-mail.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6UGKu7R016799
	for <selinux@tycho.nsa.gov>; Sat, 30 Jul 2005 16:20:57 GMT
Received: from localhost (gate [127.0.0.1])
	by mail.4-mail.net (Postfix) with ESMTP id D4558673CB
	for <selinux@tycho.nsa.gov>; Sat, 30 Jul 2005 18:21:46 +0200 (CEST)
Received: from mail.4-mail.net ([127.0.0.1])
 by localhost (mail.4-mail.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19345-04 for <selinux@tycho.nsa.gov>;
 Sat, 30 Jul 2005 18:21:38 +0200 (CEST)
Received: from [192.168.100.3] (85-124-59-247.dynamic.xdsl-line.inode.at [85.124.59.247])
	by mail.4-mail.net (Postfix) with ESMTP id 0DBE4673CA
	for <selinux@tycho.nsa.gov>; Sat, 30 Jul 2005 18:21:37 +0200 (CEST)
Message-ID: <42EBC487.2080908@online-tutorials.net>
Date: Sat, 30 Jul 2005 20:18:47 +0200
From: Simon Hecht <simon_hecht@online-tutorials.net>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: tcl headers, useradd and libuser.conf
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

I try to install selinux on a Debian system (sarge) but during the 
installation I had some problems:


setools (2.1.1):

I have install tcl and tk with

apt-get install tcl8.4 tcl8.4-dev tk8.4 tk8.4-dev

but the headers have been installed to /usr/include/tcl8.4/ and so 
#include <tcl.h> and #include <tk.h> doen't work. I changed some Makefiles.


policy (1.24):

make all && make install returned something like: grep: 
/etc/default/useradd: No such file or directory

It seems that the useradd file does'n exist on a new debian system, but 
useradd -D -g100 -f0 -s/bin/bash fixed this problem.


And now I got the following error:

grep: /etc/libuser.conf: No such file or directory
You do not have access to /etc/libuser.conf LU_HOMEDIRECTORY=

I searched for hours but I didn't find a solution. How do I solve this?

Sorry for my bad english ;)

Simon Hecht




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
