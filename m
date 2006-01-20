Message-ID: <43D0ECF2.9090104@tresys.com>
Date: Fri, 20 Jan 2006 09:00:18 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com> <1137765246.3648.118.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1137765246.3648.118.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
<snip>

> 
> The comment might be a little misleading, as:
> a) access(2) checks against the real UID/GID of the process, not its
> effective or fs identities; not presently an issue since the caller is
> not a setuid or setgid program, but could be an issue at some point,
> b) access(2) internally calls permission(9), and permission(9) calls the
> security hook, so SELinux checks are also applied here.
> 
Ok, that can be removed/updated. It is better IMO that the selinux 
checks apply since those will be just as much or more of an issue than 
uid/gid on a strict system

> diff -purN -x.svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
> --- libsemanage/src/semanage_store.c	2006-01-18 11:56:33.000000000 -0500
> +++ libsemanage/src/semanage_store.c	2006-01-19 16:36:53.000000000 -0500
> @@ -281,7 +281,41 @@ int semanage_create_store(semanage_handl
>  	return 0;
>  }
>  
> +/* returns -1 if the store or binary policy directory 
> + * is probably not writable by the current UID/GID */
> +int semanage_store_writable(semanage_handle_t *sh) {
> 
> Ditto.
> 
same

> +	const char *path;
> +	char *path2, *path3, polpath[PATH_MAX];
> +	int rc;
>  
> +	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(), sh->conf->store_path);
> +
> +	if (semanage_check_init(polpath))
> +		return -1;
> 
> These calls presently occur from semanage_direct* functions only, prior
> to calling semanage_create_store.  Not sure why this would be different.

semanage_can_write can be called separately. See the seobject.py patch 
which calls it before anything that calls semanage_check_init. I suppose 
I can move it to the direct_can_write but it is an semanage_store 
function and this will only be called by direct_can_hook, not by ps or 
any other api

> +
> +	/* check the active directory */
> +	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
> +	if ((rc = access(path, R_OK | W_OK | X_OK)) != 0)
> +		return rc;
> +
> +	/* check the binary policy install directory */
> +	path = selinux_binary_policy_path();
> +	path2 = strdup(path);
> +	path3 = dirname(path2);
> +
> +	if ((rc = access(path3, R_OK | W_OK | X_OK)) != 0) {
> +		free(path2);
> +		return rc;
> +	}
> +	free(path2);
> 
> Not sure about requiring rwx to the installed policy directory for this
> test.  As far as DAC permissions are concerned, this ends up being
> equivalent presently to checking rwx to the module store, as they are
> both root owned and only writable by owner, but conceptually being able
> to manipulate the store (particularly for read ops) differs from being
> able to install a new policy.  SELinux policy might allow one but not
> the other.
> 
hrm, at some point we need to test the writability of the binary policy 
dir. If the whole commit goes through and then the policy can't be 
written there is a consistency issue on the system


> +
> +	/* check the modules directory */
> +	path = semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
> +	if ((rc = access(path, R_OK | W_OK | X_OK)) != 0)
> +		return rc;
> +	
> +	return 0;
> +}
> 
> Do we need both checks (active toplevel and active modules), or will one do?
> semanage_create_store() ends up doing multiple checks since it also
> creates the directories along the way, but if we are just checking
> access, it is likely sufficient to check the most restrictive one (i.e.
> active modules), right?
>  
sure.

>  /********************* other I/O functions *********************/
>  
> diff -purN -x.svn policycoreutils/semanage/seobject.py policycoreutils/semanage/seobject.py
> --- policycoreutils/semanage/seobject.py	2006-01-19 15:04:23.000000000 -0500
> +++ policycoreutils/semanage/seobject.py	2006-01-19 16:34:36.000000000 -0500
> @@ -142,6 +142,11 @@ class setransRecords:
>  class semanageRecords:
>  	def __init__(self):
>  		self.sh = semanage_handle_create()
> +		rc = semanage_can_write(self.sh)
> +		if rc:
> +			semanage_handle_destroy(self.sh)
> +			raise ValueError("Cannot write to policy directory.")
> +
>  		self.semanaged = semanage_is_managed(self.sh)
>  		if self.semanaged:
>  			semanage_connect(self.sh)
> 
> Particularly given that this is called from __init__, it seems like the
> check on the installed policy directory is too strong, as it could
> interfere with module store read operations.
> 

fair enough, I'll rebase a patch today with these concerns addressed

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
