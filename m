Subject: Re: [PATCH 2/2] Consider role_transition for newly created files
 or dirs.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Harry Ciao <qingtao.cao@windriver.com>
Cc: cpebenito@tresys.com, selinux@tycho.nsa.gov
In-Reply-To: <1299739911-19352-3-git-send-email-qingtao.cao@windriver.com>
References: <1299739911-19352-1-git-send-email-qingtao.cao@windriver.com>
	 <1299739911-19352-3-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 10 Mar 2011 15:00:05 -0500
Message-ID: <1299787205.15531.13.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2011-03-10 at 14:51 +0800, Harry Ciao wrote:
> Consider role_transition for newly created files or dirs object, so that
> their role could be overriden by relevant role_transition rule than the
> default "object_r".
> 
> In reference policy role_transtion rule could be used for newly created
> files or dirs object as in below example:
> 	role_transition object_r $1 $2;
> where "$1" and "$2" are the domain and role of the creator respectively.

Hmm...that seems a little confusing. When we added support for range
transitions for objects, we just extended the syntax to support an
optional :class field and otherwise kept things consistent, e.g.
range_transition <subject-type> <object-type> : <object-class> <range>;
and then we converted any rules that omitted the :class into using the
process class by default.  But we didn't change the meaning of the
existing fields.  So, for example, I would have expected your role
transition statements to be of the form:
role_transition <subject-role> <file-type>:<class> <object-role>;
e.g.
role_transition sysadm_r user_home_dir_t:file sysadm_r;
meaning
"When a process in sysadm_r creates a file in a directory labeled
user_home_dir_t, label the new file with the role sysadm_r."

> 
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> ---
>  security/selinux/ss/policydb.h |    6 +++---
>  security/selinux/ss/services.c |   21 ++++++++++++++++-----
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
> index 4e3ab9d..06cef40 100644
> --- a/security/selinux/ss/policydb.h
> +++ b/security/selinux/ss/policydb.h
> @@ -71,9 +71,9 @@ struct role_datum {
>  };
>  
>  struct role_trans {
> -	u32 role;		/* current role */
> -	u32 type;		/* program executable type */
> -	u32 new_role;		/* new role */
> +	u32 role;		/* current role, or the parent dir role */
> +	u32 type;		/* program executable type, or creator domain */
> +	u32 new_role;		/* new role, or creator role */
>  	struct role_trans *next;
>  };
>  
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index bddcf30..c9bfa43 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1372,7 +1372,7 @@ static int security_compute_sid(u32 ssid,
>  	struct avtab_node *node;
>  	u16 tclass;
>  	int rc = 0;
> -	bool sock;
> +	bool sock, filedir;
>  
>  	if (!ss_initialized) {
>  		switch (orig_tclass) {
> @@ -1393,9 +1393,11 @@ static int security_compute_sid(u32 ssid,
>  	if (kern) {
>  		tclass = unmap_class(orig_tclass);
>  		sock = security_is_socket_class(orig_tclass);
> +		filedir = security_is_filedir_class(orig_tclass);
>  	} else {
>  		tclass = orig_tclass;
>  		sock = security_is_socket_class(map_class(tclass));
> +		filedir = security_is_filedir_class(map_class(tclass));
>  	}
>  
>  	scontext = sidtab_search(&sidtab, ssid);
> @@ -1432,8 +1434,13 @@ static int security_compute_sid(u32 ssid,
>  		newcontext.role = scontext->role;
>  		newcontext.type = scontext->type;
>  	} else {
> -		/* Use the well-defined object role. */
> -		newcontext.role = OBJECT_R_VAL;
> +		if (filedir == true)
> +			/* Inherit the role from the parent dir */
> +			newcontext.role = tcontext->role;
> +		else
> +			/* Use the well-defined object role. */
> +			newcontext.role = OBJECT_R_VAL;
> +
>  		/* Use the type of the related object. */
>  		newcontext.type = tcontext->type;
>  	}
> @@ -1462,13 +1469,17 @@ static int security_compute_sid(u32 ssid,
>  	}
>  
>  	/* Check for class-specific changes. */
> -	if  (tclass == policydb.process_class) {
> +	if ((tclass == policydb.process_class) || (filedir == true)) {
>  		if (specified & AVTAB_TRANSITION) {
>  			/* Look for a role transition rule. */
>  			for (roletr = policydb.role_tr; roletr;
>  			     roletr = roletr->next) {
>  				if (roletr->role == scontext->role &&
> -				    roletr->type == tcontext->type) {
> +				    roletr->type == tcontext->type &&
> +				    tclass == policydb.process_class ||
> +				    roletr->role == tcontext->role &&
> +				    roletr->type == scontext->type &&
> +				    filedir == true) {
>  					/* Use the role transition rule. */
>  					newcontext.role = roletr->new_role;
>  					break;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
