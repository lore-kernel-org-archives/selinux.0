Subject: Re: [PATCH v4] Build the SELinux testsuite on systems using the
 Reference Policy
To: Guido Trentalancia <guido@trentalancia.net>, selinux@tycho.nsa.gov
References: <1472042396.4446.4.camel@trentalancia.net>
 <1472047913.4446.7.camel@trentalancia.net>
 <ea82b422-2aa4-9bbb-dc56-d1cfb05bff20@tycho.nsa.gov>
 <1472233238.14055.0.camel@trentalancia.net>
 <0957f1f6-2687-6dd0-b42d-e92f6d5ce21b@tycho.nsa.gov>
 <1472233820.14055.1.camel@trentalancia.net>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1ad0ffb1-fccf-d024-7bc1-62cfc4adc97b@tycho.nsa.gov>
Date: Fri, 26 Aug 2016 13:58:03 -0400
MIME-Version: 1.0
In-Reply-To: <1472233820.14055.1.camel@trentalancia.net>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/26/2016 01:50 PM, Guido Trentalancia wrote:
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
> +++ selinux-testsuite-git-23082016/policy/Makefile	2016-08-26 19:37:13.195088500 +0200
> @@ -68,7 +69,7 @@ load_rhel: all
>  
>  load_general: all
>  	# General policy load
> -	/usr/sbin/setsebool allow_domain_fd_use=0
> +	/usr/sbin/getsebool allow_domain_fd_use > /dev/null 2&>1 && /usr/sbin/setsebool allow_domain_fd_use=0 || :

Hmm...doesn't seem to be executing the setsebool command now; boolean is
left unchanged and the corresponding tests fail.

>  	$(SEMODULE) -i test_policy/test_policy.pp
>  
>  unload_rhel:
> @@ -77,7 +78,7 @@ unload_rhel:
>  
>  unload_general:
>  	# General policy unload
> -	/usr/sbin/setsebool allow_domain_fd_use=1
> +	/usr/sbin/getsebool allow_domain_fd_use > /dev/null 2&>1 && /usr/sbin/setsebool allow_domain_fd_use=1 || :
>  	$(SEMODULE) -r test_policy
>  
>  clean:
> 
