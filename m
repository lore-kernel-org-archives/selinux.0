Subject: Re: [patch] libsemanage:  clear errno ENOMEM from libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        Daniel J Walsh <dwalsh@redhat.com>, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <1196372482.24040.86.camel@moss-spartans.epoch.ncsc.mil>
References: <1196372482.24040.86.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 30 Nov 2007 09:56:15 -0500
Message-Id: <1196434575.10720.15.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-11-29 at 16:41 -0500, Stephen Smalley wrote:
> On errors during libsepol processing (missing requirements, 
> neverallow failure, etc), we are getting a bogus "Could not allocate memory"
> message appended to the libsepol error message by libsemanage when
> it reports strerror(errno), which was added to provide useful messages
> on e.g. filesystem full or read-only filesystem errors.  It appears that
> errno is getting set by glibc upon some memory allocations performed by
> libsepol even when it ultimately succeeds.  So for now, clear such errnos
> from libsepol - on real out of memory conditions, libsepol already tells
> us that in its own error message.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

I'm going to NAK my own patch ;)

I'll investigate a better approach to handling this, as losing the errno
doesn't seem good when there is truly an ENOMEM condition.  I'm still
not 100% clear as to what precisely is setting it to ENOMEM, as we
aren't getting any actual memory failures.

> 
> ---
> 
>  libsemanage/src/debug.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: trunk/libsemanage/src/debug.c
> ===================================================================
> --- trunk/libsemanage/src/debug.c	(revision 2692)
> +++ trunk/libsemanage/src/debug.c	(working copy)
> @@ -103,6 +103,10 @@
>  	if (!sh->msg_callback)
>  		return;
>  
> +	/* Clear transient memory allocation error, non-fatal. */
> +	if (errno == ENOMEM)	
> +		errno = 0; 
> +
>  	va_start(ap, fmt);
>  	vsnprintf(buffer, sizeof(buffer), fmt, ap);
>  	va_end(ap);
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
