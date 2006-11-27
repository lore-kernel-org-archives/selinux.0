Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kARMi3vd015278
	for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2006 17:44:03 -0500
Subject: Re: [PATCH 2/5] libselinux: labeling API basic front-end
	implementation
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4561CCD9.3050905@mentalrootkit.com>
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil>
	 <1163645472.15225.70.camel@moss-huskies.epoch.ncsc.mil>
	 <4561CCD9.3050905@mentalrootkit.com>
Content-Type: text/plain
Date: Mon, 27 Nov 2006 17:44:01 -0500
Message-Id: <1164667441.2794.88.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-11-20 at 10:42 -0500, Karl MacMillan wrote:
> Eamon Walsh wrote:
> > This is the front-end implementation.
> 
> <snip>
> 
> > +
> > +/* callback pointers */
> > +extern void *(*label_func_malloc) (size_t) hidden;
> > +extern void (*label_func_free) (void *) hidden;
> > +
> > +extern int (*label_func_log) (int type, const char *, ...) hidden;
> > +
> > +extern int (*label_func_validate) (security_class_t cls, char **ctx) hidden;
> > +
> > +extern void *(*label_func_alloc_lock) (void) hidden;
> > +extern void (*label_func_get_lock) (void *) hidden;
> > +extern void (*label_func_release_lock) (void *) hidden;
> > +extern void (*label_func_free_lock) (void *) hidden;
> > +
> > +static inline void set_callbacks(const struct label_memory_callback *mem_cb,
> > +				 const struct label_log_callback *log_cb,
> > +				 const struct label_action_callback *action_cb,
> > +				 const struct label_lock_callback *lock_cb)
> > +{
> > +	if (mem_cb) {
> > +		label_func_malloc = mem_cb->func_malloc;
> > +		label_func_free = mem_cb->func_free;
> > +	}
> > +	if (log_cb) {
> > +		label_func_log = log_cb->func_log;
> > +	}
> > +	if (action_cb) {
> > +		label_func_validate = action_cb->func_validate;
> > +	}
> > +	if (lock_cb) {
> > +		label_func_alloc_lock = lock_cb->func_alloc_lock;
> > +		label_func_get_lock = lock_cb->func_get_lock;
> > +		label_func_release_lock = lock_cb->func_release_lock;
> > +		label_func_free_lock = lock_cb->func_free_lock;
> > +	}
> > +}
> 
> Why is this inline in a header? Why are those callbacks global?

The callbacks are global so the backends can call them.  The inline can
be moved; will fix.

> 
> I was expecting at least some of those callbacks to be per backend (like 
> logging and validation) yet they are global. The init function implies 
> that the callbacks are per "prefix", yet that doesn't seem to be the case.

The callbacks are global.  The prefix passed to label_init() is just
there to set the initial value to something.  It doesn't select a
backend at that point, in fact label_init() should only be called once.
I will fix the comments to try and clear this up.

The logging callback is just used to print an opaque message out, so it
doesn't need to be global in its current form (the interaction between
SELinux and the audit subsystem hasn't been clearly worked out yet).  

The validation callback has the object class passed to it so it can take
different actions based on that.  For completeness, perhaps it should
take the prefix string as well.

> 
> > +
> > +/* prefix size */
> > +#define LABEL_PREFIX_SIZE 128
> > +
> 
> Why cap the prefix size? The API certainly didn't indicate that prefix 
> could only be 128 characters long.

Sorry, hold-over from the userspace AVC's prefix string, which is
limited to 15 chars or so because it goes at the front of the AVC
messages.

I can either inform the user of the limit or remove the limit, which
would require several more memory allocations since the string is copied
into internal structures.  I don't particularly have a preference.

> 
> > +/* user-supplied callback interface for avc */
> > +static inline void *label_malloc(size_t size)
> > +{
> > +	return label_func_malloc ? label_func_malloc(size) : malloc(size);
> > +}
> > +
> 
> Why not just set the function pointers to the defaults when none are 
> supplied so that you can avoid all of these inline functions (which 
> increase the cost significantly by introducing a branch).

Will fix.

> 
> Karl
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
