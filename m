Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB6Awl9S006218
	for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2011 05:58:49 -0500
Received: from cluster-e.mailcontrol.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pB6AwiKv022216
	for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2011 10:58:45 GMT
Received: from rly36e.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly36e.srv.mailcontrol.com (MailControl) with ESMTP id pB6AwYs4016373
	for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2011 10:58:34 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly36e.srv.mailcontrol.com (MailControl) id pB6Aw9Sh015716
	for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2011 10:58:09 GMT
From: Kohei Kaigai <Kohei.Kaigai@EMEA.NEC.COM>
To: Steve Lawrence <slawrence@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>, Kohei Kaigai <Kohei.Kaigai@EMEA.NEC.COM>
Subject: RE: [2/2] libselinux: fix case of names with whitespace/multibytes
 on /selinux/create
Date: Tue, 6 Dec 2011 10:58:02 +0000
Message-ID: <D0C1A1F8BF513F469926E6C71461D9EC09D2D1@EX10MBX02.EU.NEC.COM>
References: <A9F5079BABDEE646AEBDB6831725762C5560111DD8@EUEXCLU01.EU.NEC.COM>
In-Reply-To: <A9F5079BABDEE646AEBDB6831725762C5560111DD8@EUEXCLU01.EU.NEC.COM>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Let me remind a pending patch for a half years.
How about the current status of security_compute_create_name(_raw) interfaces to handle
named type transition?

It is a season to make a plan to propose new features of the next development cycle on
PostgreSQL, so I need groundworks at selinux side, prior to application side.

Thanks,
--
NEC Europe Ltd, SAP Global Competence Center
KaiGai Kohei <kohei.kaigai@emea.nec.com>


> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On Behalf Of Kohei Kaigai
> Sent: 11. Mai 2011 08:26
> To: Steve Lawrence
> Cc: SELinux
> Subject: [2/2] libselinux: fix case of names with whitespace/multibytes on /selinux/create
> 
> I submit the patch again, according to patch submission convension.
> 
> This patch enables to revise security_compute_create() interface to take a new argument of object name.
> The new interface is declared as follows:
>   int security_compute_create_name(const security_context_t scon,
>                                    const security_context_t tcon,
>                                    security_class_t tclass,
>                                    const char *objname,
>                                    security_context_t * newcon);
> 
> Unlike security labels, object names can contain whitespaces/multibyte-characters.
> The previous patch will support percentage-encoding rule on /selinux/create to avoid troubles in kernel
> space. This patch also support the rule in libselinux.
> 
> Signed-off-by: KaiGai Kohei <kohei.kaigai@emea.nec.com>
> ---
>  libselinux/include/selinux/selinux.h               |   10 ++
>  libselinux/man/man3/security_compute_av.3          |   17 ++++-
>  libselinux/man/man3/security_compute_create_name.3 |    1 +
>  libselinux/src/compute_create.c                    |   88 +++++++++++++++++---
>  libselinux/src/selinux_internal.h                  |    2 +
>  5 files changed, 105 insertions(+), 13 deletions(-)
> 
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index 0725b57..d0ddb78 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -211,6 +211,16 @@ extern int security_compute_create_raw(const security_context_t scon,
>  				       const security_context_t tcon,
>  				       security_class_t tclass,
>  				       security_context_t * newcon);
> +extern int security_compute_create_name(const security_context_t scon,
> +					const security_context_t tcon,
> +					security_class_t tclass,
> +					const char *objname,
> +					security_context_t * newcon);
> +extern int security_compute_create_name_raw(const security_context_t scon,
> +					    const security_context_t tcon,
> +					    security_class_t tclass,
> +					    const char *objname,
> +					    security_context_t * newcon);
> 
>  /* Compute a relabeling decision and set *newcon to refer to it.
>     Caller must free via freecon. */
> diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
> index f2d9f30..8e821cf 100644
> --- a/libselinux/man/man3/security_compute_av.3
> +++ b/libselinux/man/man3/security_compute_av.3
> @@ -1,6 +1,6 @@
>  .TH "security_compute_av" "3" "1 January 2004" "russell@coker.com.au" "SELinux API documentation"
>  .SH "NAME"
> -security_compute_av, security_compute_av_flags, security_compute_create, security_compute_relabel,
> +security_compute_av, security_compute_av_flags,
> +security_compute_create, security_compute_create_name,
> +security_compute_relabel,
>  security_compute_member, security_compute_user, security_get_initial_context \- query  the SELinux
> policy database in the kernel.
> 
> @@ -15,6 +15,8 @@ the SELinux policy database in the kernel.
>  .sp
>  .BI "int security_compute_create(security_context_t "scon ", security_context_t "tcon ",
> security_class_t "tclass ", security_context_t *" newcon );  .sp
> +.BI "int security_compute_create_name(security_context_t "scon ",
> +security_context_t "tcon ", security_class_t "tclass ", const char
> +*"objname ", security_context_t *" newcon ); .sp
>  .BI "int security_compute_relabel(security_context_t "scon ", security_context_t "tcon ",
> security_class_t "tclass ", security_context_t *" newcon );  .sp  .BI "int
> security_compute_member(security_context_t "scon ", security_context_t "tcon ", security_class_t
> "tclass ", security_context_t *" newcon ); @@ -56,6 +58,19 @@ which indicates the decision is computed
> on a permissive domain.
>  is used to compute a context to use for labeling a new object in a particular  class based on a SID
> pair.
> 
> +.B security_compute_create_name
> +is identical to
> +.B security_compute_create
> +but also takes name of the new object in creation as an argument.
> +When
> +.BR TYPE_TRANSITION
> +rule on the given class and a SID pair has object name extension, we
> +shall be able to obtain a correct .BR newcon according to the security
> +policy. Note that this interface is only supported on the linux 2.6.40
> +or later.
> +In the older kernel, the object name will be simply ignored.
> +
>  .B security_compute_relabel
>  is used to compute the new context to use when relabeling an object, it is used  in the pam_selinux.so
> source and the newrole source to determine the correct diff --git
> a/libselinux/man/man3/security_compute_create_name.3
> b/libselinux/man/man3/security_compute_create_name.3
> new file mode 100644
> index 0000000..a60bca4
> --- /dev/null
> +++ b/libselinux/man/man3/security_compute_create_name.3
> @@ -0,0 +1 @@
> +.so man3/security_compute_av.3
> diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_create.c index
> 0bbeeed..3c05be3 100644
> --- a/libselinux/src/compute_create.c
> +++ b/libselinux/src/compute_create.c
> @@ -6,19 +6,58 @@
>  #include <errno.h>
>  #include <string.h>
>  #include <limits.h>
> +#include <ctype.h>
>  #include "selinux_internal.h"
>  #include "policy.h"
>  #include "mapping.h"
> 
> -int security_compute_create_raw(const security_context_t scon,
> -				const security_context_t tcon,
> -				security_class_t tclass,
> -				security_context_t * newcon)
> +static int object_name_encode(const char *objname, char *buffer, size_t
> +buflen) {
> +	int	code;
> +	size_t	offset = 0;
> +
> +	if (buflen - offset < 1)
> +		return -1;
> +	buffer[offset++] = ' ';
> +
> +	do {
> +		code = *objname++;
> +
> +		if (isalnum(code) || code == '\0' || code == '-' ||
> +		    code == '.' || code == '_' || code == '~') {
> +			if (buflen - offset < 1)
> +				return -1;
> +			buffer[offset++] = code;
> +		} else if (code == ' ') {
> +			if (buflen - offset < 1)
> +				return -1;
> +			buffer[offset++] = '+';
> +		} else {
> +			static const char *table = "0123456789ABCDEF";
> +			int	l = (code & 0x0f);
> +			int	h = (code & 0xf0) >> 4;
> +
> +			if (buflen - offset < 3)
> +				return -1;
> +			buffer[offset++] = '%';
> +			buffer[offset++] = table[h];
> +			buffer[offset++] = table[l];
> +		}
> +	} while (code != '\0');
> +
> +	return 0;
> +}
> +
> +int security_compute_create_name_raw(const security_context_t scon,
> +				     const security_context_t tcon,
> +				     security_class_t tclass,
> +				     const char *objname,
> +				     security_context_t * newcon)
>  {
>  	char path[PATH_MAX];
>  	char *buf;
>  	size_t size;
> -	int fd, ret;
> +	int fd, ret, len;
> 
>  	if (!selinux_mnt) {
>  		errno = ENOENT;
> @@ -36,7 +75,14 @@ int security_compute_create_raw(const security_context_t scon,
>  		ret = -1;
>  		goto out;
>  	}
> -	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
> +	len = snprintf(buf, size, "%s %s %hu",
> +		       scon, tcon, unmap_class(tclass));
> +	if (objname &&
> +	    object_name_encode(objname, buf + len, size - len) < 0) {
> +		errno = ENAMETOOLONG;
> +		ret = -1;
> +		goto out2;
> +	}
> 
>  	ret = write(fd, buf, strlen(buf));
>  	if (ret < 0)
> @@ -59,13 +105,23 @@ int security_compute_create_raw(const security_context_t scon,
>  	close(fd);
>  	return ret;
>  }
> +hidden_def(security_compute_create_name_raw)
> 
> +int security_compute_create_raw(const security_context_t scon,
> +				const security_context_t tcon,
> +				security_class_t tclass,
> +				security_context_t * newcon)
> +{
> +	return security_compute_create_name_raw(scon, tcon, tclass,
> +						NULL, newcon);
> +}
>  hidden_def(security_compute_create_raw)
> 
> -int security_compute_create(const security_context_t scon,
> -			    const security_context_t tcon,
> -			    security_class_t tclass,
> -			    security_context_t * newcon)
> +int security_compute_create_name(const security_context_t scon,
> +				 const security_context_t tcon,
> +				 security_class_t tclass,
> +				 const char *objname,
> +				 security_context_t * newcon)
>  {
>  	int ret;
>  	security_context_t rscon;
> @@ -79,8 +135,8 @@ int security_compute_create(const security_context_t scon,
>  		return -1;
>  	}
> 
> -	ret = security_compute_create_raw(rscon, rtcon, tclass, &rnewcon);
> -
> +	ret = security_compute_create_name_raw(rscon, rtcon, tclass,
> +					       objname, &rnewcon);
>  	freecon(rscon);
>  	freecon(rtcon);
>  	if (!ret) {
> @@ -90,5 +146,13 @@ int security_compute_create(const security_context_t scon,
> 
>  	return ret;
>  }
> +hidden_def(security_compute_create_name)
> 
> +int security_compute_create(const security_context_t scon,
> +			    const security_context_t tcon,
> +			    security_class_t tclass,
> +			    security_context_t * newcon)
> +{
> +	return security_compute_create_name(scon, tcon, tclass, NULL, newcon);
> +}
>  hidden_def(security_compute_create)
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
> index fdddfaf..3f14955 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -23,6 +23,8 @@ hidden_proto(selinux_mkload_policy)
>      hidden_proto(security_compute_user_raw)
>      hidden_proto(security_compute_create)
>      hidden_proto(security_compute_create_raw)
> +    hidden_proto(security_compute_create_name)
> +    hidden_proto(security_compute_create_name_raw)
>      hidden_proto(security_compute_member_raw)
>      hidden_proto(security_compute_relabel_raw)
>      hidden_proto(is_selinux_enabled)
> 
> --
> NEC Europe Ltd, SAP Global Competence Center
> KaiGai Kohei <kohei.kaigai@emea.nec.com>
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 
>  Click
> https://www.mailcontrol.com/sr/JI1Mn3lWOKvTndxI!oX7UseyfNgsFvsQfTggVwW!8F8tkQW8FXqoLj26b4Rh2I8EQN
> 2L0ELrfjj02A3zwbO5JA==  to report this email as spam.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
