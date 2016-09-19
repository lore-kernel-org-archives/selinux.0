Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8JCW91e011610
 for <selinux@tycho.nsa.gov>; Mon, 19 Sep 2016 08:32:09 -0400
Subject: Re: [PATCH] sandbox: Use dbus-launch instead of dbus-run-session
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <20160918223226.23000-1-bigon@debian.org>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <dd210548-2467-f538-cdc5-93bfb566ac16@redhat.com>
Date: Mon, 19 Sep 2016 14:31:35 +0200
MIME-Version: 1.0
In-Reply-To: <20160918223226.23000-1-bigon@debian.org>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/19/2016 12:32 AM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> According to dbus upstream: "dbus-launch is fairly horrible code,
> complicated by the historical need for it to support X11 autolaunching,
> so the D-Bus maintainers would like to move it out of the critical path
> and minimize its use."
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=836289

dbus-run-session was introduced in dbus-1.8.0. This change would break
systems with older dbus, e.g., rhel-7 ships dbus-1.6.12.

Would it make sense to do a test whether dbus-run-session is available
or not?

Petr

> ---
>  policycoreutils/sandbox/sandbox | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
> index 726ba9b..f537dc6 100644
> --- a/policycoreutils/sandbox/sandbox
> +++ b/policycoreutils/sandbox/sandbox
> @@ -285,7 +285,7 @@ class Sandbox:
>  /usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
>  %s &
>  WM_PID=$!
> -dbus-launch --exit-with-session %s
> +dbus-run-session -- %s
>  kill -TERM $WM_PID  2> /dev/null
>  """ % (command, wm, command))
>          fd.close()
> 
