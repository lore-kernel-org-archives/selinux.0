Subject: Re: [PATCH] add central errno.h to libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <45ACE84C.9000409@mentalrootkit.com>
References: <45AC06E8.3020708@mentalrootkit.com>
	 <1168953111.22731.50.camel@moss-spartans.epoch.ncsc.mil>
	 <45ACE84C.9000409@mentalrootkit.com>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 10:31:45 -0500
Message-Id: <1169134305.22731.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-16 at 09:59 -0500, Karl MacMillan wrote:
> Stephen Smalley wrote:
> > On Mon, 2007-01-15 at 17:57 -0500, Karl MacMillan wrote:
> >> The attached patch adds a central errno.h to libsepol and converts 
> >> several existing error numbers. This will unify the error numbers, 
> >> remove duplication, and prevent overlapping error numbers (a source of 
> >> potential bugs). Existing return values from functions exposed as part 
> >> of the binary interface are not changed.
> > 
> > I'm not enthusiastic about diverging the errno values from the system
> > values for e.g. ENOMEM and friends.  I'd prefer to keep them the same,
> > and use some other part of the value space for any custom error values
> > defined by libsepol.
> 
> I think that practically we are going to end up diverging from system 
> errno values to some extent. For example, -EPERM is -1 and I think that 
> trying to change every function that returns -1 for general error is 
> going to be hard.
> 
> The updated patch aligns them more closely, however.
> 
>    Also, I'm not sure about referring to this as
> > errno.h, as libsepol is _not_ setting errno to these values; it uses
> > these values as internal return values for conveying error information.
> 
> Changed to errcodes.h.
> 
> > The functions that do happen to explicitly set errno are using
> > traditional errno values.
> 
> I explicitly did not change those return values.
> 
> In addition to the changes noted above, I removed the license statements 
> from the header files, which I took as the consensus from the other 
> discussion in this thread. Updated patch attached.
> 
> The attached patch adds a central header for error and return codes 
> (errcodes.h) to libsepol and converts several existing error numbers. 
> This will unify the error numbers, remove duplication, and prevent 
> overlapping error numbers (a source of potential bugs). Existing return 
> values from functions exposed as part of the binary interface are not 
> changed.
> 
> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> 
>   checkpolicy/policy_parse.y                    |   15 ++---
>   libsepol/include/sepol/errcodes.h             |   25 ++++++++
>   libsepol/include/sepol/policydb/hashtab.h     |   23 +++-----
>   libsepol/include/sepol/policydb/link.h        |   29 +---------
>   libsepol/src/avtab.c                          |   18 +++---
>   libsepol/src/expand.c                         |    7 +-
>   libsepol/src/hashtab.c                        |   45 +++++++++++-----
>   libsepol/src/link.c                           |   33 ++++++-----
>   libsepol/src/policydb.c                       |    6 +-
>   libsepol/src/private.h                        |    4 +
>   policycoreutils/semodule_deps/semodule_deps.c |    9 +--
>   11 files changed, 122 insertions(+), 92 deletions(-)

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

(for trunk only, not stable)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
