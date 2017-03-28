Subject: Re: [PATCH 1/3] policycoreutils/setfiles: stdout messages don't need
 program prefix
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>, selinux@tycho.nsa.gov
References: <20170326162245.21135-1-alan.christopher.jenkins@gmail.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <f3acd6fd-3ead-df17-2d0b-d7184949ce09@tycho.nsa.gov>
Date: Tue, 28 Mar 2017 15:56:06 -0400
MIME-Version: 1.0
In-Reply-To: <20170326162245.21135-1-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/26/2017 12:22 PM, Alan Jenkins wrote:
> I suggested that if you run a command for its informational output (by
> passing  `-v`), you don't expect it to be prefixed with the program name.
> Prefixing is used for error messages, so you can tell where your shell
> script blew up :).  If a script is running a command for its informational
> output, it's usually the script's responsibility to make sure it's in
> context, e.g. providing headers if there are multiple sections of output.
>
> Removing the program name from setfiles/restorecon output is particularly
> useful because it generates very long lines.  But also, it actually helps
> highlight where there are error messages - the prefix will make them
> stand out visually.
>
> Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>

All three of these have been applied.

Thanks,
Jim

> ---
>  policycoreutils/setfiles/setfiles.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
> index 6f69c90..83e0b2a 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -142,9 +142,15 @@ static int __attribute__ ((format(printf, 2, 3)))
>  log_callback(int type, const char *fmt, ...)
>  {
>  	int rc;
> -	FILE *out = (type == SELINUX_INFO) ? stdout : stderr;
> +	FILE *out;
>  	va_list ap;
> -	fprintf(out, "%s: ", r_opts.progname);
> +
> +	if (type == SELINUX_INFO) {
> +		out = stdout;
> +	} else {
> +		out = stderr;
> +		fprintf(out, "%s: ", r_opts.progname);
> +	}
>  	va_start(ap, fmt);
>  	rc = vfprintf(out, fmt, ap);
>  	va_end(ap);
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
