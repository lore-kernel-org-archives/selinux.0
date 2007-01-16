Subject: Re: [PATCH] add central errno.h to libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45AC3FE9.3000204@tresys.com>
References: <45AC06E8.3020708@mentalrootkit.com>
	 <45AC3FE9.3000204@tresys.com>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 07:37:24 -0500
Message-Id: <1168951044.22731.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-01-15 at 22:00 -0500, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > The attached patch adds a central errno.h to libsepol and converts 
> > several existing error numbers. This will unify the error numbers, 
> > remove duplication, and prevent overlapping error numbers (a source of 
> > potential bugs). Existing return values from functions exposed as part 
> > of the binary interface are not changed.
> >
> 
> instead of adding license to files where it isn't present can we just 
> remove it everywhere and have a LICENSE file?

As I understand it, it is preferred to explicitly state the license in
each file, although naturally the terms of the license are spelled out
separately in the (already existing) COPYING file.  The only thing I
would question is putting it into the header files, as the header itself
is _not_ covered by the license; a program that includes the header in
order to use the library is not itself put under the LGPL.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
