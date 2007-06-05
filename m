Subject: Re: [PATCH] libselinux: set errno in string functions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4660A986.3040701@tycho.nsa.gov>
References: <4660A986.3040701@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 09:26:22 -0400
Message-Id: <1181049982.25769.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-06-01 at 19:19 -0400, Eamon Walsh wrote:
> Set errno to EINVAL in string functions on bad input.
> 
> Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Merge at will.

> 
> ---
> 
>  stringrep.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> 
> --- libselinux/src/stringrep.c	2007-06-01 16:05:26.000000000 -0400
> +++ libselinux/src/stringrep.c	2007-06-01 15:50:52.000000000 -0400
> @@ -160,6 +160,7 @@
>  		}
>  	}
>  
> +	errno = EINVAL;
>  	return 0;
>  }
>  
> @@ -197,13 +198,17 @@
>  			return av_perm_to_string[i].value;
>  	}
>  
> +	errno = EINVAL;
>  	return 0;
>  }
>  
>  const char *security_class_to_string(security_class_t tclass)
>  {
> -	tclass = (tclass > 0 && tclass < NCLASSES) ? tclass : 0;
> -	return class_to_string_data.str + class_to_string[tclass];
> +	if (tclass > 0 && tclass < NCLASSES)
> +		return class_to_string_data.str + class_to_string[tclass];
> +
> +	errno = EINVAL;
> +	return NULL;
>  }
>  
>  const char *security_av_perm_to_string(security_class_t tclass,
> @@ -242,6 +247,7 @@
>  				+ av_perm_to_string[i].nameidx;
>  	}
>  
> +	errno = EINVAL;
>  	return NULL;
>  }
>  
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
