Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9O74EE2026957
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2008 03:04:14 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9O72laq016127
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2008 07:02:48 GMT
From: Jim Meyering <jim@meyering.net>
To: Vikram Noel Ambrose <noel.ambrose@gmail.com>
Cc: bug-coreutils@gnu.org, selinux@tycho.nsa.gov, 472590@bugs.debian.org,
        =?utf-8?B?T25kxZllaiBWYcWhw61r?= <ovasik@redhat.com>
Subject: Re: RFC: changing the "+" in ls -l output to be "." or "+"
In-Reply-To: <49013EA2.8070301@gmail.com> (Vikram Noel Ambrose's message of
	"Thu, 23 Oct 2008 23:18:58 -0400")
References: <200803251523.34329.russell@coker.com.au>
	<87tziu96yz.fsf@rho.meyering.net> <20080325173116.GQ2626@mathom.us>
	<200803260824.17731.russell@coker.com.au>
	<877ifj9sgs.fsf@rho.meyering.net> <87prt8uhci.fsf_-_@rho.meyering.net>
	<8763njqz9a.fsf@rho.meyering.net> <49013EA2.8070301@gmail.com>
Date: Fri, 24 Oct 2008 09:04:12 +0200
Message-ID: <87mygumq37.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Vikram Noel Ambrose <noel.ambrose@gmail.com> wrote:
> Jim Meyering <jim@meyering.net> wrote:
...
>>>>     if (SELinux, with no other MAC or ACL)
>>>>       use '.'
>>>>     else if (any other combination of alternate access methods)
>>>>       use '+'
...
>>> Here's sample output, running on an SELinux system:
>>>
>>>   $ src/ls -ldgo [ac]*
>>>   -rw-r--r--.  1   42625 2008-04-02 19:31 aclocal.m4
>>>   drwxr-xr-x.  2    4096 2008-04-02 19:31 autom4te.cache
>>>   -rw-r--r--.  1    1597 2008-03-21 16:35 cfg.mk
>>>   -rw-r--r--.  1 1417195 2008-04-02 19:33 config.log
>>>   -rwxr-xr-x.  1   71225 2008-04-02 19:33 config.status
>>>   -rwxr-xr-x.  1 1846424 2008-04-02 19:31 configure
>>>   -rw-r--r--.  1   12014 2008-03-25 23:55 configure.ac
>>>
>
> This is so confusing. What is so horribly wrong with a capital S for
> SELinux or A for ACL?

A desire for compatibility makes "+" look good.
"." is appealing for SELinux-only because it's inconspicuous.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
