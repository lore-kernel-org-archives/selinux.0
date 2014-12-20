Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBKEJm3J027224
 for <selinux@tycho.nsa.gov>; Sat, 20 Dec 2014 09:19:53 -0500
Message-ID: <54958580.9090708@m4x.org>
Date: Sat, 20 Dec 2014 15:19:44 +0100
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
To: selinux@tycho.nsa.gov, Jason Zaman <jason@perfinion.com>
Subject: Re: [PATCH] run_init: Use a ring buffer in open_init_pty
References: <1419081017-20565-1-git-send-email-jason@perfinion.com>
In-Reply-To: <1419081017-20565-1-git-send-email-jason@perfinion.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2014-12-20 14:10 GMT+01:00 Jason Zaman:
> open_init_pty uses select() to handle all the file descriptors. There is
> a very high CPU usage due to select() always returning immediately with
> the fd is available for write. This uses a ring buffer and only calls
> select on the read/write fds that have data that needs to be
> read/written which eliminates the high CPU usage.
> 
> This also correctly returns the exit code from the child process.
> 
> This was originally from debian where they have been carrying it as a
> patch for a long time. Then we got a bug report in gentoo which this
> also happens to fix. The original debian patch had the ring buffer
> written in C++ so I modified the class into a struct and some static
> methods so it is C-only at the request of Steve Lawrence.
> 
> Debian bug: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=474956
> Gentoo bug: https://bugs.gentoo.org/show_bug.cgi?id=532616
> 
> Signed-off-by: Jason Zaman <jason@perfinion.com>
> Tested-by: Laurent Bigonville <bigon@bigon.be>
> ---
>  policycoreutils/run_init/open_init_pty.c | 511 ++++++++++++++++---------------
>  1 file changed, 265 insertions(+), 246 deletions(-)
> 
> diff --git a/policycoreutils/run_init/open_init_pty.c b/policycoreutils/run_init/open_init_pty.c
> index 4f04e72..fb428a3 100644
> [SNIP]
> +static void setfd_nonblock(int fd)
> +{
> +	int fsflags = fcntl(fd, F_GETFL);
> +
> +	if (fsflags < 0) {
> +		fprintf(stderr, "fcntl(%d, F_GETFL): %s\n", fd, strerror(errno));
> +		exit(EX_IOERR);
> +	}
> +
> +	if (fcntl(STDIN_FILENO, F_SETFL, fsflags | O_NONBLOCK) < 0) {
> +		fprintf(stderr, "fcntl(%d, F_SETFL, ... | O_NONBLOCK): %s\n", fd, strerror(errno));
> +		exit(EX_IOERR);
> +	}
> +}

Why does the second fcntl use STDIN_FILENO instead of fd?

> +
> +static void sigchld_handler(int asig __attribute__ ((unused)))
> +{
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	pid_t child_pid;
> [SNIP]
>  
> -	if (isatty(fileno(stdin))) {
> +	if (isatty(STDIN_FILENO)) {
>  		/* get terminal parameters associated with stdout */
> -		if (tcgetattr(fileno(stdout), &tty_attr) < 0) {
> -			perror("tcgetattr:");
> +		if (tcgetattr(STDOUT_FILENO, &tty_attr) < 0) {
> +			perror("tcgetattr(stdout,...)");
>  			exit(EX_OSERR);
>  		}
>  
> -		/* end of if(tcsetattr(&tty_attr)) */
>  		/* get window size */
> -		if (ioctl(fileno(stdout), TIOCGWINSZ, &window_size) < 0) {
> -			perror("ioctl stdout:");
> +		if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &window_size) < 0) {
> +			perror("ioctl(stdout,...)");
>  			exit(1);
>  		}

Here, it seems quite weird to check whether stdin is a tty and then use
tcgetattr on stdout.  As this behavior was in the initial code I
understand that this patch doesn't change it.  For curiosity, can this
program happen to be called with stdin from a file but not stdout, or
the other way round?

>  
>  		child_pid = forkpty(&pty_master, NULL, &tty_attr, &window_size);
> -	} /* end of if(isatty(fileno(stdin))) */
> -	else {			/* not interactive */
> +	} else { /* not interactive */
>  		child_pid = forkpty(&pty_master, NULL, NULL, NULL);
>  	}
> [SNIP]
>  
> -		}		/* end of else */
> -
> -		if (select
> -		    (pty_master + 1, &t_readfds, &t_writefds, &t_exceptfds,
> -		     &interval) < 0) {
> -			perror("Select:");
> -			fflush(stdout);
> -			fflush(stderr);
> +			break;
> +		}
> +
> +		int select_rc = select(pty_master + 1, &readfds, &writefds, NULL, NULL);
> +		if (select_rc < 0) {
> +			perror("select()");
>  			exit(EX_IOERR);
>  		}

I get this error, with my custom CFLAGS:

open_init_pty.c: In function 'main':
open_init_pty.c:330:3: error: ISO C90 forbids mixed declarations and
code [-Werror=pedantic]
   int select_rc = select(pty_master + 1, &readfds, &writefds, NULL, NULL);
   ^

I don't know what C specification follows SELinux userspace code but
there is a potential minor coding convention issue here.  Feel free to
ignore this comment if this coding style (of not moving declarations to
the beginning of functions) is ok.



Otherwise the patch looks good to me.  I have not tested it as I'm using
systemd on my systems running SELinux and I believe it does not use
open_init_pty.

Cheers,

Nicolas
