Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s631vOtv026931
 for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2014 21:57:24 -0400
Received: by mail-ob0-f170.google.com with SMTP id uz6so13164102obc.15
 for <selinux@tycho.nsa.gov>; Wed, 02 Jul 2014 18:57:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140627204142.4730.96332.stgit@localhost>
References: <20140627204142.4730.96332.stgit@localhost>
Date: Thu, 3 Jul 2014 10:57:23 +0900
Message-ID: <CAEFn6A7X5Gfjb=Kf8gHZmraVJCx+gzKKx0akXe90k6dFkaONNw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: reduce the number of calls to
 synchronize_net() when flushing caches
From: Jaejyn Shin <flagon22bass@gmail.com>
To: Paul Moore <pmoore@redhat.com>
Content-Type: multipart/alternative; boundary=001a11330d687cdfe004fd405491
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11330d687cdfe004fd405491
Content-Type: text/plain; charset=UTF-8

Thank you for your effort !!

The booting time might not be a problem for other people, but it was a
serious problem for me.

Thank you~
Best regards


2014-06-28 5:41 GMT+09:00 Paul Moore <pmoore@redhat.com>:

> When flushing the AVC, such as during a policy load, the various
> network caches are also flushed, with each making a call to
> synchronize_net() which has shown to be expensive in some cases.
> This patch consolidates the network cache flushes into a single AVC
> callback which only calls synchronize_net() once for each AVC cache
> flush.
>
> Reported-by: Jaejyn Shin <flagon22bass@gmail.com>
> Signed-off-by: Paul Moore <pmoore@redhat.com>
> ---
>  security/selinux/hooks.c           |   14 ++++++++++++++
>  security/selinux/include/netif.h   |    2 ++
>  security/selinux/include/netnode.h |    2 ++
>  security/selinux/include/netport.h |    2 ++
>  security/selinux/netif.c           |   15 +--------------
>  security/selinux/netnode.c         |   15 +--------------
>  security/selinux/netport.c         |   15 +--------------
>  7 files changed, 23 insertions(+), 42 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 336f0a0..39bc8c9 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -161,6 +161,17 @@ static int selinux_peerlbl_enabled(void)
>         return (selinux_policycap_alwaysnetwork || netlbl_enabled() ||
> selinux_xfrm_enabled());
>  }
>
> +static int selinux_netcache_avc_callback(u32 event)
> +{
> +       if (event == AVC_CALLBACK_RESET) {
> +               sel_netif_flush();
> +               sel_netnode_flush();
> +               sel_netport_flush();
> +               synchronize_net();
> +       }
> +       return 0;
> +}
> +
>  /*
>   * initialise the security for the init task
>   */
> @@ -5993,6 +6004,9 @@ static __init int selinux_init(void)
>         if (register_security(&selinux_ops))
>                 panic("SELinux: Unable to register with kernel.\n");
>
> +       if (avc_add_callback(selinux_netcache_avc_callback,
> AVC_CALLBACK_RESET))
> +               panic("SELinux: Unable to register AVC netcache
> callback\n");
> +
>         if (selinux_enforcing)
>                 printk(KERN_DEBUG "SELinux:  Starting in enforcing
> mode\n");
>         else
> diff --git a/security/selinux/include/netif.h
> b/security/selinux/include/netif.h
> index 43d5072..57c6eae 100644
> --- a/security/selinux/include/netif.h
> +++ b/security/selinux/include/netif.h
> @@ -17,6 +17,8 @@
>  #ifndef _SELINUX_NETIF_H_
>  #define _SELINUX_NETIF_H_
>
> +void sel_netif_flush(void);
> +
>  int sel_netif_sid(int ifindex, u32 *sid);
>
>  #endif /* _SELINUX_NETIF_H_ */
> diff --git a/security/selinux/include/netnode.h
> b/security/selinux/include/netnode.h
> index df7a5ed..937668d 100644
> --- a/security/selinux/include/netnode.h
> +++ b/security/selinux/include/netnode.h
> @@ -27,6 +27,8 @@
>  #ifndef _SELINUX_NETNODE_H
>  #define _SELINUX_NETNODE_H
>
> +void sel_netnode_flush(void);
> +
>  int sel_netnode_sid(void *addr, u16 family, u32 *sid);
>
>  #endif
> diff --git a/security/selinux/include/netport.h
> b/security/selinux/include/netport.h
> index 4d965b8..d1ce896 100644
> --- a/security/selinux/include/netport.h
> +++ b/security/selinux/include/netport.h
> @@ -26,6 +26,8 @@
>  #ifndef _SELINUX_NETPORT_H
>  #define _SELINUX_NETPORT_H
>
> +void sel_netport_flush(void);
> +
>  int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid);
>
>  #endif
> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> index 694e9e4..3c3de4c 100644
> --- a/security/selinux/netif.c
> +++ b/security/selinux/netif.c
> @@ -240,7 +240,7 @@ static void sel_netif_kill(int ifindex)
>   * Remove all entries from the network interface table.
>   *
>   */
> -static void sel_netif_flush(void)
> +void sel_netif_flush(void)
>  {
>         int idx;
>         struct sel_netif *netif;
> @@ -252,15 +252,6 @@ static void sel_netif_flush(void)
>         spin_unlock_bh(&sel_netif_lock);
>  }
>
> -static int sel_netif_avc_callback(u32 event)
> -{
> -       if (event == AVC_CALLBACK_RESET) {
> -               sel_netif_flush();
> -               synchronize_net();
> -       }
> -       return 0;
> -}
> -
>  static int sel_netif_netdev_notifier_handler(struct notifier_block *this,
>                                              unsigned long event, void
> *ptr)
>  {
> @@ -291,10 +282,6 @@ static __init int sel_netif_init(void)
>
>         register_netdevice_notifier(&sel_netif_netdev_notifier);
>
> -       err = avc_add_callback(sel_netif_avc_callback, AVC_CALLBACK_RESET);
> -       if (err)
> -               panic("avc_add_callback() failed, error %d\n", err);
> -
>         return err;
>  }
>
> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 03a72c3..ddf3152 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -283,7 +283,7 @@ int sel_netnode_sid(void *addr, u16 family, u32 *sid)
>   * Remove all entries from the network address table.
>   *
>   */
> -static void sel_netnode_flush(void)
> +void sel_netnode_flush(void)
>  {
>         unsigned int idx;
>         struct sel_netnode *node, *node_tmp;
> @@ -300,15 +300,6 @@ static void sel_netnode_flush(void)
>         spin_unlock_bh(&sel_netnode_lock);
>  }
>
> -static int sel_netnode_avc_callback(u32 event)
> -{
> -       if (event == AVC_CALLBACK_RESET) {
> -               sel_netnode_flush();
> -               synchronize_net();
> -       }
> -       return 0;
> -}
> -
>  static __init int sel_netnode_init(void)
>  {
>         int iter;
> @@ -322,10 +313,6 @@ static __init int sel_netnode_init(void)
>                 sel_netnode_hash[iter].size = 0;
>         }
>
> -       ret = avc_add_callback(sel_netnode_avc_callback,
> AVC_CALLBACK_RESET);
> -       if (ret != 0)
> -               panic("avc_add_callback() failed, error %d\n", ret);
> -
>         return ret;
>  }
>
> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index d353797..73ac678 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -217,7 +217,7 @@ int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid)
>   * Remove all entries from the network address table.
>   *
>   */
> -static void sel_netport_flush(void)
> +void sel_netport_flush(void)
>  {
>         unsigned int idx;
>         struct sel_netport *port, *port_tmp;
> @@ -234,15 +234,6 @@ static void sel_netport_flush(void)
>         spin_unlock_bh(&sel_netport_lock);
>  }
>
> -static int sel_netport_avc_callback(u32 event)
> -{
> -       if (event == AVC_CALLBACK_RESET) {
> -               sel_netport_flush();
> -               synchronize_net();
> -       }
> -       return 0;
> -}
> -
>  static __init int sel_netport_init(void)
>  {
>         int iter;
> @@ -256,10 +247,6 @@ static __init int sel_netport_init(void)
>                 sel_netport_hash[iter].size = 0;
>         }
>
> -       ret = avc_add_callback(sel_netport_avc_callback,
> AVC_CALLBACK_RESET);
> -       if (ret != 0)
> -               panic("avc_add_callback() failed, error %d\n", ret);
> -
>         return ret;
>  }
>
>
>

--001a11330d687cdfe004fd405491
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you for your effort !!<div><br><div>The booting time=
 might not be a problem for other people, but it was a serious problem for =
me.</div><div><br></div><div>Thank you~</div><div>Best regards</div><div cl=
ass=3D"gmail_extra">
<br><br><div class=3D"gmail_quote">2014-06-28 5:41 GMT+09:00 Paul Moore <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:pmoore@redhat.com" target=3D"_blank">p=
moore@redhat.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">
When flushing the AVC, such as during a policy load, the various<br>
network caches are also flushed, with each making a call to<br>
synchronize_net() which has shown to be expensive in some cases.<br>
This patch consolidates the network cache flushes into a single AVC<br>
callback which only calls synchronize_net() once for each AVC cache<br>
flush.<br>
<br>
Reported-by: Jaejyn Shin &lt;<a href=3D"mailto:flagon22bass@gmail.com">flag=
on22bass@gmail.com</a>&gt;<br>
Signed-off-by: Paul Moore &lt;<a href=3D"mailto:pmoore@redhat.com">pmoore@r=
edhat.com</a>&gt;<br>
---<br>
=C2=A0security/selinux/hooks.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
14 ++++++++++++++<br>
=C2=A0security/selinux/include/netif.h =C2=A0 | =C2=A0 =C2=A02 ++<br>
=C2=A0security/selinux/include/netnode.h | =C2=A0 =C2=A02 ++<br>
=C2=A0security/selinux/include/netport.h | =C2=A0 =C2=A02 ++<br>
=C2=A0security/selinux/netif.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
15 +--------------<br>
=C2=A0security/selinux/netnode.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 15 +-=
-------------<br>
=C2=A0security/selinux/netport.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 15 +-=
-------------<br>
=C2=A07 files changed, 23 insertions(+), 42 deletions(-)<br>
<br>
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c<br>
index 336f0a0..39bc8c9 100644<br>
--- a/security/selinux/hooks.c<br>
+++ b/security/selinux/hooks.c<br>
@@ -161,6 +161,17 @@ static int selinux_peerlbl_enabled(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (selinux_policycap_alwaysnetwork || netl=
bl_enabled() || selinux_xfrm_enabled());<br>
=C2=A0}<br>
<br>
+static int selinux_netcache_avc_callback(u32 event)<br>
+{<br>
+ =C2=A0 =C2=A0 =C2=A0 if (event =3D=3D AVC_CALLBACK_RESET) {<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel_netif_flush();<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel_netnode_flush();<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel_netport_flush();<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 synchronize_net();<br>
+ =C2=A0 =C2=A0 =C2=A0 }<br>
+ =C2=A0 =C2=A0 =C2=A0 return 0;<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * initialise the security for the init task<br>
=C2=A0 */<br>
@@ -5993,6 +6004,9 @@ static __init int selinux_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (register_security(&amp;selinux_ops))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panic(&quot;SELinux=
: Unable to register with kernel.\n&quot;);<br>
<br>
+ =C2=A0 =C2=A0 =C2=A0 if (avc_add_callback(selinux_netcache_avc_callback, =
AVC_CALLBACK_RESET))<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panic(&quot;SELinux: Una=
ble to register AVC netcache callback\n&quot;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (selinux_enforcing)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_DEBUG &=
quot;SELinux: =C2=A0Starting in enforcing mode\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
diff --git a/security/selinux/include/netif.h b/security/selinux/include/ne=
tif.h<br>
index 43d5072..57c6eae 100644<br>
--- a/security/selinux/include/netif.h<br>
+++ b/security/selinux/include/netif.h<br>
@@ -17,6 +17,8 @@<br>
=C2=A0#ifndef _SELINUX_NETIF_H_<br>
=C2=A0#define _SELINUX_NETIF_H_<br>
<br>
+void sel_netif_flush(void);<br>
+<br>
=C2=A0int sel_netif_sid(int ifindex, u32 *sid);<br>
<br>
=C2=A0#endif /* _SELINUX_NETIF_H_ */<br>
diff --git a/security/selinux/include/netnode.h b/security/selinux/include/=
netnode.h<br>
index df7a5ed..937668d 100644<br>
--- a/security/selinux/include/netnode.h<br>
+++ b/security/selinux/include/netnode.h<br>
@@ -27,6 +27,8 @@<br>
=C2=A0#ifndef _SELINUX_NETNODE_H<br>
=C2=A0#define _SELINUX_NETNODE_H<br>
<br>
+void sel_netnode_flush(void);<br>
+<br>
=C2=A0int sel_netnode_sid(void *addr, u16 family, u32 *sid);<br>
<br>
=C2=A0#endif<br>
diff --git a/security/selinux/include/netport.h b/security/selinux/include/=
netport.h<br>
index 4d965b8..d1ce896 100644<br>
--- a/security/selinux/include/netport.h<br>
+++ b/security/selinux/include/netport.h<br>
@@ -26,6 +26,8 @@<br>
=C2=A0#ifndef _SELINUX_NETPORT_H<br>
=C2=A0#define _SELINUX_NETPORT_H<br>
<br>
+void sel_netport_flush(void);<br>
+<br>
=C2=A0int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid);<br>
<br>
=C2=A0#endif<br>
diff --git a/security/selinux/netif.c b/security/selinux/netif.c<br>
index 694e9e4..3c3de4c 100644<br>
--- a/security/selinux/netif.c<br>
+++ b/security/selinux/netif.c<br>
@@ -240,7 +240,7 @@ static void sel_netif_kill(int ifindex)<br>
=C2=A0 * Remove all entries from the network interface table.<br>
=C2=A0 *<br>
=C2=A0 */<br>
-static void sel_netif_flush(void)<br>
+void sel_netif_flush(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int idx;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sel_netif *netif;<br>
@@ -252,15 +252,6 @@ static void sel_netif_flush(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_bh(&amp;sel_netif_lock);<br>
=C2=A0}<br>
<br>
-static int sel_netif_avc_callback(u32 event)<br>
-{<br>
- =C2=A0 =C2=A0 =C2=A0 if (event =3D=3D AVC_CALLBACK_RESET) {<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel_netif_flush();<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 synchronize_net();<br>
- =C2=A0 =C2=A0 =C2=A0 }<br>
- =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
=C2=A0static int sel_netif_netdev_notifier_handler(struct notifier_block *t=
his,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0unsigned long event, void *ptr)<br>
=C2=A0{<br>
@@ -291,10 +282,6 @@ static __init int sel_netif_init(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 register_netdevice_notifier(&amp;sel_netif_netd=
ev_notifier);<br>
<br>
- =C2=A0 =C2=A0 =C2=A0 err =3D avc_add_callback(sel_netif_avc_callback, AVC=
_CALLBACK_RESET);<br>
- =C2=A0 =C2=A0 =C2=A0 if (err)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panic(&quot;avc_add_call=
back() failed, error %d\n&quot;, err);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return err;<br>
=C2=A0}<br>
<br>
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c<br>
index 03a72c3..ddf3152 100644<br>
--- a/security/selinux/netnode.c<br>
+++ b/security/selinux/netnode.c<br>
@@ -283,7 +283,7 @@ int sel_netnode_sid(void *addr, u16 family, u32 *sid)<b=
r>
=C2=A0 * Remove all entries from the network address table.<br>
=C2=A0 *<br>
=C2=A0 */<br>
-static void sel_netnode_flush(void)<br>
+void sel_netnode_flush(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int idx;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sel_netnode *node, *node_tmp;<br>
@@ -300,15 +300,6 @@ static void sel_netnode_flush(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_bh(&amp;sel_netnode_lock);<br>
=C2=A0}<br>
<br>
-static int sel_netnode_avc_callback(u32 event)<br>
-{<br>
- =C2=A0 =C2=A0 =C2=A0 if (event =3D=3D AVC_CALLBACK_RESET) {<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel_netnode_flush();<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 synchronize_net();<br>
- =C2=A0 =C2=A0 =C2=A0 }<br>
- =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
=C2=A0static __init int sel_netnode_init(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int iter;<br>
@@ -322,10 +313,6 @@ static __init int sel_netnode_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel_netnode_hash[it=
er].size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
- =C2=A0 =C2=A0 =C2=A0 ret =3D avc_add_callback(sel_netnode_avc_callback, A=
VC_CALLBACK_RESET);<br>
- =C2=A0 =C2=A0 =C2=A0 if (ret !=3D 0)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panic(&quot;avc_add_call=
back() failed, error %d\n&quot;, ret);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
diff --git a/security/selinux/netport.c b/security/selinux/netport.c<br>
index d353797..73ac678 100644<br>
--- a/security/selinux/netport.c<br>
+++ b/security/selinux/netport.c<br>
@@ -217,7 +217,7 @@ int sel_netport_sid(u8 protocol, u16 pnum, u32 *sid)<br=
>
=C2=A0 * Remove all entries from the network address table.<br>
=C2=A0 *<br>
=C2=A0 */<br>
-static void sel_netport_flush(void)<br>
+void sel_netport_flush(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int idx;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sel_netport *port, *port_tmp;<br>
@@ -234,15 +234,6 @@ static void sel_netport_flush(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_bh(&amp;sel_netport_lock);<br>
=C2=A0}<br>
<br>
-static int sel_netport_avc_callback(u32 event)<br>
-{<br>
- =C2=A0 =C2=A0 =C2=A0 if (event =3D=3D AVC_CALLBACK_RESET) {<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel_netport_flush();<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 synchronize_net();<br>
- =C2=A0 =C2=A0 =C2=A0 }<br>
- =C2=A0 =C2=A0 =C2=A0 return 0;<br>
-}<br>
-<br>
=C2=A0static __init int sel_netport_init(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int iter;<br>
@@ -256,10 +247,6 @@ static __init int sel_netport_init(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sel_netport_hash[it=
er].size =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
- =C2=A0 =C2=A0 =C2=A0 ret =3D avc_add_callback(sel_netport_avc_callback, A=
VC_CALLBACK_RESET);<br>
- =C2=A0 =C2=A0 =C2=A0 if (ret !=3D 0)<br>
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 panic(&quot;avc_add_call=
back() failed, error %d\n&quot;, ret);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
<br>
</blockquote></div><br></div></div></div>

--001a11330d687cdfe004fd405491--
