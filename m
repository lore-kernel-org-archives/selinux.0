Subject: Re: [RFC][PATCH 1/2] Further SELinux restrictions on mprotect
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: selinux@tycho.nsa.gov, drepper@redhat.com, roland@redhat.com,
   mingo@redhat.com, James Morris <jmorris@redhat.com>
In-Reply-To: <1114632785.8548.24.camel@localhost.localdomain>
References: <1114017480.8495.93.camel@localhost.localdomain>
	 <1114619778.4115.127.camel@moss-spartans.epoch.ncsc.mil>
	 <1114632785.8548.24.camel@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Date: Thu, 28 Apr 2005 08:27:47 -0400
Message-Id: <1114691267.6708.63.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-04-27 at 22:13 +0200, Lorenzo Hernández García-Hierro
wrote:
> > Running valgrind does not yield an execstack denial and only appears to
> > require execmem permission.
> 
> It's a special case as Ulrich notes in the latter reply.
> I was wrong about it, I apologize for any inconvenience.

Just to clarify, the valgrind behavior is what I expected to happen,
i.e. it needs to perform runtime code generation (thus needs execmem)
but does not need an executable stack (thus does not need execstack).
Thus, that particular test went as expected; it has the desired behavior
- we can allow it execmem without allowing it execstack.  What was
surprising/disheartening was that we didn't get the expected behavior
from the Sun jre, where it seemed to require execstack as well as
execmem in order to function.  But hopefully that can be fixed.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
