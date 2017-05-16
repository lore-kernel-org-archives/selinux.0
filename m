Message-ID: <1494962051.21557.10.camel@tycho.nsa.gov>
Subject: Re: [PATCH v1 7/9] semanage: Update semanage to allow runtime
 labeling of Infiniband Pkeys
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
Date: Tue, 16 May 2017 15:14:11 -0400
In-Reply-To: <1494880961-73481-8-git-send-email-danielj@mellanox.com>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-8-git-send-email-danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-05-15 at 23:42 +0300, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Update libsepol and libsemanage to work with pkey records. Add local
> storage for new and modified pkey records in pkeys.local. Update
> semanage
> to parse the pkey command options to add, modify, and delete pkeys.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> 
> ---
> v1:
> Fixed semanage_pkey_exists -> semanage_ibpkey_exists in delete flow
> in
> seobject.py
> 
> Stephen Smalley:
> - Subnet prefix can't vary in size always 16 bytes, remove size
> field.
> - Removed extraneous change in libsepol/VERSION
> - Removed ifdef DARWIN s6_addr/32 blocks in favor of s6_addr.
> - Got rid of magic constant for subnet prefix size.
> 
> Jason Zaman:
> - Use SETools directly to query types in seobject.py.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> ---
>  libsemanage/include/semanage/ibpkey_record.h  |  76 +++++
>  libsemanage/include/semanage/ibpkeys_local.h  |  36 +++
>  libsemanage/include/semanage/ibpkeys_policy.h |  28 ++
>  libsemanage/include/semanage/semanage.h       |   3 +
>  libsemanage/src/direct_api.c                  |  29 +-
>  libsemanage/src/handle.h                      |  36 ++-
>  libsemanage/src/ibpkey_internal.h             |  52 +++
>  libsemanage/src/ibpkey_record.c               | 185 +++++++++++
>  libsemanage/src/ibpkeys_file.c                | 181 +++++++++++
>  libsemanage/src/ibpkeys_local.c               | 178 ++++++++++
>  libsemanage/src/ibpkeys_policy.c              |  52 +++
>  libsemanage/src/ibpkeys_policydb.c            |  62 ++++
>  libsemanage/src/libsemanage.map               |   1 +
>  libsemanage/src/policy_components.c           |   5 +-
>  libsemanage/src/semanage_store.c              |   1 +
>  libsemanage/src/semanage_store.h              |   1 +
>  libsemanage/src/semanageswig.i                |   3 +
>  libsemanage/src/semanageswig_python.i         |  43 +++
>  libsemanage/utils/semanage_migrate_store      |   3 +-
>  libsepol/include/sepol/ibpkey_record.h        |  77 +++++
>  libsepol/include/sepol/ibpkeys.h              |  44 +++
>  libsepol/include/sepol/sepol.h                |   2 +
>  libsepol/src/ibpkey_internal.h                |  21 ++
>  libsepol/src/ibpkey_record.c                  | 448
> ++++++++++++++++++++++++++
>  libsepol/src/ibpkeys.c                        | 263 +++++++++++++++
>  python/semanage/semanage                      |  60 +++-
>  python/semanage/seobject.py                   | 255 +++++++++++++++
>  27 files changed, 2129 insertions(+), 16 deletions(-)
>  create mode 100644 libsemanage/include/semanage/ibpkey_record.h
>  create mode 100644 libsemanage/include/semanage/ibpkeys_local.h
>  create mode 100644 libsemanage/include/semanage/ibpkeys_policy.h
>  create mode 100644 libsemanage/src/ibpkey_internal.h
>  create mode 100644 libsemanage/src/ibpkey_record.c
>  create mode 100644 libsemanage/src/ibpkeys_file.c
>  create mode 100644 libsemanage/src/ibpkeys_local.c
>  create mode 100644 libsemanage/src/ibpkeys_policy.c
>  create mode 100644 libsemanage/src/ibpkeys_policydb.c
>  create mode 100644 libsepol/include/sepol/ibpkey_record.h
>  create mode 100644 libsepol/include/sepol/ibpkeys.h
>  create mode 100644 libsepol/src/ibpkey_internal.h
>  create mode 100644 libsepol/src/ibpkey_record.c
>  create mode 100644 libsepol/src/ibpkeys.c
> 
> diff --git a/libsemanage/include/semanage/ibpkey_record.h
> b/libsemanage/include/semanage/ibpkey_record.h
> new file mode 100644
> index 0000000..d76aaae
> --- /dev/null
> +++ b/libsemanage/include/semanage/ibpkey_record.h
> @@ -0,0 +1,76 @@
> +/* Copyright (C) 2017 Mellanox Technologies Inc */
> +
> +#ifndef _SEMANAGE_IBPKEY_RECORD_H_
> +#define _SEMANAGE_IBPKEY_RECORD_H_
> +
> +#include <semanage/context_record.h>
> +#include <semanage/handle.h>
> +#include <stddef.h>
> +
> +#ifndef _SEMANAGE_IBPKEY_DEFINED_
> +struct semanage_ibpkey;
> +struct semanage_ibpkey_key;
> +typedef struct semanage_ibpkey semanage_ibpkey_t;
> +typedef struct semanage_ibpkey_key semanage_ibpkey_key_t;
> +#define _SEMANAGE_IBPKEY_DEFINED_
> +#endif
> +
> +#define INET6_ADDRLEN 16

We shouldn't expose this in a public header; it's an implementation
detail.  Likely could/should define it as sizeof(struct in6_addr) to
ensure consistency?

> diff --git a/libsepol/include/sepol/ibpkey_record.h
> b/libsepol/include/sepol/ibpkey_record.h
> new file mode 100644
> index 0000000..fff4591
> --- /dev/null
> +++ b/libsepol/include/sepol/ibpkey_record.h
> @@ -0,0 +1,77 @@
> +#ifndef _SEPOL_IBPKEY_RECORD_H_
> +#define _SEPOL_IBPKEY_RECORD_H_
> +
> +#include <stddef.h>
> +#include <sepol/context_record.h>
> +#include <sepol/handle.h>
> +#include <sys/cdefs.h>
> +
> +#define INET6_ADDRLEN 16

Ditto

> diff --git a/libsepol/src/ibpkey_record.c
> b/libsepol/src/ibpkey_record.c
> new file mode 100644
> index 0000000..4eed083
> --- /dev/null
> +++ b/libsepol/src/ibpkey_record.c
> @@ -0,0 +1,448 @@
> +#include <stdlib.h>
> +#include <string.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <errno.h>
> +#include <sepol/ibpkey_record.h>
> +
> +#include "ibpkey_internal.h"
> +#include "context_internal.h"
> +#include "debug.h"
> +
> +struct sepol_ibpkey {
> +	/* Subnet prefix */
> +	char *subnet_prefix;
> +
> +	/* Low - High range. Same for single ibpkeys. */
> +	int low, high;
> +
> +	/* Context */
> +	sepol_context_t *con;
> +};
> +
> +struct sepol_ibpkey_key {
> +	/* Subnet prefix */
> +	char *subnet_prefix;
> +
> +	/* Low - High range. Same for single ibpkeys. */
> +	int low, high;
> +};
> +
> +/* Converts a string represtation (subnet_prefix_str)
> + * to a numeric representation (subnet_prefix_bytes)
> + */
> +static int ibpkey_parse_subnet_prefix(sepol_handle_t *handle,
> +				      const char *subnet_prefix_str,
> +				      char *subnet_prefix_bytes)
> +{
> +	struct in6_addr in_addr;
> +
> +	if (inet_pton(AF_INET6, subnet_prefix_str, &in_addr) <= 0) {
> +		ERR(handle, "could not parse IPv6 address for ibpkey
> subnet prefix %s: %s",
> +		    subnet_prefix_str, strerror(errno));
> +		return STATUS_ERR;
> +	}
> +
> +	memcpy(subnet_prefix_bytes, in_addr.s6_addr, INET6_ADDRLEN);
> +
> +	return STATUS_SUCCESS;
> +}
> +
> +static int ibpkey_alloc_subnet_prefix(sepol_handle_t *handle,
> +				      char **subnet_prefix)
> +{
> +	char *tmp_subnet_prefix = malloc(INET6_ADDRLEN);
> +
> +	if (!tmp_subnet_prefix)
> +		goto omem;
> +
> +	*subnet_prefix = tmp_subnet_prefix;
> +	return STATUS_SUCCESS;
> +
> +omem:
> +	ERR(handle, "out of memory");
> +	return STATUS_ERR;
> +}
> +
> +/* Converts a numeric representation (subnet_prefix_bytes)
> + * to a string representation (subnet_prefix_str)
> + */
> +
> +static int ibpkey_expand_subnet_prefix(sepol_handle_t *handle,
> +				       char *subnet_prefix_bytes,
> +				       char *subnet_prefix_str)
> +{
> +	struct in6_addr addr;
> +
> +	memset(&addr, 0, sizeof(struct in6_addr));
> +#ifdef DARWIN
> +	memcpy(&addr.s6_addr[0], subnet_prefix_bytes, 16);
> +#else
> +	memcpy(&addr.s6_addr32[0], subnet_prefix_bytes, 16);
> +#endif

Another case where you can drop #ifdef DARWIN and just use s6_addr.
