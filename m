Subject: Re: [PATCH 2/2] libsepol: port str_read from kernel
To: william.c.roberts@intel.com, selinux@tycho.nsa.gov, jwcart2@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
References: <1471553689-14551-1-git-send-email-william.c.roberts@intel.com>
 <1471553689-14551-2-git-send-email-william.c.roberts@intel.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <566e5aed-5e18-db1a-eb20-dce5694b67fc@tycho.nsa.gov>
Date: Fri, 19 Aug 2016 09:13:19 -0400
MIME-Version: 1.0
In-Reply-To: <1471553689-14551-2-git-send-email-william.c.roberts@intel.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/18/2016 04:54 PM, william.c.roberts@intel.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
> 
> Rather than duplicating the following sequence:
> 1. Read len from file
> 2. alloc up space based on 1
> 3. read the contents into the buffer from 2
> 4. null terminate the buffer from 2
> 
> Use the str_read() function that is in the kernel, which
> collapses steps 2 and 4. This not only reduces redundant
> code, but also has the side-affect of providing a central
> check on zero_or_saturated lengths from step 1 when
> generating string values.
> 
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  libsepol/src/conditional.c |  9 +------
>  libsepol/src/module.c      | 66 ++++++++++++++++++++++------------------------
>  libsepol/src/policydb.c    | 10 +------
>  libsepol/src/private.h     |  1 +
>  libsepol/src/services.c    | 33 +++++++++++++++++++++++
>  5 files changed, 68 insertions(+), 51 deletions(-)
> 
> diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> index 8680eb2..e1bc961 100644
> --- a/libsepol/src/conditional.c
> +++ b/libsepol/src/conditional.c
> @@ -589,15 +589,8 @@ int cond_read_bool(policydb_t * p,
>  		goto err;
>  
>  	len = le32_to_cpu(buf[2]);
> -	if (zero_or_saturated(len))
> +	if (str_read(&key, fp, len))
>  		goto err;
> -	key = malloc(len + 1);
> -	if (!key)
> -		goto err;
> -	rc = next_entry(key, fp, len);
> -	if (rc < 0)
> -		goto err;
> -	key[len] = 0;
>  
>  	if (p->policy_type != POLICY_KERN &&
>  	    p->policyvers >= MOD_POLICYDB_VERSION_TUNABLE_SEP) {
> diff --git a/libsepol/src/module.c b/libsepol/src/module.c
> index f25df95..a9d7c54 100644
> --- a/libsepol/src/module.c
> +++ b/libsepol/src/module.c
> @@ -793,26 +793,26 @@ int sepol_module_package_info(struct sepol_policy_file *spf, int *type,
>  				    i);
>  				goto cleanup;
>  			}
> +
>  			len = le32_to_cpu(buf[0]);
> -			if (zero_or_saturated(len)) {
> -				ERR(file->handle,
> -				    "invalid module name length: 0x%"PRIx32,
> -				    len);
> -				goto cleanup;
> -			}
> -			*name = malloc(len + 1);
> -			if (!*name) {
> -				ERR(file->handle, "out of memory");
> -				goto cleanup;
> -			}
> -			rc = next_entry(*name, file, len);
> -			if (rc < 0) {
> -				ERR(file->handle,
> -				    "cannot get module name string (at section %u)",
> -				    i);
> +			if (str_read(name, file, len)) {
> +				switch(rc) {
> +				case EINVAL:
> +					ERR(file->handle,
> +						"invalid module name length: 0x%"PRIx32,
> +						len);
> +					break;
> +				case ENOMEM:
> +					ERR(file->handle, "out of memory");
> +					break;
> +				default:
> +					ERR(file->handle,
> +						"cannot get module name string (at section %u)",
> +						i);
> +				}

1) You didn't set rc = str_read(), so you can't switch on it above.
2) Using positive values for errors is likely to confuse matters when
interacting with the existing code, which always uses negative values
(either -errno as a legacy of common code with the kernel or -1).
3) I think this overcomplicates the error handling / reporting.  If
str_read() were to set errno and return -1 instead, then you could just
include strerror(errno) in a single error message.  Or you can just
always report the most general error message.  But it isn't worth a
switch statement.

Same applies throughout.

>  				goto cleanup;
>  			}
> -			(*name)[len] = '\0';
> +
>  			rc = next_entry(buf, file, sizeof(uint32_t));
>  			if (rc < 0) {
>  				ERR(file->handle,
> @@ -821,25 +821,23 @@ int sepol_module_package_info(struct sepol_policy_file *spf, int *type,
>  				goto cleanup;
>  			}
>  			len = le32_to_cpu(buf[0]);
> -			if (zero_or_saturated(len)) {
> -				ERR(file->handle,
> -				    "invalid module version length: 0x%"PRIx32,
> -				    len);
> -				goto cleanup;
> -			}
> -			*version = malloc(len + 1);
> -			if (!*version) {
> -				ERR(file->handle, "out of memory");
> -				goto cleanup;
> -			}
> -			rc = next_entry(*version, file, len);
> -			if (rc < 0) {
> -				ERR(file->handle,
> -				    "cannot get module version string (at section %u)",
> -				    i);
> +			if (str_read(version, file, len)) {
> +				switch(rc) {
> +				case EINVAL:
> +					ERR(file->handle,
> +						"invalid module name length: 0x%"PRIx32,
> +						len);
> +					break;
> +				case ENOMEM:
> +					ERR(file->handle, "out of memory");
> +					break;
> +				default:
> +					ERR(file->handle,
> +						"cannot get module version string (at section %u)",
> +						i);
> +				}
>  				goto cleanup;
>  			}
> -			(*version)[len] = '\0';
>  			seen |= SEEN_MOD;
>  			break;
>  		default:
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index 5f888d3..cdb3cde 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1911,19 +1911,11 @@ static int perm_read(policydb_t * p
>  		goto bad;
>  
>  	len = le32_to_cpu(buf[0]);
> -	if (zero_or_saturated(len))
> +	if(str_read(&key, fp, len))
>  		goto bad;
>  
>  	perdatum->s.value = le32_to_cpu(buf[1]);
>  
> -	key = malloc(len + 1);
> -	if (!key)
> -		goto bad;
> -	rc = next_entry(key, fp, len);
> -	if (rc < 0)
> -		goto bad;
> -	key[len] = 0;
> -
>  	if (hashtab_insert(h, key, perdatum))
>  		goto bad;
>  
> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> index 0beb4d4..b884c23 100644
> --- a/libsepol/src/private.h
> +++ b/libsepol/src/private.h
> @@ -65,3 +65,4 @@ extern struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
>  extern int next_entry(void *buf, struct policy_file *fp, size_t bytes) hidden;
>  extern size_t put_entry(const void *ptr, size_t size, size_t n,
>  		        struct policy_file *fp) hidden;
> +extern int str_read(char **strp, struct policy_file *fp, size_t len) hidden;
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index d2b80b4..f61f692 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1679,6 +1679,39 @@ size_t hidden put_entry(const void *ptr, size_t size, size_t n,
>  }
>  
>  /*
> + * Reads a string and null terminates it from the policy file.
> + * This is a port of str_read from the SE Linux kernel code.
> + *
> + * It returns:
> + *   0 - Success
> + *   EINVAL - len is no good
> + *   ENOMEM - allocation failed
> + *   or any error possible from next_entry().
> + */
> +int hidden str_read(char **strp, struct policy_file *fp, size_t len)
> +{
> +	int rc;
> +	char *str;
> +
> +	if (zero_or_saturated(len))
> +		return EINVAL;
> +
> +	str = malloc(len + 1);
> +	if (!str)
> +		return ENOMEM;
> +
> +	/* it's expected the caller should free the str */
> +	*strp = str;
> +
> +	rc = next_entry(str, fp, len);
> +	if (rc)
> +		return rc;
> +
> +	str[len] = '\0';
> +	return 0;
> +}
> +
> +/*
>   * Read a new set of configuration data from 
>   * a policy database binary representation file.
>   *
> 
