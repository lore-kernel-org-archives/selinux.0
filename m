Message-ID: <4561CB69.3040409@mentalrootkit.com>
Date: Mon, 20 Nov 2006 10:36:09 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: ewalsh@tycho.nsa.gov
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 1/5] libselinux: labeling API basic front-end interface
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil> <1163645170.15225.66.camel@moss-huskies.epoch.ncsc.mil>
In-Reply-To: <1163645170.15225.66.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> This is the basic front-end interface.  Note that backends may supply
> additional values and flags, which will be seen with the file_contexts
> backend.
> 

General comment - I think that providing this infrastructure is a good 
idea and the basic approach is sane.

> ---
>  include/selinux/label.h         |  181 ++++++++++++++++++++++++
>  include/selinux/label_backend.h |   20 ++
>  2 files changed, 201 insertions(+)
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> Index: include/selinux/label.h
> ===================================================================
> --- include/selinux/label.h	(revision 0)
> +++ include/selinux/label.h	(revision 0)
> @@ -0,0 +1,181 @@
> +/*
> + * Labeling interface for userspace object managers and others.
> + *
> + * Author : Eamon Walsh <ewalsh@tycho.nsa.gov>
> + */
> +#ifndef _SELINUX_LABEL_H_
> +#define _SELINUX_LABEL_H_
> +
> +#include <sys/types.h>
> +#include <selinux/selinux.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * User-provided callbacks for memory, logging, locking, and extra actions
> + */
> +
> +/* These structures are passed by reference to label_init().  Passing
> + * a NULL reference will cause a default to be used.  The default
> + * memory callbacks are malloc() and free().  The default logging method
> + * is to print on stderr.  The default validation callback is based on
> + * selinux_check_context().  If no locking callbacks are passed, no locking
> + * will take place.
> + */
> +	struct label_memory_callback {
> +		/* malloc() equivalent. */
> +		void *(*func_malloc) (size_t size);
> +		/* free() equivalent. */
> +		void (*func_free) (void *ptr);
> +		/* Note that these functions should set errno on failure.
> +		   If not, some routines may return -1 without errno set. */
> +	};
> +

Do you have an example of when this flexibility would be needed?

> +	struct label_log_callback {
> +		/* log the printf-style format and arguments,
> +		   with the type code indicating the type of message */
> +		int (*func_log) (int type, const char *fmt, ...);
> +	};
> +
> +	struct label_action_callback {
> +		/* validate the supplied context, making changes if necessary,
> +		   returning 0 if valid or -1 with errno set otherwise. */
> +		int (*func_validate) (security_class_t cls, char **context);
> +	};
> +
> +	struct label_lock_callback {
> +		/* create a lock and return an opaque pointer to it. */
> +		void *(*func_alloc_lock) (void);
> +		/* obtain a given lock, blocking if necessary. */
> +		void (*func_get_lock) (void *lock);
> +		/* release a given lock. */
> +		void (*func_release_lock) (void *lock);
> +		/* destroy a given lock (free memory, etc.) */
> +		void (*func_free_lock) (void *lock);
> +	};
> +

I would prefer to let clients to do locking by providing clear 
guarantees on the threading properties of the functions. Any reasons why 
this would be required.

Additionally, if we take this callback approach can we combine this with 
the related userspace AVC callbacks? Would a single client need to 
provide different callbacks for locking and memory between the labeling 
and AVC interfaces?

> +/* Logging type codes, passed to the logging callback */
> +#define LABEL_ERROR		0
> +#define LABEL_WARNING		1
> +#define LABEL_INFO		2
> +#define LABEL_INVALIDCON	3
> +
> +/*
> + * Label operations
> + */
> +
> +/**
> + * label_init - Initialize the labeling system.
> + * @prefix: used by the backend for selecting a configuration or package
> + * @mem_callbacks: user-supplied memory callbacks
> + * @log_callbacks: user-supplied logging callbacks
> + * @action_callbacks: user-supplied validation callbacks
> + * @lock_callbacks: user-supplied locking callbacks
> + *
> + * Initialize the labeling subsystem.  Return %0 on success or -%1 with @errno
> + * set on failure.  Argument @name must not be NULL or empty.  If any callback 
> + * structure references are NULL, use default methods for those callbacks (see
> + * the definition of the callback structures above).
> + */
> +	int label_init(const char *prefix,
> +		       const struct label_memory_callback *mem_callbacks,
> +		       const struct label_log_callback *log_callbacks,
> +		       const struct label_action_callback *action_callbacks,
> +		       const struct label_lock_callback *lock_callbacks);
> +

First - my biggest confusion here is how the backend, prefix, and label 
action callbacks all relate. To me - this is not immediately clear so at 
least some documentation is needed. I think, however, that it might be a 
sign that the API needs some work. Can you give some more explanation. 
Also, a little code showing how a client would use this API would also 
be helpful.

Second - I question the storage of "subsystems" (not certain if that is 
the correct term) in a global array in the library. Why not return a 
handle that is managed by the client? That could also be used to make 
the locking semantics clearer and allow client locking.

> +/**
> + * label_change_name - Change system prefix
> + * @prefix: used by the backend for selecting a configuration or package
> + *
> + * Change the prefix string used by the labeling system on future calls.  This
> + * function may be called multiple times.  Backend configurations are kept
> + * separately by prefix, meaning that after a call to this function, calls to
> + * label_configure() may be necessary to re-initialize backends.  However, 
> + * switching back to a prefix will preserve any configuration made previously
> + * while that prefix was in effect.
> + */
> +	void label_change_name(const char *prefix);
> +

This just becomes more confusing to me - the comment says that prefixes 
are "used by the backend" and then says "Backend configurations are kept 
separately by prefix". OK - do prefixes refer to backends or are they 
used by backends?

> +/**
> + * label_configure - Configure specific labeling backend.
> + * @cls: specifies the backend to configure
> + * @flags: global and/or backend-specific configuration flags
> + * @arg: additional backend-specific configuration data
> + *
> + * Configure a specific labeling backend.  This function should be called
> + * after a successful call to label_init and is optional; it will be called
> + * automatically with default arguments by label_lookup if necessary.  The
> + * result of the call depends on the specific flags and the backend, although
> + * typically the backend will reset its internal state.  Return %0 on success
> + * or -%1 with @errno set on failure.  
> + */
> +	int label_configure(security_class_t cls,
> +			    int flags,
> +			    void *arg);
> +

I'm not a big fan of these kinds of multiplexing configuration calls. 
Again, if you have a labeling handle it would be simple for backends to 
provide other configuration functions that simply take that handle, 
eliminating this cumbersome interface.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
