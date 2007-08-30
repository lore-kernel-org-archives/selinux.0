Subject: Re: use the OS functionality for reading
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ulrich Drepper <drepper@redhat.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46D495A1.20505@redhat.com>
References: <46D495A1.20505@redhat.com>
Content-Type: text/plain
Date: Thu, 30 Aug 2007 16:35:54 -0400
Message-Id: <1188506154.26572.378.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-28 at 14:37 -0700, Ulrich Drepper wrote:
> glibc provides for a long time functions to read and write to strings
> using the stream interfaces (i.e., using FILE).  These functions will
> also be in the next revision of the POSIX spec.
> 
> This functionality could replace the PF_USE_MEMORY use in libsepol.
> I've attached a patch to implement this.  It compiles but I haven't
> tested it.
> 
> The implementation could be a lot cleaner if some interfaces could be
> redesigned.  The PF_LEN mode shouldn't exist at all.  Just let the
> implementation care about the allocation (with open_memstream).  The
> sepol_policy_file_free should always free the FILE descriptor.  There
> should be an interface to request generating a string (the complement to
> sepol_policy_file_set_mem which is for reading).
> sepol_policy_file_get_len should go away.  All the places in libsepol
> itself which use struct policy_file should use functions instead of
> hardcoding the operations.
> 
> Anyway, the attached patch could be a first step to cleaning things up.

get_len is less of a concern, as it doesn't appear to be in use outside
the library.

The fact that set_mem can fail after this change and leave the fp NULL
seems more troubling, as a subsequent call may use that in a call to
next_entry and seg fault.

I'm not certain of the benefit of the change is for the input side; on
the output side, letting the implementation handle the allocation is
nice.

checkpolicy/checkmodule would need to be updated or they won't build
against the updated libsepol since they use the static libsepol and its
private headers.

The patch wasn't relative to your first one, so the private.h diff has
to be manually applied to services.c.

> plain text document attachment (d-libsepol-fmem)
> diff -durp libsepol-2.0.7/include/sepol/policydb/policydb.h libsepol-2.0.7-fmem/include/sepol/policydb/policydb.h
> --- libsepol-2.0.7/include/sepol/policydb/policydb.h	2007-08-23 13:52:46.000000000 -0700
> +++ libsepol-2.0.7-fmem/include/sepol/policydb/policydb.h	2007-08-28 14:11:56.000000000 -0700
> @@ -548,16 +548,13 @@ extern int symtab_insert(policydb_t * x,
>  /* A policy "file" may be a memory region referenced by a (data, len) pair
>     or a file referenced by a FILE pointer. */
>  typedef struct policy_file {
> -#define PF_USE_MEMORY  0
> -#define PF_USE_STDIO   1
> -#define PF_LEN         2	/* total up length in len field */
> +#define PF_USE_STDIO		0
> +#define PF_USE_STDIO_SYSALLOC	1
> +#define PF_LEN			2	/* total up length in len field */
>  	unsigned type;
> -	char *data;
>  	size_t len;
> -	size_t size;
>  	FILE *fp;
>  	struct sepol_handle *handle;
> -	unsigned char buffer[BUFSIZ];
>  } policy_file_t;
>  
>  struct sepol_policy_file {
> diff -durp libsepol-2.0.7/src/genbools.c libsepol-2.0.7-fmem/src/genbools.c
> --- libsepol-2.0.7/src/genbools.c	2007-08-23 13:52:46.000000000 -0700
> +++ libsepol-2.0.7-fmem/src/genbools.c	2007-08-28 12:04:40.000000000 -0700
> @@ -154,10 +154,15 @@ int sepol_genbools(void *data, size_t le
>  		goto err_destroy;
>  	}
>  
> -	pf.type = PF_USE_MEMORY;
> -	pf.data = data;
> -	pf.len = len;
> +	pf.type = PF_USE_STDIO;
> +	pf.fp = fmemopen(data, len, "r");
> +	if (pf.fp == NULL) {
> +		ERR(NULL, "error while preparing to write new binary policy image");
> +		errno = EINVAL;
> +		goto err_destroy;
> +	}
>  	rc = policydb_write(&policydb, &pf);
> +	fclose(pf.fp);
>  	if (rc) {
>  		ERR(NULL, "unable to write new binary policy image");
>  		errno = EINVAL;
> @@ -225,10 +230,15 @@ int sepol_genbools_array(void *data, siz
>  		goto err_destroy;
>  	}
>  
> -	pf.type = PF_USE_MEMORY;
> -	pf.data = data;
> -	pf.len = len;
> +	pf.type = PF_USE_STDIO;
> +	pf.fp = fmemopen(data, len, "r");
> +	if (pf.fp == NULL) {
> +		ERR(NULL, "error while preparing to write new binary policy image");
> +		errno = EINVAL;
> +		goto err_destroy;
> +	}
>  	rc = policydb_write(&policydb, &pf);
> +	fclose(pf.fp);
>  	if (rc) {
>  		ERR(NULL, "unable to write binary policy");
>  		errno = EINVAL;
> diff -durp libsepol-2.0.7/src/module.c libsepol-2.0.7-fmem/src/module.c
> --- libsepol-2.0.7/src/module.c	2007-08-23 13:52:45.000000000 -0700
> +++ libsepol-2.0.7-fmem/src/module.c	2007-08-28 14:33:19.000000000 -0700
> @@ -45,15 +45,6 @@ static int policy_file_seek(struct polic
>  			return -1;
>  		}
>  		return fseek(fp->fp, (long)offset, SEEK_SET);
> -	case PF_USE_MEMORY:
> -		if (offset > fp->size) {
> -			errno = EFAULT;
> -			return -1;
> -		}
> -		fp->data -= fp->size - fp->len;
> -		fp->data += offset;
> -		fp->len = fp->size - offset;
> -		return 0;
>  	default:
>  		return 0;
>  	}
> @@ -69,8 +60,6 @@ static size_t policy_file_length(struct 
>  		end_offset = ftell(fp->fp);
>  		fseek(fp->fp, prev_offset, SEEK_SET);
>  		return end_offset;
> -	case PF_USE_MEMORY:
> -		return fp->size;
>  	default:
>  		return 0;
>  	}
> @@ -835,7 +824,6 @@ int sepol_module_package_write(sepol_mod
>  	if (p->policy) {
>  		/* compute policy length */
>  		polfile.type = PF_LEN;
> -		polfile.data = NULL;
>  		polfile.len = 0;
>  		polfile.handle = file->handle;
>  		if (policydb_write(&p->policy->p, &polfile))
> diff -durp libsepol-2.0.7/src/policydb_convert.c libsepol-2.0.7-fmem/src/policydb_convert.c
> --- libsepol-2.0.7/src/policydb_convert.c	2007-08-23 13:52:45.000000000 -0700
> +++ libsepol-2.0.7-fmem/src/policydb_convert.c	2007-08-28 12:03:20.000000000 -0700
> @@ -13,12 +13,17 @@ int policydb_from_image(sepol_handle_t *
>  
>  	policy_file_t pf;
>  
> -	pf.type = PF_USE_MEMORY;
> -	pf.data = data;
> -	pf.len = len;
> +	pf.type = PF_USE_STDIO;
> +	pf.fp = fmemopen(data, len, "r");
> +	if (pf.fp == NULL) {
> +		ERR(handle, "cannot prepare reading policy image");
> +		return STATUS_ERR;
> +	}
>  	pf.handle = handle;
>  
> -	if (policydb_read(policydb, &pf, 0)) {
> +	int fail = policydb_read(policydb, &pf, 0);
> +	fclose(pf.fp);
> +	if (fail) {
>  		ERR(handle, "policy image is invalid");
>  		errno = EINVAL;
>  		return STATUS_ERR;
> @@ -33,51 +38,47 @@ int policydb_to_image(sepol_handle_t * h
>  		      policydb_t * policydb, void **newdata, size_t * newlen)
>  {
>  
> -	void *tmp_data = NULL;
> +	char *tmp_data = NULL;
>  	size_t tmp_len;
>  	policy_file_t pf;
>  	struct policydb tmp_policydb;
>  
> -	/* Compute the length for the new policy image. */
> -	pf.type = PF_LEN;
> -	pf.data = NULL;
> -	pf.len = 0;
> -	pf.handle = handle;
> -	if (policydb_write(policydb, &pf)) {
> -		ERR(handle, "could not compute policy length");
> -		errno = EINVAL;
> -		goto err;
> -	}
> -
> -	/* Allocate the new policy image. */
> -	pf.type = PF_USE_MEMORY;
> -	pf.data = malloc(pf.len);
> -	if (!pf.data) {
> -		ERR(handle, "out of memory");
> +	/* Generate new policy image.  */
> +	pf.type = PF_USE_STDIO;
> +	pf.fp = open_memstream(&tmp_data, &tmp_len);
> +	if (pf.fp == NULL) {
> +		ERR(handle, "cannot prepare generating new policy image");
>  		goto err;
>  	}
>  
> -	/* Need to save len and data prior to modification by policydb_write. */
> -	tmp_len = pf.len;
> -	tmp_data = pf.data;
> -
>  	/* Write out the new policy image. */
>  	if (policydb_write(policydb, &pf)) {
> +		fclose(pf.fp);
>  		ERR(handle, "could not write policy");
>  		errno = EINVAL;
>  		goto err;
>  	}
> +	if (fclose(pf.fp) == EOF) {
> +		ERR(handle, "could not write policy");
> +		goto err;
> +	}
>  
>  	/* Verify the new policy image. */
> -	pf.type = PF_USE_MEMORY;
> -	pf.data = tmp_data;
> -	pf.len = tmp_len;
> +	// pf.type = PF_USE_STDIO;		still set this way
> +	pf.fp = fmemopen(tmp_data, tmp_len, "r");
> +	if (pf.fp == NULL) {
> +		ERR(handle, "cannot prepare verifying policy");
> +		goto err;
> +	}
>  	if (policydb_init(&tmp_policydb)) {
> +		fclose(pf.fp);
>  		ERR(handle, "Out of memory");
>  		errno = ENOMEM;
>  		goto err;
>  	}
> -	if (policydb_read(&tmp_policydb, &pf, 0)) {
> +	int fail = policydb_read(&tmp_policydb, &pf, 0);
> +	fclose(pf.fp);
> +	if (fail) {
>  		ERR(handle, "new policy image is invalid");
>  		errno = EINVAL;
>  		goto err;
> diff -durp libsepol-2.0.7/src/policydb_public.c libsepol-2.0.7-fmem/src/policydb_public.c
> --- libsepol-2.0.7/src/policydb_public.c	2007-08-23 13:52:45.000000000 -0700
> +++ libsepol-2.0.7-fmem/src/policydb_public.c	2007-08-28 14:24:22.000000000 -0700
> @@ -22,10 +22,9 @@ void sepol_policy_file_set_mem(sepol_pol
>  		pf->type = PF_LEN;
>  		return;
>  	}
> -	pf->type = PF_USE_MEMORY;
> -	pf->data = data;
> -	pf->len = len;
> -	pf->size = len;
> +	pf->type = PF_USE_STDIO_SYSALLOC;
> +	pf->fp = fmemopen(data, len, "r");
> +	// XXX Cannot report error and cannot have descriptor freed
>  	return;
>  }
>  
> @@ -52,8 +51,11 @@ void sepol_policy_file_set_handle(sepol_
>  	pf->pf.handle = handle;
>  }
>  
> -void sepol_policy_file_free(sepol_policy_file_t * pf)
> +void sepol_policy_file_free(sepol_policy_file_t * spf)
>  {
> +	struct policy_file *pf = &spf->pf;
> +	if (pf->type == PF_USE_STDIO_SYSALLOC && pf->fp != NULL)
> +		fclose(pf->fp);
>  	free(pf);
>  }
>  
> diff -durp libsepol-2.0.7/src/private.h libsepol-2.0.7-fmem/src/private.h
> --- libsepol-2.0.7/src/private.h	2007-08-23 13:52:45.000000000 -0700
> +++ libsepol-2.0.7-fmem/src/private.h	2007-08-28 14:10:54.000000000 -0700
> @@ -43,25 +43,7 @@ extern struct policydb_compat_info *poli
>  /* Reading from a policy "file". */
>  static inline int next_entry(void *buf, struct policy_file *fp, size_t bytes)
>  {
> -	size_t nread;
> -
> -	switch (fp->type) {
> -	case PF_USE_STDIO:
> -		nread = fread(buf, bytes, 1, fp->fp);
> -		if (nread != 1)
> -			return -1;
> -		break;
> -	case PF_USE_MEMORY:
> -		if (bytes > fp->len)
> -			return -1;
> -		memcpy(buf, fp->data, bytes);
> -		fp->data += bytes;
> -		fp->len -= bytes;
> -		break;
> -	default:
> -		return -1;
> -	}
> -	return 0;
> +	return fread(buf, bytes, 1, fp->fp) != 1 ? -1 : 0;
>  }
>  
>  static inline size_t put_entry(const void *ptr, size_t size, size_t n,
> @@ -71,17 +53,8 @@ static inline size_t put_entry(const voi
>  
>  	switch (fp->type) {
>  	case PF_USE_STDIO:
> +	case PF_USE_STDIO_SYSALLOC:
>  		return fwrite(ptr, size, n, fp->fp);
> -	case PF_USE_MEMORY:
> -		if (bytes > fp->len) {
> -			errno = ENOSPC;
> -			return 0;
> -		}
> -
> -		memcpy(fp->data, ptr, bytes);
> -		fp->data += bytes;
> -		fp->len -= bytes;
> -		return n;
>  	case PF_LEN:
>  		fp->len += bytes;
>  		return n;
> diff -durp libsepol-2.0.7/src/services.c libsepol-2.0.7-fmem/src/services.c
> --- libsepol-2.0.7/src/services.c	2007-08-23 13:52:45.000000000 -0700
> +++ libsepol-2.0.7-fmem/src/services.c	2007-08-28 12:01:03.000000000 -0700
> @@ -952,16 +952,20 @@ int hidden sepol_load_policy(void *data,
>  	uint32_t seqno;
>  	int rc = 0;
>  	struct policy_file file = {
> -		.type = PF_USE_MEMORY,
> -		.data = data,
> -		.len = len,
> -		.fp = NULL
> -	}, *fp = &file;
> +		.type = PF_USE_STDIO,
> +		.fp = fmemopen(data, len, "r")
> +	};
> +	if (file.fp == NULL)
> +		return -errno;
>  
> -	if (policydb_init(&newpolicydb))
> +	if (policydb_init(&newpolicydb)) {
> +		fclose(file.fp);
>  		return -ENOMEM;
> +	}
>  
> -	if (policydb_read(&newpolicydb, fp, 1)) {
> +	int fail = policydb_read(&newpolicydb, &file, 1);
> +	fclose(file.fp);
> +	if (fail) {
>  		return -EINVAL;
>  	}
>  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
