Subject: Re: Using "override CFLAGS += -I$(PREFIX)/include" in mcstrans?
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux <selinux@tycho.nsa.gov>
References: <CAJfZ7=nN_w9kNKTWmFX01=0KZGm4cN1A-rut6=arH-M+Nydbog@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <cd8296a4-de52-d3cb-e3d9-5ba738fac1ea@tycho.nsa.gov>
Date: Thu, 17 Nov 2016 08:50:26 -0500
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=nN_w9kNKTWmFX01=0KZGm4cN1A-rut6=arH-M+Nydbog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/16/2016 05:17 PM, Nicolas Iooss wrote:
> Hello,
> 
> A few weeks ago I configured Travis-CI to build the SELinux userspace
> projects with several configurations (gcc and clang compilers, several
> Python and Ruby versions...). Since the merge of splitpolicycoreutils
> the builds I have done failed because of at least two things (cf. [1]
> for the raw result):
> 
> - sandbox test contains "if selinux.security_getenforce() == 1:" to skip
> the test on systems where SELinux is in enforcing mode. This fails with
> a FileNotFoundError on a system without SELinux (like Travis-CI build
> environments). To fix this I wrote a patch [1] that I'll send once I get
> the tests running fine again.
> 
> - When building mcstrans with a "make install" in the root directory,
> the compiler complains with "fatal error: selinux/selinux.h: No such
> file or directory". Other subdirectories have "override CFLAGS +=
> -I$(PREFIX)/include" to include files installed in $DESTDIR. This makes
> "make DESTDIR=/tmp/xxxx install" work on systems without SELinux.
> Moreover mcstrans/src/Makefile uses "override CFLAGS += -I../include"
> but mcstrans/include/ does not exist. I feel like this line should be
> modified to "...-I$(PREFIX)..." but it makes me quite uneasy so before
> writing a patch, I would like to be sure I am not missing something I
> have not seen in my quick reading of the files. This is why I am writing
> this email: could you please take a look at mcstrans Makefiles?

Changing it to -I$(PREFIX)/include sounds right to me.

> 
> Thanks,
> Nicolas
> 
> [1] https://travis-ci.org/fishilico/selinux/jobs/176506142
> [2] https://github.com/fishilico/selinux/commit/1c3cae4a984a6dc9a5ba5190a69bf4e7a2362623
