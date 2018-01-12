Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0CFESbi027122
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 10:14:28 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC01.oob.disa.mil (Postfix) with SMTP id 3zJ5rD2pwqz1pJh0
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 15:14:20 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC01.oob.disa.mil (Postfix) with ESMTP id 3zJ5rD20qKz1pJgw
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 15:14:19 +0000 (UTC)
Received: by mail-lf0-f48.google.com with SMTP id w23so6265902lfd.11
 for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2018 07:11:54 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org
Date: Fri, 12 Jan 2018 16:11:32 +0100
Message-Id: <20180112151135.13202-1-marcus.folkesson@gmail.com>
In-Reply-To: <marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
Subject: Rework of Makefiles
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I have reworked the Makefiles a bit to make it more compatible with
the standard semantics for DESTDIR and PREFIX.

What made me look at this was a package I was working on in 
Buildroot[1] that was using the pkg-config file generated
from libselinux. The pkg-config file generated has bogus paths 
which results in that my package did not compile.

When looking further in our packages for libselinux/libsepol/libsemanage,
we allready do "tricks" to make it compile.
For example, we set DESTDIR during compilation to compute library and header paths.

DESTDIR should be supported only in the install* and uninstall* targets,
as those are the only targets where it is useful. [2]

PREFIX should be used to set a prefix for the installation.
This could be provided both in compile and install stages.


For example, consider the following line:
#make DESTDIR=/tmp/selinux install

It will generate a libselinux.pc file that looks like this:

prefix=/tmp/selinux/usr
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=/tmp/selinux/usr/include

The DESTDIR should not be part of the prefix. The correct output should be:

prefix=/usr
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=/usr/include

The following example do not compile at all:
#make DESTDIR=/tmp/myroot PREFIX=/selinux install

In this case, everything should be installed under /tmp/myroot/selinux.
The prefix in all generated pkg-files should have the path /selinux/xxxxx ( not /tmp/myroot/selinux/xxxx).

This patchsets tries to solve the following issues:
- The pkg-config files generates odd paths when using DESTDIR without PREFIX
- DESTDIR is needed during compile time to compute library and header paths which it should not.
- Installing with both DESTDIR and PREFIX set gives us odd paths
- Make usage of DESTDIR and PREFIX more standard

However, DESTDIR is still needed in the "root" Makefile to make libsemanage to compile.
But all components (libselinux, libsepol and libsemanage) can be compiled separatly with
standard usage of DESTDIR and PREFIX.

Thanks,

Best regards
Marcus Folkesson

[1] https://buildroot.org/
[2] https://www.gnu.org/prep/standards/html_node/DESTDIR.html
