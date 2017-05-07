Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v474ktCc006228
 for <selinux@tycho.nsa.gov>; Sun, 7 May 2017 00:46:55 -0400
Received: by mail-it0-f44.google.com with SMTP id x188so25266288itb.0
 for <selinux@tycho.nsa.gov>; Sat, 06 May 2017 21:46:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8b1d353c-7f98-5522-4f42-906a7082d47a@gmail.com>
References: <72df5e72-55ac-5696-ceb6-f50f98a35ea5@gmail.com>
 <87tw4yfs82.fsf@handshake.de> <8b1d353c-7f98-5522-4f42-906a7082d47a@gmail.com>
From: Dan Stromberg <drsalists@gmail.com>
Date: Sat, 6 May 2017 21:46:51 -0700
Message-ID: <CAGGBd_r+JWr3LHkkKT3p4w44YjeuBipGDseLmXihvoD3n+5Tew@mail.gmail.com>
Subject: Re: Why does Python want to read /proc/meminfo
To: Ian Pilcher <arequipeno@gmail.com>
Cc: dieter <dieter@handshake.de>, Python List <python-list@python.org>,
 selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, May 6, 2017 at 9:07 AM, Ian Pilcher <arequipeno@gmail.com> wrote:
> On 05/06/2017 12:51 AM, dieter wrote:
> You're right.  Seems that it's glibc's qsort().
>
> So it seems that any service written in Python (or any other program
> that uses qsort) needs to be given read access to most of /proc or deal
> with the (unspecified) consequences of not allowing qsort() to determine
> the amount of memory in the system.

Actually, this appears to be a false conclusion.  Supporting detail
for CPython 2.x and 3.x:

$ strace -f python -c 'import sys' 2>&1 | egrep /proc
below cmd output started 2017 Sat May 06 09:37:36 PM PDT
above cmd output done    2017 Sat May 06 09:37:36 PM PDT
dstromberg@dell-inspiron:~ x86_64-unknown-linux-gnu 14674

$ strace -f python3 -c 'import sys' 2>&1 | egrep /proc
below cmd output started 2017 Sat May 06 09:37:53 PM PDT
above cmd output done    2017 Sat May 06 09:37:53 PM PDT
dstromberg@dell-inspiron:~ x86_64-unknown-linux-gnu 14674

Also, keep in mind that "python" is just the reference implementation
of the language.  There are several implementations of python the
language now.

Don't be too hard on glibc. It seems to work pretty well, and a good
sort algorithm probably benefits significantly from knowing how much
RAM is available when sorting very large lists.

Also, don't be overly hard on SELinux.  It's a relatively young
technology and may still adapt to such needs better in the future.

HTH
