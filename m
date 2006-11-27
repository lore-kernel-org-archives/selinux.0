Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kARMN8OL014767
	for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2006 17:23:08 -0500
Subject: Re: [PATCH 1/5] libselinux: labeling API basic front-end interface
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4561CB69.3040409@mentalrootkit.com>
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
	 <1163645170.15225.66.camel@moss-huskies.epoch.ncsc.mil>
	 <4561CB69.3040409@mentalrootkit.com>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 17:23:07 -0500
Message-Id: <1164666187.2794.67.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-20 at 10:36 -0500, Karl MacMillan wrote:
> Eamon Walsh wrote:
> > This is the basic front-end interface.  Note that backends may supply
> > additional values and flags, which will be seen with the file_contexts
> > backend.
> > 
> 
> General comment - I think that providing this infrastructure is a good 
> idea and the basic approach is sane.

Thanks for the comments.

> 
> > ---
> >  include/selinux/label.h         |  181 ++++++++++++++++++++++++
> >  include/selinux/label_backend.h |   20 ++
> >  2 files changed, 201 insertions(+)
> > 
> > 
> > 
> > 
> > ------------------------------------------------------------------------
> > 
> > Index: include/selinux/label.h
> > ===================================================================
> > --- include/selinux/label.h	(revision 0)
> > +++ include/selinux/label.h	(revision 0)
> > @@ -0,0 +1,181 @@
> > +/*
> > + * Labeling interface for userspace object managers and others.
> > + *
> > + * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
> > + */
> > +#ifndef _SELINUX_LABEL_H_
> > +#define _SELINUX_LABEL_H_
> > +
> > +#include <sys/types.h>
> > +#include <selinux/selinux.h>
> > +
> > +#ifdef __cplusplus
> > +extern "C" {
> > +#endif
> > +
> > +/*
> > + * User-provided callbacks for memory, logging, locking, and extra actions
> > + */
> > +
> > +/* These structures are passed by reference to label_init().  Passing
> > + * a NULL reference will cause a default to be used.  The default
> > + * memory callbacks are malloc() and free().  The default logging method
> > + * is to print on stderr.  The default validation callback is based on
> > + * selinux_check_context().  If no locking callbacks are passed, no locking
> > + * will take place.
> > + */
> > +	struct label_memory_callback {
> > +		/* malloc() equivalent. */
> > +		void *(*func_malloc) (size_t size);
> > +		/* free() equivalent. */
> > +		void (*func_free) (void *ptr);
> > +		/* Note that these functions should set errno on failure.
> > +		   If not, some routines may return -1 without errno set. */
> > +	};
> > +
> 
> Do you have an example of when this flexibility would be needed?

Yes, the X server has an "xalloc" function that is used internally.
There have been experiments with userspace memory managers to reduce
fragmentation, although right now xalloc just wraps malloc.  I'd think
that databases may do the same type of thing - I don't know, however.

> 
> > +	struct label_log_callback {
> > +		/* log the printf-style format and arguments,
> > +		   with the type code indicating the type of message */
> > +		int (*func_log) (int type, const char *fmt, ...);
> > +	};
> > +
> > +	struct label_action_callback {
> > +		/* validate the supplied context, making changes if necessary,
> > +		   returning 0 if valid or -1 with errno set otherwise. */
> > +		int (*func_validate) (security_class_t cls, char **context);
> > +	};
> > +
> > +	struct label_lock_callback {
> > +		/* create a lock and return an opaque pointer to it. */
> > +		void *(*func_alloc_lock) (void);
> > +		/* obtain a given lock, blocking if necessary. */
> > +		void (*func_get_lock) (void *lock);
> > +		/* release a given lock. */
> > +		void (*func_release_lock) (void *lock);
> > +		/* destroy a given lock (free memory, etc.) */
> > +		void (*func_free_lock) (void *lock);
> > +	};
> > +
> 
> I would prefer to let clients to do locking by providing clear 
> guarantees on the threading properties of the functions. Any reasons why 
> this would be required.

This is a hold-over from the userspace AVC interface.  The userspace AVC
can start a background thread that listens on netlink for selinux policy
reload notifications so it can flush its cache.  The locking can't be
done by the client in this case.

Compatibility with both the userspace AVC and the matchpathcon interface
played a large part in my thinking.

> 
> Additionally, if we take this callback approach can we combine this with 
> the related userspace AVC callbacks? Would a single client need to 
> provide different callbacks for locking and memory between the labeling 
> and AVC interfaces?

The callbacks and callback structures are identical, allowing reuse.

> 
> > +/* Logging type codes, passed to the logging callback */
> > +#define LABEL_ERROR		0
> > +#define LABEL_WARNING		1
> > +#define LABEL_INFO		2
> > +#define LABEL_INVALIDCON	3
> > +
> > +/*
> > + * Label operations
> > + */
> > +
> > +/**
> > + * label_init - Initialize the labeling system.
> > + * @prefix: used by the backend for selecting a configuration or package
> > + * @mem_callbacks: user-supplied memory callbacks
> > + * @log_callbacks: user-supplied logging callbacks
> > + * @action_callbacks: user-supplied validation callbacks
> > + * @lock_callbacks: user-supplied locking callbacks
> > + *
> > + * Initialize the labeling subsystem.  Return %0 on success or -%1 with @errno
> > + * set on failure.  Argument @name must not be NULL or empty.  If any callback 
> > + * structure references are NULL, use default methods for those callbacks (see
> > + * the definition of the callback structures above).
> > + */
> > +	int label_init(const char *prefix,
> > +		       const struct label_memory_callback *mem_callbacks,
> > +		       const struct label_log_callback *log_callbacks,
> > +		       const struct label_action_callback *action_callbacks,
> > +		       const struct label_lock_callback *lock_callbacks);
> > +
> 
> First - my biggest confusion here is how the backend, prefix, and label 
> action callbacks all relate. To me - this is not immediately clear so at 
> least some documentation is needed. I think, however, that it might be a 
> sign that the API needs some work. Can you give some more explanation. 
> Also, a little code showing how a client would use this API would also 
> be helpful.

I'll send out a patch to setfiles so you can see how it would be used.

The name "prefix" may not be very descriptive, I couldn't think of a
better name for it so I just kept the name from the avc_init() prefix
argument, which serves as the prefix to the AVC messages.

Anyway, this string serves as an argument to the backend's
initialization routine, which returns a handle that is stored in a
linked list.  Each time the prefix string is changed with
label_change_name(), an additional handle is obtained from the backend.
So you have a mapping of:

(object class, prefix string) -> handle

where the prefix string is set with label_init()/label_change_name(),
and the object class is provided to label_configure()/label_lookup().

The reason for the prefix string is package separation; think of the
prefix string as a package name.  It would allow, say, the file contexts
for each package to be shipped and installed separately, then the
installer could use the package name as the prefix at install time to
open the file contexts for just the new package and relabel them.

Another, more immediate reason for it is that there is both a
file_contexts configuration and a media_contexts configuration (from the
udev folks) both associated with object class file and I needed a way to
select between them (as can be seen by the string constants in
label_backend_file.h).

> 
> Second - I question the storage of "subsystems" (not certain if that is 
> the correct term) in a global array in the library. Why not return a 
> handle that is managed by the client? That could also be used to make 
> the locking semantics clearer and allow client locking.

The internal handle could be returned all the way out to the client.  My
thinking in not doing this is that by tracking the handles internally,
there is less work that has to be done by the client code itself, which
makes it easier to justify upstream in many of the large, multi-OS
projects we are targeting such as X, Postgres, etc.

Another reason is that I was thinking of a package manager or relabeler,
that may be going through all the packages on a system or otherwise
using many prefixes, which would require keeping track of many handles.
I thought it would be easier to just track them internally.

As discussed above, the background netlink thread thing in the userspace
AVC makes it difficult to do client locking without callbacks.

> 
> > +/**
> > + * label_change_name - Change system prefix
> > + * @prefix: used by the backend for selecting a configuration or package
> > + *
> > + * Change the prefix string used by the labeling system on future calls.  This
> > + * function may be called multiple times.  Backend configurations are kept
> > + * separately by prefix, meaning that after a call to this function, calls to
> > + * label_configure() may be necessary to re-initialize backends.  However, 
> > + * switching back to a prefix will preserve any configuration made previously
> > + * while that prefix was in effect.
> > + */
> > +	void label_change_name(const char *prefix);
> > +
> 
> This just becomes more confusing to me - the comment says that prefixes 
> are "used by the backend" and then says "Backend configurations are kept 
> separately by prefix". OK - do prefixes refer to backends or are they 
> used by backends?

Both - see above.  The prefix is passed to the backend's init function
to get a handle that is then stored in the linked list, with the prefix
as the key.

> 
> > +/**
> > + * label_configure - Configure specific labeling backend.
> > + * @cls: specifies the backend to configure
> > + * @flags: global and/or backend-specific configuration flags
> > + * @arg: additional backend-specific configuration data
> > + *
> > + * Configure a specific labeling backend.  This function should be called
> > + * after a successful call to label_init and is optional; it will be called
> > + * automatically with default arguments by label_lookup if necessary.  The
> > + * result of the call depends on the specific flags and the backend, although
> > + * typically the backend will reset its internal state.  Return %0 on success
> > + * or -%1 with @errno set on failure.  
> > + */
> > +	int label_configure(security_class_t cls,
> > +			    int flags,
> > +			    void *arg);
> > +
> 
> I'm not a big fan of these kinds of multiplexing configuration calls. 
> Again, if you have a labeling handle it would be simple for backends to 
> provide other configuration functions that simply take that handle, 
> eliminating this cumbersome interface.

OK, perhaps the void pointer can be removed from this call and instead,
backends can provide additional configuration functions.  It's a
tradeoff between the void pointer and more exported functions in the
library.

> 
> Karl
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
