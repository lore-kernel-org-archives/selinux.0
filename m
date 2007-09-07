Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87DYfsK016421
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 09:34:41 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l87DYaZl003163
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:34:39 GMT
Subject: Re: [PATCH] refpolicy: services_dbus changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022054.l72Ksk97000591@redsox.boston.devel.redhat.com>
References: <200708022054.l72Ksk97000591@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 09:33:16 -0400
Message-Id: <1189171996.3664.57.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:54 -0400, dwalsh@redhat.com wrote:
> dbus uses var_lib
> Multiple small fixes

Merged, one note:

> --- nsaserefpolicy/policy/modules/services/dbus.if      2007-07-03 07:06:27.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/dbus.if   2007-08-02 11:02:02.000000000 -0400
> @@ -271,6 +295,32 @@
>         allow $2 $1_dbusd_t:dbus send_msg;
>  ')
> 
> +
> +########################################
> +## <summary>
> +##     connectto a message on user/application specific DBUS.
> +## </summary>
> +## <param name="domain_prefix">
> +##     <summary>
> +##     The prefix of the domain (e.g., user
> +##     is the prefix for user_t).
> +##     </summary>
> +## </param>
> +## <param name="domain">
> +##     <summary>
> +##     Domain allowed access.
> +##     </summary>
> +## </param>
> +#
> +template(`dbus_connectto_user_bus',`
> +       gen_require(`
> +               type $1_dbusd_t;
> +       ')
> +
> +       allow $2 $1_dbusd_t:unix_stream_socket connectto;
> +')
> +
> +
>  ########################################
>  ## <summary>
>  ##     Read dbus configuration.

I'm holding off on this one, I think domains that this one plus the
above interface (dbus_send_user_bus()) really want
dbus_user_bus_client_template().

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
