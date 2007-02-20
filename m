Subject: Re: PATCH: setfiles memory leak
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Todd.Miller@sparta.com
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200702071709.l17H9ute004872@tex.courtesan.com>
References: <200702071709.l17H9ute004872@tex.courtesan.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:28:38 -0500
Message-Id: <1171985318.14363.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-07 at 12:09 -0500, Todd.Miller@sparta.com wrote:
> This patch fixes a memory leak on an error path.
> 
>  - todd
> 
> --- policycoreutils-1.34.1/setfiles/setfiles.c	2006-06-29 14:21:16.000000000 -0400
> +++ policycoreutils-1.34.1/setfiles/setfiles.c	2007-02-06 17:00:19.000000000 -0500
> @@ -357,6 +357,7 @@
>  				"%s: %s not reset customized by admin to %s\n",
>  				progname, my_file, context);
>  		}
> +		freecon(context);
>  		goto out;
>  	}
>  

Merged to -stable and to -trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
