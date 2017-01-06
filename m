Subject: Re: [PATCH 1/2] libsemanage: genhomedircon: remove duplicated test
 condition
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170104214623.24674-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <d8a84f18-ba5a-298b-2751-b236cc14cc2b@tycho.nsa.gov>
Date: Fri, 6 Jan 2017 14:31:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170104214623.24674-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/04/2017 04:46 PM, Nicolas Iooss wrote:
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,

> ---
>  libsemanage/src/genhomedircon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
> index 7ceeafb7b5d9..fd6d391984b6 100644
> --- a/libsemanage/src/genhomedircon.c
> +++ b/libsemanage/src/genhomedircon.c
> @@ -246,7 +246,7 @@ static int fcontext_matches(const semanage_fcontext_t *fcontext, void *varg)
>
>  	/* Only match ALL or DIR */
>  	type = semanage_fcontext_get_type(fcontext);
> -	if (type != SEMANAGE_FCONTEXT_ALL && type != SEMANAGE_FCONTEXT_ALL)
> +	if (type != SEMANAGE_FCONTEXT_ALL)
>  		return 0;
>
>  	len = strlen(oexpr);
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
