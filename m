Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9NCKJoL010053
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2008 08:20:19 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9NCKIR9006738
	for <selinux@tycho.nsa.gov>; Thu, 23 Oct 2008 12:20:19 GMT
From: Jim Meyering <jim@meyering.net>
To: bug-coreutils@gnu.org
Cc: selinux@tycho.nsa.gov, 472590@bugs.debian.org
Cc: =?utf-8?B?T25kxZllaiBWYcWhw61r?= <ovasik@redhat.com>
Subject: Re: RFC: changing the "+" in ls -l output to be "." or "+"
In-Reply-To: <87prt8uhci.fsf_-_@rho.meyering.net> (Jim Meyering's message of
	"Wed, 02 Apr 2008 22:33:49 +0200")
References: <200803251523.34329.russell@coker.com.au>
	<87tziu96yz.fsf@rho.meyering.net> <20080325173116.GQ2626@mathom.us>
	<200803260824.17731.russell@coker.com.au>
	<877ifj9sgs.fsf@rho.meyering.net> <87prt8uhci.fsf_-_@rho.meyering.net>
Date: Thu, 23 Oct 2008 14:20:17 +0200
Message-ID: <8763njqz9a.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jim Meyering <jim@meyering.net> wrote:
> I wrote this:
>> [ I'm Cc'ing bug-coreutils@gnu.org.
>>   FYI, this is a continuation of discussion from the SELinux list:
>>   http://marc.info/?t=120645074000003&r=1&w=2
>>   and the debian bug tracking system: http://bugs.debian.org/472590
>>
>>   The problem is that on an SELinux-enabled system, 'ls -l's "+",
>>   the "alternate access method" indicator, is useless, because it
>>   appears on every file:
>>
>>       $ ls -glo /var
>>       total 164
>>       drwxr-xr-x+  3 4096 2008-03-29 08:43 kerberos
>>       drwxr-xr-x+ 39 4096 2008-03-29 08:43 lib
>>       drwxr-xr-x+  2 4096 2008-03-27 17:33 local
>>       drwxrwxr-x+  8 4096 2008-03-31 04:15 lock
>>       drwxr-xr-x+ 20 4096 2008-03-31 09:55 log
>>       lrwxrwxrwx+  1   10 2008-03-28 23:33 mail -> spool/mail
>>       ...
>>
>>   Newer POSIX allows any non-space character as the indicator, and
>>   that's what we're discussing now.
>>   ]
>>
>> Russell Coker <russell@coker.com.au> wrote:
>>> On Wednesday 26 March 2008 04:31, Michael Stone <mstone@debian.org> wrote:
>>>> if (acl) then '+'
>>>> else if (selinux) then '.'
>>>
>>> Should there be some special marking of files with both a SE Linux context and
>>> an ACL?
>>>
>>> Pity that they didn't choose an "a" to mark an ACL which would then permit
>>> using "A" for ACL + MAC.
>>
>> This is probably as good a time as any to make such a change, though
>> I doubt it will make the cut for the upcoming release.  I'd like to keep
>> it simple (i.e., not try to encode all possible combinations).  If you
>> want to get full details, stat(1) is probably the program to change.
>>
>> I like Michael's suggestion.  Rephrasing it,
>>
>>     if (SELinux, with no other MAC or ACL)
>>       use '.'
>>     else if (any other combination of alternate access methods)
>>       use '+'
>>
>> If someone who already has a copyright assignment on file for coreutils
>> wants to write the patch (including doc update, tests, NEWS, ChangeLog,
>> etc.), please speak up ASAP.  Otherwise I'll do it.
>
> No one spoke up, so here's code, for discussion's sake.
> I've tested it only lightly.
> This change is not slated for the upcoming release.
>
> Here's sample output, running on an SELinux system:
>
>   $ src/ls -ldgo [ac]*
>   -rw-r--r--.  1   42625 2008-04-02 19:31 aclocal.m4
>   drwxr-xr-x.  2    4096 2008-04-02 19:31 autom4te.cache
>   -rw-r--r--.  1    1597 2008-03-21 16:35 cfg.mk
>   -rw-r--r--.  1 1417195 2008-04-02 19:33 config.log
>   -rwxr-xr-x.  1   71225 2008-04-02 19:33 config.status
>   -rwxr-xr-x.  1 1846424 2008-04-02 19:31 configure
>   -rw-r--r--.  1   12014 2008-03-25 23:55 configure.ac

Thanks to a nudge from Ondřej, I've just completed and pushed this:
