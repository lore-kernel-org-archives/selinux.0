Subject: Re: [Patch v3] sandbox: Use dbus-run-session instead of dbus-launch
 when available
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <20160927123949.24440-1-bigon@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <86f0359d-ff64-4f68-9899-c1219b30bfeb@tycho.nsa.gov>
Date: Tue, 27 Sep 2016 09:50:17 -0400
MIME-Version: 1.0
In-Reply-To: <20160927123949.24440-1-bigon@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/27/2016 08:39 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> According to dbus upstream: "dbus-launch is fairly horrible code,
> complicated by the historical need for it to support X11 autolaunching,
> so the D-Bus maintainers would like to move it out of the critical path
> and minimize its use."
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=836289
> 
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>

Thanks, applied.

> ---
>  policycoreutils/sandbox/sandbox | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
> index b6bc805..4010e83 100644
> --- a/policycoreutils/sandbox/sandbox
> +++ b/policycoreutils/sandbox/sandbox
> @@ -285,9 +285,13 @@ class Sandbox:
>  # /usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
>  %s &
>  WM_PID=$!
> -dbus-launch --exit-with-session %s
> +if which dbus-run-session >/dev/null 2>&1; then
> +    dbus-run-session -- %s
> +else
> +    dbus-launch --exit-with-session %s
> +fi
>  kill -TERM $WM_PID  2> /dev/null
> -""" % (command, wm, command))
> +""" % (command, wm, command, command))
>          fd.close()
>          os.chmod(execfile, 0o700)
>  
> 
