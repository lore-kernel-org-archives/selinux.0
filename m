Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAOKZEC6001653
 for <selinux@tycho.nsa.gov>; Thu, 24 Nov 2016 15:35:14 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id A2C461A1AE
 for <selinux@tycho.nsa.gov>; Thu, 24 Nov 2016 21:35:10 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id lmNaSjGCaPv9 for <selinux@tycho.nsa.gov>;
 Thu, 24 Nov 2016 21:35:08 +0100 (CET)
Received: from [IPv6:2a02:a03f:6c:e500:edf:2fd8:fc0a:f176] (unknown
 [IPv6:2a02:a03f:6c:e500:edf:2fd8:fc0a:f176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 2702A1A1A8
 for <selinux@tycho.nsa.gov>; Thu, 24 Nov 2016 21:35:08 +0100 (CET)
To: selinux@tycho.nsa.gov
From: Laurent Bigonville <bigon@debian.org>
Subject: setools: cast increases required alignment of target type
Message-ID: <35b585fa-99dc-0343-67df-7f9919d3ffb9@debian.org>
Date: Thu, 24 Nov 2016 21:35:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

When compiling setools on at least mips64el and sparc64, I get the 
following error:

mips64el-linux-gnuabi64-gcc -pthread -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -g -O2 -fdebug-prefix-map=/«PKGBUILDDIR»=. -fstack-protector-strong -Wformat -Werror=format-security -Wno-sign-compare -Wdate-time -D_FORTIFY_SOURCE=2 -fPIC -Ilibqpol -Ilibqpol/include -I/usr/include/python3.5m -c libqpol/module_compiler.c -o build/temp.linux-mips64-3.5/libqpol/module_compiler.o -Werror -Wextra -Waggregate-return -Wcast-align -Wfloat-equal -Wformat -Wformat=2 -Winit-self -Winline -Wmissing-format-attribute -Wmissing-include-dirs -Wnested-externs -Wold-style-definition -Wpointer-arith -Wredundant-decls -Wstrict-prototypes -Wunknown-pragmas -Wwrite-strings -Wno-missing-field-initializers -Wno-unused-parameter -Wno-cast-qual -Wno-shadow -Wno-unreachable-code -fno-exceptions
libqpol/module_compiler.c: In function ‘declare_symbol’:
libqpol/module_compiler.c:155:19: error: cast increases required alignment of target type [-Werror=cast-align]
     *dest_value = ((level_datum_t *)s)->level->sens;
                    ^
libqpol/module_compiler.c: In function ‘require_symbol’:
libqpol/module_compiler.c:650:19: error: cast increases required alignment of target type [-Werror=cast-align]
     *dest_value = ((level_datum_t *)s)->level->sens;
                    ^
libqpol/module_compiler.c: In function ‘require_bool_tunable’:
libqpol/module_compiler.c:1077:36: error: cast increases required alignment of target type [-Werror=cast-align]
       require_symbol(SYM_BOOLS, id, (hashtab_datum_t *) booldatum,
                                     ^
libqpol/module_compiler.c: In function ‘require_cat’:
libqpol/module_compiler.c:1201:40: error: cast increases required alignment of target type [-Werror=cast-align]
   retval = require_symbol(SYM_CATS, id, (hashtab_datum_t *) cat,
                                         ^
cc1: all warnings being treated as errors
error: command 'mips64el-linux-gnuabi64-gcc' failed with exit status 1

This is fatal only on some architectures, but I guess fixing this could 
also improve the performances on the others.

Regards,

Laurent Bigonville
