Subject: Re: [PATCH v2] Build the SELinux testsuite on systems using the
 Reference Policy
To: Guido Trentalancia <guido@trentalancia.net>, selinux@tycho.nsa.gov
References: <1472042396.4446.4.camel@trentalancia.net>
 <1472047913.4446.7.camel@trentalancia.net>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ea82b422-2aa4-9bbb-dc56-d1cfb05bff20@tycho.nsa.gov>
Date: Fri, 26 Aug 2016 13:06:41 -0400
MIME-Version: 1.0
In-Reply-To: <1472047913.4446.7.camel@trentalancia.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/24/2016 10:11 AM, Guido Trentalancia wrote:
> Fix the Makefile in the policy subdirectory of the SELinux testsuite
> so that it builds correctly on the standard Reference Policy which
> does not have the same booleans available on Red Hat.
> 
> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
> ---
>  policy/Makefile |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- selinux-testsuite-git-23082016-orig/policy/Makefile	2016-08-23 20:50:08.527633728 +0200
> +++ selinux-testsuite-git-23082016/policy/Makefile	2016-08-24 14:38:08.987455031 +0200
> @@ -68,7 +68,7 @@ load_rhel: all
>  
>  load_general: all
>  	# General policy load
> -	/usr/sbin/setsebool allow_domain_fd_use=0
> +	/usr/sbin/getsebool -a | grep -q allow_domain_fd_use && /usr/sbin/setsebool allow_domain_fd_use=0 || :
>  	$(SEMODULE) -i test_policy/test_policy.pp

Just test the result of getsebool allow_domain_fd_use.
No need to dump them all and grep for the one you want.
Also, the above didn't work anyway on Fedora because the boolean has
been renamed and getsebool -a lists the new names (the old names can
still be passed to getsebool and setsebool because of the
booleans.subs_dist mapping).

>  
>  unload_rhel:
> @@ -77,7 +77,7 @@ unload_rhel:
>  
>  unload_general:
>  	# General policy unload
> -	/usr/sbin/setsebool allow_domain_fd_use=1
> +	/usr/sbin/getsebool -a | grep -q allow_domain_fd_use && /usr/sbin/setsebool allow_domain_fd_use=1 || :
>  	$(SEMODULE) -r test_policy
>  
>  clean:
