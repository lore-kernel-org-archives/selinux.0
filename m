Subject: Re: More fixes for nscd in targeted policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41484CFE.3050804@redhat.com>
References: <41475DEA.90907@redhat.com>
	 <1095253977.28981.80.camel@moss-spartans.epoch.ncsc.mil>
	 <41484CFE.3050804@redhat.com>
Content-Type: text/plain
Message-Id: <1095261243.28981.185.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 15 Sep 2004 11:14:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-09-15 at 10:09, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.16/domains/program/unused/nscd.te
> --- nsapolicy/domains/program/unused/nscd.te	2004-09-10 16:10:36.000000000 -0400
> +++ policy-1.17.16/domains/program/unused/nscd.te	2004-09-15 10:05:36.390612619 -0400
> @@ -26,23 +26,27 @@
>  allow domain nscd_var_run_t:sock_file rw_file_perms;
>  allow domain { var_run_t var_t }:dir search;
>  allow domain nscd_t:nscd { getpwd getgrp gethost };
> +allow domain nscd_t:fd { use };
> +dontaudit domain nscd_var_run_t:file { getattr read };
>  dontaudit domain nscd_t:nscd { shmempwd shmemgrp shmemhost };

No, the nscd_t:fd use should also be dontaudit'd for that case; only
domains with nscd_shmem_domain need to accept fds from nscd for mapping
the cache.  And I don't understand why you need the dontaudit rule, as
the lack of shmempwd/shmemgrp/shmemhost permissions should prevent it
from ever reaching that point at all - bug report on nscd, I'd suggest.

>  ', `
>  can_unix_connect(nscd_client_domain, nscd_t)
> -allow nscd_client_domain var_run_nscd_t:sock_file rw_file_perms;
> +allow nscd_client_domain nscd_var_run_t:sock_file rw_file_perms;
>  allow nscd_client_domain { var_run_t var_t }:dir search;
>  allow nscd_client_domain nscd_t:nscd { getpwd getgrp gethost };
> +allow nscd_client_domain nscd_t:fd { use };
> +dontaudit nscd_client_domain nscd_var_run_t:file { getattr read };
>  dontaudit nscd_client_domain nscd_t:nscd { shmempwd  shmemgrp shmemhost };
>  ')dnl nscd_all_connect

ditto.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
