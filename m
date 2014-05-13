Message-ID: <537232A0.5080506@tycho.nsa.gov>
Date: Tue, 13 May 2014 10:56:32 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Will Woods <wwoods@redhat.com>, selinux@tycho.nsa.gov,
 Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] selinux_init_load_policy: setenforce(0) if
 security_disable() fails
References: <1398787174-20523-1-git-send-email-wwoods@redhat.com>
In-Reply-To: <1398787174-20523-1-git-send-email-wwoods@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/29/2014 11:59 AM, Will Woods wrote:
> If you run selinux_init_load_policy() after a chroot/switch-root, it's
> possible that your *previous* root loaded policy, but your *new* root
> wants SELinux disabled.
> 
> We can't disable SELinux in this case, but we *do* need to make sure
> it's permissive. Otherwise we may continue to enforce the old policy.
> 
> So, if seconfig = -1, but security_disable() fails, we set *enforce=0,
> and then let the existing code handle the security_{get,set}enforce
> stuff.
> 
> Once that's handled, exit with failure via "goto noload", as before.
> ---
>  libselinux/src/load_policy.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
> index e419f1a..21ee58b 100644
> --- a/libselinux/src/load_policy.c
> +++ b/libselinux/src/load_policy.c
> @@ -417,13 +417,15 @@ int selinux_init_load_policy(int *enforce)
>  			/* Successfully disabled, so umount selinuxfs too. */
>  			umount(selinux_mnt);
>  			fini_selinuxmnt();
> +			goto noload;
> +		} else {
> +			/*
> +			 * It's possible that this failed because policy has
> +			 * already been loaded. We can't disable SELinux now,
> +			 * so the best we can do is force it to be permissive.
> +			 */
> +			*enforce = 0;
>  		}
> -		/*
> -		 * If we failed to disable, SELinux will still be 
> -		 * effectively permissive, because no policy is loaded. 
> -		 * No need to call security_setenforce(0) here.
> -		 */
> -		goto noload;
>  	}
>  
>  	/*
> @@ -442,6 +444,9 @@ int selinux_init_load_policy(int *enforce)
>  		}
>  	}
>  
> +	if (seconfig == -1)
> +		goto noload;
> +
>  	/* Load the policy. */
>  	return selinux_mkload_policy(0);

Applied on #next, will be in libselinux 2.4.
