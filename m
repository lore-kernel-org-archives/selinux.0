Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3P4upKh030686
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 00:56:51 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3P4uoEA014279
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 04:56:50 GMT
Subject: Re: [PATCH 02/33] libsepol: boolean serialization
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: jbrindle@tresys.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070423213722.080079000@tresys.com>
References: <20070423213455.741326000@tresys.com>
	 <20070423213722.080079000@tresys.com>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 00:56:49 -0400
Message-Id: <1177477009.3428.98.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-04-23 at 17:34 -0400, jbrindle@tresys.com wrote:

<snip>

> +
> +/* Serialize/Unserialize */
> +/** Destructively modifies data and size.
> + *  Caller must pre-allocate space for data.
> + *  Use sepol_bool_calculate_serialized_size(). */
> +int sepol_bool_serialize(sepol_handle_t * handle,
> +			 const sepol_bool_t * boolean,
> +			 char **data, uint64_t * size)
> +{
> +	int status = STATUS_SUCCESS;
> +	const char *name = NULL;
> +	int value;
> +
> +	/* Sundry sanity checks. */
> +	if (handle == NULL || boolean == NULL) {
> +		status = STATUS_ERR;
> +		goto cleanup;
> +	}
> +

Why not assert here?

> +	/* Boolean name. */
> +	name = sepol_bool_get_name(boolean);
> +	status =
> +	    sepol_serialize(handle, name, (name == NULL) ? 0 : strlen(name),
> +			    SEPOL_SERIAL_STRING, data, size);

Why doesn't the serialization function handle null strings?

> +	if (status != STATUS_SUCCESS)
> +		goto cleanup;
> +
> +	/* Value of boolean. */
> +	value = sepol_bool_get_value(boolean);
> +	status = sepol_serialize(handle, &value, 0, SEPOL_SERIAL_INT32_T, data, size);
> +	if (status != STATUS_SUCCESS)
> +		goto cleanup;
> +

I think that it would be nice to put a header on each of these
serialized chunks that identifies what the data represents (e.g.,
boolean, seuser, etc). You could add a version there. That would also
allow you to generically handle lists of objects and, in the future,
trees of these for the policy rep work.

> +	/* Cleanup. */
> +      cleanup:
> +	return status;

Why use this idiom when there is no cleanup?

> +}
> +
> +hidden_def(sepol_bool_serialize)
> +
> +/** Destructively modifies boolean, data and size.
> + *  Allocates space for boolean.
> + *  Caller must free. */
> +int sepol_bool_unserialize(sepol_handle_t * handle,
> +			   char **data, uint64_t * size,
> +			   sepol_bool_t ** boolean)
> +{
> +	int status = STATUS_SUCCESS;
> +	char *name = NULL;
> +	size_t *name_size = NULL;
> +	int *value = NULL;
> +
> +	/* Sundry sanity checks. */
> +	if (handle == NULL || data == NULL || *data == NULL || size == NULL) {
> +		status = STATUS_ERR;
> +		goto cleanup;
> +	}
> +
> +	/* Allocate space. */
> +	status = sepol_bool_create(handle, boolean);
> +	if (status != STATUS_SUCCESS)
> +		goto cleanup;
> +
> +	/* Boolean name. */
> +	status =
> +	    sepol_unserialize(handle,
> +			      data, size,
> +					(void **)&name, &name_size, SEPOL_SERIAL_STRING);

As James said - this isn't valid. Another reason to have the type safe
versions.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
