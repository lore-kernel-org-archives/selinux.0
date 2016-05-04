Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u44Fe7LK008923
 for <selinux@tycho.nsa.gov>; Wed, 4 May 2016 11:40:07 -0400
Received: by mail-pa0-f54.google.com with SMTP id iv1so25368238pac.2
 for <selinux@tycho.nsa.gov>; Wed, 04 May 2016 08:39:45 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 4 May 2016 11:39:44 -0400
Message-ID: <CAMyQ4FwP25QU3EvAfw0oLQuH1x05S6G8a=F7G9vnsk2duJyCvg@mail.gmail.com>
Subject: SELinux build errors
From: David Merritt <david.d.merritt@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

platform: CentOS 7 x64

from:

https://github.com/SELinuxProject/selinux

git clone https://github.com/SELinuxProject/selinux.git

cd selinux

make DESTDIR=~/obj install install-pywrap

yields:

.
.
.
make[2]: Entering directory `/root/Desktop/selinux/libsepol/src'
cc -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2
-I. -I../include -D_GNU_SOURCE -I../cil/include -fPIC -c -o
../cil/src/cil_lexer.o ../cil/src/cil_lexer.c
<stdout>: In function ‘cil_yy_scan_bytes’:
<stdout>:1567:17: error: comparison between signed and unsigned
integer expressions [-Werror=sign-compare]
cc1: all warnings being treated as errors
make[2]: *** [../cil/src/cil_lexer.o] Error 1
make[2]: Leaving directory `/root/Desktop/selinux/libsepol/src'
make[1]: *** [install] Error 2
make[1]: Leaving directory `/root/Desktop/selinux/libsepol'
make: *** [install] Error 1
