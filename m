Subject: Re: [PATCH 1/1] checkpolicy: dereference rangehead after checking it
 was not NULL
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170317221003.18666-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <47cadc34-4422-85c7-0b8a-f34a8beddc38@tycho.nsa.gov>
Date: Tue, 21 Mar 2017 14:29:02 -0400
MIME-Version: 1.0
In-Reply-To: <20170317221003.18666-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/17/2017 06:10 PM, Nicolas Iooss wrote:
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,
Jim

> ---
>  checkpolicy/policy_define.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index dbafadb01e21..949ca7117233 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1924,11 +1924,11 @@ int avrule_ioctl_ranges(struct av_ioctl_range_list **rangelist)
>  	/* read in ranges to include and omit */
>  	if (avrule_read_ioctls(&rangehead))
>  		return -1;
> -	omit = rangehead->omit;
>  	if (rangehead == NULL) {
>  		yyerror("error processing ioctl commands");
>  		return -1;
>  	}
> +	omit = rangehead->omit;
>  	/* sort and merge the input ioctls */
>  	if (avrule_sort_ioctls(&rangehead))
>  		return -1;
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
