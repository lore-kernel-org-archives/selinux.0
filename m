Message-ID: <558D40FC.8060901@tycho.nsa.gov>
Date: Fri, 26 Jun 2015 08:09:32 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: Fix if file_contexts not '\n' terminated
References: <1435314596-14501-1-git-send-email-richard_c_haines@btinternet.com>
In-Reply-To: <1435314596-14501-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/26/2015 06:29 AM, Richard Haines wrote:
> If the last line of a file_contexts file is not '\n' terminated
> it failed to read the entry and gave an invalid file type error.
> read_spec_entries now handles this situation.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  libselinux/src/label_support.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
> index cf91dfa..e67d89a 100644
> --- a/libselinux/src/label_support.c
> +++ b/libselinux/src/label_support.c
> @@ -57,6 +57,11 @@ int hidden read_spec_entries(char *line_buf, int num_args, ...)
>  	len = strlen(line_buf);
>  	if (line_buf[len - 1] == '\n')
>  		line_buf[len - 1] = '\0';
> +	else
> +		/* Handle case if line not \n terminated by bumping
> +		 * the len for the check below (as the line is NUL
> +		 * terminated by getline(3)) */
> +		len++;
>  
>  	buf_p = line_buf;
>  	while (isspace(*buf_p))
> 

Hmm..seems like the problem is more general.  Try adding some trailing
whitespace to the end of a file_contexts line and you'll also encounter
the problem.
