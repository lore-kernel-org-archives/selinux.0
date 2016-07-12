Subject: Re: [PATCH] open_init_pty: Do not error on EINTR
To: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
References: <1467526822-19491-1-git-send-email-jason@perfinion.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <0198022e-7890-b09c-50ff-cbdffb93eac4@tycho.nsa.gov>
Date: Tue, 12 Jul 2016 15:38:01 -0400
MIME-Version: 1.0
In-Reply-To: <1467526822-19491-1-git-send-email-jason@perfinion.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On 07/03/2016 02:20 AM, Jason Zaman wrote:
> There is a signal handler so that the select returns EINTR when the
> child exits. EINTR is used to then clean up and flush the remaining
> buffers. It should not error.
> 
> Signed-off-by: Jason Zaman <jason@perfinion.com>

Thanks, applied.

> ---
>  policycoreutils/run_init/open_init_pty.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
> index 37805bf..6e25ea3 100644
> --- a/policycoreutils/run_init/open_init_pty.c
> +++ b/policycoreutils/run_init/open_init_pty.c
> @@ -327,8 +327,9 @@ int main(int argc, char *argv[])
>  			break;
>  		}
>  
> +		errno = 0;
>  		int select_rc = select(pty_master + 1, &readfds, &writefds, NULL, NULL);
> -		if (select_rc < 0) {
> +		if (select_rc < 0 && errno != EINTR) {
>  			perror("select()");
>  			exit(EX_IOERR);
>  		}
> 
