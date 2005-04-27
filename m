Subject: Re: [RFC][PATCH 1/2] Further SELinux restrictions on mprotect
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: selinux@tycho.nsa.gov, drepper@redhat.com, roland@redhat.com,
   mingo@redhat.com, James Morris <jmorris@redhat.com>
In-Reply-To: <1114017480.8495.93.camel@localhost.localdomain>
References: <1114017480.8495.93.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Wed, 27 Apr 2005 12:36:18 -0400
Message-Id: <1114619778.4115.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-04-20 at 19:18 +0200, Lorenzo Hernández García-Hierro
wrote:
> The first patch, included inline below, adds an execstack permission
> check that controls the ability to make the main process stack
> executable so that attempts to make the stack executable can still be
> prevented even if the process is allowed the existing execmem
> permission in order to e.g. perform runtime code generation.  Note that
> this does not yet address thread stacks. Note also that unlike the
> execmem check, the execstack check is only applied on mprotect calls,
> not mmap calls, as the current security_file_mmap hook is not passed
> the necessary information presently.

Thanks for working on these patches.  I built a 2.6.12-rc3 kernel with
execshield and both of these patches applied, and then performed a
little experimentation, yielding the following results:

The execstack check kills the mprotstack test of the modified paxtest as
expected even if execmem is allowed.  Likewise, the execheap check kills
the mprotheap test of the modified paxtest.

As expected, X requires execheap permission presently.

Running firefox with the Sun java plugin installed yields an execstack
denial on firefox-bin, and the plugin doesn't seem to work then.  Hence,
we don't seem to gain any benefit in that particular case.

Running valgrind does not yield an execstack denial and only appears to
require execmem permission.

Running OpenOffice generates audit messages for both execstack and
execheap denials on soffice.bin, but still appears to function.  Not
sure what is occurring there.

What do others think about these additional permission checks,
particularly in terms of being able to practically apply them?  Has
anyone else experimented with them?

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
