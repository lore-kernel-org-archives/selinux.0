Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7RDrhrT019979
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 09:53:43 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7RDrgoM017636
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 13:53:42 GMT
Subject: Re: Latest Diffs.
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <412CAE6B.30006@redhat.com>
References: <412CAE6B.30006@redhat.com>
Content-Type: text/plain
Message-Id: <1093614774.24188.23.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 27 Aug 2004 09:52:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks.  Merged with some slight variations in named.te as follows.

On Wed, 2004-08-25 at 11:21, Daniel J Walsh wrote:
> We now have named booleans working with named master updates.
> 
> Added can_ypbind to lots of te files to support NIS environments.
> 
> Dan
> 
> 
> 
> ______________________________________________________________________
> diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.3/domains/program/unused/named.te
> --- nsapolicy/domains/program/unused/named.te	2004-08-22 20:55:02.000000000 -0400
> +++ policy-1.17.3/domains/program/unused/named.te	2004-08-25 11:05:14.054851490 -0400
> @@ -32,10 +32,10 @@
>  type named_conf_t, file_type, sysadmfile;
>  typealias named_conf_t alias rndc_conf_t;
>  
> -# for zone files
> +# for primary zone files
>  type named_zone_t, file_type, sysadmfile;
>  
> -# named.ca files
> +# for secondary zone files
>  type named_cache_t, file_type, sysadmfile;
>  
>  # Use capabilities. Surplus capabilities may be allowed.
> @@ -68,7 +68,8 @@
>  #read zone files
>  r_dir_file(named_t, named_zone_t)
>  
> -r_dir_file(named_t, named_cache_t)
> +#write cache for secondary zones
> +rw_dir_create_file(named_t, named_cache_t)
>  
>  allow named_t self:unix_stream_socket create_stream_socket_perms;
>  allow named_t self:unix_dgram_socket create_socket_perms;
> @@ -100,7 +101,14 @@
>  can_ypbind(ndc_t)
>  read_locale(ndc_t)
>  can_tcp_connect(ndc_t, named_t)
> -allow { named_t ndc_t initrc_t } rndc_conf_t:file { getattr read };
> +dontaudit ndc_t unlabeled_t:file read;
Didn't include the above line

> +allow ndc_t var_t:dir search;
added:
allow ndc_t var_run_t:dir search;
and put both statements just before this statement:
allow ndc_t named_var_run_t:sock_file rw_file_perms;

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
