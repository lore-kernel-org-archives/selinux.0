Message-ID: <55196496.5030107@tycho.nsa.gov>
Date: Mon, 30 Mar 2015 10:58:30 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] run_init: fix open_init_pty avaibility check
References: <1419980453-10431-1-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1419980453-10431-1-git-send-email-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/30/2014 06:00 PM, Nicolas Iooss wrote:
> If /usr/sbin/open_init_pty is not found or is not executable,
> access("/usr/sbin/open_init_pty", X_OK) returns -1, not zero.
> 
> Use "!= 0" like in other places in SELinux userland libraries and tools.
> ---
>  policycoreutils/run_init/run_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/run_init/run_init.c b/policycoreutils/run_init/run_init.c
> index 129db730a9c2..4bc32b1cbdb7 100644
> --- a/policycoreutils/run_init/run_init.c
> +++ b/policycoreutils/run_init/run_init.c
> @@ -406,7 +406,7 @@ int main(int argc, char *argv[])
>  			new_context);
>  		exit(-1);
>  	}
> -	if (! access("/usr/sbin/open_init_pty", X_OK)) {
> +	if (access("/usr/sbin/open_init_pty", X_OK) != 0) {
>  		if (execvp(argv[1], argv + 1)) {
>  			perror("execvp");
>  			exit(-1);
> 

Sorry, don't know why/how this one got lost, but applied now.
