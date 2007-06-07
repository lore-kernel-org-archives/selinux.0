Subject: Re: [PATCH 2/2] libselinux: class and permission mapping support
	(try 2)
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: jwcart2@epoch.ncsc.mil, SE Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <4666FE38.4060401@tycho.nsa.gov>
References: <4666D5E6.508@tycho.nsa.gov>
	 <1181148038.17617.25.camel@moss-lions.epoch.ncsc.mil>
	 <4666FE38.4060401@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 10:18:29 -0400
Message-Id: <1181225909.7049.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-06 at 14:34 -0400, Eamon Walsh wrote:
> This patch includes the internal map and unmap functions and
> the changes to the selinuxfs interfaces to make it work.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
> ---
> 
>  compute_av.c      |    8 ++-
>  compute_create.c  |    5 +-
>  compute_member.c  |    5 +-
>  compute_relabel.c |    5 +-
>  mapping.h         |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  stringrep.c       |   17 +++++--
>  6 files changed, 148 insertions(+), 13 deletions(-)
> 
> Index: libselinux/src/mapping.h
> ===================================================================
> --- libselinux/src/mapping.h	(revision 0)
> +++ libselinux/src/mapping.h	(revision 0)
> @@ -0,0 +1,121 @@
> +/*
> + * This file describes the class and permission mappings used to 
> + * hide the kernel numbers from userspace by allowing userspace object
> + * managers to specify a list of classes and permissions.
> + */
> +#ifndef _SELINUX_MAPPING_H_
> +#define _SELINUX_MAPPING_H_
> +
> +#include <assert.h>
> +#include <selinux/selinux.h>
> +
> +struct selinux_mapping {
> +	security_class_t value; /* real, kernel value */
> +	unsigned num_perms;
> +	access_vector_t perms[sizeof(access_vector_t) * 8];
> +};

Should 8 be sizeof(access_vector_t)?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
