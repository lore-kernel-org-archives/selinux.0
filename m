Message-ID: <4576FABA.3090206@mentalrootkit.com>
Date: Wed, 06 Dec 2006 12:15:38 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: ewalsh@tycho.nsa.gov
CC: selinux@tycho.nsa.gov, James Athey <jathey@tresys.com>
Subject: Re: [PATCH 1/5] libselinux: labeling API basic front-end interface
References: <1164858471.2794.192.camel@moss-huskies.epoch.ncsc.mil> <1164859529.2794.201.camel@moss-huskies.epoch.ncsc.mil>
In-Reply-To: <1164859529.2794.201.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> This is the basic front-end interface.  I will shortly post some
> examples of how it would be used, including a patch for setfiles.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> 
> ---
>  libselinux/include/selinux/label.h         |  165 +++++++++++++
>  libselinux/include/selinux/label_backend.h |   20 +
>  2 files changed, 185 insertions(+)
> 
> 

General comments:

Don't these functions and types need a better prefix (selinux_*)? Well - 
I don't quite understand the current prefixing, but we need to decide on 
something moving forward.

What is your plan for maintaining the old interfaces?

Have you seen the FCGlob suggestions from James Athey? How would that 
fit in with that work (if it is actually needed) and is this the right 
time to introduce the FCGlob syntax?

> 
> 
> ------------------------------------------------------------------------
> 
> Index: libselinux/include/selinux/label.h
> ===================================================================
> --- libselinux/include/selinux/label.h	(revision 0)
> +++ libselinux/include/selinux/label.h	(revision 0)
> @@ -0,0 +1,165 @@
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
> + * @mem_callbacks: user-supplied memory callbacks
> + * @log_callbacks: user-supplied logging callbacks
> + * @action_callbacks: user-supplied validation callbacks
> + * @lock_callbacks: user-supplied locking callbacks
> + *
> + * Initialize the labeling subsystem.  Return %0 on success or -%1 with @errno
> + * set on failure.  If any callback structure references are NULL, use default
> + * methods for those callbacks (see the definition of the callback structures
> + * above).
> + */
> +	int label_init(const struct label_memory_callback *mem_callbacks,
> +		       const struct label_log_callback *log_callbacks,
> +		       const struct label_action_callback *action_callbacks,
> +		       const struct label_lock_callback *lock_callbacks);
> +

I'm still not convinced about these.

1) libselinux does lots of allocations with plain malloc - why are these 
special and need client control over how they are done?

2) For locking - why can't we just mark which functions for each handle 
are re-entrant and which are not? That way the caller can protect them 
with whatever locks are needed (including reader / writer locks if we 
mark them correctly). There are other parts of this library that are 
already sort-of this way (fscontext setting for example) and it seems 
simpler.

3) The logging and action callbacks seem - potentially - handle 
specific. Is global for the library really the right answer?

2) If the memory and locking callbacks are truly needed, then should 
they be library wide (for both the avc and the labeling). It seems 
unlikely that those are going to be need to be different. The existing 
avc symbols can be preserved, but new global ones introduced as well.

> +/**
> + * label_open - Create a labeling handle.
> + * @name: used by the backend for selecting a configuration or package
> + * @cls: specifies the backend to open
> + * @flags: global and/or backend-specific configuration flags
> + * @arg: additional backend-specific configuration data if not NULL
> + *
> + * Open a labeling backend for use.  The backend is identified by the specified
> + * object class in conjunction with the name argument, which is typically used
> + * to select a certain data source or subset, such as a specific package.
> + * Return value is the created handle on success or NULL with @errno set on
> + * failure.  See the backend documentation for additional flags and arg value.
> + */
> +	typedef struct label_rec *label_handle_t;
> +	label_handle_t label_open(const char *name, security_class_t cls,
> +				  int flags, void *arg);
> +

I'm still confused about name and cls and how they relate. Is it likely 
that most object managers are going to get labeling decisions for a 
single object class? Your setfiles example passes in SECCLASS_FILE for 
the class, but setfiles receives answers for dirs, link files, etc. in 
addition to plain files. Is the example wrong or is just one class 
chosen arbitrarily to represent the backend? What if I want to label 
file objects differently than file contexts for a specific object manager?

What happens if I pass in the same name for a different object class? Is 
a different file opened? How does name get mapped to different files? 
Will that require library changes?

This all - to me - goes right to the heart of Josh's criticism. How can 
this mechanism be extended without making changes to the library? To me, 
mixing up choosing which database to open (or file contexts file) with 
the mechanism for matching is just going to cause problems in the 
future. It seems simpler to pass in a fd or buffer with the data and 
tell the library what format that data is in. Then all of this name / 
cls choosing stuff can just go away, right?

If we are going to allow backends to have additional configuration 
functions taking the handles, is the void *arg needed?

I'm going to leave off comments about the implementation until we reach 
some resolution about the above.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
