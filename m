Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m59DTS75005891
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 09:29:28 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m59DTSOD001743
	for <selinux@tycho.nsa.gov>; Mon, 9 Jun 2008 13:29:28 GMT
Subject: Re: [refpolicy] Let xserver chat to hal
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Martin Orr <martin@martinorr.name>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <484A8EAB.7030106@martinorr.name>
References: <484A8EAB.7030106@martinorr.name>
Content-Type: text/plain
Date: Mon, 09 Jun 2008 09:17:03 -0400
Message-Id: <1213017423.28428.12.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2008-06-07 at 14:35 +0100, Martin Orr wrote:
> I get messages like:
> Mar  6 18:17:38 caligula dbus: avc:  denied  { send_msg } for msgtype=signal
> interface=org.freedesktop.Hal.Device member=PropertyModified
> dest=org.freedesktop.DBus spid=3245 tpid=3325
> scontext=system_u:system_r:hald_t:s0
> tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=dbus
> 
> Attached patch lets xserver talk to hal by dbus.

Merged.  I also added a dbus_system_bus_client_template() call.  I'm
guessing you're running with unconfined, so that would be covered up.

> plain text document attachment (117_xserver_hal_chat)
> Written by: Martin Orr
> 
> Let xserver talk to hal by dbus
> 
> Mar  6 18:17:38 caligula dbus: avc:  denied  { send_msg } for msgtype=signal interface=org.freedesktop.Hal.Device member=PropertyModified dest=org.freedesktop.DBus spid=3245 tpid=3325 scontext=system_u:system_r:hald_t:s0 tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=dbus
> Mar  6 19:21:41 caligula dbus: avc:  denied  { send_msg } for msgtype=method_call interface=org.freedesktop.Hal.Manager member=FindDeviceByCapability dest=org.freedesktop.Hal spid=3394 tpid=3314 scontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tcontext=system_u:system_r:hald_t:s0 tclass=dbus
> 
> Index: policy/modules/services/xserver.te
> ===================================================================
> --- policy/modules/services/xserver.te.orig
> +++ policy/modules/services/xserver.te
> @@ -467,6 +467,10 @@
>  ')
>  
>  optional_policy(`
> +	hal_dbus_chat(xdm_xserver_t)
> +')
> +
> +optional_policy(`
>  	resmgr_stream_connect(xdm_t)
>  ')
>  
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
