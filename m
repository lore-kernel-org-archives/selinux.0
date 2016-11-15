Subject: Re: [PATCH 2/2] policycoreutils: Use GObject introspection binding
 instead of python-gobject in selinux_server.py
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <20161112202021.4469-1-bigon@debian.org>
 <20161112202021.4469-2-bigon@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <46a416a9-5847-bf74-07c0-dd6d23bbb05d@tycho.nsa.gov>
Date: Tue, 15 Nov 2016 10:57:03 -0500
MIME-Version: 1.0
In-Reply-To: <20161112202021.4469-2-bigon@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/12/2016 03:20 PM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> Signed-off-by: Laurent Bigonville <bigon@bigon.be>

Thanks, applied both patches.

> ---
>  policycoreutils/sepolicy/selinux_server.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/policycoreutils/sepolicy/selinux_server.py b/policycoreutils/sepolicy/selinux_server.py
> index cdf4d16..8bd1fe5 100644
> --- a/policycoreutils/sepolicy/selinux_server.py
> +++ b/policycoreutils/sepolicy/selinux_server.py
> @@ -3,7 +3,7 @@
>  import dbus
>  import dbus.service
>  import dbus.mainloop.glib
> -import gobject
> +from gi.repository import GObject
>  import slip.dbus.service
>  from slip.dbus import polkit
>  import os
> @@ -128,7 +128,7 @@ class selinux_server(slip.dbus.service.Object):
>          raise ValueError("%s does not exist" % path)
>  
>  if __name__ == "__main__":
> -    mainloop = gobject.MainLoop()
> +    mainloop = GObject.MainLoop()
>      dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
>      system_bus = dbus.SystemBus()
>      name = dbus.service.BusName("org.selinux", system_bus)
> 
