Message-ID: <1495660335.15706.0.camel@tycho.nsa.gov>
Subject: Re: [PATCH v3 9/9] semanage: Update man pages for infiniband
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
Date: Wed, 24 May 2017 17:12:15 -0400
In-Reply-To: <1495458511-46724-10-git-send-email-danielj@mellanox.com>
References: <1495458511-46724-1-git-send-email-danielj@mellanox.com>
 <1495458511-46724-10-git-send-email-danielj@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-05-22 at 16:08 +0300, Dan Jurgens wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Update the main man page and add specific pages for ibpkeys and
> ibendports.

Thanks, applied all nine.  I did notice that you left Dan Walsh as the
author of the man pages you added though; feel free to submit a patch
to fix that.

> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> ---
>  python/semanage/semanage-ibendport.8 | 66
> ++++++++++++++++++++++++++++++++++++
>  python/semanage/semanage-ibpkey.8    | 66
> ++++++++++++++++++++++++++++++++++++
>  python/semanage/semanage.8           | 16 ++++++---
>  3 files changed, 144 insertions(+), 4 deletions(-)
>  create mode 100644 python/semanage/semanage-ibendport.8
>  create mode 100644 python/semanage/semanage-ibpkey.8
> 
> diff --git a/python/semanage/semanage-ibendport.8
> b/python/semanage/semanage-ibendport.8
> new file mode 100644
> index 00000000..c3753a27
> --- /dev/null
> +++ b/python/semanage/semanage-ibendport.8
> @@ -0,0 +1,66 @@
> +.TH "semanage-ibendport" "8" "20170508" "" ""
> +.SH "NAME"
> +.B semanage\-ibendport \- SELinux Policy Management ibendport
> mapping tool
> +.SH "SYNOPSIS"
> +.B semanage ibendport [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add \-t
> TYPE \-z IBDEV_NAME \-r RANGE port | \-\-delete \-z IBDEV_NAME port |
> \-\-deleteall  | \-\-extract  | \-\-list [\-C] | \-\-modify \-t TYPE
> \-z IBDEV_NAME \-r RANGE port ]
> +
> +.SH "DESCRIPTION"
> +semanage is used to configure certain elements of SELinux policy
> without requiring modification to or recompilation from policy
> sources.  semanage ibendport controls the ibendport number to
> ibendport type definitions.
> +
> +.SH "OPTIONS"
> +.TP
> +.I  \-h, \-\-help
> +show this help message and exit
> +.TP
> +.I   \-n, \-\-noheading
> +Do not print heading when listing the specified object type
> +.TP
> +.I   \-N, \-\-noreload
> +Do not reload policy after commit
> +.TP
> +.I   \-S STORE, \-\-store STORE
> +Select an alternate SELinux Policy Store to manage
> +.TP
> +.I   \-C, \-\-locallist
> +List local customizations
> +.TP
> +.I   \-a, \-\-add
> +Add a record of the specified object type
> +.TP
> +.I   \-d, \-\-delete
> +Delete a record of the specified object type
> +.TP
> +.I   \-m, \-\-modify
> +Modify a record of the specified object type
> +.TP
> +.I   \-l, \-\-list
> +List records of the specified object type
> +.TP
> +.I   \-E, \-\-extract
> +Extract customizable commands, for use within a transaction
> +.TP
> +.I   \-D, \-\-deleteall
> +Remove all local customizations
> +.TP
> +.I   \-t TYPE, \-\-type TYPE
> +SELinux type for the object
> +.TP
> +.I   \-r RANGE, \-\-range RANGE
> +MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for
> SELinux login mapping defaults to the SELinux user record range.
> SELinux Range for SELinux user defaults to s0.
> +.TP
> +.I \-z IBDEV_NAME, \-\-ibdev_name IBDEV_NAME
> +The name of the infiniband device for the port to be labeled.  (ex.
> mlx5_0)
> +
> +.SH EXAMPLE
> +.nf
> +List all ibendport definitions
> +# semanage ibendport \-l
> +Label mlx4_0 port 2.
> +# semanage ibendport \-a \-t allowed_ibendport_t \-z mlx4_0 2
> +
> +.SH "SEE ALSO"
> +.BR selinux (8),
> +.BR semanage (8)
> +
> +.SH "AUTHOR"
> +This man page was written by Daniel Walsh <dwalsh@redhat.com>
> diff --git a/python/semanage/semanage-ibpkey.8
> b/python/semanage/semanage-ibpkey.8
> new file mode 100644
> index 00000000..2da4f546
> --- /dev/null
> +++ b/python/semanage/semanage-ibpkey.8
> @@ -0,0 +1,66 @@
> +.TH "semanage-ibpkey" "8" "20170508" "" ""
> +.SH "NAME"
> +.B semanage\-ibpkey \- SELinux Policy Management ibpkey mapping tool
> +.SH "SYNOPSIS"
> +.B semanage ibpkey [\-h] [\-n] [\-N] [\-S STORE] [ \-\-add \-t TYPE
> \-x SUBNET_PREFIX \-r RANGE ibpkey_name | ibpkey_range | \-\-delete
> \-x SUBNET_PREFIX ibpkey_name | ibpkey_range | \-\-deleteall  | \-\-
> extract  | \-\-list [\-C] | \-\-modify \-t TYPE \-x SUBNET_PREFIX \-r 
> RANGE ibpkey_name | ibpkey_range ]
> +
> +.SH "DESCRIPTION"
> +semanage is used to configure certain elements of SELinux policy
> without requiring modification to or recompilation from policy
> sources.  semanage ibpkey controls the ibpkey number to ibpkey type
> definitions.
> +
> +.SH "OPTIONS"
> +.TP
> +.I  \-h, \-\-help
> +show this help message and exit
> +.TP
> +.I   \-n, \-\-noheading
> +Do not print heading when listing the specified object type
> +.TP
> +.I   \-N, \-\-noreload
> +Do not reload policy after commit
> +.TP
> +.I   \-S STORE, \-\-store STORE
> +Select an alternate SELinux Policy Store to manage
> +.TP
> +.I   \-C, \-\-locallist
> +List local customizations
> +.TP
> +.I   \-a, \-\-add
> +Add a record of the specified object type
> +.TP
> +.I   \-d, \-\-delete
> +Delete a record of the specified object type
> +.TP
> +.I   \-m, \-\-modify
> +Modify a record of the specified object type
> +.TP
> +.I   \-l, \-\-list
> +List records of the specified object type
> +.TP
> +.I   \-E, \-\-extract
> +Extract customizable commands, for use within a transaction
> +.TP
> +.I   \-D, \-\-deleteall
> +Remove all local customizations
> +.TP
> +.I   \-t TYPE, \-\-type TYPE
> +SELinux type for the object
> +.TP
> +.I   \-r RANGE, \-\-range RANGE
> +MLS/MCS Security Range (MLS/MCS Systems only) SELinux Range for
> SELinux login mapping defaults to the SELinux user record range.
> SELinux Range for SELinux user defaults to s0.
> +.TP
> +.I \-x SUBNET_PREFIX, \-\-subnet_prefix SUBNET_PREFIX
> +Subnet prefix for the specified pkey or range of pkeys.
> +
> +.SH EXAMPLE
> +.nf
> +List all ibpkey definitions
> +# semanage ibpkey \-l
> +Label pkey 0x8FFF (limited membership default pkey) as a default
> pkey type
> +# semanage ibpkey \-a \-t default_ibpkey_t \-x fe80:: 0x8FFF
> +
> +.SH "SEE ALSO"
> +.BR selinux (8),
> +.BR semanage (8)
> +
> +.SH "AUTHOR"
> +This man page was written by Daniel Walsh <dwalsh@redhat.com>
> diff --git a/python/semanage/semanage.8 b/python/semanage/semanage.8
> index abc47360..0bdb90f4 100644
> --- a/python/semanage/semanage.8
> +++ b/python/semanage/semanage.8
> @@ -3,7 +3,7 @@
>  semanage \- SELinux Policy Management tool
>  
>  .SH "SYNOPSIS"
> -.B
> semanage                {import,export,login,user,port,interface,modu
> le,node,fcontext,boolean,permissive,dontaudit}
> +.B
> semanage                {import,export,login,user,port,interface,modu
> le,node,fcontext,boolean,permissive,dontaudit,ibpkey,ibendport}
>                  ...
>  .B positional arguments:
>  
> @@ -43,6 +43,12 @@ Manage process type enforcement mode
>  .B    dontaudit
>  Disable/Enable dontaudit rules in policy
>  
> +.B    ibpkey
> +Manage infiniband pkey type definitions
> +
> +.B    ibendport
> +Manage infiniband end port type definitions
> +
>  .SH "DESCRIPTION"
>  semanage is used to configure certain elements of
>  SELinux policy without requiring modification to or recompilation
> @@ -50,9 +56,9 @@ from policy sources.  This includes the mapping
> from Linux usernames
>  to SELinux user identities (which controls the initial security
> context
>  assigned to Linux users when they login and bounds their authorized
> role set)
>  as well as security context mappings for various kinds of objects,
> such
> -as network ports, interfaces, and nodes (hosts) as well as the file
> -context mapping. See the EXAMPLES section below for some examples
> -of common usage.  Note that the semanage login command deals with
> the
> +as network ports, interfaces, infiniband pkeys and endports, and
> nodes (hosts)
> +as well as the file context mapping. See the EXAMPLES section below
> for some
> +examples of common usage.  Note that the semanage login command
> deals with the
>  mapping from Linux usernames (logins) to SELinux user identities,
>  while the semanage user command deals with the mapping from SELinux
>  user identities to authorized role sets.  In most cases, only the
> @@ -79,6 +85,8 @@ List help information
>  .BR semanage-permissive (8),
>  .BR semanage-port (8),
>  .BR semanage-user (8)
> +.BR semanage-ibkey (8),
> +.BR semanage-ibendport (8),
>  
>  .SH "AUTHOR"
>  This man page was written by Daniel Walsh <dwalsh@redhat.com>
