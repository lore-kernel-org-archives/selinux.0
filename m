Message-ID: <45CB3EC4.7000103@mentalrootkit.com>
Date: Thu, 08 Feb 2007 10:16:20 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Small patch to allow semodule_deps to build
References: <45CA4A0E.7000500@redhat.com>
In-Reply-To: <45CA4A0E.7000500@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> 
> 
> ------------------------------------------------------------------------
> 
> --- nsapolicycoreutils/semodule_deps/semodule_deps.c	2007-02-07 12:11:49.000000000 -0500
> +++ policycoreutils-2.0.0/semodule_deps/semodule_deps.c	2007-02-07 16:46:18.000000000 -0500
> @@ -16,7 +16,7 @@
>   * of avrule_blocks - even in an ABI safe way - seems undesirable.
>   */
>  #include <sepol/module.h>
> -#include <sepol/errno.h>
> +#include <sepol/errcodes.h>
>  #include <sepol/policydb/policydb.h>
>  
>  #include <getopt.h>

This shouldn't be necessary - errcodes.h should be included via 
policydb.h -> symtab.h -> hashtab.h. Also, I can't reproduce this locally.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
