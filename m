Message-ID: <4561CCD9.3050905@mentalrootkit.com>
Date: Mon, 20 Nov 2006 10:42:17 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: ewalsh@tycho.nsa.gov
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH 2/5] libselinux: labeling API basic front-end implementation
References: <1163643926.15225.55.camel@moss-huskies.epoch.ncsc.mil> <1163645472.15225.70.camel@moss-huskies.epoch.ncsc.mil>
In-Reply-To: <1163645472.15225.70.camel@moss-huskies.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> This is the front-end implementation.

<snip>

> +
> +/* callback pointers */
> +extern void *(*label_func_malloc) (size_t) hidden;
> +extern void (*label_func_free) (void *) hidden;
> +
> +extern int (*label_func_log) (int type, const char *, ...) hidden;
> +
> +extern int (*label_func_validate) (security_class_t cls, char **ctx) hidden;
> +
> +extern void *(*label_func_alloc_lock) (void) hidden;
> +extern void (*label_func_get_lock) (void *) hidden;
> +extern void (*label_func_release_lock) (void *) hidden;
> +extern void (*label_func_free_lock) (void *) hidden;
> +
> +static inline void set_callbacks(const struct label_memory_callback *mem_cb,
> +				 const struct label_log_callback *log_cb,
> +				 const struct label_action_callback *action_cb,
> +				 const struct label_lock_callback *lock_cb)
> +{
> +	if (mem_cb) {
> +		label_func_malloc = mem_cb->func_malloc;
> +		label_func_free = mem_cb->func_free;
> +	}
> +	if (log_cb) {
> +		label_func_log = log_cb->func_log;
> +	}
> +	if (action_cb) {
> +		label_func_validate = action_cb->func_validate;
> +	}
> +	if (lock_cb) {
> +		label_func_alloc_lock = lock_cb->func_alloc_lock;
> +		label_func_get_lock = lock_cb->func_get_lock;
> +		label_func_release_lock = lock_cb->func_release_lock;
> +		label_func_free_lock = lock_cb->func_free_lock;
> +	}
> +}

Why is this inline in a header? Why are those callbacks global?

I was expecting at least some of those callbacks to be per backend (like 
logging and validation) yet they are global. The init function implies 
that the callbacks are per "prefix", yet that doesn't seem to be the case.

> +
> +/* prefix size */
> +#define LABEL_PREFIX_SIZE 128
> +

Why cap the prefix size? The API certainly didn't indicate that prefix 
could only be 128 characters long.

> +/* user-supplied callback interface for avc */
> +static inline void *label_malloc(size_t size)
> +{
> +	return label_func_malloc ? label_func_malloc(size) : malloc(size);
> +}
> +

Why not just set the function pointers to the defaults when none are 
supplied so that you can avoid all of these inline functions (which 
increase the cost significantly by introducing a branch).

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
