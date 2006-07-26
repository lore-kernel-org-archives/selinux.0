Subject: Re: [PATCH RETRY 1/3] export sepol handle
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
In-Reply-To: <1153937500.5393.5.camel@twoface>
References: <1153937500.5393.5.camel@twoface>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 15:29:12 -0400
Message-Id: <1153942152.11769.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-07-26 at 14:11 -0400, Joshua Brindle wrote:
> Attached is a patch to export the error reporting handle in libsepol.
> The setools team needs this so that we can create, destroy, set the
> callback, and invoke the error reporting from outside libsepol.  This
> will allow us to better propagate the errors into our analysis
> libraries. This has the earlier suggestions incorporated and should be
> applied to trunk.

> diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/src/handle.c branch/setools_public-policydb-components/libsepol/src/handle.c
> --- trunk/libsepol/src/handle.c	2006-07-13 10:19:21.000000000 -0400
> +++ branch/setools_public-policydb-components/libsepol/src/handle.c	2006-07-26 12:08:30.000000000 -0400
> @@ -16,7 +18,42 @@ sepol_handle_t *sepol_handle_create(void
>  	return sh;
>  }
>  
> -void sepol_handle_destroy(sepol_handle_t * sh)
> +void sepol_handle_set_callback(sepol_handle_t *h, sepol_handle_callback_fn_t fn, void *varg)
>  {
> +	if (h == NULL)
> +		return;
> +
> +	h->msg_callback = fn;
> +	h->msg_callback_arg = varg;
> +}

This looks like sepol_msg_set_callback, which is what libsemanage
already uses.  Am I missing something?

> +void sepol_handle_do_callback(sepol_handle_t* handle, const char* fmt, ...)
> +{
> +	char *tmp = NULL;
> +	va_list ap;
> +
> +	if (handle == NULL)
> +		return;
> +
> +	va_start(ap, fmt);
> +	vasprintf(&tmp, fmt, ap);
> +	va_end(ap);
> +
> +	ERR(handle, "%s", tmp);
> +	free(tmp);
> +}

I don't quite understand the intended usage.  If I am generating an
error message from outside the library, why would I call into the
library and then have it call into the callback I provided in the first
place?  What's the point?

> +int sepol_handle_get_level(sepol_handle_t *h)
> +{
> +	if (h == NULL) {
> +		errno = EINVAL;
> +		return -1;
> +	}
> +
> +	return h->msg_level;
> +}

This looks like sepol_msg_get_level().

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
