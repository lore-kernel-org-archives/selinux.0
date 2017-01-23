Subject: Re: [PATCH 1/4] checkpolicy: always free id in define_type()
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170121142613.12375-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <b0aff308-4732-75f5-1ced-ed15285378f4@tycho.nsa.gov>
Date: Mon, 23 Jan 2017 11:44:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170121142613.12375-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/21/2017 09:26 AM, Nicolas Iooss wrote:
> In function define_type(), some error conditions between "id =
> queue_remove(id_queue)" and "get_local_type(id, attr->s.value, 1)"
> returned without freeing id. Fix theses memory leaks.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I applied all four of these.

Thanks,
Jim

> ---
>  checkpolicy/policy_define.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 6bfadbe59c91..03a0c18a9686 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1426,11 +1426,13 @@ int define_type(int alias)
>  		if (!attr) {
>  			/* treat it as a fatal error */
>  			yyerror2("attribute %s is not declared", id);
> +			free(id);
>  			return -1;
>  		}
>
>  		if (attr->flavor != TYPE_ATTRIB) {
>  			yyerror2("%s is a type, not an attribute", id);
> +			free(id);
>  			return -1;
>  		}
>
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
