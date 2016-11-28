Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uASFCmin021114
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 10:12:48 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 1B8BA1A1A8
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 16:12:40 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id cbnGK837jxic for <selinux@tycho.nsa.gov>;
 Mon, 28 Nov 2016 16:12:38 +0100 (CET)
Received: from [10.20.11.84] (unknown [193.53.238.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id E89611A1A1
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 16:12:37 +0100 (CET)
Subject: Re: setools: cast increases required alignment of target type
To: selinux@tycho.nsa.gov
References: <35b585fa-99dc-0343-67df-7f9919d3ffb9@debian.org>
From: Laurent Bigonville <bigon@debian.org>
Message-ID: <c4114f38-0d33-94ff-f4f2-b17ae1fb7ab3@debian.org>
Date: Mon, 28 Nov 2016 16:12:36 +0100
MIME-Version: 1.0
In-Reply-To: <35b585fa-99dc-0343-67df-7f9919d3ffb9@debian.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Le 24/11/16 à 21:35, Laurent Bigonville a écrit :
> Hi,
>
> When compiling setools on at least mips64el and sparc64, I get the 
> following error:
>
> mips64el-linux-gnuabi64-gcc -pthread -DNDEBUG -g -fwrapv -O2 -Wall 
> -Wstrict-prototypes -g -O2 -fdebug-prefix-map=/«PKGBUILDDIR»=. 
> -fstack-protector-strong -Wformat -Werror=format-security 
> -Wno-sign-compare -Wdate-time -D_FORTIFY_SOURCE=2 -fPIC -Ilibqpol 
> -Ilibqpol/include -I/usr/include/python3.5m -c 
> libqpol/module_compiler.c -o 
> build/temp.linux-mips64-3.5/libqpol/module_compiler.o -Werror -Wextra 
> -Waggregate-return -Wcast-align -Wfloat-equal -Wformat -Wformat=2 
> -Winit-self -Winline -Wmissing-format-attribute -Wmissing-include-dirs 
> -Wnested-externs -Wold-style-definition -Wpointer-arith 
> -Wredundant-decls -Wstrict-prototypes -Wunknown-pragmas 
> -Wwrite-strings -Wno-missing-field-initializers -Wno-unused-parameter 
> -Wno-cast-qual -Wno-shadow -Wno-unreachable-code -fno-exceptions
> libqpol/module_compiler.c: In function ‘declare_symbol’:
> libqpol/module_compiler.c:155:19: error: cast increases required 
> alignment of target type [-Werror=cast-align]
>     *dest_value = ((level_datum_t *)s)->level->sens;

Well this is actually fixed in the master branch 
(9fbfeb43d20dd196b1831ef63b4a4f4f087a0be4) of setools and not the 4.0 
one, nevermind then.
