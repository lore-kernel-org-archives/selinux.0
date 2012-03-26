Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QEsPwY003586
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 10:54:28 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Laurent Bigonville <bigon@debian.org>
Subject: Re: [PATCH 2/4] libsemanage -- max-uid
Date: Tue, 27 Mar 2012 01:54:23 +1100
Cc: selinux@tycho.nsa.gov
References: <20120326155843.4c834941@eldamar.bigon.be>
In-Reply-To: <20120326155843.4c834941@eldamar.bigon.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201203270154.23364.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 27 Mar 2012, Laurent Bigonville <bigon@debian.org> wrote:
> Again no rational and not original author

Changing "u" to "the_user" makes the code easier to read and search.

I'm not sure why we are implementing a maxuid check, it seems that in recent 
times support for larger uids has become more common so it might be worth 
removing that.

> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -283,8 +283,8 @@
>  	char *rbuf = NULL;
>  	char *path = NULL;
>  	long rbuflen;
> -	uid_t temp, minuid = 0;
> -	int minuid_set = 0;
> +	uid_t temp, minuid = 0, maxuid = 0;
> +	int minuid_set = 0, maxuid_set = 0;
>  	struct passwd pwstorage, *pwbuf;
>  	struct stat buf;
>  	int retval;
> @@ -334,6 +334,16 @@
>  	}
>  	free(path);
>  	path = NULL;
> +	path = semanage_findval(PATH_ETC_LOGIN_DEFS, "UID_MAX", NULL);
> +	if (path && *path) {
> +		temp = atoi(path);
> +		if (!maxuid_set || temp > maxuid) {
> +			maxuid = temp;
> +			maxuid_set = 1;
> +		}
> +	}
> +	free(path);
> +	path = NULL;
> 
>  	path = semanage_findval(PATH_ETC_LIBUSER, "LU_UIDNUMBER", "=");
>  	if (path && *path) {
> @@ -350,6 +360,10 @@
>  		minuid = 500;
>  		minuid_set = 1;
>  	}
> +	if (!maxuid_set) {
> +		maxuid = 60000;
> +		maxuid_set = 1;
> +	}
> 
>  	rbuflen = sysconf(_SC_GETPW_R_SIZE_MAX);
>  	if (rbuflen <= 0)
> @@ -359,7 +373,7 @@
>  		goto fail;
>  	setpwent();
>  	while ((retval = getpwent_r(&pwstorage, rbuf, rbuflen, &pwbuf)) == 0) 
{
> -		if (pwbuf->pw_uid < minuid)
> +		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
>  			continue;
>  		if (!semanage_list_find(shells, pwbuf->pw_shell))
>  			continue;
> @@ -392,7 +406,7 @@
> 
>  			/* NOTE: old genhomedircon printed a warning on match 
*/
>  			if (hand.matched) {
> -				WARN(s->h_semanage, "%s homedir %s or its 
parent directory conflicts
> with a file context already specified in the policy.  This usually
> indicates an incorrectly defined system account.  If it is a system
> account please make sure its uid is less than %u or its login shell is
> /sbin/nologin.", pwbuf->pw_name, pwbuf->pw_dir, minuid);
> +				WARN(s->h_semanage, "%s homedir %s or its 
parent directory conflicts
> with a file context already specified in the policy.  This usually
> indicates an incorrectly defined system account.  If it is a system
> account please make sure its uid is less than %u or greater than %u or its
> login shell is /sbin/nologin.", pwbuf->pw_name, pwbuf->pw_dir, minuid,
> maxuid); } else {
>  				if (semanage_list_push(&homedir_list, path))
>  					goto fail;
> @@ -743,7 +757,7 @@
>  	semanage_seuser_t **seuser_list = NULL;
>  	unsigned int nseusers = 0;
>  	semanage_user_key_t *key = NULL;
> -	semanage_user_t *u = NULL;
> +	semanage_user_t *the_user = NULL;
>  	const char *name = NULL;
>  	const char *seuname = NULL;
>  	const char *prefix = NULL;
> @@ -769,22 +783,22 @@
>  				errors = STATUS_ERR;
>  				break;
>  			}
> -			if (semanage_user_query(s->h_semanage, key, &u) < 0)
> +			if (semanage_user_query(s->h_semanage, key, &the_user) 
< 0)
>  			{
>  				prefix = name;
>  				level = "s0";
>  			}
>  			else
>  			{
> -				prefix = semanage_user_get_prefix(u);
> -				level = semanage_user_get_mlslevel(u);
> +				prefix = semanage_user_get_prefix(the_user);
> +				level = semanage_user_get_mlslevel(the_user);
>  			}
> 
>  			if (set_fallback_user(s, seuname, prefix, level) != 0)
>  				errors = STATUS_ERR;
>  			semanage_user_key_free(key);
> -			if (u)
> -				semanage_user_free(u);
> +			if (the_user)
> +				semanage_user_free(the_user);
>  			break;
>  		}
>  	}
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with the words "unsubscribe selinux" without quotes as the message.


-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
