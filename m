Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5IDJe5L024434
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2008 09:19:40 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5IDJej3014616
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2008 13:19:40 GMT
Subject: Re: kernel/kernel.* diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <485005C9.8050902@redhat.com>
References: <4836D603.1000506@redhat.com> <1213020149.27496.3.camel@gorn>
	 <485005C9.8050902@redhat.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Jun 2008 09:18:37 -0400
Message-Id: <1213795117.11146.118.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-06-11 at 13:05 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> | On Fri, 2008-05-23 at 10:34 -0400, Daniel J Walsh wrote:
> |> Mainly adding additional dontaudits for permissive domains.
> |
> |> Subject: [PATCH] refpolicy: kernel_kernel changes
> |> --text follows this line--
> |> --- nsaserefpolicy/policy/modules/kernel/kernel.if	2008-05-23
> 09:15:06.224337000 -0400
> |> +++ serefpolicy-3.4.1/policy/modules/kernel/kernel.if	2008-05-23
> 10:29:05.107838000 -0400
> |> @@ -1198,6 +1198,7 @@
> |>  	')
> |>
> |>  	dontaudit $1 proc_type:dir list_dir_perms;
> |> +	dontaudit $1 proc_type:file getattr;
> |>  ')
> |>
> |>  ########################################
> |> @@ -1768,6 +1769,7 @@
> |>  	')
> |>
> |>  	dontaudit $1 sysctl_type:dir list_dir_perms;
> |> +	dontaudit $1 sysctl_type:file read_file_perms;
> |>  ')
> |>
> |>  ########################################
> |
> | These two violate the intention of the interface.
> |
> I though the intention of the interface was to dontaudit list of all
> proc or sysctl.  I believe this means we know this app tries to list
> sysctl or proc so dontaudit the listing.  Well part of the listing in
> permissive mode is the getattr or read.

﻿As with every other list interface in the policy, list means
list_dir_perms on the object type(s) and thats it.

>   So to make this work the way
> customers would expect we need to add interfaces all over the place and
> patch every call to this will a dontaudit file, which seems to be a
> colossal waste of time.

I don't agree with your characterization.  Making this change would make
the interfaces inconsistent with all of the other list interfaces, thus
violating their expectations.  If they are expecting that list
interfaces behave like your modified interfaces, then we aren't managing
their expectations correctly.

As for these two interfaces, they're both called once, from selinuxutil.

> Maybe we need a way to indicate whether this should be dontaudited in
> enforcing mode versus permissive.
> 
> Added patch for
> 
> cgroup_t.

Merged.

> plain text document attachment (kernel_kernel.patch)
> --- nsaserefpolicy/policy/modules/kernel/kernel.te	2008-06-11 08:15:43.000000000 -0400
> +++ serefpolicy-3.4.1/policy/modules/kernel/kernel.te	2008-06-11 10:06:56.000000000 -0400
> @@ -45,6 +45,15 @@
>  sid kernel gen_context(system_u:system_r:kernel_t,mls_systemhigh)
>  
>  #
> +# cgroup fs
> +#
> +
> +type cgroup_t;
> +fs_type(cgroup_t)
> +allow cgroup_t self:filesystem associate;
> +genfscon cgroup / gen_context(system_u:object_r:cgroup_t,s0)
> +
> +#
>  # DebugFS
>  #
>  
> +
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
