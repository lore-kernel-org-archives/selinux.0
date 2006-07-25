Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6PFsc5u024779
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 11:54:38 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6PFsaPS006311
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 15:54:38 GMT
Subject: Re: [PATCH] Export sepol handle
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, sds@epoch.ncsc.mil
In-Reply-To: <1153839254.19259.13.camel@twoface>
References: <1153839254.19259.13.camel@twoface>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 11:54:33 -0400
Message-Id: <1153842873.12141.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-07-25 at 10:54 -0400, Joshua Brindle wrote:

<snip>

>  struct sepol_handle;
>  typedef struct sepol_handle sepol_handle_t;
> +typedef void (*sepol_handle_callback_fn_t) (void* varg, sepol_handle_t* handle, const char* fmt, ...);
>  

I'm confused about the first argument - it is just a blob of data passed
to the callback, correct? Why is it called varg (which implies variable
argument list to me)? And why is it passed when it is stored in the
handle which is also passed? Why not just export a function to grab it
from the handle?

>  /* Create and return a sepol handle. */
> -sepol_handle_t *sepol_handle_create(void);
> +extern sepol_handle_t *sepol_handle_create(void);
> +
> +/* Set the callback for a sepol handle */
> +extern void sepol_handle_set_callback(sepol_handle_t *h, sepol_handle_callback_fn_t fn, void *varg);
> +

See a above.

> +/* Call the callback for a sepol handle */
> +extern void sepol_handle_do_callback(sepol_handle_t* handle, const char* fmt, ...);
> +

This is meant to replace ERR, INFO, etc. for external users of the
library? Calling it do_callback is odd - it is forcing the user to think
about and know about how the error system works.

Why not:

sepol_report_err(sepol_handle_t *handle, const char* fmt, ...);

With one for info and warn, or a single function that takes a level and
some defines.

Also, the pointer goes with the variable name and not the type (this is
C not C++) - e.g., sepol_handle_t *handle not sepol_handle_t* handle.

> +/* Get the severity level of the last message */
> +extern int sepol_handle_get_level(sepol_handle_t *h);
>  

The severity should be passed with the message to the callback - this
interface cannot be used reliably with a threaded app. Even if the error
reporting system is not re-entrant (which it probably isn't) this
interface is harder to use and prevents future threading changes.

This means that the level should probably be removed from the handle as
well.

>  /* Destroy a sepol handle. */
> -void sepol_handle_destroy(sepol_handle_t *);
> +extern void sepol_handle_destroy(sepol_handle_t *);
> +
>  

Variable names?

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
