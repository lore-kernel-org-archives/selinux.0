Subject: Re: More fixes for nscd in targeted policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <41475DEA.90907@redhat.com>
References: <41475DEA.90907@redhat.com>
Content-Type: text/plain
Message-Id: <1095253977.28981.80.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 15 Sep 2004 09:12:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-09-14 at 17:08, Daniel J Walsh wrote:
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.15/domains/program/unused/named.te
> --- nsapolicy/domains/program/unused/named.te	2004-09-14 09:18:10.000000000 -0400
> +++ policy-1.17.15/domains/program/unused/named.te	2004-09-14 16:59:49.090149450 -0400
> @@ -12,10 +12,10 @@
>  #
>  type rndc_port_t, port_type;
>  
> -daemon_domain(named)
> +daemon_domain(named, `, nscd_shmem_domain')
>  tmp_domain(named)

nscd_shmem_domain should only be given to domains that you trust to have
access to the entire cached mapping.  Otherwise, use nscd_client_domain
to let them use the socket interface.

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.15/domains/program/unused/nscd.te
> --- nsapolicy/domains/program/unused/nscd.te	2004-09-10 16:10:36.000000000 -0400
> +++ policy-1.17.15/domains/program/unused/nscd.te	2004-09-14 16:59:24.541807946 -0400
> @@ -24,6 +24,7 @@
>  ifdef(`nscd_all_connect', `
>  can_unix_connect(domain, nscd_t)
>  allow domain nscd_var_run_t:sock_file rw_file_perms;
> +allow domain nscd_var_run_t:file r_file_perms;

I don't think you want to allow this for clients that are using the
socket interface, only those that are using the shmem interface (which
should be limited to a small set).

> +#
> +# Handle winbind for samba, Might only be needed for targeted policy
> +#
> +dontaudit nscd_t var_run_t:sock_file rw_file_perms;

This doesn't make sense; nscd_t has these permissions as a consequence
of having nscd_client_domain attribute in the policy (since it is used
for both the client and the daemon).

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.17.15/domains/program/unused/ntpd.te
> --- nsapolicy/domains/program/unused/ntpd.te	2004-09-09 15:36:13.000000000 -0400
> +++ policy-1.17.15/domains/program/unused/ntpd.te	2004-09-14 17:01:58.987097221 -0400
> @@ -8,7 +8,7 @@
>  #
>  # Rules for the ntpd_t domain.
>  #
> -daemon_domain(ntpd)
> +daemon_domain(ntpd, `, nscd_shmem_domain')
>  type ntp_drift_t, file_type, sysadmfile;
>  type ntp_port_t, port_type;

nscd_client_domain only, I'd say.

> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.17.15/domains/program/unused/portmap.te
> --- nsapolicy/domains/program/unused/portmap.te	2004-09-09 15:36:13.000000000 -0400
> +++ policy-1.17.15/domains/program/unused/portmap.te	2004-09-14 16:59:37.482406411 -0400
> @@ -11,7 +11,7 @@
>  #
>  # Rules for the portmap_t domain.
>  #
> -daemon_domain(portmap)
> +daemon_domain(portmap, `, nscd_shmem_domain')
>  
>  can_network(portmap_t)
>  can_ypbind(portmap_t)

Ditto.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
