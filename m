Message-ID: <45255AB1.9050408@redhat.com>
Date: Thu, 05 Oct 2006 15:19:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: SELinux List <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: Re: [RFC PATCH 3/3] mcstransd: perform an access check on the conext
 to be translated
References: <452549CF.5080707@trustedcs.com>
In-Reply-To: <452549CF.5080707@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Darrel Goeddel wrote:
> Perform an access check on the conext to be translated.  This uses the 
> new
> security class/perm of "context"/"translate".  A userspace AVC is used to
> cache all decisions and the _raw functions are used to eliminate extra
> translations for contexts never seen by users.  Dan Walsh has noted 
> that he
> would like this to turnoffable - I haven't done that yet.  I was 
> figuring on
> just including a paramter like "-c" to enable access checks or 
> something like
> that - I'm open to suggestions.  I also do not have the AVC hooked up to
> auditing right now - I imagine I'll want to do that as well.
>
Put it in the config file. 
>
> ---
>
>
> diff --git a/src/mcstransd.c b/src/mcstransd.c
> index 637c508..fb2f912 100644
> --- a/src/mcstransd.c
> +++ b/src/mcstransd.c
> @@ -13,6 +13,9 @@ #include <stdlib.h>
> #include <signal.h>
> #include <string.h>
> #include <syslog.h>
> +#include <selinux/avc.h>
> +#include <selinux/av_permissions.h>
> +#include <selinux/flask.h>
> #include <selinux/selinux.h>
> #include <sys/types.h>
> #include <sys/capability.h>
> @@ -59,6 +62,8 @@ static void cleanup_exit(int ret) __attr
> static void
> cleanup_exit(int ret) {
> +    avc_destroy();
> +
>     if (sockfd >=0)
>         (void)unlink(SETRANS_UNIX_SOCKET);
>     exit(ret);
> @@ -75,18 +80,21 @@ static  __attribute__((noreturn)) void c
>  * Returns:  0 on success, 1 on failure
>  */
> static int
> -raw_to_trans_context(char *in, char **out, char *UNUSED(pcon))
> +raw_to_trans_context(char *in, char **out, char *pcon)
> {
> +    security_id_t psid, csid;
>
>     *out = NULL;
> -    /* TODO: Check if MLS clearance (in "pcon") dominates the MLS label
> -     * (in "in").
> -     */
> +    if (avc_context_to_sid_raw(pcon, &psid))
> +        return -1;
> +    if (avc_context_to_sid_raw(in, &csid))
> +        return -1;
> +    if (avc_has_perm(psid, csid, SECCLASS_CONTEXT, CONTEXT__TRANSLATE,
> +                     NULL, NULL))
> +        return -1;
>
> -    trans_context(in, out);
> -   
> -    return 0;
> +    return trans_context(in, out);
> }
>
>
> @@ -95,17 +103,30 @@ raw_to_trans_context(char *in, char **ou
>  * Returns:  0 on success, 1 on failure
>  */
> static int
> -trans_to_raw_context(char *in, char **out, char *UNUSED(pcon))
> +trans_to_raw_context(char *in, char **out, char *pcon)
> {
> +    security_id_t psid, csid;
> +    int retval;
> +
>     *out = NULL;
>     
> -    /* TODO: Check if MLS clearance (in "pcon") dominates the MLS label
> -     * (in "in").
> -     */
> -
> -    untrans_context(in, out);
> +    retval = untrans_context(in, out);
> +    if (retval)
> +        return retval;
> +
> +    if (avc_context_to_sid_raw(pcon, &psid))
> +        goto out_err;
> +    if (avc_context_to_sid_raw(*out, &csid))
> +        goto out_err;
> +    if (avc_has_perm(psid, csid, SECCLASS_CONTEXT, CONTEXT__TRANSLATE,
> +                     NULL, NULL))
> +        goto out_err;
>
>     return 0;
> +out_err:
> +    free(*out);
> +    *out = NULL;
> +    return -1;
> }
>
> static int
> @@ -152,29 +173,6 @@ send_response(int fd, uint32_t function,
> }
>
> static int
> -get_peer_con(int fd, char **peercon)
> -{
> -    int ret;
> -    socklen_t size = sizeof(struct ucred);
> -    struct ucred peercred;
> -
> -    /* get the context of the requesting process */
> -    ret = getsockopt(fd, SOL_SOCKET, SO_PEERCRED, &peercred, &size);
> -    if (ret < 0) {
> -        syslog(LOG_ERR, "Failed to get PID of client process");
> -        return -1;
> -    }
> -    ret = getpidcon_raw(peercred.pid, peercon);
> -    if (ret) {
> -        syslog(LOG_ERR, -            "Failed to get context of client 
> process (pid=%u)",
> -            peercred.pid);
> -        return -1;
> -    }
> -    return 0;
> -}
> -
> -static int
> process_request(int fd, uint32_t function, char *data1, char *data2)
> {
>     int32_t result;
> @@ -191,14 +189,14 @@ process_request(int fd, uint32_t functio
>         ret = send_response(fd, function, NULL, result);
>         break;
>     case RAW_TO_TRANS_CONTEXT:
> -        ret = get_peer_con(fd, &peercon);
> +        ret = getpeercon_raw(fd, &peercon);
>         if (ret)
>             return ret;
>         result = raw_to_trans_context(data1, &out, peercon);
>         ret = send_response(fd, function, out, result);
>         break;
>     case TRANS_TO_RAW_CONTEXT:
> -        ret = get_peer_con(fd, &peercon);
> +        ret = getpeercon_raw(fd, &peercon);
>         if (ret)
>             return ret;
>         result = trans_to_raw_context(data1, &out, peercon);
> @@ -493,6 +491,12 @@ initialize(void)
>         cleanup_exit(1);
>     }
>
> +    if (avc_init("setransd", NULL, NULL, NULL, NULL)) {
> +        syslog(LOG_ERR, "Failed to initialize AVC for "
> +               "label translations");
> +        cleanup_exit(1);
> +    }
> +
>     /* the socket will be unlinked when the daemon terminates */
>     act.sa_handler = sigterm_handler;
>     sigemptyset(&act.sa_mask);


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
