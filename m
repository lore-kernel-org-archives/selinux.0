Message-ID: <1495208205.2209.10.camel@tycho.nsa.gov>
Subject: Re: [PATCH v2 7/9] semanage: Update semanage to allow runtime
 labeling of Infiniband Pkeys
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
Date: Fri, 19 May 2017 11:36:45 -0400
In-Reply-To: <1495146349-75366-8-git-send-email-danielj@mellanox.com>
References: <1495146349-75366-1-git-send-email-danielj@mellanox.com>
 <1495146349-75366-8-git-send-email-danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-19 at 01:25 +0300, Dan Jurgens wrote:
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
> v2:
> Jason Zaman:
> - Use set instead of sorted for valid_types.
> 
> Stephen Smalley:
> - Fix semanage when ibpkey_type attribute isn't defined.
> - Store subnet prefix in 8 bytes.
> - Removed a missed #if DARWIN
> - Use sizeof(struct in6_addr) vs a define.
> ---
>  libsemanage/include/semanage/ibpkey_record.h  |  74 +++++
>  libsemanage/include/semanage/ibpkeys_local.h  |  36 +++
>  libsemanage/include/semanage/ibpkeys_policy.h |  28 ++
>  libsemanage/include/semanage/semanage.h       |   3 +
>  libsemanage/src/direct_api.c                  |  29 +-
>  libsemanage/src/handle.h                      |  36 ++-
>  libsemanage/src/ibpkey_internal.h             |  52 +++
>  libsemanage/src/ibpkey_record.c               | 185 +++++++++++
>  libsemanage/src/ibpkeys_file.c                | 181 +++++++++++
>  libsemanage/src/ibpkeys_local.c               | 179 +++++++++++
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
>  libsepol/src/ibpkey_record.c                  | 445
> ++++++++++++++++++++++++++
>  libsepol/src/ibpkeys.c                        | 269 ++++++++++++++++
>  python/semanage/semanage                      |  60 +++-
>  python/semanage/seobject.py                   | 255 +++++++++++++++
>  27 files changed, 2131 insertions(+), 16 deletions(-)
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

> diff --git a/libsepol/src/ibpkey_record.c
> b/libsepol/src/ibpkey_record.c
> new file mode 100644
> index 00000000..c551f411
> --- /dev/null
> +++ b/libsepol/src/ibpkey_record.c
> @@ -0,0 +1,445 @@
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

Why not just struct in6_addr or even just uint64_t and only store the
first two words as in struct ocontext?  
 
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
> +	memcpy(subnet_prefix_bytes, in_addr.s6_addr, sizeof(struct
> in6_addr));

Then you can just use uint64_t or struct in6_addr throughout and don't
have to worry about code like this being called unsafely (e.g. with an
inadequately sized subnet_prefix_bytes).

> +
> +	return STATUS_SUCCESS;
> +}
> +
