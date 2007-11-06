Message-ID: <4730D9A6.6050306@manicmethod.com>
Date: Tue, 06 Nov 2007 16:16:22 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: introduce enforcing mode override option
References: <471F8F8D.3040606@tycho.nsa.gov> <1193935864.12018.107.camel@moss-spartans.epoch.ncsc.mil> <472F79D5.6020903@tycho.nsa.gov>
In-Reply-To: <472F79D5.6020903@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eamon Walsh wrote:
> Introduces an enforcing mode override option, so the object manager
> can bring up the AVC in permissive mode on an enforcing system, or
> vice versa.
>

This is probably more useful but we actually had something like this 
with the userspace security server where you could run the USS in 
permissive or enforcing independent of the kernel security server. 
Ofcourse this would mean its still a global setting across all access 
managers using the USS.

> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
>
> include/selinux/avc.h |   11 ++++++++++-
> src/avc.c             |   29 ++++++++++++++++++++---------
> src/avc_internal.c    |    7 +++++--
> src/avc_internal.h    |    1 +
> 4 files changed, 36 insertions(+), 12 deletions(-)
>
>
> Index: libselinux/include/selinux/avc.h
> ===================================================================
> --- libselinux/include/selinux/avc.h    (revision 2671)
> +++ libselinux/include/selinux/avc.h    (working copy)
> @@ -157,6 +157,15 @@
> };
>
> /*
> + * Available options
> + */
> +
> +/* no-op option, useful for unused slots in an array of options */
> +#define AVC_OPT_UNUSED        0
> +/* override kernel enforcing mode (boolean value) */
> +#define AVC_OPT_SETENFORCE    1
> +
> +/*
>  * AVC operations
>  */
>
> @@ -188,7 +197,7 @@
>  *
>  * This function is identical to avc_init(), except the message prefix
>  * is set to "avc" and any callbacks desired should be specified via
> - * selinux_set_callback().  No options are currently supported.
> + * selinux_set_callback().  Available options are listed above.
>  */
> int avc_open(struct selinux_opt *opts, unsigned nopts);
>
> Index: libselinux/src/avc.c
> ===================================================================
> --- libselinux/src/avc.c    (revision 2671)
> +++ libselinux/src/avc.c    (working copy)
> @@ -157,10 +157,19 @@
>     return rc;
> }
>
> -int avc_open(struct selinux_opt *opts __attribute__((unused)),
> -         unsigned nopts __attribute__((unused)))
> +int avc_open(struct selinux_opt *opts, unsigned nopts)
> {
> -    return avc_init("avc", NULL, NULL, NULL, NULL);
> +    avc_setenforce = 0;
> +
> +    while (nopts--)
> +        switch(opts[nopts].type) {
> +        case AVC_OPT_SETENFORCE:
> +            avc_setenforce = 1;
> +            avc_enforcing = !!opts[nopts].value;
> +            break;
> +        }
> +
> +    return avc_init("avc", NULL, NULL, NULL, NULL);
> }
>
> int avc_init(const char *prefix,
> @@ -213,13 +222,15 @@
>         avc_node_freelist = new;
>     }
>
> -    rc = security_getenforce();
> -    if (rc < 0) {
> -        avc_log("%s:  could not determine enforcing mode\n",
> -            avc_prefix);
> -        goto out;
> +    if (!avc_setenforce) {
> +        rc = security_getenforce();
> +        if (rc < 0) {
> +            avc_log("%s:  could not determine enforcing mode\n",
> +                avc_prefix);
> +            goto out;
> +        }
> +        avc_enforcing = rc;
>     }
> -    avc_enforcing = rc;
>
>     rc = avc_netlink_open(avc_using_threads);
>     if (rc < 0) {
> Index: libselinux/src/avc_internal.h
> ===================================================================
> --- libselinux/src/avc_internal.h    (revision 2671)
> +++ libselinux/src/avc_internal.h    (working copy)
> @@ -74,6 +74,7 @@
> extern char avc_prefix[AVC_PREFIX_SIZE] hidden;
> extern int avc_running hidden;
> extern int avc_enforcing hidden;
> +extern int avc_setenforce hidden;
>
> /* user-supplied callback interface for avc */
> static inline void *avc_malloc(size_t size)
> Index: libselinux/src/avc_internal.c
> ===================================================================
> --- libselinux/src/avc_internal.c    (revision 2671)
> +++ libselinux/src/avc_internal.c    (working copy)
> @@ -46,6 +46,7 @@
> char avc_prefix[AVC_PREFIX_SIZE] = "uavc";
> int avc_running = 0;
> int avc_enforcing = 1;
> +int avc_setenforce = 0;
> int avc_netlink_trouble = 0;
>
> /* netlink socket code */
> @@ -151,6 +152,8 @@
>         struct selnl_msg_setenforce *msg = NLMSG_DATA(nlh);
>         avc_log("%s:  received setenforce notice (enforcing=%d)\n",
>             avc_prefix, msg->val);
> +        if (avc_setenforce)
> +            break;
>         avc_enforcing = msg->val;
>         if (avc_enforcing && (rc = avc_ss_reset(0)) < 0) {
>             avc_log("%s:  cache reset returned %d (errno %d)\n",
> @@ -183,7 +186,7 @@
> int avc_netlink_check_nb(void)
> {
>     int rc;
> -    char buf[1024];
> +    char buf[1024] __attribute__ ((aligned));
>
>     while (1) {
>         errno = 0;
> @@ -209,7 +212,7 @@
> void avc_netlink_loop(void)
> {
>     int rc;
> -    char buf[1024];
> +    char buf[1024] __attribute__ ((aligned));
>
>     while (1) {
>         errno = 0;
>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
