Subject: Re: [PATCH] Convert avc_audit to use lsm_audit.h
From: Eric Paris <eparis@redhat.com>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        eparis@parisplace.org
In-Reply-To: <1247171811.2276.13.camel@Ares>
References: <1247171811.2276.13.camel@Ares>
Content-Type: text/plain
Date: Thu, 09 Jul 2009 16:43:53 -0400
Message-Id: <1247172234.2927.4.camel@dhcp235-23.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-09 at 16:36 -0400, Thomas Liu wrote:
> Convert avc_audit in security/selinux/avc.c to use lsm_audit.h,
> for better maintainability and for less code duplication.
> 
>  - changed selinux to use common_audit_data instead of
>    avc_audit_data
>  - eliminated code in avc.c and used code from lsm_audit.h instead.
> 
> Signed-off-by: Thomas Liu <tliu@redhat.com>
> ---

First I didn't verify that the formatting didn't change.  Did you
generate and avc before and after this patch to make sure the audit
record emitted is exactly the same?

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index 236aaa2..e525a06 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -492,7 +492,7 @@ out:
>  	return node;
>  }
>  
> -static inline void avc_print_ipv6_addr(struct audit_buffer *ab,
> +static inline void print_ipv6_addr(struct audit_buffer *ab,
>  				       struct in6_addr *addr, __be16 port,
>  				       char *name1, char *name2)
>  {
> @@ -502,7 +502,7 @@ static inline void avc_print_ipv6_addr(struct audit_buffer *ab,
>  		audit_log_format(ab, " %s=%d", name2, ntohs(port));
>  }
>  
> -static inline void avc_print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
> +static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
>  				       __be16 port, char *name1, char *name2)
>  {
>  	if (addr)
> @@ -512,6 +512,52 @@ static inline void avc_print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
>  }

Didn't you get a build warning about these functions being declared but
not used?  Maybe that doesn't happen with inlines?  Are they used?
Shouldn't these be removed as well?  Are their others?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
