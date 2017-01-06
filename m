Subject: Re: [PATCH 2/5] checkpolicy: free id in define_port_context()
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161226211832.7165-1-nicolas.iooss@m4x.org>
 <20161226211832.7165-2-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <86157859-8fe7-5f50-1f69-34059034fed6@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:26:25 -0500
MIME-Version: 1.0
In-Reply-To: <20161226211832.7165-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/26/2016 04:18 PM, Nicolas Iooss wrote:
> Variable id is almost never freed in define_port_context().
>
> This leak has been detected with gcc Address Sanitizer.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  checkpolicy/policy_define.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 2ad98c3c851e..ff902787c2aa 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -4899,6 +4899,7 @@ int define_port_context(unsigned int low, unsigned int high)
>  		protocol = IPPROTO_DCCP;
>  	} else {
>  		yyerror2("unrecognized protocol %s", id);
> +		free(id);
>  		free(newc);
>  		return -1;
>  	}
> @@ -4909,11 +4910,13 @@ int define_port_context(unsigned int low, unsigned int high)
>
>  	if (low > high) {
>  		yyerror2("low port %d exceeds high port %d", low, high);
> +		free(id);
>  		free(newc);
>  		return -1;
>  	}
>
>  	if (parse_security_context(&newc->context[0])) {
> +		free(id);
>  		free(newc);
>  		return -1;
>  	}

Applied, but for the three above I changed it to "goto bad;" which has both 
frees and returns -1.

Thanks,

> @@ -4945,9 +4948,11 @@ int define_port_context(unsigned int low, unsigned int high)
>  	else
>  		policydbp->ocontexts[OCON_PORT] = newc;
>
> +	free(id);
>  	return 0;
>
>        bad:
> +	free(id);
>  	free(newc);
>  	return -1;
>  }
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
